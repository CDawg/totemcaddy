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

TOCA.Global = {
 title  = "|cff006aa6Totem Caddy|r",
 author = "Porthios of Myzrael",
 version= 2.44,
 command= "toca",
 width  = 200,
 height = 90,
 font   = "Fonts/FRIZQT__.TTF",
}
TCCMD = "/"..TOCA.Global.command

TOCA.Backdrop={}
TOCA.Backdrop.General = {
  bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
}

TOCA.Backdrop.Button= {
  bgFile  = "Interface/Buttons/GoldGradiant",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
}

--defaults
TOCASlotAIR  = "Grace of Air Totem"
TOCASlotEARTH= "Stoneclaw Totem"
TOCASlotFIRE = "Magma Totem"
TOCASlotWATER= "Mana Spring Totem"

function TOCA.Init()
  local lC, eC, cI = UnitClass("player")
  TOCA.FrameMain:Hide()
  if (eC == "SHAMAN") then
    TOCA.FrameMain:Show()
  end
  if (TOCADB == nil) then
    TOCADB = {}
  end
  if (TOCADB[TOCA.Player.combine] == nil) then
    TOCADB[TOCA.Player.combine] = {}
    if (TOCADB[TOCA.Player.combine]["CONFIG"] == nil) then
      TOCADB[TOCA.Player.combine]["CONFIG"] = {}
    end
    if (TOCADB[TOCA.Player.combine]["PROFILES"] == nil) then
      TOCADB[TOCA.Player.combine]["PROFILES"] = {}
    end
    print(TOCA.Global.title .. " Building Profile: " .. TOCA.Player.combine)
  else
    print(TOCA.Global.title .. " Loading Profile: " .. TOCA.Player.combine)
  end
  --[==[
  for k,v in pairs(totems) do
    print(k)
    for totemBreak,totemSpell in pairs(totems[k]) do
      --print(totemSpell[1])
    end
  end
  ]==]--
  --print("TOCA.Init()")

end

function TOCA.CloseAllMenus()
  for k,v in pairs(TOCA.Totems) do
    TOCA.FrameOptionsSlotSelectMenu[k]:Hide()
  end
end

SLASH_TOCA1 = TCCMD
function SlashCmdList.TOCA(cmd)
  if ((cmd == nil) or (cmd == "")) then
    print(TOCA.Global.title .. " commands:")
    print("show = display Totem Caddy (regardless of class)")
    print("hide = close Totem Caddy")
    print("profile = display the current saved profile")
    print("config = open Totem Caddy options")
  end
  if (cmd == "show") then
    TOCA.FrameMain:Show()
  end
  if (cmd == "hide") then
    TOCA.FrameMain:Hide()
  end
  if (cmd == "config") then
    TOCA.FrameOptions:Show()
  end
end
