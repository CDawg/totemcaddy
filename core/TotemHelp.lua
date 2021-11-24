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

local FrameHelp_w = 400
local FrameHelp_h = 264
TOCA.FrameHelp = CreateFrame("Frame", TOCA.FrameHelp, UIParent, "BackdropTemplate")
TOCA.FrameHelp:SetWidth(FrameHelp_w)
TOCA.FrameHelp:SetHeight(FrameHelp_h)
TOCA.FrameHelp:SetPoint("CENTER", 0, 100)
TOCA.FrameHelp:SetBackdrop(TOCA.Backdrop.General)
TOCA.FrameHelp:SetBackdropColor(0, 0, 0, 1)
TOCA.FrameHelp:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameHelp:SetFrameStrata("DIALOG")
TOCA.FrameHelp.text={}

TOCA.help={}
TOCA.TabWidth.Help = 110
TOCA.Button.Tab={}
TOCA.Button.TabBack={}
TOCA.HelpTabs = {
  "Updates",
  "Contact",
  "Credit",
}

TOCA.FrameHelpPage={}
for i=1, getn(TOCA.HelpTabs) do
  TOCA.FrameHelpPage[TOCA.HelpTabs[i]] = CreateFrame("Frame", "TOCA.FrameHelp", TOCA.FrameHelp, "BackdropTemplate")
  TOCA.FrameHelpPage[TOCA.HelpTabs[i]]:SetWidth(TOCA.FrameHelp:GetWidth())
  TOCA.FrameHelpPage[TOCA.HelpTabs[i]]:SetHeight(TOCA.FrameHelp:GetHeight())
  TOCA.FrameHelpPage[TOCA.HelpTabs[i]]:SetPoint("CENTER", 0, 0)

  TOCA.Button.TabBack[i]= CreateFrame("Button", nil, TOCA.FrameHelp, "BackdropTemplate")
  TOCA.Button.TabBack[i]:SetSize(TOCA.TabWidth.Help-20, 29)
  TOCA.Button.TabBack[i]:SetPoint("TOPLEFT", -80+i*92, 25)
  TOCA.Button.TabBack[i]:SetBackdrop({
    bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
    edgeFile= "",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  })
  TOCA.Button.Tab[i]= CreateFrame("Button", nil, TOCA.Button.TabBack[i], "BackdropTemplate")
  TOCA.Button.Tab[i]:SetSize(TOCA.TabWidth.Help, 32)
  TOCA.Button.Tab[i]:SetPoint("CENTER", 0, 0)
  TOCA.Button.Tab[i]:SetBackdrop({
    bgFile  = "Interface/OPTIONSFRAME/UI-OptionsFrame-ActiveTab",
    --edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeFile= "",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  })
  --TOCA.Button.Tab[i]:SetBackdropColor(0.7, 0, 0, 1)
  --TOCA.Button.Tab[i]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.Button.Tab[i].text = TOCA.Button.Tab[i]:CreateFontString(nil, "ARTWORK")
  TOCA.Button.Tab[i].text:SetFont(TOCA.Global.font, 12, "OUTLINE")
  TOCA.Button.Tab[i].text:SetPoint("CENTER", 0, 0)
  TOCA.Button.Tab[i].text:SetText(TOCA.HelpTabs[i])
  TOCA.Button.Tab[i]:SetScript("OnClick", function()
    for i=1, getn(TOCA.HelpTabs) do
      TOCA.Button.TabBack[i]:SetSize(TOCA.TabWidth.Help-20, 29)
    end
    TOCA.Button.TabBack[i]:SetSize(TOCA.TabWidth.Help-20, 31)
    if (TOCA.HelpTabs[i] == "Credit") then
      TOCA.TextFrame.text:SetText(arrayToString(TOCA.help.credit))
    elseif (TOCA.HelpTabs[i] == "Contact") then
      TOCA.TextFrame.text:SetText(arrayToString(TOCA.help.contact))
    else
      TOCA.TextFrame.text:SetText(arrayToString(TOCA.help.updates))
    end
  end)
end
TOCA.Button.TabBack[1]:SetSize(TOCA.TabWidth.Help-20, 30) --first tab

TOCA.help.updates = {
  "Welcome to " .. TOCA.Global.title .. "|r v" .. TOCA.Global.version .. "\n",
  "|cffffdf96Please note:|r Totem Caddy is still evolving. Improvements will be made as time continues. Enjoy!\n",
  "|cffffdf96New Feature:|r New Frame Style: Grid Vertical. Now you can view all totems on screen in vertical order based on totem category.",
  "Grid Horizontal and Freestyle coming soon!\n",
  "|cffffdf96First time using Totem Caddy?|r",
  "Let's get started by dragging the Totem Caddy anywhere on your screen saving the position.",
  "You can select totems in a category order (air, earth, fire, or water) by selecting the top arrows above the current totem icons.",
  "The set of totems are by default, and the order is currently alphabetical. The totem order can changed under the Totem Sets in the options window.",
  "For addition options or create totem sets:",
  "Select the cogwheel button or type /toca 'options', then select Totem Sets",
  "You can select which totem for each category, give it a name, then select the bottom arrow on the main frame dropdown to access it.",
  "Totem slot keybindings for your totem category slots. If you assign key bindings to to the totem slots for the very first time, you may\nhave to do a '/reload'.",
  "\n",
}
TOCA.help.contact = {
  "Please feel free to reach out and let me know what improvements can be made.\n",
  "|cffffdf96Curseforge:|r https://www.curseforge.com/wow/addons/totem-caddy/\n",
  "|cffffdf96Discord:|r https://discord.com/users/Porthios#8963\n",
  "|cffffdf96Github:|r https://github.com/CDawg/totemcaddy",
}
TOCA.help.credit = {
  "Special thanks to some beta testers from the Myzrael realm.",
  "Especially to my shaman buddy |cff006aa6Shockpopz|r of Myzrael For all the valuable feedback and laughs!\n\n\n\n\n\n\n\n\n\n",
  "Written by |cff006aa6Porthias|r of Myzrael (a.k.a. Port)",
}

