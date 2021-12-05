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
TOCA.FrameOptions = CreateFrame("Frame", "TOCA.FrameOptions", UIParent, "BackdropTemplate")
TOCA.FrameOptions:SetWidth(TOCA.FrameOptions_w)
TOCA.FrameOptions:SetHeight(TOCA.FrameOptions_h)
TOCA.FrameOptions:SetPoint("CENTER", 0, 20)
TOCA.FrameOptions:SetBackdrop(TOCA.Backdrop.General)
TOCA.FrameOptions:SetFrameStrata("DIALOG")
TOCA.FrameOptions:SetBackdropColor(0, 0, 0, 0.8)
TOCA.FrameOptions:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameOptions:Hide()

TOCA.TabWidth.Options = 140
TOCA.Button.TabOptions={}
TOCA.Button.TabOptionsBack={}
TOCA.OptionTabs = {
  "UI Frame",
  "Totem Set Builder",
}

TOCA.FrameOptionsPage={}
for i=1, getn(TOCA.OptionTabs) do
  TOCA.FrameOptionsPage[TOCA.OptionTabs[i]] = CreateFrame("Frame", "TOCA.FrameOptions", TOCA.FrameOptions, "BackdropTemplate")
  TOCA.FrameOptionsPage[TOCA.OptionTabs[i]]:SetWidth(TOCA.FrameOptions:GetWidth())
  TOCA.FrameOptionsPage[TOCA.OptionTabs[i]]:SetHeight(TOCA.FrameOptions:GetHeight())
  TOCA.FrameOptionsPage[TOCA.OptionTabs[i]]:SetPoint("CENTER", 0, 0)
  TOCA.FrameOptionsPage[TOCA.OptionTabs[i]]:Hide()

  TOCA.Button.TabOptionsBack[i]= CreateFrame("Button", nil, TOCA.FrameOptions, "BackdropTemplate")
  TOCA.Button.TabOptionsBack[i]:SetSize(TOCA.TabWidth.Options-20, 29)
  TOCA.Button.TabOptionsBack[i]:SetPoint("TOPLEFT", -110+i*120, 25)
  TOCA.Button.TabOptionsBack[i]:SetBackdrop({
    bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
    edgeFile= "",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  })
  TOCA.Button.TabOptions[i]= CreateFrame("Button", nil, TOCA.Button.TabOptionsBack[i], "BackdropTemplate")
  TOCA.Button.TabOptions[i]:SetSize(TOCA.TabWidth.Options, 32)
  TOCA.Button.TabOptions[i]:SetPoint("CENTER", 0, 0)
  TOCA.Button.TabOptions[i]:SetBackdrop({
    bgFile  = "Interface/OPTIONSFRAME/UI-OptionsFrame-ActiveTab",
    --edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeFile= "",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  })
  --TOCA.Button.TabOptions[i]:SetBackdropColor(0.7, 0, 0, 1)
  --TOCA.Button.TabOptions[i]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.Button.TabOptions[i].text = TOCA.Button.TabOptions[i]:CreateFontString(nil, "ARTWORK")
  TOCA.Button.TabOptions[i].text:SetFont(TOCA.Global.font, 12, "OUTLINE")
  TOCA.Button.TabOptions[i].text:SetPoint("CENTER", 0, 0)
  TOCA.Button.TabOptions[i].text:SetText(TOCA.OptionTabs[i])
  TOCA.Button.TabOptions[i]:SetScript("OnClick", function()
    for i=1, getn(TOCA.OptionTabs) do
      TOCA.FrameOptionsPage[TOCA.OptionTabs[i]]:Hide()
      TOCA.Button.TabOptionsBack[i]:SetSize(TOCA.TabWidth.Options-20, 29)
    end
    TOCA.FrameOptionsPage[TOCA.OptionTabs[i]]:Show()
    TOCA.Button.TabOptionsBack[i]:SetSize(TOCA.TabWidth.Options-20, 30)
  end)
end
TOCA.Button.TabOptionsBack[1]:SetSize(TOCA.TabWidth.Options-20, 30) --first tab
TOCA.FrameOptionsPage[TOCA.OptionTabs[1]]:Show() --show first tab

