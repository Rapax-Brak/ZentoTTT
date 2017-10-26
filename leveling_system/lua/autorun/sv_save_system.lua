/*
    Saving Levels / XP
*/

function InitializeLevelSystem()
    if (!file.IsDir("level_system", "DATA")) then
        file.CreateDir("level_system", "DATA")
    end
end
hook.Add("Initialize", "InitializeLevelSystem", InitializeLevelSystem)

function LoadPlayerData(ply)
    local PlayerFile = "level_system/" .. ply:UniqueID() .. ".txt"
    if (file.Exists(PlayerFile, "DATA")) then
        local PlayerData = util.JSONToTable(file.Read(PlayerFile, "DATA"))
        // Update the player's stats (if u want to)

        file.Write(PlayerFile, util.TableToJSON(PlayerData, true))
    else
        // Write the player's stats for the first time
        data = {
            SteamID = ply:SteamID(),
            Level = 1,
            XP = 0
        }
        file.Write(PlayerFile, util.TableToJSON(data, true))
    end
end
hook.Add("PlayerInitialSpawn", "LoadPlayerData", LoadPlayerData)

hook.Add("PlayerSpawn", "TEST_SPAWN_HOOK", function(ply)
    ply:SetLevel(ply:GetLevel() + 5)
    ply:SetXP(ply:GetXP() + 5)
end)
