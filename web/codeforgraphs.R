library(scales)
dataforindividualassignment <- dataSoftwareDesign %>%
  select(-1) %>%
  filter(Team == "Detroit Tigers")

salarieswidetigers <- dataSoftwareDesign %>%
  dplyr::select(-1) %>%
  pivot_longer(c(Catchers, Infielders, Outfielders, DH, Pitchers, TotalPayroll), 
               names_to = "PositionGroup", values_to = "totalpayroll") %>%
  mutate(teamyearID = trim(paste(year, Team, sep = ""))) %>%
  filter(Team == "Detroit Tigers") %>%
  group_by(PositionGroup) %>%
  reframe(meanamountpaid = mean(totalpayroll), meanwinpercentage = mean(`Win %`)) %>%
  filter(PositionGroup != "TotalPayroll")


ggplot(salarieswidetigers, aes(x = reorder(PositionGroup, -meanamountpaid), y = meanamountpaid)) +
  geom_bar(stat = "identity", fill = "darkgrey") +
  labs(x = "Position Group", y = "Money Spent", 
       title = "Average Money Spent on Position Groups Per Year By the Tigers from 2012-2022") +
  theme(legend.position = "none",
        plot.title = element_text(size = 24, hjust = 0.5),
        axis.text=element_text(size=24),
        axis.title=element_text(size=24)) +
  scale_y_continuous(labels = scales::comma) +
  coord_flip() 

scaleFUN <- function(x) sprintf("%.0f", x)

ggplot(dataforindividualassignment, aes(x = year, y = TotalPayroll)) +
  geom_line() +
  labs(x = "Year", y = "Total Payroll", 
       title = "The Detroit Tigers Total Payroll From 2012-2022") +
  theme(legend.position = "none",
        plot.title = element_text(size = 24, hjust = 0.5),
        axis.text=element_text(size=22),
        axis.title=element_text(size=22)) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_continuous(labels = scaleFUN, breaks = c(2012,2014,2016, 2018,2020,2022)) +
  expand_limits(x = c(min(dataforindividualassignment$year), max(dataforindividualassignment$year) + 1))

ggplot(dataforindividualassignment, aes(x = year, y = Pitchers)) +
  geom_line() +
  labs(x = "Year", y = "Pitcher Payroll", 
       title = "The Detroit Tigers Pitcher Payroll From 2012-2022") +
  theme(legend.position = "none",
        plot.title = element_text(size = 24, hjust = 0.5),
        axis.text=element_text(size=22),
        axis.title=element_text(size=22)) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_continuous(labels = scaleFUN, breaks = c(2012,2014,2016, 2018,2020,2022)) +
  expand_limits(x = c(min(dataforindividualassignment$year), max(dataforindividualassignment$year) + 1))



ggplot(dataforindividualassignment, aes(x = year, y = Catchers)) +
  geom_line() +
  labs(x = "Year", y = "Catcher Payroll", 
       title = "The Detroit Tigers Catcher Payroll From 2012-2022") +
  theme(legend.position = "none",
        plot.title = element_text(size = 24, hjust = 0.5),
        axis.text=element_text(size=22),
        axis.title=element_text(size=22)) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_continuous(labels = scaleFUN, breaks = c(2012,2014,2016, 2018,2020,2022)) +
  expand_limits(x = c(min(dataforindividualassignment$year), max(dataforindividualassignment$year) + 1))


ggplot(dataforindividualassignment, aes(x = year, y = Infielders)) +
  geom_line() +
  labs(x = "Year", y = "Infielder Payroll", 
       title = "The Detroit Tigers Infielder Payroll From 2012-2022") +
  theme(legend.position = "none",
        plot.title = element_text(size = 24, hjust = 0.5),
        axis.text=element_text(size=22),
        axis.title=element_text(size=22)) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_continuous(labels = scaleFUN, breaks = c(2012,2014,2016, 2018,2020,2022)) +
  expand_limits(x = c(min(dataforindividualassignment$year), max(dataforindividualassignment$year) + 1))


ggplot(dataforindividualassignment, aes(x = year, y = Outfielders)) +
  geom_line() +
  labs(x = "Year", y = "Outfielder Payroll", 
       title = "The Detroit Tigers Outfielder Payroll From 2012-2022") +
  theme(legend.position = "none",
        plot.title = element_text(size = 24, hjust = 0.5),
        axis.text=element_text(size=22),
        axis.title=element_text(size=22)) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_continuous(labels = scaleFUN, breaks = c(2012,2014,2016, 2018,2020,2022)) +
  expand_limits(x = c(min(dataforindividualassignment$year), max(dataforindividualassignment$year) + 1))


ggplot(dataforindividualassignment, aes(x = year, y = DH)) +
  geom_line() +
  labs(x = "Year", y = "Designated Hitter Payroll", 
       title = "The Detroit Tigers Designated Hitter Payroll From 2012-2022") +
  theme(legend.position = "none",
        plot.title = element_text(size = 24, hjust = 0.5),
        axis.text=element_text(size=22),
        axis.title=element_text(size=22)) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_continuous(labels = scaleFUN, breaks = c(2012,2014,2016, 2018,2020,2022)) +
  expand_limits(x = c(min(dataforindividualassignment$year), max(dataforindividualassignment$year) + 1))


ggplot(dataforindividualassignment, aes(x = year, y = `Win %`)) +
  geom_line() +
  labs(x = "Year", y = "Win Percentage", 
       title = "The Detroit Tigers Win Percentage From 2012-2022") +
  theme(legend.position = "none",
        plot.title = element_text(size = 24, hjust = 0.5),
        axis.text=element_text(size=22),
        axis.title=element_text(size=22)) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_continuous(labels = scaleFUN, breaks = c(2012,2014,2016, 2018,2020,2022)) +
  expand_limits(x = c(min(dataforindividualassignment$year), max(dataforindividualassignment$year) + 1))


  



