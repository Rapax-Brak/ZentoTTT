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

// Format numbers (i.e: 4000 = 4,000)
local function formatNumber(n)
	n = tonumber(n)
	if (!n) then
		return 0
	end
	if n >= 1e14 then return tostring(n) end
    n = tostring(n)
    sep = sep or ","
    local dp = string.find(n, "%.") or #n+1
	for i=dp-4, 1, -3 do
		n = n:sub(1, i) .. sep .. n:sub(i+1)
    end
    return n
end

// Fonts
surface.CreateFont("LevelFont", {
	font = "DermaLarge",
	size = ScreenScale(12),
	weight = 500
})

surface.CreateFont("XPFont", {
	font = "DermaLarge",
	size = ScreenScale(8),
	weight = 500
})

local smooth = 0
local function Levels_HUD()
	local client = LocalPlayer()

	local Width, Height = ScrW() * 0.15, ScrH() * 0.075
	local Padding = 15

	RoundedBoxBlur(Padding, Padding, Width, Height, 2, 5)
	draw.RoundedBox(0, Padding, Padding, Width, Height, Color(0, 0, 0, 150))

	// Get the size of the texts displayed
	surface.SetFont("LevelFont")
	local LevelText = "Level: " .. formatNumber(client:GetLevel())
	local LT_Width, LT_Height = surface.GetTextSize(LevelText)

	surface.SetFont("XPFont")
	local XPText = "XP: " .. formatNumber(client:GetXP()) .. "/" .. formatNumber(client:GetMaxXP())

	if (client:GetLevel() >= 65) then
		XPText = "MAX LEVEL"
	end

	draw.SimpleText(LevelText, "LevelFont", Padding + (Width / 2), Padding + 5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	draw.SimpleText(XPText, "XPFont", Padding + (Width / 2), Padding + 5 + LT_Height, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

	smooth = Lerp(0.99 * FrameTime(), smooth, (Width - 10) * (client:GetXP() / client:GetMaxXP()))

	draw.RoundedBox(0, Padding + 5, Padding + (Height - 10), Width - 10, 5, Color(0, 0, 0, 150))
	draw.RoundedBox(0, Padding + 5, Padding + (Height - 10), smooth, 5, color_white)
end
hook.Add("HUDPaint", "Sharp_HUDPaint", Levels_HUD)