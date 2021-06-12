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

TOCA.FrameMain = CreateFrame("Frame", TOCA.FrameMain, UIParent, "BackdropTemplate")
TOCA.FrameMain:SetWidth(TOCA.Global.width)
TOCA.FrameMain:SetHeight(TOCA.Global.height)
TOCA.FrameMain:SetPoint("CENTER", 0, -140)
--[==[
TOCA.FrameMain:SetBackdrop(TOCA.Backdrop.Main)
TOCA.FrameMain:SetBackdropColor(0, 0, 0, 0.8)
TOCA.FrameMain:SetBackdropBorderColor(1, 1, 1, 0.6)
]==]--
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

TOCA.FrameMain.Background = CreateFrame("Frame", TOCA.FrameMain.Background, TOCA.FrameMain, "BackdropTemplate", -5)
TOCA.FrameMain.Background:SetWidth(TOCA.Global.width)
TOCA.FrameMain.Background:SetHeight(TOCA.Global.height)
TOCA.FrameMain.Background:SetPoint("CENTER", -1, 0)
TOCA.FrameMain.Background:SetBackdrop(TOCA.Backdrop.Main)
TOCA.FrameMain.Background:SetBackdropColor(0, 0, 0, 0.8)
TOCA.FrameMain.Background:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameMain.Background:SetFrameStrata("BACKGROUND")

TOCA.Main = CreateFrame("Frame")
TOCA.Main:RegisterEvent("ADDON_LOADED")
TOCA.Main:RegisterEvent("PLAYER_LOGIN")
TOCA.Main:RegisterEvent("PLAYER_TOTEM_UPDATE")
TOCA.Main:RegisterEvent("UNIT_SPELLCAST_START")
TOCA.Main:RegisterEvent("UNIT_SPELLCAST_STOP")
TOCA.Main:RegisterEvent("UNIT_AURA")
TOCA.Main:RegisterEvent("UNIT_MAXPOWER")
TOCA.Main:RegisterEvent("UNIT_POWER_FREQUENT")
TOCA.Main:RegisterEvent("UNIT_SPELLCAST_SENT")
TOCA.Main:RegisterEvent("PLAYER_REGEN_ENABLED")
TOCA.Main:RegisterEvent("PLAYER_REGEN_DISABLED")
TOCA.Main:SetScript("OnEvent", function(self, event, prefix)
  if ((event == "ADDON_LOADED") and (prefix == "TotemCaddy")) then
    print(TOCA.Global.title .. " v" .. TOCA.Global.version .. " Initializing by " .. TOCA.Global.author .. ". Type /" .. TOCA.Global.command .. " for commands.")
    TOCA.Init()
  end

  if ((event == "UNIT_SPELLCAST_START") or
  (event == "UNIT_SPELLCAST_STOP") or
  (event == "UNIT_POWER_FREQUENT")) then
    --print(event)
    TOCA.TotemBarUpdate()
  end
  --this needs to be handled on a different event
  if (event == "UNIT_SPELLCAST_SENT") then
    TOCA.TotemBarUpdate()
  end
  if (event == "UNIT_MAXPOWER") then
    TOCA.TotemBarUpdate()
  end
  if (event == "UNIT_AURA") then --more accurate on usable spells
    TOCA.TotemBarUpdate()
  end
  if (event == "PLAYER_TOTEM_UPDATE") then
    TOCA.TotemBarUpdate()
  end

  --[==[
  if (event== "PLAYER_REGEN_DISABLED") then --entered combat
  end
  if (event == "PLAYER_REGEN_ENABLED") then --left combat
  end
  ]==]--
  --print(event)
end)


