----// TTT Loadout Menu //----
-- Author: ActuallyFBI

AddCSLuaFile()

loadout = {}
loadout.version = "7/12/15"

-- Usergroups that are allowed to use the loadout menu, if you want all usergroups to be able to use it then leave the table empty/blank
loadout.whitelist = {"founder", "manager", "vipadmin", "vipmod", "supervip"}
loadout.denyMsg = "loadouts are for superVIP's only"

loadout.chatCommand = "!loadout"
loadout.keyBind = KEY_F6

-- Primary weapons. Format: Name = Class
loadout.primary = {
	["Five Seven"] = "weapon_zm_pistol",
	["Glock"] = "weapon_ttt_glock",
}

-- Secondary weapons. Format: Name = Class
loadout.secondary = {

}

-- Extra weapons. Format: Name = Class
loadout.grenades = {

}

-- Weapon icons. Format: Class = Path to material
loadout.icons = {
	["weapon_ttt_m16"] = "vgui/ttt/icon_m16",
	["weapon_zm_shotgun"] = "vgui/ttt/icon_shotgun",
	["weapon_zm_sledge"] = "vgui/ttt/icon_m249",
	["weapon_zm_mac10"] = "vgui/ttt/icon_mac",
	["weapon_zm_rifle"] = "vgui/ttt/icon_scout",
	["weapon_zm_pistol"] = "vgui/ttt/icon_pistol",
	["weapon_ttt_glock"] = "vgui/ttt/icon_glock",
	["weapon_zm_revolver"] = "vgui/ttt/icon_deagle",
}

local plymeta = FindMetaTable( "Player" )

--// Shared meta function 
function plymeta:canUseLoadout() 
	if #loadout.whitelist == 0 then return true end -- No groups on the whitelist
	
	local curgroup = self:GetUserGroup()
	for k, group in pairs(loadout.whitelist) do
		if string.lower(curgroup) == string.lower(group) then
			return true
		end
	end
	return false
end

