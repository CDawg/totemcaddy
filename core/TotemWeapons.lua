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

TOCA.FrameWeapSize = {}
TOCA.FrameWeapSize[1] = 150 --w default
TOCA.FrameWeapSize[2] = 42 -- h

TOCA.FrameWeap={}
TOCA.FrameWeap = CreateFrame("Frame", TOCA.FrameWeap, UIParent, "BackdropTemplate")
TOCA.FrameWeap:SetWidth(TOCA.FrameWeapSize[1])
TOCA.FrameWeap:SetHeight(TOCA.FrameWeapSize[2])
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
TOCA.FrameWeap:SetScript("OnEnter", function()
  TOCA.FrameWeap.close:Show()
end)
TOCA.FrameWeap:SetScript("OnLeave", function()
  TOCA.FrameWeap.close:Hide()
end)
TOCA.FrameWeap.Background = CreateFrame("Frame", TOCA.FrameWeap.Background, TOCA.FrameWeap, "BackdropTemplate", -6)
TOCA.FrameWeap.Background:SetWidth(TOCA.FrameWeapSize[1])
TOCA.FrameWeap.Background:SetHeight(TOCA.FrameWeapSize[2])
TOCA.FrameWeap.Background:SetPoint("CENTER", 0, 0)
TOCA.FrameWeap.Background:SetBackdrop(TOCA.Backdrop.General)
TOCA.FrameWeap.Background:SetBackdropColor(0, 0, 0, 1)
TOCA.FrameWeap.Background:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameWeap.Background:SetFrameLevel(TOCA.Framelevel.Background)

TOCA.Button.WeapSize_w=32
TOCA.Button.WeapSize_h=32
TOCA.Button.WeapPos_x=0
TOCA.Button.Weap = {}
for i=1, 4 do
  TOCA.Button.WeapPos_x = -21 + (i*TOCA.Button.WeapSize_w)
  TOCA.Button.Weap[i]= CreateFrame("Button", nil, TOCA.FrameWeap, "BackdropTemplate")
  TOCA.Button.Weap[i]:SetSize(TOCA.Button.WeapSize_w, TOCA.Button.WeapSize_h)
  TOCA.Button.Weap[i]:SetPoint("LEFT", TOCA.Button.WeapPos_x, 0)
  TOCA.Button.Weap[i]:SetBackdrop(TOCA.SetIcon(TOCA.icons.WEAP[i]))
  TOCA.Button.Weap[i]:SetBackdropBorderColor(1, 1, 1, 0.5)
  TOCA.Button.Weap[i]:SetFrameLevel(TOCA.Framelevel.Foreground)
  
  TOCA.Button.Weap[i].flash = TOCA.Button.Weap[i]:CreateTexture(nil, "ARTWORK")
  TOCA.Button.Weap[i].flash:SetSize(TOCA.Button.WeapSize_w*2, TOCA.Button.WeapSize_h*2)
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
    if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
        TOCA.Button.Weap[i]:SetBackdropBorderColor(1, 1, 1, 0)
    else
        TOCA.Button.Weap[i]:SetBackdropBorderColor(1, 1, 1, 1)
    end
    TOCA.Button.Weap[i].highlight:Show()
    TOCA.TooltipDisplay(self, TOCA.IdentifySpell(TOCA.weapons[i]))
  end)
  TOCA.Button.Weap[i].Action:SetScript("OnLeave", function(self)
    TOCA.Button.Weap[i].highlight:Hide()
    TOCA.CloseAllMenus()
    if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
        TOCA.Button.Weap[i]:SetBackdropBorderColor(1, 1, 1, 0)
    else
        TOCA.Button.Weap[i]:SetBackdropBorderColor(1, 1, 1, 0.6)
    end
    TOCA.Button.Weap[i].highlight:Hide()
    TOCA.CloseAllMenus()
  end)
end

function TOCA.WeapFrameFlip(vert)
  local buttonpos = 0
  if (vert == 1) then
    TOCA.FrameWeap:SetWidth(TOCA.FrameWeapSize[2])
    TOCA.FrameWeap:SetHeight(TOCA.FrameWeapSize[1])
    TOCA.FrameWeap.Background:SetWidth(TOCA.FrameWeapSize[2])
    TOCA.FrameWeap.Background:SetHeight(TOCA.FrameWeapSize[1])
    for i=1, 4 do
      buttonpos = -82 + (i*TOCA.Button.WeapSize_w)
      TOCA.Button.Weap[i]:SetPoint("LEFT", 5, -buttonpos)
    end
  else
    TOCA.FrameWeap:SetWidth(TOCA.FrameWeapSize[1])
    TOCA.FrameWeap:SetHeight(TOCA.FrameWeapSize[2])
    TOCA.FrameWeap.Background:SetWidth(TOCA.FrameWeapSize[1])
    TOCA.FrameWeap.Background:SetHeight(TOCA.FrameWeapSize[2])
    for i=1, 4 do
      buttonpos = -21 + (i*TOCA.Button.WeapSize_w)
      TOCA.Button.Weap[i]:SetPoint("LEFT", buttonpos, 0)
    end
  end
