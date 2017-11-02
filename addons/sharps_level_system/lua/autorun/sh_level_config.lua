LevelConfig = {}

LevelConfig.MaxLevel = 1000 // The max level (obviously)
LevelConfig.MaxXPMultiplier = .25 // This will return 25% of (PlayerLevel * 100)

LevelConfig.XPWinnerInnocentAlive = 10 // This is the amount of xp given for winning as an innocent and surviving
LevelConfig.XPWinnerInnocentDead = LevelConfig.XPWinnerInnocentAlive / 2 // This is the amount of xp given for winning as an innocent but died
LevelConfig.XPWinnerTraitorAlive = 25 // This is the amount of xp given for winning as a traitor and surviving
LevelConfig.XPWinnerTraitorDead = LevelConfig.XPWinnerTraitorAlive / 2 // This is the amount of xp given for winning as a traitor but died
LevelConfig.XPTimeLimitReached = 5 // This is the amount of xp given if the time limit is reached