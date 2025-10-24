local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

function SE.Details(import, addon)
	local profile, automation
	local Details = Details
	local AS

	if import then
		profile = DetailsFramework:Trim(NUI.Details)
		automation = Details:DecompressData(profile, "print")

		if NUI:IsAddOnEnabled("AddOnSkins") then
			AS = unpack(AddOnSkins)

			AS.db.EmbedSystem = nil
			AS.db.EmbedSystemDual = nil
			AS.db.EmbedOoC = nil
		end

		Details:EraseProfile("Naowh")
		Details:ImportProfile(NUI.Details, "Naowh", false, false, true)

		for i, v in Details:ListInstances() do
			DetailsFramework.table.copy(v.hide_on_context, automation.profile.instances[i].hide_on_context)
		end

		SE.SetupComplete(addon)

		NUI.db.char.loaded = true
		NUI.db.global.version = NUI.version

		return
	end

	if not Details:GetProfile("Naowh") then
		SE.UpdateDatabase(addon)

		return
	end

	Details:ApplyProfile("Naowh")
end