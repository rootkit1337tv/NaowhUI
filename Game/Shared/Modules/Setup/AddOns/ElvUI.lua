local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

local E

do
    if NUI:IsAddOnEnabled("ElvUI") then
        E = unpack(ElvUI)
    end
end

local function ImportElvUI(addon, resolution)
    local D = NUI:GetModule("Data")
    local DI = E.Distributor

    local profile = "elvui" .. (resolution or "")
    local profileType, _, data = DI:Decode(D[profile][1])

    if not data or type(data) ~= "table" then
        NUI:Print("An error occured while decompressing the profile. Please report this to rootkit1337 (Lukas) on Discord")

        return
    end

    SE.CompleteSetup(addon)
    DI:SetImportedProfile(profileType, "Naowh", data, true)
    E:SetupCVars(true)

    E.data.global.general.mapAlphaWhenMoving = 0.4
    E.data.global.general.UIScale = D[profile][2]
    E.data.global.general.WorldMapCoordinates.position = "BOTTOM"

    NUI.db.char.loaded = true
    NUI.db.global.version = NUI.version
end

function SE.ElvUI(addon, import, resolution)
    if not import then
        if not SE.IsProfileExisting(ElvDB) then
            SE.RemoveFromDatabase(addon)

            return
        end

        E.data:SetProfile("Naowh")
    else
        ImportElvUI(addon, resolution)
    end

    if NUI.Retail then
        E.private.general.chatBubbleFontSize = 10
        E.private.skins.blizzard.cooldownManager = false
    else
        E.private.general.chatBubbleFontSize = 11
    end

    E.private.general.chatBubbleFont = "Naowh"
    E.private.general.chatBubbleFontOutline = "OUTLINE"
    E.private.general.dmgfont = "GothamNarrowUltra"
    E.private.general.glossTex = "Melli"
    E.private.general.minimap.hideTracking = true
    E.private.general.namefont = "Naowh"
    E.private.general.normTex = "Melli"
    E.private.nameplates.enable = false
end