TOCA.TextFrame_w = FrameHelp_w-20
TOCA.TextFrame_h = FrameHelp_h-10
--TOCA.TextFrame = CreateFrame("Frame", nil, TOCA.FrameHelpPage[TOCA.HelpTabs[1]])
TOCA.TextFrame = CreateFrame("Frame", nil, TOCA.FrameHelp)
TOCA.TextFrame:SetWidth(TOCA.TextFrame_w)
TOCA.TextFrame:SetHeight(TOCA.TextFrame_h)
TOCA.TextFrame:SetPoint("CENTER", 0, 20)
TOCA.TextFrame:SetFrameStrata("DIALOG")
TOCA.TextFrameScrollFrame={}
--TOCA.TextFrameScrollFrame = CreateFrame("Frame", TOCA.TextFrameScrollFrame, TOCA.TextFrame, "InsetFrameTemplate")
TOCA.TextFrameScrollFrame = CreateFrame("Frame", TOCA.TextFrameScrollFrame, TOCA.TextFrame, "BackdropTemplate")
TOCA.TextFrameScrollFrame:SetWidth(TOCA.TextFrame_w+10)
TOCA.TextFrameScrollFrame:SetHeight(TOCA.TextFrame_h-65)
TOCA.TextFrameScrollFrame:SetPoint("CENTER", 0, 0)
TOCA.TextFrameScrollFrame:SetBackdrop(TOCA.Backdrop.General)
TOCA.TextFrameScrollFrame:SetBackdropBorderColor(1, 1, 1, 0.4)
TOCA.TextFrameScrollFrame.Child = CreateFrame("ScrollFrame", nil, TOCA.TextFrameScrollFrame, "UIPanelScrollFrameTemplate")
TOCA.TextFrameScrollFrame.Child:SetPoint("TOPLEFT", TOCA.TextFrameScrollFrame, "TOPLEFT", 3, -3)
TOCA.TextFrameScrollFrame.Child:SetPoint("BOTTOMRIGHT", TOCA.TextFrameScrollFrame, "BOTTOMRIGHT", 10, 4)
TOCA.TextFrameScrollFrameChildFrame = CreateFrame("Frame", TOCA.TextFrameScrollFrameChildFrame, TOCA.TextFrameScrollFrame.Child)
TOCA.TextFrameScrollFrameChildFrame:SetSize(TOCA.TextFrame_w-40, TOCA.TextFrame_h)
TOCA.TextFrameScrollFrame.Child:SetScrollChild(TOCA.TextFrameScrollFrameChildFrame)
TOCA.TextFrameScrollFrame.Child.ScrollBar:ClearAllPoints()
TOCA.TextFrameScrollFrame.Child.ScrollBar:SetPoint("TOPLEFT", TOCA.TextFrameScrollFrame.Child, "TOPRIGHT", 0, -17)
TOCA.TextFrameScrollFrame.Child.ScrollBar:SetPoint("BOTTOMRIGHT", TOCA.TextFrameScrollFrame.Child, "BOTTOMRIGHT", -42, 14)
TOCA.TextFrame.text = CreateFrame("EditBox", nil, TOCA.TextFrameScrollFrameChildFrame)
TOCA.TextFrame.text:SetWidth(TOCA.TextFrame_w-20)
TOCA.TextFrame.text:SetHeight(TOCA.TextFrame_h)
TOCA.TextFrame.text:SetFontObject(GameFontWhite)
TOCA.TextFrame.text:SetPoint("TOPLEFT", 4, -4)
TOCA.TextFrame.text:SetMultiLine(true)
TOCA.TextFrame.text:ClearFocus(self)
TOCA.TextFrame.text:SetAutoFocus(false)
TOCA.TextFrame.text:SetText(arrayToString(TOCA.help.updates))

TOCA.Button.CloseFrameHelp= CreateFrame("Button", nil, TOCA.FrameHelp, "BackdropTemplate")
TOCA.Button.CloseFrameHelp:SetSize(100, 25)
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

TOCA.ShowAgain={}
TOCA.ShowAgain[1] = TOCA.FrameHelp:CreateFontString(nil, "ARTWORK")
TOCA.ShowAgain[1]:SetFont(TOCA.Global.font, 10, "OUTLINE")
TOCA.ShowAgain[1]:SetPoint("CENTER", 0, -105)
TOCA.ShowAgain[1]:SetText("This message will not show again unless there is a new version.")
TOCA.ShowAgain[1]:SetTextColor(0.7, 0.7, 0.6, 1)
TOCA.ShowAgain[2] = TOCA.FrameHelp:CreateFontString(nil, "ARTWORK")
TOCA.ShowAgain[2]:SetFont(TOCA.Global.font, 10, "OUTLINE")
TOCA.ShowAgain[2]:SetPoint("CENTER", 0, -120)
TOCA.ShowAgain[2]:SetText('Type "toca /help" anytime to display this help message.')
TOCA.ShowAgain[2]:SetTextColor(0.7, 0.7, 0.6, 1)
