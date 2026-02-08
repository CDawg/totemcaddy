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

TOCA.FrameWeap:Hide()

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