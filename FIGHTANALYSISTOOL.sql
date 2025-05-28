-- =========================================
-- MMA Fight Analysis Database Schema
-- Author: SAFWAT AL AZAD
-- Description: Full schema for tracking fighters, fights, rounds, and actions
-- =========================================

-- Drop tables if they exist (safe re-run)
DROP TABLE IF EXISTS FightActions;
DROP TABLE IF EXISTS Rounds;
DROP TABLE IF EXISTS Fights;
DROP TABLE IF EXISTS Fighters;

-- =========================================
-- 1. Fighters Table
-- =========================================
CREATE TABLE Fighters (
    FighterID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL UNIQUE,
    Stance TEXT,              -- Orthodox, Southpaw, Switch
    ReachCM INTEGER,
    HeightCM INTEGER,
    WeightKG INTEGER,
    DateOfBirth DATE
);

-- =========================================
-- 2. Fights Table
-- =========================================
CREATE TABLE Fights (
    FightID INTEGER PRIMARY KEY AUTOINCREMENT,
    Fighter1ID INTEGER NOT NULL,
    Fighter2ID INTEGER NOT NULL,
    WinnerID INTEGER,                       -- NULL for draw/no contest
    EventName TEXT,
    FightDate DATE,
    Result TEXT,                            -- Description: "KO", "Decision", etc.
    Method TEXT,                            -- KO/TKO, Submission, Decision
    FOREIGN KEY (Fighter1ID) REFERENCES Fighters(FighterID),
    FOREIGN KEY (Fighter2ID) REFERENCES Fighters(FighterID),
    FOREIGN KEY (WinnerID) REFERENCES Fighters(FighterID)
);

-- =========================================
-- 3. Rounds Table
-- =========================================
CREATE TABLE Rounds (
    RoundID INTEGER PRIMARY KEY AUTOINCREMENT,
    FightID INTEGER NOT NULL,
    RoundNumber INTEGER NOT NULL,
    DurationSeconds INTEGER DEFAULT 300,   -- Default to 5-minute rounds
    FOREIGN KEY (FightID) REFERENCES Fights(FightID)
);

-- =========================================
-- 4. FightActions Table
-- =========================================
CREATE TABLE FightActions (
    ActionID INTEGER PRIMARY KEY AUTOINCREMENT,
    FightID INTEGER NOT NULL,
    RoundID INTEGER NOT NULL,
    TimeStampSeconds TEXT NOT NULL,     -- Format: MM:SS (remaining time)
    RoundTimeSeconds INTEGER NOT NULL,  -- Elapsed time in round as integer (e.g., 63 for 4:57)
    FighterID INTEGER NOT NULL,
    ActionType TEXT NOT NULL,           -- Punch, Kick, Takedown, etc.
    Subtype TEXT,                       -- e.g., Low Kick, Double Jab
    TargetArea TEXT,                    -- Head, Body, Leg
    Result TEXT,                        -- Landed, Missed, Blocked, Unclear
    Position TEXT,                      -- Cage, Open Mat, Clinch, etc.
    Stance TEXT,                        -- Orthodox, Southpaw, Switch
    Notes TEXT,
    FOREIGN KEY (FightID) REFERENCES Fights(FightID),
    FOREIGN KEY (RoundID) REFERENCES Rounds(RoundID),
    FOREIGN KEY (FighterID) REFERENCES Fighters(FighterID)
);

-- =========================================
-- Sample Indexes (optional for speed)
-- =========================================
CREATE INDEX idx_fighter_actions ON FightActions(FighterID);
CREATE INDEX idx_fight_round ON Rounds(FightID, RoundNumber);
CREATE INDEX idx_action_type ON FightActions(ActionType);
CREATE INDEX idx_fighter_round ON FightActions(FighterID, RoundID);
CREATE INDEX idx_fightaction_target_result ON FightActions(TargetArea, Result);
