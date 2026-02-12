local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

function SE.WarpDeplete(addon, import, resolution)
    local D = NUI:GetModule("Data")

    local WarpDepleteDB = WarpDepleteDB
    local profile = "warpdeplete" .. (resolution or "")

    if import then
        WarpDepleteDB.profiles.Naowh = D[profile]

        SE.CompleteSetup(addon)

        NUI.db.char.loaded = true
        NUI.db.global.version = NUI.version
    end

    if not SE.IsProfileExisting(WarpDepleteDB) then
        SE.RemoveFromDatabase(addon)

        return
    end

    WarpDeplete.db:SetProfile("Naowh")
end