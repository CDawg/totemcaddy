--[==[
Copyright ©2020 Porthias of Myzrael or Porthios of Myzrael

The contents of this addon, excluding third-party resources, are
copyrighted to Porthios with all rights reserved.
This addon is free to use and the authors hereby grants you the following rights:
1. You may make modifications to this addon for private use only, you
   may not publicize any portion of this addon.
2. Do not modify the name of this addon, including the addon folders.
3. This copyright notice shall be included in all copies or substantial
  portions of the Software.
All rights not explicitly addressed in this license are reserved by
the copyright holders.
]==]--

local NumTotemNotificationSounds = 20
local NumShieldNotificationSounds = 20

TOCA.FrameOptions.Title.Notifs={}
TOCA.FrameOptions.Title.Notifs = TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[3]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.Title.Notifs:SetFont(TOCA._G.font, 12)
TOCA.FrameOptions.Title.Notifs:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -20)
TOCA.FrameOptions.Title.Notifs:SetText(TOCA._L.UI.NOTIFICATIONS.TITLE)
TOCA.FrameOptions.Title.Notifs:SetTextColor(1, 1, 0.5, 1)

TOCA.Checkbox.NotifyCombat={}
TOCA.Checkbox.NotifyCombat = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[3]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.NotifyCombat:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -40)
TOCA.Checkbox.NotifyCombat:SetChecked(1)
TOCA.Checkbox.NotifyCombat.text = TOCA.Checkbox.NotifyCombat:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.NotifyCombat.text:SetFont(TOCA._G.font, 12, "OUTLINE")
TOCA.Checkbox.NotifyCombat.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.NotifyCombat.text:SetText(TOCA._L.UI.NOTIFICATIONS[1][1])
TOCA.Checkbox.NotifyCombat:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["NOTIFYCOMBAT"] = "ON"
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["NOTIFYCOMBAT"] = "OFF"
  end
end)
TOCA.Checkbox.NotifyCombat:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), TOCA._L.UI.NOTIFICATIONS[1][2])
end)
TOCA.Checkbox.NotifyCombat:SetScript("OnLeave", function()
  TOCA.CloseAllMenus()
end)

TOCA.Checkbox.ExpireMessage={}
TOCA.Checkbox.ExpireMessage = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[3]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.ExpireMessage:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -80)
TOCA.Checkbox.ExpireMessage:SetChecked(1)
TOCA.Checkbox.ExpireMessage.text = TOCA.Checkbox.ExpireMessage:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.ExpireMessage.text:SetFont(TOCA._G.font, 12, "OUTLINE")
TOCA.Checkbox.ExpireMessage.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.ExpireMessage.text:SetText(TOCA._L.UI.NOTIFICATIONS[2][1])
TOCA.Checkbox.ExpireMessage:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["EXPIREMESSAGE"] = "ON"
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["EXPIREMESSAGE"] = "OFF"
  end
end)
TOCA.Checkbox.ExpireMessage:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), TOCA._L.UI.NOTIFICATIONS[2][2])
end)
TOCA.Checkbox.ExpireMessage:SetScript("OnLeave", function()
  TOCA.CloseAllMenus()
end)

TOCA.Checkbox.ExpireSound={}
TOCA.Checkbox.ExpireSound = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[3]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.ExpireSound:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -100)
TOCA.Checkbox.ExpireSound:SetChecked(1)
TOCA.Checkbox.ExpireSound.text = TOCA.Checkbox.ExpireSound:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.ExpireSound.text:SetFont(TOCA._G.font, 12, "OUTLINE")
TOCA.Checkbox.ExpireSound.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.ExpireSound.text:SetText(TOCA._L.UI.NOTIFICATIONS[3][1])
TOCA.Checkbox.ExpireSound:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["EXPIRESOUND"] = "ON"
		TOCA.Dropdown.Sound.TotemExpire:SetAlpha(1)
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["EXPIRESOUND"] = "OFF"
		TOCA.Dropdown.Sound.TotemExpire:SetAlpha(0.4)
  end
end)
TOCA.Checkbox.ExpireSound:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), TOCA._L.UI.NOTIFICATIONS[3][2])
end)
TOCA.Checkbox.ExpireSound:SetScript("OnLeave", function()
  TOCA.CloseAllMenus()
end)

