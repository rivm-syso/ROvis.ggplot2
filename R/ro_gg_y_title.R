#' Relocate y-axis title of ggplot object to RIVM style position
#'
#' `r lifecycle::badge('experimental')`
#' Relocates the y-axis title of an existing ggplot object (with `theme_ggrivm(version = "1.0")` applied) to the right
#' location, following RIVM design guidelines. The function calculates the y-coordinate of the highest grid line and
#' positions the y-axis title slightly above this value for optimal appearance. Note: Since the title may (partly) fall
#' outside the plot area, always use this function in combination with ggplot's `coord_cartesian(clip = "off")`.
#' Please note: This is an experimental function. Its features and behavior may change in future updates.
#'
#' @param plot A ggplot object with a defined y-axis title and the custom theme `ro_gg_theme(version = "1.0)` applied.
#'
#' @returns A ggplot object
#' @family ggplot2
#' @export
#'
#' @examples
#' \dontrun{
#' my_plot <- ggplot2::ggplot(data = datasets::mtcars, mapping = ggplot2::aes(x = wt, y = mpg)) +
#'   ggplot2::geom_point() +
#'   ggplot2::labs(title = "mtcars plot") +
#'   ROvis.utils::ro_gg_theme(version = "1.0")
#' my_plot
#'
#' #relocate y-axis title to RIVM style position
#' ROvis.utils::ro_gg_y_title(my_plot) +
#'   ggplot2::coord_cartesian(clip = "off")
#'   }
ro_gg_y_title <- function(plot) {
  # check user input
  if (!is_ggplot(plot)) {
    cli_abort("{.var plot} is not a ggplot object. Check your input.")
  }

  # extract the y-axis title text
  label <- get_labs(plot)$y
  if (is.null(label) || label == "") {
    cli_abort(
      "y-axis title of {.var plot} is NULL or empty. Can't relocate non-existing title."
    )
  }

  # extract the max value from the breaks of fig
  fig_build <- ggplot_build(plot)
  y_scale <- fig_build@layout$panel_params[[1]]$y
  top_gridline_y <- if (is.numeric(y_scale$breaks)) {
    max(y_scale$breaks, na.rm = TRUE)
  } else {
    # for a discrete y-axis (e.g. flip = TRUE), the top break is the *center* of the top
    # category's bar, not "above the data" the way the highest numeric gridline is for a
    # continuous axis; anchor to the top edge of the expanded panel range instead, so the
    # title doesn't overlap the top bar
    max(y_scale$continuous_range, na.rm = TRUE)
  }

  # extract base_size and font family from plot
  font_family <- plot@theme$text$family
  base_size <- plot@theme$text$size

  # calculate fontsize for y-axis title; in ro_gg_theme we use rel(1.08)
  font_size <- 1.08 * base_size

  plot +
    # remove y-axis
    theme(axis.title.y = element_blank()) +
    annotation_custom(
      textGrob(
        label = label,
        x = unit(0, "npc"),
        y = unit(0, "npc"),
        hjust = 0,
        # offset of half a text height to create some space
        vjust = -0.5,
        gp = gpar(
          fontsize = font_size,
          col = ro_color("lintblauw"),
          fontfamily = font_family
        )
      ),
      ymin = top_gridline_y
    )
}
