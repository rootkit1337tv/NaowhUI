local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

local E

do
    if NUI:IsAddOnEnabled("ElvUI") then
        E = unpack(ElvUI)
    end
end

local function ImportElvUI(addon, resolution)
    local D = NUI:GetModule("Data")
    local DI = E.Distributor

    local profile = "elvui" .. (resolution or "")
    local profileType, _, data = DI:Decode(D[profile][1])

    if not data or type(data) ~= "table" then
        NUI:Print("An error occured while decompressing the profile. Please report this to rootkit1337 (Lukas) on Discord")

        return
    end

    DI:SetImportedProfile(profileType, "Naowh", data, true)
    E:SetupCVars(true)

    E.data.global.general.mapAlphaWhenMoving = 0.4
    E.data.global.general.UIScale = D[profile][2]
    E.data.global.general.WorldMapCoordinates.position = "BOTTOM"

    SE.CompleteSetup(addon)

    NUI.db.char.loaded = true
    NUI.db.global.version = NUI.version
end

function SE.ElvUI(addon, import, resolution)
    if not import then
        if not SE.IsProfileExisting(ElvDB) then
            SE.RemoveFromDatabase(addon)

            return
        end

        E.data:SetProfile("Naowh")
    else
        ImportElvUI(addon, resolution)
    end

    if NUI.Retail then
        if NUI:IsAddOnEnabled("ElvUI_WindTools") then
            E.private.WT.item.extendMerchantPages.enable = true
            E.private.WT.maps.superTracker.distanceText.size = 14
            E.private.WT.maps.minimapButtons.backdrop = false
            E.private.WT.maps.minimapButtons.buttonsPerRow = 7
            E.private.WT.maps.minimapButtons.inverseDirection = true
            E.private.WT.maps.minimapButtons.mouseOver = true
            E.private.WT.maps.minimapButtons.reverseOrder = true
            E.private.WT.maps.minimapButtons.spacing = 3
            E.private.WT.maps.worldMap.scale.size = 1
            E.private.WT.misc.guildNewsItemLevel = false
            E.private.WT.misc.lfgList.line.height = 4
            E.private.WT.misc.lfgList.icon.pack = "LYNUI"
            E.private.WT.misc.lfgList.icon.size = 18
            E.private.WT.misc.lfgList.line.tex = "ElvUI Blank"
            E.private.WT.misc.moveSpeed = true
            E.private.WT.quest.objectiveTracker.cosmeticBar.height = 1
            E.private.WT.quest.objectiveTracker.cosmeticBar.offsetY = -10
            E.private.WT.quest.objectiveTracker.cosmeticBar.width = 252
            E.private.WT.quest.objectiveTracker.enable = true
            E.private.WT.quest.objectiveTracker.infoColor.customColorHighlight.b = 1
            E.private.WT.quest.objectiveTracker.infoColor.customColorHighlight.g = 1
            E.private.WT.quest.objectiveTracker.infoColor.customColorHighlight.r = 1
            E.private.WT.quest.objectiveTracker.infoColor.customColorNormal.b = 1
            E.private.WT.quest.objectiveTracker.infoColor.customColorNormal.g = 1
            E.private.WT.quest.objectiveTracker.infoColor.customColorNormal.r = 1
            E.private.WT.quest.objectiveTracker.title.size = 14
            E.private.WT.quest.objectiveTracker.titleColor.customColorHighlight.b = 0.6196078658103943
            E.private.WT.quest.objectiveTracker.titleColor.customColorHighlight.g = 0.9960784912109375
            E.private.WT.quest.objectiveTracker.titleColor.customColorHighlight.r = 1
            E.private.WT.quest.objectiveTracker.titleColor.customColorNormal.b = 0.2627451121807098
            E.private.WT.quest.objectiveTracker.titleColor.customColorNormal.g = 0.874509871006012
            E.private.WT.quest.objectiveTracker.titleColor.customColorNormal.r = 1
            E.private.WT.skins.addons.worldQuestTab = false
            E.private.WT.skins.bigWigsSkin.emphasizedBar.colorRight.b = 0.4078431725502014
            E.private.WT.skins.bigWigsSkin.emphasizedBar.colorRight.g = 0.4078431725502014
            E.private.WT.skins.bigWigsSkin.emphasizedBar.colorRight.r = 1
            E.private.WT.skins.bigWigsSkin.queueTimer.countDown.name = "Naowh"
            E.private.WT.skins.bigWigsSkin.queueTimer.countDown.offsetY = -2
            E.private.WT.skins.bigWigsSkin.queueTimer.countDown.size = 15
            E.private.WT.skins.blizzard.cooldownViewer = false
            E.private.WT.skins.cooldownViewer.enable = false
            E.private.WT.skins.elvui.auras = false
            E.private.WT.skins.elvui.unitFrames = false
            E.private.WT.skins.ime.label.name = "Naowh"
            E.private.WT.skins.removeParchment = false
            E.private.WT.skins.shadow = false
            E.private.WT.skins.widgets.button.backdrop.color.b = 1
            E.private.WT.skins.widgets.button.backdrop.color.g = 0.6392157077789307
            E.private.WT.skins.widgets.button.backdrop.color.r = 0
            E.private.WT.skins.widgets.button.backdrop.texture = "NaowhLeft"
            E.private.WT.skins.widgets.button.selected.backdropColor.b = 1
            E.private.WT.skins.widgets.button.selected.backdropColor.g = 0.6392157077789307
            E.private.WT.skins.widgets.button.selected.backdropColor.r = 0
            E.private.WT.skins.widgets.button.selected.borderColor.b = 1
            E.private.WT.skins.widgets.button.selected.borderColor.g = 0.6392157077789307
            E.private.WT.skins.widgets.button.selected.borderColor.r = 0
            E.private.WT.skins.widgets.checkBox.color.a = 0.800000011920929
            E.private.WT.skins.widgets.checkBox.color.b = 1
            E.private.WT.skins.widgets.checkBox.color.g = 0.6392157077789307
            E.private.WT.skins.widgets.checkBox.color.r = 0
            E.private.WT.skins.widgets.slider.color.a = 0.800000011920929
            E.private.WT.skins.widgets.slider.color.b = 1
            E.private.WT.skins.widgets.slider.color.g = 0.6392157077789307
            E.private.WT.skins.widgets.slider.color.r = 0
            E.private.WT.skins.widgets.tab.backdrop.color.b = 1
            E.private.WT.skins.widgets.tab.backdrop.color.g = 0.6392157077789307
            E.private.WT.skins.widgets.tab.backdrop.color.r = 0
            E.private.WT.skins.widgets.tab.backdrop.texture = "NaowhLeft"
            E.private.WT.skins.widgets.tab.selected.backdropColor.b = 1
            E.private.WT.skins.widgets.tab.selected.backdropColor.g = 0.6392157077789307
            E.private.WT.skins.widgets.tab.selected.backdropColor.r = 0
            E.private.WT.skins.widgets.tab.selected.borderColor.b = 1
            E.private.WT.skins.widgets.tab.selected.borderColor.g = 0.6392157077789307
            E.private.WT.skins.widgets.tab.selected.borderColor.r = 0
            E.private.WT.skins.widgets.treeGroupButton.backdrop.color.b = 1
            E.private.WT.skins.widgets.treeGroupButton.backdrop.color.g = 0.6392157077789307
            E.private.WT.skins.widgets.treeGroupButton.backdrop.color.r = 0
            E.private.WT.skins.widgets.treeGroupButton.backdrop.texture = "NaowhLeft"
            E.private.WT.skins.widgets.treeGroupButton.selected.backdropColor.b = 1
            E.private.WT.skins.widgets.treeGroupButton.selected.backdropColor.g = 0.6392157077789307
            E.private.WT.skins.widgets.treeGroupButton.selected.backdropColor.r = 0
            E.private.WT.skins.widgets.treeGroupButton.selected.borderColor.b = 1
            E.private.WT.skins.widgets.treeGroupButton.selected.borderColor.g = 0.6392157077789307
            E.private.WT.skins.widgets.treeGroupButton.selected.borderColor.r = 0
            E.private.WT.tooltips.progression.specialAchievement.enable = false
            E.private.WT.tooltips.titleIcon.enable = false
            E.private.WT.unitFrames.roleIcon.enable = false

            if resolution then
                E.private.WT.quest.objectiveTracker.cosmeticBar.offsetY = -13
                E.private.WT.quest.objectiveTracker.header.size = 15
                E.private.WT.quest.objectiveTracker.info.size = 14
                E.private.WT.quest.objectiveTracker.menuTitle.font.size = 13
                E.private.WT.quest.objectiveTracker.title.size = 13
            end
        end

        E.private.skins.blizzard.cooldownManager = false
    end

    E.private.general.chatBubbleFont = "Naowh"
    E.private.general.chatBubbleFontOutline = "OUTLINE"
    E.private.general.chatBubbleFontSize = 10
    E.private.general.chatBubbles = "backdrop_noborder"
    E.private.general.dmgfont = "GothamNarrowUltra"
    E.private.general.glossTex = "NaowhLeft"
    E.private.general.minimap.hideTracking = true
    E.private.general.namefont = "Naowh"
    E.private.general.normTex = "NaowhLeft"
    E.private.nameplates.enable = false
end