TOCA.Button.TotemicCall_w=40
TOCA.Button.TotemicCall_h=40
TOCA.Button.TotemicCall= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
TOCA.Button.TotemicCall:SetSize(TOCA.Button.TotemicCall_w, TOCA.Button.TotemicCall_h)
TOCA.Button.TotemicCall:SetPoint("CENTER", 0, 40)
TOCA.Button.TotemicCall:SetBackdrop({
  bgFile  = "Interface/ICONS/spell_unused",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
})
TOCA.Button.TotemicCall:SetFrameLevel(10)
TOCA.Button.TotemicCall.flash = TOCA.Button.TotemicCall:CreateTexture(nil, "ARTWORK")
TOCA.Button.TotemicCall.flash:SetSize(80, 80)
TOCA.Button.TotemicCall.flash:SetPoint("CENTER", 0, 0)
TOCA.Button.TotemicCall.flash:SetTexture("Interface/Buttons/CheckButtonGlow")
TOCA.Button.TotemicCall.flash:Hide()
TOCA.Button.TotemicCall.highlight= TOCA.Button.TotemicCall:CreateTexture(nil, "ARTWORK", TOCA.Button.TotemicCall, 0)
TOCA.Button.TotemicCall.highlight:SetSize(TOCA.Button.TotemicCall_w, TOCA.Button.TotemicCall_h)
TOCA.Button.TotemicCall.highlight:SetPoint("CENTER", 0, 0)
TOCA.Button.TotemicCall.highlight:SetTexture("Interface/Buttons/ButtonHilight-Square")
TOCA.Button.TotemicCall.highlight:SetBlendMode("ADD")
TOCA.Button.TotemicCall.highlight:Hide()
TOCA.Button.TotemicCall:SetBackdropBorderColor(1, 1, 1, 0.5)
TOCA.Button.TotemicCall.ECL = TOCA.Button.TotemicCall:CreateTexture(nil, "ARTWORK")
TOCA.Button.TotemicCall.ECL:SetSize(40, 40)
TOCA.Button.TotemicCall.ECL:SetPoint("CENTER", -30, 20)
TOCA.Button.TotemicCall.ECL:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Dwarf")
TOCA.Button.TotemicCall.ECR = TOCA.Button.TotemicCall:CreateTexture(nil, "ARTWORK")
TOCA.Button.TotemicCall.ECR:SetSize(TOCA.Button.TotemicCall_w, TOCA.Button.TotemicCall_h)
TOCA.Button.TotemicCall.ECR:SetPoint("CENTER", 30, 20)
TOCA.Button.TotemicCall.ECR:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Dwarf")
TOCA.Button.TotemicCall.ECR:SetTexCoord(1, 0, 0, 1)

TOCA.Button.TotemicCallAtt= CreateFrame("Button", nil, TOCA.Button.TotemicCall, "SecureActionButtonTemplate");
TOCA.Button.TotemicCallAtt:SetSize(TOCA.Button.TotemicCall_w, TOCA.Button.TotemicCall_h)
TOCA.Button.TotemicCallAtt:SetPoint("CENTER", 0, 0)
TOCA.Button.TotemicCallAtt:SetAttribute("type", "spell")
TOCA.Button.TotemicCallAtt:SetAttribute("spell", "Totemic Call")
TOCA.Button.TotemicCallAtt:SetScript("OnEnter", function(self)
  --TOCA.CloseAllMenus() --bug with the totemic call button overlapping
  TOCA.Button.TotemicCall:SetBackdropBorderColor(1, 1, 1, 1)
  TOCA.Button.TotemicCall.highlight:Show()
  TOCA.tooltip("Totemic Call", "", "Returns your totems to the earth, giving you 25% of the mana required to cast each totem destroyed by Totemic Call.")
end)
TOCA.Button.TotemicCallAtt:SetScript("OnLeave", function(self)
  TOCA.Button.TotemicCall:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.Button.TotemicCall.highlight:Hide()
  _GTooltip:Hide()
end)

