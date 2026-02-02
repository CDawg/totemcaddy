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
TOCA.FrameWeap:SetHeight(TOCA._G.height)
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
TOCA.FrameWeap.Background:SetHeight(TOCA._G.height)
TOCA.FrameWeap.Background:SetPoint("CENTER", 0, 0)
TOCA.FrameWeap.Background:SetBackdrop(TOCA.Backdrop.General)
TOCA.FrameWeap.Background:SetBackdropColor(0, 0, 0, 1)
TOCA.FrameWeap.Background:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameWeap.Background:SetFrameLevel(TOCA.Framelevel.Background)

TOCA.FrameWeap:Hide()