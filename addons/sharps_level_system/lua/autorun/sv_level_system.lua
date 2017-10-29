function InitializePlayerData(ply)
	// Check if the PData doesn't exist
	if (ply:GetPData("Level") == nil) then
		// Create the PData and NWInt
		ply:SetPData("Level", 0)
		ply:SetNWInt("Level", 0)

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

function SavePlayerData(ply)
	// Update the player's level and xp PData
	ply:SetPData("Level", ply:GetNWInt("Level"))
	ply:SetPData("XP", ply:GetNWInt("XP"))
end
hook.Add("PlayerDisconnected", "SavePlayerData", SavePlayerData)

hook.Add("Think", "TEST_THINK", function()
	for k, v in pairs(player.GetAll()) do
		if (v:GetXP() >= 10 and v:GetLevel() < 65) then
			v:LevelUp()
		end
	end
end)