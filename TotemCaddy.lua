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

local function TOCAInit()
  local lC, eC, cI = UnitClass("player")
  TOCAFrameMain:Hide()
  if (eC == "SHAMAN") then
    TOCAFrameMain:Show()
  end
  if (TOCADB == nil) then
    TOCADB = {}
  end
  if (TOCADB[TOCAPlayer.combine] == nil) then
    TOCADB[TOCAPlayer.combine] = {}
    if (TOCADB[TOCAPlayer.combine]["CONFIG"] == nil) then
      TOCADB[TOCAPlayer.combine]["CONFIG"] = {}
    end
  end
  --[==[
  for k,v in pairs(totems) do
    print(k)
    for totemBreak,totemSpell in pairs(totems[k]) do
      --print(totemSpell[1])
    end
  end
  ]==]--
end

local TOCAFrameMain = CreateFrame("Frame", "TOCAFrameMain", UIParent, "BackdropTemplate")
TOCAFrameMain:SetWidth(TOCAGlobal.width)
TOCAFrameMain:SetHeight(TOCAGlobal.height)
TOCAFrameMain:SetPoint("CENTER", 0, 0)
TOCAFrameMain:SetBackdrop({
  bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  tile    = true,
  insets  = {left=2, right=2, top=2, bottom=2},
})
TOCAFrameMain:SetBackdropColor(0, 0, 0, 0.8)
TOCAFrameMain:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCAFrameMain:SetMovable(true)
TOCAFrameMain:EnableMouse(true)
TOCAFrameMain:RegisterForDrag("LeftButton")
TOCAFrameMain:SetScript("OnDragStart", function()
  TOCAFrameMain:StartMoving()
end)
TOCAFrameMain:SetScript("OnDragStop", function()
  TOCAFrameMain:StopMovingOrSizing()
  local point, relativeTo, relativePoint, xOfs, yOfs = TOCAFrameMain:GetPoint()
  TOCADB[player.combine]["CONFIG"]["MAINPOS"] = point .. "," .. xOfs .. "," .. yOfs
end)
local TOCAMain = CreateFrame("Frame")
TOCAMain:RegisterEvent("ADDON_LOADED")
TOCAMain:RegisterEvent("PLAYER_LOGIN")
TOCAMain:RegisterEvent("PLAYER_ENTERING_WORLD")
TOCAMain:SetScript("OnEvent", function(self, event, prefix)
  if ((event == "ADDON_LOADED") and (prefix == "TotemCaddy")) then
    print(TOCAGlobal.title .. "|r " .. "v" .. TOCAGlobal.version .. " Initializing by " .. TOCAGlobal.author .. ". Type /" .. TOCAGlobal.command .. " for commands.")
    TOCAInit()
  end
end)

TOCASlot={}
TOCATotem={}
local TOCASlot_w=35
local TOCASlot_h=35
local TOCASlot_x=-TOCASlot_w/2
for totemCat,v in pairs(TOCATotems) do
  TOCASlot_x = TOCASlot_x +TOCASlot_w+5
  TOCASlot[totemCat]={}
  TOCASlot[totemCat]= CreateFrame("Button", nil, TOCAFrameMain, "BackdropTemplate")
  TOCASlot[totemCat]:SetSize(TOCASlot_w, TOCASlot_h)
  TOCASlot[totemCat]:SetPoint("TOPLEFT", TOCASlot_x, -25)
  TOCASlot[totemCat]:SetBackdrop({
    bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    tile    = true,
    insets  = {left=2, right=2, top=2, bottom=2},
  })
  TOCASlot[totemCat]:SetBackdropColor(0, 0, 0, 0.8)
  TOCASlot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCATotem[totemCat]={}
  TOCATotem[totemCat] = CreateFrame("Button", nil, TOCASlot[totemCat], "SecureActionButtonTemplate");
  TOCATotem[totemCat]:SetSize(TOCASlot_w, TOCASlot_h)
  TOCATotem[totemCat]:SetPoint("CENTER", 0, 0)
  TOCATotem[totemCat]:SetAttribute("type", "spell")
  TOCATotem[totemCat]:SetAttribute("spell", "Healing Stream Totem") -- default
  TOCATotem[totemCat]:SetScript("OnEnter", function()
    print(totemCat)
    TOCASlot[totemCat]:SetBackdropBorderColor(1, 1, 1, 1)
  end)
  TOCATotem[totemCat]:SetScript("OnLeave", function()
    TOCASlot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  end)
