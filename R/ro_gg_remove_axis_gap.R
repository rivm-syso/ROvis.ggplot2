#' Remove gap between data and axes
#'
#' @description
#' Simplifies usage of the expansion function of ggplot2. Expansion vectors are used to add
#' some space between the data and the axes. For certain types of graphs you need to adjust the default
#' ggplot expansion values to comply with the RIVM style. For example, if you create a bar plot with
#' ro_gg_theme(), there is a gap between the bars and the x-axis. You can remove this gap with the
#' `ro_gg_remove_axis_gap()` function. This function returns the correct expansion vector that you need to use in the
#' scale functions (`scale_y_...` or `scale_x_...`) of your ggplot object. You also need to adjust the
#' expansion if you create a line graph where the y-axis starts at 0.
#'
#' @section Adjust x or y scale?:
#' If you create a vertical (default) bar graph, you want to remove the gap between the bars
#' and the x-axis, thus you need to use `ro_gg_remove_axis_gap()` in ggplot's `scale_y_...`. For horizontal
#' bar graphs, it is the other way around. You  want to remove the gap between the bars
#' and the y-axis, thus you need to use `ro_gg_remove_axis_gap()` in ggplot's `scale_x_...` function. For
#' line graphs where the y-axis starts at 0 you need to use `ro_gg_remove_axis_gap()` in ggplot's
#' `scale_y_...` function.
#' @family ggplot2
#' @returns expansion vector
#' @export
#'
#' @examples

#' #bar graph with gap removal
#' my_plot <- mtcars |>
#' dplyr::mutate(gear = as.factor(gear))|>
#' dplyr::group_by(gear) |>
#' dplyr::summarise(hp = mean(hp)) |>
#' ggplot2::ggplot(ggplot2::aes(x = gear, y = hp)) +
#' ggplot2::geom_bar(stat = "identity") +
#' ro_gg_theme() +
#' ggplot2::scale_y_continuous(
#'   expand = ro_gg_remove_axis_gap()
#' )
#'
#' #horizontal bar graph with gap removal
#' my_plot2 <- mtcars |>
#' dplyr::mutate(gear = as.factor(gear)) |>
#' dplyr::group_by(gear) |>
#' dplyr::summarise(hp = mean(hp)) |>
#' ggplot2::ggplot(ggplot2::aes(x = hp, y = gear)) +
#' ggplot2::geom_bar(stat = "identity") +
#' ro_gg_theme(flip = TRUE) +
#' ggplot2::scale_x_continuous(
#'   expand = ro_gg_remove_axis_gap()
#' )
#'
#' # line graph that starts at 0 with gap removal
#' my_plot3 <- mtcars |>
#' dplyr::group_by(gear) |>
#' dplyr::summarise(hp = mean(hp)) |>
#' ggplot2::ggplot(ggplot2::aes(x = gear, y = hp)) +
#' ggplot2::geom_line() +
#' ggplot2::expand_limits(y = 0) +
#' ro_gg_theme() +
#' ggplot2::scale_y_continuous(
#'   expand = ro_gg_remove_axis_gap()
#' )
#'
ro_gg_remove_axis_gap <- function() {
  return(expansion(mult = c(0, 0.05)))
}
