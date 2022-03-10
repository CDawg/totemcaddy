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

TOCA.FrameSets = CreateFrame("Button", TOCA.FrameSets, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[2]], "BackdropTemplate")
TOCA.FrameSets:SetWidth(300)
TOCA.FrameSets:SetHeight(180)
TOCA.FrameSets:SetPoint("TOPLEFT", 50, 0)

TOCA.FrameSets:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
end)
TOCA.FrameSets:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)

TOCA.Button.FrameSetsSave= CreateFrame("Button", nil, TOCA.FrameSets, "BackdropTemplate")
TOCA.Button.FrameSetsSave:SetSize(100, 25)
TOCA.Button.FrameSetsSave:SetPoint("TOPLEFT", 170, -60)
TOCA.Button.FrameSetsSave:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.FrameSetsSave:SetBackdropColor(0, 0.7, 0, 1)
TOCA.Button.FrameSetsSave:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.FrameSetsSave:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
  local profileSaveText = TOCA.FrameSetsProfile:GetText()
  if ((profileSaveText == " ") or (profileSaveText == "") or (profileSaveText == nil)) then
    TOCA.TooltipDisplay(self, TOCA.locale.UI.TOTEMSET[5][1], "Save the totem presets for a quick selection.")
  else
    TOCA.TooltipDisplay(self, TOCA.locale.UI.TOTEMSET[5][1], "Set: |cffffffff" .. profileSaveText .. "|r|n|nSave the totem presets for a quick selection. (pre combat)")
  end
end)
TOCA.Button.FrameSetsSave:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.CloseAllMenus()
end)
TOCA.Button.FrameSetsSave:SetScript("OnClick", function()
  TOCA.FrameSetsProfile.border:SetBackdropBorderColor(1, 1, 1, 0.8)
  local profileSaveText = TOCA.FrameSetsProfile:GetText()
  if ((profileSaveText == " ") or (profileSaveText == "") or (profileSaveText == nil)) then
    TOCA.Notification(TOCA.locale.UI.TOTEMSET[8][1] .. ": |cffffff00" .. TOCA.Dropdown.Sets.text:GetText())
    TOCADB[TOCA.player.combine]["PROFILES"][TOCA.Dropdown.Sets.text:GetText()] = {TOCA_AIR=TOCA.cache[1], TOCA_EARTH=TOCA.cache[2], TOCA_FIRE=TOCA.cache[3], TOCA_WATER=TOCA.cache[4]}
  else
    --if (profileSaveText:match("[^%w%s]")) then
		if (profileSaveText:match("%b''")) then
      TOCA.FrameSetsProfile.border:SetBackdropBorderColor(1, 0.2, 0.2, 1)
      TOCA.Notification("|cffff0000 Unable to save profile with non alphanumeric characters!")
    else
      if (TOCADB[TOCA.player.combine]["PROFILES"][profileSaveText]) then
        TOCA.Notification(TOCA.locale.UI.TOTEMSET[8][1] .. ": |cffffff00" .. profileSaveText)
      else
        TOCA.Notification(TOCA.locale.UI.TOTEMSET[7][1] .. ": |cffffff00" .. profileSaveText)
      end
      TOCADB[TOCA.player.combine]["PROFILES"][profileSaveText] = {TOCA_AIR=TOCA.cache[1], TOCA_EARTH=TOCA.cache[2], TOCA_FIRE=TOCA.cache[3], TOCA_WATER=TOCA.cache[4]}
      TOCA.UpdateDDMenu(TOCA.Dropdown.Sets)
      TOCA.UpdateDDMenu(TOCA.Dropdown.Main)
    end
  end
end)
TOCA.Button.FrameSetsSaveText = TOCA.Button.FrameSetsSave:CreateFontString(nil, "ARTWORK")
TOCA.Button.FrameSetsSaveText:SetFont(TOCA.Global.font, 11)
TOCA.Button.FrameSetsSaveText:SetPoint("CENTER", 0, 0)
TOCA.Button.FrameSetsSaveText:SetText(TOCA.locale.UI.BUTTON[2])