end

TOCACall_w=40
TOCACall_h=40
TOCACall= CreateFrame("Button", nil, TOCAFrameMain, "BackdropTemplate")
TOCACall:SetSize(TOCACall_w, TOCACall_h)
TOCACall:SetPoint("CENTER", 0, 42)
TOCACall:SetBackdrop({
  bgFile  = "Interface/ICONS/spell_unused",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
})
TOCACall:SetBackdropBorderColor(1, 1, 1, 0.5)
TOCACall.ECL = TOCACall:CreateTexture(nil, "ARTWORK")
TOCACall.ECL:SetSize(40, 40)
TOCACall.ECL:SetPoint("CENTER", 30, 20)
TOCACall.ECL:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Dwarf")
TOCACall.ECL:SetTexCoord(1, 0, 0, 1)
TOCACall.ECR = TOCACall:CreateTexture(nil, "ARTWORK")
TOCACall.ECR:SetSize(40, 40)
TOCACall.ECR:SetPoint("CENTER", -30, 20)
TOCACall.ECR:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Dwarf")

TOCACallAtt= CreateFrame("Button", nil, TOCACall, "SecureActionButtonTemplate");
TOCACallAtt:SetSize(TOCACall_w, TOCACall_h)
TOCACallAtt:SetPoint("CENTER", 0, 0)
TOCACallAtt:SetAttribute("type", "spell")
TOCACallAtt:SetAttribute("spell", "Totemic Call")
TOCACallAtt:SetScript("OnEnter", function()
  TOCACall:SetBackdropBorderColor(1, 1, 0.6, 1)
end)
TOCACallAtt:SetScript("OnLeave", function()
  TOCACall:SetBackdropBorderColor(1, 1, 1, 0.5)
end)

TOCABtnOpt= CreateFrame("Button", nil, TOCAFrameMain, "BackdropTemplate")
TOCABtnOpt:SetSize(18, 18)
TOCABtnOpt:SetPoint("TOPRIGHT", -18, -2)
TOCABtnOpt:SetBackdrop({
  bgFile  = "Interface/Buttons/RedGrad64",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  tile    = true,
  insets  = {left=4, right=4, top=4, bottom=4},
})
TOCABtnOpt:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCABtnOpt:SetBackdropColor(0.7, 0.7, 0.7, 1)
TOCABtnOpt.icon = TOCABtnOpt:CreateTexture(nil, "ARTWORK")
TOCABtnOpt.icon:SetSize(12, 12)
TOCABtnOpt.icon:SetPoint("CENTER", 0, 0)
TOCABtnOpt.icon:SetTexture("Interface/Buttons/UI-OptionsButton")
TOCABtnOpt:SetScript("OnClick", function()
  TOCAFrameOptions:Show()
end)
TOCABtnOpt:SetScript("OnEnter", function()
  TOCABtnOpt:SetBackdropBorderColor(1, 1, 1, 1)
end)
TOCABtnOpt:SetScript("OnLeave", function()
  TOCABtnOpt:SetBackdropBorderColor(1, 1, 1, 0.6)
end)

