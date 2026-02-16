local NUI = unpack(NaowhUI)

local chatCommands = {}

local function ValidateToken(token, silent)
    local C_EncodingUtil = C_EncodingUtil

    local decodedToken, decompressedToken, str1, str2, time

    if not token then

        return
    end

    if not strmatch(token, "^!NUI!") then
        NUI:Print("This token is invalid. Please generate a new one")

        return
    end

    decodedToken = C_EncodingUtil.DecodeBase64(gsub(token, "^!NUI!",""))
    decompressedToken = C_EncodingUtil.DecompressString(decodedToken)
    str1, str2 = strsplit("-", decompressedToken)
    time = GetServerTime()

    if #str1 > #str2 and time - str2 < 3600 then

        return true
    end

    if not silent then
        NUI:Print("This token is invalid. Please generate a new one")
    end
end

local function CreateUnlocker(silent)
    local AceGUI = LibStub("AceGUI-3.0")
    local frame, editbox, button

    frame = AceGUI:Create("Frame")
    frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
    frame:SetHeight(115)
    frame:SetLayout(nil)
    frame:SetStatusText(format("%s %.2f", NUI.title, NUI.version))
    frame:SetTitle("NaowhUI Unlocker")
    frame:SetWidth(500)

    -- Adjust status text position
    frame.statustext:ClearAllPoints()
    frame.statustext:SetPoint("BOTTOMLEFT", 2, 4)

    -- Label
    local label = frame.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("TOPLEFT", frame.frame, "TOPLEFT", 12, -30)
    label:SetText("Paste your token from naowhui.howli.gg below:")
    label:SetTextColor(1, 0.82, 0)

    -- EditBox (native frame for full control)
    local editbox = CreateFrame("EditBox", nil, frame.frame, "InputBoxTemplate")
    editbox:SetSize(345, 20)
    editbox:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 10, -10)
    editbox:SetAutoFocus(false)

    -- Validate button (anchored from right to align with Close)
    local validateBtn = CreateFrame("Button", nil, frame.frame, "UIPanelButtonTemplate")
    validateBtn:SetSize(100, 20)
    validateBtn:SetPoint("TOPRIGHT", frame.frame, "TOPRIGHT", -27, -54)
    validateBtn:SetText("Validate")
    validateBtn:SetScript("OnClick", function()
        local token = editbox:GetText()

        if #token == 0 then
            NUI:Print("Token not found")
            return
        end

        if ValidateToken(token) then
            frame:Hide()
            NUI.db.global.token = token
            NUI:RunInstaller()
        end
    end)

    -- Get Token button in the status bar area
    local websiteBtn = CreateFrame("Button", nil, frame.frame, "UIPanelButtonTemplate")
    websiteBtn:SetSize(110, 20)
    websiteBtn:SetPoint("BOTTOMRIGHT", frame.frame, "BOTTOMRIGHT", -129, 17)
    websiteBtn:SetText("Get Token")
    websiteBtn:SetFrameLevel(frame.frame:GetFrameLevel() + 10)
    websiteBtn:SetScript("OnClick", function()
        if NUIURLDialog then
            NUIURLDialog:Show()
            return
        end

        local dialog = CreateFrame("Frame", "NUIURLDialog", UIParent, "BackdropTemplate")
        dialog:SetSize(350, 100)
        dialog:SetPoint("CENTER", 0, 150)
        dialog:SetFrameStrata("DIALOG")
        dialog:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8X8",
            edgeFile = "Interface\\Buttons\\WHITE8X8",
            edgeSize = 1,
        })
        dialog:SetBackdropColor(0.1, 0.1, 0.1, 0.9)
        dialog:SetBackdropBorderColor(0, 0, 0, 1)

        local title = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        title:SetPoint("TOP", 0, -8)
        title:SetText("Copy this URL to get your token")
        title:SetTextColor(1, 0.82, 0)

        local editBox = CreateFrame("EditBox", nil, dialog, "InputBoxTemplate")
        editBox:SetSize(300, 20)
        editBox:SetPoint("TOP", title, "BOTTOM", 0, -8)
        editBox:SetText("https://naowhui.howli.gg/")
        editBox:HighlightText()
        editBox:SetFocus()
        editBox:SetScript("OnEscapePressed", function() dialog:Hide() end)

        local closeBtn = CreateFrame("Button", nil, dialog, "UIPanelButtonTemplate")
        closeBtn:SetSize(80, 22)
        closeBtn:SetPoint("BOTTOM", 0, 10)
        closeBtn:SetText(CLOSE)
        closeBtn:SetScript("OnClick", function() dialog:Hide() end)

        if NUI:IsAddOnEnabled("ElvUI") then
            local E = unpack(ElvUI)
            local S = E:GetModule("Skins")

            if S and S.HandleButton then
                S:HandleButton(closeBtn)
            end

            if S and S.HandleEditBox then
                S:HandleEditBox(editBox)
            end
        end

        dialog:Show()
    end)

    -- Skin buttons if ElvUI is available
    if NUI:IsAddOnEnabled("ElvUI") then
        local E = unpack(ElvUI)
        local S = E:GetModule("Skins")

        if S and S.HandleButton then
            S:HandleButton(websiteBtn)
            S:HandleButton(validateBtn)
        end

        if S and S.HandleEditBox then
            S:HandleEditBox(editbox)
        end
    end
end

function NUI:IsTokenValid(silent)
    if ValidateToken(self.db.global.token, silent) then

        return true
    end

    if not silent then
        CreateUnlocker()
    end
end

function NUI.SetFrameStrata(frame, strata)
    frame:SetFrameStrata(strata)
end

function NUI:OpenSettings()
    local PluginInstallFrame = PluginInstallFrame

    if PluginInstallFrame and PluginInstallFrame:IsShown() then
        self.SetFrameStrata(PluginInstallFrame, "MEDIUM")
    end

    Settings.OpenToCategory(self.category)
end

function NUI:RunInstaller()
    local I = NUI:GetModule("Installer")

    local E, PI

    if not self:IsTokenValid() or InCombatLockdown() then

        return
    end

    if self:IsAddOnEnabled("ElvUI") then
        E = unpack(ElvUI)
        PI = E:GetModule("PluginInstaller")

        PI:Queue(I.installer)

        return
    end

    self:OpenSettings()
end

function chatCommands.install()
    NUI:RunInstaller()
end

function NUI:HandleChatCommand(input)
    local command = chatCommands[input]

    if not command then
        self:Print("Command does not exist")

        return
    end

    command()
end

function NUI:LoadProfiles()
    local SE = NUI:GetModule("Setup")

    for k in pairs(self.db.global.profiles) do
        if self:IsAddOnEnabled(k) then
            SE:Setup(k)
        end
    end

    self.db.char.loaded = true

    ReloadUI()
end