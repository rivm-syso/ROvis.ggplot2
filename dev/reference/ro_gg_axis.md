# Expand Axis Limits for Plots

Calculates axis limits for a plot that are aligned with pretty breaks,
ensuring that all data points are within the range and the maximum value
is comfortably included, in accordance with RIVM styling. Optionally,
the lower limit can be set to zero.

## Usage

``` r
ro_gg_axis(x, start_at_zero = TRUE)
```

## Arguments

- x:

  Numeric vector of values to be plotted.

- start_at_zero:

  Logical; if TRUE (default), the lower limit of the axis will start at
  0.

## Value

A numeric vector of length 2, giving the minimum and maximum axis
limits.

## See also

Other ggplot2:
[`ro_gg_group_ticks()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_group_ticks.md),
[`ro_gg_plot()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_plot.md),
[`ro_gg_remove_axis_gap()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_remove_axis_gap.md),
[`ro_gg_save()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_save.md),
[`ro_gg_theme()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_theme.md),
[`ro_gg_y_title()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_y_title.md)

## Examples

``` r
# Example with ggplot2
if (FALSE) { # \dontrun{
library(ggplot2)
data <- data.frame(x = 1:11, y = c(11:17, 5:2))

ggplot(data, aes(x, y)) +
  geom_point() +
  scale_x_continuous(
    breaks = pretty,
    limits = ro_gg_axis
  ) +
  scale_y_continuous(
    breaks = pretty,
    limits = ro_gg_axis
  )
} # }
```
