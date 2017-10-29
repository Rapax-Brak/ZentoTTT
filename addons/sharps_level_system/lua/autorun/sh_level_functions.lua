local player = FindMetaTable("Player")

function player:SetLevel(level)
	self:SetNWInt("Level", level)
end

function player:LevelUp()
	self:SetXP(0)
	self:SetNWInt("Level", self:GetNWInt("Level") + 1)
end

function player:SetXP(amount)
	if (self:GetLevel() >= 65) then return end

	self:SetNWInt("XP", amount)
end

function player:AddXP(amount)
	if (self:GetLevel() >= 65) then return end

	self:SetNWInt("XP", self:GetNWInt("XP") + amount)
end

function player:GetLevel()
	return tonumber(self:GetNWInt("Level"))
end

function player:GetXP()
	return tonumber(self:GetNWInt("XP"))
end

function player:GetMaxXP()
	return tonumber((self:GetLevel() * 100) * .25)
end