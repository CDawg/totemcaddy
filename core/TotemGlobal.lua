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
 version= 2.15,
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

function TOCA.UpdateTotemSet()
  local totemIconKey = multiKeyFromValue(TOCA.totems.AIR,  TOCASlotAIR, 1)
  local totemIcon = {
    bgFile  = "interface/icons/" .. TOCA.totems.AIR[totemIconKey][2],
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  }
  TOCA.Slot["AIR"]:SetBackdrop(totemIcon)
  TOCA.FrameOptionsSlot["AIR"]:SetBackdrop(totemIcon)

  local totemIconKey = multiKeyFromValue(TOCA.totems.EARTH,  TOCASlotEARTH, 1)
  local totemIcon = {
    bgFile  = "interface/icons/" .. TOCA.totems.EARTH[totemIconKey][2],
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  }
  TOCA.Slot["EARTH"]:SetBackdrop(totemIcon)
  TOCA.FrameOptionsSlot["EARTH"]:SetBackdrop(totemIcon)

  local totemIconKey = multiKeyFromValue(TOCA.totems.FIRE,  TOCASlotFIRE, 1)
  local totemIcon = {
    bgFile  = "interface/icons/" .. TOCA.totems.FIRE[totemIconKey][2],
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  }
  TOCA.Slot["FIRE"]:SetBackdrop(totemIcon)
  TOCA.FrameOptionsSlot["FIRE"]:SetBackdrop(totemIcon)

  local totemIconKey = multiKeyFromValue(TOCA.totems.WATER,  TOCASlotWATER, 1)
  local totemIcon = {
    bgFile  = "interface/icons/" .. TOCA.totems.WATER[totemIconKey][2],
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  }
  TOCA.Slot["WATER"]:SetBackdrop(totemIcon)
  TOCA.FrameOptionsSlot["WATER"]:SetBackdrop(totemIcon)
end

function TOCA.Init()
  local lC, eC, cI = UnitClass("player")
  TOCA.FrameMain:Hide()
  if (eC == "SHAMAN") then
    TOCA.FrameMain:Show()
  end
  if (TOCADB == nil) then
    TOCADB = {}
  end
  if (TOCADB[TOCA.player.combine] == nil) then
    TOCADB[TOCA.player.combine] = {}
    if (TOCADB[TOCA.player.combine]["CONFIG"] == nil) then
      TOCADB[TOCA.player.combine]["CONFIG"] = {}
    end
    if (TOCADB[TOCA.player.combine]["PROFILES"] == nil) then
      TOCADB[TOCA.player.combine]["PROFILES"] = {}
    end
    if (TOCADB[TOCA.player.combine]["LASTSAVED"] == nil) then
      TOCADB[TOCA.player.combine]["LASTSAVED"] = "Default"
    end
    print(TOCA.Global.title .. " Building Profile: " .. TOCA.player.combine)
    TOCADB[TOCA.player.combine]["PROFILES"]["Default"] = {TOCA_AIR=TOCASlotAIR, TOCA_EARTH=TOCASlotEARTH, TOCA_FIRE=TOCASlotFIRE, TOCA_WATER=TOCASlotWATER}
    TOCA.UpdateTotemSet()
  else
    print(TOCA.Global.title .. " Loading Profile: " .. TOCA.player.combine)
    if (TOCADB[TOCA.player.combine]["LASTSAVED"]) then
      print(TOCADB[TOCA.player.combine]["LASTSAVED"])
      TOCA.SetDDMenu(TOCA.DD.Main, TOCADB[TOCA.player.combine]["LASTSAVED"])
    end
    TOCA.UpdateTotemSet()
    TOCA.UpdateDDMenu(TOCA.DD.Main)
    TOCA.UpdateDDMenu(TOCA.DD.Options)
  end
end

function TOCA.SetDDMenu(DDFrame, value)
  print("DD " .. value)
  if (TOCADB[TOCA.player.combine]["PROFILES"][value]) then
    for k,v in pairs(TOCADB[TOCA.player.combine]["PROFILES"][value]) do
      print("debug profile " .. k)
      if (k == "TOCA_AIR") then
        TOCASlotAIR = v
        TOCA.Totem["AIR"]:SetAttribute("spell", v)
      end
      if (k == "TOCA_EARTH") then
        TOCASlotEARTH = v
        TOCA.Totem["EARTH"]:SetAttribute("spell", v)
      end
      if (k == "TOCA_FIRE") then
        TOCASlotFIRE = v
        TOCA.Totem["FIRE"]:SetAttribute("spell", v)
      end
      if (k == "TOCA_WATER") then
        TOCASlotWATER = v
        TOCA.Totem["WATER"]:SetAttribute("spell", v)
      end
    end
  --else --use the generic default values
  end
  --DDFrame.text:SetText(value)
  --just update both
  TOCA.DD.Main.text:SetText(value)
  TOCA.DD.Options.text:SetText(value)
  TOCADB[TOCA.player.combine]["LASTSAVED"] = value
  TOCA.UpdateTotemSet()
  print("TOCA.SetDDMenu " .. value)
end

--haveTotem, totemName, startTime, duration = GetTotemInfo(1 through 4)

function TOCA.UpdateDDMenu(DDFrame, value)
  local DDArray = {"Default"}
  for k,v in pairs(TOCADB[TOCA.player.combine]["PROFILES"]) do
    if (k ~= "Default") then
      table.insert(DDArray, k)
    end
  end
  DDFrame.initialize = function(self, level)
    local info = UIDropDownMenu_CreateInfo()
    local i = 0
    for k,v in pairs(DDArray) do
      info.notCheckable = 1
      info.padding = 2
      info.text = v
      info.value= v
      info.fontObject = GameFontWhite
      info.justifyH = "LEFT"
      info.disabled = false
      info.func = self.onClick
      UIDropDownMenu_AddButton(info, level)
    end
  end
  if (value) then
    TOCA.DD.Main.text:SetText(value)
    TOCA.DD.Options.text:SetText(value)
  end
end

function TOCA.CloseAllMenus()
  for k,v in pairs(TOCA.totems) do
    TOCA.FrameOptionsSlotSelectMenu[k]:Hide()
  end
end

_GTooltip = CreateFrame("frame", "_GTootlip", UIParent, "BackdropTemplate")
_GTooltip:SetWidth(50)
_GTooltip:SetHeight(24)
_GTooltip:SetPoint("TOPLEFT", 50, 0)
_GTooltip:SetBackdrop(TOCA.Backdrop.General)
_GTooltip:SetBackdropColor(0, 0, 0, 0.8)
_GTooltip:SetBackdropBorderColor(1, 1, 1, 0.8)
_GTooltip.text = _GTooltip:CreateFontString(nil, "ARTWORK")
_GTooltip.text:SetFont(TOCA.Global.font, 11)
_GTooltip.text:SetPoint("CENTER", 0, 0)
_GTooltip.text:SetText("Unknown")
_GTooltip:Hide()

function TOCA.tooltip(frame, msg)
  _GTooltip:Hide()
  if (frame) then
    local msglen = string.len (msg)
    _GTooltip:SetWidth(msglen*8)
    local point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint()
    -- = point .. "," .. xOfs .. "," .. yOfs
    _GTooltip:SetPoint(point, xOfs, yOfs)
    _GTooltip.text:SetText(msg)
    --if (display == "show") then
    _GTooltip:Show()
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
