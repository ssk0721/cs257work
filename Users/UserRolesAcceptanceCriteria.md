User Role: Front office Member


User Story:  
Acceptance Criteria: The website is able to showcase all playoff teams of a given year in the same screen, along with table and graph comparisons of those teams
Acceptance Test 1: Given a user inputs only a year, there is a prompt that asks the user the filter type (team type, position, total payroll spent, total spent position),
which then the user can select "team type", to which they will be asked another prompt on the type of teams they want to view (all teams, all playoff teams, all teams that
made the second round, all teams that made the third round, all teams that made the world series, or the world series winner page), which then the user can then select all
playoff teams to output a page with graph and table comparisons of spending for the playoff teams
Acceptance Test 2: Given a user inputs a year and a team, in addition to having knowledge of which teams made the playoff in that year, there is a button to "save" the team
page to our comparison tool, which then the user can save all teams that made the playoffs for that year and view the comparison of the teams in our comparison tool




User Story: As a front office member, I want to see whether there is a correlation between outfield position spending and win percentage so that I can decide whether it is
worth it to sign an outfielder to a $30 million/year contract
Acceptance Criteria: The website is able to showcase information about the relationship between spending on a particular position group and win percentage
Acceptance Test 1: Given a user inputs only a year, after selecting "team type" for the filter prompt and after selecting "all teams the prompt that asks the user what type
of teams they want to view (all teams, all playoff teams, all teams that made the second round, all teams that made the third round, all teams that made the world series, or
the world series winner page), there is another prompt that asks whether a comparison is wanted for a particular position group, which then the user can select the desired
position group and output a page with graph and table comparisons for how a team spends on a particular positional group and win percentage for that year.
Acceptance Test 2: Given a user inputs "all years", after selecting "position" for the filter prompt, there is a prompt that asks whether a comparison is wanted for a
particular position group, which then the user can select the desired position group and output a page with graph and table comparisons for how a team spends on a particular
positional group and win percentage for all of the years


User Story: As a front office member, I want to see which teams have spent over $500 million in the last three years so that I can decide which teams to apply for to
maximize the amount of money that I can spend
Acceptance Criteria: The website is able to combine team's salary data over multiple years and showcase the graph and table comparisons of different teams' salary data
over multiple years
Acceptance Test 1: Given a user inputs a list of years, after selecting "position" for the filter prompt there is a prompt that asks whether a comparison is wanted for a
particular position group, which then the user can select "total payroll" and output a page with graph and table comparisons for how a team spends on a particular positional
group and win percentage for all of the years given in the list. It will pass if 
Acceptance Test 2: Given a user inputs a list of the three most recent years, after selecting "total payroll spent" for the filter prompt there is a prompt that asks to
input ">" or "<", along with a number, which then the user can select ">" and 500,000,000 and output a table of teams that have spent more than $500 million, along with
information such as win percentage and how much money they spent on each position for the given list of years, and a graph comparing total money spent and win percentage
for the given list of years


