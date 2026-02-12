local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

local ipairs = ipairs

local HidingBarDB = HidingBarDB

local function ImportHidingBar(addon)
    local D = NUI:GetModule("Data")

    local tinsert = tinsert

    local profiles = {}

    for _, v in ipairs(HidingBarDB.profiles) do
        if v.name ~= "Naowh" then
            v.isDefault = nil

            tinsert(profiles, v)
        end
    end

    tinsert(profiles, D.hidingbar)

    HidingBarDB.profiles = profiles

    SE.CompleteSetup(addon)

    NUI.db.char.loaded = true
    NUI.db.global.version = NUI.version
end

function SE.HidingBar(addon, import)
    if import then
        ImportHidingBar(addon)
    end

    for _, v in ipairs(HidingBarDB.profiles) do
        if v.name == "Naowh" then
            HidingBarDBChar = nil

            return
        end
    end

    SE.RemoveFromDatabase(addon)
end