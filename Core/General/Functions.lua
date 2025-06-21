local NUI = unpack(NaowhUI)

local C_AddOns, ReloadUI = C_AddOns, ReloadUI

local Commands = {}

function NUI.Notification(string, AcceptFunction, DeclineFunction)
	StaticPopupDialogs["Notification"] = {
		text = string,
		button1 = "Yes",
		button2 = "No",
		OnAccept = AcceptFunction,
		OnCancel = DeclineFunction,
	}
	StaticPopup_Show("Notification")
end

function NUI.SetFrameStrata(frame, strata)
	frame:SetFrameStrata(strata)
end

function NUI:OpenToCategory()
	local PluginInstallFrame = PluginInstallFrame

	if PluginInstallFrame and PluginInstallFrame:IsShown() then
		self.SetFrameStrata(PluginInstallFrame, "MEDIUM")
	end

	Settings.OpenToCategory("NaowhUI")
end

function NUI:RunInstaller()
	local E
	local I = self:GetModule("Installer")

	if InCombatLockdown() then
		self:Print("This functionality is not available in combat.")

		return
	end

	if not C_AddOns.DoesAddOnExist("NaowhUI_Data") then
		self:Print("You are missing the NaowhUI_Data AddOn. Please install it to unlock this functionality.")

		return
	end

	if self:IsAddOnEnabled("QuaziiUI") then
		self.Notification("This functionality is locked because the QuaziiUI AddOn is enabled. Do you wish to disable it?", function()
			C_AddOns.DisableAddOn("QuaziiUI")
		
			ReloadUI()
		end)

		return
	end

	if self:IsAddOnEnabled("ElvUI") then
		E = unpack(ElvUI)

		E:GetModule("PluginInstaller"):Queue(I.installer)

		return
	end

	self:OpenToCategory()
end

function Commands.install()
	NUI:RunInstaller()
end

function NUI:HandleChatCommand(input)
	local command = Commands[input]

	if not command then
		self:Print("The command" .. " " .. "'" .. input .. "'" .. " " .. "does not exist.")

		return
	end

	command()
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