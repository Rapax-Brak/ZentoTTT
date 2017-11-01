AddCSLuaFile()

// Hide the default HUD

local elements = {
    ["CHudHealth"]          = true, 
    ["CHudBattery"]         = true, 
    ["CHudAmmo"]            = true, 
    ["CHudSecondaryAmmo"]   = true,
    ["TTTInfoPanel"]        = true
}

hook.Add("HUDShouldDraw", "HideDefaultHUD", function(name)
    if (elements[name]) then return false end
end)

// Blurred RoundedBox
local blur = Material("pp/blurscreen")

local function RoundedBoxBlur(x, y, w, h, amount, heavyness)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(blur)

	for i = 1, heavyness do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()

		render.UpdateScreenEffectTexture()

		render.SetScissorRect(x, y, x + w, y + h, true)
			surface.DrawTexturedRect(0 * -1, 0 * -1, ScrW(), ScrH())
		render.SetScissorRect(0, 0, 0, 0, false)
	end
end

local roundstate = {
   [ROUND_WAIT]   = "Waiting",
   [ROUND_PREP]   = "Preparing",
   [ROUND_ACTIVE] = "In Progress",
   [ROUND_POST]   = "Round Over"
}

// Get the client's team
local function GetTeamColor()
    local client = LocalPlayer()
    local col = Color(25, 200, 25, 150)

    if (roundstate != ROUND_ACTIVE) then
        col = Color(0, 0, 0, 150)
    elseif (client:GetTraitor()) then
        col = Color(200, 25, 25, 150)
    elseif (client:GetDetective()) then
        col = Color(25, 25, 200, 150)
    end

    return col
end

local function GetRoundState()
    return roundstate[GAMEMODE.round_state]
end

// Fonts

surface.CreateFont("ClientTeam", {
    font = "Open Sans",
    size = 24,
    weight = 500
})

// Draw my HUD

local function LevelHUD_ClientStats()
    local client = LocalPlayer()

    local Width, Height = ScrW() * 0.175, ScrH() * 0.125
    local Padding = 15

    RoundedBoxBlur(Padding, ScrH() - (Padding + Height), Width, Height, 2, 5)
    draw.RoundedBox(0, Padding, ScrH() - (Padding + Height), Width, Height, Color(0, 0, 0, 150))

    draw.RoundedBox(0, Padding, ScrH() - (Padding + Height), Width, Height * 0.2, GetTeamColor())
    draw.RoundedBox(0, Padding, ScrH() - (Padding + Height), Width / 2, Height * 0.2, Color(0, 0, 0, 150))
    draw.SimpleText(GetRoundState(), "ClientTeam", Padding + (Width  * .25),  ScrH() - (Padding + Height - 1), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

    local text = util.SimpleTime(math.max(0, GetGlobalFloat("ttt_round_end", 0) - CurTime()), "%02i:%02i")
    draw.SimpleText(text, "ClientTeam", Padding + (Width * .75), ScrH() - (Padding + Height - 1), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
end

function LevelHUD_HUDPaint()
    LevelHUD_ClientStats()
end
hook.Add("HUDPaint", "Level_HUDPaint", LevelHUD_HUDPaint)