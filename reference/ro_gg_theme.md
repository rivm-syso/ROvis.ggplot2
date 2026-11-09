# Add RIVM graph theme to ggplot object

`ro_gg_theme()` is a custom ggplot2 theme designed to apply the RIVM
style to your visualizations. It functions similarly to built-in ggplot2
themes like
[`theme_minimal()`](https://ggplot2.tidyverse.org/reference/ggtheme.html).
Wherever technically feasible, this theme adheres to the RIVM guidelines
for data visualization. We use versioning to enable the user to inspect
new theme changes and compare them side-by-side. **version 1.0** is the
first published version and `ro_gg_theme(version = 1.0)` corresponds to
this version. We also offer the version `0.0`, which was the 'work in
progress' version of the theme when the official guidelines were not
published yet.

## Usage

``` r
ro_gg_theme(
  base_size = 12,
  base_family = "RijksoverheidSansWebText",
  flip = FALSE,
  version = "1.0"
)
```

## Arguments

- base_size:

  Integer. Default = 13. If you select version 1.0, base_size is
  transformed to base_size / 13 \* 12 (default = 12).

- base_family:

  Character. Default = "RijksoverheidSansWebText". Accepts system fonts.
  If RijksoverheidSansWebText is not installed, Verdana is used, then
  Arial, then the first font found on your system, whichever is
  installed first. Tip: you can check your available systemfonts with
  `systemfonts::system_fonts()$family`.

- flip:

  Logical. When set to FALSE (default), graphs have a thick x-axis and
  horizontal grid lines. For certain types of graphs, such as those with
  horizontal bars, it may be necessary to 'flip' these elements. Setting
  `flip` to TRUE changes the style to include a thick y-axis and
  vertical grid lines. Note: `flip` is only available from version 1.0.
  If you set it to TRUE for version 0.0, it will be ignored.

- version:

  Character. The theme version. Default = 1.0.

## Value

ggplot theme object

## Dependencies

- [ro_color](https://rivm-syso.github.io/ROvis.utils/reference/ro_color.html)

## RIVM style characteristics (version 1.0)

The following design elements from the RIVM style guide are incorporated
into `ro_gg_theme()`:

- Background and Layout:

  - The background color for all plot elements is white.

  - The y-axis is hidden, while the x-axis is shown.

  - Major x-axis grid lines are hidden, major y-axis grid lines are
    shown, minor grid lines are hidden.

  - Titles (main, subtitle, caption, and facet) are aligned to the left
    of the plot area.

  - The x-axis title is aligned to the right of the plot area.

  - The legend is positioned at the bottom and aligned to the left of
    the plot area.

  - Margins around the plot have been increased to ensure all text
    elements have enough space.

- Colors:

  - Titles (main, subtitle, legend, facet): `ro_color("donkerblauw")`

  - Caption: "#505050"

  - Text and axis lines: `ro_color("grijs_7")` and default
    base_line_size.

  - Grid lines: `ro_color("grijs_3")`

- Text:

  - All text elements are proportionally sized relative to base_size:

  - Main title: `ro_color("donkerblauw")`, bold and 1.42 × base_size.

  - Subtitle: `ro_color("donkerblauw")` and 1.17 × base_size.

  - Other titles: `ro_color(donkerblauw)` and 1.08 x base_size.

  - Caption: "#505050" and default base_size.

  - Legend text: `ro_color("grijs_7")` and 1.08 x base_size.

  - Other text: `ro_color("grijs_7")` and default base_size.

- Grid and Axis Formatting:

  - All line elements are proportionally sized relative to
    base_line_size (base_size / 22):

  - Axis lines: `ro_color("grijs_7")` and default base_line_size.

  - Grid lines: `ro_color("grijs_3")` and 0.5 × base_line_size.

- Other:

  - Legend keys are designed to be twice as wide as they are high.

  - Space between facets are twice the default size.

**What are the differences between `ro_gg_theme` and the official RIVM
style?**

- Font family: The official RIVM style uses the Rijksoverheid Sans font.
  This theme does not add the RO fonts to your device, but will use them
  if available. If the RO font is not available, Verdana is used, then
  Arial, then the first font found on your system, whichever is
  installed first (see
  [ro_check_if_font_available](https://rivm-syso.github.io/ROvis.utils/reference/ro_check_if_font_available.html)).

- Y-axis title alignment: The official RIVM style rotates the y-axis
  title horizontally and aligns it to the top of the plot area, which
  ggplot2 currently doesn't support. As a result, y-axis alignment is
  left to the user.

- X-axis ticks: The official RIVM style positions x-axis ticks between
  the bars of a barplot. Achieving this in ggplot2 would require
  manually calculating the exact tick positions, which is too specific
  and inconsistent to implement as part of a general theme.

## Theme customization approach

There are two approaches for creating a custom ggplot2 theme: (1)
modifying an existing theme using 'existing theme + theme(...)' and (2)
fully replacing it with 'existing theme %+replace% theme()'.

For ro_gg_theme(), we chose the first approach ('existing theme +
theme(...)').This method offers greater flexibility to users, making it
easier to apply additional customization on top of the `ro_gg_theme()`
defaults.

## See also

- To view RIVM colors, use ROvis.utils function
  [ro_show_colors](https://rivm-syso.github.io/ROvis.utils/reference/ro_show_colors.html).

- To access the hex color code of a specific color, use the ROvis.utils
  function
  [ro_color](https://rivm-syso.github.io/ROvis.utils/reference/ro_color.html).

- To view more usage examples, refer to the [ROvis
  website](https://rivm-syso.github.io/ROvis).

Other ggplot2:
[`ro_gg_axis()`](https://rivm-syso.github.io/ROvis.ggplot2/reference/ro_gg_axis.md),
[`ro_gg_group_ticks()`](https://rivm-syso.github.io/ROvis.ggplot2/reference/ro_gg_group_ticks.md),
[`ro_gg_plot()`](https://rivm-syso.github.io/ROvis.ggplot2/reference/ro_gg_plot.md),
[`ro_gg_remove_axis_gap()`](https://rivm-syso.github.io/ROvis.ggplot2/reference/ro_gg_remove_axis_gap.md),
[`ro_gg_save()`](https://rivm-syso.github.io/ROvis.ggplot2/reference/ro_gg_save.md),
[`ro_gg_y_title()`](https://rivm-syso.github.io/ROvis.ggplot2/reference/ro_gg_y_title.md)

## Examples

``` r
if (FALSE) { # \dontrun{
#without theme
my_plot <- ggplot2::ggplot(data = datasets::mtcars, mapping = ggplot2::aes(x = wt, y = mpg)) +
  ggplot2::geom_point() +
  ggplot2::labs(title = "mtcars plot")

#with theme version 0.0
my_plot +
  ROvis.utils::ro_gg_theme(version = "0.0")

#with theme version 1.0 (default)
my_plot +
  ROvis.utils::ro_gg_theme()

# different y-axis alignment choices
# top-aligned
my_plot +
  ROvis.utils::ro_gg_theme() +
  ggplot2::theme(axis.title.y = element_text(hjust = 1))
# annotated text as y-axis
my_plot +
  ROvis.utils::ro_gg_theme() +
  ggplot2::theme(axis.title.y = element_blank()) +
  ggplot2::annotate("text", x = 0, y = 35.5, label = "mpg", color = ro_color("lintblauw"))

  } # }
```
