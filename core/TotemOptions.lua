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
TOCA.FrameOptions_h = 520

TOCA.OptionsPosition_x={}
TOCA.OptionsPosition_x["RIGHT"]=400
TOCA.OptionsPosition_y={}
TOCA.OptionsPosition_y["FRAMEMENU"] = 0
TOCA.OptionsPosition_y["TIMERS"] = -190
TOCA.OptionsPosition_y["TOOLTIP"] = -310
TOCA.OptionsPosition_y["NOTIFICATIONS"] = -390

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

TOCA.FrameOptions.Title={}
TOCA.FrameOptions.Section={}

TOCA.TabWidth.Options = 140
TOCA.Button.TabOptions={}
TOCA.Button.TabOptionsBack={}

TOCA.FrameOptionsPage={}
for i=1, getn(TOCA.locale.UI.TABS.OPTIONS) do
  TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[i]] = CreateFrame("Frame", "TOCA.FrameOptions", TOCA.FrameOptions, "BackdropTemplate")
  TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[i]]:SetWidth(TOCA.FrameOptions:GetWidth())
  TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[i]]:SetHeight(TOCA.FrameOptions:GetHeight())
  TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[i]]:SetPoint("CENTER", 0, 0)
  TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[i]]:Hide()

  TOCA.Button.TabOptionsBack[i]= CreateFrame("Button", nil, TOCA.FrameOptions, "BackdropTemplate")
  TOCA.Button.TabOptionsBack[i]:SetSize(TOCA.TabWidth.Options-20, 29)
  TOCA.Button.TabOptionsBack[i]:SetPoint("TOPLEFT", -110+i*120, 25)
  TOCA.Button.TabOptionsBack[i]:SetBackdrop({
    bgFile  = "Interface/ToolTips/UI-Tooltip-Background",
    edgeFile= "",
    edgeSize= 12,
    insets  = {left=4, right=4, top=4, bottom=2},
  })
  TOCA.Button.TabOptionsBack[i]:SetBackdropColor(0, 0, 0, 0.8)

  TOCA.Button.TabOptions[i]= CreateFrame("Button", nil, TOCA.Button.TabOptionsBack[i], "BackdropTemplate")
  TOCA.Button.TabOptions[i]:SetSize(TOCA.TabWidth.Options, 32)
  TOCA.Button.TabOptions[i]:SetPoint("CENTER", 0, 0)
  TOCA.Button.TabOptions[i]:SetBackdrop({
    bgFile  = "Interface/OPTIONSFRAME/UI-OptionsFrame-ActiveTab",
    edgeFile= "",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  })
  TOCA.Button.TabOptions[i].text = TOCA.Button.TabOptions[i]:CreateFontString(nil, "ARTWORK")
  TOCA.Button.TabOptions[i].text:SetFont(TOCA.Global.font, 12, "OUTLINE")
  TOCA.Button.TabOptions[i].text:SetPoint("CENTER", 0, 0)
  TOCA.Button.TabOptions[i].text:SetText(TOCA.locale.UI.TABS.OPTIONS[i])
  TOCA.Button.TabOptions[i]:SetScript("OnClick", function()
    for i=1, getn(TOCA.locale.UI.TABS.OPTIONS) do
      TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[i]]:Hide()
      TOCA.Button.TabOptionsBack[i]:SetSize(TOCA.TabWidth.Options-20, 29)
    end
    TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[i]]:Show()
    TOCA.Button.TabOptionsBack[i]:SetSize(TOCA.TabWidth.Options-20, 30)
  end)
end
TOCA.Button.TabOptionsBack[1]:SetSize(TOCA.TabWidth.Options-20, 30) --first tab
TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]]:Show() --show first tab

TOCA.Dropdown.FrameStyles={"Classic", "Grid Vertical", "Grid Horizontal"}
TOCA.Dropdown.FrameStyle={}
TOCA.Dropdown.FrameStyle = CreateFrame("Frame", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "UIDropDownMenuTemplate")
TOCA.Dropdown.FrameStyle:SetPoint("TOPLEFT", 10, -35)
TOCA.Dropdown.FrameStyle.displayMode = "MENU"
TOCA.Dropdown.FrameStyle.text = TOCA.Dropdown.FrameStyle:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.FrameStyle.text:SetFont(TOCA.Global.font, 11)
TOCA.Dropdown.FrameStyle.text:SetPoint("TOPLEFT", TOCA.Dropdown.FrameStyle, "TOPLEFT", 25, -8)
TOCA.Dropdown.FrameStyle.text:SetText(TOCA.Dropdown.FrameStyles[1])
TOCA.Dropdown.FrameStyle:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, TOCA.locale.UI.OPTIONS[1][1], TOCA.locale.UI.OPTIONS[1][2])
end)
TOCA.Dropdown.FrameStyle:SetScript("OnLeave", function()
  TOCA.CloseAllMenus()
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
TOCA.Dropdown.FrameStyle.title = TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]]:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.FrameStyle.title:SetFont(TOCA.Global.font, 12)
TOCA.Dropdown.FrameStyle.title:SetPoint("TOPLEFT", 30, -20)
TOCA.Dropdown.FrameStyle.title:SetText(TOCA.locale.UI.OPTIONS[1][1])
TOCA.Dropdown.FrameStyle.title:SetTextColor(1, 1, 0.5, 1)

