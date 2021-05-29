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

TOCAGlobal = {
 title  = "|cff006aa6Totem Caddy|r",
 author = "Porthios of Myzrael",
 version= 2.44,
 command= "toca",
 width  = 200,
 height = 90,
 font   = "Fonts/FRIZQT__.TTF",
}
TCCMD = "/"..TOCAGlobal.command

TOCABackdrop={}
TOCABackdrop.General = {
  bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
}

TOCABackdrop.Button= {
  bgFile  = "Interface/Buttons/GoldGradiant",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
}

function TOCAInit()
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
    if (TOCADB[TOCAPlayer.combine]["PROFILES"] == nil) then
      TOCADB[TOCAPlayer.combine]["PROFILES"] = {}
    end
    print(TOCAGlobal.title .. " Building Profile: " .. TOCAPlayer.combine)
  end
  --print(TOCAGlobal.title .. " Loading Profile: " .. TOCAPlayer.combine)
  --[==[
  for k,v in pairs(totems) do
    print(k)
    for totemBreak,totemSpell in pairs(totems[k]) do
      --print(totemSpell[1])
    end
  end
  ]==]--
  print("TOCAInit()")
end

function TOCACloseAllMenus()
  for k,v in pairs(TOCATotems) do
    TOCAFrameOptionsSlotSelectMenu[k]:Hide()
  end
end

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
