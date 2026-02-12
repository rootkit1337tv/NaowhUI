local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

function SE.Details(addon, import, resolution)
    local D = NUI:GetModule("Data")

    local data, decompressedData
    local profile = "details" .. (resolution or "")
    local Details = Details

    if import then
        data = DetailsFramework:Trim(D[profile])
        decompressedData = Details:DecompressData(data, "print")

        Details:EraseProfile("Naowh")
        Details:ImportProfile(D[profile], "Naowh", false, false, true)

        for i, v in Details:ListInstances() do
            DetailsFramework.table.copy(v.hide_on_context, decompressedData.profile.instances[i].hide_on_context)
        end

        SE.CompleteSetup(addon)

        NUI.db.char.loaded = true
        NUI.db.global.version = NUI.version

        return
    end

    if not Details:GetProfile("Naowh") then
        SE.RemoveFromDatabase(addon)

        return
    end

    Details:ApplyProfile("Naowh")
end