TOCA.Dropdown.FrameStrats={"LOW", "MEDIUM", "HIGH", "DIALOG"}
TOCA.Dropdown.FrameStrat={}
TOCA.Dropdown.FrameStrat = CreateFrame("Frame", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "UIDropDownMenuTemplate")
TOCA.Dropdown.FrameStrat:SetPoint("TOPLEFT", 10, -95)
TOCA.Dropdown.FrameStrat.displayMode = "MENU"
TOCA.Dropdown.FrameStrat.text = TOCA.Dropdown.FrameStrat:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.FrameStrat.text:SetFont(TOCA.Global.font, 11)
TOCA.Dropdown.FrameStrat.text:SetPoint("TOPLEFT", TOCA.Dropdown.FrameStrat, "TOPLEFT", 25, -8)
TOCA.Dropdown.FrameStrat.text:SetText(TOCA.Dropdown.FrameStrats[2])
TOCA.Dropdown.FrameStrat:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.title:GetText(), TOCA.locale.UI.OPTIONS[2][2])
end)
TOCA.Dropdown.FrameStrat:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
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
TOCA.Dropdown.FrameStrat.title = TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]]:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.FrameStrat.title:SetFont(TOCA.Global.font, 12)
TOCA.Dropdown.FrameStrat.title:SetPoint("TOPLEFT", 30, -80)
TOCA.Dropdown.FrameStrat.title:SetText(TOCA.locale.UI.OPTIONS[2][1])
TOCA.Dropdown.FrameStrat.title:SetTextColor(1, 1, 0.5, 1)

TOCA.FrameOptions.Title.Scale = TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.Title.Scale:SetFont(TOCA.Global.font, 12)
TOCA.FrameOptions.Title.Scale:SetPoint("TOPLEFT", 30, -150)
TOCA.FrameOptions.Title.Scale:SetText(TOCA.locale.UI.OPTIONS[3][1])
TOCA.FrameOptions.Title.Scale:SetTextColor(1, 1, 0.5, 1)
TOCA.Slider.Scale={}
TOCA.Slider.Scale = CreateFrame("Slider", "TOCA.Slider.Scale", TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "OptionsSliderTemplate")
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
TOCA.Slider.Scale:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, TOCA.FrameOptions.Title.Scale:GetText(), TOCA.locale.UI.OPTIONS[3][2])
end)
TOCA.Slider.Scale:SetScript("OnLeave", function()
  TOCADB[TOCA.player.combine]["CONFIG"]["SCALE"] = TOCA.Round(TOCA.Slider.Scale:GetValue(), 2)
  TOCA.CloseAllMenus()
end)
TOCA.Button.ResetScale= CreateFrame("Button", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "BackdropTemplate")
TOCA.Button.ResetScale:SetSize(25, 25)
TOCA.Button.ResetScale:SetPoint("TOPLEFT", 180, -160)
TOCA.Button.ResetScale:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.ResetScale:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.ResetScale:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.ResetScale:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
  TOCA.TooltipDisplay(self, TOCA.locale.UI.OPTIONS[4][1], TOCA.locale.UI.OPTIONS[4][2])
end)
TOCA.Button.ResetScale:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.CloseAllMenus()
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

TOCA.Button.ResetPosition= CreateFrame("Button", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "BackdropTemplate")
TOCA.Button.ResetPosition:SetSize(100, 25)
TOCA.Button.ResetPosition:SetPoint("TOPLEFT", 210, -160)
TOCA.Button.ResetPosition:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.ResetPosition:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.ResetPosition:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.ResetPosition:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
  TOCA.TooltipDisplay(self, TOCA.locale.UI.OPTIONS[5][1], TOCA.locale.UI.OPTIONS[5][2])
end)
TOCA.Button.ResetPosition:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.CloseAllMenus()
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

