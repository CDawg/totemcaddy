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

TOCA.FrameMain = CreateFrame("Frame", "TOCA.FrameMain", UIParent, "BackdropTemplate")
TOCA.FrameMain:SetWidth(TOCA.Global.width)
TOCA.FrameMain:SetHeight(TOCA.Global.height)
TOCA.FrameMain:SetPoint("CENTER", 0, 0)
TOCA.FrameMain:SetBackdrop(TOCA.Backdrop.General)
TOCA.FrameMain:SetBackdropColor(0, 0, 0, 0.8)
TOCA.FrameMain:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameMain:SetMovable(true)
TOCA.FrameMain:EnableMouse(true)
TOCA.FrameMain:RegisterForDrag("LeftButton")
TOCA.FrameMain:SetScript("OnDragStart", function()
  TOCA.FrameMain:StartMoving()
end)
TOCA.FrameMain:SetScript("OnDragStop", function()
  TOCA.FrameMain:StopMovingOrSizing()
  local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.FrameMain:GetPoint()
  TOCADB[TOCA.player.combine]["CONFIG"]["MAINPOS"] = point .. "," .. xOfs .. "," .. yOfs
end)
TOCA.Main = CreateFrame("Frame")
TOCA.Main:RegisterEvent("ADDON_LOADED")
TOCA.Main:RegisterEvent("PLAYER_LOGIN")
TOCA.Main:RegisterEvent("PLAYER_ENTERING_WORLD")
TOCA.Main:SetScript("OnEvent", function(self, event, prefix)
  if ((event == "ADDON_LOADED") and (prefix == "TotemCaddy")) then
    print(TOCA.Global.title .. " v" .. TOCA.Global.version .. " Initializing by " .. TOCA.Global.author .. ". Type /" .. TOCA.Global.command .. " for commands.")
    TOCA.Init()
  end
end)

TOCA.Slot={}
TOCA.Totem={}
TOCA.Slot_w=35
TOCA.Slot_h=35
TOCA.Slot_x=-TOCA.Slot_w/2
for totemCat,v in pairsByKeys(TOCA.totems) do
  TOCA.Slot_x = TOCA.Slot_x +TOCA.Slot_w+5
  TOCA.Slot[totemCat]={}
  TOCA.Slot[totemCat]= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
  TOCA.Slot[totemCat]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
  TOCA.Slot[totemCat]:SetPoint("TOPLEFT", TOCA.Slot_x, -25)
  TOCA.Slot[totemCat]:SetBackdrop(TOCA.Backdrop.General)
  TOCA.Slot[totemCat]:SetBackdropColor(0, 0, 0, 0.8)
  TOCA.Slot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.Totem[totemCat]={}
  TOCA.Totem[totemCat] = CreateFrame("Button", nil, TOCA.Slot[totemCat], "SecureActionButtonTemplate");
  TOCA.Totem[totemCat]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
  TOCA.Totem[totemCat]:SetPoint("CENTER", 0, 0)
  TOCA.Totem[totemCat]:SetAttribute("type", "spell")
  if (totemCat == "AIR") then
    TOCA.Totem[totemCat]:SetAttribute("spell", TOCASlotAIR)
  end
  if (totemCat == "EARTH") then
    TOCA.Totem[totemCat]:SetAttribute("spell", TOCASlotEARTH)
  end
  if (totemCat == "FIRE") then
    TOCA.Totem[totemCat]:SetAttribute("spell", TOCASlotFIRE)
  end
  if (totemCat == "WATER") then
    TOCA.Totem[totemCat]:SetAttribute("spell", TOCASlotWATER)
  end
  TOCA.Totem[totemCat]:SetScript("OnEnter", function()
    TOCA.Slot[totemCat]:SetBackdropBorderColor(1, 1, 0.8, 1)
  end)
  TOCA.Totem[totemCat]:SetScript("OnLeave", function()
    TOCA.Slot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
    --[==[
    if (totemCat == "WATER") then
      local haveTotem, totemName, startTime, duration = GetTotemInfo(3)
      print(haveTotem)
    end
    ]==]--
  end)
end

