local NUI = unpack(NaowhUI)

local ipairs = ipairs
local format = format

local DisableAddOn = C_AddOns.DisableAddOn

NUI.title = format("|cff0091edNaowh|r|cffffa300UI|r")
NUI.version = NUI:ParseVersionString("NaowhUI")
NUI.myname = UnitName("player")

NUI.reload = false

function NUI:Initialize()
	local Details = Details
	local E
	local addons = {
		"NaowhUI_Installer",
		"SharedMedia_Naowh"
	}

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
			local CurrentHealth, MaxHealth = UnitHealth(unit), UnitHealthMax(unit)
			local HealthPercent = CurrentHealth / MaxHealth * 100
		
			return E:GetFormattedText("PERCENT", CurrentHealth, MaxHealth, HealthPercent == 100 and 0 or HealthPercent < 10 and 2 or 1, nil)
		end)

		E.global.ignoreIncompatible = true
	end

	if not InCombatLockdown() and not self:IsAddOnEnabled("QuaziiUI") and not self.db.char.installed and self.db.global.profiles then
		self.Notification("Do you wish to load your selected NaowhUI profiles onto this character?", function() self:LoadProfiles() end, function() self.db.char.installed = true end)
	end

	for _, v in ipairs(addons) do
		if self:IsAddOnEnabled(v) then
			DisableAddOn(v)
		end
	end
end