TOCA.FrameOptions.Title.OpacityBG = TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.Title.OpacityBG:SetFont(TOCA.Global.font, 12)
TOCA.FrameOptions.Title.OpacityBG:SetPoint("TOPLEFT", 30, -220)
TOCA.FrameOptions.Title.OpacityBG:SetText("Background Opacity")
TOCA.FrameOptions.Title.OpacityBG:SetTextColor(1, 1, 0.5, 1)
TOCA.Slider.OpacityBG={}
TOCA.Slider.OpacityBG = CreateFrame("Slider", "TOCA.Slider.OpacityBG", TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "OptionsSliderTemplate")
TOCA.Slider.OpacityBG:SetWidth(140)
TOCA.Slider.OpacityBG:SetHeight(14)
TOCA.Slider.OpacityBG:SetPoint("TOPLEFT", 30, -240)
TOCA.Slider.OpacityBG:SetOrientation('HORIZONTAL')
TOCA.Slider.OpacityBG:EnableMouse(true)
TOCA.Slider.OpacityBG:SetMinMaxValues(0.00, 1.0)
TOCA.Slider.OpacityBGMin, TOCA.Slider.OpacityBGMax = TOCA.Slider.OpacityBG:GetMinMaxValues()
TOCA.Slider.OpacityBG:SetValue(1.0)
TOCA.Slider.OpacityBG.Val = TOCA.Slider.OpacityBG:CreateFontString(nil, "ARTWORK")
TOCA.Slider.OpacityBG.Val:SetFont(TOCA.Global.font, 11, "OUTLINE")
TOCA.Slider.OpacityBG.Val:SetPoint("CENTER", 0, -14)
TOCA.Slider.OpacityBG.Val:SetText("")
getglobal(TOCA.Slider.OpacityBG:GetName() .. 'Low'):SetText('0')
getglobal(TOCA.Slider.OpacityBG:GetName() .. 'High'):SetText('1')
TOCA.Slider.OpacityBG:SetScript("OnValueChanged", function()
  TOCA.FrameMain.Background:SetAlpha(TOCA.Round(TOCA.Slider.OpacityBG:GetValue(), 2))
  --TOCA.Button.CloseMain:SetAlpha(TOCA.Round(TOCA.Slider.OpacityBG:GetValue(), 2))
  --TOCA.Button.Options:SetAlpha(TOCA.Round(TOCA.Slider.OpacityBG:GetValue(), 2))
  TOCA.Button.TotemicCall.ECL:SetAlpha(TOCA.Round(TOCA.Slider.OpacityBG:GetValue(), 2))
  TOCA.Button.TotemicCall.ECR:SetAlpha(TOCA.Round(TOCA.Slider.OpacityBG:GetValue(), 2))
  TOCA.Slider.OpacityBG.Val:SetText(TOCA.Round(TOCA.Slider.OpacityBG:GetValue(), 2))
end)
TOCA.Slider.OpacityBG:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, TOCA.FrameOptions.Title.OpacityBG:GetText(), "Increase/Decrease the background frame transparency.")
end)
TOCA.Slider.OpacityBG:SetScript("OnLeave", function()
  TOCADB[TOCA.player.combine]["CONFIG"]["OPACITY"] = TOCA.Round(TOCA.Slider.OpacityBG:GetValue(), 2)
  TOCA.CloseAllMenus()
end)
TOCA.Button.ResetOpacityBG= CreateFrame("Button", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "BackdropTemplate")
TOCA.Button.ResetOpacityBG:SetSize(25, 25)
TOCA.Button.ResetOpacityBG:SetPoint("TOPLEFT", 180, -230)
TOCA.Button.ResetOpacityBG:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.ResetOpacityBG:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.ResetOpacityBG:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.ResetOpacityBG:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
  TOCA.TooltipDisplay(self, "Reset Background Opacity", "Reset the background opacity to the default value.")
end)
TOCA.Button.ResetOpacityBG:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.CloseAllMenus()
end)
TOCA.Button.ResetOpacityBG:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
  TOCA.Slider.OpacityBG:SetValue(1.0)
  TOCADB[TOCA.player.combine]["CONFIG"]["OPACITY"] = "1.0"
end)
TOCA.Button.ResetOpacityBG.icon = TOCA.Button.ResetOpacityBG:CreateTexture(nil, "ARTWORK")
TOCA.Button.ResetOpacityBG.icon:SetSize(16, 16)
TOCA.Button.ResetOpacityBG.icon:SetPoint("CENTER", 0, 0)
TOCA.Button.ResetOpacityBG.icon:SetTexture("Interface/Buttons/UI-RefreshButton")

