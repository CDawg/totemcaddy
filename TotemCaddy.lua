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

TOCA.FrameMain = CreateFrame("Frame", TOCA.FrameMain, UIParent, "BackdropTemplate")
TOCA.FrameMain:SetWidth(TOCA._G.width)
TOCA.FrameMain:SetHeight(TOCA._G.height)
TOCA.FrameMain:SetPoint("CENTER", 0, -140)
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

TOCA.FrameMain.Background = CreateFrame("Frame", TOCA.FrameMain.Background, TOCA.FrameMain, "BackdropTemplate", -6)
TOCA.FrameMain.Background:SetWidth(TOCA._G.width)
TOCA.FrameMain.Background:SetHeight(TOCA._G.height)
TOCA.FrameMain.Background:SetPoint("CENTER", 0, 0)
TOCA.FrameMain.Background:SetBackdrop(TOCA.Backdrop.General)
TOCA.FrameMain.Background:SetBackdropColor(0, 0, 0, 1)
TOCA.FrameMain.Background:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameMain.Background:SetFrameLevel(TOCA.Framelevel.Background)

TOCA.KeyBindsSetOnLoad = 1

TOCA.Button.TotemicCall_w=40
TOCA.Button.TotemicCall_h=40
TOCA.Button.TotemicCall= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
TOCA.Button.TotemicCall:SetSize(TOCA.Button.TotemicCall_w, TOCA.Button.TotemicCall_h)
TOCA.Button.TotemicCall:SetPoint("CENTER", 0, 40)
TOCA.Button.TotemicCall:SetBackdrop(TOCA.SetIcon("spell_unused"))
TOCA.Button.TotemicCall:SetBackdropBorderColor(1, 1, 1, 0.5)
TOCA.Button.TotemicCall:SetFrameLevel(TOCA.Framelevel.Foreground)
TOCA.Button.TotemicCall.flash = TOCA.Button.TotemicCall:CreateTexture(nil, "ARTWORK")
TOCA.Button.TotemicCall.flash:SetSize(TOCA.Button.TotemicCall_w*2, TOCA.Button.TotemicCall_h*2)
TOCA.Button.TotemicCall.flash:SetPoint("CENTER", 0, 0)
TOCA.Button.TotemicCall.flash:SetTexture("Interface/Buttons/CheckButtonGlow")
TOCA.Button.TotemicCall.flash:Hide()
TOCA.Button.TotemicCall.highlight= TOCA.Button.TotemicCall:CreateTexture(nil, "ARTWORK", TOCA.Button.TotemicCall, 1)
TOCA.Button.TotemicCall.highlight:SetSize(TOCA.Button.TotemicCall_w, TOCA.Button.TotemicCall_h)
TOCA.Button.TotemicCall.highlight:SetPoint("CENTER", 0, 0)
TOCA.Button.TotemicCall.highlight:SetTexture("Interface/Buttons/ButtonHilight-Square")
TOCA.Button.TotemicCall.highlight:SetBlendMode("ADD")
TOCA.Button.TotemicCall.highlight:Hide()
TOCA.Button.TotemicCall.disable = CreateFrame("Frame", nil, TOCA.Button.TotemicCall, "BackdropTemplate")
TOCA.Button.TotemicCall.disable:SetSize(TOCA.Button.TotemicCall_w, TOCA.Button.TotemicCall_h)
TOCA.Button.TotemicCall.disable:SetPoint("CENTER", 0, 0)
TOCA.Button.TotemicCall.disable:SetBackdrop(TOCA.Backdrop.General)
TOCA.Button.TotemicCall.disable:SetBackdropColor(0, 0, 0, 1)
TOCA.Button.TotemicCall.disable:Hide()
TOCA.Button.TotemicCall.recharge = CreateFrame("Cooldown", nil, TOCA.Button.TotemicCall, "CooldownFrameTemplate")
TOCA.Button.TotemicCall.recharge:SetSize(TOCA.Button.TotemicCall_w, TOCA.Button.TotemicCall_h)
TOCA.Button.TotemicCall.recharge:SetPoint("CENTER", 0, 0)
TOCA.Button.TotemicCall.recharge:SetAllPoints()
TOCA.Button.TotemicCall.recharge:SetCooldown(GetTime(), 2)
TOCA.Button.TotemicCall.recharge:SetEdgeScale(0)

TOCA.Button.TotemicCall.ECL = TOCA.FrameMain:CreateTexture(nil, "ARTWORK", TOCA.Button.TotemicCall, 0)
TOCA.Button.TotemicCall.ECL:SetSize(TOCA.Button.TotemicCall_w, TOCA.Button.TotemicCall_h)
TOCA.Button.TotemicCall.ECL:SetPoint("CENTER", -30, 61)
TOCA.Button.TotemicCall.ECL:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Dwarf")
TOCA.Button.TotemicCall.ECR = TOCA.FrameMain:CreateTexture(nil, "ARTWORK", TOCA.Button.TotemicCall, 0)
TOCA.Button.TotemicCall.ECR:SetSize(TOCA.Button.TotemicCall_w, TOCA.Button.TotemicCall_h)
TOCA.Button.TotemicCall.ECR:SetPoint("CENTER", 30, 61)
TOCA.Button.TotemicCall.ECR:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Dwarf")
TOCA.Button.TotemicCall.ECR:SetTexCoord(1, 0, 0, 1)

