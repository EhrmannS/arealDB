library(testthat)
library(checkmate)
context("regTable")


test_that("a table inventory entry is produced", {
  path <- system.file("test_datasets", package="arealDB", mustWork = TRUE)
  setPath(root = paste0(path, "/newDB"))
  options(adb_testing = TRUE)

  regDataseries(name = "gadm",
                description = "Database of Global Administrative Areas",
                website = "https://gadm.org/index.html",
                update = TRUE)
  regDataseries(name = "maia",
                description = "ministerio de agricultura ganaderia y pesca",
                website = "http://datosestimaciones.magyp.gob.ar",
                update = TRUE)
  file.copy(from = paste0(path, "/example_table.7z"),
            to = paste0(path, "/newDB/adb_tables/stage1/example_table.7z"))
  file.copy(from = paste0(path, "/example_table1.csv"),
            to = paste0(path, "/newDB/adb_tables/stage2/arg_1_soyMaize_maia_1_1990_2017.csv"))
  file.copy(from = paste0(path, "/example_table2.csv"),
            to = paste0(path, "/newDB/adb_tables/stage2/arg_2_soyMaize_maia_1_1990_2017.csv"))

  meta_maia_1 <<- list(clusters = list(top = NULL, left = NULL, width = NULL, height = NULL,
                                      id = NULL),
                      variables = list(territories =
                                         list(type = "id", name = "al1", form = "long",
                                              row = NULL, col = 1, rel = FALSE),
                                       period =
                                         list(type = "id", name = "year", form = "long",
                                              row = NULL, col = 2, rel = FALSE),
                                       commodities =
                                         list(type = "id", name = NULL, form = "long",
                                              row = NULL, col = 3, rel = FALSE),
                                       harvested =
                                         list(type = "values", unit = "ha", factor = 1,
                                              row = NULL, col = 4, rel = FALSE,
                                              id = NULL, level = NULL),
                                       production =
                                         list(type = "values", unit = "t", factor = 1,
                                              row = NULL, col = 5, rel = FALSE,
                                              id = NULL, level = NULL)))

  output <- regTable(nation = "Argentina",
                     subset = "soyMaize",
                     dSeries = "maia", gSeries = "gadm",
                     level = 1,
                     begin = 1990, end = 2017,
                     archive = "example_table.7z|example_table1.csv",
                     update = TRUE)

  expect_tibble(x = output, nrows = 1, ncols = 8, col.names = "strict")
  expect_names(x = names(output), must.include = c("tabID", "geoID", "datID", "source_file", "schema", "date", "orig_file", "notes"))
  expect_file_exists(x = paste0(path, "/newDB/adb_tables/meta/schemas/meta_maia_1.rds"))

  unlink(paste0(path, "/newDB"), recursive = TRUE)
})

test_that("function asks for details, if not provided", {
  path <- system.file("test_datasets", package="arealDB", mustWork = TRUE)
  setPath(root = paste0(path, "/newDB"))
  options(adb_testing = TRUE)

  regDataseries(name = "gadm",
                description = "Database of Global Administrative Areas",
                website = "https://gadm.org/index.html",
                update = TRUE)
  regDataseries(name = "maia",
                description = "ministerio de agricultura ganaderia y pesca",
                website = "http://datosestimaciones.magyp.gob.ar",
                update = TRUE)
  file.copy(from = paste0(path, "/example_table.7z"),
            to = paste0(path, "/newDB/adb_tables/stage1/example_table.7z"))
  file.copy(from = paste0(path, "/example_table1.csv"),
            to = paste0(path, "/newDB/adb_tables/stage2/_1__maia_1_1990_2019.csv"))

  expect_message(object = regTable())
  output <- capture_messages(code = regTable())
  expect_character(x = output, len = 7, any.missing = FALSE, unique = TRUE)
  expect_equal(object = output[1], expected = "please type in to which data series this table belongs: \n")
  expect_equal(object = output[2], expected = "please type in to which geometry series this table belongs: \n")
  expect_equal(object = output[3], expected = "please type in the administrative level of the units: \n")
  expect_equal(object = output[4], expected = "please type in the first year in the table: \n")
  expect_equal(object = output[5], expected = "please type in the last year in the table: \n")
  expect_equal(object = output[6], expected = "please type in the archives' file name: \n")
  expect_equal(object = output[7], expected = "... please make the schema description 'meta_maia_1'.\n")

  unlink(paste0(path, "/newDB"), recursive = TRUE)
})

test_that("Error if arguments have wrong value", {
  path <- system.file("test_datasets", package="arealDB", mustWork = TRUE)
  setPath(root = paste0(path, "/newDB"))
  options(adb_testing = TRUE)

  regDataseries(name = "gadm",
                description = "Database of Global Administrative Areas",
                website = "https://gadm.org/index.html",
                update = TRUE)
  file.copy(from = paste0(path, "/example_table.7z"),
            to = paste0(path, "/newDB/adb_tables/stage1/example_table.7z"))
  file.copy(from = paste0(path, "/example_table.csv"),
            to = paste0(path, "/newDB/adb_tables/stage2/arg_1_soyMaize_test_1_1990_2017.csv"))

  expect_error(regTable(update = 1))

  unlink(paste0(path, "/newDB"), recursive = TRUE)
})