TOCA.FrameOptions.Title.OpacityFG = TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.Title.OpacityFG:SetFont(TOCA.Global.font, 12)
TOCA.FrameOptions.Title.OpacityFG:SetPoint("TOPLEFT", 30, -300)
TOCA.FrameOptions.Title.OpacityFG:SetText("Foreground Opacity")
TOCA.FrameOptions.Title.OpacityFG:SetTextColor(1, 1, 0.5, 1)
TOCA.Slider.OpacityFG={}
TOCA.Slider.OpacityFG = CreateFrame("Slider", "TOCA.Slider.OpacityFG", TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "OptionsSliderTemplate")
TOCA.Slider.OpacityFG:SetWidth(140)
TOCA.Slider.OpacityFG:SetHeight(14)
TOCA.Slider.OpacityFG:SetPoint("TOPLEFT", 30, -320)
TOCA.Slider.OpacityFG:SetOrientation('HORIZONTAL')
TOCA.Slider.OpacityFG:EnableMouse(true)
TOCA.Slider.OpacityFG:SetMinMaxValues(0.10, 1.0)
TOCA.Slider.OpacityFGMin, TOCA.Slider.OpacityFGMax = TOCA.Slider.OpacityFG:GetMinMaxValues()
TOCA.Slider.OpacityFG:SetValue(1.0)
TOCA.Slider.OpacityFG.Val = TOCA.Slider.OpacityFG:CreateFontString(nil, "ARTWORK")
TOCA.Slider.OpacityFG.Val:SetFont(TOCA.Global.font, 11, "OUTLINE")
TOCA.Slider.OpacityFG.Val:SetPoint("CENTER", 0, -14)
TOCA.Slider.OpacityFG.Val:SetText("")
getglobal(TOCA.Slider.OpacityFG:GetName() .. 'Low'):SetText('0')
getglobal(TOCA.Slider.OpacityFG:GetName() .. 'High'):SetText('1')
TOCA.Slider.OpacityFG:SetScript("OnValueChanged", function()
  for totemCat,v in pairsByKeys(TOCA.totems) do
    TOCA.SlotSelect[totemCat]:SetAlpha(TOCA.Round(TOCA.Slider.OpacityFG:GetValue(), 2))
    TOCA.Slot[totemCat]:SetAlpha(TOCA.Round(TOCA.Slider.OpacityFG:GetValue(), 2))
    TOCA.Button.DropdownMain:SetAlpha(TOCA.Round(TOCA.Slider.OpacityFG:GetValue(), 2))
    for i,totemSpell in pairs(TOCA.totems[totemCat]) do
      TOCA.SlotGrid.VerticalTotemButton[totemCat][i]:SetAlpha(TOCA.Round(TOCA.Slider.OpacityFG:GetValue(), 2))
      TOCA.SlotGrid.HorizontalTotemButton[totemCat][i]:SetAlpha(TOCA.Round(TOCA.Slider.OpacityFG:GetValue(), 2))
    end
    TOCA.FrameMain.ReincFrame:SetAlpha(TOCA.Round(TOCA.Slider.OpacityFG:GetValue(), 2))
  end
  TOCA.Button.CloseMain:SetAlpha(TOCA.Round(TOCA.Slider.OpacityFG:GetValue(), 2))
  TOCA.Button.Options:SetAlpha(TOCA.Round(TOCA.Slider.OpacityFG:GetValue(), 2))
  TOCA.Button.TotemicCall:SetAlpha(TOCA.Round(TOCA.Slider.OpacityFG:GetValue(), 2))
  TOCA.Slider.OpacityFG.Val:SetText(TOCA.Round(TOCA.Slider.OpacityFG:GetValue(), 2))
end)
TOCA.Slider.OpacityFG:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, TOCA.FrameOptions.Title.OpacityFG:GetText(), "Increase/Decrease the foreground buttons/dropdown|ntransparency levels.")
end)
TOCA.Slider.OpacityFG:SetScript("OnLeave", function()
  TOCADB[TOCA.player.combine]["CONFIG"]["OPACITYFG"] = TOCA.Round(TOCA.Slider.OpacityFG:GetValue(), 2)
  TOCA.CloseAllMenus()
end)
TOCA.Button.ResetOpacityFG = CreateFrame("Button", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "BackdropTemplate")
TOCA.Button.ResetOpacityFG:SetSize(25, 25)
TOCA.Button.ResetOpacityFG:SetPoint("TOPLEFT", 180, -310)
TOCA.Button.ResetOpacityFG:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.ResetOpacityFG:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.ResetOpacityFG:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.ResetOpacityFG:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
  TOCA.TooltipDisplay(self, "Reset Foreground Opacity", "Reset the foreground opacity to the default value.")
