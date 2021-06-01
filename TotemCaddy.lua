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
--[==[
TOCA.FrameMain:SetScript("OnLeave", function()
  TOCA.CloseAllMenus()
end)
]==]--

TOCA.Main = CreateFrame("Frame")
TOCA.Main:RegisterEvent("ADDON_LOADED")
TOCA.Main:RegisterEvent("PLAYER_LOGIN")
TOCA.Main:RegisterEvent("UNIT_SPELLCAST_START")
TOCA.Main:RegisterEvent("UNIT_SPELLCAST_STOP")
TOCA.Main:RegisterEvent("UNIT_MAXPOWER")
TOCA.Main:RegisterEvent("UNIT_POWER_FREQUENT")
TOCA.Main:RegisterEvent("UNIT_SPELLCAST_SENT")
TOCA.Main:SetScript("OnEvent", function(self, event, prefix)
  if ((event == "ADDON_LOADED") and (prefix == "TotemCaddy")) then
    print(TOCA.Global.title .. " v" .. TOCA.Global.version .. " Initializing by " .. TOCA.Global.author .. ". Type /" .. TOCA.Global.command .. " for commands.")
    TOCA.Init()
  end

  if (event == "PLAYER_LOGIN") then
    TOCA.Init()
  end
  if ((event == "UNIT_SPELLCAST_START") or
  (event == "UNIT_SPELLCAST_STOP") or
  (event == "UNIT_AURA") or
  (event == "UNIT_MAXPOWER") or
  (event == "UNIT_POWER_FREQUENT")) then
    --print(event)
    TOCA.TotemDetails()
  end
  --this needs to be handled on a different event
  if (event == "UNIT_SPELLCAST_SENT") then
    TOCA.TotemDetails()
  end
end)

