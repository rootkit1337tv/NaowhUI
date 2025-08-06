local NUI = unpack(NaowhUI)
local SC = NUI:GetModule("Scaling")
local SE = NUI:GetModule("Setup")

local E

do
	if NUI:IsAddOnEnabled("ElvUI") then
		E = unpack(ElvUI)
	end
end

local function ImportElvUI(addon, scale)
	local D = E.Distributor
	local ProfileType, _, data = D:Decode(NUI.ElvUI)

	if NUI.reload then
		NUI.Notification("This action requires you to reload your UI. Do you wish to reload your UI?", function() ReloadUI() end)

		return
	end

	if not data or type(data) ~= "table" then
		NUI:Print("Decompressing the ElvUI profile failed. Please report this to rootkit1337 (Lukas) in Discord")

		return
	end

	D:SetImportedProfile(ProfileType, "Naowh", data, true)
	E:SetupCVars(true)
	SC:Scaling(addon, scale)
	SE.SetupComplete(addon)

	NUI.db.char.loaded = true
	NUI.db.global.version = NUI.version
end

function SE.ElvUI(import, addon, scale)
	if import then
		ImportElvUI(addon, scale)
	end

	if not SE.IsProfileExisting(ElvDB) then
		SE.UpdateDatabase(addon)

		return
	end

	if not import then
		E.data:SetProfile("Naowh")
	end

	E.private.general.chatBubbleFont = "Naowh"
	E.private.general.chatBubbleFontOutline = "OUTLINE"
	E.private.general.chatBubbleFontSize = 11
	E.private.general.dmgfont = "GothamNarrowUltra"
	E.private.general.namefont = "Naowh"
	E.private.nameplates.enable = false
end