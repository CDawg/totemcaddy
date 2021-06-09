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

TOCA.FrameOptions = CreateFrame("Frame", TOCA.FrameOptions, UIParent, "BackdropTemplate")
TOCA.FrameOptions:SetWidth(300)
TOCA.FrameOptions:SetHeight(200)
TOCA.FrameOptions:SetPoint("CENTER", 0, 50)
TOCA.FrameOptions:SetBackdrop(TOCA.Backdrop.General)
TOCA.FrameOptions:SetBackdropColor(0, 0, 0, 0.8)
TOCA.FrameOptions:SetBackdropBorderColor(1, 1, 1, 0.6)
--[==[
TOCA.FrameSets.title = TOCA.FrameSets:CreateFontString(nil, "ARTWORK")
TOCA.FrameSets.title:SetFont(TOCA.Global.font, 14, "OUTLINE")
TOCA.FrameSets.title:SetPoint("TOPLEFT", 10, -10)
TOCA.FrameSets.title:SetText(TOCA.Global.title .. " Set Builder")
]==]--
TOCA.FrameOptions:Hide()

TOCA.FrameSets = CreateFrame("Button", TOCA.FrameSets, UIParent, "BackdropTemplate")
TOCA.FrameSets:SetWidth(300)
TOCA.FrameSets:SetHeight(200)
TOCA.FrameSets:SetPoint("CENTER", 0, 50)
TOCA.FrameSets:SetBackdrop(TOCA.Backdrop.General)
TOCA.FrameSets:SetBackdropColor(0, 0, 0, 0.8)
TOCA.FrameSets:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameSets.title = TOCA.FrameSets:CreateFontString(nil, "ARTWORK")
TOCA.FrameSets.title:SetFont(TOCA.Global.font, 14, "OUTLINE")
TOCA.FrameSets.title:SetPoint("TOPLEFT", 10, -10)
TOCA.FrameSets.title:SetText(TOCA.Global.title .. " Set Builder")
TOCA.FrameSets:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
end)
TOCA.FrameSets:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)
TOCA.FrameSets:Hide()

TOCA.FrameSetsBtnClose= CreateFrame("Button", nil, TOCA.FrameSets, "BackdropTemplate")
TOCA.FrameSetsBtnClose:SetSize(18, 18)
TOCA.FrameSetsBtnClose:SetPoint("TOPRIGHT", -2, -2)
TOCA.FrameSetsBtnClose:SetBackdrop(TOCA.Backdrop.Button)
TOCA.FrameSetsBtnClose:SetBackdropColor(0.6, 0, 0, 1)
TOCA.FrameSetsBtnClose:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameSetsBtnClose.icon = TOCA.FrameSetsBtnClose:CreateTexture(nil, "ARTWORK")
TOCA.FrameSetsBtnClose.icon:SetSize(12, 12)
TOCA.FrameSetsBtnClose.icon:SetPoint("CENTER", 0, 0)
TOCA.FrameSetsBtnClose.icon:SetTexture("Interface/Buttons/UI-StopButton")
TOCA.FrameSetsBtnClose:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.FrameSetsBtnClose:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.FrameSetsBtnClose:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
  TOCA.FrameSets:Hide()
end)

TOCA.FrameSetsBtnSave= CreateFrame("Button", nil, TOCA.FrameSets, "BackdropTemplate")
TOCA.FrameSetsBtnSave:SetSize(80, 25)
TOCA.FrameSetsBtnSave:SetPoint("CENTER", 40, -60)
TOCA.FrameSetsBtnSave:SetBackdrop(TOCA.Backdrop.Button)
TOCA.FrameSetsBtnSave:SetBackdropColor(0, 0.7, 0, 1)
TOCA.FrameSetsBtnSave:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameSetsBtnSave:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.FrameSetsBtnSave:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.FrameSetsBtnSave:SetScript("OnClick", function()
  TOCA.FrameSetsProfile.border:SetBackdropBorderColor(1, 1, 1, 0.8)
  local profileSaveText = TOCA.FrameSetsProfile:GetText()
  if ((profileSaveText == " ") or (profileSaveText == "") or (profileSaveText == nil)) then
    print(TOCA.Global.title .. " Totem Set Updated: |cffffff00" .. TOCA.Dropdown.Sets.text:GetText())
    TOCADB[TOCA.player.combine]["PROFILES"][TOCA.Dropdown.Sets.text:GetText()] = {TOCA_AIR=TOCASlotAIR, TOCA_EARTH=TOCASlotEARTH, TOCA_FIRE=TOCASlotFIRE, TOCA_WATER=TOCASlotWATER}
  else
    if (profileSaveText:match("[^%w%s]")) then
      TOCA.FrameSetsProfile.border:SetBackdropBorderColor(1, 0.2, 0.2, 1)
      print(TOCA.Global.title .. "|cffff0000 Unable to save profile with non alphanumeric characters!")
    else
      if (TOCADB[TOCA.player.combine]["PROFILES"][profileSaveText]) then
        print(TOCA.Global.title .. " Totem Set Updated: |cffffff00" .. profileSaveText)
      else
        print(TOCA.Global.title .. " Totem Set Saved: |cffffff00" .. profileSaveText)
      end
      TOCADB[TOCA.player.combine]["PROFILES"][profileSaveText] = {TOCA_AIR=TOCASlotAIR, TOCA_EARTH=TOCASlotEARTH, TOCA_FIRE=TOCASlotFIRE, TOCA_WATER=TOCASlotWATER}
      TOCA.UpdateDDMenu(TOCA.Dropdown.Sets)
      TOCA.UpdateDDMenu(TOCA.Dropdown.Main)
    end
  end
end)
TOCA.FrameSetsBtnSave.text = TOCA.FrameSetsBtnSave:CreateFontString(nil, "ARTWORK")
TOCA.FrameSetsBtnSave.text:SetFont(TOCA.Global.font, 11)
TOCA.FrameSetsBtnSave.text:SetPoint("CENTER", 0, 0)
TOCA.FrameSetsBtnSave.text:SetText("Save")

