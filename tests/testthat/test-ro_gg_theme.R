test_that("ro_gg_theme works for standard graphs", {
  # version 1.0
  barplot_ro_gg_theme <- mtcars |>
    dplyr::mutate(gear = as.factor(gear)) |>
    dplyr::group_by(gear) |>
    dplyr::summarise(hp = mean(hp)) |>
    ggplot(aes(x = gear, y = hp)) +
    ggplot2::geom_bar(stat = "identity") +
    labs(title = "mtcars plot") +
    ro_gg_theme(version = "1.0", base_family = "Verdana")

  vdiffr::expect_doppelganger("barplot_ro_gg_theme", barplot_ro_gg_theme)

  # version 0.0
  barplot_ro_gg_theme_0.0 <- mtcars |>
    dplyr::mutate(gear = as.factor(gear)) |>
    dplyr::group_by(gear) |>
    dplyr::summarise(hp = mean(hp)) |>
    ggplot(aes(x = gear, y = hp)) +
    ggplot2::geom_bar(stat = "identity") +
    labs(title = "mtcars plot") +
    ro_gg_theme(version = "0.0")
  vdiffr::expect_doppelganger("barplot_ro_gg_theme_0.0", barplot_ro_gg_theme_0.0)
})

test_that("ro_gg_theme works with flip = TRUE", {
  # only possible for version 1.0
  horizontalbar_ro_gg_theme <- mtcars |>
    dplyr::mutate(gear = as.factor(gear)) |>
    dplyr::summarise(hp = mean(hp), .by = gear) |>
    ggplot(aes(x = hp, y = gear)) +
    ggplot2::geom_bar(stat = "identity") +
    labs(title = "mtcars plot") +
    ro_gg_theme(flip = TRUE, version = "1.0", base_family = "Verdana")

  vdiffr::expect_doppelganger("horizontalbar_ro_gg_theme", horizontalbar_ro_gg_theme)
})

test_that("ro_gg_theme works for more elaborate graphs", {
  # version 1.0
  groupedline_ro_gg_theme <- mtcars |>
    dplyr::mutate(cyl = as.factor(cyl)) |>
    dplyr::summarise(hp = mean(hp), .by = c(gear, cyl)) |>
    ggplot(aes(x = gear, y = hp, color = cyl)) +
    ggplot2::geom_line() +
    labs(
      title = "mtcars plot",
      subtitle = "a beautiful plot",
      caption = "Source: mtcars is a built-in R dataset"
    ) +
    ro_gg_theme(version = "1.0", base_family = "Verdana")

  vdiffr::expect_doppelganger("groupedline_ro_gg_theme", groupedline_ro_gg_theme)

  # version 0.0
  groupedline_ro_gg_theme_0.0 <- mtcars |>
    dplyr::mutate(cyl = as.factor(cyl)) |>
    dplyr::summarise(hp = mean(hp), .by = c(gear, cyl)) |>
    ggplot(aes(x = gear, y = hp, color = cyl)) +
    ggplot2::geom_line() +
    labs(
      title = "mtcars plot",
      subtitle = "a beautiful plot",
      caption = "Source: mtcars is a built-in R dataset"
    ) +
    ro_gg_theme(version = "0.0")

  vdiffr::expect_doppelganger("groupedline_ro_gg_theme_0.0", groupedline_ro_gg_theme_0.0)
})

test_that("ro_gg_theme works for facetted graphs", {
  # version 1.0
  scatterplot_facets_ro_gg_theme <- mtcars |>
    ggplot(aes(x = wt, y = mpg)) +
    ggplot2::geom_point(stat = "identity") +
    labs(title = "mtcars plot") +
    ro_gg_theme(version = "1.0", base_family = "Verdana") +
    ggplot2::facet_wrap(~gear)

  vdiffr::expect_doppelganger("scatterplot_facets_ro_gg_theme", scatterplot_facets_ro_gg_theme)

  # version 0.0
  scatter_facets_ro_gg_theme_0.0 <- mtcars |>
    ggplot(aes(x = wt, y = mpg)) +
    ggplot2::geom_point(stat = "identity") +
    labs(title = "mtcars plot") +
    ro_gg_theme(version = "0.0") +
    ggplot2::facet_wrap(~gear)

  vdiffr::expect_doppelganger("scatter_facets_ro_gg_theme_0.0", scatter_facets_ro_gg_theme_0.0)
})

test_that("ro_gg_theme errors when user gives wrong input", {
  # only possible for version 1.0
  expect_error(
    ro_gg_theme(base_size = "12", version = "1.0"),
    "must be a number, not the string"
  )

  expect_error(
    ro_gg_theme(base_family = 12, version = "1.0"),
    "must be a single string, not the number"
  )

  expect_error(
    ro_gg_theme(flip = "TRUE", version = "1.0"),
    "must be `TRUE` or `FALSE`, not the string"
  )

  expect_error(
    ro_gg_theme(base_family = "Not an installed font"),
    "Can't find the `base_family` ="
  )
})

test_that("ro_gg_theme uses the font given in ro_gg_theme", {
  p <- barplot_ro_gg_theme <- mtcars |>
    dplyr::mutate(gear = as.factor(gear)) |>
    dplyr::group_by(gear) |>
    dplyr::summarise(hp = mean(hp)) |>
    ggplot(aes(x = gear, y = hp)) +
    ggplot2::geom_bar(stat = "identity") +
    labs(title = "mtcars plot") +
    ro_gg_theme(version = "1.0", base_family = "Verdana")
  expect_equal(p@theme$text@family, "Verdana")
})