TOCA.Slot={}
TOCA.Totem={}
TOCA.TotemFlash={}
TOCA.Slot_w=35
TOCA.Slot_h=35
TOCA.Slot_x=-TOCA.Slot_w/2
for totemCat,v in pairsByKeys(TOCA.totems) do
  TOCA.Slot_x = TOCA.Slot_x +36
  TOCA.Slot[totemCat]={}
  TOCA.Slot[totemCat]= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
  TOCA.Slot[totemCat]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
  TOCA.Slot[totemCat]:SetPoint("TOPLEFT", 10 + TOCA.Slot_x, -35)
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
    TOCA.SlotSelectMenu[totemCat]:Show()
  end)
  TOCA.SlotSelect[totemCat].icon = TOCA.SlotSelect[totemCat]:CreateTexture(nil, "ARTWORK")
  TOCA.SlotSelect[totemCat].icon:SetSize(18, 14)
  TOCA.SlotSelect[totemCat].icon:SetPoint("CENTER", 1, 2)
  TOCA.SlotSelect[totemCat].icon:SetTexture("Interface/Buttons/Arrow-Up-Up")

  local totemCategoryCount = getn(TOCA.totems[totemCat])
  TOCA.SlotSelectMenu[totemCat]= CreateFrame("Frame", nil, TOCA.SlotSelect[totemCat], "BackdropTemplate")
  TOCA.SlotSelectMenu[totemCat]:SetSize(40, (totemCategoryCount*40)+30)
  TOCA.SlotSelectMenu[totemCat]:SetPoint("BOTTOMLEFT", -3, 10)
  TOCA.SlotSelectMenu[totemCat]:SetBackdrop(TOCA.Backdrop.General)
  TOCA.SlotSelectMenu[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.SlotSelectMenu[totemCat]:SetFrameLevel(200)
  TOCA.SlotSelectMenu[totemCat]:SetFrameStrata("DIALOG")
  TOCA.SlotSelectMenu[totemCat]:Hide()

  TOCA.SlotSelectTotemCancel= CreateFrame("Button", nil, TOCA.SlotSelectMenu[totemCat], "BackdropTemplate")
  TOCA.SlotSelectTotemCancel:SetSize(35, 35)
  TOCA.SlotSelectTotemCancel:SetPoint("TOPLEFT", 2.5, -5)
  TOCA.SlotSelectTotemCancel:SetBackdrop({
    bgFile  = "interface/buttons/UI-GroupLoot-Pass-Down",
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  })
  TOCA.SlotSelectTotemCancel:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.SlotSelectTotemCancel:SetScript("OnEnter", function(self)
    self:SetBackdropBorderColor(1, 1, 0.8, 1)
  end)
  TOCA.SlotSelectTotemCancel:SetScript("OnLeave", function(self)
    self:SetBackdropBorderColor(1, 1, 1, 0.6)
  end)
  TOCA.SlotSelectTotemCancel:SetScript("OnClick", function()
    TOCA.CloseAllMenus()
  end)

  local totemSpellCount={}
  totemSpellCount[totemCat] = 0
  for i,totemSpell in pairs(TOCA.totems[totemCat]) do
    --print(totemCat .. i .. " " .. totemSpell[1])
    totemSpellCount[totemCat] = totemSpellCount[totemCat]+35
    TOCA.SlotSelectTotem[totemCat]={}
    TOCA.SlotSelectTotem[totemCat][i]= CreateFrame("Button", nil, TOCA.SlotSelectMenu[totemCat], "BackdropTemplate")
    TOCA.SlotSelectTotem[totemCat][i]:SetSize(35, 35)
    TOCA.SlotSelectTotem[totemCat][i]:SetPoint("TOPLEFT", 2.5, -totemSpellCount[totemCat]-5)
    TOCA.SlotSelectTotem[totemCat][i]:SetBackdrop({
      bgFile  = "interface/icons/" .. totemSpell[2],
      edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
      edgeSize= 12,
      insets  = {left=2, right=2, top=2, bottom=2},
    })
    TOCA.SlotSelectTotem[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0.6)
    TOCA.SlotSelectTotem[totemCat][i]:SetScript("OnEnter", function(self)
      TOCA.tooltip(self, totemSpell[1], "show")
      self:SetBackdropBorderColor(1, 1, 0.8, 1)
    end)
    TOCA.SlotSelectTotem[totemCat][i]:SetScript("OnLeave", function(self)
      TOCA.tooltip(self, totemSpell[1], "hide")
      self:SetBackdropBorderColor(1, 1, 1, 0.6)
    end)
    TOCA.SlotSelectTotem[totemCat][i]:SetScript("OnClick", function()
      print(totemCat .. " ".. i .. " " .. totemSpell[1])
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
      TOCA.Slot[totemCat]:SetBackdrop({
        bgFile  = "interface/icons/" .. totemSpell[2],
        edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
        edgeSize= 12,
        insets  = {left=2, right=2, top=2, bottom=2},
      })
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
      --TOCA.Totem[totemCat]:SetAttribute("spell", totemSpell[1]) -- default
      TOCA.CloseAllMenus()
    end)
  end
  --TOCA.SlotSelect[totemCat]:SetBackdropColor(0, 0, 0, 0.8)
  --TOCA.SlotSelect[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
end

TOCA.Call_w=40
TOCA.Call_h=40
TOCA.Call= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
TOCA.Call:SetSize(TOCA.Call_w, TOCA.Call_h)
TOCA.Call:SetPoint("CENTER", 0, 48)
TOCA.Call:SetBackdrop({
  bgFile  = "Interface/ICONS/spell_unused",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
})
TOCA.CallFlash = TOCA.Call:CreateTexture(nil, "ARTWORK")
TOCA.CallFlash:SetSize(80, 80)
TOCA.CallFlash:SetPoint("CENTER", 0, 0)
TOCA.CallFlash:SetTexture("Interface/Buttons/CheckButtonGlow")
TOCA.CallFlash:Hide()
TOCA.Call:SetBackdropBorderColor(1, 1, 1, 0.5)
TOCA.Call.ECL = TOCA.Call:CreateTexture(nil, "ARTWORK")
TOCA.Call.ECL:SetSize(40, 40)
TOCA.Call.ECL:SetPoint("CENTER", -30, 20)
TOCA.Call.ECL:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Dwarf")
TOCA.Call.ECR = TOCA.Call:CreateTexture(nil, "ARTWORK")
TOCA.Call.ECR:SetSize(TOCA.Call_w, TOCA.Call_h)
TOCA.Call.ECR:SetPoint("CENTER", 30, 20)
TOCA.Call.ECR:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Dwarf")
TOCA.Call.ECR:SetTexCoord(1, 0, 0, 1)

TOCA.CallAtt= CreateFrame("Button", nil, TOCA.Call, "SecureActionButtonTemplate");
TOCA.CallAtt:SetSize(TOCA.Call_w, TOCA.Call_h)
TOCA.CallAtt:SetPoint("CENTER", 0, 0)
TOCA.CallAtt:SetAttribute("type", "spell")
TOCA.CallAtt:SetAttribute("spell", "Totemic Call")
TOCA.CallAtt:SetScript("OnEnter", function(self)
  TOCA.Call:SetBackdropBorderColor(1, 1, 1, 1)
end)
TOCA.CallAtt:SetScript("OnLeave", function(self)
  TOCA.Call:SetBackdropBorderColor(1, 1, 1, 0.6)
end)

TOCA.FrameMainExt = CreateFrame("Frame", TOCA.FrameMaiExt, TOCA.FrameMain, "BackdropTemplate")
TOCA.FrameMainExt:SetWidth(120)
TOCA.FrameMainExt:SetHeight(TOCA.Global.height)
TOCA.FrameMainExt:SetPoint("CENTER", TOCA.Global.width-50, 0)
TOCA.FrameMainExt:SetBackdrop(TOCA.Backdrop.General)
TOCA.FrameMainExt:SetBackdropColor(0, 0, 0, 0.8)
TOCA.FrameMainExt:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameMainExt:Hide()

TOCA.Button.OpenFrameMainExt= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
TOCA.Button.OpenFrameMainExt:SetSize(18, 30)
TOCA.Button.OpenFrameMainExt:SetPoint("CENTER", TOCA.Global.width-116, 0)
TOCA.Button.OpenFrameMainExt:SetBackdrop(TOCA.Backdrop.General)
TOCA.Button.OpenFrameMainExt:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.OpenFrameMainExt.icon = TOCA.Button.OpenFrameMainExt:CreateTexture(nil, "ARTWORK")
TOCA.Button.OpenFrameMainExt.icon:SetSize(18, 18)
TOCA.Button.OpenFrameMainExt.icon:SetPoint("CENTER", 5, -2)
TOCA.Button.OpenFrameMainExt.icon:SetTexture("Interface/CHATFRAME/UI-InChatFriendsArrow")
TOCA.Button.OpenFrameMainExt:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
  TOCA.FrameMainExt:Show()
end)
TOCA.Button.OpenFrameMainExt:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 1)
end)
TOCA.Button.OpenFrameMainExt:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)