TOCA.Button.TotemicCallAtt= CreateFrame("Button", nil, TOCA.Button.TotemicCall, "SecureActionButtonTemplate")
TOCA.Button.TotemicCallAtt:SetSize(TOCA.Button.TotemicCall_w, TOCA.Button.TotemicCall_h)
TOCA.Button.TotemicCallAtt:SetPoint("CENTER", 0, 0)
TOCA.Button.TotemicCallAtt:SetAttribute("type", "spell")
TOCA.Button.TotemicCallAtt:SetAttribute("spell", TOCA._L.SPELLS.TotemicCall)
TOCA.Button.TotemicCallAtt:SetScript("OnEnter", function(self)
  --TOCA.CloseAllMenus() --bug with the totemic call button overlapping
  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
    TOCA.Button.TotemicCall:SetBackdropBorderColor(1, 1, 1, 0)
  else
    TOCA.Button.TotemicCall:SetBackdropBorderColor(1, 1, 1, 1)
  end
  TOCA.Button.TotemicCall.highlight:Show()
  TOCA.TooltipDisplay(self, TOCA._L.SPELLS.TotemicCall)
end)
TOCA.Button.TotemicCallAtt:SetScript("OnLeave", function(self)
  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
    TOCA.Button.TotemicCall:SetBackdropBorderColor(1, 1, 1, 0)
  else
    TOCA.Button.TotemicCall:SetBackdropBorderColor(1, 1, 1, 0.6)
  end
  TOCA.Button.TotemicCall.highlight:Hide()
  TOCA.CloseAllMenus()
end)

--grid timers
TOCA.SlotGrid.VerticalTimerX = 0
TOCA.SlotGrid.HorizontalTimerX = 0
for i=1, 4 do
  TOCA.SlotGrid.VerticalTimerX = TOCA.SlotGrid.VerticalTimerX+TOCA.Slot_w
  TOCA.SlotGrid.VerticalTimer[i]= TOCA.FrameMain:CreateFontString(nil, "ARTWORK")
  TOCA.SlotGrid.VerticalTimer[i]:SetFont(TOCA._G.font, 12, "OUTLINE")
  TOCA.SlotGrid.VerticalTimer[i]:SetPoint("TOPLEFT", TOCA.SlotGrid.VerticalTimerX-TOCA.Slot_w+5, -28)
  TOCA.SlotGrid.VerticalTimer[i]:SetText("")
  TOCA.SlotGrid.VerticalTimer[i]:Hide()

  TOCA.SlotGrid.HorizontalTimerX = TOCA.SlotGrid.HorizontalTimerX+TOCA.Slot_w
  TOCA.SlotGrid.HorizontalTimer[i]= TOCA.FrameMain:CreateFontString(nil, "ARTWORK")
  TOCA.SlotGrid.HorizontalTimer[i]:SetFont(TOCA._G.font, 12, "OUTLINE")
  TOCA.SlotGrid.HorizontalTimer[i]:SetPoint("TOPLEFT", TOCA.SlotGrid.HorizontalTimerX-TOCA.Slot_w+5, -28)
  TOCA.SlotGrid.HorizontalTimer[i]:SetText("")
  TOCA.SlotGrid.HorizontalTimer[i]:Hide()
end

--classic style
TOCA.Slot={}
TOCA.Slot.Disable={}
TOCA.Slot.highlight={}
TOCA.Slot.Radius={}
TOCA.Slot.Radius.Border={}
TOCA.Slot.Recharge={}
TOCA.Totem={}
TOCA.TotemFlash={}
TOCA.Slot.Timer={}
TOCA.SlotPosX = {
  18.5,
  54.5,
  90.5,
  126.5,
}

--local totemNum = 0
TOCA.TotemNum ={}