end)
TOCA.Button.ResetOpacityFG:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.CloseAllMenus()
end)
TOCA.Button.ResetOpacityFG:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
  TOCA.Slider.OpacityFG:SetValue(1.0)
  TOCADB[TOCA.player.combine]["CONFIG"]["OPACITYFG"] = "1.0"
end)
TOCA.Button.ResetOpacityFG.icon = TOCA.Button.ResetOpacityFG:CreateTexture(nil, "ARTWORK")
TOCA.Button.ResetOpacityFG.icon:SetSize(16, 16)
TOCA.Button.ResetOpacityFG.icon:SetPoint("CENTER", 0, 0)
TOCA.Button.ResetOpacityFG.icon:SetTexture("Interface/Buttons/UI-RefreshButton")

TOCA.FrameOptions.Title.Menu = TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.Title.Menu:SetFont(TOCA.Global.font, 12)
TOCA.FrameOptions.Title.Menu:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["RIGHT"], TOCA.OptionsPosition_y["FRAMEMENU"]-20)
TOCA.FrameOptions.Title.Menu:SetText("Frame Menu")
TOCA.FrameOptions.Title.Menu:SetTextColor(1, 1, 0.5, 1)

TOCA.Checkbox.MainLock={}
TOCA.Checkbox.MainLock = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.MainLock:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["RIGHT"], TOCA.OptionsPosition_y["FRAMEMENU"]-40)
TOCA.Checkbox.MainLock:SetChecked(1)
TOCA.Checkbox.MainLock.text = TOCA.Checkbox.MainLock:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.MainLock.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.MainLock.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.MainLock.text:SetText("Lock Frame While In Combat")
TOCA.Checkbox.MainLock:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), "Lock the frame position while in combat.|nThis will prevent the accidental moving of the frame|nwhile accessing/clicking totems.")
end)
TOCA.Checkbox.MainLock:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)
TOCA.Checkbox.MainLock:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["COMBATLOCK"] = "ON"
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["COMBATLOCK"] = "OFF"
  end
end)

TOCA.Checkbox.MainMenu={}
TOCA.Checkbox.MainMenu = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.MainMenu:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["RIGHT"], TOCA.OptionsPosition_y["FRAMEMENU"]-60)
TOCA.Checkbox.MainMenu:SetChecked(1)
TOCA.Checkbox.MainMenu.text = TOCA.Checkbox.MainMenu:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.MainMenu.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.MainMenu.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.MainMenu.text:SetText("Display Main Menu/Options Buttons")
TOCA.Checkbox.MainMenu:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    --TOCA.FrameMain.Background:SetBackdrop(TOCA.Backdrop.Main)
    TOCADB[TOCA.player.combine]["CONFIG"]["MAINMENU"] = "ON"
    TOCA.Button.CloseMain:Show()
    TOCA.Button.Options:Show()
    --TOCA.FrameMain.Background:SetPoint("CENTER", -1, 0)
  else
    --TOCA.FrameMain.Background:SetBackdrop(TOCA.Backdrop.General)
    TOCADB[TOCA.player.combine]["CONFIG"]["MAINMENU"] = "OFF"
    TOCA.Button.CloseMain:Hide()
    TOCA.Button.Options:Hide()
    --TOCA.FrameMain.Background:SetPoint("CENTER", 0, 0)
    TOCA.Notification("Menu header disabled. Type '"..TCCMD.." options' to reopen.")
  end
end)
TOCA.Checkbox.MainMenu:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), "Toggle the Options and Close menu buttons from the frame.|nType |cffffffff/".. TOCA.Global.command .. " show|r if the frame is closed.")
end)
TOCA.Checkbox.MainMenu:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)


TOCA.Checkbox.FrameBorder={}
TOCA.Checkbox.FrameBorder = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.FrameBorder:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["RIGHT"], TOCA.OptionsPosition_y["FRAMEMENU"]-80)
TOCA.Checkbox.FrameBorder:SetChecked(1)
TOCA.Checkbox.FrameBorder.text = TOCA.Checkbox.FrameBorder:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.FrameBorder.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.FrameBorder.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.FrameBorder.text:SetText("Display Frame/Button Borders")
TOCA.Checkbox.FrameBorder:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] = "ON"
    TOCA.BorderFrame(true)
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] = "OFF"
    TOCA.BorderFrame(false)
  end
end)
TOCA.Checkbox.FrameBorder:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), "Toggle borders around the frames/buttons.|n|nBorder enabled is default.")
end)
TOCA.Checkbox.FrameBorder:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)

