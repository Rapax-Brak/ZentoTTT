ITEM.Name = 'Bubbles'
ITEM.Price = 1000
ITEM.Model = 'models/props/de_tides/Vending_turtle.mdl'
ITEM.Follower = 'bubbles'

function ITEM:OnEquip(ply, modifications)
	ply:Fo_CreateFollower( self.Follower )
end

function ITEM:OnHolster(ply)
	ply:Fo_RemoveFollower( self.Follower )
end