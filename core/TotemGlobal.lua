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
 version= 2.29,
 command= "toca",
 width  = 150,
 height = 85,
 font   = "Fonts/FRIZQT__.TTF",
 dir    = "Interface/Addons/TotemCaddy/",
 prefix = "TotemCaddy",
}

TOCA.Prefix = {
  version = "0xEFVe",
}

TCCMD = "/"..TOCA.Global.command

TOCA.Backdrop={}
TOCA.Backdrop.General = { --also used for gray out
  bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
}

TOCA.Backdrop.Main = { --also used for gray out
  bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
  edgeFile= "Interface/TUTORIALFRAME/TUTORIALFRAMEBORDER",
  edgeSize= 20,
  insets  = {left=2, right=2, top=2, bottom=2},
}

TOCA.Backdrop.empty= { --also used for gray out
  bgFile  = "",
  edgeFile= "",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
}

TOCA.Backdrop.highlight = {
  bgFile  = "Interface/Buttons/ButtonHilight-Square",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
}

TOCA.Backdrop.Button = {
  bgFile  = "Interface/Buttons/GoldGradiant",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
}

TOCA.Backdrop.RGB = {
  bgFile  = "Interface/Tooltips/UI-Tooltip-Background",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
}

TOCA.Backdrop.BorderOnly= { --also used for gray out
  bgFile  = "",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
}

TOCA.version_alerted = 0
TOCA.Button={}
TOCA.Checkbox={}
TOCA.Slider={}
TOCA.Prompt={}
TOCA.Dropdown = {}
TOCA.Dropdown.Menu = {"Default"}
TOCA.Tooltip = {}

TOCA.MenuIsOpenMain = 0
TOCA.MenuIsOpenSets = 0

TOCA.Slot_w=35
TOCA.Slot_h=35
TOCA.Slot_x=-TOCA.Slot_w/2

--defaults
TOCASlotAIR  = "Grace of Air Totem"
TOCASlotEARTH= "Stoneclaw Totem"
TOCASlotFIRE = "Magma Totem"
TOCASlotWATER= "Mana Spring Totem"

function TOCA.Round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function TOCA.UpdateTotemSet()
  local totemIconKey = multiKeyFromValue(TOCA.totems.AIR,  TOCASlotAIR, 1)
  local totemIcon = {
    bgFile  = "interface/icons/" .. TOCA.totems.AIR[totemIconKey][2],
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  }
  TOCA.Slot["AIR"]:SetBackdrop(totemIcon)
  TOCA.FrameSetsSlot["AIR"]:SetBackdrop(totemIcon)

  local totemIconKey = multiKeyFromValue(TOCA.totems.EARTH,  TOCASlotEARTH, 1)
  local totemIcon = {
    bgFile  = "interface/icons/" .. TOCA.totems.EARTH[totemIconKey][2],
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  }
  TOCA.Slot["EARTH"]:SetBackdrop(totemIcon)
  TOCA.FrameSetsSlot["EARTH"]:SetBackdrop(totemIcon)

  local totemIconKey = multiKeyFromValue(TOCA.totems.FIRE,  TOCASlotFIRE, 1)
  local totemIcon = {
    bgFile  = "interface/icons/" .. TOCA.totems.FIRE[totemIconKey][2],
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  }
  TOCA.Slot["FIRE"]:SetBackdrop(totemIcon)
  TOCA.FrameSetsSlot["FIRE"]:SetBackdrop(totemIcon)

  local totemIconKey = multiKeyFromValue(TOCA.totems.WATER,  TOCASlotWATER, 1)
  local totemIcon = {
    bgFile  = "interface/icons/" .. TOCA.totems.WATER[totemIconKey][2],
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  }
  TOCA.Slot["WATER"]:SetBackdrop(totemIcon)
  TOCA.FrameSetsSlot["WATER"]:SetBackdrop(totemIcon)
end

TOCA.SlotSelectTotemDisabled={}
TOCA.FrameSetsSlotDisabled={}
for totemCat,v in pairsByKeys(TOCA.totems) do
  TOCA.SlotSelectTotemDisabled[totemCat]={}
  TOCA.FrameSetsSlotDisabled[totemCat]={}
end

function TOCA.EnableKnownTotems()
  for totemCat,v in pairsByKeys(TOCA.totems) do
    for i,totemSpell in pairs(TOCA.totems[totemCat]) do
      --TOCA.SlotSelectTotemDisabled[totemCat][i]:Show()
      --TOCA.FrameSetsSlotDisabled[totemCat][i]:Show()
      local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(totemSpell[1])
      if (name) then
        --print(name)
        TOCA.SlotSelectTotemDisabled[totemCat][i]:Hide()
        TOCA.FrameSetsSlotDisabled[totemCat][i]:Hide()
      end
    end
  end
  --print("TOCA.EnableKnownTotems()")
