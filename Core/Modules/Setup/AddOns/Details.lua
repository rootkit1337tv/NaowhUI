local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

function SE.Details(import, addon)
	local profile
	local automation
    local Details = Details

    if import then
		profile = DetailsFramework:Trim(NUI.Details)
		automation = Details:DecompressData(profile, "print")

		Details:EraseProfile("Naowh")
		Details:ImportProfile(NUI.Details, "Naowh", false, false, true)

		for i, v in Details:ListInstances() do
			DetailsFramework.table.copy(v.hide_on_context, automation.profile.instances[i].hide_on_context)
		end

		SE.SetupComplete(addon)

		return
    end

    if not Details:GetProfile("Naowh") then
        SE.RemoveEntry(addon)

        return
    end

	Details:ApplyProfile("Naowh")
end