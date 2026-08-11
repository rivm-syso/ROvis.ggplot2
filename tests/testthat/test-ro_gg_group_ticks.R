test_that("ro_gg_group_ticks only accepts expected inputs", {
  p <- ggplot2::ggplot(
    data.frame(cat = c("a", "b"), n = c(1, 2)),
    ggplot2::aes(cat, n)
  ) +
    ggplot2::geom_col()

  expect_error(ro_gg_group_ticks("not a plot"), "must be a ggplot object")
  expect_error(ro_gg_group_ticks(p, flip = "yes"), "TRUE.*FALSE")
})

test_that("ro_gg_group_ticks errors when the category axis is not discrete", {
  p <- ggplot2::ggplot(
    data.frame(x = 1:3, y = c(1, 2, 3)),
    ggplot2::aes(x, y)
  ) +
    ggplot2::geom_point()

  expect_error(
    ro_gg_group_ticks(p),
    'does not have a discrete "x" axis'
  )

  p_flip <- ggplot2::ggplot(
    data.frame(x = 1:3, y = c(1, 2, 3)),
    ggplot2::aes(x, y)
  ) +
    ggplot2::geom_point()

  expect_error(
    ro_gg_group_ticks(p_flip, flip = TRUE),
    'does not have a discrete "y" axis'
  )
})

test_that("ro_gg_group_ticks places ticks between bar groups", {
  dat <- data.frame(
    agegroup = c("0-19", "20-39", "40-59"),
    n = c(1200, 4800, 6100)
  )
  p <- ggplot2::ggplot(dat, ggplot2::aes(agegroup, n)) +
    ggplot2::geom_col() +
    ro_gg_theme(base_family = "Verdana")

  barplot_group_ticks <- ro_gg_group_ticks(p) +
    ggplot2::coord_cartesian(clip = "off")

  vdiffr::expect_doppelganger("barplot_group_ticks", barplot_group_ticks)
})

test_that("ro_gg_group_ticks works with flip = TRUE", {
  dat <- data.frame(
    agegroup = c("0-19", "20-39", "40-59"),
    n = c(1200, 4800, 6100)
  )
  p <- ggplot2::ggplot(dat, ggplot2::aes(n, agegroup)) +
    ggplot2::geom_col() +
    ro_gg_theme(flip = TRUE, base_family = "Verdana")

  horizontalbar_group_ticks <- ro_gg_group_ticks(p, flip = TRUE) +
    ggplot2::coord_cartesian(clip = "off")

  vdiffr::expect_doppelganger(
    "horizontalbar_group_ticks",
    horizontalbar_group_ticks
  )
})
