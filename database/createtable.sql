DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (
    id INT NOT NULL,
    team TEXT NOT NULL,
    winpercentage DECIMAL(4,3) NOT NULL,
    teamyear SMALLINT NOT NULL,
    roundmade TINYINT NOT NULL,
    positiongroup TEXT NOT NULL,
    payrollamount INT NOT NULL,
    teamyearID TEXT NOT NULL
);

