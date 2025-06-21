local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

local function ImportPlater(addon)
	local Plater = Plater
	local method = "OnProfileCreated"
	local data = Plater.DecompressData(NUI.Plater, "print")

	if not SE:IsHooked(Plater, method) then
		SE:RawHook(Plater, method, function()
			C_Timer.After (.5, function()
				Plater.ImportScriptsFromLibrary()
				Plater.ApplyPatches()
				Plater.CompileAllScripts("script")
				Plater.CompileAllScripts("hook")

				Plater.db.profile.use_ui_parent = true
				Plater.db.profile.ui_parent_scale_tune = 1 / UIParent:GetEffectiveScale()
				
				Plater:RefreshConfig()
				Plater.UpdatePlateClickSpace()
			end)
		end)
	end

	Plater.ImportAndSwitchProfile("Naowh", data, false, false, true)
	SE.SetupComplete(addon)
end

function SE.Plater(import, addon)
    local Plater = Plater
	local method = "RefreshConfigProfileChanged"

	if not SE:IsHooked(Plater, method) then
		SE:RawHook(Plater, method, function() Plater:RefreshConfig() end)
	end

    if import then
		ImportPlater(addon)

		return
    end

    if not SE.IsProfileExisting(PlaterDB) then
        SE.RemoveEntry(addon)

        return
    end

	Plater.db:SetProfile("Naowh")
end