local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

local function ImportNameplateAuras(addon)
	local NameplateAurasAceDB = NameplateAurasAceDB
	local spell

	SE.SetupComplete(addon)

	NameplateAurasAceDB.profiles.Naowh = NUI.NameplateAuras

	for _, v in ipairs(NameplateAurasAceDB.profiles.Naowh.CustomSpells2) do
		spell = C_Spell.GetSpellName(next(v.checkSpellID))

		if spell ~= v.spellName then
			v.spellName = spell
		end
	end

	NUI.db.char.loaded = true
	NUI.db.global.version = NUI.version
end

function SE.NameplateAuras(import, addon)
	local NameplateAurasAceDB = NameplateAurasAceDB
	local database = LibStub("AceDB-3.0"):New(NameplateAurasAceDB)

	if import then
		ImportNameplateAuras(addon)
	end

	if not SE.IsProfileExisting(NameplateAurasAceDB) then
		SE.UpdateDatabase(addon)

		return
	end

	database:SetProfile("Naowh")
end