#' Apply the RO ggplot2 theme and auto-fix common RO style requirements
#'
#' @description
#' `r lifecycle::badge('experimental')`
#' `ro_gg_plot()` is a concept/draft function that explores applying the RO visual style in a single step, instead
#' of requiring the separate calls to [ro_gg_theme()], [ro_gg_remove_axis_gap()], [ro_gg_axis()],
#' a manual thousands-separator, [ro_gg_group_ticks()], and [ro_gg_y_title()] described in
#' the `vignette("ggplot2-in-ro-style")` vignette.
#'
#' Unlike [ro_gg_theme()], which returns a `theme()` object that only carries cosmetic
#' settings, `ro_gg_plot()` takes the *whole plot* as input and returns a modified plot. This
#' is required because several RO style rules (axis limits/expansion, number formatting, y-axis
#' title position) depend on the data, the scales, and the geoms already present on the plot,
#' none of which a plain `theme()` object can see. Call `ro_gg_plot()` last, after all layers,
#' scales, and labels have been added.
#'
#' @section What this does automatically:
#' * Applies the [ro_gg_theme()] cosmetic theme.
#' * Removes legend titles (RO style never shows one), for `fill`, `colour`/`color`, `shape`,
#' `linetype`, `alpha`, and `size`.
#' * For bar/column charts (any layer using `geom_col()`/`geom_bar()`), sets the group width to
#' 80% of each category slot, removes any padding between bars within the same group (switching
#' `position_dodge2()` to `position_dodge()` if needed), and removes bar outlines. Tick marks are
#' then moved from under each category to the boundary between groups via [ro_gg_group_ticks()].
#' Works for both the default and flipped (`flip = TRUE`) orientation.
#' * For bar/column and line charts (any layer using `geom_col()`/`geom_bar()`/`geom_line()`),
#' and only if the user has not already added a scale for the continuous axis, applies
#' [ro_gg_remove_axis_gap()] expansion, [ro_gg_axis()] as the axis limits (so the continuous axis
#' starts at 0), and a thousands separator on the labels. Other chart types (e.g. scatter
#' plots) only get the thousands separator.
#' * Relocates the y-axis title to the RO position via [ro_gg_y_title()], when a y-axis
#' title is present. Works for both the default and flipped (`flip = TRUE`) orientation.
#'
#' @section Known limitations:
#' * The bar group width (80%), zero padding within a group, and tick-mark styling
#' (color/width/length) are fixed and not user-configurable; if you need different values, apply
#' [ro_gg_group_ticks()] and the geom parameters yourself instead of `ro_gg_plot()`.
#' * Detecting whether a scale was already set by the user relies on `plot$scales$scales`,
#' which is a bit buggy.
#' * Facetted plots are not specifically handled; [ro_gg_y_title()] and [ro_gg_group_ticks()]
#' only look at the first panel.
#'
#' @param plot A ggplot object, with all layers, scales, and labels already added.
#' @param flip Logical. Passed on to [ro_gg_theme()]. Default = FALSE.
#' @param base_size Integer. Passed on to [ro_gg_theme()]. Default = 12.
#' @param base_family Character. Passed on to [ro_gg_theme()]. Default = "RijksoverheidSansWebText".
#' @param lang Character. `"nl"` (default) uses a dot as thousands separator (e.g. "1.000");
#' `"en"` uses a comma (e.g. "1,000").
#' @param auto_set_y_title Logical. If `TRUE` (default), relocates the y-axis title via
#' [ro_gg_y_title()], as described above. Set to `FALSE` to leave the y-axis title alone
#' (`ro_gg_plot()` then only applies the cosmetic theme, legend, and axis changes) so you can
#' position it yourself, e.g. with your own [ggplot2::annotation_custom()] call, or via
#' `theme(axis.title.y = ...)` if the default placement isn't needed at all.
#' @family ggplot2
#' @return A modified ggplot object.
#'
#' @seealso
#' * [ro_gg_theme()], [ro_gg_remove_axis_gap()], [ro_gg_axis()], [ro_gg_group_ticks()], and
#' [ro_gg_y_title()], which `ro_gg_plot()` combines.
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#'
#' dat <- data.frame(
#'   agegroup = c("0-19", "20-39", "40-59"),
#'   n = c(1200, 4800, 6100)
#' )
#'
#' p <- ggplot(dat, aes(x = agegroup, y = n)) +
#'   geom_col() +
#'   labs(title = "Cases by age group", y = "Number of cases", x = "Age group")
#'
#' # build the plot fully with `+` first, then call ro_gg_plot() on the finished object
#' ro_gg_plot(p)
#' }
#' @export
ro_gg_plot <- function(
    plot,
    flip = FALSE,
    base_size = 12,
    base_family = "RijksoverheidSansWebText",
    lang = c("nl", "en"),
    auto_set_y_title = TRUE
) {
  if (!is_ggplot(plot)) {
    cli_abort("{.arg plot} must be a ggplot object.")
  }
  check_bool(flip)
  check_bool(auto_set_y_title)
  lang <- arg_match(lang)

  # cosmetic theme: background, gridlines, text, fonts, legend position, ...
  plot <- plot +
    ro_gg_theme(base_size = base_size, base_family = base_family, flip = flip)

  # RO style never shows a legend title, only the keys
  legend_aes <- c(
    "fill",
    "colour",
    "color",
    "shape",
    "linetype",
    "alpha",
    "size"
  )
  # assigning list(NULL), not NULL, keeps the key present so ggplot2 does not fall back to a
  # default label derived from the aes mapping (the same effect as labs(fill = NULL))
  for (legend_lab in intersect(legend_aes, names(plot$labels))) {
    plot$labels[legend_lab] <- list(NULL)
  }

  # RO style for bar/column charts: bars within a group sit flush (pointPadding = 0), each
  # group occupies 80% of its category slot (groupPadding = 0.1), bars have no outline
  # (borderWidth = 0), and tick marks sit between groups instead of centered under each one
  has_bar <- any(vapply(
    plot$layers,
    function(l) inherits(l$geom, "GeomBar"),
    logical(1)
  ))
  # ro_gg_group_ticks() and ro_gg_y_title() both draw outside the panel and need
  # coord_cartesian(clip = "off"); track whether either ran so it's only added once at the end
  needs_clip_off <- FALSE
  if (has_bar) {
    plot$layers <- lapply(plot$layers, function(l) {
      if (!inherits(l$geom, "GeomBar")) {
        return(l)
      }
      l$geom_params$width <- 0.8
      # position_dodge2() defaults to 10% padding between bars in a group; position_dodge()
      # has none, which is what pointPadding = 0 requires
      if (inherits(l$position, "PositionDodge2")) {
        l$position <- position_dodge(preserve = l$position$preserve)
      }
      l$aes_params$linewidth <- 0
      l
    })
    plot <- ro_gg_group_ticks(plot, flip = flip)
    needs_clip_off <- TRUE
  }

  # skip all of the below if the user already added a scale for the continuous axis themselves
  continuous_aes <- if (flip) "x" else "y"
  has_scale <- any(
    vapply(
      plot$scales$scales,
      function(sc) continuous_aes %in% sc$aesthetics,
      logical(1)
    )
  )

  if (!has_scale) {
    number_format <- if (lang == "nl") {
      label_comma(big.mark = ".", decimal.mark = ",")
    } else {
      label_comma(big.mark = ",", decimal.mark = ".")
    }
    scale_fun <- if (continuous_aes == "y") {
      scale_y_continuous
    } else {
      scale_x_continuous
    }

    # bar/column and line charts should have their continuous axis start at 0 and touch the
    # discrete/category axis; otherwise the axis line floats at an arbitrary, meaningless
    # height instead of a real zero baseline (see ro_gg_remove_axis_gap()'s "line graph" example). Other chart
    # types (e.g. scatter plots with two continuous axes) keep ggplot2's default
    # expansion/limits and only get the thousands separator.
    is_bar_or_line <- any(vapply(
      plot$layers,
      function(l) inherits(l$geom, c("GeomBar", "GeomLine")),
      logical(1)
    ))

    plot <- plot +
      if (is_bar_or_line) {
        scale_fun(
          expand = ro_gg_remove_axis_gap(),
          limits = ro_gg_axis,
          labels = number_format
        )
      } else {
        scale_fun(labels = number_format)
      }
  }

  # relocate the y-axis title to the RO position
  y_title <- get_labs(plot)$y
  if (auto_set_y_title && !is.null(y_title) && nzchar(y_title)) {
    plot <- ro_gg_y_title(plot)
    needs_clip_off <- TRUE
  }

  if (needs_clip_off) {
    plot <- plot + coord_cartesian(clip = "off")
  }

  plot
}
