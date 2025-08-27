local NUI = unpack(NaowhUI)
local I = NUI:GetModule("Installer")
local SE = NUI:GetModule("Setup")

I.installer = {
	Title = format("%s %s", NUI.title, "Installation"),
	Name = NUI.title,
	tutorialImage = "Interface\\AddOns\\NaowhUI\\Core\\Media\\Textures\\NaowhUILogo.tga",
	Pages = {
		[1] = function()
			PluginInstallFrame.SubTitle:SetFormattedText("Welcome to %s", NUI.title)

			if not NUI.db.global.profiles then
				PluginInstallFrame.Desc1:SetText("To start the installation process, click on 'Continue'")

				return
			end

			--[[if NUI:AreUpdatesAvailable() then
				PluginInstallFrame.Desc2:SetText("To update your installed profiles to their latest revision, click on 'Update Profiles'")
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript("OnClick", function() NUI:UpdateProfiles() end)
				PluginInstallFrame.Option2:SetText("Update Profiles")
			end]]

			PluginInstallFrame.Desc1:SetText("To load your installed profiles onto this character, click on 'Load Profiles'")
			PluginInstallFrame.Desc3:SetText("To start the installation process again, click on 'Continue'")
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() NUI:LoadProfiles() end)
			PluginInstallFrame.Option1:SetText("Load Profiles")
		end,
		[2] = function()
			PluginInstallFrame.SubTitle:SetText("ElvUI")
			PluginInstallFrame.Desc1:SetText("You can choose between three different scaling options")
			PluginInstallFrame.Desc2:SetText("Recommendation: 0.71 for 1080p, 0.53 or 0.62 for 1440p")
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() SE:Setup("ElvUI", true, 0.5333333333333333) end)
			PluginInstallFrame.Option1:SetText("0.53")
			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:SetScript("OnClick", function() SE:Setup("ElvUI", true, 0.6222222222222222) end)
			PluginInstallFrame.Option2:SetText("0.62")
			PluginInstallFrame.Option3:Show()
			PluginInstallFrame.Option3:SetScript("OnClick", function() SE:Setup("ElvUI", true, 0.7111111111111111) end)
			PluginInstallFrame.Option3:SetText("0.71 (Default)")
		end,
		[3] = function()
			PluginInstallFrame.SubTitle:SetText("BigWigs")

			if not NUI:IsAddOnEnabled("AddOnSkins") or not NUI:IsAddOnEnabled("BigWigs") then
				PluginInstallFrame.Desc1:SetText("Enable AddOnSkins and BigWigs to unlock this functionality")

				return
			end

			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() SE:Setup("BigWigs", true) end)
			PluginInstallFrame.Option1:SetText("Setup BigWigs")
		end,
		[4] = function()
			PluginInstallFrame.SubTitle:SetText("Details")

			if not NUI:IsAddOnEnabled("Details") then
				PluginInstallFrame.Desc1:SetText("Enable Details to unlock this functionality")

				return
			end

			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() SE:Setup("Details", true) end)
			PluginInstallFrame.Option1:SetText("Setup Details")
		end,
		[5] = function()
			PluginInstallFrame.SubTitle:SetText("HidingBar")

			if not NUI:IsAddOnEnabled("HidingBar") then
				PluginInstallFrame.Desc1:SetText("Enable HidingBar to unlock this functionality")

				return
			end

			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() SE:Setup("HidingBar", true) end)
			PluginInstallFrame.Option1:SetText("Setup HidingBar")
		end,
		[6] = function()
			PluginInstallFrame.SubTitle:SetText("NameplateAuras")

			if not NUI:IsAddOnEnabled("NameplateAuras") then
				PluginInstallFrame.Desc1:SetText("Enable NameplateAuras to unlock this functionality")

				return
			end

			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() SE:Setup("NameplateAuras", true) end )
			PluginInstallFrame.Option1:SetText("Setup NameplateAuras")
		end,
		[7] = function()
			PluginInstallFrame.SubTitle:SetText("OmniCD")

			if not NUI:IsAddOnEnabled("OmniCD") then
				PluginInstallFrame.Desc1:SetText("Enable OmniCD to unlock this functionality")

				return
			end

			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() SE:Setup("OmniCD", true) end)
			PluginInstallFrame.Option1:SetText("Setup OmniCD")
		end,
		[8] = function()
			PluginInstallFrame.SubTitle:SetText("Plater")

			if not NUI:IsAddOnEnabled("Plater") then
				PluginInstallFrame.Desc1:SetText("Enable Plater to unlock this functionality")

				return
			end

			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() SE:Setup("Plater", true) end)
			PluginInstallFrame.Option1:SetText("Setup Plater")
		end,
		[9] = function()
			PluginInstallFrame.SubTitle:SetText("WarpDeplete")

			if not NUI:IsAddOnEnabled("WarpDeplete") then
				PluginInstallFrame.SubDesc1Title:SetText("Enable WarpDeplete to unlock this functionality")

				return
			end

			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() SE:Setup("WarpDeplete", true) end)
			PluginInstallFrame.Option1:SetText("Setup WarpDeplete")
		end,
		[10] = function()
			PluginInstallFrame.SubTitle:SetText("General WeakAuras")

			if not NUI:IsAddOnEnabled("WeakAuras") then
				PluginInstallFrame.Desc1:SetText("Enable WeakAuras to unlock this functionality")

				return
			end

			PluginInstallFrame.Desc1:SetText("Select your General WeakAuras")
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() SE:Setup("WeakAuras", nil, nil, PluginInstallFrame, "HIGH", "core") end)
			PluginInstallFrame.Option1:SetText("Core")
			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:SetScript("OnClick", function() SE:Setup("WeakAuras", nil, nil, PluginInstallFrame, "HIGH", "generic") end)
			PluginInstallFrame.Option2:SetText("M+ Generic")
			PluginInstallFrame.Option3:Show()
			PluginInstallFrame.Option3:SetScript("OnClick", function() SE:Setup("WeakAuras", nil, nil, PluginInstallFrame, "HIGH", "Season3") end)
			PluginInstallFrame.Option3:SetText("M+ Season 3")
			PluginInstallFrame.Option4:Show()
			PluginInstallFrame.Option4:SetScript("OnClick", function() SE:Setup("WeakAuras", nil, nil, PluginInstallFrame, "HIGH", "raid") end)
			PluginInstallFrame.Option4:SetText("Raid")
		end,
		[11] = function()
			PluginInstallFrame.SubTitle:SetText("Class WeakAuras")

			if not NUI:IsAddOnEnabled("WeakAuras") then
				PluginInstallFrame.Desc1:SetText("Enable WeakAuras to unlock this functionality")

				return
			end

			PluginInstallFrame.Desc1:SetText("Click on the button below to select your Class WeakAuras")
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() NUI:OpenSettings() end)
			PluginInstallFrame.Option1:SetText("Open Settings")
		end,
		[12] = function()
			PluginInstallFrame.SubTitle:SetText("Installation Complete")
			PluginInstallFrame.Desc1:SetText("You have completed the installation process")
			PluginInstallFrame.Desc2:SetText("Please click on 'Finished' to reload your UI")
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() ReloadUI() end)
			PluginInstallFrame.Option1:SetText("Finished")
		end
	},
	StepTitles = {
		[1] = "Welcome",
		[2] = "ElvUI",
		[3] = "BigWigs",
		[4] = "Details",
		[5] = "HidingBar",
		[6] = "NameplateAuras",
		[7] = "OmniCD",
		[8] = "Plater",
		[9] = "WarpDeplete",
		[10] = "General WeakAuras",
		[11] = "Class WeakAuras",
		[12] = "Installation Complete"
	},
	StepTitlesColor = {1, 1, 1},
	StepTitlesColorSelected = {0, 179/255, 1},
	StepTitleWidth = 200,
	StepTitleButtonWidth = 180,
	StepTitleTextJustification = "RIGHT"
}