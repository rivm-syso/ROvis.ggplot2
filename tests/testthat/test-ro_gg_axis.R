test_that("ro_gg_axis only accepts the right inputs", {
  expect_error(
    ro_gg_axis(x = c("a", "b", "c")),
    "x can only contain numerical values"
  )

  expect_error(
    ro_gg_axis(x = c(1, 2, 3), start_at_zero = "yes"),
    "`start_at_zero` must be `TRUE` or `FALSE`, not "
  )
})

test_that("axis limits are plotted as expected", {
  plot <- ggplot2::ggplot(data.frame(x = 1:11, y = c(11:17, 5:2)),
                          aes(x, y)) +
    ggplot2::geom_point() +
    scale_x_continuous(
      breaks = pretty,
      limits = ro_gg_axis
    ) +
    scale_y_continuous(
      breaks = pretty,
      limits = ro_gg_axis
    )
  vdiffr::expect_doppelganger("plot_with_pretty_axis", plot)
})
