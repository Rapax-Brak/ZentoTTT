ITEM.Name = 'Doom Dude | VIP'
ITEM.Price = 1000
ITEM.Model = 'models/ex-mo/quake3/players/doom.mdl'
ITEM.AllowedUserGroups = {"founder","manager","communitymanager","headofstaff", "vipadmin", "vipmod", "supervip", "vip" }

function ITEM:OnEquip(ply, modifications)
	if not ply._OldModel then
		ply._OldModel = ply:GetModel()
	end

	timer.Simple(1, function() ply:SetModel(self.Model) end)
end

function ITEM:OnHolster(ply)
	if ply._OldModel then
		ply:SetModel(ply._OldModel)
	end
end

function ITEM:PlayerSetModel(ply)
	ply:SetModel(self.Model)
end
