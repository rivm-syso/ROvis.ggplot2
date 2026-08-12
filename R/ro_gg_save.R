#' Save ggplot objects with an offline configuration
#'
#' @description
#' This function can help you save your ggplot objects for offline reports.
#' It changes the font size of your title and text and sets a default set of parameters for offline publication.
#' Originally made for Staat van Infectieziektes.
#'
#' @param filename Filename to save object as. Should include preferred extension (e.g "name.png")
#' @param plot ggplot object to save.
#' @param fontsize Fontsize for title and text. Default = 10.75.
#' @param dpi Plot resolution. Default = 600.
#' @param width,height Plot size in units from the units argument. Defaults are 12 and 8
#' @param units Possibilities: "cm", "mm", "px" or "in".
#' @param ... Other arguments passed on to the ggsave  function.
#' @family ggplot2
#'
#' @seealso
#'  [ggplot2::ggsave()]
#' @export
#'
#' @examples
#' \dontrun{
#' my_plot <- ggplot2::ggplot(data = datasets::mtcars, mapping = ggplot2::aes(x = wt, y = mpg)) +
#'   ggplot2::geom_point() +
#'   ggplot2::labs(title = "mtcars plot") +
#'   ro_gg_theme()
#'
#'   ro_gg_save(my_plot, filename = "my_plot.png")
#' }
#'

ro_gg_save <- function(
  filename,
  plot,
  fontsize = 10.75,
  dpi = 600,
  width = 12,
  height = 8,
  units = "cm",
  ...
) {
  if (!inherits(plot, "ggplot")) {
    abort("'object' must be a ggplot object.")
  }

  plot <- plot +
    theme(
      axis.title = element_text(size = fontsize),
      axis.text = element_text(size = fontsize)
    )

  ggsave(
    plot = plot,
    filename = filename,
    dpi = dpi,
    width = width,
    height = height,
    units = units,
    ...
  )
}
