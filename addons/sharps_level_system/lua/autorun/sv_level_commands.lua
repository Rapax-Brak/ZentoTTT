// Concommands
local function findPlayer(info)
    if not info or info == "" then return nil end
    local pls = player.GetAll()

    for k = 1, #pls do
        local v = pls[k]
        if tonumber(info) == v:UserID() then
            return v
        end

        if info == v:SteamID() then
            return v
        end

        if string.find(string.lower(v:Name()), string.lower(tostring(info)), 1, true) ~= nil then
            return v
        end
    end

    return nil
end

concommand.Add("xp_add", function(ply, cmd, args)
	--local steamid = table.concat(args," ")
	local target, amount = findPlayer(args[1]), args[2]

	if (!target) then print("Invalid target!") return end
	print("Target: " .. target:Nick())
	print("Amount: " .. amount)
	target:AddXP(amount)
end)

// Chat commands