# Save ggplot objects with an offline configuration

This function can help you save your ggplot objects for offline reports.
It changes the font size of your title and text and sets a default set
of parameters for offline publication. Originally made for Staat van
Infectieziektes.

## Usage

``` r
ro_gg_save(
  filename,
  plot,
  fontsize = 10.75,
  dpi = 600,
  width = 12,
  height = 8,
  units = "cm",
  ...
)
```

## Arguments

- filename:

  Filename to save object as. Should include preferred extension (e.g
  "name.png")

- plot:

  ggplot object to save.

- fontsize:

  Fontsize for title and text. Default = 10.75.

- dpi:

  Plot resolution. Default = 600.

- width, height:

  Plot size in units from the units argument. Defaults are 12 and 8

- units:

  Possibilities: "cm", "mm", "px" or "in".

- ...:

  Other arguments passed on to the ggsave function.

## See also

[`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html)

Other ggplot2:
[`ro_gg_axis()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_axis.md),
[`ro_gg_group_ticks()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_group_ticks.md),
[`ro_gg_plot()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_plot.md),
[`ro_gg_remove_axis_gap()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_remove_axis_gap.md),
[`ro_gg_theme()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_theme.md),
[`ro_gg_y_title()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_y_title.md)

## Examples

``` r
if (FALSE) { # \dontrun{
my_plot <- ggplot2::ggplot(data = datasets::mtcars, mapping = ggplot2::aes(x = wt, y = mpg)) +
  ggplot2::geom_point() +
  ggplot2::labs(title = "mtcars plot") +
  ro_gg_theme()

  ro_gg_save(my_plot, filename = "my_plot.png")
} # }
```
