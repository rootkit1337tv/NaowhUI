local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

local function ImportBigWigs(addon)
    BigWigsAPI.RegisterProfile(NUI.title, NUI.BigWigs, "Naowh", function(callback)
		if not callback then

			return
		end

		SE.SetupComplete(addon)
	end)
end

function SE.BigWigs(import, addon)
	local BigWigs3DB = BigWigs3DB
	local database

    if import then
        ImportBigWigs(addon)

        return
    end

    if not SE.IsProfileExisting(BigWigs3DB) then
        SE.RemoveEntry(addon)

        return
    end

	database = LibStub("AceDB-3.0"):New(BigWigs3DB)

	database:SetProfile("Naowh")
end