scrollA = 1
scrollE = 1
scrollF = 1
scrollW = 1
TOCA.TotemNum["MAIN"] = 0
for totemCat,v in pairsByKeys(TOCA.totems) do
  TOCA.TotemNum["MAIN"] = TOCA.TotemNum["MAIN"] +1
  TOCA.Slot_x = TOCA.Slot_x +36
  TOCA.Slot[totemCat]={}
  TOCA.Slot[totemCat]= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
  TOCA.Slot[totemCat]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
  TOCA.Slot[totemCat]:SetPoint("TOPLEFT", -15+TOCA.SlotPosX[TOCA.TotemNum["MAIN"]], -TOCA.Slot_h)
  TOCA.Slot[totemCat]:SetBackdrop(TOCA.Backdrop.General)
	TOCA.Slot[totemCat]:SetBackdropColor(0, 0, 0, 1)
	TOCA.Slot[totemCat]:SetBackdropBorderColor(
	TOCA.colors.totems[totemCat][1],
	TOCA.colors.totems[totemCat][2],
	TOCA.colors.totems[totemCat][3], 0.6)
  TOCA.Slot.highlight[totemCat]= TOCA.Slot[totemCat]:CreateTexture(nil, "ARTWORK", TOCA.Slot[totemCat], 0)
  TOCA.Slot.highlight[totemCat]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
  TOCA.Slot.highlight[totemCat]:SetPoint("CENTER", 0, 0)
  TOCA.Slot.highlight[totemCat]:SetTexture("Interface/Buttons/ButtonHilight-Square")
  TOCA.Slot.highlight[totemCat]:SetBlendMode("ADD")
  TOCA.Slot.highlight[totemCat]:Hide()
	TOCA.Slot.Radius[totemCat]= TOCA.Slot[totemCat]:CreateTexture(nil, "ARTWORK", TOCA.Slot[totemCat], 1)
	TOCA.Slot.Radius[totemCat]:SetSize(TOCA.Slot_w-1, TOCA.Slot_h-1)
	TOCA.Slot.Radius[totemCat]:SetPoint("CENTER", 0, 0)
	TOCA.Slot.Radius[totemCat]:SetTexture("Interface/Buttons/ButtonHilight-Square")
	TOCA.Slot.Radius[totemCat]:SetVertexColor(1, 0, 0, 1)
	TOCA.Slot.Radius[totemCat]:SetBlendMode("ADD")
	TOCA.Slot.Radius[totemCat]:Hide()
	TOCA.Slot.Radius.Border[totemCat] = TOCA.Slot[totemCat]:CreateTexture(nil, "ARTWORK", TOCA.Slot[totemCat], 1)
	TOCA.Slot.Radius.Border[totemCat]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
	TOCA.Slot.Radius.Border[totemCat]:SetPoint("CENTER", 0, 0)
	TOCA.Slot.Radius.Border[totemCat]:SetTexture("Interface/ContainerFrame/UI-Icon-QuestBorder")
	TOCA.Slot.Radius.Border[totemCat]:SetVertexColor(1, 0, 0, 1)
	TOCA.Slot.Radius.Border[totemCat]:SetBlendMode("BLEND")
	TOCA.Slot.Radius.Border[totemCat]:Hide()
  TOCA.Slot.Disable[totemCat]= CreateFrame("Frame", nil, TOCA.Slot[totemCat], "BackdropTemplate")
  TOCA.Slot.Disable[totemCat]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
  TOCA.Slot.Disable[totemCat]:SetPoint("CENTER", 0, 0)
  TOCA.Slot.Disable[totemCat]:SetBackdrop(TOCA.Backdrop.General)
	TOCA.Slot.Disable[totemCat]:SetBackdropColor(0, 0, 0, 1)
  TOCA.Slot.Disable[totemCat]:SetBackdropBorderColor(1, 1, 1, 0)
  TOCA.Slot.Disable[totemCat]:Hide()
	TOCA.Slot.Recharge[totemCat] = CreateFrame("Cooldown", nil, TOCA.Slot[totemCat], "CooldownFrameTemplate")
	TOCA.Slot.Recharge[totemCat]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
	TOCA.Slot.Recharge[totemCat]:SetPoint("CENTER", 0, 0)
	TOCA.Slot.Recharge[totemCat]:SetAllPoints()
	TOCA.Slot.Recharge[totemCat]:SetCooldown(GetTime(), 2)
	TOCA.Slot.Recharge[totemCat]:SetEdgeScale(0)

  TOCA.Totem[totemCat] = CreateFrame("Button", nil, TOCA.Slot[totemCat], "SecureActionButtonTemplate")
  TOCA.Totem[totemCat]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
  TOCA.Totem[totemCat]:SetPoint("CENTER", 0, 0)
  TOCA.Totem[totemCat]:SetAttribute("type", "spell")

  local thisTotemSpell = ""
  if (totemCat == "AIR") then
    if (TOCA.isInCombat) then
      TOCA.Notification("[1] In Combat, do nothing!", true)
    else
      TOCA.Totem[totemCat]:SetAttribute("spell", TOCA.cache[1])
      TOCA.Slot.Timer[4]= TOCA.Slot[totemCat]:CreateFontString(nil, "ARTWORK")
      TOCA.Slot.Timer[4]:SetFont(TOCA._G.font, 12, "OUTLINE")
      TOCA.Slot.Timer[4]:SetPoint("CENTER", 0, -8)
      TOCA.Slot.Timer[4]:SetText("")
      TOCA.SlotGrid.VerticalTimer[4]:SetText("")
      TOCA.SlotGrid.HorizontalTimer[4]:SetText("")
    end
  end
  if (totemCat == "EARTH") then
    if (TOCA.isInCombat) then
      TOCA.Notification("[1] In Combat, do nothing!", true)
    else
      TOCA.Totem[totemCat]:SetAttribute("spell", TOCA.cache[2])
      TOCA.Slot.Timer[2]= TOCA.Slot[totemCat]:CreateFontString(nil, "ARTWORK")
      TOCA.Slot.Timer[2]:SetFont(TOCA._G.font, 12, "OUTLINE")
      TOCA.Slot.Timer[2]:SetPoint("CENTER", 0, -8)
      TOCA.Slot.Timer[2]:SetText("")
      TOCA.SlotGrid.VerticalTimer[2]:SetText("")
      TOCA.SlotGrid.HorizontalTimer[2]:SetText("")
    end
  end
  if (totemCat == "FIRE") then
    if (TOCA.isInCombat) then
      TOCA.Notification("[1] In Combat, do nothing!", true)
    else
      TOCA.Totem[totemCat]:SetAttribute("spell", TOCA.cache[3])
      TOCA.Slot.Timer[1]= TOCA.Slot[totemCat]:CreateFontString(nil, "ARTWORK")
      TOCA.Slot.Timer[1]:SetFont(TOCA._G.font, 12, "OUTLINE")
      TOCA.Slot.Timer[1]:SetPoint("CENTER", 0, -8)
      TOCA.Slot.Timer[1]:SetText("")
      TOCA.SlotGrid.VerticalTimer[1]:SetText("")
      TOCA.SlotGrid.HorizontalTimer[1]:SetText("")
    end
  end
  if (totemCat == "WATER") then
    if (TOCA.isInCombat) then
      TOCA.Notification("[1] In Combat, do nothing!", true)
    else
      TOCA.Totem[totemCat]:SetAttribute("spell", TOCA.cache[4])
      TOCA.Slot.Timer[3]= TOCA.Slot[totemCat]:CreateFontString(nil, "ARTWORK")
      TOCA.Slot.Timer[3]:SetFont(TOCA._G.font, 12, "OUTLINE")
      TOCA.Slot.Timer[3]:SetPoint("CENTER", 0, -8)
      TOCA.Slot.Timer[3]:SetText("")
      TOCA.SlotGrid.VerticalTimer[3]:SetText("")
      TOCA.SlotGrid.HorizontalTimer[3]:SetText("")
    end
  end
  TOCA.Totem[totemCat]:SetScript("OnEnter", function(self)
    TOCA.CloseAllMenus()
    if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
      TOCA.Slot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0)
    else
      TOCA.Slot[totemCat]:SetBackdropBorderColor(TOCA.colors.totems[totemCat][1],
			TOCA.colors.totems[totemCat][2],
			TOCA.colors.totems[totemCat][3], 1)
    end
    TOCA.Slot.highlight[totemCat]:Show()
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
  end)
  TOCA.Totem[totemCat]:SetScript("OnLeave", function()
    TOCA.CloseAllMenus()
    if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
      TOCA.Slot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0)
    else
      TOCA.Slot[totemCat]:SetBackdropBorderColor(
			TOCA.colors.totems[totemCat][1],
			TOCA.colors.totems[totemCat][2],
			TOCA.colors.totems[totemCat][3], 0.6)
    end
    TOCA.Slot.highlight[totemCat]:Hide()
  end)
  TOCA.TotemFlash[totemCat] = TOCA.Totem[totemCat]:CreateTexture(nil, "ARTWORK")
  TOCA.TotemFlash[totemCat]:SetSize(60, 60)
  TOCA.TotemFlash[totemCat]:SetPoint("CENTER", 0, 0)
  TOCA.TotemFlash[totemCat]:SetTexture("Interface/Buttons/CheckButtonGlow")
  TOCA.TotemFlash[totemCat]:Hide()
