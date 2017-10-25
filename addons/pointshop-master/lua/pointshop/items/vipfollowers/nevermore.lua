ITEM.Name = 'Nevermore'
ITEM.Price = 1000
ITEM.Model = 'models/crow.mdl'
ITEM.Follower = 'nevermore'

function ITEM:OnEquip(ply, modifications)
	ply:Fo_CreateFollower( self.Follower )
end

function ITEM:OnHolster(ply)
	ply:Fo_RemoveFollower( self.Follower )
end