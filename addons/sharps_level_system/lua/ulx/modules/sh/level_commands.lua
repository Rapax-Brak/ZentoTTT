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
function ulx.addxp(calling_ply, target_ply, amount)
	target_ply:AddXP(amount)

	ulx.fancyLogAdmin(calling_ply, "#A added #a xp to #T", target_ply, amount)
end

local addxp = ulx.command(CATEGORY_NAME, "ulx addxp", ulx.addxp, "!addxp", true)
addxp:addParam{ type=ULib.cmds.PlayerArg }
addxp:addParam{ type=ULib.cmds.NumArg }
addxp:defaultAccess(ULib.ACCESS_SUPERADMIN)
addxp:help("Adds XP to the specified player.")

/*
	Set XP
*/
function ulx.setxp(calling_ply, target_ply, amount)
	target_ply:SetXP(amount)

	ulx.fancyLogAdmin(calling_ply, "#A set #T's xp to #s", target_ply, amount)
end

local setxp = ulx.command(CATEGORY_NAME, "ulx setxp", ulx.setxp, "!setxp", true)
setxp:addParam{ type=ULib.cmds.PlayerArg }
setxp:addParam{ type=ULib.cmds.NumArg }
setxp:defaultAccess(ULib.ACCESS_SUPERADMIN)
setxp:help("Sets the XP of the specified player.")

/*
	Set Level
*/
function ulx.setlevel(calling_ply, target_ply, level)
	target_ply:SetXP(0)
	target_ply:SetLevel(level)

	ulx.fancyLogAdmin(calling_ply, "#A set #T's level to #s", target_ply, level)
end

local setlevel = ulx.command(CATEGORY_NAME, "ulx setlevel", ulx.setlevel, "!setlevel", true)
setlevel:addParam{ type=ULib.cmds.PlayerArg }
setlevel:addParam{ type=ULib.cmds.NumArg }
setlevel:defaultAccess(ULib.ACCESS_SUPERADMIN)
setlevel:help("Sets the Level of the specified player.")

/*
	Reset Level
*/
function ulx.resetlevel(calling_ply, target_ply)
	target_ply:SetXP(0)
	target_ply:SetLevel(1)

	ulx.fancyLogAdmin(calling_ply, "#A reset #T's level", target_ply)
end

local resetlevel = ulx.command(CATEGORY_NAME, "ulx resetlevel", ulx.resetlevel, "!resetlevel", true)
resetlevel:addParam{ type=ULib.cmds.PlayerArg }
resetlevel:defaultAccess(ULib.ACCESS_SUPERADMIN)
resetlevel:help("Resets the Level of the specified player.")

/*
	Level Up
*/
function ulx.levelup(calling_ply, target_ply)
	target_ply:LevelUp()

	ulx.fancyLogAdmin(calling_ply, "#A leveled up #T", target_ply)
end

local levelup = ulx.command(CATEGORY_NAME, "ulx levelup", ulx.levelup, "!levelup", true)
levelup:addParam{ type=ULib.cmds.PlayerArg }
levelup:defaultAccess(ULib.ACCESS_SUPERADMIN)
levelup:help("Levels up the specified player.")
