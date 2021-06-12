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

TOCA.FrameSets = CreateFrame("Button", TOCA.FrameSets, TOCA.FrameOptions, "BackdropTemplate")
TOCA.FrameSets:SetWidth(300)
TOCA.FrameSets:SetHeight(180)
TOCA.FrameSets:SetPoint("CENTER", 170, 100)
--[==[
TOCA.FrameSets:SetBackdrop(TOCA.Backdrop.BorderOnly)
TOCA.FrameSets:SetBackdropColor(0, 0, 0, 0.8)
TOCA.FrameSets:SetBackdropBorderColor(1, 1, 1, 0.6)
]==]--
TOCA.FrameSets.title = TOCA.FrameSets:CreateFontString(nil, "ARTWORK")
TOCA.FrameSets.title:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.FrameSets.title:SetPoint("CENTER", 0, 80)
TOCA.FrameSets.title:SetText("Totem Set Builder")
TOCA.FrameSets:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
end)
TOCA.FrameSets:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)

TOCA.Button.FrameSetsSave= CreateFrame("Button", nil, TOCA.FrameSets, "BackdropTemplate")
TOCA.Button.FrameSetsSave:SetSize(100, 25)
TOCA.Button.FrameSetsSave:SetPoint("CENTER", 55, -60)
TOCA.Button.FrameSetsSave:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.FrameSetsSave:SetBackdropColor(0, 0.7, 0, 1)
TOCA.Button.FrameSetsSave:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.FrameSetsSave:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.Button.FrameSetsSave:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.Button.FrameSetsSave:SetScript("OnClick", function()
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
TOCA.Button.FrameSetsSaveText = TOCA.Button.FrameSetsSave:CreateFontString(nil, "ARTWORK")
TOCA.Button.FrameSetsSaveText:SetFont(TOCA.Global.font, 11)
TOCA.Button.FrameSetsSaveText:SetPoint("CENTER", 0, 0)
TOCA.Button.FrameSetsSaveText:SetText("Save")

TOCA.Button.FrameSetsDeleteOpenPrompt= CreateFrame("Button", nil, TOCA.FrameSets, "BackdropTemplate")
TOCA.Button.FrameSetsDeleteOpenPrompt:SetSize(100, 25)
TOCA.Button.FrameSetsDeleteOpenPrompt:SetPoint("CENTER", -55, -60)
TOCA.Button.FrameSetsDeleteOpenPrompt:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.FrameSetsDeleteOpenPrompt:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.FrameSetsDeleteOpenPrompt:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.FrameSetsDeleteOpenPrompt:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.Button.FrameSetsDeleteOpenPrompt:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.Button.FrameSetsDeleteOpenPrompt:SetScript("OnClick", function()
  local profileSaveText = TOCA.Dropdown.Sets.text:GetText()
  if (profileSaveText == TOCA.Dropdown.Menu[1]) then
    print(TOCA.Global.title .. "|cffff0000 Unable to remove profile:|r " .. profileSaveText)
  else
    TOCA.Prompt.DeleteSetText:SetText('Delete Totem Set "' .. profileSaveText .. '" ?')
    TOCA.Prompt.DeleteSet:Show()
    --TOCA.FrameSets:Hide()
    TOCA.FrameOptions:SetAlpha(0.50)
  end
end)
TOCA.Button.FrameSetsDeleteOpenPromptText = TOCA.Button.FrameSetsDeleteOpenPrompt:CreateFontString(nil, "ARTWORK")
TOCA.Button.FrameSetsDeleteOpenPromptText:SetFont(TOCA.Global.font, 11)
TOCA.Button.FrameSetsDeleteOpenPromptText:SetPoint("CENTER", 0, 0)
TOCA.Button.FrameSetsDeleteOpenPromptText:SetText("Delete")


--PROMPT BO
TOCA.Prompt.DeleteSet = CreateFrame("Frame", TOCA.Prompt.DeleteSet, UIParent, "BackdropTemplate")
TOCA.Prompt.DeleteSet:SetWidth(340)
TOCA.Prompt.DeleteSet:SetHeight(100)
TOCA.Prompt.DeleteSet:SetPoint("CENTER", 0, 50)
TOCA.Prompt.DeleteSet:SetBackdrop(TOCA.Backdrop.General)
TOCA.Prompt.DeleteSet:SetBackdropColor(0, 0, 0, 1)
TOCA.Prompt.DeleteSet:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Prompt.DeleteSet:SetFrameStrata("DIALOG")
TOCA.Prompt.DeleteSetText = TOCA.Prompt.DeleteSet:CreateFontString(nil, "ARTWORK")
TOCA.Prompt.DeleteSetText:SetFont(TOCA.Global.font, 14, "OUTLINE")
TOCA.Prompt.DeleteSetText:SetPoint("CENTER", 0, 20)
TOCA.Prompt.DeleteSetText:SetText("...")
TOCA.Prompt.DeleteSet:Hide()

TOCA.Button.FrameSetsDelete= CreateFrame("Button", nil, TOCA.Prompt.DeleteSet, "BackdropTemplate")
TOCA.Button.FrameSetsDelete:SetSize(100, 25)
TOCA.Button.FrameSetsDelete:SetPoint("CENTER", 60, -20)
TOCA.Button.FrameSetsDelete:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.FrameSetsDelete:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.FrameSetsDelete:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.FrameSetsDelete:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.Button.FrameSetsDelete:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.Button.FrameSetsDelete:SetScript("OnClick", function()
  local profileSaveText = TOCA.Dropdown.Sets.text:GetText()
  if (profileSaveText == TOCA.Dropdown.Menu[1]) then
    print(TOCA.Global.title .. "|cffff0000 Unable to remove profile:|r " .. profileSaveText)
  else
    if (TOCADB[TOCA.player.combine]["PROFILES"][profileSaveText]) then
      TOCADB[TOCA.player.combine]["PROFILES"][profileSaveText] = nil
      TOCA.UpdateDDMenu(TOCA.Dropdown.Sets)
      TOCA.UpdateDDMenu(TOCA.Dropdown.Main)
      print(TOCA.Global.title .. " Totem Set Deleted: |cffffff00" .. profileSaveText)
      TOCA.SetDDMenu(TOCA.Dropdown.Main, TOCA.Dropdown.Menu[1])
      TOCA.FrameSetsProfile:SetText("")
      TOCA.Prompt.DeleteSet:Hide()
      TOCA.FrameOptions:SetAlpha(1)
    end
  end
  TOCA.CloseAllMenus()
end)
TOCA.Button.FrameSetsDeleteText = TOCA.Button.FrameSetsDelete:CreateFontString(nil, "ARTWORK")
TOCA.Button.FrameSetsDeleteText:SetFont(TOCA.Global.font, 11)
TOCA.Button.FrameSetsDeleteText:SetPoint("CENTER", 0, 0)
TOCA.Button.FrameSetsDeleteText:SetText("Yes")

TOCA.Button.FrameSetsCancel= CreateFrame("Button", nil, TOCA.Prompt.DeleteSet, "BackdropTemplate")
TOCA.Button.FrameSetsCancel:SetSize(100, 25)
TOCA.Button.FrameSetsCancel:SetPoint("CENTER", -60, -20)
TOCA.Button.FrameSetsCancel:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.FrameSetsCancel:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.FrameSetsCancel:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.FrameSetsCancel:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.Button.FrameSetsCancel:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.Button.FrameSetsCancel:SetScript("OnClick", function()
  --TOCA.FrameSets:Show()
  TOCA.Prompt.DeleteSet:Hide()
  TOCA.FrameOptions:SetAlpha(1)
end)
TOCA.Button.FrameSetsCancelText = TOCA.Button.FrameSetsCancel:CreateFontString(nil, "ARTWORK")
TOCA.Button.FrameSetsCancelText:SetFont(TOCA.Global.font, 11)
TOCA.Button.FrameSetsCancelText:SetPoint("CENTER", 0, 0)
TOCA.Button.FrameSetsCancelText:SetText("No")
--PROMPT EO


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
      TOCA.tooltip(totemSpell[1], totemCat, totemSpell[3])
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
TOCA.Dropdown.Sets:SetPoint("CENTER", -4, 50)
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
UIDropDownMenu_SetWidth(TOCA.Dropdown.Sets, 135)


---- TOTEM ORDER -----
--[==[
TOCA.SlotOrderTitle = TOCA.FrameOptions:CreateFontString(nil, "ARTWORK")
TOCA.SlotOrderTitle:SetFont(TOCA.Global.font, 12)
TOCA.SlotOrderTitle:SetPoint("CENTER", 170, -20)
TOCA.SlotOrderTitle:SetText("Totem Order")

TOCA.SlotOrderBack={}
TOCA.Dropdown.OrderSet={}
TOCA.Dropdown.OrderSetMenu={"AIR", "EARTH", "FIRE", "WATER"}

local totemNum = 0
for totemCat,v in pairsByKeys(TOCA.totems) do
  TOCA.SlotSets_x = TOCA.SlotSets_x + 68
  totemNum = totemNum+1

  --TOCA.SlotOrder[totemCat]={}
  TOCA.SlotOrderBack[totemCat]= CreateFrame("Button", nil, TOCA.FrameOptions, "BackdropTemplate")
  TOCA.SlotOrderBack[totemCat]:SetSize(40, 40)
  TOCA.SlotOrderBack[totemCat]:SetPoint("CENTER", -90+TOCA.SlotSets_x, -60)
  TOCA.SlotOrderBack[totemCat]:SetBackdrop(TOCA.Backdrop.General)
  --TOCA.SlotOrderBack[totemCat]={}
  TOCA.SlotOrderBack[totemCat].text = TOCA.SlotOrderBack[totemCat]:CreateFontString(nil, "ARTWORK")
  TOCA.SlotOrderBack[totemCat].text:SetFont(TOCA.Global.font, 8)
  TOCA.SlotOrderBack[totemCat].text:SetPoint("CENTER", 1, 0)
  TOCA.SlotOrderBack[totemCat].text:SetText(totemCat)
  if (totemCat == "AIR") then
    TOCA.SlotOrderBack[totemCat].text:SetTextColor(1, 1, 1, 1)
  end
  if (totemCat == "EARTH") then
    TOCA.SlotOrderBack[totemCat].text:SetTextColor(1, 0.7, 0.4, 1)
  end
  if (totemCat == "FIRE") then
    TOCA.SlotOrderBack[totemCat].text:SetTextColor(0.8, 0.4, 0, 1)
  end
  if (totemCat == "WATER") then
    TOCA.SlotOrderBack[totemCat].text:SetTextColor(0.4, 0.6, 1, 1)
  end


  TOCA.Dropdown.OrderSet[totemCat] = CreateFrame("Frame", nil, TOCA.FrameOptions, "UIDropDownMenuTemplate")
  TOCA.Dropdown.OrderSet[totemCat]:SetPoint("CENTER", -150+TOCA.SlotSets_x, -50)
  TOCA.Dropdown.OrderSet[totemCat].displayMode = "MENU"
  TOCA.Dropdown.OrderSet[totemCat].text = TOCA.Dropdown.OrderSet[totemCat]:CreateFontString(nil, "ARTWORK")
  TOCA.Dropdown.OrderSet[totemCat].text:SetFont(TOCA.Global.font, 10)
  TOCA.Dropdown.OrderSet[totemCat].text:SetPoint("TOPLEFT", TOCA.Dropdown.OrderSet[totemCat], "TOPLEFT", 25, -8)
  TOCA.Dropdown.OrderSet[totemCat].text:SetText(TOCA.Dropdown.OrderSetMenu[totemNum])
  TOCA.Dropdown.OrderSet[totemCat].onClick = function(self, checked)
    TOCA.Dropdown.OrderSet[totemCat].text:SetText(self.value)
    --print(totemCat .. " = " .. self.value)
    TOCA.BuildTotemOrder()
  end
  TOCA.Dropdown.OrderSet[totemCat].initialize = function(self, level)
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
  UIDropDownMenu_SetWidth(TOCA.Dropdown.OrderSet[totemCat], 50)
end
]==]--
