# Relocate y-axis title of ggplot object to RIVM style position

**\[experimental\]** Relocates the y-axis title of an existing ggplot
object (with `theme_ggrivm(version = "1.0")` applied) to the right
location, following RIVM design guidelines. The function calculates the
y-coordinate of the highest grid line and positions the y-axis title
slightly above this value for optimal appearance. Note: Since the title
may (partly) fall outside the plot area, always use this function in
combination with ggplot's `coord_cartesian(clip = "off")`. Please note:
This is an experimental function. Its features and behavior may change
in future updates.

## Usage

``` r
ro_gg_y_title(plot)
```

## Arguments

- plot:

  A ggplot object with a defined y-axis title and the custom theme
  `ro_gg_theme(version = "1.0)` applied.

## Value

A ggplot object

## See also

Other ggplot2:
[`ro_gg_axis()`](https://rivm-syso.github.io/ROvis.ggplot2/reference/ro_gg_axis.md),
[`ro_gg_group_ticks()`](https://rivm-syso.github.io/ROvis.ggplot2/reference/ro_gg_group_ticks.md),
[`ro_gg_plot()`](https://rivm-syso.github.io/ROvis.ggplot2/reference/ro_gg_plot.md),
[`ro_gg_remove_axis_gap()`](https://rivm-syso.github.io/ROvis.ggplot2/reference/ro_gg_remove_axis_gap.md),
[`ro_gg_save()`](https://rivm-syso.github.io/ROvis.ggplot2/reference/ro_gg_save.md),
[`ro_gg_theme()`](https://rivm-syso.github.io/ROvis.ggplot2/reference/ro_gg_theme.md)

## Examples

``` r
if (FALSE) { # \dontrun{
my_plot <- ggplot2::ggplot(data = datasets::mtcars, mapping = ggplot2::aes(x = wt, y = mpg)) +
  ggplot2::geom_point() +
  ggplot2::labs(title = "mtcars plot") +
  ROvis.utils::ro_gg_theme(version = "1.0")
my_plot

#relocate y-axis title to RIVM style position
ROvis.utils::ro_gg_y_title(my_plot) +
  ggplot2::coord_cartesian(clip = "off")
  } # }
```