TOCABtnClose= CreateFrame("Button", nil, TOCAFrameMain, "BackdropTemplate")
TOCABtnClose:SetSize(18, 18)
TOCABtnClose:SetPoint("TOPRIGHT", -2, -2)
TOCABtnClose:SetBackdrop({
  bgFile  = "Interface/Buttons/RedGrad64",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  tile    = true,
  insets  = {left=3, right=3, top=3, bottom=3},
})
TOCABtnClose:SetBackdropColor(0.7, 0.7, 0.7, 1)
TOCABtnClose:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCABtnClose.icon = TOCABtnClose:CreateTexture(nil, "ARTWORK")
TOCABtnClose.icon:SetSize(12, 12)
TOCABtnClose.icon:SetPoint("CENTER", 0, 0)
TOCABtnClose.icon:SetTexture("Interface/Buttons/UI-StopButton")
TOCABtnClose:SetScript("OnEnter", function()
  TOCABtnClose:SetBackdropBorderColor(1, 1, 1, 1)
end)
TOCABtnClose:SetScript("OnLeave", function()
  TOCABtnClose:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCABtnClose:SetScript("OnClick", function()
  TOCAFrameMain:Hide()
  print(TOCAGlobal.title .. "|r closed. Type '"..TCCMD.." show' to reopen.")
end)

TOCAFrameOptions = CreateFrame("Frame", "TOCAFrameOptions", UIParent, "BackdropTemplate")
TOCAFrameOptions:SetWidth(300)
TOCAFrameOptions:SetHeight(200)
TOCAFrameOptions:SetPoint("CENTER", 0, 0)
TOCAFrameOptions:SetBackdrop({
  bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  tile    = true,
  insets  = {left=2, right=2, top=2, bottom=2},
})
TOCAFrameOptions:SetBackdropColor(0, 0, 0, 0.8)
TOCAFrameOptions:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCAFrameOptions.title = TOCAFrameOptions:CreateFontString(nil, "ARTWORK")
TOCAFrameOptions.title:SetFont(TOCAGlobal.font, 14, "OUTLINE")
TOCAFrameOptions.title:SetPoint("TOPLEFT", 10, -10)
TOCAFrameOptions.title:SetText(TOCAGlobal.title .. "|r Options  v" .. TOCAGlobal.version)
--TOCAFrameOptions.title:SetTextColor(0.8, 0.8, 0.8)
TOCAFrameOptions:Hide()

TOCAFrameOptionsBtnClose= CreateFrame("Button", nil, TOCAFrameOptions, "BackdropTemplate")
TOCAFrameOptionsBtnClose:SetSize(18, 18)
TOCAFrameOptionsBtnClose:SetPoint("TOPRIGHT", -2, -2)
TOCAFrameOptionsBtnClose:SetBackdrop({
  bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  tile    = true,
  insets  = {left=4, right=4, top=4, bottom=4},
})
TOCAFrameOptionsBtnClose:SetBackdropColor(1, 0.6, 0.6, 1)
TOCAFrameOptionsBtnClose:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCAFrameOptionsBtnClose.icon = TOCAFrameOptionsBtnClose:CreateTexture(nil, "ARTWORK")
TOCAFrameOptionsBtnClose.icon:SetSize(12, 12)
TOCAFrameOptionsBtnClose.icon:SetPoint("CENTER", 0, 0)
TOCAFrameOptionsBtnClose.icon:SetTexture("Interface/Buttons/UI-StopButton")
TOCAFrameOptionsBtnClose:SetScript("OnEnter", function()
  TOCAFrameOptionsBtnClose:SetBackdropBorderColor(1, 1, 1, 1)
end)
TOCAFrameOptionsBtnClose:SetScript("OnLeave", function()
  TOCAFrameOptionsBtnClose:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCAFrameOptionsBtnClose:SetScript("OnClick", function()
  TOCAFrameOptions:Hide()
end)

TOCAFrameOptionsSlot={}
TOCAFrameOptionsTotem={}
TOCASlotOptions_x = 0
for totemCat,v in ipairs(TOCATotems) do
  TOCASlotOptions_x = TOCASlotOptions_x + TOCASlot_w+4
  TOCAFrameOptionsSlot[totemCat]={}
  TOCAFrameOptionsSlot[totemCat]= CreateFrame("Button", nil, TOCAFrameOptions, "BackdropTemplate")
  TOCAFrameOptionsSlot[totemCat]:SetSize(TOCASlot_w, TOCASlot_h)
  TOCAFrameOptionsSlot[totemCat]:SetPoint("CENTER", -100+TOCASlotOptions_x, -50)
  TOCAFrameOptionsSlot[totemCat]:SetBackdrop({
    bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    tile    = true,
    insets  = {left=2, right=2, top=2, bottom=2},
  })
  TOCAFrameOptionsSlot[totemCat]:SetBackdropColor(0, 0, 0, 0.8)
  TOCAFrameOptionsSlot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCAFrameOptionsTotem[totemCat]={}
  TOCAFrameOptionsTotem[totemCat] = CreateFrame("Button", nil, TOCAFrameOptionsSlot[totemCat], "BackdropTemplate");
  TOCAFrameOptionsTotem[totemCat]:SetSize(TOCASlot_w, TOCASlot_h)
  TOCAFrameOptionsTotem[totemCat]:SetPoint("CENTER", 0, 0)
  TOCAFrameOptionsTotem[totemCat]:SetScript("OnEnter", function()
    TOCAFrameOptionsSlot[totemCat]:SetBackdropBorderColor(1, 1, 1, 1)
  end)
  TOCAFrameOptionsTotem[totemCat]:SetScript("OnLeave", function()
    TOCAFrameOptionsSlot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
  end)
end

TOCAFrameProfile = CreateFrame("EditBox", nil, TOCAFrameOptions, "BackdropTemplate")
TOCAFrameProfile:SetWidth(140)
TOCAFrameProfile:SetHeight(24)
TOCAFrameProfile:SetFontObject(GameFontWhite)
TOCAFrameProfile:SetBackdrop({
  bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
  insets  = {left=-2, right=6, top=2, bottom=2},
})
TOCAFrameProfile:SetBackdropColor(0, 0, 0, 1)
TOCAFrameProfile:SetPoint("CENTER", 0, -50)
TOCAFrameProfile:ClearFocus(self)
TOCAFrameProfile:SetAutoFocus(false)
TOCAFrameProfile.border = CreateFrame("Frame", nil, TOCAFrameProfile, "BackdropTemplate")
TOCAFrameProfile.border:SetWidth(140)
TOCAFrameProfile.border:SetHeight(24)
TOCAFrameProfile.border:SetPoint("TOPLEFT", -4, 0)
TOCAFrameProfile.border:SetBackdrop({
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  tile    = true,
  insets  = {left=2, right=2, top=2, bottom=2},
})

TOCADDMenu = {"Default"}
TOCADD = CreateFrame("Frame", nil, TOCAFrameMain, "UIDropDownMenuTemplate")
--TOCADD:SetFrameLevel(50)
TOCADD:SetPoint("CENTER", 0, -30)
--ddBossList[DNAInstance[i][1]].displayMode = "MENU"
TOCADD.text = TOCADD:CreateFontString(nil, "ARTWORK")
TOCADD.text:SetFont("Fonts\\FRIZQT__.TTF", 11)
TOCADD.text:SetPoint("TOPLEFT", TOCADD, "TOPLEFT", 25, -8)
TOCADD.text:SetText(TOCADDMenu[1])
TOCADD.onClick = function(self, checked)
  TOCADD.text:SetText(self.value)
  --print("click")
end
TOCADD.initialize = function(self, level)
  local info = UIDropDownMenu_CreateInfo()
  local i = 0
  for k,v in pairs(TOCADDMenu) do
    info.notCheckable = 1
    info.padding = 50
    info.text = v
    info.value= v
    info.fontObject = GameFontWhite
    info.justifyH = "LEFT"
    info.disabled = false
    info.func = self.onClick
    UIDropDownMenu_AddButton(info, level)
  end
end
UIDropDownMenu_SetWidth(TOCADD, TOCAGlobal.width-60)

SLASH_TOCA1 = TCCMD
function SlashCmdList.TOCA(cmd)
  if ((cmd == nil) or (cmd == "")) then
    print(TOCAGlobal.title .. " commands:")
    print("show = display Totem Caddy (regardless of class)")
    print("hide = close Totem Caddy")
    print("profile = display the current saved profile")
    print("config = open Totem Caddy options")
  end
  if (cmd == "show") then
    TOCAFrameMain:Show()
  end
  if (cmd == "hide") then
    TOCAFrameMain:Hide()
  end
  if (cmd == "config") then
    TOCAFrameOptions:Show()
  end
end
