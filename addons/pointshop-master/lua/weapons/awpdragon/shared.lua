
SWEP.Gun = ("awpdragon")
SWEP.Category				= "Pointshop Weapons"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "AWP - Dragon Lore"	
SWEP.Slot				= 2			
SWEP.SlotPos				= 4		
SWEP.DrawAmmo				= true	
SWEP.DrawWeaponInfoBox			= false		
SWEP.BounceWeaponIcon   		= 	false
SWEP.DrawCrosshair			= false	
SWEP.Weight				= 50		
SWEP.AutoSwitchTo			= true	
SWEP.AutoSwitchFrom			= true	
SWEP.XHair					= false	
SWEP.BoltAction				= true
SWEP.HoldType 				= "rpg"		

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_clout_awp.mdl"	
SWEP.WorldModel				= "models/weapons/w_snip_awp.mdl"	
SWEP.ShowWorldModel			= false
SWEP.Base 				= "clout_scoped_base" 
SWEP.Spawnable				= false
SWEP.AdminSpawnable			= false

SWEP.Primary.Sound			= Sound("dragon_shot_sound")
SWEP.Primary.RPM				= 50		
SWEP.Primary.ClipSize			= 10		
SWEP.Primary.DefaultClip			= 30	
SWEP.Primary.KickUp			= 1				
SWEP.Primary.KickDown			= 1			
SWEP.Primary.KickHorizontal			= 1		
SWEP.Primary.Automatic			= false		
SWEP.Primary.Ammo			= "SniperPenetratedRound"

SWEP.Secondary.ScopeZoom			= 8	
SWEP.Secondary.UseACOG			= false 
SWEP.Secondary.UseMilDot		= false
SWEP.Secondary.UseClout         = true
SWEP.Secondary.UseSVD			= false
SWEP.Secondary.UseParabolic		= false	
SWEP.Secondary.UseElcan			= false
SWEP.Secondary.UseGreenDuplex	= false	

SWEP.data 				= {}
SWEP.data.ironsights			= 1
SWEP.ScopeScale 			= 1
SWEP.ReticleScale 				= 0.6

SWEP.Primary.Damage		= 90	
SWEP.Primary.Spread		= .015	
SWEP.Primary.IronAccuracy = .0001 


SWEP.SightsPos = Vector(5, -4.624, 0.879)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(-0.681, -2.329, 0)
SWEP.RunSightsAng = Vector(-12.804, -37.112, 11.071)

SWEP.WElements = {
	["weapon_dragonlore"] = { type = "Model", model = "models/weapons/w_clout_awp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 1.616, 0), angle = Angle(-15.301, 7.714, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
