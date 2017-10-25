ITEM.Name = 'Majoras Mask | VIP'
ITEM.Price = 2000
ITEM.Model = 'models/gmod_tower/majorasmask.mdl'
ITEM.Attachment = 'eyes'
ITEM.AllowedUserGroups = {"founder","manager","communitymanager","headofstaff", "vipadmin", "vipmod", "supervip", "vip"}

function ITEM:OnEquip(ply, modifications)
	ply:PS_AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:PS_RemoveClientsideModel(self.ID)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	--model:SetModelScale(1.6, 0)
	pos = pos + (ang:Forward() * -3.5)
	--ang:RotateAroundAxis(ang:Right(), 90)
	
	return model, pos, ang
end
