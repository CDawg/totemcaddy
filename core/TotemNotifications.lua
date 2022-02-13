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

TOCA.FrameOptions.Title.Notifs={}
TOCA.FrameOptions.Title.Notifs = TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[3]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.Title.Notifs:SetFont(TOCA.Global.font, 12)
TOCA.FrameOptions.Title.Notifs:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -20)
TOCA.FrameOptions.Title.Notifs:SetText(TOCA.locale.UI.NOTIFICATIONS.TITLE)
TOCA.FrameOptions.Title.Notifs:SetTextColor(1, 1, 0.5, 1)

TOCA.Checkbox.ExpireMessage={}
TOCA.Checkbox.ExpireMessage = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[3]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.ExpireMessage:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -40)
TOCA.Checkbox.ExpireMessage:SetChecked(1)
TOCA.Checkbox.ExpireMessage.text = TOCA.Checkbox.ExpireMessage:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.ExpireMessage.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.ExpireMessage.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.ExpireMessage.text:SetText(TOCA.locale.UI.NOTIFICATIONS[2][1])
TOCA.Checkbox.ExpireMessage:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["EXPIREMESSAGE"] = "ON"
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["EXPIREMESSAGE"] = "OFF"
  end
end)
TOCA.Checkbox.ExpireMessage:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), TOCA.locale.UI.NOTIFICATIONS[2][2])
end)
TOCA.Checkbox.ExpireMessage:SetScript("OnLeave", function()
  TOCA.CloseAllMenus()
end)

TOCA.Checkbox.ExpireSound={}
TOCA.Checkbox.ExpireSound = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[3]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.ExpireSound:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -60)
TOCA.Checkbox.ExpireSound:SetChecked(1)
TOCA.Checkbox.ExpireSound.text = TOCA.Checkbox.ExpireSound:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.ExpireSound.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.ExpireSound.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.ExpireSound.text:SetText(TOCA.locale.UI.NOTIFICATIONS[3][1])
TOCA.Checkbox.ExpireSound:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["EXPIRESOUND"] = "ON"
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["EXPIRESOUND"] = "OFF"
  end
end)
TOCA.Checkbox.ExpireSound:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), TOCA.locale.UI.NOTIFICATIONS[3][2])
end)
TOCA.Checkbox.ExpireSound:SetScript("OnLeave", function()
  TOCA.CloseAllMenus()
end)

local NotificationSounds = 19
TOCA.Dropdown.Sounds={}
for i=1, 19 do
	TOCA.Dropdown.Sounds[i] = "totemexpire_" .. i
end

TOCA.Dropdown.Sound={}
TOCA.Dropdown.Sound = CreateFrame("Frame", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[3]], "UIDropDownMenuTemplate")
TOCA.Dropdown.Sound:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"]+10, -80)
TOCA.Dropdown.Sound.displayMode = "MENU"
TOCA.Dropdown.Sound.text = TOCA.Dropdown.Sound:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.Sound.text:SetFont(TOCA.Global.font, 11)
TOCA.Dropdown.Sound.text:SetPoint("TOPLEFT", TOCA.Dropdown.Sound, "TOPLEFT", 25, -8)
TOCA.Dropdown.Sound.text:SetText(TOCA.Dropdown.Sounds[1])
TOCA.Dropdown.Sound:SetScript("OnEnter", function(self)
  --TOCA.TooltipDisplay(self, TOCA.locale.UI.OPTIONS[1][1], TOCA.locale.UI.OPTIONS[1][2])
end)
TOCA.Dropdown.Sound:SetScript("OnLeave", function()
  TOCA.CloseAllMenus()
end)
TOCA.Dropdown.Sound.onClick = function(self, checked)
  TOCA.Dropdown.Sound.text:SetText(self.value)
  TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDFILE"] = self.value
	PlaySoundFile(TOCA.Global.dir .. "sounds/" .. self.value .. ".ogg")
end
TOCA.Dropdown.Sound.initialize = function(self, level)
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
UIDropDownMenu_SetWidth(TOCA.Dropdown.Sound, 125)
TOCA.Dropdown.Sound.title = TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]]:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.Sound.title:SetFont(TOCA.Global.font, 12)
TOCA.Dropdown.Sound.title:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -20)
TOCA.Dropdown.Sound.title:SetText(TOCA.locale.UI.OPTIONS[1][1])
TOCA.Dropdown.Sound.title:SetTextColor(1, 1, 0.5, 1)
