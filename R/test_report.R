library(dplyr)

# read in our fake reporting data
reports <- readr::read_csv("fake_trip_data.csv")
# View(reports)
# required reporting

# Create column names
cols <- c("permit_number", "jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec")

# Create empty data frame
df <- data.frame(matrix(ncol = length(cols), nrow = 0))

# Set column names
colnames(df) <- cols

# View data frame
df

# aggregate by permit holder and month

x <- reports %>%
  filter(trip_type == 'vtr' & month != 0) %>%
  group_by(permit_number, month) %>%
  summarise(num_reports = n()) %>%
  mutate(num_reports = if_else(num_reports > 0 , 1, 0)) %>%
  tidyr::pivot_wider(names_from = month, values_from = num_reports, values_fill = 0)
# View(x)
# View(df)

final <- bind_rows(df, x)
View(final)


# Specify the columns you want to replace values
cols <- c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec")

# Percentage of values to replace with 0
replace_percent <- 0.1

# Loop through specified columns
for(col in cols){

  # Get number of values to replace
  n <- floor(nrow(final) * replace_percent)

  # Sample indices to replace
  indices <- sample(seq_len(nrow(final)), size = n)

  # Replace sampled values with 0
  final[indices, col] <- 0

}