end

--local totemNum = 0
TOCA.SlotGrid.VerticalTotemButtonAction={}
TOCA.SlotGrid.HorizontalTotemButtonAction={}
TOCA.FrameMainGridVertical = CreateFrame("Frame", nil, TOCA.FrameMain)
TOCA.FrameMainGridVertical:SetSize(40, 250)
TOCA.FrameMainGridVertical:SetPoint("TOPLEFT", 0, 0)
TOCA.FrameMainGridVertical:Hide()
TOCA.FrameMainGridHorizontal = CreateFrame("Frame", nil, TOCA.FrameMain)
TOCA.FrameMainGridHorizontal:SetSize(1,1)
TOCA.FrameMainGridHorizontal:SetPoint("TOPLEFT", 0, 0)
TOCA.FrameMainGridHorizontal:Hide()

local totemButtonPos_X={}
local totemButtonPos_Y={}
TOCA.TotemNum["ROW"] = 0
for totemCat,v in pairsByKeys(TOCA.totems) do
  TOCA.TotemNum["ROW"] = TOCA.TotemNum["ROW"] +1
  totemButtonPos_X[totemCat] = 0
  totemButtonPos_Y[totemCat] = 0
  for i,totemSpell in pairs(TOCA.totems[totemCat]) do
    totemButtonPos_X[totemCat] = totemButtonPos_X[totemCat]+TOCA.Slot_w
    totemButtonPos_Y[totemCat] = totemButtonPos_Y[totemCat]+TOCA.Slot_h
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i]= CreateFrame("Button", nil, TOCA.FrameMainGridVertical, "BackdropTemplate")
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i]:SetPoint("TOPLEFT", -15+TOCA.SlotPosX[TOCA.TotemNum["ROW"]], -40-totemButtonPos_Y[totemCat]+TOCA.Slot_h)
		--TOCA.SlotGrid.VerticalTotemButton[totemCat][i]:SetPoint("CENTER", 0, -40-totemButtonPos_Y[totemCat]+TOCA.Slot_h)
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i]:SetFrameLevel(TOCA.Framelevel.Buttons)
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i]:SetBackdrop(TOCA.SetIcon(totemSpell[2]))
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0.6)
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].disable = CreateFrame("Frame", nil, TOCA.SlotGrid.VerticalTotemButton[totemCat][i], "BackdropTemplate")
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].disable:SetSize(TOCA.Slot_w, TOCA.Slot_h)
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].disable:SetPoint("CENTER", 0, 0)
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].disable:SetBackdrop(TOCA.Backdrop.General)
		TOCA.SlotGrid.VerticalTotemButton[totemCat][i].disable:SetBackdropColor(0, 0, 0, 1)
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].disable:SetBackdropBorderColor(1, 1, 1, 0)
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].disable:Hide()
		TOCA.SlotGrid.VerticalTotemButton[totemCat][i].recharge = CreateFrame("Cooldown", nil, TOCA.SlotGrid.VerticalTotemButton[totemCat][i], "CooldownFrameTemplate")
		TOCA.SlotGrid.VerticalTotemButton[totemCat][i].recharge:SetSize(TOCA.Slot_w, TOCA.Slot_h)
		TOCA.SlotGrid.VerticalTotemButton[totemCat][i].recharge:SetPoint("CENTER", 0, 0)
		TOCA.SlotGrid.VerticalTotemButton[totemCat][i].recharge:SetAllPoints()
		TOCA.SlotGrid.VerticalTotemButton[totemCat][i].recharge:SetCooldown(GetTime(), 2)
		TOCA.SlotGrid.VerticalTotemButton[totemCat][i].recharge:SetEdgeScale(0)
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].action = CreateFrame("Button", nil, TOCA.SlotGrid.VerticalTotemButton[totemCat][i], "SecureActionButtonTemplate")
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].action:SetSize(TOCA.Slot_w, TOCA.Slot_h)
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].action:SetPoint("CENTER", 0, 0)
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].action:SetAttribute("type", "spell")
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].action:SetAttribute("spell", totemSpell[1])
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].action.highlight= TOCA.SlotGrid.VerticalTotemButton[totemCat][i]:CreateTexture(nil, "ARTWORK", TOCA.SlotGrid.VerticalTotemButton[totemCat][i].action, 0)
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].action.highlight:SetSize(TOCA.Slot_w, TOCA.Slot_h)
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].action.highlight:SetPoint("CENTER", 0, 0)
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].action.highlight:SetTexture("Interface/Buttons/ButtonHilight-Square")
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].action.highlight:SetBlendMode("ADD")
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].action.highlight:Hide()
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].action:SetScript("OnEnter", function(self)
      self.highlight:Show()
      TOCA.TooltipDisplay(self, totemSpell[1])
    end)
    TOCA.SlotGrid.VerticalTotemButton[totemCat][i].action:SetScript("OnLeave", function(self)
      self.highlight:Hide()
      TOCA.CloseAllMenus()
    end)

    --totemButtonPos_X[totemCat] = totemButtonPos_X[totemCat]+TOCA.Slot_w
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i]= CreateFrame("Button", nil, TOCA.FrameMainGridHorizontal, "BackdropTemplate")
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i]:SetPoint("TOPLEFT", totemButtonPos_X[totemCat]+TOCA.Slot_w-30, -TOCA.SlotPosX[TOCA.TotemNum["ROW"]]-4)
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i]:SetFrameLevel(TOCA.Framelevel.Buttons)
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i]:SetBackdrop(TOCA.SetIcon(totemSpell[2]))
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0.6)
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].disable = CreateFrame("Frame", nil, TOCA.SlotGrid.HorizontalTotemButton[totemCat][i], "BackdropTemplate")
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].disable:SetSize(TOCA.Slot_w, TOCA.Slot_h)
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].disable:SetPoint("CENTER", 0, 0)
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].disable:SetBackdrop(TOCA.Backdrop.General)
		TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].disable:SetBackdropColor(0, 0, 0, 1)
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].disable:SetBackdropBorderColor(1, 1, 1, 0)
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].disable:SetFrameStrata("TOOLTIP")
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].disable:Hide()
		TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].recharge = CreateFrame("Cooldown", nil, TOCA.SlotGrid.HorizontalTotemButton[totemCat][i], "CooldownFrameTemplate")
		TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].recharge:SetSize(TOCA.Slot_w, TOCA.Slot_h)
		TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].recharge:SetPoint("CENTER", 0, 0)
		TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].recharge:SetAllPoints()
		TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].recharge:SetCooldown(GetTime(), 2)
		TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].recharge:SetEdgeScale(0)
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].action = CreateFrame("Button", nil, TOCA.SlotGrid.HorizontalTotemButton[totemCat][i], "SecureActionButtonTemplate")
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].action:SetSize(TOCA.Slot_w, TOCA.Slot_h)
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].action:SetPoint("CENTER", 0, 0)
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].action:SetAttribute("type", "spell")
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].action:SetAttribute("spell", totemSpell[1])
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].action.highlight= TOCA.SlotGrid.HorizontalTotemButton[totemCat][i]:CreateTexture(nil, "ARTWORK", TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].action, 0)
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].action.highlight:SetSize(TOCA.Slot_w, TOCA.Slot_h)
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].action.highlight:SetPoint("CENTER", 0, 0)
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].action.highlight:SetTexture("Interface/Buttons/ButtonHilight-Square")
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].action.highlight:SetBlendMode("ADD")
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].action.highlight:Hide()
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].action:SetScript("OnEnter", function(self)
      self.highlight:Show()
      TOCA.TooltipDisplay(self, totemSpell[1])
    end)
    TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].action:SetScript("OnLeave", function(self)
      self.highlight:Hide()
      TOCA.CloseAllMenus()
    end)
  end
