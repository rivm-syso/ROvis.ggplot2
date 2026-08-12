#' Expand Axis Limits for Plots
#'
#' @description
#' Calculates axis limits for a plot that are aligned with pretty breaks,
#' ensuring that all data points are within the range and the maximum value
#' is comfortably included, in accordance with RIVM styling.
#' Optionally, the lower limit can be set to zero.
#'
#' @param x Numeric vector of values to be plotted.
#' @param start_at_zero Logical; if TRUE (default), the lower limit of the axis
#'   will start at 0.
#' @family ggplot2
#' @return A numeric vector of length 2, giving the minimum and maximum
#'   axis limits.
#'
#' @export
#'
#' @examples
#' # Example with ggplot2
#' \dontrun{
#' library(ggplot2)
#' data <- data.frame(x = 1:11, y = c(11:17, 5:2))
#'
#' ggplot(data, aes(x, y)) +
#'   geom_point() +
#'   scale_x_continuous(
#'     breaks = pretty,
#'     limits = ro_gg_axis
#'   ) +
#'   scale_y_continuous(
#'     breaks = pretty,
#'     limits = ro_gg_axis
#'   )
#' }

ro_gg_axis <- function(x, start_at_zero = TRUE) {
  if (!is.numeric(x)) {
    stop("x can only contain numerical values.")
  }

  check_bool(start_at_zero)

  # Add 0 at the beginning if start_at_zero is TRUE and 0 is not already present
  if (start_at_zero && !0 %in% x) {
    x <- c(0, x)
  }

  # Generate pretty breaks
  breaks <- pretty(x)

  # If the number of breaks is even, extend the sequence by one interval
  if (length(breaks) %% 2 == 0) {
    interval <- diff(breaks)[1] # take the first difference; works even for irregular intervals
    breaks <- c(breaks, max(breaks) + interval)
  }

  return(range(breaks))
}
