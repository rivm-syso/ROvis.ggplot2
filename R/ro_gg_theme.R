#' Add RIVM graph theme to ggplot object
#'
#' @description
#' `ro_gg_theme()` is a custom ggplot2 theme designed to apply the RIVM style to your visualizations.
#' It functions similarly to built-in ggplot2 themes like `theme_minimal()`. Wherever technically feasible, this
#' theme adheres to the RIVM guidelines for data visualization. We use versioning
#' to enable the user to inspect new theme changes and compare them side-by-side. **version 1.0** is the first
#' published version and `ro_gg_theme(version = 1.0)` corresponds to this version.
#' We also offer the version `0.0`, which was the
#' 'work in progress' version of the theme when the official guidelines were not published yet.
#'
#' @section Dependencies:
#'  * \link[ROvis.utils]{ro_color}
#'
#' @section RIVM style characteristics (version 1.0):
#' The following design elements from the RIVM style guide are incorporated into `ro_gg_theme()`:
#' * Background and Layout:
#'    * The background color for all plot elements is white.
#'    * The y-axis is hidden, while the x-axis is shown.
#'    * Major x-axis grid lines are hidden, major y-axis grid lines are shown, minor grid lines are hidden.
#'    * Titles (main, subtitle, caption, and facet) are aligned to the left of the plot area.
#'    * The x-axis title is aligned to the right of the plot area.
#'    * The legend is positioned at the bottom and aligned to the left of the plot area.
#'    * Margins around the plot have been increased to ensure all text elements have enough space.
#' * Colors:
#'    * Titles (main, subtitle, legend, facet): `ro_color("donkerblauw")`
#'    * Caption: "#505050"
#'    * Text and axis lines: `ro_color("grijs_7")` and default base_line_size.
#'    * Grid lines: `ro_color("grijs_3")`
#' * Text:
#'    * All text elements are proportionally sized relative to base_size:
#'    * Main title: `ro_color("donkerblauw")`, bold and 1.42 × base_size.
#'    * Subtitle: `ro_color("donkerblauw")` and 1.17 × base_size.
#'    * Other titles: `ro_color(donkerblauw)` and 1.08 x base_size.
#'    * Caption: "#505050" and default base_size.
#'    * Legend text: `ro_color("grijs_7")` and 1.08 x base_size.
#'    * Other text: `ro_color("grijs_7")` and default base_size.
#' * Grid and Axis Formatting:
#'    * All line elements are proportionally sized relative to base_line_size (base_size / 22):
#'    * Axis lines: `ro_color("grijs_7")` and default base_line_size.
#'    * Grid lines: `ro_color("grijs_3")` and 0.5 × base_line_size.
#' * Other:
#'    * Legend keys are designed to be twice as wide as they are high.
#'    * Space between facets are twice the default size.
#'
#' **What are the differences between `ro_gg_theme` and the official RIVM style?**
#' * Font family: The official RIVM style uses the Rijksoverheid Sans font. This theme
#' does not add the RO fonts to your device, but will use them if available.
#' If the RO font is not available, Verdana is used, then Arial, then the first font
#' found on your system, whichever is installed first (see
#' \link[ROvis.utils]{ro_check_if_font_available}).
#' * Y-axis title alignment: The official RIVM style rotates the y-axis title horizontally and aligns it to the top
#' of the plot area, which ggplot2 currently doesn't support. As a result, y-axis alignment is left to the user.
#' * X-axis ticks: The official RIVM style positions x-axis ticks between the bars of a barplot. Achieving this in
#' ggplot2 would require manually calculating the exact tick positions, which is too specific and inconsistent to
#' implement as part of a general theme.
#'
#' @section Theme customization approach:
#' There are two approaches for creating a custom ggplot2 theme:
#' (1) modifying an existing theme using 'existing theme + theme(...)' and
#' (2) fully replacing it with 'existing theme %+replace% theme()'.
#'
#' For ro_gg_theme(), we chose the first approach ('existing theme + theme(...)').This method offers greater
#' flexibility to users, making it easier to apply additional customization on top of the `ro_gg_theme()`
#' defaults.
#'
#' @seealso
#' * To view RIVM colors, use ROvis.utils function \link[ROvis.utils]{ro_show_colors}.
#' * To access the hex color code of a specific color, use the ROvis.utils function \link[ROvis.utils]{ro_color}.
#' * To view more usage examples, refer to the
#' [ROvis website](https://rivm-syso.github.io/ROvis).
#'
#' @param base_size Integer. Default = 13. If you select version 1.0, base_size is transformed to
#' base_size / 13 * 12 (default = 12).
#' @param base_family Character. Default = "RijksoverheidSansWebText". Accepts system fonts. If
#' RijksoverheidSansWebText is not installed, Verdana is used, then Arial, then the first font found on your
#' system, whichever is installed first. Tip: you can check your available systemfonts with
#' `systemfonts::system_fonts()$family`.
#' @param flip Logical. When set to FALSE (default), graphs have a thick x-axis and horizontal grid lines. For certain
#' types of graphs, such as those with horizontal bars, it may be necessary to 'flip' these elements. Setting `flip`
#' to TRUE changes the style to include a thick y-axis and vertical grid lines. Note: `flip` is only available from
#' version 1.0. If you set it to TRUE for version 0.0, it will be ignored.
#' @param version Character. The theme version. Default = 1.0.
#' @family ggplot2
#' @family ggplotly
#' @return ggplot theme object
#'
#' @examples
#' \dontrun{
#' #without theme
#' my_plot <- ggplot2::ggplot(data = datasets::mtcars, mapping = ggplot2::aes(x = wt, y = mpg)) +
#'   ggplot2::geom_point() +
#'   ggplot2::labs(title = "mtcars plot")
#'
#' #with theme version 0.0
#' my_plot +
#'   ROvis.utils::ro_gg_theme(version = "0.0")
#'
#' #with theme version 1.0 (default)
#' my_plot +
#'   ROvis.utils::ro_gg_theme()
#'
#' # different y-axis alignment choices
#' # top-aligned
#' my_plot +
#'   ROvis.utils::ro_gg_theme() +
#'   ggplot2::theme(axis.title.y = element_text(hjust = 1))
#' # annotated text as y-axis
#' my_plot +
#'   ROvis.utils::ro_gg_theme() +
#'   ggplot2::theme(axis.title.y = element_blank()) +
#'   ggplot2::annotate("text", x = 0, y = 35.5, label = "mpg", color = ro_color("lintblauw"))
#'
#'   }
#' @export
ro_gg_theme <- function(
  base_size = 12,
  base_family = "RijksoverheidSansWebText",
  flip = FALSE,
  version = "1.0"
) {
  check_string(version, allow_empty = FALSE)
  check_string(base_family)
  base_family <- ro_check_if_font_available(base_family = base_family)

  if (version == "0.0") {
    ro_gg_theme_0.0(base_size = base_size, base_family = base_family)
  } else if (version == "1.0") {
    ro_gg_theme_1.0(
      base_size = base_size,
      base_family = base_family,
      flip = flip
    )
  } else {
    cli_abort(
      "{.var version} {.value {version}} doesn't exist. Check your spelling."
    )
  }
}

