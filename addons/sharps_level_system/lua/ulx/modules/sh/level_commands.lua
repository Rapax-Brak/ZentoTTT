local CATEGORY_NAME = "Level System"

// Concommands
local function findPlayer(info)
    if not info or info == "" then return nil end
    local pls = player.GetAll()

    for k = 1, #pls do
        local v = pls[k]
        if tonumber(info) == v:UserID() then
            return v
        end

        if info == v:SteamID() then
            return v
        end

        if string.find(string.lower(v:Name()), string.lower(tostring(info)), 1, true) ~= nil then
            return v
        end
    end

    return nil
end

/*
	Add XP
*/
function ulx.add_xp(calling_ply, target_ply, amount)
	if (!target_ply) then print("Invalid target!") return end
	target_ply:AddXP(amount)

	ulx.fancyLogAdmin(calling_ply, "#A added #s xp to #T", target_ply, amount)
end

local add_xp = ulx.command(CATEGORY_NAME, "ulx add_xp", ulx.add_xp, "!add_xp", true)
add_xp:addParam{ type=ULib.cmds.PlayerArg }
add_xp:addParam{ type=ULib.cmds.StringArg }
add_xp:defaultAccess(ULib.ACCESS_SUPERADMIN)
add_xp:help("Adds XP to the specified player.")

/*
	Set XP
*/
function ulx.set_xp(calling_ply, target_ply, amount)
	if (!target_ply) then print("Invalid target!") return end
	target_ply:SetXP(amount)

	ulx.fancyLogAdmin(calling_ply, "#A set #T's xp to #s", target_ply, amount)
end

local set_xp = ulx.command(CATEGORY_NAME, "ulx set_xp", ulx.set_xp, "!set_xp", true)
set_xp:addParam{ type=ULib.cmds.PlayerArg }
set_xp:addParam{ type=ULib.cmds.StringArg }
set_xp:defaultAccess(ULib.ACCESS_SUPERADMIN)
set_xp:help("Sets the XP of the specified player.")

/*
	Set Level
*/
function ulx.set_level(calling_ply, target_ply, level)
	if (!target_ply) then print("Invalid target!") return end
	target_ply:SetXP(0)
	target_ply:SetLevel(level)

	ulx.fancyLogAdmin(calling_ply, "#A set #T's level to #s", target_ply, level)
end

local set_level = ulx.command(CATEGORY_NAME, "ulx set_level", ulx.set_level, "!set_level", true)
set_level:addParam{ type=ULib.cmds.PlayerArg }
set_level:addParam{ type=ULib.cmds.StringArg }
set_level:defaultAccess(ULib.ACCESS_SUPERADMIN)
set_level:help("Sets the Level of the specified player.")

/*
	Level Up
*/
function ulx.level_up(calling_ply, target_ply)
	if (!target_ply) then print("Invalid target!") return end
	target_ply:LevelUp()

	ulx.fancyLogAdmin(calling_ply, "#A leveled up #T", target_ply)
end

local level_up = ulx.command(CATEGORY_NAME, "ulx level_up", ulx.level_up, "!level_up", true)
level_up:addParam{ type=ULib.cmds.PlayerArg }
level_up:defaultAccess(ULib.ACCESS_SUPERADMIN)
level_up:help("Levels up the specified player.")