TOCA.Slot={}
TOCA.Slot.deactive={}
TOCA.Slot.highlight={}
TOCA.Totem={}
TOCA.TotemFlash={}
for totemCat,v in pairsByKeys(TOCA.totems) do
  TOCA.Slot_x = TOCA.Slot_x +36
  TOCA.Slot[totemCat]={}
  TOCA.Slot[totemCat]= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
  TOCA.Slot[totemCat]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
  TOCA.Slot[totemCat]:SetPoint("TOPLEFT", -15+TOCA.Slot_x, -35)
  TOCA.Slot[totemCat]:SetBackdrop(TOCA.Backdrop.General)
  TOCA.Slot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.Slot.deactive[totemCat]= CreateFrame("Frame", nil, TOCA.Slot[totemCat], "BackdropTemplate")
  TOCA.Slot.deactive[totemCat]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
  TOCA.Slot.deactive[totemCat]:SetPoint("CENTER", 0, 0)
  TOCA.Slot.deactive[totemCat]:SetBackdrop(TOCA.Backdrop.General)
  TOCA.Slot.deactive[totemCat]:SetBackdropBorderColor(1, 1, 1, 0)
  TOCA.Slot.deactive[totemCat]:Hide()
  TOCA.Slot.highlight[totemCat]= TOCA.Slot[totemCat]:CreateTexture(nil, "ARTWORK", TOCA.Slot[totemCat], 0)
  TOCA.Slot.highlight[totemCat]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
  TOCA.Slot.highlight[totemCat]:SetPoint("CENTER", 0, 0)
  TOCA.Slot.highlight[totemCat]:SetTexture("Interface/Buttons/ButtonHilight-Square")
  TOCA.Slot.highlight[totemCat]:SetBlendMode("ADD")
  TOCA.Slot.highlight[totemCat]:Hide()
  TOCA.Slot.Timer = TOCA.Slot[totemCat]:CreateFontString(nil, "ARTWORK")
  TOCA.Slot.Timer:SetFont(TOCA.Global.font, 12, "OUTLINE")
  TOCA.Slot.Timer:SetPoint("CENTER", 0, -8)
  TOCA.Slot.Timer:SetText("1")
  TOCA.Slot.Timer:Hide()
  TOCA.Totem[totemCat] = CreateFrame("Button", nil, TOCA.Slot[totemCat], "SecureActionButtonTemplate");
  TOCA.Totem[totemCat]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
  TOCA.Totem[totemCat]:SetPoint("CENTER", 0, 0)
  TOCA.Totem[totemCat]:SetAttribute("type", "spell")
  local thisTotemSpell = ""
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
    TOCA.CloseAllMenus()
    TOCA.Slot[totemCat]:SetBackdropBorderColor(1, 1, 1, 1)
    TOCA.Slot.highlight[totemCat]:Show()
    if (totemCat == "AIR") then
      TOCA.tooltip(TOCASlotAIR, totemCat, TOCA.totems[totemCat][multiKeyFromValue(TOCA.totems[totemCat], TOCASlotAIR, 1)][3])
    end
    if (totemCat == "EARTH") then
      TOCA.tooltip(TOCASlotEARTH, totemCat, TOCA.totems[totemCat][multiKeyFromValue(TOCA.totems[totemCat], TOCASlotEARTH, 1)][3])
    end
    if (totemCat == "FIRE") then
      TOCA.tooltip(TOCASlotFIRE, totemCat, TOCA.totems[totemCat][multiKeyFromValue(TOCA.totems[totemCat], TOCASlotFIRE, 1)][3])
    end
    if (totemCat == "WATER") then
      TOCA.tooltip(TOCASlotWATER, totemCat, TOCA.totems[totemCat][multiKeyFromValue(TOCA.totems[totemCat], TOCASlotWATER, 1)][3])
    end
  end)
  TOCA.Totem[totemCat]:SetScript("OnLeave", function()
    TOCA.CloseAllMenus()
    TOCA.Slot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
    TOCA.Slot.highlight[totemCat]:Hide()
  end)
  TOCA.TotemFlash[totemCat] = TOCA.Totem[totemCat]:CreateTexture(nil, "ARTWORK")
  TOCA.TotemFlash[totemCat]:SetSize(60, 60)
  TOCA.TotemFlash[totemCat]:SetPoint("CENTER", 0, 0)
  TOCA.TotemFlash[totemCat]:SetTexture("Interface/Buttons/CheckButtonGlow")
  TOCA.TotemFlash[totemCat]:Hide()
end

