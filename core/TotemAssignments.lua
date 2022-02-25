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

TOCA.FrameAssignments={}
TOCA.FrameAssignments = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
TOCA.FrameAssignments:SetWidth(600)
TOCA.FrameAssignments:SetHeight(150)
TOCA.FrameAssignments:SetPoint("CENTER", 0, 60)
TOCA.FrameAssignments:SetBackdrop(TOCA.Backdrop.General)
--[==[
TOCA.FrameAssignments:SetMovable(true)
TOCA.FrameAssignments:EnableMouse(true)
TOCA.FrameAssignments:RegisterForDrag("LeftButton")
TOCA.FrameAssignments:SetScript("OnDragStart", function()
  TOCA.FrameMain:StartMoving()
end)
]==]--
TOCA.FrameAssignments:Hide()

for i=1, MAX_RAID_MEMBERS do
	TOCA.FrameAssignments.text = TOCA.FrameAssignments:CreateFontString(nil, "ARTWORK")
	TOCA.FrameAssignments.text:SetFont(TOCA.Global.font, 11)
	TOCA.FrameAssignments.text:SetPoint("TOPLEFT", 10, -i*14)
	TOCA.FrameAssignments.text:SetText("")
end
--UI-DialogBox-Header