TOCA.Checkbox.Totemic={}
TOCA.Checkbox.Totemic = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.Totemic:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["RIGHT"], TOCA.OptionsPosition_y["FRAMEMENU"]-100)
TOCA.Checkbox.Totemic:SetChecked(1)
TOCA.Checkbox.Totemic.text = TOCA.Checkbox.Totemic:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.Totemic.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.Totemic.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.Totemic.text:SetText("Display Totemic Call Button")
TOCA.Checkbox.Totemic:SetScript("OnClick", function(self)
  TOCA.Button.TotemicCall.ECL:Show()
  TOCA.Button.TotemicCall.ECR:Show()
  if (TOCADB[TOCA.player.combine]["CONFIG"]["ENDCAPS"] == "OFF") then
    TOCA.Button.TotemicCall.ECL:Hide()
    TOCA.Button.TotemicCall.ECR:Hide()
  end

  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["TOTEMICCALL"] = "ON"
    TOCA.Button.TotemicCall:Show()
    TOCA.Checkbox.EndCaps:SetAlpha(1)
    TOCA.Dropdown.FrameGryphons:SetAlpha(1)
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["TOTEMICCALL"] = "OFF"
    TOCA.Button.TotemicCall:Hide()
    TOCA.Button.TotemicCall.ECL:Hide()
    TOCA.Button.TotemicCall.ECR:Hide()
    TOCA.Checkbox.EndCaps:SetAlpha(0.5)
    --TOCA.Checkbox.EndCaps:SetChecked(nil)
    TOCA.Dropdown.FrameGryphons:SetAlpha(0.5)
  end
end)
TOCA.Checkbox.Totemic:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), "Toggle the Totemic Call button to display.|n|nDisplaying the Totemic Call button is by default.")
end)
TOCA.Checkbox.Totemic:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)

TOCA.Checkbox.EndCaps={}
TOCA.Checkbox.EndCaps = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.EndCaps:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["RIGHT"], TOCA.OptionsPosition_y["FRAMEMENU"]-120)
TOCA.Checkbox.EndCaps:SetChecked(1)
TOCA.Checkbox.EndCaps:SetAlpha(1)
TOCA.Checkbox.EndCaps.text = TOCA.Checkbox.EndCaps:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.EndCaps.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.EndCaps.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.EndCaps.text:SetText("Display Gryphons")
TOCA.Checkbox.EndCaps:SetScript("OnClick", function(self)
  if (TOCADB[TOCA.player.combine]["CONFIG"]["TOTEMICCALL"] == "OFF") then
    return
  end
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
TOCA.Checkbox.EndCaps:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), "Toggle the cosmetic end caps on the main frame.|n|nEnabled (Gryphons) by Default")
end)
TOCA.Checkbox.EndCaps:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)
TOCA.Dropdown.FrameGryphons={}
TOCA.Dropdown.FrameGryphonsSel={"Gryphons", "Lions"}
TOCA.Dropdown.FrameGryphons = CreateFrame("Frame", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "UIDropDownMenuTemplate")
TOCA.Dropdown.FrameGryphons:SetPoint("TOPLEFT", 410, TOCA.OptionsPosition_y["FRAMEMENU"]-140)
TOCA.Dropdown.FrameGryphons.displayMode = "MENU"
TOCA.Dropdown.FrameGryphons:SetAlpha(1)
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

TOCA.FrameOptions.Title.Timer = TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.Title.Timer:SetFont(TOCA.Global.font, 12)
TOCA.FrameOptions.Title.Timer:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["RIGHT"], TOCA.OptionsPosition_y["TIMERS"])
TOCA.FrameOptions.Title.Timer:SetText(TOCA.locale.UI.TIMERS.TITLE)
TOCA.FrameOptions.Title.Timer:SetTextColor(1, 1, 0.5, 1)

TOCA.Checkbox.Timers={}
TOCA.Checkbox.Timers = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.Timers:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["RIGHT"], TOCA.OptionsPosition_y["TIMERS"]-20)
TOCA.Checkbox.Timers:SetChecked(1)
TOCA.Checkbox.Timers.text = TOCA.Checkbox.Timers:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.Timers.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.Timers.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.Timers.text:SetText("Display Totem Timers")
TOCA.Checkbox.Timers:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["TIMERS"] = "ON"
    TOCA.Checkbox.TimersInMinutes:SetAlpha(1)
    for i=1, 4 do
      TOCA.Slot.Timer[i]:Show()
    end
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["TIMERS"] = "OFF"
    TOCA.Checkbox.TimersInMinutes:SetAlpha(0.5)
    --TOCA.Checkbox.TimersInMinutes:SetChecked(nil)
    for i=1, 4 do
      TOCA.Slot.Timer[i]:Hide()
    end
  end
