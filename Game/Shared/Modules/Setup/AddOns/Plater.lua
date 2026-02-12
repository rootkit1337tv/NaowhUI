local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

local function ImportPlater(addon, resolution)
    local D = NUI:GetModule("Data")

    local Plater = Plater
    local profile = "plater" .. (resolution or "")
    local data = Plater.DecompressData(D[profile], "print")

    if not SE:IsHooked(Plater, "OnProfileCreated") then
        SE:RawHook(Plater, "OnProfileCreated", function()
            C_Timer.After (.5, function()
                Plater.ImportScriptsFromLibrary()
                Plater.ApplyPatches()
                Plater.CompileAllScripts("script")
                Plater.CompileAllScripts("hook")
                
                Plater:RefreshConfig()
                Plater.UpdatePlateClickSpace()
            end)
        end)
    end

    Plater.ImportAndSwitchProfile("Naowh", data, false, false, true, true)

    SE.CompleteSetup(addon)

    NUI.db.char.loaded = true
    NUI.db.global.version = NUI.version
end

function SE.Plater(addon, import, resolution)
    local Plater = Plater

    if not SE:IsHooked(Plater, "RefreshConfigProfileChanged") then
        SE:RawHook(Plater, "RefreshConfigProfileChanged", function() Plater:RefreshConfig() end)
    end

    if import then
        ImportPlater(addon, resolution)

        return
    end

    if not SE.IsProfileExisting(PlaterDB) then
        SE.RemoveFromDatabase(addon)

        return
    end

    Plater.db:SetProfile("Naowh")
end