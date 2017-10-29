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
function SavePlayerData(ply)
	// Update the player's level and xp PData
	ply:SetPData("Level", ply:GetNWInt("Level"))
	ply:SetPData("XP", ply:GetNWInt("XP"))
end
hook.Add("PlayerDisconnected", "SavePlayerData", SavePlayerData)

local function TTTWinRoundPoints(result)
--	if result == WIN_TIMELIMIT then return end 
	if result == WIN_INNOCENT then 
		for _,ply in pairs(player.GetAll() ) do
			if (ply:GetRole() == ROLE_INNOCENT or ply:GetRole()== ROLE_DETECTIVE) then
				if ply:Alive() then
					ply:AddXP( 10 )
					ply:ChatPrint("+10XP for winning and surviving as innocent")
				elseif not ply:Alive() then 
					ply:AddXP( 5 )
					ply:ChatPrint("+5XP for winning but dying as innocent")
				end
			elseif ply:GetRole() == TEAM_SPEC then return
			end
		end
	elseif result == WIN_TRAITOR then
		for _,ply in pairs(player.GetAll() ) do
			if ply:GetRole() == ROLE_TRAITOR then
				if ply:Alive() then
					ply:AddXP( 25 )
					ply:ChatPrint("+25XP for winning and surviving as traitor")
				elseif not ply:Alive() then
					ply:AddXP( 10 )
					ply:ChatPrint("+10XP for winning and dying as traitor")
				end
			elseif ply:GetRole() == TEAM_SPEC then return
			end
		end
	elseif result == WIN_TIMELIMIT then 
		for _,ply in pairs(player.GetAll() ) do
			if (ply:GetRole() == ROLE_INNOCENT or ply:GetRole()== ROLE_DETECTIVE) then
				if ply:Alive() then
					ply:AddXP( 5 )
					ply:ChatPrint("+5XP because the traitors are being puss bois")
				elseif not ply:Alive() then 
					ply:AddXP( 5 )
					ply:ChatPrint("+5XP because the traitors are being puss bois")
				end
			end
		end
	end
end -- end func
hook.Add("TTTEndRound", "WinPoints", TTTWinRoundPoints)


