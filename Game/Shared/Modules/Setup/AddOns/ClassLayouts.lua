local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

local C_EditMode, Enum = C_EditMode, Enum

local function GetClassKey()
    local _, class = UnitClass("player")

    return class and strlower(class)
end

local function GetSpecName()
    local specIndex = GetSpecialization()

    if specIndex then
        local _, specName = GetSpecializationInfo(specIndex)

        return specName
    end
end

local function IsEditModeLayoutExisting()
    local layouts = C_EditMode.GetLayouts()

    for i, v in ipairs(layouts.layouts) do
        if v.layoutName == "Naowh" then

            return Enum.EditModePresetLayoutsMeta.NumValues + i
        end
    end
end

local function ImportClassCooldowns()
    local D = NUI:GetModule("Data")

    if InCombatLockdown() then return false end
    if not CooldownViewerSettings then return false end

    local classData = D[GetClassKey()]
    if not classData then return false end

    local layoutManager = CooldownViewerSettings:GetLayoutManager()
    if not layoutManager then return false end

    local ok, layoutIDs = pcall(layoutManager.CreateLayoutsFromSerializedData, layoutManager, classData)
    if not ok or not layoutIDs or #layoutIDs == 0 then return false end

    local specName = GetSpecName()
    local activeLayoutID = layoutIDs[1]

    if specName and layoutManager.layouts then
        for _, layoutID in ipairs(layoutIDs) do
            local layout = layoutManager.layouts[layoutID]

            if layout and layout.name and layout.name:find(specName) then
                activeLayoutID = layoutID
                break
            end
        end
    end

    layoutManager:SetActiveLayoutByID(activeLayoutID)
    layoutManager:SaveLayouts()

    if StaticPopup1Button2Text and StaticPopup1Button2Text:GetText() == "Ignore" then
        StaticPopup1Button2:Click()
    end

    return true
end

function SE.ClassCooldowns(addon, import)
    local layout

    if import then
        if ImportClassCooldowns() then
            SE.CompleteSetup(addon)

            NUI.db.char.loaded = true
            NUI.db.global.version = NUI.version
        end
    end

    layout = IsEditModeLayoutExisting()

    if not layout then
        return
    end

    C_EditMode.SetActiveLayout(layout)
end

function SE.GetPlayerClassDisplayName()
    local _, className = UnitClass("player")

    return LOCALIZED_CLASS_NAMES_MALE[className] or className
end