end

function TOCA.Init()
  local lC, eC, cI = UnitClass("player")
  TOCA.FrameMain:Hide()
  if (eC == "SHAMAN") then
    TOCA.FrameMain:Show()
  else
    TOCA.FrameHelp:Hide()
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
      TOCADB[TOCA.player.combine]["LASTSAVED"] = TOCA.Dropdown.Menu[1]
    end
    if (TOCADB[TOCA.player.combine]["DISABLED"] == nil) then
      TOCADB[TOCA.player.combine]["DISABLED"] = "NO"
    end
    if (TOCADB[TOCA.player.combine]["HELP"] == nil) then
      TOCADB[TOCA.player.combine]["HELP"] = "YES"
    end
    print(TOCA.Global.title .. " Building Profile: " .. TOCA.player.combine)
    TOCADB[TOCA.player.combine]["PROFILES"][TOCA.Dropdown.Menu[1]] = {TOCA_AIR=TOCASlotAIR, TOCA_EARTH=TOCASlotEARTH, TOCA_FIRE=TOCASlotFIRE, TOCA_WATER=TOCASlotWATER}
    TOCA.UpdateTotemSet()
  else
    print(TOCA.Global.title .. " Loading Profile: " .. TOCA.player.combine)
    if (TOCADB[TOCA.player.combine]["DISABLED"] == "YES") then
      TOCA.FrameMain:Hide()
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["SCALE"]) then
      TOCA.Slider.Scale:SetValue(TOCADB[TOCA.player.combine]["CONFIG"]["SCALE"])
      TOCA.Slider.Scale.Val:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["SCALE"])
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["MAINMENU"] == "OFF") then
      TOCA.FrameMain.Background:SetBackdrop(TOCA.Backdrop.General)
      TOCA.Button.CloseMain:Hide()
      TOCA.Button.Options:Hide()
      TOCA.Checkbox.MainMenu:SetChecked(nil)
      TOCA.FrameMain.Background:SetPoint("CENTER", 0, 0)
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["ENDCAPS"] == "OFF") then
      TOCA.Button.TotemicCall.ECL:Hide()
      TOCA.Button.TotemicCall.ECR:Hide()
      TOCA.Checkbox.EndCaps:SetChecked(nil)
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["OPACITY"]) then
      TOCA.Slider.Opacity:SetValue(TOCADB[TOCA.player.combine]["CONFIG"]["OPACITY"])
      TOCA.Slider.Opacity.Val:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["OPACITY"])
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMELEVEL"]) then
      TOCA.FrameMain:SetFrameStrata(TOCADB[TOCA.player.combine]["CONFIG"]["FRAMELEVEL"])
      TOCA.Dropdown.FrameStrat.text:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["FRAMELEVEL"])
    end
    if (TOCADB[TOCA.player.combine]["LASTSAVED"]) then
      TOCA.SetDDMenu(TOCA.Dropdown.Main, TOCADB[TOCA.player.combine]["LASTSAVED"])
      TOCA.FrameSetsProfile:SetText(TOCADB[TOCA.player.combine]["LASTSAVED"])
    end
    if (TOCADB[TOCA.player.combine]["HELP"] == TOCA.Global.version) then
      TOCA.FrameHelp:Hide()
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["MAINPOS"]) then
      local TOCAFrameMainPos = {}
      TOCAFrameMainPos = split(TOCADB[TOCA.player.combine]["CONFIG"]["MAINPOS"], ",")
      TOCA.FrameMain:ClearAllPoints()
      TOCA.FrameMain:SetPoint(TOCAFrameMainPos[1], tonumber(TOCAFrameMainPos[2]), tonumber(TOCAFrameMainPos[3]))
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["EXPLODEPOS"]) then
      local TOCAFrameExplodePos = {}
      TOCAFrameExplodePos = split(TOCADB[TOCA.player.combine]["CONFIG"]["EXPLODEPOS"], ",")
      TOCA.FrameExplode:ClearAllPoints()
      TOCA.FrameExplode:SetPoint(TOCAFrameExplodePos[1], tonumber(TOCAFrameExplodePos[2]), tonumber(TOCAFrameExplodePos[3]))
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["TOOLPOS"]) then
      local TOCAFrameToolPos = {}
      TOCAFrameToolPos = split(TOCADB[TOCA.player.combine]["CONFIG"]["TOOLPOS"], ",")
      TOCA.Tooltip:ClearAllPoints()
      TOCA.Tooltip:SetPoint(TOCAFrameToolPos[1], tonumber(TOCAFrameToolPos[2]), tonumber(TOCAFrameToolPos[3]))
    end
    TOCA.UpdateTotemSet()
    TOCA.UpdateDDMenu(TOCA.Dropdown.Main)
    TOCA.UpdateDDMenu(TOCA.Dropdown.Sets)
  end
