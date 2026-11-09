# Add RIVM-style tick marks between bar/column groups

**\[experimental\]** Replaces the default per-category axis ticks of a
bar/column chart with tick marks placed *between* each group of bars,
following RIVM design guidelines. ggplot2 centers axis ticks under/next
to each category by default; `ro_gg_group_ticks()` hides those and draws
short line segments at the boundary between every pair of adjacent
categories instead, plus the two outer edges.

Since the tick marks are drawn just outside the panel area, always use
this function in combination with `coord_cartesian(clip = "off")`.

## Usage

``` r
ro_gg_group_ticks(plot, flip = FALSE)
```

## Arguments

- plot:

  A ggplot object with a discrete category axis (e.g. from
  [`geom_col()`](https://ggplot2.tidyverse.org/reference/geom_bar.html)/[`geom_bar()`](https://ggplot2.tidyverse.org/reference/geom_bar.html)).

- flip:

  Logical. Set to `TRUE` if the category axis is `y` rather than `x`
  (the same orientation you'd pass to `theme_ggrivm(flip = TRUE)`).
  Default = FALSE.

## Value

A ggplot object

## See also

Other ggplot2:
[`ro_gg_axis()`](https://rivm-syso.github.io/ROvis.ggplot2/reference/ro_gg_axis.md),
[`ro_gg_plot()`](https://rivm-syso.github.io/ROvis.ggplot2/reference/ro_gg_plot.md),
[`ro_gg_remove_axis_gap()`](https://rivm-syso.github.io/ROvis.ggplot2/reference/ro_gg_remove_axis_gap.md),
[`ro_gg_save()`](https://rivm-syso.github.io/ROvis.ggplot2/reference/ro_gg_save.md),
[`ro_gg_theme()`](https://rivm-syso.github.io/ROvis.ggplot2/reference/ro_gg_theme.md),
[`ro_gg_y_title()`](https://rivm-syso.github.io/ROvis.ggplot2/reference/ro_gg_y_title.md)

## Examples

``` r
if (FALSE) { # \dontrun{
library(ggplot2)

dat <- data.frame(agegroup = c("0-19", "20-39", "40-59"), n = c(1200, 4800, 6100))
p <- ggplot(dat, aes(agegroup, n)) +
  geom_col() +
  theme_ggrivm()

ro_gg_group_ticks(p) +
  coord_cartesian(clip = "off")
} # }
```
