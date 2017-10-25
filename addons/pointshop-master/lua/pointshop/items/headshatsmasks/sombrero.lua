ITEM.Name = 'Sombrero'
ITEM.Price = 20000
ITEM.Model = 'models/gmod_tower/sombrero.mdl'
ITEM.Attachment = 'eyes'
ITEM.AllowedUserGroups = {"founder","manager","communitymanager","headofstaff", "vipadmin", "vipmod", "supervip", "vip"}

function ITEM:OnEquip(ply, modifications)
	ply:PS_AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:PS_RemoveClientsideModel(self.ID)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	ang:RotateAroundAxis(ang:Right(), 15)
	pos = pos + (ang:Forward() * -3) + (ang:Up() * 3)
	--
	
	return model, pos, ang
end
