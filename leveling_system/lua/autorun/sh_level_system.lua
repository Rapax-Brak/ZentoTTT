local meta = FindMetaTable("Player")

// Setters

function meta:SetLevel(level)
    if (CLIENT) then return end
    local PlayerFile = "level_system/" .. self:UniqueID() .. ".txt"

	if (file.Exists(PlayerFile, "DATA")) then
		local PlayerData = util.JSONToTable(file.Read(PlayerFile, "DATA"))
        self:SetNWInt("PlayerLevel", level)
        PlayerData.Level = level

		file.Write(PlayerFile, util.TableToJSON(PlayerData, true))
	end
end

function meta:SetXP(amount)
    if (CLIENT) then return end
    local PlayerFile = "level_system/" .. self:UniqueID() .. ".txt"

	if (file.Exists(PlayerFile, "DATA")) then
		local PlayerData = util.JSONToTable(file.Read(PlayerFile, "DATA"))
        self:SetNWInt("PlayerXP", amount)
        PlayerData.XP = amount

		file.Write(PlayerFile, util.TableToJSON(PlayerData, true))
	end
end

// Getters

function meta:GetLevel()
    if (CLIENT) then
        return self:GetNWInt("PlayerLevel")
    end

    if (SERVER) then
        local PlayerFile = "level_system/" .. self:UniqueID() .. ".txt"
    	if (file.Exists(PlayerFile, "DATA")) then
    		local PlayerData = util.JSONToTable(file.Read(PlayerFile, "DATA"))

            return PlayerData.Level
    	end
    end
end

function meta:GetXP()
    if (CLIENT) then
        return self:GetNWInt("PlayerXP")
    end

    if (SERVER) then
        local PlayerFile = "level_system/" .. self:UniqueID() .. ".txt"
    	if (file.Exists(PlayerFile, "DATA")) then
    		local PlayerData = util.JSONToTable(file.Read(PlayerFile, "DATA"))

            return PlayerData.XP
    	end
    end
end

if (CLIENT) then
    hook.Add("HUDPaint", "DrawLevelHUD", function()
        draw.SimpleText("Level: " .. LocalPlayer():GetLevel(), "DermaLarge", 25, 25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.SimpleText("XP: " .. LocalPlayer():GetXP(), "DermaLarge", 25, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end)
end