TOCA.Dropdown.Sounds={}
for i=1, NumTotemNotificationSounds do
	TOCA.Dropdown.Sounds[i] = "totemexpire_" .. i
end

TOCA.Dropdown.Sound={}
TOCA.Dropdown.Sound.TotemExpire={}
TOCA.Dropdown.Sound.TotemExpire = CreateFrame("Frame", nil, TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[3]], "UIDropDownMenuTemplate")
TOCA.Dropdown.Sound.TotemExpire:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"]+10, -120)
TOCA.Dropdown.Sound.TotemExpire.displayMode = "MENU"
TOCA.Dropdown.Sound.TotemExpire.text = TOCA.Dropdown.Sound.TotemExpire:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.Sound.TotemExpire.text:SetFont(TOCA._G.font, 11)
TOCA.Dropdown.Sound.TotemExpire.text:SetPoint("TOPLEFT", TOCA.Dropdown.Sound.TotemExpire, "TOPLEFT", 25, -8)
TOCA.Dropdown.Sound.TotemExpire.text:SetText(TOCA.Dropdown.Sounds[1])
TOCA.Dropdown.Sound.TotemExpire:SetScript("OnEnter", function(self)
  --TOCA.TooltipDisplay(self, TOCA._L.UI.OPTIONS[1][1], TOCA._L.UI.OPTIONS[1][2])
end)
TOCA.Dropdown.Sound.TotemExpire:SetScript("OnLeave", function()
  TOCA.CloseAllMenus()
end)
TOCA.Dropdown.Sound.TotemExpire.onClick = function(self, checked)
  TOCA.Dropdown.Sound.TotemExpire.text:SetText(self.value)
  TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDFILE"] = self.value
	PlaySoundFile(TOCA._G.dir .. "sounds/" .. self.value .. ".ogg")
end
TOCA.Dropdown.Sound.TotemExpire.initialize = function(self, level)
  local info = UIDropDownMenu_CreateInfo()
  local i = 0
  for k,v in pairs(TOCA.Dropdown.Sounds) do
    info.notCheckable = 1
    info.padding = 2
    info.text = v
    info.value= v
    info.fontObject = GameFontWhite
    info.justifyH = "LEFT"
    info.disabled = false
    info.func = self.onClick
    UIDropDownMenu_AddButton(info, level)
  end
end
UIDropDownMenu_SetWidth(TOCA.Dropdown.Sound.TotemExpire, 125)

TOCA.Checkbox.ShieldMessage={}
TOCA.Checkbox.ShieldMessage = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[3]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.ShieldMessage:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -160)
TOCA.Checkbox.ShieldMessage:SetChecked(1)
TOCA.Checkbox.ShieldMessage.text = TOCA.Checkbox.ShieldMessage:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.ShieldMessage.text:SetFont(TOCA._G.font, 12, "OUTLINE")
TOCA.Checkbox.ShieldMessage.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.ShieldMessage.text:SetText(TOCA._L.UI.NOTIFICATIONS[4][1])
TOCA.Checkbox.ShieldMessage:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["EXPIREMESSAGESHIELD"] = "ON"
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["EXPIREMESSAGESHIELD"] = "OFF"
  end
end)
TOCA.Checkbox.ShieldMessage:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), TOCA._L.UI.NOTIFICATIONS[4][2])
end)
TOCA.Checkbox.ShieldMessage:SetScript("OnLeave", function()
  TOCA.CloseAllMenus()
end)

TOCA.Checkbox.ShieldExpire={}
TOCA.Checkbox.ShieldExpire = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[3]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.ShieldExpire:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -180)
TOCA.Checkbox.ShieldExpire:SetChecked(1)
TOCA.Checkbox.ShieldExpire.text = TOCA.Checkbox.ShieldExpire:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.ShieldExpire.text:SetFont(TOCA._G.font, 12, "OUTLINE")
TOCA.Checkbox.ShieldExpire.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.ShieldExpire.text:SetText(TOCA._L.UI.NOTIFICATIONS[5][1])
TOCA.Checkbox.ShieldExpire:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["EXPIRESHIELD"] = "ON"
		TOCA.Dropdown.Sound.ShieldExpire:SetAlpha(1)
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["EXPIRESHIELD"] = "OFF"
		TOCA.Dropdown.Sound.ShieldExpire:SetAlpha(0.4)
  end