TOCA.Dropdown.FrameStyle={}
TOCA.Dropdown.FrameStyles={"Classic", "Grid Vertical", "Grid Horizontal"}
TOCA.Dropdown.FrameStyle = CreateFrame("Frame", nil, TOCA.FrameOptionsPage[TOCA.OptionTabs[1]], "UIDropDownMenuTemplate")
TOCA.Dropdown.FrameStyle:SetPoint("TOPLEFT", 10, -35)
TOCA.Dropdown.FrameStyle.displayMode = "MENU"
TOCA.Dropdown.FrameStyle.text = TOCA.Dropdown.FrameStyle:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.FrameStyle.text:SetFont(TOCA.Global.font, 11)
TOCA.Dropdown.FrameStyle.text:SetPoint("TOPLEFT", TOCA.Dropdown.FrameStyle, "TOPLEFT", 25, -8)
TOCA.Dropdown.FrameStyle.text:SetText(TOCA.Dropdown.FrameStyles[1])
TOCA.Dropdown.FrameStyle:SetScript("OnEnter", function()
  TOCA.TooltipMenu("Frame Style", "|cffffffffClassic|r\nFour primary totems that are commonly used|nselectable or profile built.|n|n|cffffffffGrid Vertical|r|nAll known Totems are displayed vertically organized|nby category row.|n|n|cffffffffGrid Horizontally|r|nAll known Totems are displayed Horizontally organized|nby category row.|n|nThe totem category orders are configurable|nin the options menu.", 235)
end)
TOCA.Dropdown.FrameStyle:SetScript("OnLeave", function()
  TOCA.Tooltip:Hide()
end)
TOCA.Dropdown.FrameStyle.onClick = function(self, checked)
  TOCA.Dropdown.FrameStyle.text:SetText(self.value)

  if (TOCADB[TOCA.player.combine]["CONFIG"]["TOTEMORDER"]) then
    --TOCA.BuildTotemOrder()
  else
    TOCA.BuildTotemOrder()
  end

  TOCADB[TOCA.player.combine]["CONFIG"]["FRAMESTYLE"] = self.value
  TOCA.FrameStyleSet(self.value)
end
TOCA.Dropdown.FrameStyle.initialize = function(self, level)
  local info = UIDropDownMenu_CreateInfo()
  local i = 0
  for k,v in pairs(TOCA.Dropdown.FrameStyles) do
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
UIDropDownMenu_SetWidth(TOCA.Dropdown.FrameStyle, 125)
TOCA.Dropdown.FrameStyle.title = TOCA.FrameOptionsPage[TOCA.OptionTabs[1]]:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.FrameStyle.title:SetFont(TOCA.Global.font, 12)
TOCA.Dropdown.FrameStyle.title:SetPoint("TOPLEFT", 30, -20)
TOCA.Dropdown.FrameStyle.title:SetText("Frame Totem Layout")
TOCA.Dropdown.FrameStyle.title:SetTextColor(1, 1, 0.5, 1)