TOCA.Button.FrameSetsDeleteOpenPrompt= CreateFrame("Button", nil, TOCA.FrameSets, "BackdropTemplate")
TOCA.Button.FrameSetsDeleteOpenPrompt:SetSize(100, 25)
TOCA.Button.FrameSetsDeleteOpenPrompt:SetPoint("TOPLEFT", 170, -90)
TOCA.Button.FrameSetsDeleteOpenPrompt:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.FrameSetsDeleteOpenPrompt:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.FrameSetsDeleteOpenPrompt:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.FrameSetsDeleteOpenPrompt:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
  TOCA.TooltipDisplay(self, TOCA.locale.UI.TOTEMSET[4][1], "Set: |cffffffff" .. TOCA.Dropdown.Sets.text:GetText() .. "|r|n|nDelete the totem preset.|nThe core default totem set can not be deleted.")
end)
TOCA.Button.FrameSetsDeleteOpenPrompt:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.CloseAllMenus()
end)
TOCA.Button.FrameSetsDeleteOpenPrompt:SetScript("OnClick", function()
  local profileSaveText = TOCA.Dropdown.Sets.text:GetText()
  if (profileSaveText == TOCA.Dropdown.Menu[1]) then
    TOCA.Notification("|cffff0000 " .. TOCA.locale.UI.TOTEMSET[6][1] .. ":|r " .. profileSaveText)
  else
    TOCA.Prompt.DeleteSetText:SetText(TOCA.locale.UI.TOTEMSET[4][1] .. ' "' .. profileSaveText .. '" ?')
    TOCA.Prompt.DeleteSet:Show()
    --TOCA.FrameSets:Hide()
    TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[2]]:SetAlpha(0.50)
  end
end)
TOCA.Button.FrameSetsDeleteOpenPromptText = TOCA.Button.FrameSetsDeleteOpenPrompt:CreateFontString(nil, "ARTWORK")
TOCA.Button.FrameSetsDeleteOpenPromptText:SetFont(TOCA.Global.font, 11)
TOCA.Button.FrameSetsDeleteOpenPromptText:SetPoint("CENTER", 0, 0)
TOCA.Button.FrameSetsDeleteOpenPromptText:SetText(TOCA.locale.UI.BUTTON[3])

--PROMPT BO
TOCA.Prompt.DeleteSet = CreateFrame("Frame", TOCA.Prompt.DeleteSet, UIParent, "BackdropTemplate")
TOCA.Prompt.DeleteSet:SetWidth(340)
TOCA.Prompt.DeleteSet:SetHeight(100)
TOCA.Prompt.DeleteSet:SetPoint("CENTER", 0, 50)
TOCA.Prompt.DeleteSet:SetBackdrop(TOCA.Backdrop.General)
TOCA.Prompt.DeleteSet:SetBackdropColor(0, 0, 0, 1)
TOCA.Prompt.DeleteSet:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Prompt.DeleteSet:SetFrameStrata("TOOLTIP")
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
    TOCA.Notification("|cffff0000 Unable to remove profile:|r " .. profileSaveText)
  else
    if (TOCADB[TOCA.player.combine]["PROFILES"][profileSaveText]) then
      TOCADB[TOCA.player.combine]["PROFILES"][profileSaveText] = nil
      TOCA.UpdateDDMenu(TOCA.Dropdown.Sets)
      TOCA.UpdateDDMenu(TOCA.Dropdown.Main)
      TOCA.Notification("Totem Set Deleted: |cffffff00" .. profileSaveText)
      TOCA.SetDDMenu(TOCA.Dropdown.Main, TOCA.Dropdown.Menu[1])
      TOCA.FrameSetsProfile:SetText("")
      TOCA.Prompt.DeleteSet:Hide()
      TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[2]]:SetAlpha(1)
    end
  end
  TOCA.CloseAllMenus()
end)
TOCA.Button.FrameSetsDeleteText = TOCA.Button.FrameSetsDelete:CreateFontString(nil, "ARTWORK")
TOCA.Button.FrameSetsDeleteText:SetFont(TOCA.Global.font, 11)
TOCA.Button.FrameSetsDeleteText:SetPoint("CENTER", 0, 0)
TOCA.Button.FrameSetsDeleteText:SetText(TOCA.locale.UI.BUTTON[4])

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
  TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[2]]:SetAlpha(1)
end)
TOCA.Button.FrameSetsCancelText = TOCA.Button.FrameSetsCancel:CreateFontString(nil, "ARTWORK")
TOCA.Button.FrameSetsCancelText:SetFont(TOCA.Global.font, 11)
TOCA.Button.FrameSetsCancelText:SetPoint("CENTER", 0, 0)
TOCA.Button.FrameSetsCancelText:SetText(TOCA.locale.UI.BUTTON[5])
--PROMPT EO

