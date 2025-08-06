local NUI = unpack(NaowhUI)
local SC = NUI:GetModule("Scaling")

local Strings

local function SplitString(string)
	for e in string.gmatch(string, "[^,]+") do
		tinsert(Strings, e)
	end
end

function SC.ElvUI(scale)
	local E = unpack(ElvUI)

	local UIParent = UIParent

	local UIScale = scale or E.data.global.general.UIScale
	local x, y
	local UnscaledMovers = {
		["AlertFrameMover"] = true,
		["AltPowerBarMover"] = true,
		["BossButton"] = true,
		["BossHeaderMover"] = true,
		["ElvAB_2"] = true,
		["ElvAB_3"] = true,
		["ElvAB_4"] = true,
		["ElvAB_5"] = true,
		["ElvAB_6"] = true,
		["ElvUF_FocusMover"] = true,
		["ElvUF_PartyMover"] = true,
		["ElvUF_PetMover"] = true,
		["ElvUF_PlayerMover"] = true,
		["ElvUF_Raid1Mover"] = true,
		["ElvUF_Raid2Mover"] = true,
		["ElvUF_Raid3Mover"] = true,
		["ElvUF_TargetMover"] = true,
		["ElvUF_TargetTargetMover"] = true,
		["LossControlMover"] = true,
		["LootFrameMover"] = true,
		["TargetPowerBarMover"] = true,
		["VehicleLeaveButton"] = true,
		["ZoneAbility"] = true
	}
	local anchors = {
		["BOTTOM"] = {
			["AnchorX"] = 0,
			["AnchorY"] = 1 / 2
		},
		["BOTTOMLEFT"] = {
			["AnchorX"] = 1 / 2,
			["AnchorY"] = 1 / 2
		},
		["BOTTOMRIGHT"] = {
			["AnchorX"] = -1 / 2,
			["AnchorY"] = 1 / 2
		},
		["TOP"] = {
			["AnchorX"] = 0,
			["AnchorY"] = -1 / 2
		},
		["TOPLEFT"] = {
			["AnchorX"] = 1 / 2,
			["AnchorY"] = -1 / 2
		},
		["TOPRIGHT"] = {
			["AnchorX"] = -1 / 2,
			["AnchorY"] = -1 / 2
		}
	}
	local ScaledMovers = {}
	local tostring = tostring

	if UIScale == 0.7111111111111111 then
		UIParent:SetScale(UIScale)

		E.data.global.general.UIScale = UIScale

		return
	end

	UIParent:SetScale(UIScale)

	x, y = UIParent:GetSize()

	for k, v in pairs(E.data.profiles.Naowh.movers) do
		if UnscaledMovers[k] then
			Strings = {}

			SplitString(v)

			ScaledMovers[k] = format("%s,%s,%s,%s,%s", Strings[1], Strings[2], Strings[3], tostring(Strings[4] - (768 / 0.7111111111111111 / 9 * 16 * anchors[Strings[1]].AnchorX) + (x * anchors[Strings[1]].AnchorX)), tostring(Strings[5] - (768 / 0.7111111111111111 * anchors[Strings[1]].AnchorY) + (y * anchors[Strings[1]].AnchorY)))
		else
			ScaledMovers[k] = v
		end
	end

	E.data.global.general.UIScale = UIScale
	E.data.profiles.Naowh.movers = ScaledMovers
	NUI.reload = true
end