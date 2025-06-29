local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

function SE.WeakAuras(_, _, _, frame, strata, weakaura)
	local weakaura = NUI[weakaura]

	if frame and strata then
		NUI.SetFrameStrata(frame, strata)
	end

	WeakAuras.Import(weakaura)
end