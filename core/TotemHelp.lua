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

TOCA.FrameHelp = CreateFrame("Frame", TOCA.FrameHelp, UIParent, "BackdropTemplate")
TOCA.FrameHelp:SetWidth(350)
TOCA.FrameHelp:SetHeight(250)
TOCA.FrameHelp:SetPoint("CENTER", 0, 100)
TOCA.FrameHelp:SetBackdrop(TOCA.Backdrop.General)
TOCA.FrameHelp:SetBackdropColor(0, 0, 0, 1)
TOCA.FrameHelp:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameHelp.text={}
TOCA.FrameHelp.text[1] = TOCA.FrameHelp:CreateFontString(nil, "ARTWORK")
TOCA.FrameHelp.text[1]:SetFont(TOCA.Global.font, 13, "OUTLINE")
TOCA.FrameHelp.text[1]:SetPoint("TOPLEFT", 20, -20)
TOCA.FrameHelp.text[1]:SetText("Welcome to " .. TOCA.Global.title .. "|r v" .. TOCA.Global.version .. "\n")
TOCA.FrameHelp.text[2] = TOCA.FrameHelp:CreateFontString(nil, "ARTWORK")
TOCA.FrameHelp.text[2]:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.FrameHelp.text[2]:SetPoint("TOPLEFT", 20, -40)
TOCA.FrameHelp.text[2]:SetText("Let's get started by dragging the Totem Caddy\nanywhere on your screen saving the position.")
TOCA.FrameHelp.text[3] = TOCA.FrameHelp:CreateFontString(nil, "ARTWORK")
TOCA.FrameHelp.text[3]:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.FrameHelp.text[3]:SetPoint("TOPLEFT", 20, -85)
TOCA.FrameHelp.text[3]:SetText("You can also select totems in order\n[AIR,EARTH,FIRE,WATER] by selecting the\ntop arrows above the current totem icons.")
TOCA.FrameHelp.text[4] = TOCA.FrameHelp:CreateFontString(nil, "ARTWORK")
TOCA.FrameHelp.text[4]:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.FrameHelp.text[4]:SetPoint("TOPLEFT", 20, -130)
TOCA.FrameHelp.text[4]:SetText("You can also select the right arrow for additional\noptions, like saving Totem Sets to your profile,\ngive it a name, then select the dropdown\n to access it from the Totem Caddy Frame.")
TOCA.Button.CloseFrameHelp= CreateFrame("Button", nil, TOCA.FrameHelp, "BackdropTemplate")
TOCA.Button.CloseFrameHelp:SetSize(80, 25)
TOCA.Button.CloseFrameHelp:SetPoint("CENTER", 0, -90)
TOCA.Button.CloseFrameHelp:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.CloseFrameHelp:SetBackdropColor(0.7, 0, 0, 1)
TOCA.Button.CloseFrameHelp:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.CloseFrameHelp.text = TOCA.Button.CloseFrameHelp:CreateFontString(nil, "ARTWORK")
TOCA.Button.CloseFrameHelp.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Button.CloseFrameHelp.text:SetPoint("CENTER", 0, 0)
TOCA.Button.CloseFrameHelp.text:SetText("Close")
TOCA.Button.CloseFrameHelp:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 1)
end)
TOCA.Button.CloseFrameHelp:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.Button.CloseFrameHelp:SetScript("OnClick", function()
  TOCA.FrameHelp:Hide()
  TOCADB[TOCA.player.combine]["HELP"] = TOCA.Global.version
end)
--TOCA.FrameHelp:Hide()
TOCA.Checkbox.DontShow={}
TOCA.Checkbox.DontShow = CreateFrame("CheckButton", nil, TOCA.FrameHelp, "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.DontShow:SetPoint("CENTER", -80, -110)
TOCA.Checkbox.DontShow.text = TOCA.Checkbox.DontShow:CreateFontString(nil,"ARTWORK")
TOCA.Checkbox.DontShow.text:SetFont(TOCA.Global.font, 10, "OUTLINE")
TOCA.Checkbox.DontShow.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.DontShow.text:SetText("Don't Show this message again")
