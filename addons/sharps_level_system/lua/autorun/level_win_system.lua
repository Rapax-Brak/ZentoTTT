include("sh_config.lua")

local function TTTWinRoundPoints(result)
--	if result == WIN_TIMELIMIT then return end 
	if (result == WIN_INNOCENT) then 
		for _, ply in pairs(player.GetAll()) do
			if (ply:GetRole() == ROLE_INNOCENT or ply:GetRole() == ROLE_DETECTIVE) then
				if (ply:Alive() and ply:GetLevel() < LevelConfig.MaxLevel) then
					ply:AddXP(LevelConfig.XPWinnerInnocentAlive)
					ply:Notify("+" .. LevelConfig.XPWinnerInnocentAlive .. "XP for winning and surviving as innocent!", 0, 5, "")
				elseif (!ply:Alive() and ply:GetLevel() < LevelConfig.MaxLevel) then 
					ply:AddXP(LevelConfig.XPWinnerInnocentDead)
					ply:Notify("+" .. LevelConfig.XPWinnerInnocentDead .. "XP for winning and surviving as innocent!", 0, 5, "")
				end
			elseif (ply:GetRole() == TEAM_SPEC) then return
			end
		end
	elseif (result == WIN_TRAITOR) then
		for _, ply in pairs(player.GetAll()) do
			if (ply:GetRole() == ROLE_TRAITOR) then
				if (ply:Alive() and ply:GetLevel() < LevelConfig.MaxLevel) then
					ply:AddXP(LevelConfig.XPWinnerTraitorAlive)
					ply:Notify("+" .. LevelConfig.XPWinnerTraitorAlive .. "XP for winning and surviving as traitor!", 0, 5, "")
				elseif (!ply:Alive() and ply:GetLevel() < LevelConfig.MaxLevel) then
					ply:AddXP(LevelConfig.XPWinnerTraitorDead)
					ply:Notify("+" .. LevelConfig.XPWinnerTraitorDead .. "XP for winning and surviving as traitor!", 0, 5, "")
				end
			elseif (ply:GetRole() == TEAM_SPEC) then return
			end
		end
	elseif (result == WIN_TIMELIMIT) then 
		for _, ply in pairs(player.GetAll()) do
			if (ply:GetRole() == ROLE_INNOCENT or ply:GetRole() == ROLE_DETECTIVE) then
				if (IsValid(ply) and ply:GetLevel() < LevelConfig.MaxLevel) then
					ply:AddXP(LevelConfig.XPTimeLimitReached)
					ply:Notify("+" .. LevelConfig.XPTimeLimitReached .. "XP because the traitors failed at their job!", 0, 5, "")
				end
			end
		end
	end
end -- end func
hook.Add("TTTEndRound", "WinPoints", TTTWinRoundPoints)