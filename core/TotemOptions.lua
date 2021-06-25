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

TOCA.FrameOptions_w = 700
TOCA.FrameOptions_h = 400
TOCA.FrameOptions={}
TOCA.FrameOptions = CreateFrame("Frame", TOCA.FrameOptions, UIParent, "BackdropTemplate")
TOCA.FrameOptions:SetWidth(TOCA.FrameOptions_w)
TOCA.FrameOptions:SetHeight(TOCA.FrameOptions_h)
TOCA.FrameOptions:SetPoint("CENTER", 0, 20)
TOCA.FrameOptions:SetBackdrop(TOCA.Backdrop.General)
TOCA.FrameOptions:SetFrameStrata("DIALOG")
TOCA.FrameOptions:SetBackdropColor(0, 0, 0, 0.8)
TOCA.FrameOptions:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameOptions.title = TOCA.FrameOptions:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.title:SetFont(TOCA.Global.font, 14, "OUTLINE")
TOCA.FrameOptions.title:SetPoint("TOPLEFT", 10, -10)
TOCA.FrameOptions.title:SetText(TOCA.Global.title .. " Options " .. " v" .. TOCA.Global.version)
TOCA.FrameOptions:Hide()

TOCA.Slider.Scale={}
TOCA.Slider.Scale = CreateFrame("Slider", "TOCA.Slider.Scale", TOCA.FrameOptions, "OptionsSliderTemplate")
TOCA.Slider.Scale:SetWidth(140)
TOCA.Slider.Scale:SetHeight(14)
TOCA.Slider.Scale:SetPoint("CENTER", -250, 130)
TOCA.Slider.Scale:SetOrientation('HORIZONTAL')
TOCA.Slider.Scale:EnableMouse(true)
TOCA.Slider.Scale:SetMinMaxValues(0.50, 2.00)
TOCA.Slider.ScaleMin, TOCA.Slider.ScaleMax = TOCA.Slider.Scale:GetMinMaxValues()
TOCA.Slider.Scale:SetValue(1.0)
TOCA.Slider.Scale.Val = TOCA.Slider.Scale:CreateFontString(nil, "ARTWORK")
TOCA.Slider.Scale.Val:SetFont(TOCA.Global.font, 11, "OUTLINE")
TOCA.Slider.Scale.Val:SetPoint("CENTER", 0, -14)
TOCA.Slider.Scale.Val:SetText("")
getglobal(TOCA.Slider.Scale:GetName() .. 'Low'):SetText('0.50')
getglobal(TOCA.Slider.Scale:GetName() .. 'High'):SetText('2')
getglobal(TOCA.Slider.Scale:GetName() .. 'Text'):SetText('Scale')
TOCA.Slider.Scale:SetScript("OnValueChanged", function()
  --print(TOCA.Round(TOCA.Slider.Scale:GetValue(), 2))
  TOCA.FrameMain:SetScale(TOCA.Round(TOCA.Slider.Scale:GetValue(), 2))
  TOCA.Slider.Scale.Val:SetText(TOCA.Round(TOCA.Slider.Scale:GetValue(), 2))
end)
TOCA.Slider.Scale:SetScript("OnLeave", function()
  local transparentVal = tonumber(TOCA.Slider.Scale:GetValue())
  TOCADB[TOCA.player.combine]["CONFIG"]["SCALE"] = TOCA.Round(TOCA.Slider.Scale:GetValue(), 2)
  --print(TOCA.Round(TOCA.Slider.Scale:GetValue(), 2))
end)
TOCA.Button.ResetScale= CreateFrame("Button", nil, TOCA.FrameOptions, "BackdropTemplate")
TOCA.Button.ResetScale:SetSize(25, 25)
TOCA.Button.ResetScale:SetPoint("CENTER", -160, 140)
TOCA.Button.ResetScale:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.ResetScale:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.ResetScale:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.ResetScale:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.Button.ResetScale:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.Button.ResetScale:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
  TOCA.Slider.Scale:SetValue(1.0)
  TOCADB[TOCA.player.combine]["CONFIG"]["SCALE"] = "1.0"
end)
TOCA.Button.ResetScale.icon = TOCA.Button.ResetScale:CreateTexture(nil, "ARTWORK")
TOCA.Button.ResetScale.icon:SetSize(16, 16)
TOCA.Button.ResetScale.icon:SetPoint("CENTER", 0, 0)
TOCA.Button.ResetScale.icon:SetTexture("Interface/Buttons/UI-RefreshButton")

