AddCSLuaFile()

// Draw a blurred RoundedBox
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

local function Levels_HUD()
	local client = LocalPlayer()

	local Width, Height = ScrW() * 0.15, ScrH() * 0.075
	local Padding = 15

	RoundedBoxBlur(Padding, Padding, Width, Height, 2, 5)
	draw.RoundedBox(0, Padding, Padding, Width, Height, Color(0, 0, 0, 150))

	surface.SetFont("DermaLarge")
	local LevelText = "Level: " .. client:GetLevel()
	local LT_Width, LT_Height = surface.GetTextSize(LevelText)

	draw.SimpleText(LevelText, "DermaLarge", Padding + (Width / 2), Padding + 5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	draw.SimpleText("XP: " .. client:GetXP() .. "/max_xp_here", "DermaDefault", Padding + (Width / 2), Padding + 5 + LT_Height, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

	draw.RoundedBox(0, Padding + 5, Padding + (Height - 10), Width - 10, 5, color_white)
end
hook.Add("HUDPaint", "Sharp_HUDPaint", Levels_HUD)