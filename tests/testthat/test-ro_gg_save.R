test_that("ro_gg_save only accepts expected inputs", {
  not_a_plot <- mtcars |> gt::gt()

  my_working_plot <- ggplot2::ggplot(data = datasets::mtcars, mapping = ggplot2::aes(x = wt, y = mpg)) +
    ggplot2::geom_point() +
    ggplot2::labs(title = "mtcars plot") +
    ro_gg_theme()

  expect_error(
    ro_gg_save(plot = not_a_plot, filename = "testplt.png"),
    "'object' must be a ggplot object."
  )

  expect_error(
    ro_gg_save(plot = my_working_plot),
    'argument "filename" is missing, with no default'
  )

  expect_error(
    ro_gg_save(plot = my_working_plot, filename = "test.png", fontsize = "fifteen"),
    "@size must be <NULL>, <integer>, or <double>, not <character>"
  )
})