TOCA.Button.ResetPosition= CreateFrame("Button", nil, TOCA.FrameOptions, "BackdropTemplate")
TOCA.Button.ResetPosition:SetSize(100, 25)
TOCA.Button.ResetPosition:SetPoint("CENTER", -90, 140)
TOCA.Button.ResetPosition:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.ResetPosition:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.ResetPosition:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.ResetPosition:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.Button.ResetPosition:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.Button.ResetPosition:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
  TOCA.FrameMain:ClearAllPoints()
  TOCA.FrameMain:SetPoint("CENTER", 0, -140)
end)
TOCA.Button.ResetPositionText = TOCA.Button.ResetPosition:CreateFontString(nil, "ARTWORK")
TOCA.Button.ResetPositionText:SetFont(TOCA.Global.font, 11)
TOCA.Button.ResetPositionText:SetPoint("CENTER", 0, 0)
TOCA.Button.ResetPositionText:SetText("Reset Position")

TOCA.Slider.Opacity={}
TOCA.Slider.Opacity = CreateFrame("Slider", "TOCA.Slider.Opacity", TOCA.FrameOptions, "OptionsSliderTemplate")
TOCA.Slider.Opacity:SetWidth(140)
TOCA.Slider.Opacity:SetHeight(14)
TOCA.Slider.Opacity:SetPoint("CENTER", -250, 60)
TOCA.Slider.Opacity:SetOrientation('HORIZONTAL')
TOCA.Slider.Opacity:EnableMouse(true)
TOCA.Slider.Opacity:SetMinMaxValues(0.00, 1.0)
TOCA.Slider.OpacityMin, TOCA.Slider.OpacityMax = TOCA.Slider.Opacity:GetMinMaxValues()
TOCA.Slider.Opacity:SetValue(1.0)
TOCA.Slider.Opacity.Val = TOCA.Slider.Opacity:CreateFontString(nil, "ARTWORK")
TOCA.Slider.Opacity.Val:SetFont(TOCA.Global.font, 11, "OUTLINE")
TOCA.Slider.Opacity.Val:SetPoint("CENTER", 0, -14)
TOCA.Slider.Opacity.Val:SetText("")
getglobal(TOCA.Slider.Opacity:GetName() .. 'Low'):SetText('0')
getglobal(TOCA.Slider.Opacity:GetName() .. 'High'):SetText('1')
getglobal(TOCA.Slider.Opacity:GetName() .. 'Text'):SetText('Opacity')
TOCA.Slider.Opacity:SetScript("OnValueChanged", function()
  TOCA.FrameMain.Background:SetAlpha(TOCA.Round(TOCA.Slider.Opacity:GetValue(), 2))
  TOCA.Button.TotemicCall.ECL:SetAlpha(TOCA.Round(TOCA.Slider.Opacity:GetValue(), 2))
  TOCA.Button.TotemicCall.ECR:SetAlpha(TOCA.Round(TOCA.Slider.Opacity:GetValue(), 2))
  TOCA.Slider.Opacity.Val:SetText(TOCA.Round(TOCA.Slider.Opacity:GetValue(), 2))
end)

TOCA.Slider.Opacity:SetScript("OnLeave", function()
  local transparentVal = tonumber(TOCA.Slider.Opacity:GetValue())
  TOCADB[TOCA.player.combine]["CONFIG"]["OPACITY"] = TOCA.Round(TOCA.Slider.Opacity:GetValue(), 2)
  --print(TOCA.Round(TOCA.Slider.Opacity:GetValue(), 2))
end)
TOCA.Button.ResetOpacity= CreateFrame("Button", nil, TOCA.FrameOptions, "BackdropTemplate")
TOCA.Button.ResetOpacity:SetSize(25, 25)
TOCA.Button.ResetOpacity:SetPoint("CENTER", -160, 70)
TOCA.Button.ResetOpacity:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.ResetOpacity:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.ResetOpacity:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.ResetOpacity:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.Button.ResetOpacity:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.Button.ResetOpacity:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
  TOCA.Slider.Opacity:SetValue(1.0)
  TOCADB[TOCA.player.combine]["CONFIG"]["OPACITY"] = "1.0"
end)
TOCA.Button.ResetOpacity.icon = TOCA.Button.ResetOpacity:CreateTexture(nil, "ARTWORK")
TOCA.Button.ResetOpacity.icon:SetSize(16, 16)
TOCA.Button.ResetOpacity.icon:SetPoint("CENTER", 0, 0)
TOCA.Button.ResetOpacity.icon:SetTexture("Interface/Buttons/UI-RefreshButton")

