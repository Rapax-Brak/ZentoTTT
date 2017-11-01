local ply = FindMetaTable("Player")

if (SERVER) then
	util.AddNetworkString("NotifyPlayer")
end

function ply:Notify(text, type, duration)
	if (CLIENT) then return end

	if not istable(self) then
        if not IsValid(self) then
            print(text)
            return
        end

        self = {self}
    end

    local rcp = RecipientFilter()
    for k, v in pairs(self) do
        rcp:AddPlayer(v)
    end

    net.Start("NotifyPlayer")
    	net.WriteString(text)
    	net.WriteInt(type, 16)
    	net.WriteInt(duration, 32)
    net.Send(rcp)
end

if (CLIENT) then
	net.Receive("NotifyPlayer", function()
		local msg, type, dur = net.ReadString(), net.ReadInt(16), net.ReadInt(32)

		notification.AddLegacy(msg, type, dur)
	end)
end

function ply:SetLevel(level)
	self:SetNWInt("Level", level)
end

function ply:LevelUp()
	if (self:GetLevel() >= LevelConfig.MaxLevel) then return end

	if (self:GetXP() > 0) then
		if (self:GetMaxXP() > self:GetXP()) then
			self:SetXP(0)
		else
			self:SetXP(self:GetXP() - self:GetMaxXP())
		end
	elseif (self:GetXP() <= 0) then
		self:SetXP(0)
	end
	self:SetNWInt("Level", self:GetNWInt("Level") + 1)
	self:Notify("You leveled up to " .. self:GetLevel() .. "!", 0, 5)
end

function ply:SetXP(amount)
	if (self:GetLevel() >= LevelConfig.MaxLevel) then return end

	self:SetNWInt("XP", amount)
end

function ply:AddXP(amount)
	if (self:GetLevel() >= LevelConfig.MaxLevel) then return end

	self:SetNWInt("XP", self:GetNWInt("XP") + amount)
end

function ply:GetLevel()
	return tonumber(self:GetNWInt("Level"))
end

function ply:GetXP()
	return tonumber(self:GetNWInt("XP"))
end

function ply:GetMaxXP()
	return tonumber((self:GetLevel() * 100) * LevelConfig.MaxXPMultiplier)
end