end

TOCA.SlotSelect={}
TOCA.SlotSelectTotem={}
TOCA.SlotSelectTotemAction={}
TOCA.SlotSelectMenu={}
--TOCA.TotemSlotAction={}
TOCA.SlotSelect_x = 0
for totemCat,v in pairsByKeys(TOCA.totems) do
  TOCA.SlotSelect[totemCat]= CreateFrame("Button", nil, TOCA.Slot[totemCat], "BackdropTemplate")
  TOCA.SlotSelect[totemCat]:SetSize(TOCA.Slot_w, 15)
  TOCA.SlotSelect[totemCat]:SetPoint("CENTER", 0, 21)
  TOCA.SlotSelect[totemCat]:SetBackdrop(TOCA.Backdrop.Button)
	TOCA.SlotSelect[totemCat]:SetBackdropColor(0, 0, 0, 1)
  TOCA.SlotSelect[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.SlotSelect[totemCat]:SetFrameLevel(TOCA.Framelevel.Buttons)
  TOCA.SlotSelect[totemCat]:SetScript("OnEnter", function(self)
    if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
      self:SetBackdropBorderColor(1, 1, 1, 0)
    else
      self:SetBackdropBorderColor(1, 1, 0.8, 1)
    end
  end)
  TOCA.SlotSelect[totemCat]:SetScript("OnLeave", function(self)
    if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
      self:SetBackdropBorderColor(1, 1, 1, 0)
    else
      self:SetBackdropBorderColor(1, 1, 1, 0.6)
    end
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
	if (TOCA.Game.version == 3) then --WRATH
		--bugfix: air totems are not registering
		if (totemCat == "AIR") then
		  totemCategoryCount = 5
	  end
	end
  TOCA.SlotSelectMenu[totemCat]= CreateFrame("Frame", nil, TOCA.SlotSelect[totemCat], "BackdropTemplate")
  TOCA.SlotSelectMenu[totemCat]:SetSize(40, (totemCategoryCount*36.2))
	TOCA.SlotSelectMenu[totemCat]:SetPoint("BOTTOMLEFT", -3, 15)
  TOCA.SlotSelectMenu[totemCat]:SetBackdrop(TOCA.Backdrop.General)
	TOCA.SlotSelectMenu[totemCat]:SetBackdropColor(TOCA.colors.totems[totemCat][1], TOCA.colors.totems[totemCat][2], TOCA.colors.totems[totemCat][3], 1)
	TOCA.SlotSelectMenu[totemCat]:SetBackdropBorderColor(TOCA.colors.totems[totemCat][1], TOCA.colors.totems[totemCat][2], TOCA.colors.totems[totemCat][3], 0.6)
  --TOCA.SlotSelectMenu[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.SlotSelectMenu[totemCat]:SetFrameLevel(TOCA.Framelevel.Menu)
  TOCA.SlotSelectMenu[totemCat]:Hide()

  local totemSpellCount={}
  totemSpellCount[totemCat] = 0
  for i,totemSpell in pairs(TOCA.totems[totemCat]) do
    totemSpellCount[totemCat] = totemSpellCount[totemCat]+TOCA.Slot_h
    TOCA.SlotSelectTotem[totemCat]={}
    TOCA.SlotSelectTotem[totemCat][i]= CreateFrame("Button", nil, TOCA.SlotSelectMenu[totemCat], "BackdropTemplate")
    TOCA.SlotSelectTotem[totemCat][i]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
    TOCA.SlotSelectTotem[totemCat][i]:SetPoint("TOPLEFT", 2.5, -totemSpellCount[totemCat]+30)
    TOCA.SlotSelectTotem[totemCat][i]:SetFrameLevel(TOCA.Framelevel.Buttons)
    TOCA.SlotSelectTotem[totemCat][i]:SetBackdrop(TOCA.SetIcon(totemSpell[2]))
    TOCA.SlotSelectTotem[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0.6)
    TOCA.SlotSelectTotem[totemCat][i]:SetScript("OnEnter", function(self)
      TOCA.TooltipDisplay(self, totemSpell[1])
      if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
        self:SetBackdropBorderColor(1, 1, 1, 0)
      else
        self:SetBackdropBorderColor(1, 1, 0.8, 1)
      end
    end)
    TOCA.SlotSelectTotem[totemCat][i]:SetScript("OnLeave", function(self)
      GameTooltip:Hide()
      if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
        self:SetBackdropBorderColor(1, 1, 1, 0)
      else
        self:SetBackdropBorderColor(1, 1, 1, 0.6)
      end
    end)
    TOCA.SlotSelectTotem[totemCat][i]:SetScript("OnClick", function(self)
      if (totemCat == "AIR") then
        TOCA.cache[1] = totemSpell[1]
        if (TOCA.isInCombat) then
          TOCA.Notification("[2] In Combat, do nothing!", true)
        else
          TOCA.Totem[totemCat]:SetAttribute("spell", TOCA.cache[1])
          TOCA.SetKeyBindReset("TOTEM_AIR", totemSpell[1])
          TOCA.Notification("Setting AIR " .. totemSpell[1], true)
        end
      end
      if (totemCat == "EARTH") then
        TOCA.cache[2] = totemSpell[1]
        if (TOCA.isInCombat) then
          TOCA.Notification("[2] In Combat, do nothing!", true)
        else
          TOCA.Totem[totemCat]:SetAttribute("spell", TOCA.cache[2])
          TOCA.SetKeyBindReset("TOTEM_EARTH", totemSpell[1])
          TOCA.Notification("Setting EARTH " .. totemSpell[1], true)
        end
      end
      if (totemCat == "FIRE") then
        TOCA.cache[3] = totemSpell[1]
        if (TOCA.isInCombat) then
          TOCA.Notification("[2] In Combat, do nothing!", true)
        else
          TOCA.Totem[totemCat]:SetAttribute("spell", TOCA.cache[3])
          TOCA.SetKeyBindReset("TOTEM_FIRE", totemSpell[1])
          TOCA.Notification("Setting FIRE " .. totemSpell[1], true)
        end
      end
      if (totemCat == "WATER") then
        TOCA.cache[4] = totemSpell[1]
        if (TOCA.isInCombat) then
          TOCA.Notification("[2] In Combat, do nothing!", true)
        else
          TOCA.Totem[totemCat]:SetAttribute("spell", TOCA.cache[4])
          TOCA.SetKeyBindReset("TOTEM_WATER", totemSpell[1])
          TOCA.Notification("Setting WATER " .. totemSpell[1], true)
        end
      end
      TOCA.Slot[totemCat]:SetBackdrop(TOCA.SetIcon(totemSpell[2]))
      TOCA.CloseAllMenus()
    end)
    TOCA.SlotSelectTotemDisabled[totemCat][i]= CreateFrame("Frame", nil, TOCA.SlotSelectTotem[totemCat][i], "BackdropTemplate", -6)
    TOCA.SlotSelectTotemDisabled[totemCat][i]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
    TOCA.SlotSelectTotemDisabled[totemCat][i]:SetPoint("CENTER", 0, 0)
    TOCA.SlotSelectTotemDisabled[totemCat][i]:SetBackdrop(TOCA.Backdrop.General)
    TOCA.SlotSelectTotemDisabled[totemCat][i]:SetBackdropColor(0, 0, 0, 1)
    TOCA.SlotSelectTotemDisabled[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0)
    TOCA.SlotSelectTotemDisabled[totemCat][i]:SetFrameLevel(TOCA.Framelevel.Cover)
  end
end

TOCA.Button.Options= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
TOCA.Button.Options:SetSize(16, 16)
TOCA.Button.Options:SetPoint("TOPRIGHT", -16, -2)
TOCA.Button.Options:SetBackdrop(TOCA.Backdrop.General)
TOCA.Button.Options:SetBackdropColor(0, 0, 0, 1)
TOCA.Button.Options:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.Options.icon = TOCA.Button.Options:CreateTexture(nil, "ARTWORK")
TOCA.Button.Options.icon:SetSize(12, 12)
TOCA.Button.Options.icon:SetPoint("CENTER", 0, 0)
TOCA.Button.Options.icon:SetTexture("Interface/Buttons/UI-OptionsButton")
TOCA.Button.Options:SetScript("OnEnter", function(self)
  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
    self:SetBackdropBorderColor(1, 1, 1, 0)
  else
    self:SetBackdropBorderColor(1, 1, 1, 0.6)
  end
  TOCA.TooltipDisplay(self, TOCA._G.title, "v" .. TOCA._G.version .. "-" .. TOCA._G.suffix .. " ("..GetLocale()..")")
end)
TOCA.Button.Options:SetScript("OnLeave", function(self)
  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
    self:SetBackdropBorderColor(1, 1, 1, 0)
  else
    self:SetBackdropBorderColor(1, 1, 1, 0.6)
  end
  TOCA.CloseAllMenus()
end)
TOCA.Button.Options:SetScript("OnClick", function(self)
  TOCA.CloseAllMenus()
  TOCA.FrameOptions:Show()
end)
TOCA.Button.Options:Hide()

TOCA.Button.CloseMain= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
TOCA.Button.CloseMain:SetSize(16, 16)
TOCA.Button.CloseMain:SetPoint("TOPRIGHT", -2, -2)
TOCA.Button.CloseMain:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.CloseMain:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.CloseMain:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.CloseMain.icon = TOCA.Button.CloseMain:CreateTexture(nil, "ARTWORK")
TOCA.Button.CloseMain.icon:SetSize(12, 12)
TOCA.Button.CloseMain.icon:SetPoint("CENTER", 0, 0)
TOCA.Button.CloseMain.icon:SetTexture("Interface/Buttons/UI-StopButton")
TOCA.Button.CloseMain:SetScript("OnEnter", function(self)
  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
    self:SetBackdropBorderColor(1, 1, 1, 0)
  else
    self:SetBackdropBorderColor(1, 1, 1, 1)
  end
end)
TOCA.Button.CloseMain:SetScript("OnLeave", function(self)
  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
    self:SetBackdropBorderColor(1, 1, 1, 0)
  else
    self:SetBackdropBorderColor(1, 1, 1, 0.6)
  end
end)
TOCA.Button.CloseMain:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
  TOCA.FrameMain:Hide()
  TOCADB[TOCA.player.combine]["DISABLED"] = "YES"
  TOCA.Notification("closed. Type '" .. TOCA._G.CMD .. " show' to reopen.")
end)

TOCA.FrameMain.ShieldFrame = CreateFrame("Frame", nil, TOCA.FrameMain, "BackdropTemplate", 6)
TOCA.FrameMain.ShieldFrame:SetWidth(30)
TOCA.FrameMain.ShieldFrame:SetHeight(30)
TOCA.FrameMain.ShieldFrame:SetPoint("TOPLEFT", TOCA._G.width-4, -14)
TOCA.FrameMain.ShieldFrame:SetBackdrop(TOCA.SetIcon("ability_shaman_watershield")) --default
TOCA.FrameMain.ShieldFrame:SetBackdropColor(0.7, 0.7, 0.7, 0.8)
TOCA.FrameMain.ShieldFrame:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameMain.ShieldFrame:SetFrameLevel(TOCA.Framelevel.Foreground)
TOCA.FrameMain.ShieldFrame.timer = TOCA.FrameMain.ShieldFrame:CreateFontString(nil, "ARTWORK")
TOCA.FrameMain.ShieldFrame.timer:SetFont(TOCA._G.font, 10)
TOCA.FrameMain.ShieldFrame.timer:SetPoint("CENTER", TOCA.FrameMain.ShieldFrame, "CENTER", 0, 18)
TOCA.FrameMain.ShieldFrame.timer:SetText("")
TOCA.FrameMain.ShieldFrame.timer:SetTextColor(1, 0.8, 0, 1)
TOCA.FrameMain.ShieldFrame.timer:SetShadowOffset(1, 1)
TOCA.FrameMain.ShieldFrame.count = TOCA.FrameMain.ShieldFrame:CreateFontString(nil, "ARTWORK")
TOCA.FrameMain.ShieldFrame.count:SetFont(TOCA._G.font, 11, "OUTLINE")
TOCA.FrameMain.ShieldFrame.count:SetPoint("CENTER", TOCA.FrameMain.ShieldFrame, "CENTER", 7, -5)
TOCA.FrameMain.ShieldFrame.count:SetText("")
--TOCA.FrameMain.ShieldFrame.count:SetTextColor(1, 1, 0, 1)
--TOCA.FrameMain.ShieldFrame.count:SetShadowColor(0, 0, 0, 1)
--TOCA.FrameMain.ShieldFrame.count:SetShadowOffset(1, 1)
--[==[
TOCA.FrameMain.ShieldFrame:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, TOCA._L.SPELLS.Reincarnation)
end)
TOCA.FrameMain.ShieldFrame:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)
]==]--
TOCA.FrameMain.ShieldFrame:Hide()

