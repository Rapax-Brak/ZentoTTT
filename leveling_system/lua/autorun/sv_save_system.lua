/*
    Saving Levels / XP
*/

function InitializeLevelSystem()
    if (!file.IsDir("level_system", "DATA")) then
        file.CreateDir("level_system", "DATA")
    end
end
hook.Add("Initialize", "InitializeLevelSystem", InitializeLevelSystem)

function LoadPlayerData(ply)
    local PlayerFile = "level_system/" .. ply:UniqueID() .. ".txt"
    if (file.Exists(PlayerFile, "DATA")) then
        local PlayerData = util.JSONToTable(file.Read(PlayerFile, "DATA"))
        // Update the player's stats (if u want to)
        file.Write(PlayerFile, util.TableToJSON(PlayerData, true))
    else
        // Write the player's stats for the first time
        data = {
            SteamID = ply:SteamID(),
            Level = 0,
            XP = 0
        }
        file.Write(PlayerFile, util.TableToJSON(data, true))
    end
end
hook.Add("PlayerInitialSpawn", "LoadPlayerData", LoadPlayerData)

local function TTTWinRoundPoints(result)
--	if result == WIN_TIMELIMIT then return end 
	if result == WIN_INNOCENT then 
		for _,ply in pairs(player.GetAll() ) do
			if (ply:GetRole() == ROLE_INNOCENT or ply:GetRole()== ROLE_DETECTIVE) then
				if ply:Alive() then
					ply:SetXP(ply:GetXP() + 10)
					ply:ChatPrint("+10XP for winning and surviving as innocent")
				elseif not ply:Alive() then 
					ply:SetXP(ply:GetXP() + 5)
					ply:ChatPrint("+5XP for winning but dying as innocent")
				end
			elseif ply:GetRole() == TEAM_SPEC then return
			end
		end
	elseif result == WIN_TRAITOR then
		for _,ply in pairs(player.GetAll() ) do
			if ply:GetRole() == ROLE_TRAITOR then
				if ply:Alive() then
					ply:SetXP(ply:GetXP() + 25)
					ply:ChatPrint("+25XP for winning and surviving as traitor")
				elseif not ply:Alive() then
					ply:SetXP(ply:GetXP() + 10)
					ply:ChatPrint("+10XP for winning and dying as traitor")
				end
			elseif ply:GetRole() == TEAM_SPEC then return
			end
		end
	elseif result == WIN_TIMELIMIT then 
		for _,ply in pairs(player.GetAll() ) do
			if (ply:GetRole() == ROLE_INNOCENT or ply:GetRole()== ROLE_DETECTIVE) then
				if ply:Alive() then
					ply:SetXP(ply:GetXP() + 5)
					ply:ChatPrint("+5XP because the traitors are being puss bois")
				elseif not ply:Alive() then 
					ply:SetXP(ply:GetXP() + 10)
					ply:ChatPrint("+5XP because the traitors are being puss bois")
				end
			end
		end
	end
end -- end func
hook.Add("TTTEndRound", "WinPoints", TTTWinRoundPoints)
