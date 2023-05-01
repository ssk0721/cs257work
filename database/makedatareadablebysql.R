library(dplyr)
library(tibble)
salaries <- read_csv("dataSoftwareDesign.csv")

salaries <- salaries %>%
  dplyr::select(-1) %>%
  pivot_longer(c(Catchers, Infielders, Outfielders, DH, Pitchers, TotalPayroll), 
               names_to = "PositionGroup", values_to = "totalpayroll") %>%
  mutate(teamyearID = trim(paste(year, Team, sep = ""))) 


salaries$teamyearID <- str_replace_all(string=salaries$teamyearID, pattern=" ", repl="")

tibble::rowid_to_column(salaries, "ID")
colnames(salaries)[2] = "WinPercentage"


write_csv(salaries, "dataSoftwareDesign.csv")