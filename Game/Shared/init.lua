local _G = _G

local C_AddOns_GetAddOnEnableState = C_AddOns.GetAddOnEnableState

local AceAddon = _G.LibStub("AceAddon-3.0")

local AddOnName, Engine = ...
local NUI = AceAddon:NewAddon(AddOnName, "AceConsole-3.0")

Engine[1] = NUI
_G.NaowhUI = Engine

NUI.Data = NUI:NewModule("Data")
NUI.Installer = NUI:NewModule("Installer")
NUI.Setup = NUI:NewModule("Setup", "AceHook-3.0")

do
    NUI.Mists = WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC
    NUI.Retail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
end

do
    function NUI:AddonCompartmentFunc()
        NUI:RunInstaller()
    end

    _G.NaowhUI_AddonCompartmentFunc = NUI.AddonCompartmentFunc
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

    if self.db.global.version and self.db.global.version <= 20260131 then
        self.db:ResetDB()
    end

    self:RegisterChatCommand("nui", "HandleChatCommand")
    _G.LibStub("AceConfig-3.0"):RegisterOptionsTable("NaowhUI", self.options)

    self.category = select(2, _G.LibStub("AceConfigDialog-3.0"):AddToBlizOptions("NaowhUI"))
end


function NUI:SecureSlashCommand()
    local function NUISlashHandler(msg, editBox)
        NUI:HandleChatCommand(msg)
    end

    local function CleanupConflictingCommands()
        for name, handler in pairs(_G.SlashCmdList) do
            if name ~= "NUI" then
                for i = 1, 10 do
                    local slashVar = "SLASH_" .. name .. i
                    local slashCmd = _G[slashVar]
                    if slashCmd and slashCmd:lower() == "/nui" then
                        _G[slashVar] = nil
                    end
                end
            end
        end

        _G.SLASH_NUI1 = "/nui"
        _G.SlashCmdList["NUI"] = NUISlashHandler

        if hash_SlashCmdList then
            hash_SlashCmdList["/nui"] = "NUI"
        end
    end

    CleanupConflictingCommands()

    local watchFrame = CreateFrame("Frame")
    watchFrame:RegisterEvent("PLAYER_LOGIN")
    watchFrame:RegisterEvent("ADDON_LOADED")
    watchFrame:SetScript("OnEvent", function(self, event, addon)
        CleanupConflictingCommands()
    end)

    C_Timer.After(5, CleanupConflictingCommands)
end