TOCA.FrameMain.ReincFrame = CreateFrame("Frame", TOCA.FrameMain.Background, TOCA.FrameMain, "BackdropTemplate", -7)
TOCA.FrameMain.ReincFrame:SetWidth(30)
TOCA.FrameMain.ReincFrame:SetHeight(30)
TOCA.FrameMain.ReincFrame:SetPoint("TOPLEFT", TOCA._G.width-4, -44)
TOCA.FrameMain.ReincFrame:SetBackdrop(TOCA.SetIcon("spell_nature_reincarnation"))
--TOCA.FrameMain.ReincFrame:SetBackdropColor(0.7, 0.7, 0.7, 1)
TOCA.FrameMain.ReincFrame:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameMain.ReincFrame:SetFrameLevel(TOCA.Framelevel.Foreground)
TOCA.FrameMain.ReincFrame.text = TOCA.FrameMain.ReincFrame:CreateFontString(nil, "ARTWORK")
TOCA.FrameMain.ReincFrame.text:SetFont(TOCA._G.font, 10)
TOCA.FrameMain.ReincFrame.text:SetPoint("CENTER", TOCA.FrameMain.ReincFrame, "CENTER", 0, -18)
TOCA.FrameMain.ReincFrame.text:SetText("")
TOCA.FrameMain.ReincFrame.text:SetTextColor(1, 0.8, 0, 1)
TOCA.FrameMain.ReincFrame.text:SetShadowOffset(1, 1)
TOCA.FrameMain.ReincFrame:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, TOCA._L.SPELLS.Reincarnation)
end)
TOCA.FrameMain.ReincFrame:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)
TOCA.FrameMain.ReincFrame:Hide()

