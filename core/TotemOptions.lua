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

TOCA.FrameOptions = CreateFrame("Frame", TOCA.FrameOptions, UIParent, "BackdropTemplate")
TOCA.FrameOptions:SetWidth(300)
TOCA.FrameOptions:SetHeight(200)
TOCA.FrameOptions:SetPoint("CENTER", 0, 50)
TOCA.FrameOptions:SetBackdrop(TOCA.Backdrop.General)
TOCA.FrameOptions:SetBackdropColor(0, 0, 0, 0.8)
TOCA.FrameOptions:SetBackdropBorderColor(1, 1, 1, 0.6)
--[==[
TOCA.FrameSets.title = TOCA.FrameSets:CreateFontString(nil, "ARTWORK")
TOCA.FrameSets.title:SetFont(TOCA.Global.font, 14, "OUTLINE")
TOCA.FrameSets.title:SetPoint("TOPLEFT", 10, -10)
TOCA.FrameSets.title:SetText(TOCA.Global.title .. " Set Builder")
]==]--
TOCA.FrameOptions:Hide()