end

function TOCA.SetDDMenu(DDFrame, value)
  --print("DD " .. value)
  if (TOCADB[TOCA.player.combine]["PROFILES"][value]) then
    for k,v in pairs(TOCADB[TOCA.player.combine]["PROFILES"][value]) do
      --print("debug profile " .. k)
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
  end
  --just update both
  TOCA.Dropdown.Main.text:SetText(value)
  TOCA.Dropdown.Sets.text:SetText(value)
  TOCADB[TOCA.player.combine]["LASTSAVED"] = value
  TOCA.UpdateTotemSet()
  --print("TOCA.SetDDMenu " .. value)
end

function TOCA.UpdateDDMenu(DDFrame, value)
  local DDArray = {TOCA.Dropdown.Menu[1]}
  for k,v in pairs(TOCADB[TOCA.player.combine]["PROFILES"]) do
    if (k ~= TOCA.Dropdown.Menu[1]) then
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
    TOCA.Dropdown.Main.text:SetText(value)
    TOCA.Dropdown.Sets.text:SetText(value)
  end
end

function TOCA.CloseAllMenus()
  for k,v in pairs(TOCA.totems) do
    TOCA.SlotSelectMenu[k]:Hide()
    TOCA.FrameSetsSlotSelectMenu[k]:Hide()
  end
  TOCA.Tooltip:Hide()
end

local TooltipMaxHeight = 82
TOCA.Tooltip = CreateFrame("frame", "TOCA.Tooltip", UIParent, "BackdropTemplate")
TOCA.Tooltip:SetWidth(260)
TOCA.Tooltip:SetHeight(TooltipMaxHeight)
TOCA.Tooltip:SetFrameStrata("TOOLTIP")
TOCA.Tooltip:SetBackdrop(TOCA.Backdrop.General)
TOCA.Tooltip:SetBackdropColor(0, 0, 1, 1)
TOCA.Tooltip:SetBackdropBorderColor(1, 1, 1, 1)
TOCA.Tooltip:SetPoint("BOTTOMRIGHT", -160, 150)
TOCA.Tooltip:SetMovable(true)
TOCA.Tooltip:EnableMouse(true)
TOCA.Tooltip:RegisterForDrag("LeftButton")
TOCA.Tooltip:SetScript("OnDragStart", function()
  TOCA.Tooltip:StartMoving()
end)
TOCA.Tooltip:SetScript("OnDragStop", function()
  TOCA.Tooltip:StopMovingOrSizing()
  local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.Tooltip:GetPoint()
  TOCADB[TOCA.player.combine]["CONFIG"]["TOOLPOS"] = point .. "," .. xOfs .. "," .. yOfs
end)
TOCA.Tooltip.title = TOCA.Tooltip:CreateFontString(nil, "ARTWORK")
TOCA.Tooltip.title:SetFont(TOCA.Global.font, 14)
TOCA.Tooltip.title:SetPoint("TOPLEFT", 10, -10)
TOCA.Tooltip.title:SetText("")
TOCA.Tooltip.tools = TOCA.Tooltip:CreateFontString(nil, "ARTWORK")
TOCA.Tooltip.tools:SetFont(TOCA.Global.font, 12)
TOCA.Tooltip.tools:SetPoint("TOPLEFT", 12, -30)
TOCA.Tooltip.tools:SetText("")
TOCA.Tooltip.text = TOCA.Tooltip:CreateFontString(nil, "ARTWORK")
TOCA.Tooltip.text:SetFont(TOCA.Global.font, 12)
TOCA.Tooltip.text:SetPoint("TOPLEFT", 12, -50)
TOCA.Tooltip.text:SetText("")
TOCA.Tooltip.text:SetTextColor(1, 1, 0.2, 1)
TOCA.Tooltip:Hide()

