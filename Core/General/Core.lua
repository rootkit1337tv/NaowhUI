local NUI = unpack(NaowhUI)

local unpack = unpack
local format = format

NUI.title = format("|cff0091edNaowh|r|cffffa300UI|r")
NUI.version = NUI:ParseVersionString("NaowhUI")
NUI.myname = UnitName("player")

NUI.reload = false

function NUI:Initialize()
	local Details = Details
	local E

	if self:IsAddOnEnabled("Details") then
		if Details.is_first_run and #Details.custom == 0 then
			Details:AddDefaultCustomDisplays()
		end

		Details.character_first_run = false
		Details.is_first_run = false
		Details.is_version_first_run = false
	end

	if self:IsAddOnEnabled("ElvUI") then
		E = unpack(ElvUI)

		if E.InstallFrame and E.InstallFrame:IsShown() then
			E.InstallFrame:Hide()

			E.private.install_complete = E.version
		end

		E:AddTag("health:percent-naowh", "UNIT_HEALTH UNIT_MAXHEALTH", function(unit)
			local current, maximum = UnitHealth(unit), UnitHealthMax(unit)
			local percent = current / maximum * 100
		
			return E:GetFormattedText("PERCENT", current, maximum, percent == 100 and 0 or percent < 10 and 2 or 1, nil)
		end)

		E.global.ignoreIncompatible = true
	end

	if not InCombatLockdown() and not self:IsAddOnEnabled("QuaziiUI") and C_AddOns.DoesAddOnExist("NaowhUI_Data") and self.db.global.profiles and not self.db.char.loaded then
		self.Notification("Do you wish to load your installed profiles onto this character?", function() self:LoadProfiles() end, function() self.db.char.loaded = true end)
	end
end