TOCA.FrameSetsSlot={}
TOCA.FrameSetsTotem={}
TOCA.FrameSetsSlotSelect={}
TOCA.FrameSetsSlotSelectMenu={}
TOCA.FrameSetsSlotSelectTotem={}
TOCA.SlotSetsPosX = {
  39,
  78,
  117,
  156,
}
local totemNum = 0
for totemCat,v in pairsByKeys(TOCA.totems) do
  totemNum = totemNum+1
  TOCA.FrameSetsSlot[totemCat]={}
  TOCA.FrameSetsSlot[totemCat]= CreateFrame("Button", nil, TOCA.FrameSets, "BackdropTemplate")
  TOCA.FrameSetsSlot[totemCat]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
  TOCA.FrameSetsSlot[totemCat]:SetPoint("TOPLEFT", -60+TOCA.SlotSetsPosX[totemNum], -70)
  TOCA.FrameSetsSlot[totemCat]:SetBackdrop(TOCA.Backdrop.General)
	TOCA.FrameSetsSlot[totemCat]:SetBackdropColor(0, 0, 0, 1)
  TOCA.FrameSetsSlotSelect[totemCat]= CreateFrame("Button", nil, TOCA.FrameSetsSlot[totemCat], "BackdropTemplate")
  TOCA.FrameSetsSlotSelect[totemCat]:SetSize(TOCA.Slot_w, 15)
  TOCA.FrameSetsSlotSelect[totemCat]:SetPoint("CENTER", 0, -21)
  TOCA.FrameSetsSlotSelect[totemCat]:SetBackdrop(TOCA.Backdrop.General)
	TOCA.FrameSetsSlotSelect[totemCat]:SetBackdropColor(0, 0, 0, 1)
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
  --TOCA.FrameSetsSlotSelectMenu[totemCat]:SetSize(40, (totemCategoryCount*40)+30)
  TOCA.FrameSetsSlotSelectMenu[totemCat]:SetSize(40, totemCategoryCount*36.2)
  TOCA.FrameSetsSlotSelectMenu[totemCat]:SetPoint("TOPLEFT", -2, -10)
  TOCA.FrameSetsSlotSelectMenu[totemCat]:SetBackdrop(TOCA.Backdrop.General)
	TOCA.FrameSetsSlotSelectMenu[totemCat]:SetBackdropColor(0, 0, 0, 1)
  TOCA.FrameSetsSlotSelectMenu[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.FrameSetsSlotSelectMenu[totemCat]:SetFrameLevel(200)
  TOCA.FrameSetsSlotSelectMenu[totemCat]:SetFrameStrata("DIALOG")
  TOCA.FrameSetsSlotSelectMenu[totemCat]:Hide()

  local totemSpellCount={}
  totemSpellCount[totemCat] = 0
  for i,totemSpell in pairs(TOCA.totems[totemCat]) do
    --TOCA.Notification(totemCat .. i .. " " .. totemSpell[1], true)
    totemSpellCount[totemCat] = totemSpellCount[totemCat]+TOCA.Slot_w
    TOCA.FrameSetsSlotSelectTotem[totemCat]={}
    TOCA.FrameSetsSlotSelectTotem[totemCat][i]= CreateFrame("Button", nil, TOCA.FrameSetsSlotSelectMenu[totemCat], "BackdropTemplate")
    TOCA.FrameSetsSlotSelectTotem[totemCat][i]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
    TOCA.FrameSetsSlotSelectTotem[totemCat][i]:SetPoint("TOPLEFT", 2.5, -totemSpellCount[totemCat]+30)
    TOCA.FrameSetsSlotSelectTotem[totemCat][i]:SetFrameLevel(300)
    TOCA.FrameSetsSlotSelectTotem[totemCat][i]:SetBackdrop(TOCA.SetIcon(totemSpell[2]))
    TOCA.FrameSetsSlotSelectTotem[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0.6)
    TOCA.FrameSetsSlotSelectTotem[totemCat][i]:SetScript("OnEnter", function(self)
      TOCA.TooltipDisplay(self, totemSpell[1])
      self:SetBackdropBorderColor(1, 1, 0.8, 1)
    end)
    TOCA.FrameSetsSlotSelectTotem[totemCat][i]:SetScript("OnLeave", function(self)
      self:SetBackdropBorderColor(1, 1, 1, 0.6)
    end)
    TOCA.FrameSetsSlotSelectTotem[totemCat][i]:SetScript("OnClick", function()
      --TOCA.Notification(totemCat .. " ".. i .. " " .. totemSpell[1], true)
      if (totemCat == "AIR") then
        TOCA.cache[1] = totemSpell[1]
      end
      if (totemCat == "EARTH") then
        TOCA.cache[2] = totemSpell[1]
      end
      if (totemCat == "FIRE") then
        TOCA.cache[3] = totemSpell[1]
      end
      if (totemCat == "WATER") then
        TOCA.cache[4] = totemSpell[1]
      end
      TOCA.FrameSetsSlot[totemCat]:SetBackdrop(TOCA.SetIcon(totemSpell[2]))
      TOCA.CloseAllMenus()
    end)
    TOCA.FrameSetsSlotDisabled[totemCat][i]= CreateFrame("Button", nil, TOCA.FrameSetsSlotSelectTotem[totemCat][i], "BackdropTemplate")
    TOCA.FrameSetsSlotDisabled[totemCat][i]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
    TOCA.FrameSetsSlotDisabled[totemCat][i]:SetPoint("CENTER", 0, 0)
    TOCA.FrameSetsSlotDisabled[totemCat][i]:SetBackdrop(TOCA.Backdrop.General)
    TOCA.FrameSetsSlotDisabled[totemCat][i]:SetBackdropColor(0, 0, 0, 1)
  end

  TOCA.FrameSetsSlot[totemCat]:SetBackdropColor(0, 0, 0, 0.8)
  TOCA.FrameSetsSlot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.FrameSetsSlot[totemCat]:SetScript("OnEnter", function(self)
    if (totemCat == "AIR") then
      TOCA.TooltipDisplay(self, TOCA.cache[1])
    end
    if (totemCat == "EARTH") then
      TOCA.TooltipDisplay(self, TOCA.cache[2])
    end
    if (totemCat == "FIRE") then
      TOCA.TooltipDisplay(self, TOCA.cache[3])
    end
    if (totemCat == "WATER") then
      TOCA.TooltipDisplay(self, TOCA.cache[4])
    end
    self:SetBackdropBorderColor(1, 1, 0.8, 1)
  end)
  TOCA.FrameSetsSlot[totemCat]:SetScript("OnLeave", function(self)
    self:SetBackdropBorderColor(1, 1, 1, 0.6)
  end)
end

TOCA.FrameSetsProfileTitle = TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[2]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameSetsProfileTitle:SetFont(TOCA.Global.font, 12)
TOCA.FrameSetsProfileTitle:SetPoint("TOPLEFT", 30, -123)
TOCA.FrameSetsProfileTitle:SetText(TOCA.locale.UI.TOTEMSET[2][1])
TOCA.FrameSetsProfileTitle:SetTextColor(1, 1, 0.5, 1)

TOCA.FrameSetsProfile = CreateFrame("EditBox", nil, TOCA.FrameSets, "BackdropTemplate")
TOCA.FrameSetsProfile:SetWidth(150)
TOCA.FrameSetsProfile:SetHeight(24)
TOCA.FrameSetsProfile:SetFontObject(GameFontWhite)
TOCA.FrameSetsProfile:SetBackdrop({
  bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
  insets  = {left=-2, right=6, top=2, bottom=2},
})
TOCA.FrameSetsProfile:SetBackdropColor(0, 0, 0, 1)
TOCA.FrameSetsProfile:SetPoint("TOPLEFT", -15, -140)
TOCA.FrameSetsProfile:ClearFocus(self)
TOCA.FrameSetsProfile:SetAutoFocus(false)
TOCA.FrameSetsProfile:SetMaxLetters(25)
TOCA.FrameSetsProfile.border = CreateFrame("Frame", nil, TOCA.FrameSetsProfile, "BackdropTemplate")
TOCA.FrameSetsProfile.border:SetWidth(150)
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

TOCA.DropdownTitle = TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[2]]:CreateFontString(nil, "ARTWORK")
TOCA.DropdownTitle:SetFont(TOCA.Global.font, 12)
TOCA.DropdownTitle:SetPoint("TOPLEFT", 30, -20)
TOCA.DropdownTitle:SetText(TOCA.locale.UI.TOTEMSET[1][1])
TOCA.DropdownTitle:SetTextColor(1, 1, 0.5, 1)

TOCA.Dropdown.Sets = CreateFrame("Frame", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[2]], "UIDropDownMenuTemplate")
TOCA.Dropdown.Sets:SetPoint("TOPLEFT", 10, -35)
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
