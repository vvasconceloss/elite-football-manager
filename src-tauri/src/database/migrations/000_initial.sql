-- CreateTable
CREATE TABLE "seed_status" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "seeded" INTEGER NOT NULL DEFAULT 0,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "game_state" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "date" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "stadium" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "city" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "capacity" INTEGER NOT NULL,
    "construction_year" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "nation" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "continent" TEXT NOT NULL,
    "ranking" INTEGER NOT NULL,
    "youth_rating" INTEGER NOT NULL,
    "national_team" INTEGER NOT NULL,
    "image_federation" TEXT,
    "image_flag" TEXT
);

-- CreateTable
CREATE TABLE "club" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "founded_year" INTEGER,
    "reputation" INTEGER NOT NULL,
    "balance" INTEGER,
    "budget" INTEGER,
    "salaries" INTEGER,
    "is_nation" INTEGER,
    "image_logo" TEXT,
    "nation_id" INTEGER NOT NULL,
    "stadium_id" INTEGER NOT NULL,
    CONSTRAINT "Club_nation_id_fkey" FOREIGN KEY ("nation_id") REFERENCES "Nation" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Club_stadium_id_fkey" FOREIGN KEY ("stadium_id") REFERENCES "Stadium" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "season" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "start_date" TEXT NOT NULL,
    "end_date" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "club_transactions" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "type" TEXT NOT NULL,
    "date" TEXT,
    "value" REAL,
    "club_id" INTEGER NOT NULL,
    CONSTRAINT "ClubTransactions_club_id_fkey" FOREIGN KEY ("club_id") REFERENCES "Club" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "titles" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "club_id" INTEGER NOT NULL,
    CONSTRAINT "Titles_club_id_fkey" FOREIGN KEY ("club_id") REFERENCES "Club" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "competition" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "type" TEXT,
    "continent" TEXT,
    "season_id" INTEGER NOT NULL,
    CONSTRAINT "Competition_season_id_fkey" FOREIGN KEY ("season_id") REFERENCES "Season" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "club_has_competition" (
    "club_id" INTEGER NOT NULL,
    "competition_id" INTEGER NOT NULL,

    PRIMARY KEY ("club_id", "competition_id"),
    CONSTRAINT "ClubHasCompetition_club_id_fkey" FOREIGN KEY ("club_id") REFERENCES "Club" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "ClubHasCompetition_competition_id_fkey" FOREIGN KEY ("competition_id") REFERENCES "Competition" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "club_competition_stats" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "club_id" INTEGER NOT NULL,
    "competition_id" INTEGER NOT NULL,
    "position" INTEGER,
    "matches_played" INTEGER NOT NULL DEFAULT 0,
    "wins" INTEGER NOT NULL DEFAULT 0,
    "draws" INTEGER NOT NULL DEFAULT 0,
    "losses" INTEGER NOT NULL DEFAULT 0,
    "goals_for" INTEGER NOT NULL DEFAULT 0,
    "goals_against" INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT "ClubCompetitionStats_club_id_fkey" FOREIGN KEY ("club_id") REFERENCES "Club" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "ClubCompetitionStats_competition_id_fkey" FOREIGN KEY ("competition_id") REFERENCES "Competition" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "matches" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "match_date" TEXT,
    "home_score" INTEGER,
    "away_score" INTEGER,
    "status" TEXT,
    "competition_id" INTEGER NOT NULL,
    CONSTRAINT "Matches_competition_id_fkey" FOREIGN KEY ("competition_id") REFERENCES "Competition" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "matches_has_club" (
    "matches_id" INTEGER NOT NULL,
    "club_id" INTEGER NOT NULL,

    PRIMARY KEY ("matches_id", "club_id"),
    CONSTRAINT "MatchesHasClub_matches_id_fkey" FOREIGN KEY ("matches_id") REFERENCES "Matches" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "MatchesHasClub_club_id_fkey" FOREIGN KEY ("club_id") REFERENCES "Club" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "player" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "birth_date" TEXT NOT NULL,
    "position" TEXT NOT NULL,
    "market_value" REAL,
    "current_ability" INTEGER,
    "potential_ability" INTEGER,
    "overall" INTEGER,
    "finishing" INTEGER,
    "crossing" INTEGER,
    "dribbling" INTEGER,
    "heading" INTEGER,
    "tackling" INTEGER,
    "marking" INTEGER,
    "passing" INTEGER,
    "free_kick" INTEGER,
    "acceleration" INTEGER,
    "agility" INTEGER,
    "strength" INTEGER,
    "jumping" INTEGER,
    "vision" INTEGER,
    "decision" INTEGER,
    "positioning" INTEGER,
    "antecipation" INTEGER,
    "aggression" INTEGER,
    "reflexes" INTEGER,
    "handling" INTEGER,
    "diving" INTEGER,
    "fatigue" INTEGER,
    "nation_id" INTEGER NOT NULL,
    CONSTRAINT "Player_nation_id_fkey" FOREIGN KEY ("nation_id") REFERENCES "Nation" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "player_contract" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "salary" REAL,
    "start_date" TEXT,
    "end_date" TEXT,
    "player_id" INTEGER NOT NULL,
    "club_id" INTEGER NOT NULL,
    CONSTRAINT "PlayerContract_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "Player" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "PlayerContract_club_id_fkey" FOREIGN KEY ("club_id") REFERENCES "Club" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "player_stats" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "goals" INTEGER,
    "assists" INTEGER,
    "pass_completed" INTEGER,
    "pass_failed" INTEGER,
    "shots_on_target" INTEGER,
    "shots_off_target" INTEGER,
    "interceptions" INTEGER,
    "tackles" INTEGER,
    "dribbles" INTEGER,
    "fouls_commited" INTEGER,
    "fouls_suffered" INTEGER,
    "saves" INTEGER,
    "yellow_cards" INTEGER,
    "red_cards" INTEGER,
    "gk_saves" INTEGER,
    "rating" INTEGER,
    "player_id" INTEGER NOT NULL,
    CONSTRAINT "PlayerStats_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "Player" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "player_injury" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "type" TEXT,
    "start_date" TEXT,
    "end_date" TEXT,
    "player_id" INTEGER NOT NULL,
    CONSTRAINT "PlayerInjury_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "Player" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "coach" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "first_name" TEXT,
    "last_name" TEXT,
    "birth_date" TEXT,
    "matches" INTEGER,
    "wins" INTEGER,
    "draws" INTEGER,
    "losses" INTEGER,
    "nation_id" INTEGER NOT NULL,
    CONSTRAINT "Coach_nation_id_fkey" FOREIGN KEY ("nation_id") REFERENCES "Nation" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "coach_contract" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "salary" REAL,
    "start_date" TEXT,
    "end_date" TEXT,
    "coach_id" INTEGER NOT NULL,
    "club_id" INTEGER NOT NULL,
    CONSTRAINT "CoachContract_coach_id_fkey" FOREIGN KEY ("coach_id") REFERENCES "Coach" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "CoachContract_club_id_fkey" FOREIGN KEY ("club_id") REFERENCES "Club" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
