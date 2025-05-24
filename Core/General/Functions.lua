local NUI = unpack(NaowhUI)

local ReloadUI = ReloadUI
local C_AddOns = C_AddOns

local function SetStrata(frame, strata)
	frame:SetFrameStrata(strata)
end

function NUI:OpenToCategory()
	local PluginInstallFrame = PluginInstallFrame
	local Category = "NaowhUI"

	if PluginInstallFrame and PluginInstallFrame:IsShown() then
		SetStrata(PluginInstallFrame, "MEDIUM")
	end

	Settings.OpenToCategory(Category)
end

function NUI:RunInstaller()
	if self:IsAddOnEnabled("QuaziiUI") then
		self:Notification("You currently have the QuaziiUI AddOn enabled. This AddOn is not compatible with NaowhUI. Do you want to disable it?", function()
			C_AddOns.DisableAddOn("QuaziiUI")

			ReloadUI()
		end, function() return end)

		return
	end

	if not self:IsAddOnEnabled("NaowhUI_Data") then
		return
	end

	if self:IsAddOnEnabled("ElvUI") then
		local E = unpack(ElvUI)
		local I = self:GetModule("Installer")

		E:GetModule("PluginInstaller"):Queue(I.Installer)

		return
	end

	self:OpenToCategory()
end

function NUI:Notification(string, AcceptFunction, DeclineFunction)
	local Frame = "Notification"

	StaticPopupDialogs[Frame] = {
		text = string,
		button1 = "Yes",
		button2 = "No",
		OnAccept = AcceptFunction,
		OnCancel = DeclineFunction,
	}
	StaticPopup_Show(Frame)
end

function NUI:LoadProfiles()
	local SE = self:GetModule("Setup")

	for k in pairs(self.db.global.profiles) do
		if self:IsAddOnEnabled(k) then
			SE:Setup(k)
		end
	end

	self.db.char.installed = true

	ReloadUI()
end

function NUI:LoadData()
	local AddOn = "NaowhUI_Data"

	if C_AddOns.LoadAddOn(AddOn) then
		return
	end

	if not self:IsAddOnEnabled(AddOn) then
		C_AddOns.EnableAddOn(AddOn)
	end

	C_AddOns.LoadAddOn(AddOn)
end

function NUI:ImportWeakAura(frame, strata, weakaura)
	if frame and strata then
		SetStrata(frame, strata)
	end

	WeakAuras.Import(weakaura)
end

function NUI:InstallComplete(reload)
	if GetCVarBool("Sound_EnableMusic") then
		StopMusic()
	end

	self.db.char.installed = true
	self.db.global.version = self.version

	if reload then
		ReloadUI()
	end
end