data_header <- function(store, department) {
  paste0("Showing data from store ", store, " and department ", department)
}

subset_data <- function(data, cols) {
  valid_cols <- intersect(cols, colnames(data))
  if (length(cols) == 0) {
    return(data)
  }
  data[, valid_cols, drop = FALSE]
}

read_data <- function(store) {
  read.csv(paste0("walmart_", store, ".csv"))
}
