local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

function SE:Setup(...)
	local addon, import, scale, frame, strata, weakaura = ...
	local setup = self[addon]

	NUI:LoadData()
	setup(import, addon, scale, frame, strata, weakaura)
end

function SE.SetupComplete(addon)
	local PluginInstallStepComplete = PluginInstallStepComplete

	if PluginInstallStepComplete then
		if PluginInstallStepComplete:IsShown() then
			PluginInstallStepComplete:Hide()
		end

		PluginInstallStepComplete.message = "Success"

		PluginInstallStepComplete:Show()
	end

	if not NUI.db.global.profiles then
		NUI.db.global.profiles = {}
	end

	NUI.db.global.profiles[addon] = NUI.version
end

function SE.IsProfileExisting(db)
	local database = LibStub("AceDB-3.0"):New(db)
	local profiles = database:GetProfiles()

	for i = 1, #profiles do
		if profiles[i] == "Naowh" then

			return true
		end
	end
end

function SE.UpdateDatabase(addon)
	NUI.db.global.profiles[addon] = nil

	if NUI.db.global.profiles and #NUI.db.global.profiles == 0 then
		for k in pairs(NUI.db.char) do
			k = nil
		end

		NUI.db.global.profiles = nil
	end
end