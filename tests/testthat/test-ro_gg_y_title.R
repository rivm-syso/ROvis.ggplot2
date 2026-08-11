test_that("ro_gg_y_title errors when user gives wrong input", {

  my_plot <- ggplot2::ggplot(data = datasets::mtcars, mapping = ggplot2::aes(x = wt, y = mpg)) +
    ggplot2::geom_point() +
    ggplot2::labs(title = "mtcars plot") +
    ro_gg_theme(version = "1.0", base_family = "Verdana")

  plot_with_y_axis_rivm <- ro_gg_y_title(my_plot) +
    ggplot2::coord_cartesian(clip = "off")

  vdiffr::expect_doppelganger("plot_with_y_axis_rivm", plot_with_y_axis_rivm)

})

test_that("ro_gg_y_title errors when user gives wrong input", {

  my_plot <- ggplot2::ggplot(data = datasets::mtcars, mapping = ggplot2::aes(x = wt, y = mpg)) +
    ggplot2::geom_point() +
    ggplot2::labs(title = "mtcars plot") +
    ro_gg_theme(version = "1.0", base_family = "Verdana")

  expect_error(
    ro_gg_y_title("hallo"),
    "is not a ggplot object. Check your input"
  )

  expect_error(
    ro_gg_y_title(),
    "is missing, with no default"
  )
})