TOCA.Call_w=40
TOCA.Call_h=40
TOCA.Call= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
TOCA.Call:SetSize(TOCA.Call_w, TOCA.Call_h)
TOCA.Call:SetPoint("CENTER", 0, 42)
TOCA.Call:SetBackdrop({
  bgFile  = "Interface/ICONS/spell_unused",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
})
TOCA.Call:SetBackdropBorderColor(1, 1, 1, 0.5)
TOCA.Call.ECL = TOCA.Call:CreateTexture(nil, "ARTWORK")
TOCA.Call.ECL:SetSize(40, 40)
TOCA.Call.ECL:SetPoint("CENTER", 30, 20)
TOCA.Call.ECL:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Dwarf")
TOCA.Call.ECL:SetTexCoord(1, 0, 0, 1)
TOCA.Call.ECR = TOCA.Call:CreateTexture(nil, "ARTWORK")
TOCA.Call.ECR:SetSize(40, 40)
TOCA.Call.ECR:SetPoint("CENTER", -30, 20)
TOCA.Call.ECR:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Dwarf")

TOCA.CallAtt= CreateFrame("Button", nil, TOCA.Call, "SecureActionButtonTemplate");
TOCA.CallAtt:SetSize(TOCA.Call_w, TOCA.Call_h)
TOCA.CallAtt:SetPoint("CENTER", 0, 0)
TOCA.CallAtt:SetAttribute("type", "spell")
TOCA.CallAtt:SetAttribute("spell", "Totemic Call")
TOCA.CallAtt:SetScript("OnEnter", function()
  TOCA.Call:SetBackdropBorderColor(1, 1, 0.6, 1)
end)
TOCA.CallAtt:SetScript("OnLeave", function()
  TOCA.Call:SetBackdropBorderColor(1, 1, 1, 0.5)
end)

TOCA.BtnOpt= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
TOCA.BtnOpt:SetSize(18, 18)
TOCA.BtnOpt:SetPoint("TOPRIGHT", -18, -2)
TOCA.BtnOpt:SetBackdrop(TOCA.Backdrop.Button)
TOCA.BtnOpt:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.BtnOpt:SetBackdropColor(0.5, 0.5, 0.6, 1)
TOCA.BtnOpt.icon = TOCA.BtnOpt:CreateTexture(nil, "ARTWORK")
TOCA.BtnOpt.icon:SetSize(12, 12)
TOCA.BtnOpt.icon:SetPoint("CENTER", 0, 0)
TOCA.BtnOpt.icon:SetTexture("Interface/Buttons/UI-OptionsButton")
TOCA.BtnOpt:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
  TOCA.FrameOptions:Show()
end)
TOCA.BtnOpt:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.BtnOpt:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)

TOCA.BtnClose= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
TOCA.BtnClose:SetSize(18, 18)
TOCA.BtnClose:SetPoint("TOPRIGHT", -2, -2)
TOCA.BtnClose:SetBackdrop(TOCA.Backdrop.Button)
TOCA.BtnClose:SetBackdropColor(0.6, 0, 0, 1)
TOCA.BtnClose:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.BtnClose.icon = TOCA.BtnClose:CreateTexture(nil, "ARTWORK")
TOCA.BtnClose.icon:SetSize(12, 12)
TOCA.BtnClose.icon:SetPoint("CENTER", 0, 0)
TOCA.BtnClose.icon:SetTexture("Interface/Buttons/UI-StopButton")
TOCA.BtnClose:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.BtnClose:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.BtnClose:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
  TOCA.FrameMain:Hide()
  print(TOCA.Global.title .. " closed. Type '"..TCCMD.." show' to reopen.")
end)

TOCA.FrameOptions = CreateFrame("Button", "TOCA.FrameOptions", UIParent, "BackdropTemplate")
TOCA.FrameOptions:SetWidth(300)
TOCA.FrameOptions:SetHeight(200)
TOCA.FrameOptions:SetPoint("CENTER", 0, 50)
TOCA.FrameOptions:SetBackdrop(TOCA.Backdrop.General)
TOCA.FrameOptions:SetBackdropColor(0, 0, 0, 0.8)
TOCA.FrameOptions:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameOptions.title = TOCA.FrameOptions:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.title:SetFont(TOCA.Global.font, 14, "OUTLINE")
TOCA.FrameOptions.title:SetPoint("TOPLEFT", 10, -10)
TOCA.FrameOptions.title:SetText(TOCA.Global.title .. " Options  v" .. TOCA.Global.version)
TOCA.FrameOptions:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
end)
TOCA.FrameOptions:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)
TOCA.FrameOptions:Hide()

