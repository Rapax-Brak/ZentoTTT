ITEM.Name = 'Flaming Skull'
ITEM.Price = 1000
ITEM.Model = 'models/Gibs/HGIBS.mdl'
ITEM.Follower = 'flaming_skull'

function ITEM:OnEquip(ply, modifications)
	ply:Fo_CreateFollower( self.Follower )
end

function ITEM:OnHolster(ply)
	ply:Fo_RemoveFollower( self.Follower )
end