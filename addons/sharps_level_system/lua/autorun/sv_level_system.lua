function InitializePlayerData(ply)
	// Check if the PData doesn't exist
	if (ply:GetPData("Level") == nil) then
		// Create the PData and NWInt
		ply:SetPData("Level", 1)
		ply:SetNWInt("Level", 1)

		// Create the PData and NWInt
		ply:SetPData("XP", 0)
		ply:SetNWInt("XP", 0)
	// Else, if it does exist..
	else
		// Just create the NWInt
		ply:SetNWInt("Level", ply:GetPData("Level"))
		ply:SetNWInt("XP", ply:GetPData("XP"))
	end
end
hook.Add("PlayerInitialSpawn", "InitializePlayerData", InitializePlayerData)

function LevelPlayerDeath(victim, inflictor, attacker)
end
hook.Add("PlayerDeath", "LevelPlayerDeath", LevelPlayerDeath)

function SaveDisconnectedPlayerData(ply)
	// Update the player's level and xp PData
	ply:SetPData("Level", ply:GetNWInt("Level"))
	ply:SetPData("XP", ply:GetNWInt("XP"))
end
hook.Add("PlayerDisconnected", "SaveDisconnectedPlayerData", SaveDisconnectedPlayerData)

function SaveAllPlayerData(ply)
	// Loop through every player
	for k, v in pairs(player.GetAll()) do
		// Update their level and xp PData
		v:SetPData("Level", v:GetNWInt("Level"))
		v:SetPData("XP", v:GetNWInt("XP"))
	end
end
hook.Add("ShutDown", "SaveAllPlayerData", SaveAllPlayerData)

hook.Add("Think", "LevelThink", function()
	for k, v in pairs(player.GetAll()) do
		if (v:GetXP() >= v:GetMaxXP()) then
			v:LevelUp()
		end
	end
end)