TOCA.FrameMain.AnkhFrame = CreateFrame("Frame", TOCA.FrameMain.Background, TOCA.FrameMain, "BackdropTemplate", -7)
TOCA.FrameMain.AnkhFrame:SetWidth(30)
TOCA.FrameMain.AnkhFrame:SetHeight(30)
TOCA.FrameMain.AnkhFrame:SetPoint("TOPLEFT", -28, -14)
TOCA.FrameMain.AnkhFrame:SetBackdrop(TOCA.SetIcon("inv_jewelry_talisman_06"))
--TOCA.FrameMain.AnkhFrame:SetBackdropColor(0.7, 0.7, 0.7, 0.8)
TOCA.FrameMain.AnkhFrame:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameMain.AnkhFrame:SetFrameLevel(TOCA.Framelevel.Foreground)
TOCA.FrameMain.AnkhFrame.text = TOCA.FrameMain.AnkhFrame:CreateFontString(nil, "ARTWORK")
TOCA.FrameMain.AnkhFrame.text:SetFont(TOCA._G.font, 12, "OUTLINE")
TOCA.FrameMain.AnkhFrame.text:SetPoint("CENTER", TOCA.FrameMain.AnkhFrame, "CENTER", 0, -2)
TOCA.FrameMain.AnkhFrame.text:SetText(TOCA.InventoryCountItem(TOCA.item.ANKH))
--TOCA.FrameMain.AnkhFrame.text:SetShadowOffset(1, 1)
TOCA.FrameMain.AnkhFrame:SetScript("OnEnter", function(self)
	TOCA.TooltipDisplay(self, TOCA._L.INIT[3], TOCA._L.Ankh())
end)
TOCA.FrameMain.AnkhFrame:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)
TOCA.FrameMain.AnkhFrame:Hide()

