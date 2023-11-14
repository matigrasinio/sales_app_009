library(testthat)

test_that("data_header returns valid message", {
  expect_equal(
    data_header(1, 3),
    "Showing data from store 1 and department 3"
  )
})

test_that("subset_data returns data.frame with selected columns", {
  test_data <- data.frame(
    a = 1:10,
    b = letters[1:10],
    c = LETTERS[1:10]
  )
  expect_equal(
    subset_data(test_data, c("a", "b")),
    data.frame(a = 1:10, b = letters[1:10])
  )
  expect_equal(
    subset_data(test_data, c("a", "b", "d")),
    data.frame(a = 1:10, b = letters[1:10])
  )

  expect_equal(
    subset_data(test_data, c("a")),
    data.frame(a = 1:10)
  )

  expect_equal(
    subset_data(test_data, c(NULL)),
    test_data
  )

})