end)
TOCA.Checkbox.ShieldExpire:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), TOCA._L.UI.NOTIFICATIONS[5][2])
end)
TOCA.Checkbox.ShieldExpire:SetScript("OnLeave", function()
  TOCA.CloseAllMenus()
end)

TOCA.Dropdown.SoundsShield={}
for i=1, NumShieldNotificationSounds do
	TOCA.Dropdown.SoundsShield[i] = "shieldexpire_" .. i
end

TOCA.Dropdown.Sound.ShieldExpire={}
TOCA.Dropdown.Sound.ShieldExpire = CreateFrame("Frame", nil, TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[3]], "UIDropDownMenuTemplate")
TOCA.Dropdown.Sound.ShieldExpire:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"]+10, -200)
TOCA.Dropdown.Sound.ShieldExpire.displayMode = "MENU"
TOCA.Dropdown.Sound.ShieldExpire.text = TOCA.Dropdown.Sound.ShieldExpire:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.Sound.ShieldExpire.text:SetFont(TOCA._G.font, 11)
TOCA.Dropdown.Sound.ShieldExpire.text:SetPoint("TOPLEFT", TOCA.Dropdown.Sound.ShieldExpire, "TOPLEFT", 25, -8)
TOCA.Dropdown.Sound.ShieldExpire.text:SetText(TOCA.Dropdown.SoundsShield[1])
TOCA.Dropdown.Sound.ShieldExpire:SetScript("OnEnter", function(self)
  --TOCA.TooltipDisplay(self, TOCA._L.UI.OPTIONS[1][1], TOCA._L.UI.OPTIONS[1][2])
end)
TOCA.Dropdown.Sound.ShieldExpire:SetScript("OnLeave", function()
  TOCA.CloseAllMenus()
end)
TOCA.Dropdown.Sound.ShieldExpire.onClick = function(self, checked)
  TOCA.Dropdown.Sound.ShieldExpire.text:SetText(self.value)
  TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDSHIELDFILE"] = self.value
	PlaySoundFile(TOCA._G.dir .. "sounds/" .. self.value .. ".ogg")
end
TOCA.Dropdown.Sound.ShieldExpire.initialize = function(self, level)
  local info = UIDropDownMenu_CreateInfo()
  local i = 0
  for k,v in pairs(TOCA.Dropdown.SoundsShield) do
    info.notCheckable = 1
    info.padding = 2
    info.text = v
    info.value= v
    info.fontObject = GameFontWhite
    info.justifyH = "LEFT"
    info.disabled = false
    info.func = self.onClick
    UIDropDownMenu_AddButton(info, level)
  end
end
UIDropDownMenu_SetWidth(TOCA.Dropdown.Sound.ShieldExpire, 125)

TOCA.Checkbox.TotemRadiusVisual={}
TOCA.Checkbox.TotemRadiusVisual = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[3]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.TotemRadiusVisual:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -240)
TOCA.Checkbox.TotemRadiusVisual:SetChecked(1)
TOCA.Checkbox.TotemRadiusVisual.text = TOCA.Checkbox.TotemRadiusVisual:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.TotemRadiusVisual.text:SetFont(TOCA._G.font, 12, "OUTLINE")
TOCA.Checkbox.TotemRadiusVisual.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.TotemRadiusVisual.text:SetText(TOCA._L.UI.NOTIFICATIONS[6][1])
TOCA.Checkbox.TotemRadiusVisual:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["TOTEMRADIUSVISUAL"] = "ON"
		TOCA.TotemAuraRadius() --added this here for players that want to test while standing still
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["TOTEMRADIUSVISUAL"] = "OFF"
		for k,v in pairs(TOCA.totems) do
			TOCA.Slot.Radius[k]:Hide()
			TOCA.Slot.Radius.Border[k]:Hide()
		end
  end
end)
TOCA.Checkbox.TotemRadiusVisual:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), TOCA._L.UI.NOTIFICATIONS[6][2])
end)
TOCA.Checkbox.TotemRadiusVisual:SetScript("OnLeave", function()
  TOCA.CloseAllMenus()
end)
