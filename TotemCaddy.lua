--[==[
Copyright ©2020 Porthios of Myzrael or Porthias of Myzrael

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

local TOCAFrameMain = CreateFrame("Frame", "TOCAFrameMain", UIParent, "BackdropTemplate")
TOCAFrameMain:SetWidth(TOCAGlobal.width)
TOCAFrameMain:SetHeight(TOCAGlobal.height)
TOCAFrameMain:SetPoint("CENTER", 0, 0)
TOCAFrameMain:SetBackdrop(TOCABackdrop.General)
TOCAFrameMain:SetBackdropColor(0, 0, 0, 0.8)
TOCAFrameMain:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCAFrameMain:SetMovable(true)
TOCAFrameMain:EnableMouse(true)
TOCAFrameMain:RegisterForDrag("LeftButton")
TOCAFrameMain:SetScript("OnDragStart", function()
  TOCAFrameMain:StartMoving()
end)
TOCAFrameMain:SetScript("OnDragStop", function()
  TOCAFrameMain:StopMovingOrSizing()
  local point, relativeTo, relativePoint, xOfs, yOfs = TOCAFrameMain:GetPoint()
  TOCADB[player.combine]["CONFIG"]["MAINPOS"] = point .. "," .. xOfs .. "," .. yOfs
end)
local TOCAMain = CreateFrame("Frame")
TOCAMain:RegisterEvent("ADDON_LOADED")
TOCAMain:RegisterEvent("PLAYER_LOGIN")
TOCAMain:RegisterEvent("PLAYER_ENTERING_WORLD")
TOCAMain:SetScript("OnEvent", function(self, event, prefix)
  if ((event == "ADDON_LOADED") and (prefix == "TotemCaddy")) then
    print(TOCAGlobal.title .. " v" .. TOCAGlobal.version .. " Initializing by " .. TOCAGlobal.author .. ". Type /" .. TOCAGlobal.command .. " for commands.")
    TOCAInit()
  end
end)

TOCASlot={}
TOCATotem={}
local TOCASlot_w=35
local TOCASlot_h=35
local TOCASlot_x=-TOCASlot_w/2
--for totemCat,v in pairs(TOCATotems) do
for totemCat,v in pairsByKeys(TOCATotems) do
  TOCASlot_x = TOCASlot_x +TOCASlot_w+5
  TOCASlot[totemCat]={}
  TOCASlot[totemCat]= CreateFrame("Button", nil, TOCAFrameMain, "BackdropTemplate")
  TOCASlot[totemCat]:SetSize(TOCASlot_w, TOCASlot_h)
  TOCASlot[totemCat]:SetPoint("TOPLEFT", TOCASlot_x, -25)
  TOCASlot[totemCat]:SetBackdrop(TOCABackdrop.General)
  TOCASlot[totemCat]:SetBackdropColor(0, 0, 0, 0.8)
  TOCASlot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCATotem[totemCat]={}
  TOCATotem[totemCat] = CreateFrame("Button", nil, TOCASlot[totemCat], "SecureActionButtonTemplate");
  TOCATotem[totemCat]:SetSize(TOCASlot_w, TOCASlot_h)
  TOCATotem[totemCat]:SetPoint("CENTER", 0, 0)
  TOCATotem[totemCat]:SetAttribute("type", "spell")
  TOCATotem[totemCat]:SetAttribute("spell", "Healing Stream Totem") -- default
  TOCATotem[totemCat]:SetScript("OnEnter", function()
    TOCASlot[totemCat]:SetBackdropBorderColor(1, 1, 0.8, 1)
  end)
  TOCATotem[totemCat]:SetScript("OnLeave", function()
    TOCASlot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  end)
end

local TOCACall_w=40
local TOCACall_h=40
TOCACall= CreateFrame("Button", nil, TOCAFrameMain, "BackdropTemplate")
TOCACall:SetSize(TOCACall_w, TOCACall_h)
TOCACall:SetPoint("CENTER", 0, 42)
TOCACall:SetBackdrop({
  bgFile  = "Interface/ICONS/spell_unused",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
})
TOCACall:SetBackdropBorderColor(1, 1, 1, 0.5)
TOCACall.ECL = TOCACall:CreateTexture(nil, "ARTWORK")
TOCACall.ECL:SetSize(40, 40)
TOCACall.ECL:SetPoint("CENTER", 30, 20)
TOCACall.ECL:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Dwarf")
TOCACall.ECL:SetTexCoord(1, 0, 0, 1)
TOCACall.ECR = TOCACall:CreateTexture(nil, "ARTWORK")
TOCACall.ECR:SetSize(40, 40)
TOCACall.ECR:SetPoint("CENTER", -30, 20)
TOCACall.ECR:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Dwarf")

TOCACallAtt= CreateFrame("Button", nil, TOCACall, "SecureActionButtonTemplate");
TOCACallAtt:SetSize(TOCACall_w, TOCACall_h)
TOCACallAtt:SetPoint("CENTER", 0, 0)
TOCACallAtt:SetAttribute("type", "spell")
TOCACallAtt:SetAttribute("spell", "Totemic Call")
TOCACallAtt:SetScript("OnEnter", function()
  TOCACall:SetBackdropBorderColor(1, 1, 0.6, 1)
end)
TOCACallAtt:SetScript("OnLeave", function()
  TOCACall:SetBackdropBorderColor(1, 1, 1, 0.5)
end)

TOCABtnOpt= CreateFrame("Button", nil, TOCAFrameMain, "BackdropTemplate")
TOCABtnOpt:SetSize(18, 18)
TOCABtnOpt:SetPoint("TOPRIGHT", -18, -2)
TOCABtnOpt:SetBackdrop(TOCABackdrop.Button)
TOCABtnOpt:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCABtnOpt:SetBackdropColor(0.5, 0.5, 0.6, 1)
TOCABtnOpt.icon = TOCABtnOpt:CreateTexture(nil, "ARTWORK")
TOCABtnOpt.icon:SetSize(12, 12)
TOCABtnOpt.icon:SetPoint("CENTER", 0, 0)
TOCABtnOpt.icon:SetTexture("Interface/Buttons/UI-OptionsButton")
TOCABtnOpt:SetScript("OnClick", function()
  TOCACloseAllMenus()
  TOCAFrameOptions:Show()
end)
TOCABtnOpt:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCABtnOpt:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)

TOCABtnClose= CreateFrame("Button", nil, TOCAFrameMain, "BackdropTemplate")
TOCABtnClose:SetSize(18, 18)
TOCABtnClose:SetPoint("TOPRIGHT", -2, -2)
TOCABtnClose:SetBackdrop(TOCABackdrop.Button)
TOCABtnClose:SetBackdropColor(0.6, 0, 0, 1)
TOCABtnClose:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCABtnClose.icon = TOCABtnClose:CreateTexture(nil, "ARTWORK")
TOCABtnClose.icon:SetSize(12, 12)
TOCABtnClose.icon:SetPoint("CENTER", 0, 0)
TOCABtnClose.icon:SetTexture("Interface/Buttons/UI-StopButton")
TOCABtnClose:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCABtnClose:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCABtnClose:SetScript("OnClick", function()
  TOCACloseAllMenus()
  TOCAFrameMain:Hide()
  print(TOCAGlobal.title .. " closed. Type '"..TCCMD.." show' to reopen.")
end)

TOCAFrameOptions = CreateFrame("Button", "TOCAFrameOptions", UIParent, "BackdropTemplate")
TOCAFrameOptions:SetWidth(300)
TOCAFrameOptions:SetHeight(200)
TOCAFrameOptions:SetPoint("CENTER", 0, 50)
TOCAFrameOptions:SetBackdrop(TOCABackdrop.General)
TOCAFrameOptions:SetBackdropColor(0, 0, 0, 0.8)
TOCAFrameOptions:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCAFrameOptions.title = TOCAFrameOptions:CreateFontString(nil, "ARTWORK")
TOCAFrameOptions.title:SetFont(TOCAGlobal.font, 14, "OUTLINE")
TOCAFrameOptions.title:SetPoint("TOPLEFT", 10, -10)
TOCAFrameOptions.title:SetText(TOCAGlobal.title .. " Options  v" .. TOCAGlobal.version)
TOCAFrameOptions:SetScript("OnClick", function()
  TOCACloseAllMenus()
end)
TOCAFrameOptions:Hide()

TOCAFrameOptionsBtnClose= CreateFrame("Button", nil, TOCAFrameOptions, "BackdropTemplate")
TOCAFrameOptionsBtnClose:SetSize(18, 18)
TOCAFrameOptionsBtnClose:SetPoint("TOPRIGHT", -2, -2)
TOCAFrameOptionsBtnClose:SetBackdrop(TOCABackdrop.Button)
TOCAFrameOptionsBtnClose:SetBackdropColor(0.6, 0, 0, 1)
TOCAFrameOptionsBtnClose:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCAFrameOptionsBtnClose.icon = TOCAFrameOptionsBtnClose:CreateTexture(nil, "ARTWORK")
TOCAFrameOptionsBtnClose.icon:SetSize(12, 12)
TOCAFrameOptionsBtnClose.icon:SetPoint("CENTER", 0, 0)
TOCAFrameOptionsBtnClose.icon:SetTexture("Interface/Buttons/UI-StopButton")
TOCAFrameOptionsBtnClose:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCAFrameOptionsBtnClose:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCAFrameOptionsBtnClose:SetScript("OnClick", function()
  TOCACloseAllMenus()
  TOCAFrameOptions:Hide()
end)


TOCAFrameOptionsBtnSave= CreateFrame("Button", nil, TOCAFrameOptions, "BackdropTemplate")
TOCAFrameOptionsBtnSave:SetSize(80, 25)
TOCAFrameOptionsBtnSave:SetPoint("CENTER", 40, -60)
TOCAFrameOptionsBtnSave:SetBackdrop(TOCABackdrop.Button)
TOCAFrameOptionsBtnSave:SetBackdropColor(0, 0.7, 0, 1)
TOCAFrameOptionsBtnSave:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCAFrameOptionsBtnSave:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCAFrameOptionsBtnSave:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCAFrameOptionsBtnSave:SetScript("OnClick", function()
  if ((TOCAFrameOptionsProfile:GetText() == "") or (TOCAFrameOptionsProfile == nil)) then
    print(TOCAGlobal.title .. " Profile Saved: " .. TOCADDOpt.text:GetText())
  else
    print(TOCAGlobal.title .. " Profile Saved: " .. TOCAFrameOptionsProfile:GetText())
  end
end)
TOCAFrameOptionsBtnSave.text = TOCAFrameOptionsBtnSave:CreateFontString(nil, "ARTWORK")
TOCAFrameOptionsBtnSave.text:SetFont("Fonts\\FRIZQT__.TTF", 11)
TOCAFrameOptionsBtnSave.text:SetPoint("CENTER", 0, 0)
TOCAFrameOptionsBtnSave.text:SetText("Save")

TOCAFrameOptionsBtnDelete= CreateFrame("Button", nil, TOCAFrameOptions, "BackdropTemplate")
TOCAFrameOptionsBtnDelete:SetSize(80, 25)
TOCAFrameOptionsBtnDelete:SetPoint("CENTER", -40, -60)
TOCAFrameOptionsBtnDelete:SetBackdrop(TOCABackdrop.Button)
TOCAFrameOptionsBtnDelete:SetBackdropColor(0.6, 0, 0, 1)
TOCAFrameOptionsBtnDelete:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCAFrameOptionsBtnDelete:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCAFrameOptionsBtnDelete:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCAFrameOptionsBtnDelete:SetScript("OnClick", function()
  if (TOCADDOpt.text:GetText() == "Default") then
    print(TOCAGlobal.title .. " Unable to remove the Default profile.")
  end
end)
TOCAFrameOptionsBtnDelete.text = TOCAFrameOptionsBtnDelete:CreateFontString(nil, "ARTWORK")
TOCAFrameOptionsBtnDelete.text:SetFont("Fonts\\FRIZQT__.TTF", 11)
TOCAFrameOptionsBtnDelete.text:SetPoint("CENTER", 0, 0)
TOCAFrameOptionsBtnDelete.text:SetText("Delete")

TOCAFrameOptionsSlot={}
TOCAFrameOptionsTotem={}
TOCAFrameOptionsSlotSelect={}
TOCAFrameOptionsSlotSelectMenu={}
TOCAFrameOptionsSlotSelectTotem={}

local TOCASlotOptions_x = 0
for totemCat,v in pairsByKeys(TOCATotems) do
  TOCASlotOptions_x = TOCASlotOptions_x + TOCASlot_w+4
  TOCAFrameOptionsSlot[totemCat]={}
  TOCAFrameOptionsSlot[totemCat]= CreateFrame("Button", nil, TOCAFrameOptions, "BackdropTemplate")
  TOCAFrameOptionsSlot[totemCat]:SetSize(TOCASlot_w, TOCASlot_h)
  TOCAFrameOptionsSlot[totemCat]:SetPoint("CENTER", -100+TOCASlotOptions_x, 20)
  TOCAFrameOptionsSlot[totemCat]:SetBackdrop(TOCABackdrop.General)
  TOCAFrameOptionsSlotSelect[totemCat]= CreateFrame("Button", nil, TOCAFrameOptions, "BackdropTemplate")
  TOCAFrameOptionsSlotSelect[totemCat]:SetSize(28, 15)
  TOCAFrameOptionsSlotSelect[totemCat]:SetPoint("CENTER", -100+TOCASlotOptions_x, 0)
  TOCAFrameOptionsSlotSelect[totemCat]:SetBackdrop(TOCABackdrop.General)
  TOCAFrameOptionsSlotSelect[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCAFrameOptionsSlotSelect[totemCat]:SetFrameStrata("DIALOG")
  TOCAFrameOptionsSlotSelect[totemCat]:SetScript("OnEnter", function(self)
    self:SetBackdropBorderColor(1, 1, 0.8, 1)
  end)
  TOCAFrameOptionsSlotSelect[totemCat]:SetScript("OnLeave", function(self)
    self:SetBackdropBorderColor(1, 1, 1, 0.6)
  end)
  TOCAFrameOptionsSlotSelect[totemCat]:SetScript("OnClick", function()
    TOCACloseAllMenus()
    TOCAFrameOptionsSlotSelectMenu[totemCat]:Show()
  end)
  TOCAFrameOptionsSlotSelect[totemCat].icon = TOCAFrameOptionsSlotSelect[totemCat]:CreateTexture(nil, "ARTWORK")
  TOCAFrameOptionsSlotSelect[totemCat].icon:SetSize(18, 14)
  TOCAFrameOptionsSlotSelect[totemCat].icon:SetPoint("CENTER", 0, -3)
  TOCAFrameOptionsSlotSelect[totemCat].icon:SetTexture("Interface/Buttons/Arrow-Down-Down")

  local totemCategoryCount = getn(TOCATotems[totemCat])
  TOCAFrameOptionsSlotSelectMenu[totemCat]= CreateFrame("Frame", nil, TOCAFrameOptionsSlotSelect[totemCat], "BackdropTemplate")
  TOCAFrameOptionsSlotSelectMenu[totemCat]:SetSize(40, (totemCategoryCount*40)+30)
  TOCAFrameOptionsSlotSelectMenu[totemCat]:SetPoint("TOPLEFT", -6, -10)
  TOCAFrameOptionsSlotSelectMenu[totemCat]:SetBackdrop(TOCABackdrop.General)
  TOCAFrameOptionsSlotSelectMenu[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCAFrameOptionsSlotSelectMenu[totemCat]:SetFrameLevel(200)
  TOCAFrameOptionsSlotSelectMenu[totemCat]:SetFrameStrata("DIALOG")
  TOCAFrameOptionsSlotSelectMenu[totemCat]:Hide()

  TOCAFrameOptionsSlotSelectTotemCancel= CreateFrame("Button", nil, TOCAFrameOptionsSlotSelectMenu[totemCat], "BackdropTemplate")
  TOCAFrameOptionsSlotSelectTotemCancel:SetSize(35, 35)
  TOCAFrameOptionsSlotSelectTotemCancel:SetPoint("TOPLEFT", 2.5, -5)
  TOCAFrameOptionsSlotSelectTotemCancel:SetBackdrop({
    bgFile  = "interface/buttons/UI-GroupLoot-Pass-Down",
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  })
  TOCAFrameOptionsSlotSelectTotemCancel:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCAFrameOptionsSlotSelectTotemCancel:SetScript("OnEnter", function(self)
    self:SetBackdropBorderColor(1, 1, 0.8, 1)
  end)
  TOCAFrameOptionsSlotSelectTotemCancel:SetScript("OnLeave", function(self)
    self:SetBackdropBorderColor(1, 1, 1, 0.6)
  end)
  TOCAFrameOptionsSlotSelectTotemCancel:SetScript("OnClick", function()
    TOCACloseAllMenus()
  end)

  local totemSpellCount={}
  totemSpellCount[totemCat] = 0
  for i,totemSpell in pairs(TOCATotems[totemCat]) do
    --print(totemCat .. i .. " " .. totemSpell[1])
    totemSpellCount[totemCat] = totemSpellCount[totemCat]+35
    TOCAFrameOptionsSlotSelectTotem[totemCat]={}
    TOCAFrameOptionsSlotSelectTotem[totemCat][i]= CreateFrame("Button", nil, TOCAFrameOptionsSlotSelectMenu[totemCat], "BackdropTemplate")
    TOCAFrameOptionsSlotSelectTotem[totemCat][i]:SetSize(35, 35)
    TOCAFrameOptionsSlotSelectTotem[totemCat][i]:SetPoint("TOPLEFT", 2.5, -totemSpellCount[totemCat]-5)
    TOCAFrameOptionsSlotSelectTotem[totemCat][i]:SetBackdrop({
      bgFile  = "interface/icons/" .. totemSpell[2],
      edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
      edgeSize= 12,
      insets  = {left=2, right=2, top=2, bottom=2},
    })
    TOCAFrameOptionsSlotSelectTotem[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0.6)
    TOCAFrameOptionsSlotSelectTotem[totemCat][i]:SetScript("OnEnter", function(self)
      self:SetBackdropBorderColor(1, 1, 0.8, 1)
    end)
    TOCAFrameOptionsSlotSelectTotem[totemCat][i]:SetScript("OnLeave", function(self)
      self:SetBackdropBorderColor(1, 1, 1, 0.6)
    end)
    TOCAFrameOptionsSlotSelectTotem[totemCat][i]:SetScript("OnClick", function()
      print(totemCat .. i .. " " .. totemSpell[1])
      TOCACloseAllMenus()
    end)
  end

  TOCAFrameOptionsSlot[totemCat]:SetBackdropColor(0, 0, 0, 0.8)
  TOCAFrameOptionsSlot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  --[==[
  TOCAFrameOptionsTotem[totemCat]={}
  TOCAFrameOptionsTotem[totemCat] = CreateFrame("Button", nil, TOCAFrameOptionsSlot[totemCat], "BackdropTemplate");
  TOCAFrameOptionsTotem[totemCat]:SetSize(TOCASlot_w, TOCASlot_h)
  TOCAFrameOptionsTotem[totemCat]:SetPoint("CENTER", 0, 0)
  ]==]--
end

TOCAFrameOptionsProfile = CreateFrame("EditBox", nil, TOCAFrameOptions, "BackdropTemplate")
TOCAFrameOptionsProfile:SetWidth(140)
TOCAFrameOptionsProfile:SetHeight(24)
TOCAFrameOptionsProfile:SetFontObject(GameFontWhite)
TOCAFrameOptionsProfile:SetBackdrop({
  bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
  insets  = {left=-2, right=6, top=2, bottom=2},
})
TOCAFrameOptionsProfile:SetBackdropColor(0, 0, 0, 1)
TOCAFrameOptionsProfile:SetPoint("CENTER", 0, -26)
TOCAFrameOptionsProfile:ClearFocus(self)
TOCAFrameOptionsProfile:SetAutoFocus(false)
TOCAFrameOptionsProfile.border = CreateFrame("Frame", nil, TOCAFrameOptionsProfile, "BackdropTemplate")
TOCAFrameOptionsProfile.border:SetWidth(140)
TOCAFrameOptionsProfile.border:SetHeight(24)
TOCAFrameOptionsProfile.border:SetPoint("TOPLEFT", -4, 0)
TOCAFrameOptionsProfile.border:SetBackdrop({
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
})

TOCADDMenu = {"Default"}
TOCADD = CreateFrame("Frame", nil, TOCAFrameMain, "UIDropDownMenuTemplate")
--TOCADD:SetFrameLevel(50)
TOCADD:SetPoint("CENTER", 0, -30)
TOCADD.displayMode = "MENU"
TOCADD.text = TOCADD:CreateFontString(nil, "ARTWORK")
TOCADD.text:SetFont("Fonts\\FRIZQT__.TTF", 11)
TOCADD.text:SetPoint("TOPLEFT", TOCADD, "TOPLEFT", 25, -8)
TOCADD.text:SetText(TOCADDMenu[1])
TOCADD.onClick = function(self, checked)
  TOCADD.text:SetText(self.value)
  --print(self.value)
end
TOCADD.initialize = function(self, level)
  local info = UIDropDownMenu_CreateInfo()
  local i = 0
  for k,v in pairs(TOCADDMenu) do
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
UIDropDownMenu_SetWidth(TOCADD, TOCAGlobal.width-60)

TOCADDOpt = CreateFrame("Frame", nil, TOCAFrameOptions, "UIDropDownMenuTemplate")
TOCADDOpt:SetPoint("CENTER", 0, 50)
TOCADDOpt.displayMode = "MENU"
TOCADDOpt.text = TOCADDOpt:CreateFontString(nil, "ARTWORK")
TOCADDOpt.text:SetFont("Fonts\\FRIZQT__.TTF", 11)
TOCADDOpt.text:SetPoint("TOPLEFT", TOCADDOpt, "TOPLEFT", 25, -8)
TOCADDOpt.text:SetText(TOCADDMenu[1])
TOCADDOpt.onClick = function(self, checked)
  TOCADDOpt.text:SetText(self.value)
  --print(self.value)
end
TOCADDOpt.initialize = function(self, level)
  local info = UIDropDownMenu_CreateInfo()
  local i = 0
  for k,v in pairs(TOCADDMenu) do
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
UIDropDownMenu_SetWidth(TOCADDOpt, TOCAGlobal.width-60)
