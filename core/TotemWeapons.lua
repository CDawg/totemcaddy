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

TOCA.FrameWeap={}
TOCA.FrameWeap = CreateFrame("Frame", TOCA.FrameWeap, UIParent, "BackdropTemplate")
TOCA.FrameWeap:SetWidth(TOCA._G.width)
TOCA.FrameWeap:SetHeight(TOCA._G.height/2)
TOCA.FrameWeap:SetPoint("CENTER", 0, -140)
TOCA.FrameWeap:SetMovable(true)
TOCA.FrameWeap:EnableMouse(true)
TOCA.FrameWeap:RegisterForDrag("LeftButton")
TOCA.FrameWeap:SetScript("OnDragStart", function()
  TOCA.FrameWeap:StartMoving()
end)
TOCA.FrameWeap:SetScript("OnDragStop", function()
  TOCA.FrameWeap:StopMovingOrSizing()
  local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.FrameWeap:GetPoint()
  TOCADB[TOCA.player.combine]["CONFIG"]["WEAPPOS"] = point .. "," .. xOfs .. "," .. yOfs
end)
TOCA.FrameWeap.Background = CreateFrame("Frame", TOCA.FrameWeap.Background, TOCA.FrameWeap, "BackdropTemplate", -6)
TOCA.FrameWeap.Background:SetWidth(TOCA._G.width)
TOCA.FrameWeap.Background:SetHeight(TOCA._G.height/2)
TOCA.FrameWeap.Background:SetPoint("CENTER", 0, 0)
TOCA.FrameWeap.Background:SetBackdrop(TOCA.Backdrop.General)
TOCA.FrameWeap.Background:SetBackdropColor(0, 0, 0, 1)
TOCA.FrameWeap.Background:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameWeap.Background:SetFrameLevel(TOCA.Framelevel.Background)

--TOCA.FrameWeap:Hide()

