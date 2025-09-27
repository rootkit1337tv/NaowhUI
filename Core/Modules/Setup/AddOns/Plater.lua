local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

local function ImportPlater(addon)
	local Plater = Plater
	local data = Plater.DecompressData(NUI.Plater, "print")

	if not SE:IsHooked(Plater, "OnProfileCreated") then
		SE:RawHook(Plater, "OnProfileCreated", function()
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

	NUI.db.char.loaded = true
	NUI.db.global.version = NUI.version
end

function SE.Plater(import, addon)
	local Plater = Plater

	if not SE:IsHooked(Plater, "RefreshConfigProfileChanged") then
		SE:RawHook(Plater, "RefreshConfigProfileChanged", function() Plater:RefreshConfig() end)
	end

	if import then
		ImportPlater(addon)

		return
	end

	if not SE.IsProfileExisting(PlaterDB) then
		SE.UpdateDatabase(addon)

		return
	end

	Plater.db:SetProfile("Naowh")
end