### Versions

ro_gg_theme_0.0 <- function(base_size, base_family) {
  # convert base_size to new old default '13'
  base_size <- base_size / 12 * 13

  # define relative line sizes
  base_line_size <- base_size / 22
  base_rect_size <- base_size / 22

  # start with most basic ggplot theme and add certain components
  theme_gray(
    base_size = base_size,
    base_family = base_family,
    base_line_size = base_line_size,
    base_rect_size = base_rect_size
  ) +

    # tweaks to RIVM style
    theme(
      ### white background, no panel borders

      # panel
      panel.background = element_rect(
        fill = "white",
        colour = NA
      ),

      # facet labels
      strip.background = element_rect(
        fill = "white",
        colour = NA
      ),

      # legend key
      legend.key = element_rect(
        fill = "white",
        colour = NA
      ),

      ### grid and axes lines

      # style for all axis lines
      axis.line = element_line(
        linewidth = rel(1),
        ro_color("grijs_7")
      ),

      # y-axis: hide line and ticks
      axis.line.y = element_blank(),
      axis.ticks.y = element_blank(),

      # style for all grid lines
      panel.grid = element_line(
        linewidth = rel(0.5),
        ro_color("grijs_3")
      ),
      panel.grid.minor = element_blank(),

      # add grid lines for y-axis and remove for x-axis
      panel.grid.major.x = element_blank(),
      panel.grid.major.y = element_line(),

      ### text elements

      # all text
      text = element_text(
        family = base_family,
        size = base_size,
        color = ro_color("grijs_7")
      ),

      # all titles
      title = element_text(
        color = ro_color("lintblauw")
      ),

      # main title
      plot.title = element_text(
        size = rel(1.33),
        face = "bold"
      ),

      # subtitle
      # NOTE: plot.subtitle inherits from "text", not "title", in ggplot2's element tree, so the
      # color must be set explicitly here rather than relying on the `title` element above.
      plot.subtitle = element_text(
        color = ro_color("lintblauw"),
        size = rel(1.1)
      ),

      # facet title (align to left of plot area)
      strip.text = element_text(
        color = ro_color("lintblauw"),
        hjust = 0
      ),

      ### spacing and alignment

      # align plot title and caption to left of plot area
      plot.title.position = "plot",

      # adjust position legend
      legend.position = "bottom",

      # bigger spacing for facet panels
      panel.spacing = unit(2, "lines")
    )
}

