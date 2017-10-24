ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.AutomaticFrameAdvance = true;

function ENT:SetupDataTables()

	//self:NetworkVar( "String", 0, "PetName" );
	//self:NetworkVar( "String", 1, "Arsenal" );
	//self:NetworkVar( "Float", 0, "Cooldown" );
	//self:NetworkVar( "Entity", 0, "PetTarget" );
	//self:NetworkVar( "Vector", 0, "AimPos" );

end

-- DT VARS REPLACEMENT WHILE ITS BUGGED --

------------------------------------------

function ENT:Fo_SetCooldown( time )
	if ( self:Fo_GetOwner() ) then self:Fo_GetOwner().fo_petCooldown = time end
	self:SetCooldown( time )
end

function ENT:Initialize()
	
	// Determines wheter or not this entity is a pet.
	self.IsPet 			= true
	
	self.ModelString 	= self.ModelString or 'models/props/cs_office/Snowman_face.mdl'
	self.ModelScale 	= self.ModelScale or 1
	self.Particles 		= self.Particles
	self.PetColor 		= self.PetColor or Color( 255, 255, 255, 255 )
	self.OffsetAngle 	= self.OffsetAngle or Angle( 0, 0, 0 )
	self.ArsenalAttach	= self.ArsenalAttach or nil
	self.ArsenalForward	= self.ArsenalForward or 0
	self.ArsenalRight	= self.ArsenalRight or 0
	self.ArsenalUp		= self.ArsenalUp or 0
	self.Shadows 		= self.Shadows or false
	self.RollAngles 	= self.RollAngles or Angle( 0, 0, 0 ) 
	
	// Battle values.
	/*
	self.NextAttack		= CurTime()
	self.EndAttack		= CurTime()
	self.AttackCooldown	= 0
	*/

	if SERVER then
		self:SetModel( self.ModelString )
		self:SetMoveType( MOVETYPE_NOCLIP )
		self:SetSolid( SOLID_BBOX )
		self:SetCollisionGroup( COLLISION_GROUP_DISSOLVING )
	end

	if CLIENT then
		if self.Particles then self:Fo_AttachParticles( self.Particles ) end
		self:DrawShadow( self.Shadows )
	end
	
	self:SetModelScale( self.ModelScale, 0 )
	self:SetColor( self.PetColor )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	
end


function ENT:Think()
	
	-- Check for EQUIP/UNEQUIP
	self:Fo_CheckEquip()
	
	-- Function that calls the "OnThink" for the pet.
	local arsenal,func = self:Fo_ArsenalFunction( "OnThink" )
	if ( arsenal and func ) then func( arsenal, self:Fo_GetOwner(), self ) end
	
	if SERVER then
		self:Fo_MoveFollower()
	end

	local speed,weight = self:Fo_SetAngles( self.OffsetAngle )
	
	if ( self.Fo_UpdatePet ) then 
		self:Fo_UpdatePet( speed, weight ) 
	end
	
	if SERVER and fo.SmoothAnimations then
		self:NextThink( CurTime() )
		return true
	end
	
end



-- This checks calls the "hooks" for EQUIP and UNEQUIP
-- in the arsenal's table.
function ENT:Fo_CheckEquip()
	
	if ( fo.Arsenal and ( self:GetArsenal() != self.fo_lastArsenal ) ) then
		
		local last 		= self.fo_lastArsenal	-- Last equipped arsenal.
		local active 	= self:GetArsenal()		-- Currently equipped arsenal.

		self:Fo_CallUnequipArsenal( last )
		self:Fo_CallEquipArsenal( active )

	end
	
	self.fo_lastArsenal = self:GetArsenal()

end

-- Calls the OnPetEquip of the given arsenal.
function ENT:Fo_CallEquipArsenal( name )
	local arsenal,func = Fo_ArsenalFunction( name, "OnPetEquip" )
	if ( arsenal and func ) then
		func( arsenal, self:Fo_GetOwner(), self )	
	end
end

-- Calls the OnPetUnequip of the given arsenal.
function ENT:Fo_CallUnequipArsenal( name )
	local arsenal,func = Fo_ArsenalFunction( name, "OnPetUnequip" )
	if ( arsenal and func ) then
		func( arsenal, self:Fo_GetOwner(), self )
	end
	
	if ( CLIENT and fo.Arsenal ) then
		self:Fo_DeleteClientProps()
	end
end

function ENT:OnRemove()
	
	-- Call unequip of current arsenal when removing this entity.
	self:Fo_CallUnequipArsenal( self:GetArsenal() )
	
	local arsenal,func = self:Fo_ArsenalFunction( "OnPetRemove" )
	if ( arsenal and func ) then
		func( arsenal, self:Fo_GetOwner(), self )
	end

	if ( self.Fo_OnDeath ) then
		self:Fo_OnDeath()
	end
	
	if ( CLIENT and self.Fo_DeleteClientProps ) then
		self:Fo_DeleteClientProps()
	end

end

if CLIENT then
	function ENT:Draw()
		self:Fo_Draw()
	end
end