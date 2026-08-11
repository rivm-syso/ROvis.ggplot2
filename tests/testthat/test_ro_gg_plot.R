test_that("ro_gg_plot validates its inputs", {
  p <- ggplot2::ggplot(data.frame(x = 1, y = 1), ggplot2::aes(x, y)) +
    ggplot2::geom_point()

  expect_error(ro_gg_plot("not a plot"), "must be a ggplot object")
  expect_error(ro_gg_plot(p, flip = "yes"), "TRUE.*FALSE")
  expect_error(ro_gg_plot(p, lang = "fr"), "must be one of")
})

test_that("ro_gg_plot applies RO bar styling and removes legend titles", {
  dat <- data.frame(cat = c("a", "b", "c"), n = c(3, 5, 2))
  p <- ggplot2::ggplot(dat, ggplot2::aes(cat, n, fill = cat)) +
    ggplot2::geom_col() +
    ggplot2::labs(fill = "Category")

  result <- ro_gg_plot(p)

  # the legend key is kept (as NULL), not dropped, so ggplot2 does not fall back to a default
  expect_true("fill" %in% names(result$labels))
  expect_null(result$labels[["fill"]])
  expect_equal(result$layers[[1]]$geom_params$width, 0.8)
  expect_equal(result$layers[[1]]$aes_params$linewidth, 0)
  expect_identical(result$coordinates$clip, "off")
})

test_that("ro_gg_plot adds a formatted continuous scale for charts", {
  dat <- data.frame(x = 1:5, y = c(1000, 2000, 1500, 3000, 2500))
  p <- ggplot2::ggplot(dat, ggplot2::aes(x, y)) +
    ggplot2::geom_line()

  result <- ro_gg_plot(p)

  y_idx <- which(vapply(
    result$scales$scales,
    function(sc) {
      "y" %in% sc$aesthetics
    },
    logical(1)
  ))
  y_scale <- result$scales$scales[[y_idx]]

  expect_length(y_idx, 1)
  expect_equal(y_scale$labels(1000), "1.000")
})

test_that("ro_gg_plot leaves scatter plots on the default scale", {
  dat <- data.frame(x = c(1000, 2000, 1500), y = c(10.5, 20.1, 15.3))
  p <- ggplot2::ggplot(dat, ggplot2::aes(x, y)) +
    ggplot2::geom_point() +
    # suppress the default axis titles ggplot2 derives from the aes mapping, so this test
    # isolates the scale/clip behavior from the (separately tested) y-title relocation
    ggplot2::labs(y = NULL)

  result <- ro_gg_plot(p)

  y_idx <- which(vapply(
    result$scales$scales,
    function(sc) "y" %in% sc$aesthetics,
    logical(1)
  ))
  y_scale <- result$scales$scales[[y_idx]]

  # scatter plots get the thousands separator but keep ggplot2's default limits/expansion,
  # since there is no discrete/category axis for the continuous axis to touch at zero
  expect_null(y_scale$limits)
  expect_equal(y_scale$labels(1000), "1.000")
  # no group ticks or y-axis title relocation happened, so clip stays at the ggplot2 default
  expect_identical(result$coordinates$clip, "on")
})

test_that("ro_gg_plot does not override a scale the user already added", {
  dat <- data.frame(x = 1:5, y = c(1000, 2000, 1500, 3000, 2500))
  p <- ggplot2::ggplot(dat, ggplot2::aes(x, y)) +
    ggplot2::geom_line() +
    ggplot2::scale_y_continuous(limits = c(0, 10000))

  result <- ro_gg_plot(p)

  y_idx <- which(vapply(
    result$scales$scales,
    function(sc) "y" %in% sc$aesthetics,
    logical(1)
  ))

  expect_length(y_idx, 1)
  expect_equal(result$scales$scales[[y_idx]]$limits, c(0, 10000))
})

test_that("ro_gg_plot relocates the y-axis title unless auto_set_y_title = FALSE", {
  dat <- data.frame(x = 1:5, y = c(1000, 2000, 1500, 3000, 2500))
  p <- ggplot2::ggplot(dat, ggplot2::aes(x, y)) +
    ggplot2::geom_line() +
    ggplot2::labs(y = "Number of cases")

  with_title <- ro_gg_plot(p)
  without_title <- ro_gg_plot(p, auto_set_y_title = FALSE)

  expect_length(with_title$layers, length(p$layers) + 1)
  expect_identical(with_title$coordinates$clip, "off")

  expect_length(without_title$layers, length(p$layers))
  expect_identical(without_title$coordinates$clip, "on")
})

test_that("ro_gg_plot renders a full bar chart in RO style", {
  dat <- data.frame(
    agegroup = c("0-19", "20-39", "40-59"),
    n = c(1200, 4800, 6100)
  )
  p <- ggplot2::ggplot(dat, ggplot2::aes(agegroup, n)) +
    ggplot2::geom_col() +
    ggplot2::labs(
      title = "Cases by age group",
      y = "Number of cases",
      x = "Age group"
    )

  barplot_ro_gg_plot <- ro_gg_plot(p, base_family = "Verdana")

  vdiffr::expect_doppelganger("barplot_ro_gg_plot", barplot_ro_gg_plot)
})

test_that("ro_gg_plot renders a flipped bar chart in RO style", {
  dat <- data.frame(
    agegroup = c("0-19", "20-39", "40-59"),
    n = c(1200, 4800, 6100)
  )
  p <- ggplot2::ggplot(dat, ggplot2::aes(n, agegroup)) +
    ggplot2::geom_col() +
    ggplot2::labs(
      title = "Cases by age group",
      x = "Number of cases",
      y = "Age group"
    )

  horizontalbar_ro_gg_plot <- ro_gg_plot(
    p,
    flip = TRUE,
    base_family = "Verdana"
  )

  vdiffr::expect_doppelganger(
    "horizontalbar_ro_gg_plot",
    horizontalbar_ro_gg_plot
  )
})