TOCA.Button.OpenSets={}
TOCA.Button.OpenSets= CreateFrame("Button", nil, TOCA.FrameMainExt, "BackdropTemplate")
TOCA.Button.OpenSets:SetSize(80, 24)
TOCA.Button.OpenSets:SetPoint("CENTER", 0, 15)
TOCA.Button.OpenSets:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.OpenSets:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.OpenSets:SetBackdropColor(0, 0.7, 0, 1)
TOCA.Button.OpenSets.text = TOCA.Button.OpenSets:CreateFontString(nil, "ARTWORK")
TOCA.Button.OpenSets.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Button.OpenSets.text:SetPoint("CENTER", 0, 0)
TOCA.Button.OpenSets.text:SetText("Build Set")
TOCA.Button.OpenSets:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
  TOCA.FrameSets:Show()
end)
TOCA.Button.OpenSets:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 1)
end)
TOCA.Button.OpenSets:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)

TOCA.Button.CloseFrameMainExt={}
TOCA.Button.CloseFrameMainExt= CreateFrame("Button", nil, TOCA.FrameMainExt, "BackdropTemplate")
TOCA.Button.CloseFrameMainExt:SetSize(80, 24)
TOCA.Button.CloseFrameMainExt:SetPoint("CENTER", 0, -15)
TOCA.Button.CloseFrameMainExt:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.CloseFrameMainExt:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.CloseFrameMainExt:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.CloseFrameMainExt.text = TOCA.Button.CloseFrameMainExt:CreateFontString(nil, "ARTWORK")
TOCA.Button.CloseFrameMainExt.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Button.CloseFrameMainExt.text:SetPoint("CENTER", 0, 0)
TOCA.Button.CloseFrameMainExt.text:SetText("Cancel")
TOCA.Button.CloseFrameMainExt:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
end)
TOCA.Button.CloseFrameMainExt:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 1)
end)
TOCA.Button.CloseFrameMainExt:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)

TOCA.Button.MainClose= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
TOCA.Button.MainClose:SetSize(18, 18)
TOCA.Button.MainClose:SetPoint("TOPRIGHT", -2, -2)
TOCA.Button.MainClose:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.MainClose:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.MainClose:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.MainClose.icon = TOCA.Button.MainClose:CreateTexture(nil, "ARTWORK")
TOCA.Button.MainClose.icon:SetSize(12, 12)
TOCA.Button.MainClose.icon:SetPoint("CENTER", 0, 0)
TOCA.Button.MainClose.icon:SetTexture("Interface/Buttons/UI-StopButton")
TOCA.Button.MainClose:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.Button.MainClose:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.Button.MainClose:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
  TOCA.FrameMain:Hide()
  TOCADB[TOCA.player.combine]["DISABLED"] = "YES"
  print(TOCA.Global.title .. " closed. Type '"..TCCMD.." show' to reopen.")
end)

TOCA.Dropdown = {}
TOCA.Dropdown.Menu = {"Default"}
TOCA.Dropdown.Main = CreateFrame("Frame", nil, TOCA.FrameMain, "UIDropDownMenuTemplate")
TOCA.Dropdown.Main:SetPoint("CENTER", -4, -35)
TOCA.Dropdown.Main.displayMode = "MENU"
TOCA.Dropdown.Main.text = TOCA.Dropdown.Main:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.Main.text:SetFont(TOCA.Global.font, 11)
TOCA.Dropdown.Main.text:SetPoint("TOPLEFT", TOCA.Dropdown.Main, "TOPLEFT", 25, -8)
TOCA.Dropdown.Main.text:SetText(TOCA.Dropdown.Menu[1])
TOCA.Dropdown.Main.onClick = function(self, checked)
  TOCA.SetDDMenu(TOCA.Dropdown.Main, self.value)
end
UIDropDownMenu_SetWidth(TOCA.Dropdown.Main, TOCA.Global.width-80)
