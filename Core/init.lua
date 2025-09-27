local _G = _G
local tonumber, strmatch = tonumber, strmatch

local C_AddOns_GetAddOnEnableState = C_AddOns.GetAddOnEnableState

local GetAddOnMetadata = C_AddOns.GetAddOnMetadata

local AceAddon = _G.LibStub("AceAddon-3.0")

local AddOnName, Engine = ...
local NUI = AceAddon:NewAddon(AddOnName, "AceConsole-3.0")

Engine[1] = NUI
_G.NaowhUI = Engine

NUI.Installer = NUI:NewModule("Installer")
NUI.Scaling = NUI:NewModule("Scaling")
NUI.Setup = NUI:NewModule("Setup", "AceHook-3.0")

do
	NUI.Mists = WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC
	NUI.Retail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
	NUI.Classic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
end

do
	function NUI:AddonCompartmentFunc()
		NUI:RunInstaller()
	end

	_G.NaowhUI_AddonCompartmentFunc = NUI.AddonCompartmentFunc
end

function NUI:ParseVersionString(addon)
	local version = GetAddOnMetadata(addon, "Version")
	local release, extra = strmatch(version, "^v?([%d.]+)(.*)")
	return tonumber(release), release..extra, extra ~= ""
end

function NUI:GetAddOnEnableState(addon, character)
	return C_AddOns_GetAddOnEnableState(addon, character)
end

function NUI:IsAddOnEnabled(addon)
	return NUI:GetAddOnEnableState(addon, NUI.myname) == 2
end

function NUI:OnEnable()
	NUI:Initialize()
end

function NUI:OnInitialize()
	self.db = _G.LibStub("AceDB-3.0"):New("NaowhDB")

	if self.db.global and (not self.db.global.reset or (self.db.global.version and self.db.global.version <= 20250927)) then
		self.db:ResetDB()

		self.db.global.reset = true
	end

	_G.LibStub("AceConfig-3.0"):RegisterOptionsTable("NaowhUI", self.options)
	_G.LibStub("AceConfigDialog-3.0"):AddToBlizOptions("NaowhUI")
	self:RegisterChatCommand("nui", "HandleChatCommand")
end