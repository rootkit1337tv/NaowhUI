local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

function SE.WarpDeplete(import, addon)
	local WarpDepleteDB = WarpDepleteDB

	if import then
		SE.SetupComplete(addon)

		WarpDepleteDB.profiles.Naowh = NUI.WarpDeplete

		NUI.db.char.loaded = true
		NUI.db.global.version = NUI.version
	end

	if not SE.IsProfileExisting(WarpDepleteDB) then
		SE.UpdateDatabase(addon)

		return
	end

	WarpDeplete.db:SetProfile("Naowh")
end