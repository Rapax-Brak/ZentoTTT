ITEM.Name = 'Turtle Hat | VIP'
ITEM.Price = 10000
ITEM.Model = 'models/props/de_tides/Vending_turtle.mdl'
ITEM.Attachment = 'eyes'
ITEM.AllowedUserGroups = {"founder","manager","communitymanager","headofstaff", "vipadmin", "vipmod", "supervip", "vip"}

function ITEM:OnEquip(ply, modifications)
	ply:PS_AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:PS_RemoveClientsideModel(self.ID)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	pos = pos + (ang:Forward() * -3)
	ang:RotateAroundAxis(ang:Up(), -90)
	
	return model, pos, ang
end
