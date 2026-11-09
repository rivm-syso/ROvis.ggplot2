# Apply the RO ggplot2 theme and auto-fix common RO style requirements

**\[experimental\]** `ro_gg_plot()` is a concept/draft function that
explores applying the RO visual style in a single step, instead of
requiring the separate calls to
[`ro_gg_theme()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_theme.md),
[`ro_gg_remove_axis_gap()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_remove_axis_gap.md),
[`ro_gg_axis()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_axis.md),
a manual thousands-separator,
[`ro_gg_group_ticks()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_group_ticks.md),
and
[`ro_gg_y_title()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_y_title.md)
described in the
[`vignette("ggplot2-in-ro-style")`](https://rivm-syso.github.io/ROvis.ggplot2/dev/articles/ggplot2-in-ro-style.md)
vignette.

Unlike
[`ro_gg_theme()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_theme.md),
which returns a
[`theme()`](https://ggplot2.tidyverse.org/reference/theme.html) object
that only carries cosmetic settings, `ro_gg_plot()` takes the *whole
plot* as input and returns a modified plot. This is required because
several RO style rules (axis limits/expansion, number formatting, y-axis
title position) depend on the data, the scales, and the geoms already
present on the plot, none of which a plain
[`theme()`](https://ggplot2.tidyverse.org/reference/theme.html) object
can see. Call `ro_gg_plot()` last, after all layers, scales, and labels
have been added.

## Usage

``` r
ro_gg_plot(
  plot,
  flip = FALSE,
  base_size = 12,
  base_family = "RijksoverheidSansWebText",
  lang = c("nl", "en"),
  auto_set_y_title = TRUE
)
```

## Arguments

- plot:

  A ggplot object, with all layers, scales, and labels already added.

- flip:

  Logical. Passed on to
  [`ro_gg_theme()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_theme.md).
  Default = FALSE.

- base_size:

  Integer. Passed on to
  [`ro_gg_theme()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_theme.md).
  Default = 12.

- base_family:

  Character. Passed on to
  [`ro_gg_theme()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_theme.md).
  Default = "RijksoverheidSansWebText".

- lang:

  Character. `"nl"` (default) uses a dot as thousands separator (e.g.
  "1.000"); `"en"` uses a comma (e.g. "1,000").

- auto_set_y_title:

  Logical. If `TRUE` (default), relocates the y-axis title via
  [`ro_gg_y_title()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_y_title.md),
  as described above. Set to `FALSE` to leave the y-axis title alone
  (`ro_gg_plot()` then only applies the cosmetic theme, legend, and axis
  changes) so you can position it yourself, e.g. with your own
  [`ggplot2::annotation_custom()`](https://ggplot2.tidyverse.org/reference/annotation_custom.html)
  call, or via `theme(axis.title.y = ...)` if the default placement
  isn't needed at all.

## Value

A modified ggplot object.

## What this does automatically

- Applies the
  [`ro_gg_theme()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_theme.md)
  cosmetic theme.

- Removes legend titles (RO style never shows one), for `fill`,
  `colour`/`color`, `shape`, `linetype`, `alpha`, and `size`.

- For bar/column charts (any layer using
  [`geom_col()`](https://ggplot2.tidyverse.org/reference/geom_bar.html)/[`geom_bar()`](https://ggplot2.tidyverse.org/reference/geom_bar.html)),
  sets the group width to 80% of each category slot, removes any padding
  between bars within the same group (switching
  [`position_dodge2()`](https://ggplot2.tidyverse.org/reference/position_dodge.html)
  to
  [`position_dodge()`](https://ggplot2.tidyverse.org/reference/position_dodge.html)
  if needed), and removes bar outlines. Tick marks are then moved from
  under each category to the boundary between groups via
  [`ro_gg_group_ticks()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_group_ticks.md).
  Works for both the default and flipped (`flip = TRUE`) orientation.

- For bar/column and line charts (any layer using
  [`geom_col()`](https://ggplot2.tidyverse.org/reference/geom_bar.html)/[`geom_bar()`](https://ggplot2.tidyverse.org/reference/geom_bar.html)/[`geom_line()`](https://ggplot2.tidyverse.org/reference/geom_path.html)),
  and only if the user has not already added a scale for the continuous
  axis, applies
  [`ro_gg_remove_axis_gap()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_remove_axis_gap.md)
  expansion,
  [`ro_gg_axis()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_axis.md)
  as the axis limits (so the continuous axis starts at 0), and a
  thousands separator on the labels. Other chart types (e.g. scatter
  plots) only get the thousands separator.

- Relocates the y-axis title to the RO position via
  [`ro_gg_y_title()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_y_title.md),
  when a y-axis title is present. Works for both the default and flipped
  (`flip = TRUE`) orientation.

## Known limitations

- The bar group width (80%), zero padding within a group, and tick-mark
  styling (color/width/length) are fixed and not user-configurable; if
  you need different values, apply
  [`ro_gg_group_ticks()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_group_ticks.md)
  and the geom parameters yourself instead of `ro_gg_plot()`.

- Detecting whether a scale was already set by the user relies on
  `plot$scales$scales`, which is a bit buggy.

- Facetted plots are not specifically handled;
  [`ro_gg_y_title()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_y_title.md)
  and
  [`ro_gg_group_ticks()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_group_ticks.md)
  only look at the first panel.

## See also

- [`ro_gg_theme()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_theme.md),
  [`ro_gg_remove_axis_gap()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_remove_axis_gap.md),
  [`ro_gg_axis()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_axis.md),
  [`ro_gg_group_ticks()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_group_ticks.md),
  and
  [`ro_gg_y_title()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_y_title.md),
  which `ro_gg_plot()` combines.

Other ggplot2:
[`ro_gg_axis()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_axis.md),
[`ro_gg_group_ticks()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_group_ticks.md),
[`ro_gg_remove_axis_gap()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_remove_axis_gap.md),
[`ro_gg_save()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_save.md),
[`ro_gg_theme()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_theme.md),
[`ro_gg_y_title()`](https://rivm-syso.github.io/ROvis.ggplot2/dev/reference/ro_gg_y_title.md)

## Examples

``` r
if (FALSE) { # \dontrun{
library(ggplot2)

dat <- data.frame(
  agegroup = c("0-19", "20-39", "40-59"),
  n = c(1200, 4800, 6100)
)

p <- ggplot(dat, aes(x = agegroup, y = n)) +
  geom_col() +
  labs(title = "Cases by age group", y = "Number of cases", x = "Age group")

# build the plot fully with `+` first, then call ro_gg_plot() on the finished object
ro_gg_plot(p)
} # }
```