TOCA.SlotSelect={}
TOCA.SlotSelectTotem={}
TOCA.SlotSelectMenu={}
TOCA.SlotSelect_x = 0
for totemCat,v in pairsByKeys(TOCA.totems) do
  TOCA.SlotSelect[totemCat]= CreateFrame("Button", nil, TOCA.Slot[totemCat], "BackdropTemplate")
  TOCA.SlotSelect[totemCat]:SetSize(35, 15)
  TOCA.SlotSelect[totemCat]:SetPoint("CENTER", 0, 20)
  TOCA.SlotSelect[totemCat]:SetBackdrop(TOCA.Backdrop.General)
  TOCA.SlotSelect[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.SlotSelect[totemCat]:SetFrameStrata("DIALOG")
  TOCA.SlotSelect[totemCat]:SetScript("OnEnter", function(self)
    self:SetBackdropBorderColor(1, 1, 0.8, 1)
  end)
  TOCA.SlotSelect[totemCat]:SetScript("OnLeave", function(self)
    self:SetBackdropBorderColor(1, 1, 1, 0.6)
  end)
  TOCA.SlotSelect[totemCat]:SetScript("OnClick", function()
    TOCA.CloseAllMenus()
    if (TOCA.MenuIsOpenMain == 0) then
      TOCA.EnableKnownTotems()
      TOCA.SlotSelectMenu[totemCat]:Show()
      TOCA.MenuIsOpenMain = 1
    else
      TOCA.MenuIsOpenMain = 0
    end
  end)
  TOCA.SlotSelect[totemCat].icon = TOCA.SlotSelect[totemCat]:CreateTexture(nil, "ARTWORK")
  TOCA.SlotSelect[totemCat].icon:SetSize(18, 14)
  TOCA.SlotSelect[totemCat].icon:SetPoint("CENTER", 1, 2)
  TOCA.SlotSelect[totemCat].icon:SetTexture("Interface/Buttons/Arrow-Up-Up")

  local totemCategoryCount = getn(TOCA.totems[totemCat])
  TOCA.SlotSelectMenu[totemCat]= CreateFrame("Frame", nil, TOCA.SlotSelect[totemCat], "BackdropTemplate")
  TOCA.SlotSelectMenu[totemCat]:SetSize(40, (totemCategoryCount*38))
  TOCA.SlotSelectMenu[totemCat]:SetPoint("BOTTOMLEFT", -3, 10)
  TOCA.SlotSelectMenu[totemCat]:SetBackdrop(TOCA.Backdrop.General)
  TOCA.SlotSelectMenu[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.SlotSelectMenu[totemCat]:SetFrameStrata("DIALOG")
  TOCA.SlotSelectMenu[totemCat]:SetFrameLevel(400)
  TOCA.SlotSelectMenu[totemCat]:Hide()

  local totemSpellCount={}
  totemSpellCount[totemCat] = 0
  for i,totemSpell in pairs(TOCA.totems[totemCat]) do
    --print(totemCat .. i .. " " .. totemSpell[1])
    totemSpellCount[totemCat] = totemSpellCount[totemCat]+35
    TOCA.SlotSelectTotem[totemCat]={}
    TOCA.SlotSelectTotem[totemCat][i]= CreateFrame("Button", nil, TOCA.SlotSelectMenu[totemCat], "BackdropTemplate")
    TOCA.SlotSelectTotem[totemCat][i]:SetSize(35, 35)
    TOCA.SlotSelectTotem[totemCat][i]:SetPoint("TOPLEFT", 2.5, -totemSpellCount[totemCat]+20)
    TOCA.SlotSelectTotem[totemCat][i]:SetBackdrop({
      bgFile  = "interface/icons/" .. totemSpell[2],
      edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
      edgeSize= 12,
      insets  = {left=2, right=2, top=2, bottom=2},
    })
    TOCA.SlotSelectTotem[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0.6)
    TOCA.SlotSelectTotem[totemCat][i]:SetScript("OnEnter", function(self)
      TOCA.tooltip(totemSpell[1], totemCat, totemSpell[3])
      self:SetBackdropBorderColor(1, 1, 0.8, 1)
    end)
    TOCA.SlotSelectTotem[totemCat][i]:SetScript("OnLeave", function(self)
      _GTooltip:Hide()
      self:SetBackdropBorderColor(1, 1, 1, 0.6)
    end)
    TOCA.SlotSelectTotem[totemCat][i]:SetScript("OnClick", function()
      --print(totemCat .. " ".. i .. " " .. totemSpell[1])
      if (totemCat == "AIR") then
        TOCASlotAIR = totemSpell[1]
        TOCA.Totem[totemCat]:SetAttribute("spell", TOCASlotAIR)
      end
      if (totemCat == "EARTH") then
        TOCASlotEARTH = totemSpell[1]
        TOCA.Totem[totemCat]:SetAttribute("spell", TOCASlotEARTH)
      end
      if (totemCat == "FIRE") then
        TOCASlotFIRE = totemSpell[1]
        TOCA.Totem[totemCat]:SetAttribute("spell", TOCASlotFIRE)
      end
      if (totemCat == "WATER") then
        TOCASlotWATER = totemSpell[1]
        TOCA.Totem[totemCat]:SetAttribute("spell", TOCASlotWATER)
      end
      TOCA.Slot[totemCat]:SetBackdrop({
        bgFile  = "interface/icons/" .. totemSpell[2],
        edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
        edgeSize= 12,
        insets  = {left=2, right=2, top=2, bottom=2},
      })
      --TOCA.Totem[totemCat]:SetAttribute("spell", totemSpell[1]) -- default
      TOCA.CloseAllMenus()
    end)
    TOCA.SlotSelectTotemDisabled[totemCat][i]= CreateFrame("Frame", nil, TOCA.SlotSelectTotem[totemCat][i], "BackdropTemplate", 7)
    TOCA.SlotSelectTotemDisabled[totemCat][i]:SetSize(35, 35)
    TOCA.SlotSelectTotemDisabled[totemCat][i]:SetPoint("CENTER", 0, 0)
    TOCA.SlotSelectTotemDisabled[totemCat][i]:SetBackdrop(TOCA.Backdrop.RGB)
    TOCA.SlotSelectTotemDisabled[totemCat][i]:SetBackdropColor(0, 0, 0, 1)
    TOCA.SlotSelectTotemDisabled[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0)
    TOCA.SlotSelectTotemDisabled[totemCat][i]:SetFrameStrata("TOOLTIP")
  end
end

TOCA.Button.Options= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
TOCA.Button.Options:SetSize(16, 16)
TOCA.Button.Options:SetPoint("TOPRIGHT", -14, 1)
TOCA.Button.Options:SetBackdrop(TOCA.Backdrop.General)
TOCA.Button.Options:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.Options.icon = TOCA.Button.Options:CreateTexture(nil, "ARTWORK")
TOCA.Button.Options.icon:SetSize(12, 12)
TOCA.Button.Options.icon:SetPoint("CENTER", 0, 0)
TOCA.Button.Options.icon:SetTexture("Interface/Buttons/UI-OptionsButton")
TOCA.Button.Options:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 1)
end)
TOCA.Button.Options:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.Button.Options:SetScript("OnClick", function(self)
  TOCA.CloseAllMenus()
  --TOCA.FrameSets:Show()
  TOCA.FrameOptions:Show()
end)

