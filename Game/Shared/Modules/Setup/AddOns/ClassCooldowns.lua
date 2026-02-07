local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")
local D = NUI:GetModule("Data")

local function getClassKey()
    local _, class = UnitClass("player")
    return class and strlower(class)
end

function SE.ImportClassCooldowns()
    if InCombatLockdown and InCombatLockdown() then return false end
    if not CooldownViewerSettings then return false end
    if C_CooldownViewer and C_CooldownViewer.IsCooldownViewerAvailable and not C_CooldownViewer.IsCooldownViewerAvailable() then
        return false
    end

    local classData = D[getClassKey()]
    if not classData then return false end

    local layoutManager = CooldownViewerSettings:GetLayoutManager()
    if not layoutManager then return false end

    local ok, layoutIDs = pcall(layoutManager.CreateLayoutsFromSerializedData, layoutManager, classData)
    if not ok or not layoutIDs or #layoutIDs == 0 then return false end

    layoutManager:SetActiveLayoutByID(layoutIDs[1])
    layoutManager:SaveLayouts()

    if StaticPopup1Button2Text and StaticPopup1Button2Text:GetText() == "Ignore" then
        StaticPopup1Button2:Click()
    end

    return true
end

function SE.ClassCooldownDataExists()
    return D[getClassKey()] ~= nil
end

function SE.ClassCooldowns(addon, import)
    if import then
        SE.ApplyEditModeProfile(true)
        if SE.ImportClassCooldowns() then
            SE.CompleteSetup(addon)
            NUI.db.char.loaded = true
            NUI.db.global.version = NUI.version
        end
    end
end

function SE.GetPlayerClassDisplayName()
    local _, className = UnitClass("player")
    return LOCALIZED_CLASS_NAMES_MALE[className] or className
end
