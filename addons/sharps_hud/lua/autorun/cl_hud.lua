AddCSLuaFile()



// Hide the default HUD
local HUDElements = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudSuitPower"] = true,
	--["TTTInfoPanel"] = true
	--["TTTSpecHUD"] = true
}

hook.Add("HUDShouldDraw", "HideHUD", function(name)
	if (HUDElements[name]) then return false end
end)

