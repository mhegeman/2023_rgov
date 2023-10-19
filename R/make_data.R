library(tidyverse)

permit_numbers <- 1:200
trip_types <- c("vtr", "dnf", "none")
months <- c("none", "jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec")

rows <- tibble(
  permit_number = sample(permit_numbers, 10000, replace = TRUE),
  trip_type = sample(trip_types, 10000, replace = TRUE),
  month = sample(months, 10000, replace = TRUE)
)


# Get number of rows
num_rows <- nrow(rows)

# Calculate 10% of rows
rows_to_remove <- floor(0.1 * num_rows)

# Get random indices to remove
indices <- sample(seq_len(num_rows), size = rows_to_remove)

# Subset dataframe to remove sampled rows
rows <- rows[-indices,]

# View(rows)

readr::write_csv(rows, "fake_trip_data.csv")
