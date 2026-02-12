local LSM = LibStub("LibSharedMedia-3.0")
local koKR, ruRU, zhCN, zhTW, western = LSM.LOCALE_BIT_koKR, LSM.LOCALE_BIT_ruRU, LSM.LOCALE_BIT_zhCN, LSM.LOCALE_BIT_zhTW, LSM.LOCALE_BIT_western

local MediaType_FONT = LSM.MediaType.FONT
local MediaType_STATUSBAR = LSM.MediaType.STATUSBAR

LSM:Register(MediaType_FONT, "GothamNarrowUltra",       [[Interface\Addons\NaowhUI\Game\Shared\Media\Fonts\GothamNarrowUltra.ttf]],                           ruRU + western)
LSM:Register(MediaType_FONT, "GothamNarrowUltra",       [[Interface\Addons\NaowhUI\Game\Shared\Media\Fonts\GothamNarrowUltraAsia.ttf]],                       koKR + zhCN + zhTW)
LSM:Register(MediaType_FONT, "Naowh",                   [[Interface\Addons\NaowhUI\Game\Shared\Media\Fonts\Naowh.ttf]],                                       ruRU + western)
LSM:Register(MediaType_FONT, "Naowh",                   [[Interface\Addons\NaowhUI\Game\Shared\Media\Fonts\NaowhAsia.ttf]],                                   koKR + zhCN + zhTW)

LSM:Register(MediaType_STATUSBAR, "Melli",                  [[Interface\Addons\NaowhUI\Game\Shared\Media\Textures\Melli]])
LSM:Register(MediaType_STATUSBAR, "NaowhGradient",          [[Interface\Addons\NaowhUI\Game\Shared\Media\Textures\NaowhGradient]])
LSM:Register(MediaType_STATUSBAR, "NaowhLeft",              [[Interface\Addons\NaowhUI\Game\Shared\Media\Textures\NaowhLeft]])
LSM:Register(MediaType_STATUSBAR, "NaowhMouseover",         [[Interface\Addons\NaowhUI\Game\Shared\Media\Textures\NaowhMouseover]])
LSM:Register(MediaType_STATUSBAR, "NaowhMouseoverArrows",   [[Interface\Addons\NaowhUI\Game\Shared\Media\Textures\NaowhMouseoverArrows]])
LSM:Register(MediaType_STATUSBAR, "NaowhRight",             [[Interface\Addons\NaowhUI\Game\Shared\Media\Textures\NaowhRight]])