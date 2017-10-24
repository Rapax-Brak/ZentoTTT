local Player = FindMetaTable( "Player" )
local Entity = FindMetaTable( "Entity" )

fo = {}

fo.SmoothAnimations	= true				// TURN THIS SETTING OFF TO DISABLE FAST ANIM, IMPROVES SERVER PERFORMANCE.
fo.ShowFirstPersonParticles = true		// Setting this to false will remove particle attachments from the owner's point of view.
fo.ShowFirstPersonFollower = true		// Setting this to false will disable the player's follower model from being show to him.

fo.DefaultName = "Follower"				// The default name shown in case no name is given to pets.
fo.DefaultAttackPauseTime = 0.5			// The default attack pause time.
fo.NamePlatesShowTime = 4				// How long should the nameplates be displayed?

fo.EnableSounds = true					// Set this to false to disable sounds.
fo.SoundsMinTime = 15
fo.SoundsMaxTime = 60

fo.EnableNamePlates = true				// If this is set to true, it'll show name for the pets.
fo.EnableDynamicLights = true			// Set this to false to disable dynamic lights.
fo.EnableAllParticles = true			// Set this to false to disable particles.

fo.ViewOffset = Vector( 0, 0, 20 );		// Offset when spectating a follower.
fo.Speed = 100;							// Overall speed.
fo.ForwardSpeed = 100					// Set the forward speed when controlling the entity.
fo.SideSpeed = 60						// Set the side speed of the controlled follower.
fo.UpSpeed = 20							// DOES NOT WORK YET LOL.
fo.Acceleration = 20;

fo.AllowIdleOrder = true;				// Enable/Disable the IDLE order.
fo.AllowChaseOrder = true;				// Enable/Disable the CHASE order.
fo.AllowControlOrder = true;			// Enable/Disable the CONTROLLED order. TURN THIS OFF IF YOU HAVE A THIRDPERSON MODE
fo.AllowControlCollisions = true;		// Enable/Disable the collision on pets when controlled.

fo.IdleOffset = Vector( 0, 0, 50 );		// Offset when idling.
fo.IdleTimer = 3						// Timer between idle commands for the player, so its not spammed.

fo.ChaseCircleSpeed = 150;				// Speed at which the ent circles around another entity.
fo.ChaseTimer = 3						// Timer between chase commands.

fo.Origin = Vector( 0, 0, 62 )			// Offset when following the player.
fo.Forward = -10
fo.Right = -20
fo.Up = 10
fo.Wobble = 4;
fo.WobbleSpeed = 1.5;
fo.MinSpeed = 0;
fo.MaxSpeed = 150;
fo.SpeedMult = 3;

// STATES
fo.STATE_IDLE			= 1
fo.STATE_FOLLOW 		= 2
fo.STATE_CHASE			= 3
fo.STATE_CONTROLLED		= 4
fo.STATE_ATTACK			= 5
fo.STATE_CUSTOM			= 6

function Player:Fo_GetSpecEntity()
	return self:GetNWEntity( "fo_SpecEnt" );
end

function Player:Fo_ShouldSpec()
	local ent = self:Fo_GetSpecEntity()
	if ( IsValid( ent ) ) and ( ent:Fo_GetState() == fo.STATE_CONTROLLED ) then 
		if CLIENT then 
			hook.Add( "CalcView", "Fo_CalcView", Fo_CalcView ) 
			hook.Add( "CreateMove", "Fo_CreateMove", Fo_CreateMove )
		end
		return true 
	end
	if CLIENT then
		hook.Remove( "CalcView", "Fo_CalcView" )
		hook.Remove( "CreateMove", "Fo_CreateMove" )
	end
	return false;
end

function Entity:Fo_GetOwner()
	return self:GetNWEntity( "fo_PetOwner" );
end

function Entity:Fo_GetState()
	return self:GetNWInt( "fo_State" );
end

function Entity:Fo_Speed()
	return self.fo_Speed or 0;
end

function Entity:Fo_SetSpeed( value )
	self.fo_Speed = value 
end

function Entity:SetPetName( name )
	self:SetNWString( "PetName", name )
end

function Entity:GetPetName()
	return self:GetNWString( "PetName" )
end

function Entity:SetArsenal( name )
	self:SetNWString( "Arsenal", name )
end

function Entity:GetArsenal()
	return self:GetNWString( "Arsenal" )
end

function Entity:SetCooldown( time )
	self:SetNWFloat( "Cooldown", time )
end

function Entity:GetCooldown()
	return self:GetNWFloat( "Cooldown" )
end

function Entity:SetPetTarget( ent )
	self:SetNWEntity( "PetTarget", ent )
end

function Entity:GetPetTarget()
	return self:GetNWEntity( "PetTarget" )
end

function Entity:SetAimPos( pos )
	self:SetNWVector( "AimPos", pos )
end

function Entity:GetAimPos()
	return self:GetNWVector( "AimPos" )
end


// Sets the angle of the entity.
function Entity:Fo_SetAngles( offset )
	
	if ( not self.angWeight ) then self.angWeight = 0 end
	
	local state = self:Fo_GetState();
	local ply = self:Fo_GetOwner()
	local vel = self:GetVelocity()
	local speed = vel:LengthSqr() * 0.0005
	
	if speed > 1.5 then
		self.angWeight = math.Approach( self.angWeight, 1, FrameTime() * 3 )
	else
		self.angWeight = math.Approach( self.angWeight, 0, FrameTime() * 2.5)
	end
	
	offset = offset or Angle( 0, 0, 0 )
	
	local angMove = Angle( 0, vel:Angle().y, 0 ) + offset;
	local angStop = self:GetAngles();
	
	if ( state == fo.STATE_CONTROLLED ) then
		angMove = Angle( vel:Angle().p, vel:Angle().y, 0 ) + offset;
	end
	
	if ( IsValid( ply ) ) and ( ( state == fo.STATE_FOLLOW ) or ( state == fo.STATE_CONTROLLED ) ) then
		angStop = Angle( 0, ply:GetAngles().y, 0 ) + offset;
	end
	
	if ( state == fo.STATE_ATTACK or state == fo.STATE_CUSTOM ) and ( self:GetAimPos() ) then
		angMove = ( self:GetAimPos() - self:GetPos() ):Angle() + offset
		angStop = angMove
		speed = 10000
	end
	
	self:SetAngles( LerpAngle( self.angWeight, angStop, angMove ) )
	
	//self:Fo_SetSpeed( speed )
	
	return speed, self.angWeight

end

-- Hook to tell we've loaded the addon.
hook.Run( "FollowersLoaded" )

-- Returns the arsenal and the func of a pet.
function Entity:Fo_ArsenalFunction( funcName )
	if ( not IsValid( self ) ) then return end
	return Fo_ArsenalFunction( self:GetArsenal(), funcName )
end

-- Returns the the function associated with the given arsenal.
function Fo_ArsenalFunction( arsenalName, funcName )
	if ( not fo.Arsenal ) then return end
	local arsenal = Fo_GetArsenal( arsenalName )
	
	if arsenal and arsenal[funcName] then
		return arsenal,arsenal[funcName]
	end
end