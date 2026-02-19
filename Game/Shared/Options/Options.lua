local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

local InCombatLockdown = InCombatLockdown

local function AreAddOnsEnabled()
    local addons = {
        "BigWigs",
        "Details",
        "HidingBar",
        "Plater"
    }

    for _, v in ipairs(addons) do
        if NUI:IsAddOnEnabled(v) then

            return true
        end
    end
end

NUI.options = {
    name = "NaowhUI",
    type = "group",
    args = {
        profiles_classic = {
            name = "Profiles",
            order = 1,
            hidden = function()
                if NUI.Retail or not NUI:IsTokenValid(true) or NUI:IsAddOnEnabled("ElvUI") or not AreAddOnsEnabled() or InCombatLockdown() then

                    return true
                end
            end,
            type = "group",
            args = {
                bigwigs = {
                    name = "BigWigs",
                    desc = "Setup BigWigs",
                    hidden = function()
                        if not NUI:IsAddOnEnabled("BigWigs") then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function() SE:Setup("BigWigs", true) end
                },
                details = {
                    name = "Details",
                    desc = "Setup Details",
                    hidden = function()
                        if not NUI:IsAddOnEnabled("Details") then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function() SE:Setup("Details", true) end
                },
                hidingbar = {
                    name = "HidingBar",
                    desc = "Setup HidingBar",
                    hidden = function()
                        if not NUI:IsAddOnEnabled("HidingBar") then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function()
                        SE:Setup("HidingBar", true)

                        ReloadUI()
                    end
                },
                plater = {
                    name = "Plater",
                    desc = "Setup Plater",
                    hidden = function()
                        if not NUI:IsAddOnEnabled("Plater") then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function()
                        SE:Setup("Plater", true)

                        ReloadUI()
                    end
                },
            }
        },
        profiles_retail = {
            name = "Profiles",
            order = 1,
            hidden = function()
                if not NUI.Retail or not NUI:IsTokenValid(true) or NUI:IsAddOnEnabled("ElvUI") or InCombatLockdown() then

                    return true
                end
            end,
            type = "group",
            args = {
                header_1440p = {
                    name = "1440p",
                    order = 1,
                    type = "header"
                },
                bettercooldownmanager = {
                    name = "BCM",
                    order = 2,
                    desc = "Setup BetterCooldownManager",
                    hidden = function()
                        if not NUI:IsAddOnEnabled("BetterCooldownManager") then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function() SE:Setup("BetterCooldownManager", true) end
                },
                bigwigs = {
                    name = "BigWigs",
                    order = 3,
                    desc = "Setup BigWigs",
                    hidden = function()
                        if not NUI:IsAddOnEnabled("BigWigs") then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function() SE:Setup("BigWigs", true) end
                },
                blizzard_editmode = {
                    name = "Blizzard_EditMode",
                    order = 4,
                    desc = "Setup Blizzard_EditMode",
                    type = "execute",
                    func = function() SE:Setup("Blizzard_EditMode", true) end
                },
                details = {
                    name = "Details",
                    order = 5,
                    desc = "Setup Details",
                    hidden = function()
                        if not NUI:IsAddOnEnabled("Details") then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function() SE:Setup("Details", true) end
                },
                plater = {
                    name = "Plater",
                    order = 6,
                    desc = "Setup Plater",
                    hidden = function()
                        if not NUI:IsAddOnEnabled("Plater") then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function()
                        SE:Setup("Plater", true)

                        ReloadUI()
                    end
                },
                warpdeplete = {
                    name = "WarpDeplete",
                    order = 7,
                    desc = "Setup WarpDeplete",
                    hidden = function()
                        if not NUI:IsAddOnEnabled("WarpDeplete") then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function() SE:Setup("WarpDeplete", true) end
                },
                header_1080p = {
                    name = "1080p",
                    order = 8,
                    type = "header"
                },
                bettercooldownmanager_1080p = {
                    name = "BCM",
                    order = 9,
                    desc = "Setup BetterCooldownManager",
                    hidden = function()
                        if not NUI:IsAddOnEnabled("BetterCooldownManager") then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function() SE:Setup("BetterCooldownManager", true, "1080p") end
                },
                bigwigs_1080p = {
                    name = "BigWigs",
                    order = 10,
                    desc = "Setup BigWigs",
                    hidden = function()
                        if not NUI:IsAddOnEnabled("BigWigs") then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function() SE:Setup("BigWigs", true, "1080p") end
                },
                blizzard_editmode_1080p = {
                    name = "Blizzard_EditMode",
                    order = 11,
                    desc = "Setup Blizzard_EditMode",
                    type = "execute",
                    func = function() SE:Setup("Blizzard_EditMode", true, "1080p") end
                },
                details_1080p = {
                    name = "Details",
                    order = 12,
                    desc = "Setup Details",
                    hidden = function()
                        if not NUI:IsAddOnEnabled("Details") then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function() SE:Setup("Details", true, "1080p") end
                },
                plater_1080p = {
                    name = "Plater",
                    order = 13,
                    desc = "Setup Plater",
                    hidden = function()
                        if not NUI:IsAddOnEnabled("Plater") then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function()
                        SE:Setup("Plater", true, "1080p")

                        ReloadUI()
                    end
                },
                warpdeplete_1080p = {
                    name = "WarpDeplete",
                    order = 14,
                    desc = "Setup WarpDeplete",
                    hidden = function()
                        if not NUI:IsAddOnEnabled("WarpDeplete") then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function() SE:Setup("WarpDeplete", true, "1080p") end
                }
            }
        },
        general_weakauras = {
            name = "General WeakAuras",
            order = 2,
            hidden = function()
                if NUI.Retail or not NUI:IsTokenValid(true) or not NUI:IsAddOnEnabled("WeakAuras") or InCombatLockdown() then

                    return true
                end
            end,
            type = "group",
            args = {
                core = {
                    name = "Core",
                    desc = "Import the Core General WeakAura",
                    type = "execute",
                    func = function() SE:Setup("WeakAuras", nil, nil, "core") end
                }
            }
        },
        class_weakauras = {
            name = "Class WeakAuras",
            order = 3,
            hidden = function()
                if NUI.Retail or not NUI:IsTokenValid(true) or not NUI:IsAddOnEnabled("WeakAuras") or InCombatLockdown() then

                    return true
                end
            end,
            type = "group",
            args = {
                death_knight = {
                    name = "Death Knight",
                    desc = "Import the Death Knight Class WeakAura",
                    hidden = function()
                        if not NUI.Mists then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function() SE:Setup("WeakAuras", nil, nil, "deathknight") end
                },
                druid = {
                    name = "Druid",
                    desc = "Import the Druid Class WeakAura",
                    type = "execute",
                    func = function() SE:Setup("WeakAuras", nil, nil, "druid") end
                },
                hunter = {
                    name = "Hunter",
                    desc = "Import the Hunter Class WeakAura",
                    type = "execute",
                    func = function() SE:Setup("WeakAuras", nil, nil, "hunter") end
                },
                mage = {
                    name = "Mage",
                    desc = "Import the Mage Class WeakAura",
                    type = "execute",
                    func = function() SE:Setup("WeakAuras", nil, nil, "mage") end
                },
                monk = {
                    name = "Monk",
                    desc = "Import the Monk Class WeakAura",
                    hidden = function()
                        if not NUI.Mists then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function() SE:Setup("WeakAuras", nil, nil, "monk") end
                },
                paladin = {
                    name = "Paladin",
                    desc = "Import the Paladin Class WeakAura",
                    type = "execute",
                    func = function() SE:Setup("WeakAuras", nil, nil, "paladin") end
                },
                priest = {
                    name = "Priest",
                    desc = "Import the Priest Class WeakAura",
                    type = "execute",
                    func = function() SE:Setup("WeakAuras", nil, nil, "priest") end
                },
                rogue = {
                    name = "Rogue",
                    desc = "Import the Rogue Class WeakAura",
                    type = "execute",
                    func = function() SE:Setup("WeakAuras", nil, nil, "rogue") end
                },
                shaman = {
                    name = "Shaman",
                    desc = "Import the Shaman Class WeakAura",
                    type = "execute",
                    func = function() SE:Setup("WeakAuras", nil, nil, "shaman") end
                },
                warlock = {
                    name = "Warlock",
                    desc = "Import the Warlock Class WeakAura",
                    type = "execute",
                    func = function() SE:Setup("WeakAuras", nil, nil, "warlock") end
                },
                warrior = {
                    name = "Warrior",
                    desc = "Import the Warrior Class WeakAura",
                    type = "execute",
                    func = function() SE:Setup("WeakAuras", nil, nil, "warrior") end
                }
            }
        },
        class_layouts = {
            name = "Class Layouts",
            order = 4,
            hidden = function()
                if not NUI.Retail or not NUI:IsTokenValid(true) or NUI:IsAddOnEnabled("ElvUI") or InCombatLockdown() then

                    return true
                end
            end,
            type = "group",
            args = {
                desc1 = {
<<<<<<< HEAD
                    name = "Install Edit Mode and Cooldown Manager layouts for your class.",
=======
                    name = "Install Cooldown Manager layouts for your class.",
>>>>>>> 8fad44d1cbe62fe580a189023da112cf8653ea96
                    order = 1,
                    type = "description",
                    fontSize = "medium"
                },
                desc2 = {
                    name = function()
                        local className = SE.GetPlayerClassDisplayName and SE.GetPlayerClassDisplayName() or UnitClass("player")

                        return "|cffFFFF00Note:|r This only installs layouts for |cff00FF00" .. className .. "|r (all specs)."
                    end,
                    order = 2,
                    type = "description",
                    fontSize = "medium"
                },
                desc3 = {
                    name = "Make sure the Cooldown Manager is enabled in Advanced Options.",
                    order = 3,
                    type = "description",
                    fontSize = "medium"
                },
                class_cooldowns = {
                    name = "Class Layout",
                    order = 4,
                    desc = "Install class cooldown layouts for your current class",
                    type = "execute",
                    func = function() SE:Setup("ClassCooldowns", true) end
                }
            }
        },
        advanced = {
            name = "Advanced",
            order = -1,
            type = "group",
            args = {
                load_profiles = {
                    name = "Load Profiles",
                    desc = "Load your installed profiles onto this character",
                    hidden = function()
                        if NUI:IsAddOnEnabled("ElvUI") or (not NUI.Retail and not AreAddOnsEnabled()) or not NUI.db.global.profiles or InCombatLockdown() then

                            return true
                        end
                    end,
                    type = "execute",
                    func = function() NUI:LoadProfiles() end
                },
                print_version = {
                    name = "Print Version",
                    desc = "Print the current version",
                    type = "execute",
                    func = function() NUI:Print(NUI.version) end
                }
            }
        }
    }
}