TOCA.FrameSetsBtnDelete= CreateFrame("Button", nil, TOCA.FrameSets, "BackdropTemplate")
TOCA.FrameSetsBtnDelete:SetSize(80, 25)
TOCA.FrameSetsBtnDelete:SetPoint("CENTER", -40, -60)
TOCA.FrameSetsBtnDelete:SetBackdrop(TOCA.Backdrop.Button)
TOCA.FrameSetsBtnDelete:SetBackdropColor(0.6, 0, 0, 1)
TOCA.FrameSetsBtnDelete:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameSetsBtnDelete:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.FrameSetsBtnDelete:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.FrameSetsBtnDelete:SetScript("OnClick", function()
  local profileSaveText = TOCA.Dropdown.Sets.text:GetText()
  if (profileSaveText == "Default") then
    print(TOCA.Global.title .. "|cffff0000 Unable to remove profile:|r " .. profileSaveText)
  else
    if (TOCADB[TOCA.player.combine]["PROFILES"][profileSaveText]) then
      TOCADB[TOCA.player.combine]["PROFILES"][profileSaveText] = nil
      TOCA.UpdateDDMenu(TOCA.Dropdown.Sets)
      TOCA.UpdateDDMenu(TOCA.Dropdown.Main)
      print(TOCA.Global.title .. " Totem Set Deleted: |cffffff00" .. profileSaveText)
      TOCA.SetDDMenu(TOCA.Dropdown.Main, "Default")
      TOCA.FrameSetsProfile:SetText("")
    end
  end
  TOCA.CloseAllMenus()
end)
TOCA.FrameSetsBtnDelete.text = TOCA.FrameSetsBtnDelete:CreateFontString(nil, "ARTWORK")
TOCA.FrameSetsBtnDelete.text:SetFont(TOCA.Global.font, 11)
TOCA.FrameSetsBtnDelete.text:SetPoint("CENTER", 0, 0)
TOCA.FrameSetsBtnDelete.text:SetText("Delete")