TOCA.FrameOptionsBtnClose= CreateFrame("Button", nil, TOCA.FrameOptions, "BackdropTemplate")
TOCA.FrameOptionsBtnClose:SetSize(18, 18)
TOCA.FrameOptionsBtnClose:SetPoint("TOPRIGHT", -2, -2)
TOCA.FrameOptionsBtnClose:SetBackdrop(TOCA.Backdrop.Button)
TOCA.FrameOptionsBtnClose:SetBackdropColor(0.6, 0, 0, 1)
TOCA.FrameOptionsBtnClose:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameOptionsBtnClose.icon = TOCA.FrameOptionsBtnClose:CreateTexture(nil, "ARTWORK")
TOCA.FrameOptionsBtnClose.icon:SetSize(12, 12)
TOCA.FrameOptionsBtnClose.icon:SetPoint("CENTER", 0, 0)
TOCA.FrameOptionsBtnClose.icon:SetTexture("Interface/Buttons/UI-StopButton")
TOCA.FrameOptionsBtnClose:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.FrameOptionsBtnClose:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.FrameOptionsBtnClose:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
  TOCA.FrameOptions:Hide()
end)

TOCA.FrameOptionsBtnSave= CreateFrame("Button", nil, TOCA.FrameOptions, "BackdropTemplate")
TOCA.FrameOptionsBtnSave:SetSize(80, 25)
TOCA.FrameOptionsBtnSave:SetPoint("CENTER", 40, -60)
TOCA.FrameOptionsBtnSave:SetBackdrop(TOCA.Backdrop.Button)
TOCA.FrameOptionsBtnSave:SetBackdropColor(0, 0.7, 0, 1)
TOCA.FrameOptionsBtnSave:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameOptionsBtnSave:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.FrameOptionsBtnSave:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.FrameOptionsBtnSave:SetScript("OnClick", function()
  TOCA.FrameOptionsProfile.border:SetBackdropBorderColor(1, 1, 1, 0.8)
  local profileSaveText = TOCA.FrameOptionsProfile:GetText()
  if ((profileSaveText == " ") or (profileSaveText == "") or (profileSaveText == nil)) then
    print(TOCA.Global.title .. " Totem Set Updated: |cffffff00" .. TOCA.DD.Options.text:GetText())
    TOCADB[TOCA.player.combine]["PROFILES"][TOCA.DD.Options.text:GetText()] = {TOCA_AIR=TOCASlotAIR, TOCA_EARTH=TOCASlotEARTH, TOCA_FIRE=TOCASlotFIRE, TOCA_WATER=TOCASlotWATER}
  else
    if (profileSaveText:match("[^%w%s]")) then
      TOCA.FrameOptionsProfile.border:SetBackdropBorderColor(1, 0.2, 0.2, 1)
      print(TOCA.Global.title .. "|cffff0000 Unable to save profile with non alphanumeric characters!")
    else
      if (TOCADB[TOCA.player.combine]["PROFILES"][profileSaveText]) then
        print(TOCA.Global.title .. " Totem Set Updated: |cffffff00" .. profileSaveText)
      else
        print(TOCA.Global.title .. " Totem Set Saved: |cffffff00" .. profileSaveText)
      end
      TOCADB[TOCA.player.combine]["PROFILES"][profileSaveText] = {TOCA_AIR=TOCASlotAIR, TOCA_EARTH=TOCASlotEARTH, TOCA_FIRE=TOCASlotFIRE, TOCA_WATER=TOCASlotWATER}
      TOCA.UpdateDDMenu(TOCA.DD.Options)
      TOCA.UpdateDDMenu(TOCA.DD.Main)
    end
  end
end)
TOCA.FrameOptionsBtnSave.text = TOCA.FrameOptionsBtnSave:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptionsBtnSave.text:SetFont(TOCA.Global.font, 11)
TOCA.FrameOptionsBtnSave.text:SetPoint("CENTER", 0, 0)
TOCA.FrameOptionsBtnSave.text:SetText("Save")