TOCA.Dropdown.FrameStrat={}
TOCA.Dropdown.FrameStrats={"LOW", "MEDIUM", "HIGH", "DIALOG"}
TOCA.Dropdown.FrameStrat = CreateFrame("Frame", nil, TOCA.FrameOptionsPage[TOCA.OptionTabs[1]], "UIDropDownMenuTemplate")
TOCA.Dropdown.FrameStrat:SetPoint("TOPLEFT", 10, -95)
TOCA.Dropdown.FrameStrat.displayMode = "MENU"
TOCA.Dropdown.FrameStrat.text = TOCA.Dropdown.FrameStrat:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.FrameStrat.text:SetFont(TOCA.Global.font, 11)
TOCA.Dropdown.FrameStrat.text:SetPoint("TOPLEFT", TOCA.Dropdown.FrameStrat, "TOPLEFT", 25, -8)
TOCA.Dropdown.FrameStrat.text:SetText(TOCA.Dropdown.FrameStrats[2])
TOCA.Dropdown.FrameStrat:SetScript("OnEnter", function(self)
  TOCA.TooltipMenu("Frame Layer", "Sets the overlap over other menu and action bar items|non your screen.|nHigher frames will take precedence over items on screen.", 120)
end)
TOCA.Dropdown.FrameStrat:SetScript("OnLeave", function(self)
  TOCA.Tooltip:Hide()
end)
TOCA.Dropdown.FrameStrat.onClick = function(self, checked)
  TOCA.Dropdown.FrameStrat.text:SetText(self.value)
  TOCA.Notification(self.value, true)
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
TOCA.Dropdown.FrameStrat.title = TOCA.FrameOptionsPage[TOCA.OptionTabs[1]]:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.FrameStrat.title:SetFont(TOCA.Global.font, 12)
TOCA.Dropdown.FrameStrat.title:SetPoint("TOPLEFT", 30, -80)
TOCA.Dropdown.FrameStrat.title:SetText("Frame Layer")
TOCA.Dropdown.FrameStrat.title:SetTextColor(1, 1, 0.5, 1)