end

TOCA.FrameWeap.close = CreateFrame("Button", nil, TOCA.FrameWeap, "BackdropTemplate")
TOCA.FrameWeap.close:SetSize(18, 18)
TOCA.FrameWeap.close:SetPoint("TOPLEFT", 2, 16)
TOCA.FrameWeap.close:SetFrameLevel(TOCA.Framelevel.Buttons)
TOCA.FrameWeap.close:SetBackdrop(TOCA.Backdrop.Button)
TOCA.FrameWeap.close:SetBackdropColor(0.6, 0, 0, 1)
TOCA.FrameWeap.close:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameWeap.close.icon = TOCA.FrameWeap.close:CreateTexture(nil, "ARTWORK")
TOCA.FrameWeap.close.icon:SetSize(12, 12)
TOCA.FrameWeap.close.icon:SetPoint("CENTER", 0, 0)
TOCA.FrameWeap.close.icon:SetTexture("Interface/Buttons/UI-StopButton")
TOCA.FrameWeap.close:SetScript("OnClick", function(self)
  TOCA.CloseAllMenus()
  TOCA.FrameWeap:Hide()
  --TOCA.Notification(string.lower(totemCat) .. " bar closed. Type '" .. TOCA._G.CMD .. " show' to reopen.")
end)
TOCA.FrameWeap.close:SetScript("OnEnter", function(self)
  TOCA.CloseAllMenus()
  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
    self:SetBackdropBorderColor(1, 1, 1, 0)
  else
    self:SetBackdropBorderColor(1, 1, 1, 1)
  end
  --TOCA.SegmentedButtonMenu(totemCat, true)
  TOCA.TooltipDisplay(self, TOCA._L.UI.TOOLTIP[3][1], TOCA._L.UI.TOOLTIP[3][2]) -- hide this bar
  self:Show()
end)
TOCA.FrameWeap.close:SetScript("OnLeave", function(self)
  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
    self:SetBackdropBorderColor(1, 1, 1, 0)
  else
    self:SetBackdropBorderColor(1, 1, 1, 0.6)
  end
  self:Hide()
  TOCA.CloseAllMenus()
end)
TOCA.FrameWeap.close:Hide()

--TOCA.FrameWeapOptions = {}
TOCA.Checkbox.FrameWeap={}
TOCA.Checkbox.FrameWeap = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.TABPage.WEAPONS], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.FrameWeap:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -40)
TOCA.Checkbox.FrameWeap:SetChecked(nil)
TOCA.Checkbox.FrameWeap.text = TOCA.Checkbox.FrameWeap:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.FrameWeap.text:SetFont(TOCA._G.font, 12, "OUTLINE")
TOCA.Checkbox.FrameWeap.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.FrameWeap.text:SetText(TOCA._L.UI.FRAME[7][1])
TOCA.Checkbox.FrameWeap:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), TOCA._L.UI.FRAME[7][2])
end)
TOCA.Checkbox.FrameWeap:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)
TOCA.Checkbox.FrameWeap:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["WEAPFRAME"] = "ON"
    TOCA.FrameWeap:Show()
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["WEAPFRAME"] = "OFF"
    TOCA.FrameWeap:Hide()
  end
end)

--TOCA.Checkbox.FrameWeap.flip={}
TOCA.Checkbox.FrameWeap.flip = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.TABPage.WEAPONS], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.FrameWeap.flip:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -60)
TOCA.Checkbox.FrameWeap.flip:SetChecked(nil)
TOCA.Checkbox.FrameWeap.flip.text = TOCA.Checkbox.FrameWeap.flip:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.FrameWeap.flip.text:SetFont(TOCA._G.font, 12, "OUTLINE")
TOCA.Checkbox.FrameWeap.flip.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.FrameWeap.flip.text:SetText(TOCA._L.UI.FRAME[8][1])
TOCA.Checkbox.FrameWeap.flip:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), TOCA._L.UI.FRAME[8][2])
end)
TOCA.Checkbox.FrameWeap.flip:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)
TOCA.Checkbox.FrameWeap.flip:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["WEAPFLIP"] = "ON"
    TOCA.WeapFrameFlip(1)
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["WEAPFLIP"] = "OFF"
    TOCA.WeapFrameFlip(0)
  end
end)

TOCA.FrameWeap:Hide()