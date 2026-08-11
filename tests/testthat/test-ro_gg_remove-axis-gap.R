test_that("ro_gg_remove_axis_gap returns correct output", {

  expect_equal(
    ro_gg_remove_axis_gap(),
    c(0.00, 0.00, 0.05, 0.00)
  )
})
