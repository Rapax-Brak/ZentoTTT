local CATEGORY_NAME = "Fun"

/*
	Spam Notify
*/
function ulx.spamnotify(calling_ply, target_ply, amount, message)
	for (i = 1, amount) do
		target_ply:Notify(message, 0, 5)
	end
end

local spamnotify = ulx.command(CATEGORY_NAME, "ulx spamnotify", ulx.spamnotify, "!spamnotify", true)
spamnotify:addParam{ type=ULib.cmds.PlayerArg }
spamnotify:defaultAccess(ULib.ACCESS_SUPERADMIN)
spamnotify:help("Notifys the player according to the specified amount of times.")