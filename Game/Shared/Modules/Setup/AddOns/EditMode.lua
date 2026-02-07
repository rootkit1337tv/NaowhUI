local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

local profileName = "NaowhUI"

local function presetCount()
    if Enum and Enum.EditModePresetLayoutsMeta and Enum.EditModePresetLayoutsMeta.NumValues then
        return Enum.EditModePresetLayoutsMeta.NumValues
    end

    return 2
end

local function findEditModeProfile(name)
    if not C_EditMode or not C_EditMode.GetLayouts then return nil end

    local layouts = C_EditMode.GetLayouts()

    if not layouts or not layouts.layouts then return nil end

    local presets = presetCount()

    for i, layout in ipairs(layouts.layouts) do
        if layout.layoutName == name then
            return presets + i
        end
    end

    return nil
end

function SE.ApplyEditModeProfile(doImport)
    if InCombatLockdown and InCombatLockdown() then
        NUI:Print("Cannot apply Edit Mode in combat")

        return false
    end

    if not (C_EditMode and C_EditMode.ConvertStringToLayoutInfo and C_EditMode.GetLayouts and C_EditMode.SaveLayouts and C_EditMode.SetActiveLayout) then
        NUI:Print("C_EditMode API not available")

        return false
    end

    local existingIdx = findEditModeProfile(profileName)

    if existingIdx then
        local ok, err = pcall(C_EditMode.SetActiveLayout, existingIdx)

        if not ok then
            NUI:Print("SetActiveLayout failed: " .. tostring(err))

            return false
        end

        return true
    end

    if not doImport then
        return false
    end

    local D = NUI:GetModule("Data")
    local profileString = D.Editmode

    if not profileString then
        NUI:Print("No EditMode profile data found")

        return false
    end

    local info = C_EditMode.ConvertStringToLayoutInfo(profileString)

    if not info then
        NUI:Print("Edit Mode string did not parse")

        return false
    end

    if not info.systems or #info.systems == 0 then
        NUI:Print("Edit Mode string parsed but contains no systems")

        return false
    end

    info.layoutName = profileName

    if Enum and Enum.EditModeLayoutType then
        info.layoutType = Enum.EditModeLayoutType.Account
    end

    local save = C_EditMode.GetLayouts()

    if type(save) ~= "table" then
        NUI:Print("C_EditMode.GetLayouts returned invalid data")

        return false
    end

    save.layouts = save.layouts or {}

    for i = #save.layouts, 1, -1 do
        local l = save.layouts[i]

        if l and l.layoutName == profileName then
            table.remove(save.layouts, i)
        end
    end

    table.insert(save.layouts, info)

    local idx = presetCount() + #save.layouts
    save.activeLayout = idx

    local ok, err = pcall(C_EditMode.SaveLayouts, save)

    if not ok then
        NUI:Print("SaveLayouts failed: " .. tostring(err))

        return false
    end

    ok, err = pcall(C_EditMode.SetActiveLayout, idx)

    if not ok then
        NUI:Print("SetActiveLayout failed: " .. tostring(err))

        return false
    end

    return true
end

function SE.EditModeProfileExists()
    return findEditModeProfile(profileName) ~= nil
end

function SE.EditMode(addon, import, resolution)
    if import then
        if SE.ApplyEditModeProfile(true) then
            SE.CompleteSetup(addon)

            NUI.db.char.loaded = true
            NUI.db.global.version = NUI.version
        end
    else
        SE.ApplyEditModeProfile(false)
    end
end