TOCA.FrameOptionsBtnDelete= CreateFrame("Button", nil, TOCA.FrameOptions, "BackdropTemplate")
TOCA.FrameOptionsBtnDelete:SetSize(80, 25)
TOCA.FrameOptionsBtnDelete:SetPoint("CENTER", -40, -60)
TOCA.FrameOptionsBtnDelete:SetBackdrop(TOCA.Backdrop.Button)
TOCA.FrameOptionsBtnDelete:SetBackdropColor(0.6, 0, 0, 1)
TOCA.FrameOptionsBtnDelete:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameOptionsBtnDelete:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.FrameOptionsBtnDelete:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.FrameOptionsBtnDelete:SetScript("OnClick", function()
  local profileSaveText = TOCA.DD.Options.text:GetText()
  if (profileSaveText == "Default") then
    print(TOCA.Global.title .. "|cffff0000 Unable to remove profile: " .. profileSaveText)
  else
    if (TOCADB[TOCA.player.combine]["PROFILES"][profileSaveText]) then
      TOCADB[TOCA.player.combine]["PROFILES"][profileSaveText] = nil
      TOCA.UpdateDDMenu(TOCA.DD.Options)
      TOCA.UpdateDDMenu(TOCA.DD.Main)
      print(TOCA.Global.title .. " Totem Set Deleted: |cffffff00" .. profileSaveText)
      TOCA.SetDDMenu(TOCA.DD.Main, "Default")
    end
  end
  TOCA.CloseAllMenus()
end)
TOCA.FrameOptionsBtnDelete.text = TOCA.FrameOptionsBtnDelete:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptionsBtnDelete.text:SetFont(TOCA.Global.font, 11)
TOCA.FrameOptionsBtnDelete.text:SetPoint("CENTER", 0, 0)
TOCA.FrameOptionsBtnDelete.text:SetText("Delete")

