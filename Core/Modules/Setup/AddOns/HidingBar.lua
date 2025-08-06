local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

local ipairs, HidingBarDB = ipairs, HidingBarDB

local function ImportHidingBar(addon)
	local tinsert = tinsert
	local database = {}

	for _, v in ipairs(HidingBarDB.profiles) do
		if v.name ~= "Naowh" then
			v.isDefault = nil

			tinsert(database, v)
		end
	end

	tinsert(database, NUI.HidingBar)

	HidingBarDB.profiles = database

	SE.SetupComplete(addon)

	NUI.db.char.loaded = true
	NUI.db.global.version = NUI.version
end

function SE.HidingBar(import, addon)
	if import then
		ImportHidingBar(addon)
	end

	for _, v in ipairs(HidingBarDB.profiles) do
		if v.name == "Naowh" then
			HidingBarDBChar = nil

			return
		end
	end

	SE.UpdateDatabase(addon)
end