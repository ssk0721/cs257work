# cs257work

A repository for course work in CS 257

**Created on:** Friday, March 31, 2023

Team J

The main thing that I changed about the table in the database was making the positions into one column, and their values into another. I did this so
that there weren't as many columns in our data, and now we can also compare statistics such as the highest paid position group for a year much easier. The 
only downside is that it is much more difficult to find things such as the highest paid position for a certain team and year; however, I showed how to deal
with a similar issue with my third example query. I considered having two tables of the same data, one with a "long" format like the current one in the 
database, and one with a "wide" format with columns representing each position; however, I wasn't sure if that was the best idea in terms of efficient 
storage use. In terms of the datatypes, I thought that they were pretty striaghtforward. I decided to limit the decimal points in our win percentage, as I 
don't think it is useful to look at win percentage with any more decimal points than 3. For integer variables that I knew were not going to be above 
32,000 (year and roundmade), I decided to assign as a SMALLINT. For the integer variables that do go over 32,000 (payroll amount), or could theoretically
go over 32,000 if more data were to be added (id), I assigned as a INT. Finally, because there is no theoretical limit to our strings, I decided to assign
each of them as a text. I did not exclude any date, as I felt that all of our original variables were useful. 

For query 1, I could see a front office member looking for a new team being interested in finding out which teams have spent over $150 million in one year.
At the beginning of each offseason, many front office members end up moving teams; whether it be to move to a better city, find a better career path, or a 
promotion. They often have many choices, and I could see a front office member being interested in finding teams that consistently spend a lot of money, as
that would likely make their jobs easier. For query 2, although it would have similar motivation as query 1, I can see a fan that is debating another 
fan on the performance of the owners and front offices around the league. By getting the average for both win percentage and total payroll spent per year, 
it provides a quick and easy resource from 2012-2022 on two metrics that define both the owners' and front offices' success. Are certain teams spending 
less than others? Are certain teams winning a lot even if they are spending the most? Are teams that are spending a lot of money successful? All of these 
are possible questions by fans that can easily be answered with one query. Finally, for the last query, I think that it would be very helpful for 
players, particularly free agents. Players typically want to be on winning teams; therefore, they will likely want to choose teams that have a lot of 
apperances and wins in the world series. Furthermore, if they see that a certain team has had success spending a lot of money on their position group, they
can use that as leverage in negotiation to receive more money.  