end)
TOCA.Checkbox.Timers:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), "Toggle the current totem living timer in world to|ndisplay on the current totem dropped.")
end)
TOCA.Checkbox.Timers:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)

TOCA.Checkbox.TimersInMinutes={}
TOCA.Checkbox.TimersInMinutes = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.TimersInMinutes:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["RIGHT"], TOCA.OptionsPosition_y["TIMERS"]-40)
TOCA.Checkbox.TimersInMinutes:SetChecked(1)
TOCA.Checkbox.TimersInMinutes:SetAlpha(1)
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
TOCA.Checkbox.TimersInMinutes:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), "Toggle the totem timer display in total seconds|nor minutes and seconds.|nBoth are default.")
end)
TOCA.Checkbox.TimersInMinutes:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)

TOCA.Checkbox.Reinc={}
TOCA.Checkbox.Reinc = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.Reinc:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["RIGHT"], TOCA.OptionsPosition_y["TIMERS"]-60)
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
TOCA.Checkbox.Reinc:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), "Display the Reincarnation timer at the right top|nof the frame when you have activated Reincarnation.|nThe cooldown timer is live and also displayed.")
end)
TOCA.Checkbox.Reinc:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)

TOCA.Checkbox.Ankh={}
TOCA.Checkbox.Ankh = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.Ankh:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["RIGHT"], TOCA.OptionsPosition_y["TIMERS"]-80)
TOCA.Checkbox.Ankh:SetChecked(1)
TOCA.Checkbox.Ankh.text = TOCA.Checkbox.Ankh:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.Ankh.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.Ankh.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.Ankh.text:SetText("Display Ankh Inventory Count Reminder")
TOCA.Checkbox.Ankh:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["ANKH"] = "ON"
    TOCA.FrameMain.AnkhFrame:Show()
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["ANKH"] = "OFF"
    TOCA.FrameMain.AnkhFrame:Hide()
  end
end)
TOCA.Checkbox.Ankh:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), "Display a reminder when the Ankh reagent is low in|ncurrent your inventory.|nThis will display when you have less than " .. TOCA.AnkhReminder .. " Ankhs.")
end)
TOCA.Checkbox.Ankh:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)

TOCA.FrameOptions.Title.Tooltip = TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.Title.Tooltip:SetFont(TOCA.Global.font, 12)
TOCA.FrameOptions.Title.Tooltip:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["RIGHT"], TOCA.OptionsPosition_y["TOOLTIP"])
TOCA.FrameOptions.Title.Tooltip:SetText(TOCA.locale.UI.TOOLTIP.TITLE)
TOCA.FrameOptions.Title.Tooltip:SetTextColor(1, 1, 0.5, 1)

TOCA.Checkbox.Tooltip={}
TOCA.Checkbox.Tooltip = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.Tooltip:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["RIGHT"], TOCA.OptionsPosition_y["TOOLTIP"]-20)
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
TOCA.Checkbox.Tooltip:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), "Toggle the mouseover of totem/spell details.")
end)
TOCA.Checkbox.Tooltip:SetScript("OnLeave", function()
  TOCA.CloseAllMenus()
end)
TOCA.Checkbox.TooltipMouse={}
TOCA.Checkbox.TooltipMouse = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.TooltipMouse:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["RIGHT"], TOCA.OptionsPosition_y["TOOLTIP"]-40)
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
TOCA.Checkbox.TooltipMouse:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), "Toggle the tooltip to follow over the mouse cursor.")
end)
TOCA.Checkbox.TooltipMouse:SetScript("OnLeave", function()
  TOCA.CloseAllMenus()
end)

TOCA.FrameOptions.Title.Tooltip = TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.Title.Tooltip:SetFont(TOCA.Global.font, 12)
TOCA.FrameOptions.Title.Tooltip:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["RIGHT"], TOCA.OptionsPosition_y["NOTIFICATIONS"])
TOCA.FrameOptions.Title.Tooltip:SetText(TOCA.locale.UI.NOTIFICATIONS.TITLE)
TOCA.FrameOptions.Title.Tooltip:SetTextColor(1, 1, 0.5, 1)

TOCA.Checkbox.ExpireMessage={}
TOCA.Checkbox.ExpireMessage = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.ExpireMessage:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["RIGHT"], TOCA.OptionsPosition_y["NOTIFICATIONS"]-20)
TOCA.Checkbox.ExpireMessage:SetChecked(1)
TOCA.Checkbox.ExpireMessage.text = TOCA.Checkbox.ExpireMessage:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.ExpireMessage.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.ExpireMessage.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.ExpireMessage.text:SetText(TOCA.locale.UI.NOTIFICATIONS[1][1])
TOCA.Checkbox.ExpireMessage:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["EXPIREMESSAGE"] = "ON"
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["EXPIREMESSAGE"] = "OFF"
  end
