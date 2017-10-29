local function TTTWinRoundPoints(result)
--	if result == WIN_TIMELIMIT then return end 
	if result == WIN_INNOCENT then 
		for _,ply in pairs(player.GetAll() ) do
			if (ply:GetRole() == ROLE_INNOCENT or ply:GetRole()== ROLE_DETECTIVE) then
				if ply:Alive() then
					ply:StatsAddXp( 10 )
					ply:ChatPrint("+10XP for winning and surviving as innocent")
				elseif not ply:Alive() then 
					ply:StatsAddXp( 5 )
					ply:ChatPrint("+5XP for winning but dying as innocent")
				end
			elseif ply:GetRole() == TEAM_SPEC then return
			end
		end
	elseif result == WIN_TRAITOR then
		for _,ply in pairs(player.GetAll() ) do
			if ply:GetRole() == ROLE_TRAITOR then
				if ply:Alive() then
					ply:StatsAddXp( 25 )
					ply:ChatPrint("+25XP for winning and surviving as traitor")
				elseif not ply:Alive() then
					ply:StatsAddXp( 10 )
					ply:ChatPrint("+10XP for winning and dying as traitor")
				end
			elseif ply:GetRole() == TEAM_SPEC then return
			end
		end
	elseif result == WIN_TIMELIMIT then 
		for _,ply in pairs(player.GetAll() ) do
			if (ply:GetRole() == ROLE_INNOCENT or ply:GetRole()== ROLE_DETECTIVE) then
				if ply:Alive() then
					ply:StatsAddXp( 5 )
					ply:ChatPrint("+5XP because the traitors are being puss bois")
				elseif not ply:Alive() then 
					ply:StatsAddXp( 5 )
					ply:ChatPrint("+5XP because the traitors are being puss bois")
				end
			end
		end
	end
end -- end func
hook.Add("TTTEndRound", "WinPoints", TTTWinRoundPoints)