TOCA.FrameOptions.TitleSlider = TOCA.FrameOptionsPage[TOCA.OptionTabs[1]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.TitleSlider:SetFont(TOCA.Global.font, 12)
TOCA.FrameOptions.TitleSlider:SetPoint("TOPLEFT", 30, -150)
TOCA.FrameOptions.TitleSlider:SetText("Frame Scale")
TOCA.FrameOptions.TitleSlider:SetTextColor(1, 1, 0.5, 1)


TOCA.Slider.Scale={}
TOCA.Slider.Scale = CreateFrame("Slider", "TOCA.Slider.Scale", TOCA.FrameOptionsPage[TOCA.OptionTabs[1]], "OptionsSliderTemplate")
TOCA.Slider.Scale:SetWidth(140)
TOCA.Slider.Scale:SetHeight(14)
TOCA.Slider.Scale:SetPoint("TOPLEFT", 30, -170)
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
--getglobal(TOCA.Slider.Scale:GetName() .. 'Text'):SetText("Scale")
TOCA.Slider.Scale:SetScript("OnValueChanged", function()
  TOCA.FrameMain:SetScale(TOCA.Round(TOCA.Slider.Scale:GetValue(), 2))
  TOCA.Slider.Scale.Val:SetText(TOCA.Round(TOCA.Slider.Scale:GetValue(), 2))
end)
TOCA.Slider.Scale:SetScript("OnLeave", function()
  local transparentVal = tonumber(TOCA.Slider.Scale:GetValue())
  TOCADB[TOCA.player.combine]["CONFIG"]["SCALE"] = TOCA.Round(TOCA.Slider.Scale:GetValue(), 2)
end)
TOCA.Button.ResetScale= CreateFrame("Button", nil, TOCA.FrameOptionsPage[TOCA.OptionTabs[1]], "BackdropTemplate")
TOCA.Button.ResetScale:SetSize(25, 25)
TOCA.Button.ResetScale:SetPoint("TOPLEFT", 190, -160)
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

TOCA.Button.ResetPosition= CreateFrame("Button", nil, TOCA.FrameOptionsPage[TOCA.OptionTabs[1]], "BackdropTemplate")
TOCA.Button.ResetPosition:SetSize(100, 25)
TOCA.Button.ResetPosition:SetPoint("TOPLEFT", 220, -160)
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

TOCA.FrameOptions.TitleSlider = TOCA.FrameOptionsPage[TOCA.OptionTabs[1]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.TitleSlider:SetFont(TOCA.Global.font, 12)
TOCA.FrameOptions.TitleSlider:SetPoint("TOPLEFT", 30, -220)
TOCA.FrameOptions.TitleSlider:SetText("Frame Opacity")
TOCA.FrameOptions.TitleSlider:SetTextColor(1, 1, 0.5, 1)

TOCA.Slider.Opacity={}
TOCA.Slider.Opacity = CreateFrame("Slider", "TOCA.Slider.Opacity", TOCA.FrameOptionsPage[TOCA.OptionTabs[1]], "OptionsSliderTemplate")
TOCA.Slider.Opacity:SetWidth(140)
TOCA.Slider.Opacity:SetHeight(14)
TOCA.Slider.Opacity:SetPoint("TOPLEFT", 30, -240)
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
--getglobal(TOCA.Slider.Opacity:GetName() .. 'Text'):SetText('Background Opacity')
TOCA.Slider.Opacity:SetScript("OnValueChanged", function()
  TOCA.FrameMain.Background:SetAlpha(TOCA.Round(TOCA.Slider.Opacity:GetValue(), 2))
  --TOCA.FrameMain.ReincFrame:SetAlpha(TOCA.Round(TOCA.Slider.Opacity:GetValue(), 2))
  TOCA.Button.TotemicCall.ECL:SetAlpha(TOCA.Round(TOCA.Slider.Opacity:GetValue(), 2))
  TOCA.Button.TotemicCall.ECR:SetAlpha(TOCA.Round(TOCA.Slider.Opacity:GetValue(), 2))
  TOCA.Slider.Opacity.Val:SetText(TOCA.Round(TOCA.Slider.Opacity:GetValue(), 2))
end)

TOCA.Slider.Opacity:SetScript("OnLeave", function()
  local transparentVal = tonumber(TOCA.Slider.Opacity:GetValue())
  TOCADB[TOCA.player.combine]["CONFIG"]["OPACITY"] = TOCA.Round(TOCA.Slider.Opacity:GetValue(), 2)
end)
TOCA.Button.ResetOpacity= CreateFrame("Button", nil, TOCA.FrameOptionsPage[TOCA.OptionTabs[1]], "BackdropTemplate")
TOCA.Button.ResetOpacity:SetSize(25, 25)
TOCA.Button.ResetOpacity:SetPoint("TOPLEFT", 190, -230)
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

--[==[
TOCA.OptionsDivider = TOCA.FrameOptions:CreateTexture(nil, "ARTWORK")
TOCA.OptionsDivider:SetSize(4, 340)
TOCA.OptionsDivider:SetPoint("CENTER", 0, 20)
TOCA.OptionsDivider:SetTexture("Interface/DialogFrame/DialogFrame-Left")
]==]--

TOCA.FrameOptions.TitleMenu = TOCA.FrameOptionsPage[TOCA.OptionTabs[1]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.TitleMenu:SetFont(TOCA.Global.font, 12)
TOCA.FrameOptions.TitleMenu:SetPoint("TOPLEFT", 400, -20)
TOCA.FrameOptions.TitleMenu:SetText("Frame Menu")
TOCA.FrameOptions.TitleMenu:SetTextColor(1, 1, 0.5, 1)

TOCA.Checkbox.MainLock={}
TOCA.Checkbox.MainLock = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.OptionTabs[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.MainLock:SetPoint("TOPLEFT", 400, -40)
TOCA.Checkbox.MainLock:SetChecked(1)
TOCA.Checkbox.MainLock.text = TOCA.Checkbox.MainLock:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.MainLock.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.MainLock.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.MainLock.text:SetText("Lock Frame While In Combat")
TOCA.Checkbox.MainLock:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["COMBATLOCK"] = "ON"
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["COMBATLOCK"] = "OFF"
  end
end)

TOCA.Checkbox.MainMenu={}
TOCA.Checkbox.MainMenu = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.OptionTabs[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.MainMenu:SetPoint("TOPLEFT", 400, -60)
TOCA.Checkbox.MainMenu:SetChecked(1)
TOCA.Checkbox.MainMenu.text = TOCA.Checkbox.MainMenu:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.MainMenu.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.MainMenu.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.MainMenu.text:SetText("Display Main Menu/Options Buttons")
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
    TOCA.Notification("Menu header disabled. Type '"..TCCMD.." options' to reopen.")
  end
end)

TOCA.Checkbox.EndCaps={}
TOCA.Checkbox.EndCaps = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.OptionTabs[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.EndCaps:SetPoint("TOPLEFT", 400, -80)
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
TOCA.Dropdown.FrameGryphons={}
TOCA.Dropdown.FrameGryphonsSel={"Gryphons", "Lions"}
TOCA.Dropdown.FrameGryphons = CreateFrame("Frame", nil, TOCA.FrameOptionsPage[TOCA.OptionTabs[1]], "UIDropDownMenuTemplate")
TOCA.Dropdown.FrameGryphons:SetPoint("TOPLEFT", 410, -100)
TOCA.Dropdown.FrameGryphons.displayMode = "MENU"
TOCA.Dropdown.FrameGryphons.text = TOCA.Dropdown.FrameGryphons:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.FrameGryphons.text:SetFont(TOCA.Global.font, 11)
TOCA.Dropdown.FrameGryphons.text:SetPoint("TOPLEFT", TOCA.Dropdown.FrameGryphons, "TOPLEFT", 25, -8)
TOCA.Dropdown.FrameGryphons.text:SetText(TOCA.Dropdown.FrameGryphonsSel[1])
TOCA.Dropdown.FrameGryphons.onClick = function(self, checked)
  TOCA.Dropdown.FrameGryphons.text:SetText(self.value)
  TOCADB[TOCA.player.combine]["CONFIG"]["ENDCAPSTYLE"] = self.value
  TOCA.Button.TotemicCall.ECL:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Dwarf")
  TOCA.Button.TotemicCall.ECR:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Dwarf")
  if (self.value == "Lions") then
    TOCA.Button.TotemicCall.ECL:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Human")
    TOCA.Button.TotemicCall.ECR:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Human")
  end
end
TOCA.Dropdown.FrameGryphons.initialize = function(self, level)
  local info = UIDropDownMenu_CreateInfo()
  local i = 0
  for k,v in pairs(TOCA.Dropdown.FrameGryphonsSel) do
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
UIDropDownMenu_SetWidth(TOCA.Dropdown.FrameGryphons, 125)
--[==[
TOCA.Dropdown.FrameGryphons.title = TOCA.FrameOptionsPage[TOCA.OptionTabs[1]]:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.FrameGryphons.title:SetFont(TOCA.Global.font, 12)
TOCA.Dropdown.FrameGryphons.title:SetPoint("TOPLEFT", 30, -20)
TOCA.Dropdown.FrameGryphons.title:SetText("Frame Style")
TOCA.Dropdown.FrameGryphons.title:SetTextColor(1, 1, 0.5, 1)
]==]--

TOCA.FrameOptions.TitleTimer = TOCA.FrameOptionsPage[TOCA.OptionTabs[1]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.TitleTimer:SetFont(TOCA.Global.font, 12)
TOCA.FrameOptions.TitleTimer:SetPoint("TOPLEFT", 400, -140)
TOCA.FrameOptions.TitleTimer:SetText("Timers")
TOCA.FrameOptions.TitleTimer:SetTextColor(1, 1, 0.5, 1)

TOCA.Checkbox.Timers={}
TOCA.Checkbox.Timers = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.OptionTabs[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.Timers:SetPoint("TOPLEFT", 400, -160)
TOCA.Checkbox.Timers:SetChecked(1)
TOCA.Checkbox.Timers.text = TOCA.Checkbox.Timers:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.Timers.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.Timers.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.Timers.text:SetText("Display Totem Timers")
TOCA.Checkbox.Timers:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["TIMERS"] = "ON"
    for i=1, 4 do
      TOCA.Slot.Timer[i]:Show()
    end
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["TIMERS"] = "OFF"
    for i=1, 4 do
      TOCA.Slot.Timer[i]:Hide()
    end
  end
end)

TOCA.Checkbox.TimersInMinutes={}
TOCA.Checkbox.TimersInMinutes = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.OptionTabs[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.TimersInMinutes:SetPoint("TOPLEFT", 400, -180)
TOCA.Checkbox.TimersInMinutes:SetChecked(1)
TOCA.Checkbox.TimersInMinutes.text = TOCA.Checkbox.TimersInMinutes:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.TimersInMinutes.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.TimersInMinutes.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.TimersInMinutes.text:SetText("Display Totem Timers In Minutes")
TOCA.Checkbox.TimersInMinutes:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["TIMERSMINUTES"] = "ON"
    TOCA.globalTimerInMinutes = true
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["TIMERSMINUTES"] = "OFF"
    TOCA.globalTimerInMinutes = false
  end
end)

TOCA.Checkbox.Reinc={}
TOCA.Checkbox.Reinc = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.OptionTabs[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.Reinc:SetPoint("TOPLEFT", 400, -200)
TOCA.Checkbox.Reinc:SetChecked(1)
TOCA.Checkbox.Reinc.text = TOCA.Checkbox.Reinc:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.Reinc.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.Reinc.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.Reinc.text:SetText("Display Reincarnation Timer (Cooldown)")
TOCA.Checkbox.Reinc:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["REINC"] = "ON"
    TOCA.GetReincTimer()
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["REINC"] = "OFF"
    TOCA.FrameMain.ReincFrame:Hide()
  end
end)

TOCA.FrameOptions.TitleTooltip = TOCA.FrameOptionsPage[TOCA.OptionTabs[1]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.TitleTooltip:SetFont(TOCA.Global.font, 12)
TOCA.FrameOptions.TitleTooltip:SetPoint("TOPLEFT", 400, -240)
TOCA.FrameOptions.TitleTooltip:SetText("Tooltip")
TOCA.FrameOptions.TitleTooltip:SetTextColor(1, 1, 0.5, 1)

TOCA.Checkbox.Tooltip={}
TOCA.Checkbox.Tooltip = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.OptionTabs[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.Tooltip:SetPoint("TOPLEFT", 400, -260)
TOCA.Checkbox.Tooltip:SetChecked(1)
TOCA.Checkbox.Tooltip.text = TOCA.Checkbox.Tooltip:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.Tooltip.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.Tooltip.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.Tooltip.text:SetText("Display Totem Tooltip")
TOCA.Checkbox.Tooltip:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["TOOLON"] = "ON"
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["TOOLON"] = "OFF"
  end
end)

TOCA.Checkbox.TooltipMouse={}
TOCA.Checkbox.TooltipMouse = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.OptionTabs[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.TooltipMouse:SetPoint("TOPLEFT", 400, -280)
TOCA.Checkbox.TooltipMouse:SetChecked(1)
TOCA.Checkbox.TooltipMouse.text = TOCA.Checkbox.TooltipMouse:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.TooltipMouse.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.TooltipMouse.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.TooltipMouse.text:SetText("Anchor Tooltip to Cursor")
TOCA.Checkbox.TooltipMouse:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["TOOLMOUSE"] = "ON"
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["TOOLMOUSE"] = "OFF"
  end
end)

--[==[
TOCA.Button.TooltipPosition= CreateFrame("Button", nil, TOCA.FrameOptionsPage[TOCA.OptionTabs[1]], "BackdropTemplate")
TOCA.Button.TooltipPosition:SetSize(100, 25)
TOCA.Button.TooltipPosition:SetPoint("TOPLEFT", 425, -285)
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
]==]--

movingTotem= "nil"
overTotem = "nil"
TOCA.SlotSets_x = -60
TOCA.SlotOrderTitle = TOCA.FrameOptionsPage[TOCA.OptionTabs[2]]:CreateFontString(nil, "ARTWORK")
TOCA.SlotOrderTitle:SetFont(TOCA.Global.font, 12)
TOCA.SlotOrderTitle:SetPoint("TOPLEFT", 30, -190)
TOCA.SlotOrderTitle:SetText("Totem Order")
TOCA.SlotOrderTitle:SetTextColor(1, 1, 0.5, 1)

TOCA.SlotOrderIcon={}
TOCA.SlotOrderBack={}
TOCA.Dropdown.OrderSet={}

for i=1, getn(TOCA.Dropdown.OrderSetMenu) do
  TOCA.SlotSets_x = TOCA.SlotSets_x + 66
  TOCA.Dropdown.OrderSet[i] = CreateFrame("Frame", nil, TOCA.FrameOptionsPage[TOCA.OptionTabs[2]], "UIDropDownMenuTemplate")
  TOCA.Dropdown.OrderSet[i]:SetPoint("TOPLEFT", TOCA.SlotSets_x+6, -210)
  TOCA.Dropdown.OrderSet[i].displayMode = "MENU"
  TOCA.Dropdown.OrderSet[i].text = TOCA.Dropdown.OrderSet[i]:CreateFontString(nil, "ARTWORK")
  TOCA.Dropdown.OrderSet[i].text:SetFont(TOCA.Global.font, 10)
  TOCA.Dropdown.OrderSet[i].text:SetPoint("TOPLEFT", TOCA.Dropdown.OrderSet[i], "TOPLEFT", 25, -10)
  TOCA.Dropdown.OrderSet[i].text:SetText(TOCA.Dropdown.OrderSetMenu[i])
  TOCA.Dropdown.OrderSet[i].onClick = function(self, checked)
    TOCA.Dropdown.OrderSet[i].text:SetText(self.value)
    TOCA.Notification(self.value, true)
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
end

TOCA.FrameOptions.Divider = TOCA.FrameOptions:CreateTexture(nil, "ARTWORK")
TOCA.FrameOptions.Divider:SetSize(TOCA.FrameOptions_w-6, 4)
TOCA.FrameOptions.Divider:SetPoint("TOPLEFT", 3, -360)
TOCA.FrameOptions.Divider:SetTexture("Interface/DialogFrame/DialogFrame-TOP")
--TOCA.FrameOptions.Divider:Hide()

TOCA.FrameOptions.Title = TOCA.FrameOptions:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.Title:SetFont(TOCA.Global.font, 12)
TOCA.FrameOptions.Title:SetPoint("TOPLEFT", 10, -TOCA.FrameOptions_h+25)
TOCA.FrameOptions.Title:SetText(TOCA.Global.title .. " Options v" .. TOCA.Global.version .. "-" .. TOCA.Global.suffix)


TOCA.Button.OptionsClose= CreateFrame("Button", nil, TOCA.FrameOptions, "BackdropTemplate")
TOCA.Button.OptionsClose:SetSize(100, 25)
TOCA.Button.OptionsClose:SetPoint("CENTER", 0, -180)
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
  --TOCA.Button.OptionsClose:Hide()
  --TOCA.FrameOptions.Divider:Hide()
  --TOCA.FrameOptions.Title:Hide()
end)
TOCA.Button.OptionsCloseText = TOCA.Button.OptionsClose:CreateFontString(nil, "ARTWORK")
TOCA.Button.OptionsCloseText:SetFont(TOCA.Global.font, 11)
TOCA.Button.OptionsCloseText:SetPoint("CENTER", 0, 0)
TOCA.Button.OptionsCloseText:SetText("Close")
TOCA.Button.OptionsClose:SetFrameStrata("TOOLTIP")
--TOCA.Button.OptionsClose:Hide()

TOCA.FrameOptionsMain = CreateFrame("Frame", "TOCA.FrameOptionsMain", UIParent, "BackdropTemplate")
TOCA.FrameOptionsMain.Options= CreateFrame("Button", nil, TOCA.FrameOptionsMain, "BackdropTemplate")
TOCA.FrameOptionsMain.Options:SetSize(150, 25)
TOCA.FrameOptionsMain.Options:SetPoint("CENTER", 0, 0)
TOCA.FrameOptionsMain.Options:SetBackdrop(TOCA.Backdrop.Button)
TOCA.FrameOptionsMain.Options:SetBackdropColor(0.6, 0, 0, 1)
TOCA.FrameOptionsMain.Options:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameOptionsMain.Options:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.FrameOptionsMain.Options:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.FrameOptionsMain.Options:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
  TOCA.FrameMain:Show()
  TOCA.FrameOptions:Show()
end)
TOCA.FrameOptionsMain.Title = TOCA.FrameOptionsMain.Options:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptionsMain.Title:SetFont(TOCA.Global.font, 11)
TOCA.FrameOptionsMain.Title:SetPoint("CENTER", 0, 0)
TOCA.FrameOptionsMain.Title:SetText("Totem Caddy Options")
