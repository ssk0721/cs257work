DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (
    id INT NOT NULL,
    team TEXT NOT NULL,
    winpercentage FLOAT NOT NULL,
    teamyear SMALLINT NOT NULL,
    roundmade SMALLINT NOT NULL,
    positiongroup TEXT NOT NULL,
    payrollamount INT NOT NULL,
    teamyearID TEXT NOT NULL
);


DROP TABLE IF EXISTS salarieswide;
CREATE TABLE salarieswide (
    team TEXT NOT NULL,
    winpercentage FLOAT NOT NULL,
    catchers TEXT NOT NULL,
    infielders TEXT NOT NULL,
    outfielders TEXT NOT NULL,
    DH TEXT NOT NULL,
    pitchers TEXT NOT NULL,
    TotalPayroll INT NOT NULL,
    teamyear SMALLINT NOT NULL,
    roundmade SMALLINT NOT NULL
)







class BaseballAPI:
    def __init__(self):
        '''
        Reads in and stores the data from the specified file as a pandas dataframe, then does required data cleaning for use by the rest of the functions in the class.
        PARAMETER
            filename - the name (and path, if not in the current working directory) of the data file
        '''
        self.connection = self.connect()
        self.saved_teams = []
        self.cur = self.connection.cursor()

    @staticmethod
    def connect():
        '''
        Establishes a connection to the database with the following credentials:
            user - username, which is also the name of the database
            password - the password for this database on perlman

        Returns: a database connection.

        Note: exits if a connection cannot be established.
        '''
        try:
            connection = psycopg2.connect(database=config.database, user=config.user, password=config.password, host="localhost")
        except Exception as e:
            print("Connection error: ", e)
            exit()
        return connection
    
    def get_unique_teams(self):
        '''
        helper function that outpurs a list of all distinct teams in our dataset. For use when a user selects "all teams"
        in any of the functions that have to specify a team name or 
        '''
        try:
            self.cur.execute("SELECT DISTINCT team FROM salarieswithpositiongroupcolumn;")
            distinctteams = [row[0] for row in self.cur.fetchall()]
            return distinctteams
        except Exception as e:
            print ("Something went wrong when executing the query: ", e)
            return None


    def get_unique_years(self):
        '''
        helper function that outputs a list of all distinct years in our dataset. For use when a user selects "all years"
        in any of the functions that have to specify a year or years
        '''
        try: 
            self.cur.execute("SELECT DISTINCT teamyear FROM salarieswithpositiongroupcolumn;")
            distinctyears = [row[0] for row in self.cur.fetchall()]
            return distinctyears
        except Exception as e:
            print ("Something went wrong when executing the query: ", e)
            return None



    def make_teams_list(self, teams):
        '''
        helper function that outputs a list of all distinct teams in our dataset if the user selects "all teams", or splits
        the string teams inputted by the user by a comma
        '''
        if teams == "all teams":
            teams = self.get_unique_teams()
        else:
            teams = teams.split(", ")
        return teams

    def make_years_list(self,years):
        '''
        helper function that outputs a list of all distinct years in our dataset if the user selects "all teams", or splits
        the string years inputted by the user by a comma
        '''
        if years == "all years":
            years = self.get_unique_years()
        else:
            years = years.split(", ")
            years = [eval(i) for i in years]
        return years


    def query_db(self, query, args=(), one=False):
        '''
        helper function that queries our database and returns the value of the columns, along with the column names
        '''
        self.cur.execute(query, args)
        r = [dict((self.cur.description[i][0], value) \
                for i, value in enumerate(row)) for row in self.cur.fetchall()]
        self.cur.connection.close()
        return (r[0] if r else None) if one else r


    def get_payrolls_winpercentage_wanted_years_wanted_teams_wanted_position_group(self,teams, years, positiongroup):
        '''
        This function will return the winpercentage and payrollamount columns from our salarieswithpositiongroupcolumn table in our database
        for the user's wanted years, teams, and position group. It will then convert the data received by the query to a 
        json string for use when we visualize the data in the front end
        Parameters
        ----------
        teams : str
            name of team user wants to see data for, or teams separated by a comma (eg. "Boston Red Sox, New York Yankees"), or 
            "all teams" if the user wants to see data for all teams
        years : str 
            the year the user wants to see data for, or years separated by a comma (eg. "2013, 2014"), or 
            "all years" if the user wants to see data for all years
        position_group : str
            The position group that the user wants (Choices: "Catchers", "Pitchers", "Infielders", "Outfielders", "Pitchers", "DH"), or "TotalPayroll",
            which will return the payroll information for all positions combined
        
        Returns
        -------
        json_output_payrolls_winpercentage_for_wanted_teams_years_and_positiongroups : str
            json string of queried data based on the user's inputs for the parameters (eg. if we wanted to get the win percentages and
            payroll data for the Boston Red Sox and the New York Yankees for the 2013 and 2014 seasons, along with specifying that the
            payroll data is for the catchers, the following would be output:
            "[{"team": "New York Yankees", "winpercentage": 0.519, "payrollamount": 18047479}, {"team": "Boston Red Sox", "winpercentage": 0.438, "payrollamount": 3700599}, 
            {"team": "New York Yankees", "winpercentage": 0.525, "payrollamount": 1528481}, {"team": "Boston Red Sox", "winpercentage": 0.602, "payrollamount": 7889426}]"
            This can then be used in our front end to display the exact data that is needed for our graphs
            )
        '''
        try:
            teams = self.make_teams_list(teams)
            years = self.make_years_list(years)
            query = self.query_db("SELECT team, positiongroup, teamyear, winpercentage, payrollamount FROM salarieswithpositiongroupcolumn WHERE positiongroup = %s AND team = ANY(%s) AND teamyear = ANY(%s);", (positiongroup,teams, years))
            json_output_payrolls_winpercentage_for_wanted_teams_years_and_positiongroups = json.dumps(query)
            return json_output_payrolls_winpercentage_for_wanted_teams_years_and_positiongroups
        except Exception as e:
            print ("Something went wrong when executing the query: ", e)
            return None





    def get_payroll_wanted_year_wanted_team_wanted_positiongroup(self, team, year, positiongroup):
        '''
        This function will return the payroll amount for the user's wanted year, team, and position group. 
        Parameters
        ----------
        team : str
            name of team user wants to see data for (eg. "Boston Red Sox")
        year : str 
            the year the user wants to see data for (eg. "2013")
        position_group : str
            The position group that the user wants (Choices: "Catchers", "Pitchers", "Infielders", "Outfielders", "Pitchers", "DH"), or "TotalPayroll",
            which will return the payroll information for all positions combined
        
        Returns
        -------
        payroll_wanted_year_wanted_team_wanted_positiongroup: int
        the payroll amount  of the user's wanted year, team, and position group. 
        '''
        try:
            self.cur.execute("SELECT payrollamount FROM salarieswithpositiongroupcolumn WHERE positiongroup = %s AND team = %s AND teamyear = %s;", (positiongroup,team, year))
            row = self.cur.fetchone()
            payroll_wanted_year_wanted_team_wanted_positiongroup = row[0]
            return payroll_wanted_year_wanted_team_wanted_positiongroup
        except Exception as e:
            print ("Something went wrong when executing the query: ", e)
            return None

    def get_win_percentage_wanted_year_wanted_team(self, team, year):
        '''
        This function will return the win percentage for the user's wanted year and team
        Parameters
        ----------
        team : str
            name of team user wants to see data for (eg. "Boston Red Sox")
        year : str 
            the year the user wants to see data for (eg. "2013")
        
        Returns
        -------
        winpercentage_wanted_year_wanted_team: float
        the win percentage for the user's wanted year and team
        '''
        try:
            self.cur.execute("SELECT winpercentage FROM salarieswithcolumnforeachpositiongroup WHERE team = %s AND teamyear = %s;", (team, year))
            row = self.cur.fetchone()
            winpercentage_wanted_year_wanted_team = row[0]
            return winpercentage_wanted_year_wanted_team
        except Exception as e:
            print ("Something went wrong when executing the query: ", e)
            return None

    def translate_roundmade_from_int_to_string(self, roundmade):
        '''
        helper function that translates the roundmade column in our data (currently as an int) to the corresponding 
        string that represents that round. used in get_number_of_apperances_and_years_of_apperance_by_round_wanted_team
        so that we can return a string with accurate and clear information about the round. 
        '''
        if roundmade == 0:
            return "didn't make the playoffs"
        elif roundmade == 1:
            return "made the Wild Card round"
        elif roundmade == 2:
            return "made the Division Series"
        elif roundmade == 3:
            return "made the Championship Series"
        elif roundmade == 4:
            return "made the World Series"
        else:
            return "won the World Series"
        
    def get_round_made_wanted_year_wanted_team(self, team, year):
        '''
        This function will return a string that contains the round made in the playoffs for the user's wanted year and team. If the team did not make the playoffs
        it will return that the team did not make the playoffs
        Parameters
        ----------
        team : str
            name of team user wants to see data for (eg. "Boston Red Sox")
        year : str 
            the year the user wants to see data for (eg. "2013")
        
        Returns
        -------
        roundmade_with_team_and_year: str
        A string that clearly states the team and year, along with what round of the playoffs they made that year,
        or the string will state that the team missed the playoffs that year if that year and team did not make the playoffs
        '''
        try:
            self.cur.execute("SELECT roundmade FROM salarieswithcolumnforeachpositiongroup WHERE team = %s AND teamyear = %s;", (team, year))
            row = self.cur.fetchone()
            roundmade = row[0]
            roundmadestring = self.translate_roundmade_from_int_to_string(roundmade)
            roundmade_with_team_and_year = "The " + str(year) + " " + str(team) + " " + str(roundmadestring)
            return roundmade_with_team_and_year
        except Exception as e:
            print ("Something went wrong when executing the query: ", e)
            return None
        
    def get_years_of_apperances_by_round_wanted_team(self, team, roundmade):
        '''
        helper function that will get the years that the team made the round that is stated as an int (1 for wild card round, 2 for division series,
        3 for championship series, 4 for making the world series, or 5 for winning the world series), or will get the years that the team missed
        the playoffs if 0 is entered as the roundmade parameter
        '''
        try:
            if roundmade == 0:
                self.cur.execute("SELECT teamyear FROM salarieswithcolumnforeachpositiongroup WHERE team = %s AND roundmade = %s;", (team, roundmade))
            else:
                self.cur.execute("SELECT teamyear FROM salarieswithcolumnforeachpositiongroup WHERE team = %s AND roundmade >= %s;", (team, roundmade))
            rows = self.cur.fetchall()
            round_made_apperance_years_list = [row[0] for row in rows]
            round_made_apperance_years_to_string = ', '.join(str(e) for e in round_made_apperance_years_list)
            return round_made_apperance_years_to_string
        except Exception as e:
            print ("Something went wrong when executing the query: ", e)
            return None

    def get_number_of_apperances_and_years_of_apperance_by_round_wanted_team(self, team, roundmade):
        '''
        This function will return a string containing the number of times a user's wanted team made the round that is stated as an int (1 for wild 
        card round, 2 for division series, 3 for championship series, 4 for making the world series, or 5 for winning the world series), or the 
        number of times the team missed the playoffs in our data if 0 is entered as the roundmade parameter. The string will also contain the number 
        of times the team made the desired round in the playoffs. 
        Parameters
        ----------
        team : str
            name of team user wants to see data for (eg. "Boston Red Sox")
        roundmade : int 
            the round of interest for the team (0 for missing the playoffs, 1 for wild card round, 2 for division series, 
            3 for championship series, 4 for making the world series, or 5 for winning the world series)
        
        Returns
        -------
        roundmade_with_team_and_year: str
        A string that clearly states the team, along with the number of times the team made the round of the playoffs entered by the 
        user and the years they made that round. It will also account for the number of times the team missed the playoffs, and the 
        years they missed the playoffs if the user desires. 
        '''
        try:
            if roundmade == 0:
                self.cur.execute("SELECT count(*) FROM salarieswithcolumnforeachpositiongroup WHERE team = %s AND roundmade = %s;", (team, roundmade))
            else:
                self.cur.execute("SELECT count(*) FROM salarieswithcolumnforeachpositiongroup WHERE team = %s AND roundmade >= %s;", (team, roundmade))
            row = self.cur.fetchone()
            num_of_round_apperances = row[0]
            num_of_round_apperances_string = self.translate_roundmade_from_int_to_string(roundmade)
            years_of_apperance = self.get_years_of_apperances_by_round_wanted_team(team, roundmade)
            number_of_apperances_and_years_of_apperance_by_round_wanted_team = "The " + str(team) + " " +str(num_of_round_apperances_string) + " " + str(num_of_round_apperances) + " time(s) from 2012-2022 in the following years: " + str(years_of_apperance)
            return number_of_apperances_and_years_of_apperance_by_round_wanted_team
        except Exception as e:
            print ("Something went wrong when executing the query: ", e)
            return None









