ITEM.Name = 'Anon'
ITEM.Price = 150
ITEM.Material = 'trails/anon.vmt'

function ITEM:OnEquip(ply, modifications)
	ply.ElectricTrail = util.SpriteTrail(ply, 0, modifications.color, false, 15, 1, 4, 0.125, self.Material)
end

function ITEM:OnHolster(ply)
	SafeRemoveEntity(ply.ElectricTrail)
end

function ITEM:Modify(modifications)
	PS:ShowColorChooser(self, modifications)
end

function ITEM:OnModify(ply, modifications)
	SafeRemoveEntity(ply.ElectricTrail)
	self:OnEquip(ply, modifications)
end