TOCA.Button.DropdownMain= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
TOCA.Button.DropdownMain:SetSize(143, 16)
TOCA.Button.DropdownMain:SetPoint("CENTER", 0, -32)
TOCA.Button.DropdownMain:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.DropdownMain:SetBackdropColor(0, 0, 0, 1)
TOCA.Button.DropdownMain:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.DropdownMain:SetFrameLevel(TOCA.Framelevel.Buttons)
TOCA.Button.DropdownMain.icon = TOCA.Button.DropdownMain:CreateTexture(nil, "ARTWORK")
TOCA.Button.DropdownMain.icon:SetSize(26, 18)
TOCA.Button.DropdownMain.icon:SetPoint("CENTER", 0, -3)
TOCA.Button.DropdownMain.icon:SetTexture("Interface/Buttons/Arrow-Down-Down")
TOCA.Button.DropdownMain:SetScript("OnClick", function(self)
  TOCA.CloseAllMenus()
  ToggleDropDownMenu(1, nil, TOCA.Dropdown.Main, self, 0, 0)
end)
TOCA.Button.DropdownMain:SetScript("OnEnter", function(self)
  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
    self:SetBackdropBorderColor(1, 1, 1, 0)
  else
    self:SetBackdropBorderColor(1, 1, 1, 1)
  end
end)
TOCA.Button.DropdownMain:SetScript("OnLeave", function(self)
  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
    self:SetBackdropBorderColor(1, 1, 1, 0)
  else
    self:SetBackdropBorderColor(1, 1, 1, 0.6)
  end
end)

TOCA.Dropdown.Main = CreateFrame("Frame", nil, TOCA.FrameMain, "UIDropDownMenuTemplate")
TOCA.Dropdown.Main:SetPoint("TOPLEFT", 0, -68)
TOCA.Dropdown.Main.displayMode = "MENU"
TOCA.Dropdown.Main.text = TOCA.Dropdown.Main:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.Main.text:SetFont(TOCA._G.font, 11)
TOCA.Dropdown.Main.text:SetPoint("TOPLEFT", TOCA.Dropdown.Main, "TOPLEFT", 25, -8)
TOCA.Dropdown.Main.text:SetText(TOCA.Dropdown.Menu[1])
TOCA.Dropdown.Main.onClick = function(self, checked)
  TOCA.SetDDMenu(TOCA.Dropdown.Main, self.value)
  TOCA.FrameSetsProfile:SetText(self.value)
end
UIDropDownMenu_SetWidth(TOCA.Dropdown.Main, 102)
TOCA.Dropdown.Main:Hide()
