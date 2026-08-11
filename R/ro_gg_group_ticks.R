#' Add RIVM-style tick marks between bar/column groups
#'
#' @description
#' `r lifecycle::badge('experimental')`
#' Replaces the default per-category axis ticks of a bar/column chart with tick marks placed
#' *between* each group of bars, following RIVM design guidelines. ggplot2 centers axis ticks under/next to each
#' category by default; `ro_gg_group_ticks()` hides those and draws short line segments at the
#' boundary between every pair of adjacent categories instead, plus the two outer edges.
#'
#' Since the tick marks are drawn just outside the panel area, always use this function in
#' combination with `coord_cartesian(clip = "off")`.
#'
#' @param plot A ggplot object with a discrete category axis (e.g. from `geom_col()`/`geom_bar()`).
#' @param flip Logical. Set to `TRUE` if the category axis is `y` rather than `x` (the same
#' orientation you'd pass to `theme_ggrivm(flip = TRUE)`). Default = FALSE.
#' @returns A ggplot object
#' @family ggplot2
#' @export
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#'
#' dat <- data.frame(agegroup = c("0-19", "20-39", "40-59"), n = c(1200, 4800, 6100))
#' p <- ggplot(dat, aes(agegroup, n)) +
#'   geom_col() +
#'   theme_ggrivm()
#'
#' ro_gg_group_ticks(p) +
#'   coord_cartesian(clip = "off")
#' }
ro_gg_group_ticks <- function(plot, flip = FALSE) {
  if (!is_ggplot(plot)) {
    cli_abort("{.arg plot} must be a ggplot object.")
  }
  check_bool(flip)

  cat_aes <- if (flip) "y" else "x"

  # by default, a discrete scale expands the panel by 0.6 units beyond the outermost category
  # *center*, i.e. further than the boundary (0.5 units out) where the outer group ticks sit.
  # Everything that spans the full panel width/height (the axis line, grid lines) would then
  # stick out past those outer ticks. Shrink the expansion to exactly half a category width so
  # the panel edges land flush with the outer ticks instead.
  scale_idx <- which(vapply(
    plot$scales$scales,
    function(sc) cat_aes %in% sc$aesthetics,
    logical(1)
  ))
  if (length(scale_idx) > 0) {
    plot$scales <- plot$scales$clone()
    plot$scales$scales[[scale_idx[1]]]$expand <- expansion(add = 0.5)
  } else {
    scale_fun <- if (cat_aes == "x") scale_x_discrete else scale_y_discrete
    plot <- plot + scale_fun(expand = expansion(add = 0.5))
  }

  fig_build <- ggplot_build(plot)
  cat_scale <- fig_build@layout$panel_params[[1]][[cat_aes]]
  positions <- attr(cat_scale$breaks, "pos")
  if (length(positions) == 0) {
    cli_abort(
      "{.arg plot} does not have a discrete {.val {cat_aes}} axis to add group ticks to."
    )
  }

  # one boundary between every pair of adjacent categories, plus the two outer edges
  boundaries <- seq(min(positions) - 0.5, max(positions) + 0.5, by = 1)

  # annotation_custom() grobs are drawn in a viewport with no xscale/yscale of their own, so
  # "native" units inside them are meaningless; rescale the boundaries to npc fractions of the
  # full (expanded) panel range ourselves instead
  panel_range <- cat_scale$continuous_range
  boundaries_npc <- (boundaries - panel_range[1]) / diff(panel_range)

  tick_gpar <- gpar(col = ro_color("grijs_7"), lwd = 1.5, lineend = "butt")

  # ticks sit just outside the panel: at the bottom (npc y = 0) for a vertical category axis,
  # at the left (npc x = 0) for a horizontal one, extending 4pt further out
  ticks_grob <- if (!flip) {
    segmentsGrob(
      x0 = unit(boundaries_npc, "npc"),
      x1 = unit(boundaries_npc, "npc"),
      y0 = unit(0, "npc"),
      y1 = unit(0, "npc") - unit(4, "points"),
      gp = tick_gpar
    )
  } else {
    segmentsGrob(
      x0 = unit(0, "npc"),
      x1 = unit(0, "npc") - unit(4, "points"),
      y0 = unit(boundaries_npc, "npc"),
      y1 = unit(boundaries_npc, "npc"),
      gp = tick_gpar
    )
  }

  hide_ticks <- if (!flip) {
    theme(axis.ticks.x = element_blank())
  } else {
    theme(axis.ticks.y = element_blank())
  }

  plot + hide_ticks + annotation_custom(ticks_grob)
}
