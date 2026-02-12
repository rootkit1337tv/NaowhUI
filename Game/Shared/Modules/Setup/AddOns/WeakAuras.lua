local NUI = unpack(NaowhUI)
local SE = NUI:GetModule("Setup")

function SE.WeakAuras(_, frame, strata, weakaura)
    local D = NUI:GetModule("Data")

    if frame and strata then
        NUI.SetFrameStrata(frame, strata)
    end

    WeakAuras.Import(D[weakaura])
end