TOCA.FrameOptionsSlot={}
TOCA.FrameOptionsTotem={}
TOCA.FrameOptionsSlotSelect={}
TOCA.FrameOptionsSlotSelectMenu={}
TOCA.FrameOptionsSlotSelectTotem={}
TOCA.SlotOptions_x = 0
for totemCat,v in pairsByKeys(TOCA.totems) do
  TOCA.SlotOptions_x = TOCA.SlotOptions_x + TOCA.Slot_w+4
  TOCA.FrameOptionsSlot[totemCat]={}
  TOCA.FrameOptionsSlot[totemCat]= CreateFrame("Button", nil, TOCA.FrameOptions, "BackdropTemplate")
  TOCA.FrameOptionsSlot[totemCat]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
  TOCA.FrameOptionsSlot[totemCat]:SetPoint("CENTER", -100+TOCA.SlotOptions_x, 20)
  TOCA.FrameOptionsSlot[totemCat]:SetBackdrop(TOCA.Backdrop.General)
  TOCA.FrameOptionsSlotSelect[totemCat]= CreateFrame("Button", nil, TOCA.FrameOptions, "BackdropTemplate")
  TOCA.FrameOptionsSlotSelect[totemCat]:SetSize(28, 15)
  TOCA.FrameOptionsSlotSelect[totemCat]:SetPoint("CENTER", -100+TOCA.SlotOptions_x, 0)
  TOCA.FrameOptionsSlotSelect[totemCat]:SetBackdrop(TOCA.Backdrop.General)
  TOCA.FrameOptionsSlotSelect[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.FrameOptionsSlotSelect[totemCat]:SetFrameStrata("DIALOG")
  TOCA.FrameOptionsSlotSelect[totemCat]:SetScript("OnEnter", function(self)
    self:SetBackdropBorderColor(1, 1, 0.8, 1)
  end)
  TOCA.FrameOptionsSlotSelect[totemCat]:SetScript("OnLeave", function(self)
    self:SetBackdropBorderColor(1, 1, 1, 0.6)
  end)
  TOCA.FrameOptionsSlotSelect[totemCat]:SetScript("OnClick", function()
    TOCA.CloseAllMenus()
    TOCA.FrameOptionsSlotSelectMenu[totemCat]:Show()
  end)
  TOCA.FrameOptionsSlotSelect[totemCat].icon = TOCA.FrameOptionsSlotSelect[totemCat]:CreateTexture(nil, "ARTWORK")
  TOCA.FrameOptionsSlotSelect[totemCat].icon:SetSize(18, 14)
  TOCA.FrameOptionsSlotSelect[totemCat].icon:SetPoint("CENTER", 0, -3)
  TOCA.FrameOptionsSlotSelect[totemCat].icon:SetTexture("Interface/Buttons/Arrow-Down-Down")

  local totemCategoryCount = getn(TOCA.totems[totemCat])
  TOCA.FrameOptionsSlotSelectMenu[totemCat]= CreateFrame("Frame", nil, TOCA.FrameOptionsSlotSelect[totemCat], "BackdropTemplate")
  TOCA.FrameOptionsSlotSelectMenu[totemCat]:SetSize(40, (totemCategoryCount*40)+30)
  TOCA.FrameOptionsSlotSelectMenu[totemCat]:SetPoint("TOPLEFT", -6, -10)
  TOCA.FrameOptionsSlotSelectMenu[totemCat]:SetBackdrop(TOCA.Backdrop.General)
  TOCA.FrameOptionsSlotSelectMenu[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.FrameOptionsSlotSelectMenu[totemCat]:SetFrameLevel(200)
  TOCA.FrameOptionsSlotSelectMenu[totemCat]:SetFrameStrata("DIALOG")
  TOCA.FrameOptionsSlotSelectMenu[totemCat]:Hide()

  TOCA.FrameOptionsSlotSelectTotemCancel= CreateFrame("Button", nil, TOCA.FrameOptionsSlotSelectMenu[totemCat], "BackdropTemplate")
  TOCA.FrameOptionsSlotSelectTotemCancel:SetSize(35, 35)
  TOCA.FrameOptionsSlotSelectTotemCancel:SetPoint("TOPLEFT", 2.5, -5)
  TOCA.FrameOptionsSlotSelectTotemCancel:SetBackdrop({
    bgFile  = "interface/buttons/UI-GroupLoot-Pass-Down",
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  })
  TOCA.FrameOptionsSlotSelectTotemCancel:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.FrameOptionsSlotSelectTotemCancel:SetScript("OnEnter", function(self)
    self:SetBackdropBorderColor(1, 1, 0.8, 1)
  end)
  TOCA.FrameOptionsSlotSelectTotemCancel:SetScript("OnLeave", function(self)
    self:SetBackdropBorderColor(1, 1, 1, 0.6)
  end)
  TOCA.FrameOptionsSlotSelectTotemCancel:SetScript("OnClick", function()
    TOCA.CloseAllMenus()
  end)

  local totemSpellCount={}
  totemSpellCount[totemCat] = 0
  for i,totemSpell in pairs(TOCA.totems[totemCat]) do
    --print(totemCat .. i .. " " .. totemSpell[1])
    totemSpellCount[totemCat] = totemSpellCount[totemCat]+35
    TOCA.FrameOptionsSlotSelectTotem[totemCat]={}
    TOCA.FrameOptionsSlotSelectTotem[totemCat][i]= CreateFrame("Button", nil, TOCA.FrameOptionsSlotSelectMenu[totemCat], "BackdropTemplate")
    TOCA.FrameOptionsSlotSelectTotem[totemCat][i]:SetSize(35, 35)
    TOCA.FrameOptionsSlotSelectTotem[totemCat][i]:SetPoint("TOPLEFT", 2.5, -totemSpellCount[totemCat]-5)
    TOCA.FrameOptionsSlotSelectTotem[totemCat][i]:SetBackdrop({
      bgFile  = "interface/icons/" .. totemSpell[2],
      edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
      edgeSize= 12,
      insets  = {left=2, right=2, top=2, bottom=2},
    })
    TOCA.FrameOptionsSlotSelectTotem[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0.6)
    TOCA.FrameOptionsSlotSelectTotem[totemCat][i]:SetScript("OnEnter", function(self)
      TOCA.tooltip(self, totemSpell[1], "show")
      self:SetBackdropBorderColor(1, 1, 0.8, 1)
    end)
    TOCA.FrameOptionsSlotSelectTotem[totemCat][i]:SetScript("OnLeave", function(self)
      TOCA.tooltip(self, totemSpell[1], "hide")
      self:SetBackdropBorderColor(1, 1, 1, 0.6)
    end)
    TOCA.FrameOptionsSlotSelectTotem[totemCat][i]:SetScript("OnClick", function()
      --print(totemCat .. " ".. i .. " " .. totemSpell[1])
      if (totemCat == "AIR") then
        TOCASlotAIR = totemSpell[1]
      end
      if (totemCat == "EARTH") then
        TOCASlotEARTH = totemSpell[1]
      end
      if (totemCat == "FIRE") then
        TOCASlotFIRE = totemSpell[1]
      end
      if (totemCat == "WATER") then
        TOCASlotWATER = totemSpell[1]
      end
      print(TOCA.Global.title .. " " .. totemCat .. " : " .. totemSpell[1])
      TOCA.FrameOptionsSlot[totemCat]:SetBackdrop({
        bgFile  = "interface/icons/" .. totemSpell[2],
        edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
        edgeSize= 12,
        insets  = {left=2, right=2, top=2, bottom=2},
      })
      --TOCA.Totem[totemCat]:SetAttribute("spell", totemSpell[1]) -- default
      TOCA.CloseAllMenus()
    end)
  end

  TOCA.FrameOptionsSlot[totemCat]:SetBackdropColor(0, 0, 0, 0.8)
  TOCA.FrameOptionsSlot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
end

TOCA.FrameOptionsProfile = CreateFrame("EditBox", nil, TOCA.FrameOptions, "BackdropTemplate")
TOCA.FrameOptionsProfile:SetWidth(140)
TOCA.FrameOptionsProfile:SetHeight(24)
TOCA.FrameOptionsProfile:SetFontObject(GameFontWhite)
TOCA.FrameOptionsProfile:SetBackdrop({
  bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
  insets  = {left=-2, right=6, top=2, bottom=2},
})
TOCA.FrameOptionsProfile:SetBackdropColor(0, 0, 0, 1)
TOCA.FrameOptionsProfile:SetPoint("CENTER", 0, -26)
TOCA.FrameOptionsProfile:ClearFocus(self)
TOCA.FrameOptionsProfile:SetAutoFocus(false)
TOCA.FrameOptionsProfile.border = CreateFrame("Frame", nil, TOCA.FrameOptionsProfile, "BackdropTemplate")
TOCA.FrameOptionsProfile.border:SetWidth(140)
TOCA.FrameOptionsProfile.border:SetHeight(24)
TOCA.FrameOptionsProfile.border:SetPoint("TOPLEFT", -4, 0)
TOCA.FrameOptionsProfile.border:SetBackdrop({
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
})
TOCA.FrameOptionsProfile:SetScript("OnKeyUp", function(self)
  TOCA.CloseAllMenus()
end)

TOCA.DD = {}
TOCA.DD.Menu = {"Default"}
TOCA.DD.Main = CreateFrame("Frame", nil, TOCA.FrameMain, "UIDropDownMenuTemplate")
TOCA.DD.Main:SetPoint("CENTER", 0, -30)
TOCA.DD.Main.displayMode = "MENU"
TOCA.DD.Main.text = TOCA.DD.Main:CreateFontString(nil, "ARTWORK")
TOCA.DD.Main.text:SetFont(TOCA.Global.font, 11)
TOCA.DD.Main.text:SetPoint("TOPLEFT", TOCA.DD.Main, "TOPLEFT", 25, -8)
TOCA.DD.Main.text:SetText(TOCA.DD.Menu[1])
TOCA.DD.Main.onClick = function(self, checked)
  TOCA.SetDDMenu(TOCA.DD.Main, self.value)
end
UIDropDownMenu_SetWidth(TOCA.DD.Main, TOCA.Global.width-60)

TOCA.DD.Options = CreateFrame("Frame", nil, TOCA.FrameOptions, "UIDropDownMenuTemplate")
TOCA.DD.Options:SetPoint("CENTER", 0, 50)
TOCA.DD.Options.displayMode = "MENU"
TOCA.DD.Options.text = TOCA.DD.Options:CreateFontString(nil, "ARTWORK")
TOCA.DD.Options.text:SetFont(TOCA.Global.font, 11)
TOCA.DD.Options.text:SetPoint("TOPLEFT", TOCA.DD.Options, "TOPLEFT", 25, -8)
TOCA.DD.Options.text:SetText(TOCA.DD.Menu[1])
TOCA.FrameOptionsProfile:SetText(TOCA.DD.Menu[1])
TOCA.DD.Options.onClick = function(self, checked)
  --TOCA.DD.Options.text:SetText(self.value)
  TOCA.SetDDMenu(TOCA.DD.Options, self.value)
  TOCA.FrameOptionsProfile:SetText(self.value)
end
UIDropDownMenu_SetWidth(TOCA.DD.Options, TOCA.Global.width-60)
