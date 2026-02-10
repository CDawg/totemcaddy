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

TOCA.CREDIT = {
  "Shockpopz",
  "SteveBotella",
  "WolfLove",
  "Torfear",
	"knarfde",
  "|nAnd a few nameless heroes on Classic Myzrael|n",
  "Written by |cff006aa6Porthias|r (a.k.a. Port)",
}
TOCA.CONTACT = {
  "|n|cffffdf96Curseforge:|r https://www.curseforge.com/wow/addons/totem-caddy/",
  "|n|cffffdf96Discord:|r https://discordapp.com/users/238146303324979200",
}
table.merge(TOCA._L.INTRO[3], TOCA.CONTACT)
table.merge(TOCA._L.INTRO[4], TOCA.CREDIT)

TOCA.FrameHelp_w = 500
TOCA.FrameHelp_h = 350
TOCA.FrameHelp = CreateFrame("Frame", TOCA.FrameHelp, UIParent, "BackdropTemplate")
TOCA.FrameHelp:SetWidth(TOCA.FrameHelp_w)
TOCA.FrameHelp:SetHeight(TOCA.FrameHelp_h)
TOCA.FrameHelp:SetPoint("CENTER", 0, 50)
TOCA.FrameHelp:SetBackdrop(TOCA.Backdrop.General)
TOCA.FrameHelp:SetBackdropColor(0, 0, 0, 1)
TOCA.FrameHelp:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.FrameHelp:SetFrameStrata("DIALOG")
TOCA.FrameHelp.text={}

TOCA.TabWidth.Help = 140
TOCA.Button.Tab={}
TOCA.Button.TabBack={}
TOCA.FrameHelpPage={}

for i=1, getn(TOCA._L.UI.TABS.HELP) do
  TOCA.FrameHelpPage[TOCA._L.UI.TABS.HELP[i]] = CreateFrame("Frame", "TOCA.FrameHelp", TOCA.FrameHelp, "BackdropTemplate")
  TOCA.FrameHelpPage[TOCA._L.UI.TABS.HELP[i]]:SetWidth(TOCA.FrameHelp:GetWidth())
  TOCA.FrameHelpPage[TOCA._L.UI.TABS.HELP[i]]:SetHeight(TOCA.FrameHelp:GetHeight())
  TOCA.FrameHelpPage[TOCA._L.UI.TABS.HELP[i]]:SetPoint("CENTER", 0, 0)

  TOCA.Button.TabBack[i]= CreateFrame("Button", nil, TOCA.FrameHelp, "BackdropTemplate")
  TOCA.Button.TabBack[i]:SetSize(TOCA.TabWidth.Help-20, 29)
  TOCA.Button.TabBack[i]:SetPoint("TOPLEFT", -110+i*120, 25)
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
  TOCA.Button.Tab[i].text:SetFont(TOCA._G.font, 12, "OUTLINE")
  TOCA.Button.Tab[i].text:SetPoint("CENTER", 0, 0)
  TOCA.Button.Tab[i].text:SetText(TOCA._L.UI.TABS.HELP[i])
  TOCA.Button.Tab[i]:SetScript("OnClick", function()
    for i=1, getn(TOCA._L.UI.TABS.HELP) do
      TOCA.Button.TabBack[i]:SetSize(TOCA.TabWidth.Help-20, 29)
    end
    TOCA.Button.TabBack[i]:SetSize(TOCA.TabWidth.Help-20, 31)

    if (TOCA._L.UI.TABS.HELP[i] == TOCA._L.UI.TABS.HELP[i]) then
      TOCA.TextFrame.text:SetText(arrayToString(TOCA._L.INTRO[i]):gsub(">", "|cfffab734>|r"))
      if (i == 1) then
        TOCA.TextFrame.text:SetText(TOCA.INTROLOG)
      end
    end
  end)
end
TOCA.Button.TabBack[1]:SetSize(TOCA.TabWidth.Help-20, 30) --first tab

TOCA.FrameHelp.Header = TOCA.FrameHelp:CreateFontString(nil, "ARTWORK")
TOCA.FrameHelp.Header:SetFont(TOCA._G.font, 12, "OUTLINE")
TOCA.FrameHelp.Header:SetPoint("TOPLEFT", 10, -15)
TOCA.FrameHelp.Header:SetText(TOCA._L.INIT[5].. " " .. TOCA._G.title .. " " .. TOCA.Addon)

TOCA.TextFrame_w = TOCA.FrameHelp_w-20
TOCA.TextFrame_h = TOCA.FrameHelp_h-50
TOCA.TextFrame = CreateFrame("Frame", nil, TOCA.FrameHelp)
TOCA.TextFrame:SetWidth(TOCA.TextFrame_w)
TOCA.TextFrame:SetHeight(TOCA.TextFrame_h)
TOCA.TextFrame:SetPoint("CENTER", 0, 20)
TOCA.TextFrame:SetFrameStrata("DIALOG")
TOCA.TextFrameScrollFrame={}
--TOCA.TextFrameScrollFrame = CreateFrame("Frame", TOCA.TextFrameScrollFrame, TOCA.TextFrame, "InsetFrameTemplate")
TOCA.TextFrameScrollFrame = CreateFrame("Frame", TOCA.TextFrameScrollFrame, TOCA.TextFrame, "BackdropTemplate")
TOCA.TextFrameScrollFrame:SetWidth(TOCA.TextFrame_w+10)
TOCA.TextFrameScrollFrame:SetHeight(TOCA.TextFrame_h-60)
TOCA.TextFrameScrollFrame:SetPoint("CENTER", 0, 0)
TOCA.TextFrameScrollFrame:SetBackdrop(TOCA.Backdrop.General)
TOCA.TextFrameScrollFrame:SetBackdropColor(0, 0, 0, 1)
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
TOCA.TextFrame.text:SetText(arrayToString(TOCA._L.INTRO[1]))

TOCA.Button.CloseFrameHelp= CreateFrame("Button", nil, TOCA.FrameHelp, "BackdropTemplate")
TOCA.Button.CloseFrameHelp:SetSize(100, 25)
TOCA.Button.CloseFrameHelp:SetPoint("CENTER", 0, -TOCA.FrameHelp_h/2+20)
TOCA.Button.CloseFrameHelp:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.CloseFrameHelp:SetBackdropColor(0.7, 0, 0, 1)
TOCA.Button.CloseFrameHelp:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.CloseFrameHelp.text = TOCA.Button.CloseFrameHelp:CreateFontString(nil, "ARTWORK")
TOCA.Button.CloseFrameHelp.text:SetFont(TOCA._G.font, 12, "OUTLINE")
TOCA.Button.CloseFrameHelp.text:SetPoint("CENTER", 0, 0)
TOCA.Button.CloseFrameHelp.text:SetText(TOCA._L.UI.BUTTON[1])
TOCA.Button.CloseFrameHelp:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 1)
end)
TOCA.Button.CloseFrameHelp:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.Button.CloseFrameHelp:SetScript("OnClick", function()
  TOCA.FrameHelp:Hide()
  TOCADB[TOCA.player.combine]["HELP"] = TOCA._G.version
end)

TOCA.ShowAgain = TOCA.FrameHelp:CreateFontString(nil, "ARTWORK")
TOCA.ShowAgain:SetFont(TOCA._G.font, 10, "OUTLINE")
TOCA.ShowAgain:SetPoint("CENTER", 0, -TOCA.FrameHelp_h/2+60)
TOCA.ShowAgain:SetText(arrayToString(TOCA._L.INTRO[5]))
TOCA.ShowAgain:SetTextColor(0.7, 0.7, 0.6, 1)
