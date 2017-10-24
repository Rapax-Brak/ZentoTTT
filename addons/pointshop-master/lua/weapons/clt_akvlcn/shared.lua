SWEP.Gun = ("clt_akvlcn") 
SWEP.Category				= "Pointshop Weapons" 
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "AK-47 Vulcan"			
SWEP.Slot				= 2				
SWEP.SlotPos				= 3			
SWEP.DrawAmmo				= true		
SWEP.DrawWeaponInfoBox		= false		
SWEP.BounceWeaponIcon   	= false		
SWEP.DrawCrosshair			= true		
SWEP.Weight					= 43		
SWEP.AutoSwitchTo			= true		
SWEP.AutoSwitchFrom			= true		
SWEP.HoldType 				= "ar2"		


SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_vulakclt.mdl"	
SWEP.WorldModel				= "models/weapons/w_rif_ak47.mdl"	
SWEP.ShowWorldModel			= false
SWEP.Base				= "clout_gun_base" 
SWEP.Spawnable				= false
SWEP.AdminSpawnable			= false
SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound("clt_vcln-1")		
SWEP.Primary.SilencedSound 	= Sound("")		
SWEP.Primary.RPM			= 575			
SWEP.Primary.ClipSize			= 30		
SWEP.Primary.DefaultClip		= 90		
SWEP.Primary.KickUp				= 0.6		
SWEP.Primary.KickDown			= 0.3		
SWEP.Primary.KickHorizontal		= 0.4		
SWEP.Primary.Automatic			= true		
SWEP.Primary.Ammo			= "ar2"			

SWEP.SelectiveFire		= false
SWEP.CanBeSilenced		= false

SWEP.Secondary.IronFOV			= 70			

SWEP.data 				= {}				
SWEP.data.ironsights			= 1

SWEP.Primary.Damage		= 23	
SWEP.Primary.Spread		= .03	
SWEP.Primary.IronAccuracy = .02 

SWEP.IronSightsPos = Vector ( 4.869, -14.039, 1.769 )
SWEP.IronSightsAng = Vector ( 2.342, -0.145, 0 )

SWEP.SightsPos = Vector ( 4.869, -14.039, 1.769 )
SWEP.SightsAng = Vector ( 2.342, -0.145, 0 )

SWEP.RunSightsPos = Vector ( -5.131, 4.952, -2.37 )

SWEP.RunSightsAng = Vector ( 0, -26.59, 1.608 )


SWEP.WElements = {
	["clt_vlcn_wrld"] = { type = "Model", model = "models/weapons/w_vulakclt.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.444, 1.483, 0.4), angle = Angle(-12.407, 2.015, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


