local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

local C_AddOns, ReloadUI = C_AddOns, ReloadUI

local function AreAddOnsEnabled()
	local addons = {
		["BigWigs"] = true,
		["Details"] = true,
		["HidingBar"] = true,
		["NameplateAuras"] = true,
		["OmniCD"] = true,
		["Plater"] = true,
		["WarpDeplete"] = true
	}

	if NUI.TBC or NUI.Mists or NUI.Classic then
		addons.NameplateAuras = nil
		addons.OmniCD = nil
		addons.WarpDeplete = nil
	end

	for k in pairs(addons) do
		if NUI:IsAddOnEnabled(k) then

			return true
		end
	end
end

NUI.options = {
	name = "NaowhUI",
	type = "group",
	args = {
		addon_profiles = {
			name = "AddOn Profiles",
			order = 1,
			hidden = function()
				if InCombatLockdown() or NUI:IsAddOnEnabled("QuaziiUI") or not C_AddOns.DoesAddOnExist("NaowhUI_Data") or NUI:IsAddOnEnabled("ElvUI") or not AreAddOnsEnabled() then

					return true
				end
			end,
			type = "group",
			args = {
				bigwigs = {
					name = "BigWigs",
					desc = "Setup BigWigs",
					hidden = function()
						if not NUI:IsAddOnEnabled("AddOnSkins") or not NUI:IsAddOnEnabled("BigWigs") then

							return true
						end
					end,
					type = "execute",
					func = function() SE:Setup("BigWigs", true) end
				},
				details = {
					name = "Details",
					desc = "Setup Details",
					hidden = function()
						if not NUI:IsAddOnEnabled("Details") then

							return true
						end
					end,
					type = "execute",
					func = function() SE:Setup("Details", true) end
				},
				hidingbar = {
					name = "HidingBar",
					desc = "Setup HidingBar",
					hidden = function()
						if not NUI:IsAddOnEnabled("HidingBar") then

							return true
						end
					end,
					type = "execute",
					func = function()
						SE:Setup("HidingBar", true)

						ReloadUI()
					end
				},
				nameplateauras = {
					name = "NameplateAuras",
					desc = "Setup NameplateAuras",
					hidden = function()
						if NUI.TBC or NUI.Mists or NUI.Classic or not NUI:IsAddOnEnabled("NameplateAuras") then

							return true
						end
					end,
					type = "execute",
					func = function()
						SE:Setup("NameplateAuras", true)

						ReloadUI()
					end
				},
				omnicd = {
					name = "OmniCD",
					desc = "Setup OmniCD",
					hidden = function()
						if NUI.TBC or NUI.Mists or NUI.Classic or not NUI:IsAddOnEnabled("OmniCD") then

							return true
						end
					end,
					type = "execute",
					func = function()
						SE:Setup("OmniCD", true)

						ReloadUI()
					end
				},
				plater = {
					name = "Plater",
					desc = "Setup Plater",
					hidden = function()
						if not NUI:IsAddOnEnabled("Plater") then

							return true
						end
					end,
					type = "execute",
					func = function()
						SE:Setup("Plater", true)

						ReloadUI()
					end
				},
				warpdeplete = {
					name = "WarpDeplete",
					desc = "Setup WarpDeplete",
					hidden = function()
						if NUI.TBC or NUI.Mists or NUI.Classic or not NUI:IsAddOnEnabled("WarpDeplete") then

							return true
						end
					end,
					type = "execute",
					func = function() SE:Setup("WarpDeplete", true) end
				}
			}
		},
		general_weakauras = {
			name = "General WeakAuras",
			order = 2,
			hidden = function()
				if InCombatLockdown() or NUI:IsAddOnEnabled("QuaziiUI") or not C_AddOns.DoesAddOnExist("NaowhUI_Data") or NUI:IsAddOnEnabled("ElvUI") or not NUI:IsAddOnEnabled("WeakAuras") then

					return true
				end
			end,
			type = "group",
			args = {
				core = {
					name = "Core",
					desc = "Import the Core WeakAura",
					type = "execute",
					func = function() SE:Setup("WeakAuras", nil, nil, nil, nil, "core") end
				},
				generic = {
					name = "M+ Generic",
					desc = "Import the M+ Generic WeakAura",
					hidden = function()
						if NUI.TBC or NUI.Mists or NUI.Classic then

							return true
						end
					end,
					type = "execute",
					func = function() SE:Setup("WeakAuras", nil, nil, nil, nil, "generic") end
				},
				season_3 = {
					name = "M+ Season 3",
					desc = "Import the M+ Season 3 WeakAura",
					hidden = function()
						if NUI.TBC or NUI.Mists or NUI.Classic then

							return true
						end
					end,
					type = "execute",
					func = function() SE:Setup("WeakAuras", nil, nil, nil, nil, "Season3") end
				},
				raid = {
					name = "Raid",
					desc = "Import the Raid WeakAura",
					hidden = function()
						if NUI.TBC or NUI.Mists or NUI.Classic then

							return true
						end
					end,
					type = "execute",
					func = function() SE:Setup("WeakAuras", nil, nil, nil, nil, "raid") end
				}
			}
		},
		class_weakauras = {
			name = "Class WeakAuras",
			order = 3,
			hidden = function()
				if InCombatLockdown() or NUI:IsAddOnEnabled("QuaziiUI") or not C_AddOns.DoesAddOnExist("NaowhUI_Data") or not NUI:IsAddOnEnabled("WeakAuras") then

					return true
				end
			end,
			type = "group",
			args = {
				death_knight = {
					name = "Death Knight",
					desc = "Import the Death Knight Class WeakAura",
					hidden = function()
						if NUI.TBC or NUI.Classic then

							return true
						end
					end,
					type = "execute",
					func = function() SE:Setup("WeakAuras", nil, nil, nil, nil, "DeathKnight") end
				},
				demon_hunter = {
					name = "Demon Hunter",
					desc = "Import the Demon Hunter Class WeakAura",
					hidden = function()
						if NUI.TBC or NUI.Mists or NUI.Classic then

							return true
						end
					end,
					type = "execute",
					func = function() SE:Setup("WeakAuras", nil, nil, nil, nil, "DemonHunter") end
				},
				druid = {
					name = "Druid",
					desc = "Import the Druid Class WeakAura",
					type = "execute",
					func = function() SE:Setup("WeakAuras", nil, nil, nil, nil, "Druid") end
				},
				evoker = {
					name = "Evoker",
					desc = "Import the Evoker Class WeakAura",
					hidden = function()
						if NUI.TBC or NUI.Mists or NUI.Classic then

							return true
						end
					end,
					type = "execute",
					func = function() SE:Setup("WeakAuras", nil, nil, nil, nil, "Evoker") end
				},
				hunter = {
					name = "Hunter",
					desc = "Import the Hunter Class WeakAura",
					type = "execute",
					func = function() SE:Setup("WeakAuras", nil, nil, nil, nil, "Hunter") end
				},
				mage = {
					name = "Mage",
					desc = "Import the Mage Class WeakAura",
					type = "execute",
					func = function() SE:Setup("WeakAuras", nil, nil, nil, nil, "Mage") end
				},
				monk = {
					name = "Monk",
					desc = "Import the Monk Class WeakAura",
					hidden = function()
						if NUI.TBC or NUI.Classic then

							return true
						end
					end,
					type = "execute",
					func = function() SE:Setup("WeakAuras", nil, nil, nil, nil, "Monk") end
				},
				paladin = {
					name = "Paladin",
					desc = "Import the Paladin Class WeakAura",
					type = "execute",
					func = function() SE:Setup("WeakAuras", nil, nil, nil, nil, "Paladin") end
				},
				priest = {
					name = "Priest",
					desc = "Import the Priest Class WeakAura",
					type = "execute",
					func = function() SE:Setup("WeakAuras", nil, nil, nil, nil, "Priest") end
				},
				rogue = {
					name = "Rogue",
					desc = "Import the Rogue Class WeakAura",
					type = "execute",
					func = function() SE:Setup("WeakAuras", nil, nil, nil, nil, "Rogue") end
				},
				shaman = {
					name = "Shaman",
					desc = "Import the Shaman Class WeakAura",
					type = "execute",
					func = function() SE:Setup("WeakAuras", nil, nil, nil, nil, "Shaman") end
				},
				warlock = {
					name = "Warlock",
					desc = "Import the Warlock Class WeakAura",
					type = "execute",
					func = function() SE:Setup("WeakAuras", nil, nil, nil, nil, "Warlock") end
				},
				warrior = {
					name = "Warrior",
					desc = "Import the Warrior Class WeakAura",
					type = "execute",
					func = function() SE:Setup("WeakAuras", nil, nil, nil, nil, "Warrior") end
				}
			}
		},
		advanced = {
			name = "Advanced",
			order = -1,
			type = "group",
			args = {
				load_profiles = {
					name = "Load Profiles",
					desc = "Load your installed profiles onto this character",
					hidden = function()
						if InCombatLockdown() or NUI:IsAddOnEnabled("QuaziiUI") or not C_AddOns.DoesAddOnExist("NaowhUI_Data") or NUI:IsAddOnEnabled("ElvUI") or not NUI.db.global.profiles or not AreAddOnsEnabled() then

							return true
						end
					end,
					type = "execute",
					func = function() NUI:LoadProfiles() end
				},
				update_profiles = {
					name = "Update Profiles",
					desc = "Update your installed profiles to their latest revision",
					hidden = function()
						--if InCombatLockdown() or NUI:IsAddOnEnabled("QuaziiUI") or not C_AddOns.DoesAddOnExist("NaowhUI_Data") or NUI:IsAddOnEnabled("ElvUI") or not NUI:AreUpdatesAvailable() then

							return true
						--end
					end,
					type = "execute",
					func = function() NUI:UpdateProfiles() end
				},
				print_version = {
					name = "Print Version",
					desc = "Print the current versions of NaowhUI and NaowhUI_Data",
					type = "execute",
					func = function()
						local DataVersion = C_AddOns.GetAddOnMetadata("NaowhUI_Data", "Version") or "Missing"

						NUI:Print(format("%s %s", "AddOn version:", tostring(NUI.version)))
						NUI:Print(format("%s %s", "Data version:", DataVersion))
					end
				}
			}
		}
	}
}