TOCA.Button.CloseMain= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
TOCA.Button.CloseMain:SetSize(16, 16)
TOCA.Button.CloseMain:SetPoint("TOPRIGHT", 0, 1)
TOCA.Button.CloseMain:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.CloseMain:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.CloseMain:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.CloseMain.icon = TOCA.Button.CloseMain:CreateTexture(nil, "ARTWORK")
TOCA.Button.CloseMain.icon:SetSize(12, 12)
TOCA.Button.CloseMain.icon:SetPoint("CENTER", 0, 0)
TOCA.Button.CloseMain.icon:SetTexture("Interface/Buttons/UI-StopButton")
TOCA.Button.CloseMain:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.Button.CloseMain:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.Button.CloseMain:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
  TOCA.FrameMain:Hide()
  TOCADB[TOCA.player.combine]["DISABLED"] = "YES"
  print(TOCA.Global.title .. " closed. Type '"..TCCMD.." show' to reopen.")
end)

TOCA.Button.DropdownMain= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
TOCA.Button.DropdownMain:SetSize(143, 16)
TOCA.Button.DropdownMain:SetPoint("CENTER", 0, -32)
TOCA.Button.DropdownMain:SetBackdrop(TOCA.Backdrop.General)
TOCA.Button.DropdownMain:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.DropdownMain:SetFrameStrata("DIALOG")
TOCA.Button.DropdownMain.icon = TOCA.Button.DropdownMain:CreateTexture(nil, "ARTWORK")
TOCA.Button.DropdownMain.icon:SetSize(26, 18)
TOCA.Button.DropdownMain.icon:SetPoint("CENTER", 0, -3)
TOCA.Button.DropdownMain.icon:SetTexture("Interface/Buttons/Arrow-Down-Down")
TOCA.Button.DropdownMain:SetScript("OnClick", function(self)
  TOCA.CloseAllMenus()
  --TOCA.FrameSets:Show()
  ToggleDropDownMenu(1, nil, TOCA.Dropdown.Main, self, 0, 0)
end)
TOCA.Button.DropdownMain:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 1)
end)
TOCA.Button.DropdownMain:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)

TOCA.Dropdown.Main = CreateFrame("Frame", nil, TOCA.FrameMain, "UIDropDownMenuTemplate")
TOCA.Dropdown.Main:SetPoint("TOPLEFT", 0, -68)
TOCA.Dropdown.Main.displayMode = "MENU"
TOCA.Dropdown.Main.text = TOCA.Dropdown.Main:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.Main.text:SetFont(TOCA.Global.font, 11)
TOCA.Dropdown.Main.text:SetPoint("TOPLEFT", TOCA.Dropdown.Main, "TOPLEFT", 25, -8)
TOCA.Dropdown.Main.text:SetText(TOCA.Dropdown.Menu[1])
TOCA.Dropdown.Main.onClick = function(self, checked)
  TOCA.SetDDMenu(TOCA.Dropdown.Main, self.value)
  TOCA.FrameSetsProfile:SetText(self.value)
end
UIDropDownMenu_SetWidth(TOCA.Dropdown.Main, 102)
TOCA.Dropdown.Main:Hide()
