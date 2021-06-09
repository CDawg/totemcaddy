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

local FrameHelp_w = 400
local FrameHelp_h = 260
TOCA.FrameHelp = CreateFrame("Frame", TOCA.FrameHelp, UIParent, "BackdropTemplate")
TOCA.FrameHelp:SetWidth(FrameHelp_w)
TOCA.FrameHelp:SetHeight(FrameHelp_h)
TOCA.FrameHelp:SetPoint("CENTER", 0, 100)
TOCA.FrameHelp:SetBackdrop(TOCA.Backdrop.General)
TOCA.FrameHelp:SetBackdropColor(0, 0, 0, 1)
TOCA.FrameHelp:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameHelp:SetFrameStrata("DIALOG")
TOCA.FrameHelp.text={}

TOCA.helpMessage = {
  "Welcome to " .. TOCA.Global.title .. "|r v" .. TOCA.Global.version,
  "Let's get started by dragging the Totem Caddy anywhere on your screen saving the position.",
  "You can select totems in order [AIR,EARTH,FIRE,WATER] by selecting the top arrows above the current totem icons.",
  "The set of totems are by default, but you can create your own totem sets in the options window.",
  "For addition options or create totem sets:",
  "Select the cogwheel button, then select Totem Sets, You can select which totem for each category, give it a name, then select the bottom arrow on the main frame dropdown to access it.",
}
TOCA.HelpMessageArray = ""
for k, v in pairs(TOCA.helpMessage) do
  TOCA.HelpMessageArray = TOCA.HelpMessageArray .. v .. "\n\n"
end

TOCA.TextFrame_w = FrameHelp_w-20
TOCA.TextFrame_h = FrameHelp_h-65
TOCA.TextFrame = CreateFrame("Frame", nil, TOCA.FrameHelp)
TOCA.TextFrame:SetWidth(TOCA.TextFrame_w)
TOCA.TextFrame:SetHeight(TOCA.TextFrame_h)
TOCA.TextFrame:SetPoint("CENTER", 0, 20)
TOCA.TextFrame:SetFrameStrata("DIALOG")
TOCA.TextFrameScrollFrame={}
--TOCA.TextFrameScrollFrame = CreateFrame("Frame", TOCA.TextFrameScrollFrame, TOCA.TextFrame, "InsetFrameTemplate")
TOCA.TextFrameScrollFrame = CreateFrame("Frame", TOCA.TextFrameScrollFrame, TOCA.TextFrame, "BackdropTemplate")
TOCA.TextFrameScrollFrame:SetWidth(TOCA.TextFrame_w+10)
TOCA.TextFrameScrollFrame:SetHeight(TOCA.TextFrame_h-20)
TOCA.TextFrameScrollFrame:SetPoint("CENTER", 0, 0)
TOCA.TextFrameScrollFrame:SetBackdrop(TOCA.Backdrop.General)
TOCA.TextFrameScrollFrame:SetBackdropBorderColor(1, 1, 1, 0.4)
TOCA.TextFrameScrollFrame.Child = CreateFrame("ScrollFrame", nil, TOCA.TextFrameScrollFrame, "UIPanelScrollFrameTemplate")
TOCA.TextFrameScrollFrame.Child:SetPoint("TOPLEFT", TOCA.TextFrameScrollFrame, "TOPLEFT", 3, -3)
TOCA.TextFrameScrollFrame.Child:SetPoint("BOTTOMRIGHT", TOCA.TextFrameScrollFrame, "BOTTOMRIGHT", 10, 4)
TOCA.TextFrameScrollFrameChildFrame = CreateFrame("Frame", TOCA.TextFrameScrollFrameChildFrame, TOCA.TextFrameScrollFrame.Child)
TOCA.TextFrameScrollFrameChildFrame:SetSize(TOCA.TextFrame_w-40, TOCA.TextFrame_h-20)
TOCA.TextFrameScrollFrame.Child:SetScrollChild(TOCA.TextFrameScrollFrameChildFrame)
TOCA.TextFrameScrollFrame.Child.ScrollBar:ClearAllPoints()
TOCA.TextFrameScrollFrame.Child.ScrollBar:SetPoint("TOPLEFT", TOCA.TextFrameScrollFrame.Child, "TOPRIGHT", 0, -17)
TOCA.TextFrameScrollFrame.Child.ScrollBar:SetPoint("BOTTOMRIGHT", TOCA.TextFrameScrollFrame.Child, "BOTTOMRIGHT", -42, 14)
TOCA.TextFrame.text = CreateFrame("EditBox", nil, TOCA.TextFrameScrollFrameChildFrame)
TOCA.TextFrame.text:SetWidth(TOCA.TextFrame_w-20)
TOCA.TextFrame.text:SetHeight(20)
TOCA.TextFrame.text:SetFontObject(GameFontWhite)
TOCA.TextFrame.text:SetPoint("CENTER", 10, -30)
TOCA.TextFrame.text:SetMultiLine(true)
TOCA.TextFrame.text:ClearFocus(self)
TOCA.TextFrame.text:SetAutoFocus(false)
TOCA.TextFrame.text:SetText(TOCA.HelpMessageArray)

TOCA.Button.CloseFrameHelp= CreateFrame("Button", nil, TOCA.FrameHelp, "BackdropTemplate")
TOCA.Button.CloseFrameHelp:SetSize(80, 25)
TOCA.Button.CloseFrameHelp:SetPoint("CENTER", 0, -86)
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
--[==[
TOCA.Checkbox.DontShow={}
TOCA.Checkbox.DontShow = CreateFrame("CheckButton", nil, TOCA.FrameHelp, "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.DontShow:SetPoint("CENTER", -80, -110)
TOCA.Checkbox.DontShow:SetChecked(1)
TOCA.Checkbox.DontShow.text = TOCA.Checkbox.DontShow:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.DontShow.text:SetFont(TOCA.Global.font, 10, "OUTLINE")
TOCA.Checkbox.DontShow.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.DontShow.text:SetText("Don't Show this message again")
]==]--
TOCA.ShowAgain={}
TOCA.ShowAgain[1] = TOCA.FrameHelp:CreateFontString(nil, "ARTWORK")
TOCA.ShowAgain[1]:SetFont(TOCA.Global.font, 10, "OUTLINE")
TOCA.ShowAgain[1]:SetPoint("CENTER", 0, -105)
TOCA.ShowAgain[1]:SetText("This message will not show again unless there is a new version.")
TOCA.ShowAgain[1]:SetTextColor(0.7, 0.7, 0.6, 1)
TOCA.ShowAgain[2] = TOCA.FrameHelp:CreateFontString(nil, "ARTWORK")
TOCA.ShowAgain[2]:SetFont(TOCA.Global.font, 10, "OUTLINE")
TOCA.ShowAgain[2]:SetPoint("CENTER", 0, -120)
TOCA.ShowAgain[2]:SetText('Type "toca /show" anytime to display this help message.')
TOCA.ShowAgain[2]:SetTextColor(0.7, 0.7, 0.6, 1)