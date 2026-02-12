local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

function SE:Setup(addon, ...)
    local setup = self[addon]

    setup(addon, ...)
end

function SE.CompleteSetup(addon)
    local PluginInstallStepComplete = PluginInstallStepComplete

    if PluginInstallStepComplete then
        if PluginInstallStepComplete:IsShown() then
            PluginInstallStepComplete:Hide()
        end

        PluginInstallStepComplete.message = "Success"

        PluginInstallStepComplete:Show()
    end

    NUI.db.global.profiles = NUI.db.global.profiles or {}
    NUI.db.global.profiles[addon] = true
end

function SE.IsProfileExisting(table)
    local db = LibStub("AceDB-3.0"):New(table)
    local profiles = db:GetProfiles()

    for i = 1, #profiles do
        if profiles[i] == "Naowh" then

            return true
        end
    end
end

function SE.RemoveFromDatabase(addon)
    NUI.db.global.profiles[addon] = nil

    if NUI.db.global.profiles and #NUI.db.global.profiles == 0 then
        for k in pairs(NUI.db.char) do
            k = nil
        end

        NUI.db.global.profiles = nil
    end
end