DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (
    id INT NOT NULL,
    team TEXT NOT NULL,
    winpercentage DECIMAL(4,3) NOT NULL,
    teamyear SMALLINT NOT NULL,
    roundmade SMALLINT NOT NULL,
    positiongroup TEXT NOT NULL,
    payrollamount INT NOT NULL,
    teamyearID TEXT NOT NULL
);


DROP TABLE IF EXISTS salarieswide;
CREATE TABLE salarieswide (
    team TEXT NOT NULL,
    winpercentage DECIMAL(4,3) NOT NULL,
    catchers TEXT NOT NULL,
    infielders TEXT NOT NULL,
    outfielders TEXT NOT NULL,
    DH TEXT NOT NULL,
    pitchers TEXT NOT NULL,
    TotalPayroll INT NOT NULL,
    teamyear SMALLINT NOT NULL,
    roundmade SMALLINT NOT NULL
)