TOCA.Button.OptionsClose= CreateFrame("Button", nil, TOCA.FrameOptions, "BackdropTemplate")
TOCA.Button.OptionsClose:SetSize(100, 25)
TOCA.Button.OptionsClose:SetPoint("CENTER", 0, -170)
TOCA.Button.OptionsClose:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.OptionsClose:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.OptionsClose:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.OptionsClose:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.Button.OptionsClose:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.Button.OptionsClose:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
  TOCA.FrameOptions:Hide()
end)
TOCA.Button.OptionsCloseText = TOCA.Button.OptionsClose:CreateFontString(nil, "ARTWORK")
TOCA.Button.OptionsCloseText:SetFont(TOCA.Global.font, 11)
TOCA.Button.OptionsCloseText:SetPoint("CENTER", 0, 0)
TOCA.Button.OptionsCloseText:SetText("Close")
TOCA.Button.OptionsClose:SetFrameStrata("TOOLTIP")

TOCA.OptionsDivider = TOCA.FrameOptions:CreateTexture(nil, "ARTWORK")
TOCA.OptionsDivider:SetSize(4, 340)
TOCA.OptionsDivider:SetPoint("CENTER", 0, 20)
TOCA.OptionsDivider:SetTexture("Interface/DialogFrame/DialogFrame-Left")

TOCA.Dropdown.FrameStrat={}
TOCA.Dropdown.FrameStrats={"LOW", "MEDIUM", "HIGH", "DIALOG"}
TOCA.Dropdown.FrameStrat = CreateFrame("Frame", nil, TOCA.FrameOptions, "UIDropDownMenuTemplate")
TOCA.Dropdown.FrameStrat:SetPoint("TOPLEFT", 20, -210)
TOCA.Dropdown.FrameStrat.displayMode = "MENU"
TOCA.Dropdown.FrameStrat.text = TOCA.Dropdown.FrameStrat:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.FrameStrat.text:SetFont(TOCA.Global.font, 11)
TOCA.Dropdown.FrameStrat.text:SetPoint("TOPLEFT", TOCA.Dropdown.FrameStrat, "TOPLEFT", 25, -8)
TOCA.Dropdown.FrameStrat.text:SetText(TOCA.Dropdown.FrameStrats[2])
TOCA.Dropdown.FrameStrat.onClick = function(self, checked)
  TOCA.Dropdown.FrameStrat.text:SetText(self.value)
  --print(self.value)
  TOCADB[TOCA.player.combine]["CONFIG"]["FRAMELEVEL"] = self.value
  TOCA.FrameMain:SetFrameStrata(self.value)
end
TOCA.Dropdown.FrameStrat.initialize = function(self, level)
  local info = UIDropDownMenu_CreateInfo()
  local i = 0
  for k,v in pairs(TOCA.Dropdown.FrameStrats) do
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
UIDropDownMenu_SetWidth(TOCA.Dropdown.FrameStrat, 125)
TOCA.Dropdown.FrameStrat.title = TOCA.Dropdown.FrameStrat:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.FrameStrat.title:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Dropdown.FrameStrat.title:SetPoint("CENTER", 0, 25)
TOCA.Dropdown.FrameStrat.title:SetText("Frame Layer (Level)")

TOCA.Checkbox.MainMenu={}
TOCA.Checkbox.MainMenu = CreateFrame("CheckButton", nil, TOCA.FrameOptions, "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.MainMenu:SetPoint("CENTER", -320, -80)
TOCA.Checkbox.MainMenu:SetChecked(1)
TOCA.Checkbox.MainMenu.text = TOCA.Checkbox.MainMenu:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.MainMenu.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.MainMenu.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.MainMenu.text:SetText("Display Main Menu Buttons")
TOCA.Checkbox.MainMenu:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCA.FrameMain.Background:SetBackdrop(TOCA.Backdrop.Main)
    TOCADB[TOCA.player.combine]["CONFIG"]["MAINMENU"] = "ON"
    TOCA.Button.CloseMain:Show()
    TOCA.Button.Options:Show()
    TOCA.FrameMain.Background:SetPoint("CENTER", -1, 0)
  else
    TOCA.FrameMain.Background:SetBackdrop(TOCA.Backdrop.General)
    TOCADB[TOCA.player.combine]["CONFIG"]["MAINMENU"] = "OFF"
    TOCA.Button.CloseMain:Hide()
    TOCA.Button.Options:Hide()
    TOCA.FrameMain.Background:SetPoint("CENTER", 0, 0)
    print(TOCA.Global.title .. " Menu header disabled. Type '"..TCCMD.." options' to reopen.")
  end
end)