end)
TOCA.Checkbox.ExpireMessage:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), TOCA.locale.UI.NOTIFICATIONS[1][2])
end)
TOCA.Checkbox.ExpireMessage:SetScript("OnLeave", function()
  TOCA.CloseAllMenus()
end)

TOCA.Checkbox.ExpireSound={}
TOCA.Checkbox.ExpireSound = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[1]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.ExpireSound:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["RIGHT"], TOCA.OptionsPosition_y["NOTIFICATIONS"]-40)
TOCA.Checkbox.ExpireSound:SetChecked(1)
TOCA.Checkbox.ExpireSound.text = TOCA.Checkbox.ExpireSound:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.ExpireSound.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.ExpireSound.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.ExpireSound.text:SetText(TOCA.locale.UI.NOTIFICATIONS[2][1])
TOCA.Checkbox.ExpireSound:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["EXPIRESOUND"] = "ON"
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["EXPIRESOUND"] = "OFF"
  end
end)
TOCA.Checkbox.ExpireSound:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), TOCA.locale.UI.NOTIFICATIONS[2][2])
end)
TOCA.Checkbox.ExpireSound:SetScript("OnLeave", function()
  TOCA.CloseAllMenus()
end)

movingTotem= "nil"
overTotem = "nil"
TOCA.SlotSets_x = -60
TOCA.SlotOrderTitle = TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[2]]:CreateFontString(nil, "ARTWORK")
TOCA.SlotOrderTitle:SetFont(TOCA.Global.font, 12)
TOCA.SlotOrderTitle:SetPoint("TOPLEFT", 30, -190)
TOCA.SlotOrderTitle:SetText(TOCA.locale.UI.TOTEMSET[3])
TOCA.SlotOrderTitle:SetTextColor(1, 1, 0.5, 1)

TOCA.SlotOrderIcon={}
TOCA.SlotOrderBack={}
TOCA.Dropdown.OrderSet={}

for i=1, getn(TOCA.Dropdown.OrderSetMenu) do
  TOCA.SlotSets_x = TOCA.SlotSets_x + 66
  TOCA.Dropdown.OrderSet[i] = CreateFrame("Frame", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[2]], "UIDropDownMenuTemplate")
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

TOCA.FrameOptions.Divider = TOCA.FrameOptions:CreateTexture(nil, "OVERLAY")
TOCA.FrameOptions.Divider:SetSize(TOCA.FrameOptions_w-6, 8)
TOCA.FrameOptions.Divider:SetPoint("TOPLEFT", 3, -TOCA.FrameOptions_h+60)
TOCA.FrameOptions.Divider:SetTexture("Interface/DialogFrame/DialogFrame-TOP")
--TOCA.FrameOptions.Divider:Hide()

TOCA.FrameOptions.Title.Footer = TOCA.FrameOptions:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.Title.Footer:SetFont(TOCA.Global.font, 12)
TOCA.FrameOptions.Title.Footer:SetPoint("TOPLEFT", 10, -TOCA.FrameOptions_h+25)
TOCA.FrameOptions.Title.Footer:SetText(TOCA.Global.title .. " v" .. TOCA.Global.version .. "-" .. TOCA.Global.suffix .. " ("..GetLocale()..") |cff4d4d4d " .. TOCA.Global.date)

TOCA.Button.OptionsClose= CreateFrame("Button", nil, TOCA.FrameOptions, "BackdropTemplate")
TOCA.Button.OptionsClose:SetSize(100, 25)
--TOCA.Button.OptionsClose:SetPoint("CENTER", 0, -180)
TOCA.Button.OptionsClose:SetPoint("CENTER", 0, -TOCA.FrameOptions_h+290)
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
TOCA.Button.OptionsCloseText:SetText(TOCA.locale.UI.BUTTON[1])
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
TOCA.FrameOptionsMain.footer = TOCA.FrameOptionsMain:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptionsMain.footer:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.FrameOptionsMain.footer:SetPoint("TOPLEFT", 20, -40)
TOCA.FrameOptionsMain.footer:SetText(TOCA.Global.title .. " v" .. TOCA.Global.version .. "-" .. TOCA.Global.suffix .. " ("..GetLocale()..")")

TOCA.FrameOptionsMain.text = TOCA.FrameOptionsMain.Options:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptionsMain.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.FrameOptionsMain.text:SetPoint("CENTER", 0, 0)
TOCA.FrameOptionsMain.text:SetText(TOCA.locale.UI.OPTIONS.TITLE)
