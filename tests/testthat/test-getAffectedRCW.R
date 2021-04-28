test_that("function works for each input type", {
  d <- getAffectedRCW("2007-08", "HB 1001", type = "df")
  l <- getAffectedRCW("2007-08", "HB 1001", type = "list")
  x <- getAffectedRCW("2007-08", "HB 1001", type = "xml")

  expect_s3_class(d, "data.frame")
  expect_type(l, "list")
  expect_type(x[[1]], "externalptr")
})

test_that("function handles vector inputs", {
  bills <- c("HB 1001", "HB 1002")

  d <- getAffectedRCW("2007-08", bills, type = "df")
  l <- getAffectedRCW("2007-08", bills, type = "list")
  x <- getAffectedRCW("2007-08", bills, type = "xml")

  expect_equal(unique(d$BillId), bills)
  expect_equal(names(l), bills)
  expect_equal(names(x), paste("2007-08", bills, sep = "//"))
})

test_that("function checks for proper formatting", {
  expect_error(getAffectedRCW("2007-2008", "HB 1001"))
  expect_error(getAffectedRCW("2007-08", "1001"))
  expect_error(getAffectedRCW("1989-90", "HB 1001"))
})