TOCA.Checkbox.EndCaps={}
TOCA.Checkbox.EndCaps = CreateFrame("CheckButton", nil, TOCA.FrameOptions, "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.EndCaps:SetPoint("CENTER", -320, -105)
TOCA.Checkbox.EndCaps:SetChecked(1)
TOCA.Checkbox.EndCaps.text = TOCA.Checkbox.EndCaps:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.EndCaps.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.EndCaps.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.EndCaps.text:SetText("Display Gryphons")
TOCA.Checkbox.EndCaps:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCA.Button.TotemicCall.ECL:Show()
    TOCA.Button.TotemicCall.ECR:Show()
    TOCADB[TOCA.player.combine]["CONFIG"]["ENDCAPS"] = "ON"
  else
    TOCA.Button.TotemicCall.ECL:Hide()
    TOCA.Button.TotemicCall.ECR:Hide()
    TOCADB[TOCA.player.combine]["CONFIG"]["ENDCAPS"] = "OFF"
  end
end)

TOCA.Button.TooltipPosition= CreateFrame("Button", nil, TOCA.FrameOptions, "BackdropTemplate")
TOCA.Button.TooltipPosition:SetSize(100, 25)
TOCA.Button.TooltipPosition:SetPoint("CENTER", -280, -135)
TOCA.Button.TooltipPosition:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.TooltipPosition:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.TooltipPosition:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.TooltipPosition:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.Button.TooltipPosition:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.Button.TooltipPosition:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
  TOCA.TooltipDisplay("Adjust Tooltip Position", "", "Drag and drop this tooltip window anywhere on screen.")
end)
TOCA.Button.TooltipPositionText = TOCA.Button.TooltipPosition:CreateFontString(nil, "ARTWORK")
TOCA.Button.TooltipPositionText:SetFont(TOCA.Global.font, 11)
TOCA.Button.TooltipPositionText:SetPoint("CENTER", 0, 0)
TOCA.Button.TooltipPositionText:SetText("Tooltip Position")

TOCA.SlotOrderTitle = TOCA.FrameOptions:CreateFontString(nil, "ARTWORK")
TOCA.SlotOrderTitle:SetFont(TOCA.Global.font, 12)
TOCA.SlotOrderTitle:SetPoint("CENTER", 170, -20)
TOCA.SlotOrderTitle:SetText("Totem Order")

TOCA.SlotOrderIcon={}
TOCA.SlotOrderBack={}
TOCA.Dropdown.OrderSet={}

movingTotem= "nil"
overTotem = "nil"
TOCA.SlotSets_x = 0
for i=1, getn(TOCA.Dropdown.OrderSetMenu) do
  TOCA.SlotSets_x = TOCA.SlotSets_x + 68
  TOCA.Dropdown.OrderSet[i] = CreateFrame("Frame", nil, TOCA.FrameOptions, "UIDropDownMenuTemplate")
  TOCA.Dropdown.OrderSet[i]:SetPoint("CENTER", TOCA.SlotSets_x, -50)
  TOCA.Dropdown.OrderSet[i].displayMode = "MENU"
  TOCA.Dropdown.OrderSet[i].text = TOCA.Dropdown.OrderSet[i]:CreateFontString(nil, "ARTWORK")
  TOCA.Dropdown.OrderSet[i].text:SetFont(TOCA.Global.font, 10)
  TOCA.Dropdown.OrderSet[i].text:SetPoint("TOPLEFT", TOCA.Dropdown.OrderSet[i], "TOPLEFT", 25, -8)
  TOCA.Dropdown.OrderSet[i].text:SetText(TOCA.Dropdown.OrderSetMenu[i])
  TOCA.Dropdown.OrderSet[i].onClick = function(self, checked)
    TOCA.Dropdown.OrderSet[i].text:SetText(self.value)
    --print(self.value)
    TOCA.BuildTotemOrder()
  end
  TOCA.Dropdown.OrderSet[i].initialize = function(self, level)
    local info = UIDropDownMenu_CreateInfo()
    local i = 0
    for k,v in pairs(TOCA.Dropdown.OrderSetMenu) do
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
  UIDropDownMenu_SetWidth(TOCA.Dropdown.OrderSet[i], 50)
  --print("TOCA.Dropdown.OrderSet[" .. totemNum)
end