local function adjustTooltipHeight(s, x, indent)
  x = x or 79
  indent = indent or ""
  local t = {""}
  local function cleanse(s) return s:gsub("@x%d%d%d",""):gsub("@r","") end
  for prefix, word, suffix, newline in s:gmatch("([ \t]*)(%S*)([ \t]*)(\n?)") do
    if (#t >= 2) then
      TOCA.Tooltip:SetHeight(TooltipMaxHeight + (8 * #t))
    end
    if #(cleanse(t[#t])) + #prefix + #cleanse(word) > x and #t > 0 then
      table.insert(t, word..suffix)
    else
      t[#t] = t[#t]..prefix..word..suffix
    end
    if #newline > 0 then
      table.insert(t, "")
    end
  end
  return indent..table.concat(t, "\n"..indent)
end

function TOCA.TooltipDisplay(msg, tools, msgtooltip)
  TOCA.Tooltip:Show()
  TOCA.Tooltip:SetHeight(TooltipMaxHeight)
  TOCA.Tooltip.title:SetText(msg)
  local toolsMsg = tools.lower(tools)
  toolsMsg = firstToUpper(toolsMsg)
  TOCA.Tooltip.tools:SetText("Tools: " .. toolsMsg .. " Totem")
  if (tools == "") then
    TOCA.Tooltip.tools:SetText("")
  end
  TOCA.Tooltip.text:SetText(adjustTooltipHeight(msgtooltip, 34))
  TOCA.Tooltip:Show()
end

--TOCA.HasTotemOut = 0
TOCA.TotemPresent={}
TOCA.TotemName={}
TOCA.TotemStartTime={}
TOCA.TotemDuration={}
function TOCA.TotemBarUpdate()
  --local playerPos = GetUnitSpeed("player")
  local percMana = (UnitPower("player")/UnitPowerMax("player"))*100
  local percMana = floor(percMana+0.5)
  --print("mana: " .. percMana)
  --Fire = 1 Earth = 2 Water = 3 Air = 4
  TOCA.Button.TotemicCall.flash:Hide()
  for totemCat,v in pairsByKeys(TOCA.totems) do
    TOCA.Slot.deactive[totemCat]:Hide()
    if (percMana <= 3) then
      TOCA.Slot.deactive[totemCat]:Show()
    end
  end

  for i=1, 4 do
    TOCA.TotemPresent[i], TOCA.TotemName[i], TOCA.TotemStartTime[i], TOCA.TotemDuration[i] = GetTotemInfo(i)
    if (TOCA.TotemPresent[i]) then
      TOCA.Button.TotemicCall.flash:Show()
      --TOCA.TotemStartTime[i]
    end
  end
end

function TOCA.ChatNotification(msg)
  print(TOCA.Global.title .. " " .. msg)
end

function TOCA.SendPacket(packet, filtered, rec)
  filteredPacket = nil
  local msg_to = "GUILD"
  if (rec) then
    msg_to = rec
  end
  if (filtered) then
    filteredPacket = packet:gsub("%s+", "") --filter spaces
  else
    filteredPacket = packet
  end
  C_ChatInfo.SendAddonMessage(TOCA.Global.prefix, filteredPacket, msg_to)
  --print("sending packet " .. filteredPacket)
end

function TOCA.ParsePacket(netpacket, code)
  if (netpacket) then
    if (string.sub(netpacket, 1, strlen(code)) == code) then
      parse = string.gsub(netpacket, code, "")
      return parse
    end
  end
end

function TOCA.BuildTotemOrder()
  for totemCat,v in pairsByKeys(TOCA.totems) do
    print(TOCA.Dropdown.OrderSet[totemCat].text:GetText())
  end
end

SLASH_TOCA1 = TCCMD
function SlashCmdList.TOCA(cmd)
  if ((cmd == nil) or (cmd == "")) then
    print(TOCA.Global.title .. " v" .. TOCA.Global.version)
    print("Commands:")
    print("|cffffff00options:|r Open Totem Caddy Options.")
    print("|cffffff00show:|r Display Totem Caddy (regardless of class).")
    print("|cffffff00hide:|r Close Totem Caddy.")
    print("|cffffff00profile:|r Display the current saved profile.")
    print("|cffffff00help:|r Display the help introduction.")
  elseif (cmd == "show") then
    TOCA.FrameMain:Show()
    TOCADB[TOCA.player.combine]["DISABLED"] = "NO"
  elseif (cmd == "hide") then
    TOCA.FrameMain:Hide()
  elseif (cmd == "sets") then
    TOCA.FrameSets:Show()
  elseif (cmd == "profile") then
    print(TOCA.Global.title .. "|r Profile: " .. TOCA.player.combine)
  elseif ((cmd == "options") or (cmd == "config")) then
    TOCA.FrameOptions:Show()
  elseif (cmd == "help") then
    TOCA.FrameHelp:Show()
  end
end
