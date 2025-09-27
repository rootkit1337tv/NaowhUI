local NUI = unpack(NaowhUI)
local SC = NUI:GetModule("Scaling")

function SC:Scaling(...)
	local addon, scale = ...
	local scaling = self[addon]

	scaling(scale)
end