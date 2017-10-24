local Player = FindMetaTable( "Player" )
local Entity = FindMetaTable( "Entity" )

function Entity:Fo_AttachParticles( effectName )
	
	if ( not effectName ) or ( not fo.EnableAllParticles ) then return end
	if ( not fo.ShowFirstPersonParticles ) and ( self:Fo_GetOwner() == LocalPlayer() ) then return end
	
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart( vPoint ) // not sure if ( we need a start and origin ( endpoint ) for this effect, but whatever
	effectdata:SetOrigin( vPoint )
	effectdata:SetEntity( self )
	effectdata:SetScale( 1 )
	util.Effect( effectName, effectdata )

end

function Entity:Fo_Draw()
	if ( fo.ShowFirstPersonFollower ) then self:DrawModel()	end
end

// Third preson controlling test.
function Fo_CalcView( ply, pos, angles, fov )
	
	if ( ply:Fo_ShouldSpec() ) then
	
		local view = {}
		view.origin = pos
		view.angles = angles
		view.fov = fov
		
		local pet = ply:Fo_GetSpecEntity()
		pos = pet:GetPos() + fo.ViewOffset;
		targetPos = pos + angles:Forward() * -80;
		
		local tracedata = {}
		tracedata.start = pos
		tracedata.endpos = targetPos
		tracedata.filter = { pet }
		
		local trace = util.TraceLine(tracedata)
		if trace.Hit then
		   targetPos = trace.HitPos
		end
		
		view.origin = targetPos
		view.drawviewer = true
		
		return view
	
	end

end

// Prevent moving when controlling the pet.
function Fo_CreateMove( cmd )

	cmd:SetForwardMove( 0 )
	cmd:SetSideMove( 0 )

	return cmd

end

// Add a pet to show.
function Fo_AddPetsToShow( pet )
	if ( not Fo_PetsToShow ) then Fo_PetsToShow = {} end
	pet.fo_showTime = CurTime() + fo.NamePlatesShowTime
	if ( table.HasValue( Fo_PetsToShow, pet ) ) then return end
	table.insert( Fo_PetsToShow, pet )
end

// Nameplates
function Fo_NamePlates()
	
	local ply = LocalPlayer()
	if ( not IsValid( ply ) ) then return end
	
	local tres = util.TraceLine( {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:EyeAngles():Forward() * 300,
			filter = ply
	})
	
	local pet = tres.Entity
	if ( IsValid( pet ) and pet.Fo_GetOwner ) then
		Fo_AddPetsToShow( pet )
	end
	
	if ( Fo_PetsToShow ) then
		for k,pet in pairs( Fo_PetsToShow ) do
			if ( not IsValid( pet ) or pet.fo_showTime <= CurTime() ) then table.remove( Fo_PetsToShow, k ) end
			Fo_DrawInfo( pet )
		end
	end
	
end

// Draw the info.
function Fo_DrawInfo( pet )
	if ( not IsValid( pet ) ) then return end
	local owner = pet:Fo_GetOwner()
	local pos = ( pet:GetPos() + Vector( 0, 0, 15 )):ToScreen()
	
	if ( not IsValid( owner ) ) then return end
	
	pos.y = pos.y - 40
	draw.SimpleTextOutlined( ( owner:Nick() or "Unknown" ) .. "'s Follower", "Trebuchet18", pos.x , pos.y, Color( 150, 150, 150, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 200 ) )
	draw.SimpleTextOutlined( pet:GetPetName(), "Trebuchet18", pos.x , pos.y - 15, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 200 ) )
	
	-- Show the arsenal.
	if ( fo.Arsenal ) then
		local wep = "None"
		local cooldown = ""
		local color = Color( 100, 100, 100, 200 )
		if ( pet:Fo_GetArsenal() ) then 
			wep = pet:Fo_GetArsenal().Name
			color = pet:Fo_GetArsenal().NameColor
			
		end
		draw.SimpleTextOutlined( "Arsenal: " .. wep, "Trebuchet18", pos.x , pos.y + 15, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 200 ) )
		
		if ( pet:GetCooldown() > CurTime() ) then
			draw.SimpleTextOutlined( "Cooldown: " .. math.Round( math.Clamp( pet:GetCooldown() - CurTime(), 0, 2000 ) ) .. " seconds", "Trebuchet18", pos.x , pos.y + 30, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 200 ) )
		end
	end
end

// Nameplates
if ( fo.EnableNamePlates ) then hook.Add( "HUDPaint", "Fo_NamePlates", Fo_NamePlates ) end

// Remove bindings.
hook.Add( "PlayerBindPress", "Fo_PlayerBindPress", function( ply, bind )
	if ( ply:Fo_ShouldSpec() ) and (( bind == "+attack" ) or ( bind == "+attack2" ) or ( bind == "+duck" ) or ( bind == "+jump" ) ) then return true end
end )