ro_gg_theme_1.0 <- function(base_size, base_family, flip) {
  # check user input
  check_number_decimal(base_size)
  check_string(base_family, allow_empty = FALSE)
  check_bool(flip)

  # show info alert once per session
  inform(
    "Keep in mind that when using ro_gg_theme, you need to take additional coding steps to fully comply
    with the RIVM style. For more information, see the ROvis documentation website:
    https://rivm-syso.github.io/ROvis",
    .frequency = "once",
    .frequency_id = "warn_rivm_style"
  )

  # define relative line sizes
  base_line_size <- base_size / 22
  base_rect_size <- base_size / 22

  # start with most basic ggplot theme
  theme_rivm <- theme_gray(
    base_size = base_size,
    base_family = base_family,
    base_line_size = base_line_size,
    base_rect_size = base_rect_size
  ) +

    # tweaks to RIVM style
    theme(
      ### plot background and borders
      # increase margins (5 is default) to create more space around plot
      plot.margin = margin(t = 10, r = 10, b = 10, l = 10),

      # panel
      panel.background = element_rect(
        fill = "white",
        colour = NA
      ),

      # facet labels
      strip.background = element_rect(
        fill = "white",
        colour = NA
      ),

      # legend key
      legend.key = element_rect(
        fill = "white",
        colour = NA
      ),

      ### grid and axes lines

      # style for all axis lines
      axis.line = element_line(
        linewidth = rel(1),
        ro_color("grijs_7")
      ),

      # style for all grid lines
      panel.grid = element_line(
        linewidth = rel(0.5),
        ro_color("grijs_3")
      ),
      panel.grid.minor = element_blank(),

      ### text elements

      # settings for all text elements (element_text)
      # NOTE: if a text element (like axis.text) was explicitly overwritten by theme_gray(), it will retain these
      # theme settings regardless of the specifications in 'text' here. Therefore, we still have to overwrite some
      # properties, like color and size, of text elements below.
      text = element_text(
        family = base_family,
        size = base_size,
        color = ro_color("grijs_7")
      ),

      # all titles (inherits from text)
      title = element_text(
        size = rel(1.08), # 13pt with default base_size
        color = ro_color("lintblauw")
      ),

      # main title
      plot.title = element_text(
        size = rel(1.42), # 17pt with default base_size
        face = "bold",
        hjust = 0,
        # increase space between the title and plot area
        margin = margin(t = 0, r = 0, b = 20, l = 0)
      ),
      # align plot title and subtitle to left of plot area
      plot.title.position = "plot",

      # subtitle
      # NOTE: plot.subtitle inherits from "text", not "title", in ggplot2's element tree
      # (unlike plot.title/axis.title/legend.title), so the color must be set explicitly here
      # rather than relying on the `title` element above.
      plot.subtitle = element_text(
        color = ro_color("lintblauw"),
        size = rel(1.17), # 14pt with default base_size
        # increase space between subtitle and plot area, decrease space between title and subtitle
        margin = margin(t = -18, r = 0, b = 20, l = 0)
      ),

      # legend title
      legend.title.position = "top",

      # legend item labels (inherits from text)
      legend.text = element_text(
        size = rel(1.08), # 13pt with default base_size
        color = ro_color("grijs_7")
      ),

      # caption (inherits from title)
      plot.caption = element_text(
        color = "#505050",
        size = base_size,
        # align to left of plot area
        hjust = 0
      ),
      # align plot caption to left of plot area
      plot.caption.position = "plot",

      # axis titles and text
      axis.text = element_text(
        size = base_size,
        color = ro_color("grijs_7")
      ),
      # align x-axis title to right of plot area
      axis.title.x = element_text(hjust = 1),

      # facet labels (inherits from text)
      strip.text = element_text(
        size = base_size,
        color = ro_color("lintblauw"),
        # align to left of plot area
        hjust = 0
      ),

      ### legend and facets

      # legend position to bottom of graph and left-aligned with x-axis
      legend.position = "bottom",
      legend.justification = c(0, 0),
      legend.margin = margin(t = 5, r = 5, b = 5, l = 0),

      # reduce space between legend and plot area
      legend.box.spacing = unit(5, "pt"),

      # legend keys should be twice as wide as they are high
      legend.key.width = unit(2, "lines"),

      # bigger spacing for facet panels
      panel.spacing = unit(2, "lines")
    )

  # Conditional logic to modify theme based on `flip`
  if (!flip) {
    theme_axes <- theme(
      # y-axis: hide line and ticks
      axis.line.y = element_blank(),
      axis.ticks.y = element_blank(),

      # add grid lines for y-axis and remove for x-axis
      panel.grid.major.x = element_blank(),
      panel.grid.major.y = element_line()
    )
  } else {
    theme_axes <- theme(
      panel.grid.major.y = element_blank(),
      panel.grid.major.x = element_line(),
      axis.line.x = element_blank(),
      axis.ticks.x = element_blank()
    )
  }

  # Add theme_axes
  theme_rivm + theme_axes
}