TOCA.Button.WeapSize_w=32
TOCA.Button.WeapSize_h=32
TOCA.Button.WeapPos_x=0
TOCA.Button.Weap = {}
for i=1, 4 do
  TOCA.Button.WeapPos_x = -20 + (i*TOCA.Button.WeapSize_w)
  TOCA.Button.Weap[i]= CreateFrame("Button", nil, TOCA.FrameWeap, "BackdropTemplate")
  TOCA.Button.Weap[i]:SetSize(TOCA.Button.WeapSize_w, TOCA.Button.WeapSize_h)
  TOCA.Button.Weap[i]:SetPoint("LEFT", TOCA.Button.WeapPos_x, 0)
  TOCA.Button.Weap[i]:SetBackdrop(TOCA.SetIcon("spell_unused"))
  TOCA.Button.Weap[i]:SetBackdropBorderColor(1, 1, 1, 0.5)
  TOCA.Button.Weap[i]:SetFrameLevel(TOCA.Framelevel.Foreground)
  
  TOCA.Button.Weap[i].flash = TOCA.Button.Weap[i]:CreateTexture(nil, "ARTWORK")
  --TOCA.Button.Weap[i].flash:SetSize(TOCA.Button.WeapSize_w*2, TOCA.Button.WeapSize_h*2)
  TOCA.Button.Weap[i].flash:SetSize(TOCA.Button.WeapSize_w, TOCA.Button.WeapSize_h)
  TOCA.Button.Weap[i].flash:SetPoint("LEFT", 0, 0)
  TOCA.Button.Weap[i].flash:SetTexture("Interface/Buttons/CheckButtonGlow")
  TOCA.Button.Weap[i].flash:Hide()
  TOCA.Button.Weap[i].highlight= TOCA.Button.Weap[i]:CreateTexture(nil, "ARTWORK")
  TOCA.Button.Weap[i].highlight:SetSize(TOCA.Button.WeapSize_w, TOCA.Button.WeapSize_h)
  TOCA.Button.Weap[i].highlight:SetPoint("LEFT", 0, 0)
  TOCA.Button.Weap[i].highlight:SetTexture("Interface/Buttons/ButtonHilight-Square")
  TOCA.Button.Weap[i].highlight:SetBlendMode("ADD")
  TOCA.Button.Weap[i].highlight:Hide()
  TOCA.Button.Weap[i].disable = CreateFrame("Frame", nil, TOCA.Button.Weap[i], "BackdropTemplate")
  TOCA.Button.Weap[i].disable:SetSize(TOCA.Button.WeapSize_w, TOCA.Button.WeapSize_h)
  TOCA.Button.Weap[i].disable:SetPoint("LEFT", 0, 0)
  TOCA.Button.Weap[i].disable:SetBackdrop(TOCA.Backdrop.General)
  TOCA.Button.Weap[i].disable:SetBackdropColor(0, 0, 0, 1)
  TOCA.Button.Weap[i].disable:Hide()
  TOCA.Button.Weap[i].recharge = CreateFrame("Cooldown", nil, TOCA.Button.Weap[i], "CooldownFrameTemplate")
  TOCA.Button.Weap[i].recharge:SetSize(TOCA.Button.WeapSize_w, TOCA.Button.WeapSize_h)
  TOCA.Button.Weap[i].recharge:SetPoint("LEFT", 0, 0)
  TOCA.Button.Weap[i].recharge:SetAllPoints()
  TOCA.Button.Weap[i].recharge:SetCooldown(GetTime(), 2)
  TOCA.Button.Weap[i].recharge:SetEdgeScale(0)
  TOCA.Button.Weap[i].Action = CreateFrame("Button", nil, TOCA.Button.Weap[i], "SecureActionButtonTemplate")
  TOCA.Button.Weap[i].Action:SetSize(TOCA.Button.WeapSize_w, TOCA.Button.WeapSize_h)
  TOCA.Button.Weap[i].Action:SetPoint("LEFT", 0, 0)
  TOCA.Button.Weap[i].Action:RegisterForClicks("AnyDown", "AnyUp")
  TOCA.Button.Weap[i].Action:SetAttribute("type", "spell")
  TOCA.Button.Weap[i].Action:SetAttribute("spell", TOCA.IdentifySpell(TOCA.weapons[i]))
  TOCA.Button.Weap[i].Action:SetScript("OnEnter", function(self)
    TOCA.CloseAllMenus()
    TOCA.Button.Weap[i].highlight:Show()
    --TOCA.TooltipDisplay(self, TOCA._L.SPELLS.TotemicCall)
  end)
  TOCA.Button.Weap[i].Action:SetScript("OnLeave", function(self)
    TOCA.CloseAllMenus()
    TOCA.Button.Weap[i].highlight:Hide()
  end)
end

--[==[
TOCA.Checkbox.MainLock={}
TOCA.Checkbox.MainLock = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.TABPage.WEAPONS], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.MainLock:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["RIGHT"], TOCA.OptionsPosition_y["FRAMEMENU"]-40)
TOCA.Checkbox.MainLock:SetChecked(1)
TOCA.Checkbox.MainLock.text = TOCA.Checkbox.MainLock:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.MainLock.text:SetFont(TOCA._G.font, 12, "OUTLINE")
TOCA.Checkbox.MainLock.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.MainLock.text:SetText(TOCA._L.UI.FRAME[1][1])
TOCA.Checkbox.MainLock:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), TOCA._L.UI.FRAME[1][2])
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
]==]--
TOCA.FrameWeapOptions = {}
TOCA.FrameWeapOptions.text = TOCA.FrameOptionsPage[TOCA.TABPage.WEAPONS]:CreateFontString(nil, "ARTWORK")
TOCA.FrameWeapOptions.text:SetFont(TOCA._G.font, 12, "OUTLINE")
TOCA.FrameWeapOptions.text:SetPoint("TOPLEFT", 25, -12)
TOCA.FrameWeapOptions.text:SetText("Coming soon")