TOCA.FrameSetsSlot={}
TOCA.FrameSetsTotem={}
TOCA.FrameSetsSlotSelect={}
TOCA.FrameSetsSlotSelectMenu={}
TOCA.FrameSetsSlotSelectTotem={}
TOCA.SlotSets_x = 0
for totemCat,v in pairsByKeys(TOCA.totems) do
  TOCA.SlotSets_x = TOCA.SlotSets_x + TOCA.Slot_w+4
  TOCA.FrameSetsSlot[totemCat]={}
  TOCA.FrameSetsSlot[totemCat]= CreateFrame("Button", nil, TOCA.FrameSets, "BackdropTemplate")
  TOCA.FrameSetsSlot[totemCat]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
  TOCA.FrameSetsSlot[totemCat]:SetPoint("CENTER", -100+TOCA.SlotSets_x, 20)
  TOCA.FrameSetsSlot[totemCat]:SetBackdrop(TOCA.Backdrop.General)
  TOCA.FrameSetsSlotSelect[totemCat]= CreateFrame("Button", nil, TOCA.FrameSets, "BackdropTemplate")
  TOCA.FrameSetsSlotSelect[totemCat]:SetSize(35, 15)
  TOCA.FrameSetsSlotSelect[totemCat]:SetPoint("CENTER", -100+TOCA.SlotSets_x, 0)
  TOCA.FrameSetsSlotSelect[totemCat]:SetBackdrop(TOCA.Backdrop.General)
  TOCA.FrameSetsSlotSelect[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.FrameSetsSlotSelect[totemCat]:SetFrameStrata("DIALOG")
  TOCA.FrameSetsSlotSelect[totemCat]:SetScript("OnEnter", function(self)
    self:SetBackdropBorderColor(1, 1, 0.8, 1)
  end)
  TOCA.FrameSetsSlotSelect[totemCat]:SetScript("OnLeave", function(self)
    self:SetBackdropBorderColor(1, 1, 1, 0.6)
  end)
  TOCA.FrameSetsSlotSelect[totemCat]:SetScript("OnClick", function()
    TOCA.CloseAllMenus()
    if (TOCA.MenuIsOpenSets == 0) then
      TOCA.EnableKnownTotems()
      TOCA.FrameSetsSlotSelectMenu[totemCat]:Show()
      TOCA.MenuIsOpenSets = 1
    else
      TOCA.MenuIsOpenSets = 0
    end
  end)
  TOCA.FrameSetsSlotSelect[totemCat].icon = TOCA.FrameSetsSlotSelect[totemCat]:CreateTexture(nil, "ARTWORK")
  TOCA.FrameSetsSlotSelect[totemCat].icon:SetSize(18, 14)
  TOCA.FrameSetsSlotSelect[totemCat].icon:SetPoint("CENTER", 0, -3)
  TOCA.FrameSetsSlotSelect[totemCat].icon:SetTexture("Interface/Buttons/Arrow-Down-Down")

  local totemCategoryCount = getn(TOCA.totems[totemCat])
  TOCA.FrameSetsSlotSelectMenu[totemCat]= CreateFrame("Frame", nil, TOCA.FrameSetsSlotSelect[totemCat], "BackdropTemplate")
  TOCA.FrameSetsSlotSelectMenu[totemCat]:SetSize(40, (totemCategoryCount*40)+30)
  TOCA.FrameSetsSlotSelectMenu[totemCat]:SetPoint("TOPLEFT", -2, -10)
  TOCA.FrameSetsSlotSelectMenu[totemCat]:SetBackdrop(TOCA.Backdrop.General)
  TOCA.FrameSetsSlotSelectMenu[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.FrameSetsSlotSelectMenu[totemCat]:SetFrameLevel(200)
  TOCA.FrameSetsSlotSelectMenu[totemCat]:SetFrameStrata("DIALOG")
  TOCA.FrameSetsSlotSelectMenu[totemCat]:Hide()

  TOCA.FrameSetsSlotSelectTotemCancel= CreateFrame("Button", nil, TOCA.FrameSetsSlotSelectMenu[totemCat], "BackdropTemplate")
  TOCA.FrameSetsSlotSelectTotemCancel:SetSize(35, 35)
  TOCA.FrameSetsSlotSelectTotemCancel:SetPoint("TOPLEFT", 2.5, -5)
  TOCA.FrameSetsSlotSelectTotemCancel:SetBackdrop({
    bgFile  = "interface/buttons/UI-GroupLoot-Pass-Down",
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  })
  TOCA.FrameSetsSlotSelectTotemCancel:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.FrameSetsSlotSelectTotemCancel:SetScript("OnEnter", function(self)
    self:SetBackdropBorderColor(1, 1, 0.8, 1)
  end)
  TOCA.FrameSetsSlotSelectTotemCancel:SetScript("OnLeave", function(self)
    self:SetBackdropBorderColor(1, 1, 1, 0.6)
  end)
  TOCA.FrameSetsSlotSelectTotemCancel:SetScript("OnClick", function()
    TOCA.CloseAllMenus()
  end)

  local totemSpellCount={}
  totemSpellCount[totemCat] = 0
  for i,totemSpell in pairs(TOCA.totems[totemCat]) do
    --print(totemCat .. i .. " " .. totemSpell[1])
    totemSpellCount[totemCat] = totemSpellCount[totemCat]+35
    TOCA.FrameSetsSlotSelectTotem[totemCat]={}
    TOCA.FrameSetsSlotSelectTotem[totemCat][i]= CreateFrame("Button", nil, TOCA.FrameSetsSlotSelectMenu[totemCat], "BackdropTemplate")
    TOCA.FrameSetsSlotSelectTotem[totemCat][i]:SetSize(35, 35)
    TOCA.FrameSetsSlotSelectTotem[totemCat][i]:SetPoint("TOPLEFT", 2.5, -totemSpellCount[totemCat]-5)
    TOCA.FrameSetsSlotSelectTotem[totemCat][i]:SetBackdrop({
      bgFile  = "interface/icons/" .. totemSpell[2],
      edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
      edgeSize= 12,
      insets  = {left=2, right=2, top=2, bottom=2},
    })
    TOCA.FrameSetsSlotSelectTotem[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0.6)
    TOCA.FrameSetsSlotSelectTotem[totemCat][i]:SetScript("OnEnter", function(self)
      --TOCA.tooltip(self, totemSpell[1], "show")
      TOCA.tooltip(self, totemSpell[1], totemCat, totemSpell[3])
      self:SetBackdropBorderColor(1, 1, 0.8, 1)
    end)
    TOCA.FrameSetsSlotSelectTotem[totemCat][i]:SetScript("OnLeave", function(self)
      _GTooltip:Hide()
      self:SetBackdropBorderColor(1, 1, 1, 0.6)
    end)
    TOCA.FrameSetsSlotSelectTotem[totemCat][i]:SetScript("OnClick", function()
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
      TOCA.FrameSetsSlot[totemCat]:SetBackdrop({
        bgFile  = "interface/icons/" .. totemSpell[2],
        edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
        edgeSize= 12,
        insets  = {left=2, right=2, top=2, bottom=2},
      })
      TOCA.CloseAllMenus()
    end)
    TOCA.FrameSetsSlotDisabled[totemCat][i]= CreateFrame("Button", nil, TOCA.FrameSetsSlotSelectTotem[totemCat][i], "BackdropTemplate")
    TOCA.FrameSetsSlotDisabled[totemCat][i]:SetSize(35, 35)
    TOCA.FrameSetsSlotDisabled[totemCat][i]:SetPoint("CENTER", 0, 0)
    TOCA.FrameSetsSlotDisabled[totemCat][i]:SetBackdrop(TOCA.Backdrop.RGB)
    TOCA.FrameSetsSlotDisabled[totemCat][i]:SetBackdropColor(0, 0, 0, 1)
  end

  TOCA.FrameSetsSlot[totemCat]:SetBackdropColor(0, 0, 0, 0.8)
  TOCA.FrameSetsSlot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
end

TOCA.FrameSetsProfile = CreateFrame("EditBox", nil, TOCA.FrameSets, "BackdropTemplate")
TOCA.FrameSetsProfile:SetWidth(140)
TOCA.FrameSetsProfile:SetHeight(24)
TOCA.FrameSetsProfile:SetFontObject(GameFontWhite)
TOCA.FrameSetsProfile:SetBackdrop({
  bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
  insets  = {left=-2, right=6, top=2, bottom=2},
})
TOCA.FrameSetsProfile:SetBackdropColor(0, 0, 0, 1)
TOCA.FrameSetsProfile:SetPoint("CENTER", 0, -26)
TOCA.FrameSetsProfile:ClearFocus(self)
TOCA.FrameSetsProfile:SetAutoFocus(false)
TOCA.FrameSetsProfile:SetMaxLetters(25)
TOCA.FrameSetsProfile.border = CreateFrame("Frame", nil, TOCA.FrameSetsProfile, "BackdropTemplate")
TOCA.FrameSetsProfile.border:SetWidth(140)
TOCA.FrameSetsProfile.border:SetHeight(24)
TOCA.FrameSetsProfile.border:SetPoint("TOPLEFT", -4, 0)
TOCA.FrameSetsProfile.border:SetBackdrop({
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
})
TOCA.FrameSetsProfile:SetScript("OnKeyUp", function(self)
  TOCA.CloseAllMenus()
end)

TOCA.Dropdown.Sets = CreateFrame("Frame", nil, TOCA.FrameSets, "UIDropDownMenuTemplate")
TOCA.Dropdown.Sets:SetPoint("CENTER", 0, 50)
TOCA.Dropdown.Sets.displayMode = "MENU"
TOCA.Dropdown.Sets.text = TOCA.Dropdown.Sets:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.Sets.text:SetFont(TOCA.Global.font, 11)
TOCA.Dropdown.Sets.text:SetPoint("TOPLEFT", TOCA.Dropdown.Sets, "TOPLEFT", 25, -8)
TOCA.Dropdown.Sets.text:SetText(TOCA.Dropdown.Menu[1])
TOCA.FrameSetsProfile:SetText(TOCA.Dropdown.Menu[1])
TOCA.Dropdown.Sets.onClick = function(self, checked)
  --TOCA.Dropdown.Sets.text:SetText(self.value)
  TOCA.SetDDMenu(TOCA.Dropdown.Sets, self.value)
  TOCA.FrameSetsProfile:SetText(self.value)
end
UIDropDownMenu_SetWidth(TOCA.Dropdown.Sets, 140)
