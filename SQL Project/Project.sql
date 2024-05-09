CREATE DATABASE IF NOT EXISTS project;
USE project;

CREATE TABLE Nation (
    NationID INT PRIMARY KEY,
    NationName VARCHAR(50),
    NationContinent VARCHAR(15),
    NationTitle INT,
    Nation_UEFA_place INT
);

CREATE TABLE League (
    LeagueID INT PRIMARY KEY,
    LeagueName VARCHAR(50),
    League_team_number INT,
    League_most_champion VARCHAR(50),
    League_foundation_year INT,
    NationID INT, 
    FOREIGN KEY (NationID) REFERENCES Nation(NationID)
);

CREATE TABLE Team (
    TeamID INT PRIMARY KEY,
    TeamName VARCHAR(50),
    TeamCity VARCHAR(50),
    Team_title_number INT,
    Team_founder VARCHAR(50),
    Team_stadium_name VARCHAR(50),
    LeagueID INT,
    FOREIGN KEY (LeagueID) REFERENCES League(LeagueID)
);

CREATE TABLE Player (
    PlayerID INT PRIMARY KEY,
    Player_jersey_number INT,
    Player_foot_choice VARCHAR(10),
    Player_nationality VARCHAR(50),
    Player_age INT,
    TeamID INT,
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);

CREATE TABLE Position (
    PositionID INT PRIMARY KEY,
    Position_attack VARCHAR(50),
    Position_defence VARCHAR(50),
    Position_mid VARCHAR(50),
    PlayerID INT,
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID)
);

CREATE TABLE Coach (
    CoachID INT PRIMARY KEY,
    Coach_age INT,
    Coach_nationality VARCHAR(50),
    Coach_title INT,
    TeamID INT,
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);

-- Test records
INSERT INTO Nation (NationID, NationName, NationContinent, NationTitle, Nation_UEFA_place)
VALUES
(1, 'Germany', 'Europe', 4, 2),
(2, 'Brazil', 'South America', 5, 1),
(3, 'Japan', 'Asia', 0, 20);

INSERT INTO League (LeagueID, LeagueName, League_team_number, League_most_champion, League_foundation_year, NationID)
VALUES
(101, 'Bundesliga', 18, 'Bayern Munich', 1963, 1),
(102, 'Brasileirão', 20, 'Palmeiras', 1971, 2),
(103, 'J1 League', 18, 'Kashima Antlers', 1993, 3);

INSERT INTO Team (TeamID, TeamName, TeamCity, Team_title_number, Team_founder, Team_stadium_name, LeagueID)
VALUES
(201, 'Bayern Munich', 'Munich', 31, 'Members of FC Bayern Munich', 'Allianz Arena', 101),
(202, 'Palmeiras', 'São Paulo', 11, 'Italian-Brazilians', 'Allianz Parque', 102),
(203, 'Kashima Antlers', 'Kashima', 9, 'Sumitomo Metal Industries', 'Kashima Soccer Stadium', 103);

INSERT INTO Player (PlayerID, Player_jersey_number, Player_foot_choice, Player_nationality, Player_age, TeamID)
VALUES
(301, 10, 'Right', 'German', 28, 201),
(302, 7, 'Left', 'Brazilian', 25, 202),
(303, 18, 'Right', 'Japanese', 23, 203);

INSERT INTO Position (PositionID, Position_attack, Position_defence, Position_mid, PlayerID)
VALUES
(401, 'Striker', 'Defender', 'Midfielder', 301),
(402, 'Forward', 'Midfielder', 'Defensive Midfielder', 302),
(403, 'Attacking Midfielder', 'Full-back', 'Central Midfielder', 303);

INSERT INTO Coach (CoachID, Coach_age, Coach_nationality, Coach_title, TeamID)
VALUES
(501, 50, 'German', 7, 201),
(502, 45, 'Brazilian', 4, 202),
(503, 55, 'Japanese', 2, 203);

-- 1
SELECT LeagueID, COUNT(*) AS TeamCount
FROM Team
GROUP BY LeagueID;

-- 2
SELECT TeamID, AVG(Player_age) AS AverageAge
FROM Player
GROUP BY TeamID;

-- 3
SELECT MAX(Team_title_number) AS MaxTitles
FROM Team;

-- 4
SELECT COUNT(*) AS TotalPlayers
FROM Player;

-- 5
SELECT LeagueID, AVG(Team_title_number) AS AvgTitles
FROM Team
GROUP BY LeagueID
ORDER BY AvgTitles DESC
LIMIT 1;

-- 6
SELECT MIN(Player_age) AS MinAge, MAX(Player_age) AS MaxAge
FROM Player;

-- 7
SELECT l.LeagueName, SUM(t.Team_title_number) AS TotalTitles
FROM League l
JOIN Team t ON l.LeagueID = t.LeagueID
GROUP BY l.LeagueID, l.LeagueName;

-- 8
SELECT PlayerID, Player_jersey_number
FROM Player
ORDER BY Player_jersey_number DESC
LIMIT 1;


-- 9
SELECT AVG(Nation_UEFA_place) AS AvgUEFAPlaces
FROM Nation;

-- 10
SELECT TeamID, COUNT(*) AS CoachCount
FROM Coach
GROUP BY TeamID
ORDER BY CoachCount DESC
LIMIT 1;


ALTER TABLE Player
ADD COLUMN Player_name VARCHAR(50);

ALTER TABLE Coach
ADD COLUMN Coach_name VARCHAR(50);

UPDATE Player
SET Player_name = 'Thomas Muller' WHERE PlayerID = 301;

UPDATE Player
SET Player_name = 'Gabriel Jesus' WHERE PlayerID = 302;

UPDATE Player
SET Player_name = 'Takuya Nozawa' WHERE PlayerID = 303;

UPDATE Coach
SET Coach_name = 'Hans-Dieter Flick' WHERE CoachID = 501;

UPDATE Coach
SET Coach_name = 'Abel Ferreira' WHERE CoachID = 502;

UPDATE Coach
SET Coach_name = 'Zago' WHERE CoachID = 503;


