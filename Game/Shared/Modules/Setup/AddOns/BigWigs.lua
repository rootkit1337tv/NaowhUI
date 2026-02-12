local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

local function ImportBigWigs(addon, resolution)
    local D = NUI:GetModule("Data")

    local profile = "bigwigs" .. (resolution or "")

    BigWigsAPI.RegisterProfile(NUI.title, D[profile], "Naowh", function(callback)
        if not callback then

            return
        end

        SE.CompleteSetup(addon)

        NUI.db.char.loaded = true
        NUI.db.global.version = NUI.version
    end)
end

function SE.BigWigs(addon, import, resolution)
    local BigWigs3DB = BigWigs3DB
    local db

    if import then
        ImportBigWigs(addon, resolution)

        return
    end

    if not SE.IsProfileExisting(BigWigs3DB) then
        SE.RemoveFromDatabase(addon)

        return
    end

    db = LibStub("AceDB-3.0"):New(BigWigs3DB)

    db:SetProfile("Naowh")
end