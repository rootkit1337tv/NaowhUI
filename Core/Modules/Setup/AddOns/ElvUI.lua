local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

local E

do
	if NUI:IsAddOnEnabled("ElvUI") then
		E = unpack(ElvUI)
	end
end

local function ImportElvUI(addon, scale)
	local D = E.Distributor
	local SC = NUI:GetModule("Scaling")
	local ProfileType, _, data = D:Decode(NUI.ElvUI)

	if NUI.reload then
		NUI.Notification("This action requires you to reload your UI. Do you wish to reload your UI now?", function() ReloadUI() end)

		return
	end

	if not data or type(data) ~= "table" then
		NUI:Print("Decompressing the ElvUI profile failed. Please report this to rootkit1337 (Lukas) in Discord.")

		return
	end

	D:SetImportedProfile(ProfileType, "Naowh", data, true)
	SC:Scale(addon, scale)
	SE.SetupComplete(addon)
	E:SetupCVars(true)
end

function SE.ElvUI(import, addon, scale)
    if import then
		ImportElvUI(addon, scale)
    end

    if not SE.IsProfileExisting(ElvDB) then
        SE.RemoveEntry(addon)

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