local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

function SE.OmniCD(import, addon)
	local OmniCDDB = OmniCDDB
	local database = LibStub("AceDB-3.0"):New(OmniCDDB)

	if import then
		SE.SetupComplete(addon)

		OmniCDDB.profiles.Naowh = NUI.OmniCD

		NUI.db.char.loaded = true
		NUI.db.global.version = NUI.version
	end

	if not SE.IsProfileExisting(OmniCDDB) then
		SE.UpdateDatabase(addon)

		return
	end

	database:SetProfile("Naowh")
end