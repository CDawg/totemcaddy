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

TOCA.DEBUG = true

TOCA._G = {
  title  = TOCA.colors.class[7][4] .. TOCA._L.TITLE .."|r",
  author = "Porthias",
  version= 3.08,
  CMD    = "/toca",
  width  = 150,
  height = 85,
  font   = "Interface/Addons/TotemCaddy/fonts/FRIZQT__.TTF",
  dir    = "Interface/Addons/TotemCaddy/",
  prefix = "TotemCaddy",
  suffix = "TBC",
  date   = date("%Y%m%d"),
  update = 20260208,
}
--local _LName, _LTitle = GetAddOnInfo(TOCA._G.prefix)
--TOCA._G.version = tonumber(string.sub(_LTitle, 26, 29))

TOCA.Game={}
TOCA.Game.version = tonumber(string.sub(__Gversion, 1, 1))
if (TOCA.Game.version == 1) then
  TOCA._G.suffix = "Classic"
end

TOCA.Net = {
  register  = C_ChatInfo.RegisterAddonMessagePrefix(TOCA._G.prefix),
  version   = "0xEFVe", --version
  assign_es = "0xEFES", --earthshield assign
  assign_au = "0xEFAU", --earthshield author
  report_s  = "0xEuRS",--report send signal
  report_g  = "0xEuRG",--report get signal
}

TOCA.OptionMenuOpen = 0
TOCA.ShamanShieldDuration = 10 --10 minutes on ALL shields
TOCA.NotificationAlertShield = 0
TOCA.NotificationAlertRadius = {}
for i=1, 4 do
	TOCA.NotificationAlertRadius[i] = 0
end

function TOCA.IdentifySpell(spellID) --used for different languages
  local spell = GetSpellInfo(spellID)
	if (spell) then return spell end
end

--build all totems for the respective language (rank 1)
TOCA._L.TOTEMS = {FIRE={}, EARTH={}, WATER={}, AIR={}}
for totemCat,v in pairsByKeys(TOCA.totems.ID) do
	for k,v in pairsByKeys(TOCA.totems.ID[totemCat]) do
		TOCA._L.TOTEMS[totemCat][k] = TOCA.IdentifySpell(TOCA.totems.ID[totemCat][k])
	end
end

TOCA._L.SPELLS.Reincarnation = TOCA.IdentifySpell(TOCA.spell.REINCARNATION)
TOCA._L.SPELLS.TotemicCall = TOCA.IdentifySpell(TOCA.spell.TOTEMIC_CALL)
TOCA._L.SPELLS.SHIELDS = {
	TOCA.IdentifySpell(TOCA.spell.WATER_SHIELD),
	TOCA.IdentifySpell(TOCA.spell.LIGHTNING_SHIELD),
	TOCA.IdentifySpell(TOCA.spell.EARTH_SHIELD),
}

--match the totems spells to their respective icons
TOCA.totems = {FIRE={}, EARTH={}, WATER={}, AIR={}} --cached order
for totemCat,v in pairsByKeys(TOCA.totems) do
	for k,v in pairsByKeys(TOCA._L.TOTEMS[totemCat]) do
		TOCA.totems[totemCat][k] = {}
		TOCA.totems[totemCat][k][1] = TOCA._L.TOTEMS[totemCat][k]
		TOCA.totems[totemCat][k][2] = TOCA.icons[totemCat][k]
	end
end

TOCA.version_alerted = 0
function TOCA.VersionControl(netprefix, netpacket)
	if (TOCA.version_alerted == 0) then
	  --if (netprefix == TOCA._G.prefix) then
	    local getPacket = TOCA.ParsePacket(netpacket, TOCA.Net.version)
	    if (getPacket) then
	      local latest_version = tonumber(getPacket)
	      local my_version = tonumber(TOCA._G.version)
	      if (latest_version > my_version) then --2 minor
	        TOCA.Notification("|cfffc2121" .. TOCA._L.INIT[7] .. " Latest version:|cffffedad " .. latest_version)
	        TOCA.version_alerted = tonumber(latest_version)
	      end
	    end
	  end
		if (tonumber(TOCA._G.date) >= tonumber(TOCA._G.update)) then
	    TOCA.Notification("|cfffc2121" .. TOCA._L.INIT[7])
			TOCA.version_alerted = 1
		end
	--end
end

--menu & frame system default structures
TOCA.Button={}
TOCA.Checkbox={}
TOCA.Slider={}
TOCA.Prompt={}
TOCA.Dropdown = {}
TOCA.Dropdown.Menu = {"Default"}
TOCA.MenuIsOpenMain = 0
TOCA.MenuIsOpenSets = 0
TOCA.ReincTimer = 0
TOCA._GTimerInMinutes = true --default
TOCA.Tab={}
TOCA.TabWidth={}
TOCA.isInCombat = false
TOCA.Framelevel = {
  Background=0,
  Foreground=1,
  Menu      =2,
  Buttons   =3,
  Cover     =4,
}
TOCA.Slot_w=35
TOCA.Slot_h=35
TOCA.Slot_x=-TOCA.Slot_w/2
TOCA.TotemsEnabled = true

-- may need to add this to it's own function
if (TOCA.Game.version == 1) then --classic
  table.remove(TOCA.totems.FIRE, 6) --totem of wrath
  table.remove(TOCA.totems.AIR, 2) --grounding totem
elseif (TOCA.Game.version == 3) then --WRATH
	table.remove(TOCA.totems.FIRE, 1) --fire nova
  table.remove(TOCA.totems.WATER, 5) --poison cleansing
	table.remove(TOCA.totems.AIR, 1) --grace of air
	table.remove(TOCA.totems.AIR, 5) --tranquil air
	table.remove(TOCA.totems.AIR, 7) --windwall

	--remove auras in this version
	table.remove(TOCA.TotemAuras.AIR, 3)
	table.remove(TOCA.TotemAuras.AIR, 5)
	table.remove(TOCA.TotemAuras.AIR, 7)
end

--default totem slots
TOCA.cache={}
for totemInt,totemCat in pairsByKeys(TOCA.AlphaOrder) do
	TOCA.cache[totemInt] = TOCA.totems[totemCat][1][1]
end

function TOCA.Notification(msg, debug)
  if ((debug) and (TOCA.DEBUG)) then
    print(TOCA._G.title .. " DEBUG: " .. msg)
  end
  if (not debug) then
    print(TOCA._G.title .. " " .. msg)
  end
end

function TOCA.BuildKeyBindsInit()
  BINDING_HEADER_TOTEMCADDY = TOCA._G.title
  for KeyBK,KeyBV in pairsByKeys(TOCA._L.KEYBINDS) do
    _G["BINDING_NAME_"..KeyBK] = KeyBV
  end
  TOCA.Notification("TOCA.BuildKeyBindsInit()", true)
end

TOCA.KeyBindButton = CreateFrame("Button", nil, UIParent, "BackdropTemplate")
TOCA.KeyBindButton:SetSize(4, 4)
TOCA.KeyBindButton:SetPoint("TOPLEFT", -100, 0)

TOCA.BuildKeyBindsInit()

function TOCA.SetIcon(icon)
	local array = {
		bgFile="Interface/AddOns/".. TOCA._G.prefix .."/images/" .. icon,
		edgeFile="Interface/ToolTips/UI-Tooltip-Border",
		edgeSize=10,
		insets={left=2, right=2, top=2, bottom=2},
	}
	if (TOCA.BorderFrames <= 0) then
		array = {
	    bgFile="Interface/AddOns/".. TOCA._G.prefix .."/images/" .. icon,
	    edgeFile="",
	    edgeSize=10,
	    insets={left=2, right=2, top=2, bottom=2},
	  }
	end
  return array
end

function TOCA.SetKeyBindReset(KeyBK, spell)
  local key1, key2 = GetBindingKey(KeyBK)
  if (key1) then
    SetOverrideBindingSpell(TOCA.KeyBindButton, true, key1, spell)
    TOCA.Notification("TOCA.SetKeyBindReset("..key1..", "..spell..")", true)
  end
  if (key2) then
    SetOverrideBindingSpell(TOCA.KeyBindButton, true, key2, spell)
    TOCA.Notification("TOCA.SetKeyBindReset("..key2..", "..spell..")", true)
  end
end

function TOCA.SetKeyBindOnLoad()
  if (TOCA.isInCombat) then
    TOCA.Notification("In combat, do nothing! TOCA.SetKeyBindOnLoad()", true)
  else
		if (TOCA.Game.version > 1) then
			local title = "TOTEM_RECALL"
	    TOCA.SetKeyBindReset(title, TOCA._L.SPELLS.TotemicCall)
		end

		if (TOCA.cache[1]) then
			local title = "TOTEM_AIR"
      TOCA.SetKeyBindReset(title, TOCA.cache[1])
    end
    if (TOCA.cache[2]) then
			local title = "TOTEM_EARTH"
      TOCA.SetKeyBindReset(title, TOCA.cache[2])
    end
    if (TOCA.cache[3]) then
			local title = "TOTEM_FIRE"
      TOCA.SetKeyBindReset(title, TOCA.cache[3])
    end
    if (TOCA.cache[4]) then
			local title = "TOTEM_WATER"
      TOCA.SetKeyBindReset(title, TOCA.cache[4])
    end
		TOCA.SetKeyBindReset("SHIELD_WATER",    TOCA.IdentifySpell(TOCA.spell.WATER_SHIELD))
		TOCA.SetKeyBindReset("SHIELD_LIGHTNING",TOCA.IdentifySpell(TOCA.spell.LIGHTNING_SHIELD))
		TOCA.SetKeyBindReset("SHIELD_EARTH",    TOCA.IdentifySpell(TOCA.spell.EARTH_SHIELD))
    TOCA.Notification("TOCA.SetKeyBindOnLoad()", true)
  end
end

function TOCA.Round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function TOCA.UpdateTotemSet()
  local totemIconKey = getKeyFromValue(TOCA.totems.AIR, TOCA.cache[1], 1)
	if (totemIconKey) then
	  local totemIcon = TOCA.SetIcon(TOCA.totems.AIR[totemIconKey][2])
	  TOCA.Slot["AIR"]:SetBackdrop(totemIcon)
	  TOCA.FrameSetsSlot["AIR"]:SetBackdrop(totemIcon)
	end

  local totemIconKey = getKeyFromValue(TOCA.totems.EARTH, TOCA.cache[2], 1)
	if (totemIconKey) then
	  local totemIcon = TOCA.SetIcon(TOCA.totems.EARTH[totemIconKey][2])
	  TOCA.Slot["EARTH"]:SetBackdrop(totemIcon)
	  TOCA.FrameSetsSlot["EARTH"]:SetBackdrop(totemIcon)
	end

  local totemIconKey = getKeyFromValue(TOCA.totems.FIRE, TOCA.cache[3], 1)
	if (totemIconKey) then
	  local totemIcon = TOCA.SetIcon(TOCA.totems.FIRE[totemIconKey][2])
	  TOCA.Slot["FIRE"]:SetBackdrop(totemIcon)
	  TOCA.FrameSetsSlot["FIRE"]:SetBackdrop(totemIcon)
	end

  local totemIconKey = getKeyFromValue(TOCA.totems.WATER, TOCA.cache[4], 1)
	if (totemIconKey) then
	  local totemIcon = TOCA.SetIcon(TOCA.totems.WATER[totemIconKey][2])
	  TOCA.Slot["WATER"]:SetBackdrop(totemIcon)
	  TOCA.FrameSetsSlot["WATER"]:SetBackdrop(totemIcon)
	end
end

TOCA.KnownTotems={}
TOCA.SlotSelectTotemDisabled={}
TOCA.FrameSetsSlotDisabled={}
TOCA.SlotGrid={}
TOCA.SlotGrid.VerticalTotemButton={}
TOCA.SlotGrid.HorizontalTotemButton={}
TOCA.FrameSeg={}
TOCA.FrameSeg.Button={}

for totemCat,v in pairsByKeys(TOCA.totems) do
  TOCA.SlotSelectTotemDisabled[totemCat]={}
  TOCA.FrameSetsSlotDisabled[totemCat]={}
  TOCA.SlotGrid.VerticalTotemButton[totemCat]={}
  TOCA.SlotGrid.HorizontalTotemButton[totemCat]={}
	TOCA.FrameSeg.Button[totemCat]={}
	TOCA.KnownTotems[totemCat] = 40 --min
end

function TOCA.EnableTotems(enable)
  if (enable) then
    TOCA.TotemsEnabled = true
    for totemCat,v in pairsByKeys(TOCA.totems) do
      TOCA.Slot.Disable[totemCat]:Hide()
      for i,totemSpell in pairs(TOCA.totems[totemCat]) do
        TOCA.SlotGrid.VerticalTotemButton[totemCat][i].disable:Hide()
        TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].disable:Hide()
				TOCA.FrameSeg.Button[totemCat][i].disable:Hide()
      end
    end
  else
    TOCA.TotemsEnabled = false
    for totemCat,v in pairsByKeys(TOCA.totems) do
      TOCA.Slot.Disable[totemCat]:Show()
      for i,totemSpell in pairs(TOCA.totems[totemCat]) do
        TOCA.SlotGrid.VerticalTotemButton[totemCat][i].disable:Show()
        TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].disable:Show()
				TOCA.FrameSeg.Button[totemCat][i].disable:Show()
      end
    end
  end
	--TOCA.Notification("TOCA.EnableTotems(" .. tostring(enable) .. ")", true)
end

local totemButtonPos_X={}
local totemButtonPos_Y={}
function TOCA.SizeSegmentedBars(totemCat) --and adjust orientation
	totemButtonPos_X[totemCat] = 0
	totemButtonPos_Y[totemCat] = 0
	if ((TOCA.KnownTotems[totemCat] <= 3) or (TOCA.KnownTotems[totemCat] >= 20)) then --bugfix for leveling shamans without totems
		TOCA.KnownTotems[totemCat] = 4 --min 4
	end

	if (TOCA.player.classID == 7) then --shaman
		if (TOCADB[TOCA.player.combine]["CONFIG"]["SEG_OR_"..totemCat] == "H") then
			TOCA.FrameSeg[totemCat]:SetWidth(38.8*TOCA.KnownTotems[totemCat])
			TOCA.FrameSeg[totemCat]:SetHeight(41)
			for i,totemSpell in pairs(TOCA.totems[totemCat]) do
				totemButtonPos_X[totemCat] = totemButtonPos_X[totemCat]+TOCA.Slot_w
				totemButtonPos_Y[totemCat] = totemButtonPos_Y[totemCat]+TOCA.Slot_h
				--TOCA.FrameSeg.Button[totemCat][i]:SetPoint("TOPLEFT", 15.1-totemButtonPos_Y[totemCat]+TOCA.Slot_w, -3)
				TOCA.FrameSeg.Button[totemCat][i]:SetPoint("TOPLEFT", -TOCA.Slot_w+totemButtonPos_Y[totemCat]+16.1, -3)
				TOCA.FrameSeg[totemCat].Menu:SetWidth(40)
				TOCA.FrameSeg[totemCat].Menu:SetHeight(22)
				TOCA.FrameSeg[totemCat].Menu:SetPoint("TOPLEFT", 0, 20)
				TOCA.FrameSeg.Button[totemCat].orientation:SetPoint("TOPLEFT", 18, -2)
				TOCA.FrameSeg[totemCat].Header:SetWidth(14)
				TOCA.FrameSeg[totemCat].Header:SetHeight(33)
				TOCA.FrameSeg[totemCat].Header:SetPoint("TOPLEFT", 3, -4)
			end
		else
			TOCA.FrameSeg[totemCat]:SetWidth(41)
			TOCA.FrameSeg[totemCat]:SetHeight(38.8*TOCA.KnownTotems[totemCat])
			for i,totemSpell in pairs(TOCA.totems[totemCat]) do
				totemButtonPos_X[totemCat] = totemButtonPos_X[totemCat]+TOCA.Slot_w
				totemButtonPos_Y[totemCat] = totemButtonPos_Y[totemCat]+TOCA.Slot_h
				TOCA.FrameSeg.Button[totemCat][i]:SetPoint("TOPLEFT", 3, -15.1-totemButtonPos_Y[totemCat]+TOCA.Slot_h)
				TOCA.FrameSeg[totemCat].Menu:SetWidth(22)
				TOCA.FrameSeg[totemCat].Menu:SetHeight(40)
				TOCA.FrameSeg[totemCat].Menu:SetPoint("TOPLEFT", TOCA.FrameSeg[totemCat]:GetWidth()-1, 0)
				TOCA.FrameSeg.Button[totemCat].orientation:SetPoint("TOPLEFT", 2, -18)
				TOCA.FrameSeg[totemCat].Header:SetWidth(33)
				TOCA.FrameSeg[totemCat].Header:SetHeight(14)
				TOCA.FrameSeg[totemCat].Header:SetPoint("TOPLEFT", 4, -3)
			end
		end
		TOCA.FrameSeg[totemCat].Background:SetWidth(TOCA.FrameSeg[totemCat]:GetWidth())
		TOCA.FrameSeg[totemCat].Background:SetHeight(TOCA.FrameSeg[totemCat]:GetHeight())
	end
end

function TOCA.EnableKnownTotems()
  if (TOCA.TotemsEnabled) then
		local TotemicCall = GetSpellInfo(TOCA._L.SPELLS.TotemicCall)
		if (not TotemicCall) then
			TOCA.HideUnknownSpells(true)
		end

    if (TOCA.isInCombat) then
      TOCA.Notification("In Combat, do nothing! TOCA.EnableKnownTotems()", true)
			for totemCat,v in pairsByKeys(TOCA.totems) do
				TOCA.FrameSeg[totemCat].Menu:Hide()
			end
			return
    else
      for totemCat,v in pairsByKeys(TOCA.totems) do
        for i,totemSpell in pairs(TOCA.totems[totemCat]) do
          TOCA.SlotSelectTotemDisabled[totemCat][i]:Show()
          TOCA.FrameSetsSlotDisabled[totemCat][i]:Show()
          TOCA.SlotGrid.VerticalTotemButton[totemCat][i]:Hide()
          TOCA.SlotGrid.HorizontalTotemButton[totemCat][i]:Hide()
					TOCA.FrameSeg.Button[totemCat][i]:Hide()
          local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(totemSpell[1])
          if (name) then
            TOCA.SlotSelectTotemDisabled[totemCat][i]:Hide()
            TOCA.FrameSetsSlotDisabled[totemCat][i]:Hide()
            TOCA.SlotGrid.VerticalTotemButton[totemCat][i]:Show()
            TOCA.SlotGrid.HorizontalTotemButton[totemCat][i]:Show()
						TOCA.FrameSeg.Button[totemCat][i]:Show()
						TOCA.KnownTotems[totemCat] = i
          end
        end
      end
    end
  end
	for totemCat,v in pairsByKeys(TOCA.totems) do
		TOCA.SizeSegmentedBars(totemCat)
	end
	TOCA.Notification("TOCA.EnableKnownTotems()", true)
end

function TOCA.HasEarthShield()
	local usable, nomana = IsUsableSpell(TOCA.spell.EARTH_SHIELD)
	if (usable) then
		return usable
	end
end

TOCA.FrameStyleIndex={} --build an index for localization
for k,v in pairs(TOCA._L.UI.FRAMESTYLES) do
  TOCA.FrameStyleIndex[v]=k
end

function TOCA.FrameStyleDefault() --used for emergency recovery
  TOCA.FrameMain:SetHeight(TOCA._G.height)
  TOCA.FrameMain:SetWidth(TOCA._G.width)
  TOCA.Button.TotemicCall:SetPoint("CENTER", 0, 40)
	TOCA.Button.DropdownMain:Show()
	TOCA.FrameMain.ShieldFrame:SetPoint("TOPLEFT", TOCA._G.width-4, -14)
	TOCA.FrameMain.ReincFrame:SetPoint("TOPLEFT", TOCA._G.width-4, -44)
	TOCA.FrameMain.AnkhFrame:SetPoint("TOPLEFT", -28, -14)
	TOCA.Button.TotemicCall.ECL:SetPoint("CENTER", -30, 61)
	TOCA.Button.TotemicCall.ECR:SetPoint("CENTER", 30, 61)
	for totemCat,v in pairsByKeys(TOCA.totems) do
		TOCA.Slot[totemCat]:Show()
		TOCA.FrameSeg[totemCat]:Hide()
	end
	TOCA.Button.DropdownMain:Show()
	TOCA.FrameMainGridVertical:Hide()
	TOCA.FrameMainGridHorizontal:Hide()
	TOCA.FrameMain.ReincFrame.text:SetPoint("CENTER", TOCA.FrameMain.ReincFrame, "CENTER", 0, -18)
end

function TOCA.FrameStyleSet(style)
	TOCA.FrameStyleDefault()
  if (style == TOCA._L.UI.FRAMESTYLES[2]) then --segmented
			TOCA.FrameMain.ShieldFrame:SetPoint("TOPLEFT", 10, -30)
	    TOCA.FrameMain.ReincFrame:SetPoint("TOPLEFT", 40, -30)
	    TOCA.FrameMain.AnkhFrame:SetPoint("TOPLEFT", 70, -30)
			for totemCat,v in pairsByKeys(TOCA.totems) do
				TOCA.Slot[totemCat]:Hide()
	      TOCA.FrameSeg[totemCat]:Show()
			end
			TOCA.FrameMain:SetHeight(TOCA._G.height-20)
			TOCA.Button.TotemicCall:SetPoint("CENTER", 0, 30)
			TOCA.Button.TotemicCall.ECL:SetPoint("CENTER", -30, 51)
			TOCA.Button.TotemicCall.ECR:SetPoint("CENTER", 30, 51)
			TOCA.Button.DropdownMain:Hide()
			TOCA.FrameMain.ReincFrame.text:SetPoint("CENTER", TOCA.FrameMain.ReincFrame, "CENTER", 0, 18)
  elseif (style == TOCA._L.UI.FRAMESTYLES[3]) then --vert
		TOCA.FrameMain.ShieldFrame:SetPoint("TOPLEFT", TOCA._G.width-4, -14)
    TOCA.FrameMain.ReincFrame:SetPoint("TOPLEFT", TOCA._G.width-4, -44)
    TOCA.FrameMain.AnkhFrame:SetPoint("TOPLEFT", TOCA._G.width-4, -74)
    TOCA.FrameMain:SetHeight(TOCA._G.height+240)
    TOCA.Button.TotemicCall:SetPoint("CENTER", 0, 160)
    TOCA.Button.TotemicCall.ECL:SetPoint("CENTER", -30, 181)
    TOCA.Button.TotemicCall.ECR:SetPoint("CENTER", 30, 181)
    for totemCat,v in pairsByKeys(TOCA.totems) do
      TOCA.Slot[totemCat]:Hide()
			TOCA.FrameSeg[totemCat]:Hide()
    end
		TOCA.Button.DropdownMain:Hide()
		TOCA.FrameMainGridVertical:Show()
		TOCA.FrameMainGridHorizontal:Hide()
  elseif (style == TOCA._L.UI.FRAMESTYLES[4]) then --horz
		TOCA.FrameMain.ShieldFrame:SetPoint("TOPLEFT", TOCA._G.width+171, -22)
    TOCA.FrameMain.ReincFrame:SetPoint("TOPLEFT", TOCA._G.width+171, -52)
    TOCA.FrameMain.AnkhFrame:SetPoint("TOPLEFT", TOCA._G.width+171, -82)
    TOCA.FrameMain:SetHeight(TOCA._G.height+84)
		TOCA.FrameMain:SetWidth(TOCA._G.height+240)
    TOCA.Button.TotemicCall:SetPoint("CENTER", 0, 84)
    TOCA.Button.TotemicCall.ECL:SetPoint("CENTER", -30, 103)
    TOCA.Button.TotemicCall.ECR:SetPoint("CENTER", 30, 103)
		TOCA.Button.DropdownMain:Hide()
    for totemCat,v in pairsByKeys(TOCA.totems) do
      TOCA.Slot[totemCat]:Hide()
			TOCA.FrameSeg[totemCat]:Hide()
    end
		TOCA.FrameMainGridVertical:Hide()
		TOCA.FrameMainGridHorizontal:Show()
  end
	TOCA.FrameMain.Background:SetHeight(TOCA.FrameMain:GetHeight())
	TOCA.FrameMain.Background:SetWidth(TOCA.FrameMain:GetWidth())
  TOCA.Notification("Frame Style: " .. style, true)
end

function TOCA.DisplayAnkhFrame()
  TOCA.FrameMain.AnkhFrame:Hide()
  if (TOCADB[TOCA.player.combine]["CONFIG"]["ANKH"] == "OFF") then
    return
  end
  local pL = UnitLevel("player")
  if (pL >= 30) then
    TOCA.FrameMain.AnkhFrame.text:SetText(TOCA.InventoryCountItem(TOCA.item.ANKH))
    if (TOCA.InventoryCountItem(TOCA.item.ANKH) <= TOCA.AnkhReminder) then
			TOCA.FrameMain.AnkhFrame.text:SetTextColor(1, 1, 1, 1)
			if (TOCA.InventoryCountItem(TOCA.item.ANKH) <= 1) then
			  TOCA.FrameMain.AnkhFrame.text:SetTextColor(1, 0, 0, 1)
		  end
      TOCA.FrameMain.AnkhFrame:Show()
    else
      TOCA.FrameMain.AnkhFrame:Hide()
    end
  end
end

function TOCA.BorderFrame(enable)
  if (enable) then
    TOCA.FrameMain.Background:SetBackdropBorderColor(1, 1, 1, 0.6)
    TOCA.Button.TotemicCall:SetBackdropBorderColor(1, 1, 1, 0.6)
    TOCA.Button.CloseMain:SetBackdropBorderColor(1, 1, 1, 0.8)
    TOCA.Button.DropdownMain:SetBackdropBorderColor(1, 1, 1, 0.6)
		TOCA.FrameMain.ShieldFrame:SetBackdropBorderColor(1, 1, 1, 0.6)
    TOCA.FrameMain.ReincFrame:SetBackdropBorderColor(1, 1, 1, 0.6)
    TOCA.FrameMain.AnkhFrame:SetBackdropBorderColor(1, 1, 1, 0.6)
    for totemCat,v in pairsByKeys(TOCA.totems) do
      TOCA.Slot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
      TOCA.SlotSelect[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
      TOCA.SlotSelectMenu[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
			TOCA.FrameSeg[totemCat].Background:SetBackdropBorderColor(
			TOCA.colors.totems[totemCat][1],
			TOCA.colors.totems[totemCat][2],
			TOCA.colors.totems[totemCat][3],
			TOCA.colors.totems[totemCat][4])
      for i,totemSpell in pairs(TOCA.totems[totemCat]) do
        if (TOCA.SlotSelectTotem[totemCat][i]) then
          TOCA.SlotSelectTotem[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0.6)
        end
        if (TOCA.SlotGrid.VerticalTotemButton[totemCat][i]) then
          TOCA.SlotGrid.VerticalTotemButton[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0.6)
        end
        if (TOCA.SlotGrid.HorizontalTotemButton[totemCat][i]) then
          TOCA.SlotGrid.HorizontalTotemButton[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0.6)
        end
				TOCA.FrameSeg.Button[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0.6)
      end
    end
  else
    TOCA.FrameMain.Background:SetBackdropBorderColor(1, 1, 1, 0)
    TOCA.Button.TotemicCall:SetBackdropBorderColor(1, 1, 1, 0)
    TOCA.Button.CloseMain:SetBackdropBorderColor(1, 1, 1, 0)
    TOCA.Button.DropdownMain:SetBackdropBorderColor(1, 1, 1, 0)
		TOCA.FrameMain.ShieldFrame:SetBackdropBorderColor(1, 1, 1, 0)
    TOCA.FrameMain.ReincFrame:SetBackdropBorderColor(1, 1, 1, 0)
    TOCA.FrameMain.AnkhFrame:SetBackdropBorderColor(1, 1, 1, 0)
    for totemCat,v in pairsByKeys(TOCA.totems) do
      TOCA.Slot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0)
      TOCA.SlotSelect[totemCat]:SetBackdropBorderColor(1, 1, 1, 0)
      TOCA.SlotSelectMenu[totemCat]:SetBackdropBorderColor(1, 1, 1, 0)
			TOCA.FrameSeg[totemCat].Background:SetBackdropBorderColor(0,0,0,0)
      for i,totemSpell in pairs(TOCA.totems[totemCat]) do
        if (TOCA.SlotSelectTotem[totemCat][i]) then
          TOCA.SlotSelectTotem[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0)
        end
        if (TOCA.SlotGrid.VerticalTotemButton[totemCat][i]) then
          TOCA.SlotGrid.VerticalTotemButton[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0)
        end
        if (TOCA.SlotGrid.HorizontalTotemButton[totemCat][i]) then
          TOCA.SlotGrid.HorizontalTotemButton[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0)
        end
				TOCA.FrameSeg.Button[totemCat][i]:SetBackdropBorderColor(1, 1, 1, 0)
      end
    end
  end
  TOCA.Notification("TOCA.BorderFrame()", true)
end

function TOCA.HideUnknownSpells(force)
	if ((TOCA.Game.version == 1) or (force)) then --classic
		TOCA.Button.TotemicCall:Hide()
		TOCA.Button.TotemicCall.ECL:Hide()
		TOCA.Button.TotemicCall.ECR:Hide()
		TOCA.Checkbox.EndCaps:Hide()
		TOCA.Checkbox.Totemic:Hide()
		TOCA.Dropdown.FrameGryphons:Hide()
	end
end

TOCA.BorderFrames = 1 --called after building icons

function TOCA.SetDDMenu(DDFrame, value)
  if (TOCADB[TOCA.player.combine]["PROFILES"][value]) then
    for k,v in pairs(TOCADB[TOCA.player.combine]["PROFILES"][value]) do
      --TOCA.Notification("debug profile " .. k, true)
      if (k == "TOCA_AIR") then
        TOCA.cache[1] = v
        if (TOCA.isInCombat) then
          TOCA.Notification("In Combat, do nothing! TOCA.SetDDMenu", true)
        else
          TOCA.Totem["AIR"]:SetAttribute("spell", v)
          TOCA.SetKeyBindReset("TOTEM_AIR", v)
        end
      end
      if (k == "TOCA_EARTH") then
        TOCA.cache[2] = v
        if (TOCA.isInCombat) then
          TOCA.Notification("In Combat, do nothing! TOCA.SetDDMenu", true)
        else
          TOCA.Totem["EARTH"]:SetAttribute("spell", v)
          TOCA.SetKeyBindReset("TOTEM_EARTH", v)
        end
      end
      if (k == "TOCA_FIRE") then
        TOCA.cache[3] = v
        if (TOCA.isInCombat) then
          TOCA.Notification("In Combat, do nothing! TOCA.SetDDMenu", true)
        else
          TOCA.Totem["FIRE"]:SetAttribute("spell", v)
          TOCA.SetKeyBindReset("TOTEM_FIRE", v)
        end
      end
      if (k == "TOCA_WATER") then
        TOCA.cache[4] = v
        if (TOCA.isInCombat) then
          TOCA.Notification("In Combat, do nothing! TOCA.SetDDMenu", true)
        else
          TOCA.Totem["WATER"]:SetAttribute("spell", v)
          TOCA.SetKeyBindReset("TOTEM_WATER", v)
        end
      end
    end
  end
  --just update both
  TOCA.Dropdown.Main.text:SetText(value)
  TOCA.Dropdown.Sets.text:SetText(value)
  TOCADB[TOCA.player.combine]["LASTSAVED"] = value
  TOCA.UpdateTotemSet()
  TOCA.Notification("TOCA.SetDDMenu(...)", true)
end

function TOCA.AddDDItem(DDFrame, DDArray)
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
		TOCA.FrameSeg[k].Menu:Hide()
  end
  GameTooltip:ClearLines()
  GameTooltip:Hide()
end

function TOCA.GetOwnerSpell(bookSpell)
  local i = 1
  local spellLatest = 0
  while true do
    local spell = GetSpellBookItemName(i, BOOKTYPE_SPELL)
    if (not spell) then
      break
    end
    if (bookSpell == spell) then
      spellLatest = i
    end
    i = i + 1
  end
  return spellLatest --latest known spell in the owner's book
end

function TOCA.TooltipDisplay(owner, title, msg, anchor)
  local spellName, spellRank, spellID = GetSpellBookItemName(title)
	GameTooltip:ClearLines()
  if (spellID) then --assure that there is a valid spell
		if (TOCADB[TOCA.player.combine]["CONFIG"]["TOOLON"] == "OFF") then
			return
		end
    local knownSpell = TOCA.GetOwnerSpell(spellName)
    if (knownSpell) then
			local point, relativeTo, relativePoint, xOfs, yOfs = GameTooltip:GetPoint()
			if ((xOfs == 0) or (yOfs == 0)) then
				GameTooltip:ClearAllPoints()
				GameTooltip:SetPoint("BOTTOMRIGHT", WorldFrame, "BOTTOMRIGHT", -90, 90)
			end
			GameTooltip:SetOwner(owner, "ANCHOR_PRESERVE") --spells go to the right
      GameTooltip:SetSpellBookItem(knownSpell, BOOKTYPE_SPELL)
      GameTooltip:Show()
    end
  else --manual
    if (anchor) then
      GameTooltip:SetOwner(owner, anchor)
    else
			GameTooltip:SetOwner(owner, "ANCHOR_TOPLEFT")
    end
    if (title) then
      GameTooltip:AddLine(title, 1, 1, 1, 1)
      if (msg) then
        GameTooltip:AddDoubleLine(msg, "", 1, 0.8, 0, 0,0,1)
      else
        GameTooltip:AddDoubleLine(TOCA._L.SPELLS.Unknown, "", 1, 0, 0, 0,0,1)
      end
    end
    GameTooltip:Show()
  end
end

--TOCA.HasTotemOut = 0
TOCA.TotemPresent={}
TOCA.TotemName={}
TOCA.TotemStartTime={}
TOCA.TotemDuration={}
TOCA.TotemID={}
TOCA.TotemFunc={}
TOCA.TotemIcon={}
TOCA.TotemRate={}

TOCA.TotemTimer={}
for i=1, 4 do
  TOCA.TotemTimer[i] = 0
  TOCA.TotemDuration[i] = 0
end

function TOCA.GetTotemInfo(t)
  --TOCA.TotemPresent[t], TOCA.TotemName[t], TOCA.TotemStartTime[t], TOCA.TotemDuration[t], TOCA.TotemIcon[t], TOCA.TotemRate[t], TOCA.TotemID[t] = GetTotemInfo(t)
	TOCA.TotemPresent[t], TOCA.TotemName[t], TOCA.TotemStartTime[t], TOCA.TotemDuration[t], TOCA.TotemID[t] = GetTotemInfo(t)
end

function TOCA.ExpireNotificationsTotems(totemname, totemtimer)
	--print(totemtimer)
	if (totemtimer == 10) then
		if ((totemname ~= nil) or (totemname ~= "")) then
			if (TOCADB[TOCA.player.combine]["CONFIG"]["EXPIREMESSAGE"] ~= "OFF") then
				TOCA.Notification("|cfff6d526" .. totemname .. "|r ".. TOCA._L.INIT[4])
			end
			if (TOCADB[TOCA.player.combine]["CONFIG"]["EXPIRESOUND"] ~= "OFF") then
				if (TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDFILE"]) then
					PlaySoundFile(TOCA._G.dir .. "sounds/" .. TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDFILE"] .. ".ogg")
				else
					PlaySoundFile(TOCA._G.dir .. "sounds/totemexpire_1.ogg")
				end
			end
		end
	end
end

TOCA.HasShield = 0
function TOCA.ExpireNotificationsShield()
	local _Uindex = 1
	while UnitAura("player", _Uindex) do
		local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura("player", _Uindex)
		for k,v in pairs(TOCA._L.SPELLS.SHIELDS) do
			if (string.find(name, v)) then
				local timeDuration = duration + expirationTime - GetTime()
				timeDuration = timeDuration / 120
				if ((timeDuration >= TOCA.ShamanShieldDuration) and (count >= 2)) then
				  TOCA.NotificationAlertShield = 0 --reset / refreshed the aura
					TOCA.HasShield = 1
			  else
					if ((timeDuration < 1.0) or (count <= 1)) then
						if (TOCA.NotificationAlertShield <= 0) then
							TOCA.NotificationAlertShield = 1
							if (TOCADB[TOCA.player.combine]["CONFIG"]["EXPIREMESSAGESHIELD"] ~= "OFF") then
								TOCA.Notification("|cfff6d526" .. name .. "|r ".. TOCA._L.INIT[4])
							end
							if (TOCADB[TOCA.player.combine]["CONFIG"]["EXPIRESHIELD"] ~= "OFF") then
								if (TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDSHIELDFILE"]) then
									PlaySoundFile(TOCA._G.dir .. "sounds/" .. TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDSHIELDFILE"] .. ".ogg")
								else
									PlaySoundFile(TOCA._G.dir .. "sounds/shieldexpire_1.ogg")
								end
							end
						end
					end
				end
			end
		end
		_Uindex = _Uindex + 1
	end
end

TOCA.TotemInRange={}
--TOCA.AuraMatchTotem={}
function TOCA.TotemAuraRadius(event)
	local _Uindex = 1
	local totemCat={}
	for k,v in pairs(TOCA.totems) do
		TOCA.Slot.Radius[k]:Hide()
		TOCA.Slot.Radius.Border[k]:Hide()
			for i,totemSpell in pairs(TOCA.totems[k]) do
				TOCA.FrameSeg.Button[k][i].radius:Hide()
			end
	end
	for v,k in pairs(TOCA.GameOrder) do
		totemCat[k] = v
	end
	for i=1, 4 do
		TOCA.TotemInRange[i] = nil --clear the array
	end

  while UnitAura("player", _Uindex) do
	  local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura("player", _Uindex)
		--print(name)
		--print(spellId)
		for auraCat,index in pairs(TOCA.TotemAuras) do
			for auraCatIndex,auraList in pairs(TOCA.TotemAuras[auraCat]) do
				if (auraList) then
					for auraListIndex,auraId in pairs(auraList) do
						if (spellId == auraId) then
							--print("a totem aura has been identified: " .. spellId)
							--print(auraCat)
							for i=1, 4 do
								--TOCA.AuraMatchTotem[i] = nil
								if (totemCat[i]) then --totem is down and we are in range for the moment
									if (auraCat == totemCat[i]) then
										--print("Aura and Totem : " .. auraCat)
										--TOCA.AuraMatchTotem[i] = auraCat
										TOCA.TotemInRange[i] = auraCat
									end
								end
							end
						end
					end
				end
			end
		end
		_Uindex = _Uindex + 1
	end

	--trap the totem second time around
	for i=1, 4 do
		TOCA.GetTotemInfo(i)

		if ((TOCA.TotemPresent[i]) and (TOCA.TotemName[i] ~= "")) then
			--print(TOCA.TotemID[i])
			if (TOCA.TotemInRange[i]) then
				--print("In Range : " .. TOCA.TotemInRange[i])
				TOCA.Slot.Radius[TOCA.TotemInRange[i]]:Hide()
				TOCA.Slot.Radius.Border[TOCA.TotemInRange[i]]:Hide()
				for index,totemSpell in pairs(TOCA.totems[TOCA.TotemInRange[i]]) do
					TOCA.FrameSeg.Button[TOCA.TotemInRange[i]][index].radius:Hide()
				end
			else --Not in range of an aura but the totem is present
				--if (TOCA.TotemName[i]) then
					--print("Out of Range : " .. i)
					--print(TOCA.TotemName[i])
				--end
				if (TOCA.TotemName[i]) then
					if (TOCA.TotemName[i] ~= "") then
						for totemCat,v in pairsByKeys(TOCA.totems) do
							for index,totemSpell in pairs(TOCA.totems[totemCat]) do
								if (string.find(TOCA.TotemName[i], TOCA.FrameSeg.Button[totemCat][index].ID:GetText())) then
									--print(TOCA.TotemName[i])
									TOCA.FrameSeg.Button[totemCat][index].radius:Show()
								end
							end
						end
					end
				end

				for v,k in pairs(TOCA.GameOrder) do
					if (i == k) then
						TOCA.Slot.Radius[v]:Show()
						TOCA.Slot.Radius.Border[v]:Show()
					end
				end
			end
			--exempt totems, due to no aura
			for totemCat,v in pairs(TOCA.TotemAuraExempt) do
				for k,totemID in pairs(TOCA.TotemAuraExempt[totemCat]) do
					if (TOCA.TotemID[i] == totemID) then --use the icon id, since it's unique and totems dont have an actual ID
						--print(totemID .. " is exempt " .. totemCat)
						TOCA.Slot.Radius[totemCat]:Hide()
						TOCA.Slot.Radius.Border[totemCat]:Hide()
						for index,totemSpell in pairs(TOCA.totems[totemCat]) do
							TOCA.FrameSeg.Button[totemCat][index].radius:Hide() --just clear everything in that category
						end
					end
				end
			end
		end --totempresent
	end

end

function TOCA.TimerFrame(i)
  TOCA.GetTotemInfo(i)

  if ((TOCA.TotemPresent[i]) and (TOCA.TotemName[i] ~= "")) then
    TOCA.TotemTimer[i] = TOCA.TotemTimer[i] -1
    if (TOCA._GTimerInMinutes) then
      TOCA.Slot.Timer[i]:SetText(TimeSecondsToMinutes(TOCA.TotemTimer[i]))
      TOCA.SlotGrid.VerticalTimer[i]:SetText(TimeSecondsToMinutes(TOCA.TotemTimer[i]))
      TOCA.SlotGrid.HorizontalTimer[i]:SetText(TimeSecondsToMinutes(TOCA.TotemTimer[i]))
			for totemCat,v in pairsByKeys(TOCA.totems) do
			  for index,totemSpell in pairs(TOCA.totems[totemCat]) do
					if ((TOCA.TotemName[i]) and (TOCA.FrameSeg.Button[totemCat][index].ID:GetText())) then
						if (string.find(TOCA.TotemName[i], TOCA.FrameSeg.Button[totemCat][index].ID:GetText())) then
							--print(TOCA.TotemName[i])
							--print(i)
							--print("time: ")
							--print(TimeSecondsToMinutes(TOCA.TotemTimer[i]))
							TOCA.FrameSeg.Button[totemCat][index].timer:SetText(TimeSecondsToMinutes(TOCA.TotemTimer[i]))
						end
					end
				end
		  end
    else --seconds
      TOCA.Slot.Timer[i]:SetText(TOCA.TotemTimer[i])
      TOCA.SlotGrid.VerticalTimer[i]:SetText(TOCA.TotemTimer[i])
      TOCA.SlotGrid.HorizontalTimer[i]:SetText(TOCA.TotemTimer[i])
			for totemCat,v in pairsByKeys(TOCA.totems) do
			  for index,totemSpell in pairs(TOCA.totems[totemCat]) do
					if ((TOCA.TotemName[i]) and (TOCA.FrameSeg.Button[totemCat][index].ID:GetText())) then
						if (string.find(TOCA.TotemName[i], TOCA.FrameSeg.Button[totemCat][index].ID:GetText())) then
							--print(TOCA.TotemName[i])
							TOCA.FrameSeg.Button[totemCat][index].timer:SetText(TOCA.TotemTimer[i])
						end
					end
				end
		  end
    end
  else
    TOCA.Slot.Timer[i]:SetText("")
    TOCA.SlotGrid.VerticalTimer[i]:SetText("")
    TOCA.SlotGrid.HorizontalTimer[i]:SetText("")
		local totemCat = nil
		if (i == 1) then totemCat = "FIRE" end
		if (i == 2) then totemCat = "EARTH" end
		if (i == 3) then totemCat = "WATER" end
		if (i == 4) then totemCat = "AIR" end
		if (totemCat) then
			for index,totemSpell in pairs(TOCA.totems[totemCat]) do
				TOCA.FrameSeg.Button[totemCat][index].timer:SetText("")
			end
		end
  end

	if (TOCADB[TOCA.player.combine]["CONFIG"]["NOTIFYCOMBAT"] == "OFF") then
		TOCA.ExpireNotificationsTotems(TOCA.TotemName[i], TOCA.TotemTimer[i])
	else
		if (TOCA.isInCombat) then
			TOCA.ExpireNotificationsTotems(TOCA.TotemName[i], TOCA.TotemTimer[i])
		end
	end

  if (TOCADB[TOCA.player.combine]["CONFIG"]["TIMERS"] == "OFF") then
    for i=1, 4 do --hide all
      TOCA.Slot.Timer[i]:Hide()
      TOCA.SlotGrid.VerticalTimer[i]:Hide()
      TOCA.SlotGrid.HorizontalTimer[i]:Hide()
    end
		for totemCat,v in pairsByKeys(TOCA.totems) do
			for index,totemSpell in pairs(TOCA.totems[totemCat]) do
				TOCA.FrameSeg.Button[totemCat][index].timer:Hide()
			end
		end
    return
  end

  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMESTYLE"] == TOCA._L.UI.FRAMESTYLES[1]) then --classic
    for i=1, 4 do
      TOCA.Slot.Timer[i]:Show()
      TOCA.SlotGrid.VerticalTimer[i]:Hide()
      TOCA.SlotGrid.HorizontalTimer[i]:Hide()
    end
  end

	if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMESTYLE"] == TOCA._L.UI.FRAMESTYLES[2]) then --segmented
		for i=1, 4 do
			TOCA.Slot.Timer[i]:Hide()
			TOCA.SlotGrid.VerticalTimer[i]:Hide()
			TOCA.SlotGrid.HorizontalTimer[i]:Hide()
		end
	end

  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMESTYLE"] == TOCA._L.UI.FRAMESTYLES[3]) then --vert
    for i=1, 4 do
      TOCA.Slot.Timer[i]:Hide()
      TOCA.SlotGrid.VerticalTimer[i]:Show()
      TOCA.SlotGrid.HorizontalTimer[i]:Hide()
    end
  end

  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMESTYLE"] == TOCA._L.UI.FRAMESTYLES[4]) then --horz
    for i=1, 4 do
      TOCA.Slot.Timer[i]:Hide()
      TOCA.SlotGrid.VerticalTimer[i]:Hide()
      TOCA.SlotGrid.HorizontalTimer[i]:Show()
    end
  end
end

--build timers
for i=1, 4 do
  TOCA.TotemFunc[i] = 0
  TOCA.TotemFunc[i] = C_Timer.NewTicker(0, function() TOCA.TimerFrame(i) end, 0)
  TOCA.TotemFunc[i]:Cancel()
end

TOCA.ShieldExpirationTimer = 0
do
	function TOCA.TimerShield(frame, exptime)
		if (exptime) then
			frame.frame = 0
			frame:SetScript("OnUpdate", function(self, lapse)
				self.frame = self.frame + lapse
				TOCA.ShieldExpirationTimer = exptime - self.frame
				--print(TOCA.ShieldExpirationTimer)
				shieldTime = TOCA.ShieldExpirationTimer / 60
				if (shieldTime>= 1) then
					TOCA.FrameMain.ShieldFrame.timer:SetText(math.ceil(shieldTime) .. " m")
				end
			end)
		end
	end
end

function TOCA.ExtendedTotemCooldowns(totemCat, spell, countDown)
	TOCA.Slot.Recharge[totemCat]:SetCooldown(GetTime(), countDown)
	for i,totemSpell in pairs(TOCA.totems[totemCat]) do
		TOCA.SlotGrid.VerticalTotemButton[totemCat][i].recharge:SetCooldown(GetTime(), countDown)
		TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].recharge:SetCooldown(GetTime(), countDown)
		TOCA.FrameSeg.Button[totemCat][i].recharge:SetCooldown(GetTime(), countDown)
	end
	if (totemCat == "EARTH") then
	  if (spell == 2484) then
			TOCA.Slot.Recharge[totemCat]:SetCooldown(GetTime(), 15) --earthbind
			TOCA.FrameSeg.Button[totemCat][1].recharge:SetCooldown(GetTime(), 15)
	  elseif ((spell == 5730) or (spell == 6390) or (spell == 6391) or (spell == 10428) or (spell == 25525)) then
			TOCA.Slot.Recharge[totemCat]:SetCooldown(GetTime(), 30) --stoneclaws
			TOCA.FrameSeg.Button[totemCat][2].recharge:SetCooldown(GetTime(), 30)
		end
	elseif (totemCat == "FIRE") then
		--TOCA.Slot.Recharge[totemCat]:SetCooldown(GetTime(), countDown)
	elseif (totemCat == "WATER") then
		if (spell == 16190) then
			TOCA.Slot.Recharge[totemCat]:SetCooldown(GetTime(), 300) --mana tide
			TOCA.FrameSeg.Button[totemCat][5].recharge:SetCooldown(GetTime(), 300)
		end
	elseif (totemCat == "AIR") then
		--TOCA.Slot.Recharge[totemCat]:SetCooldown(GetTime(), countDown)
		if (spell == 8177) then
			TOCA.Slot.Recharge[totemCat]:SetCooldown(GetTime(), 15) --grounding
			TOCA.FrameSeg.Button[totemCat][2].recharge:SetCooldown(GetTime(), 15)
		end
	end
end

--trigger only on totem drops / self spells
function TOCA.TimerRechargeStart(spell, instant)
	local countDown = 1.1
	local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(spell)
	--local manaConsume = GetSpellPowerCost(name)
	--print(manaConsume.cost)
	--print(spell)
	if (name) then
		local skillType, contextualID = GetSpellBookItemInfo(name)
		if (skillType == "SPELL") then
			--if (skillType) then
			if (instant) then --trigger only on totems
				for totemCat,k in pairs(TOCA.totems) do
					for totemSpell,v in pairs(TOCA.totems[totemCat]) do
						if (v[1] == name) then
							TOCA.Button.TotemicCall.recharge:SetCooldown(GetTime(), countDown)
							for totemCat,k in pairs(TOCA.totems) do
								TOCA.ExtendedTotemCooldowns(totemCat, spell, countDown)
							end
						end
					end
				end
				if (name == TOCA._L.SPELLS.TotemicCall) then
					TOCA.Button.TotemicCall.recharge:SetCooldown(GetTime(), countDown)
					for totemCat,k in pairs(TOCA.totems) do
						TOCA.ExtendedTotemCooldowns(totemCat, spell, countDown)
					end
				end
				for spellCat,v in pairs(TOCA._L.SPELLS.SHIELDS) do
					if (v == name) then
						TOCA.Button.TotemicCall.recharge:SetCooldown(GetTime(), countDown)
						for totemCat,k in pairs(TOCA.totems) do
							TOCA.ExtendedTotemCooldowns(totemCat, spell, countDown)
						end
						TOCA.TimerShield(TOCA.FrameMain.ShieldFrame, TOCA.ShamanShieldDuration*60)
						TOCA.NotificationAlertShield = 0 --clear the alerts
						TOCA.HasShield = 1
						--print("TOCA.HasShield " .. TOCA.HasShield)
					end
				end
			else
				TOCA.Button.TotemicCall.recharge:SetCooldown(GetTime(), countDown)
				for totemCat,k in pairs(TOCA.totems) do
					TOCA.ExtendedTotemCooldowns(totemCat, spell, countDown)
				end
			end
		end
	end
end

function TOCA.TotemBarTimerStart()
  for i=1, 4 do
		TOCA.GetTotemInfo(i)

		if (TOCA.TotemTimer[i] <= 0) then
			TOCA.TotemTimerReset(i)
			TOCA.TotemFunc[i] = C_Timer.NewTicker(1, function() TOCA.TimerFrame(i) end, TOCA.TotemDuration[i])
			TOCA.TotemTimer[i] = TOCA.TotemDuration[i]
		end
  end
	TOCA.Notification("TOCA.TotemBarTimerStart()", true)
end

function TOCA.GetReincTimer() --always checking
  --local numTabs = GetNumTalentTabs()
  local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(TOCA._L.SPELLS.Reincarnation)
  if (name) then
    local start, duration, enabled = GetSpellCooldown(name)
    if (duration) then
      if (enabled == 0) then
        --DEFAULT_CHAT_FRAME:AddMessage(name.." is currently active, use it and wait " .. duration .. " seconds for the next one.")
      elseif (start > 0 and duration > 0) then
        local reincTimeLeftCalc = start + duration - GetTime()
        local reincTimeLeftRT = reincTimeLeftCalc / 60
        TOCA.ReincTimer = math.ceil(reincTimeLeftCalc / 60)
        --TOCA.Notification(name.." is cooling down, wait " .. TOCA.ReincTimer, true)
        TOCA.FrameMain.ReincFrame.text:SetText(TOCA.ReincTimer .. " m")
        TOCA.FrameMain.ReincFrame:Show()
      else
        TOCA.FrameMain.ReincFrame:Hide()
        --TOCA.Notification(name.." is ready.", true)
      end
    end
  end

  if (TOCA.Game.version == 1) then --classic
    TOCA.FrameMain.ReincFrame:Hide()
  end
end

function TOCA.GetShieldTimer()
  if (TOCADB[TOCA.player.combine]["CONFIG"]["SHIELD"] == "OFF") then
		return
	end
  local _Uindex = 1
	TOCA.FrameMain.ShieldFrame:Hide()
  while UnitAura("player", _Uindex) do
	  local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura("player", _Uindex)
		for k,v in pairs(TOCA._L.SPELLS.SHIELDS) do --it's a shield spell, ignore everything else
			if (string.find(name, v)) then
				TOCA.FrameMain.ShieldFrame:Show()
				local current_shield = nil
				for shieldCat,shieldIndex in pairs(TOCA.spell.SHIELD) do
					for k,shieldID in pairs(TOCA.spell.SHIELD[shieldCat]) do
						if (spellId == shieldID) then
							current_shield = shieldCat
						end
					end
				end
				if (current_shield == "LIGHTNING_SHIELD") then
					TOCA.FrameMain.ShieldFrame:SetBackdrop(TOCA.SetIcon("spell_nature_lightningshield"))
				elseif (current_shield == "EARTH_SHIELD") then
					TOCA.FrameMain.ShieldFrame:SetBackdrop(TOCA.SetIcon("spell_nature_skinofearth"))
				else --default to water
					TOCA.FrameMain.ShieldFrame:SetBackdrop(TOCA.SetIcon("ability_shaman_watershield"))
				end
				if (TOCA.ShieldExpirationTimer <= 0) then --something went wrong, have a timer display backup
					local timeDuration = duration + expirationTime - GetTime()
					timeDuration = timeDuration / 120 --on first load or reload
					local shieldTime = timeDuration
					if (shieldTime >= 9.5) then shieldTime=10 end
					--print(shieldTime)
					TOCA.FrameMain.ShieldFrame.timer:SetText(math.floor(shieldTime) .. " m")
				end
				TOCA.FrameMain.ShieldFrame.count:SetText("")
				if (count >= 2) then
					TOCA.FrameMain.ShieldFrame.count:SetText(count)
				end
		  end
	  end
		_Uindex = _Uindex + 1
  end
end

TOCA.SlotGrid.VerticalTimer={}
TOCA.SlotGrid.HorizontalTimer={}
function TOCA.TotemTimerReset(i)
  if (i == "all") then
    for i=1, 4 do
      TOCA.TotemFunc[i]:Cancel()
      TOCA.TotemTimer[i] = 0
      TOCA.Slot.Timer[i]:SetText("")
      TOCA.SlotGrid.VerticalTimer[i]:SetText("")
      TOCA.SlotGrid.HorizontalTimer[i]:SetText("")
    end
		for totemCat,v in pairsByKeys(TOCA.totems) do --place vert and horz here?
			for index,totemSpell in pairs(TOCA.totems[totemCat]) do
				TOCA.FrameSeg.Button[totemCat][index].timer:SetText("")
			end
		end
		--print("Totem Timer reset!")
  else
    TOCA.TotemFunc[i]:Cancel()
    TOCA.TotemTimer[i] = 0
    TOCA.Slot.Timer[i]:SetText("")
    TOCA.SlotGrid.VerticalTimer[i]:SetText("")
    TOCA.SlotGrid.HorizontalTimer[i]:SetText("")
		local totemCat = nil
		if (i == 1) then totemCat = "FIRE" end
		if (i == 2) then totemCat = "EARTH" end
		if (i == 3) then totemCat = "WATER" end
		if (i == 4) then totemCat = "AIR" end
		if (totemCat) then
			for index,totemSpell in pairs(TOCA.totems[totemCat]) do
				TOCA.FrameSeg.Button[totemCat][index].timer:SetText("")
			end
		end
  end
  TOCA.Notification("TOCA.TotemTimerReset("..i..")", true)
end

function TOCA.TotemTimerResetBySpell(spellID)
  local spell = GetSpellInfo(spellID)
  local totemCatSpell={}
  if (spell) then
    totemCatSpell.fire = getKeyFromValue(TOCA.totems.FIRE, spell, 1)
    if (totemCatSpell.fire) then
      TOCA.TotemTimerReset(1)
    end
    totemCatSpell.earth = getKeyFromValue(TOCA.totems.EARTH, spell, 1)
    if (totemCatSpell.earth) then
      TOCA.TotemTimerReset(2)
    end
    totemCatSpell.water = getKeyFromValue(TOCA.totems.WATER, spell, 1)
    if (totemCatSpell.water) then
      TOCA.TotemTimerReset(3)
    end
    totemCatSpell.air = getKeyFromValue(TOCA.totems.AIR, spell, 1)
    if (totemCatSpell.air) then
      TOCA.TotemTimerReset(4)
    end
  end
end

function TOCA.HandleShieldAlert()
	if (TOCADB[TOCA.player.combine]["CONFIG"]["NOTIFYCOMBAT"] == "OFF") then
		TOCA.ExpireNotificationsShield()
	else
		if (TOCA.isInCombat) then
			TOCA.ExpireNotificationsShield()
		end
	end
end

function TOCA.OnUpdateEvent(event)
	if (TOCA.player.classID == 7) then --shaman
	  local percMana = (UnitPower("player")/UnitPowerMax("player"))*100
	  local percMana = floor(percMana+0.5)
	  --local onTaxi = UnitOnTaxi("player")
	  --TOCA.Notification("mana: " .. percMana, true)
	  TOCA.Button.TotemicCall.flash:Hide()
    --TOCA.TotemInRange={} --clear the array
	  if ((UnitOnTaxi("player")) or (percMana <= 1)) then
	    TOCA.EnableTotems(false)
	  else
	    TOCA.EnableTotems(true)
	  end

		if (TOCADB[TOCA.player.combine]["CONFIG"]["TOTEMRADIUSVISUAL"] ~= "OFF") then
			TOCA.TotemAuraRadius(event)
		end

	  for i=1, 4 do
	    TOCA.GetTotemInfo(i)
			if ((TOCA.TotemPresent[i]) and (TOCA.TotemName[i] ~= "")) then
	      TOCA.Button.TotemicCall.flash:Show()
			end
	  end

		TOCA.GetReincTimer()
		TOCA.GetShieldTimer()
	  TOCA.DisplayAnkhFrame()
		TOCA.HandleShieldAlert()
		TOCA.GetShieldFromTanks()
	end
end

function TOCA.Combat(event)
  for totemCat,v in pairsByKeys(TOCA.totems) do
    if (event == "PLAYER_REGEN_DISABLED") then
      TOCA.isInCombat = true
      TOCA.SlotSelect[totemCat]:Hide()
      TOCA.Button.DropdownMain:Hide()
      TOCA.Button.CloseMain:Hide()
      if (TOCADB[TOCA.player.combine]["CONFIG"]["COMBATLOCK"] == "OFF") then
        TOCA.FrameMain:SetMovable(true)
        TOCA.FrameMain:EnableMouse(true)
      else
        TOCA.FrameMain:SetMovable(false)
        TOCA.FrameMain:EnableMouse(false)
      end
      TOCA.Notification("Combat Initiated", true)
    end
    if (event == "PLAYER_REGEN_ENABLED") then
      TOCA.isInCombat = false
      TOCA.SlotSelect[totemCat]:Show()
      TOCA.Button.DropdownMain:Show()
      if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMESTYLE"]) then
        TOCA.FrameStyleSet(TOCADB[TOCA.player.combine]["CONFIG"]["FRAMESTYLE"])
      end
      TOCA.FrameMain:SetMovable(true)
      TOCA.FrameMain:EnableMouse(true)
      if (TOCADB[TOCA.player.combine]["CONFIG"]["MAINMENU"] == "OFF") then
        TOCA.Button.CloseMain:Hide()
      else
        TOCA.Button.CloseMain:Show()
      end
			if (TOCADB[TOCA.player.combine]["CONFIG"]["MAINMENUOPT"] == "ON") then
        TOCA.Button.Options:Show()
      else
        TOCA.Button.Options:Hide()
      end
      TOCA.Notification("Combat Ended", true)
    end
  end
end

function TOCA.InventoryCountItem(itemID)
  --[==[
	local i = 0
  for bag = 0, NUM_BAG_SLOTS do
    for slot=1,C_Container.GetContainerNumSlots(bag) do
      if (itemID == C_Container.GetContainerItemID(bag,slot)) then
        i=i+(select(2, C_Container.GetContainerItemInfo(bag, slot)))
      end
    end
  end
  return i
	]==]--
	return 10
end

function TOCA.SendPacket(packet, channel, compress)
  compressPacket = packet
  if (compress) then
    compressPacket = packet:gsub("%s+", "") --filter spaces
  end
	TOCA.Notification("sending packet " .. compressPacket, true)
	if (channel == "GUILD") then
		if (not IsInGuild()) then return end
	end
  C_ChatInfo.SendAddonMessage(TOCA._G.prefix, compressPacket, channel)
  TOCA.Notification("sending packet " .. compressPacket, true)
end

function TOCA.ParsePacket(netpacket, code)
  if (netpacket) then
    if (string.sub(netpacket, 1, strlen(code)) == code) then
      parse = string.gsub(netpacket, code, "")
      return parse
    end
  end
end

function TOCA.GetTotemOrder()
  local buildOrder = ""
  for k, v in ipairs(TOCADB[TOCA.player.combine]["CONFIG"]["TOTEMORDER"]) do
    buildOrder = buildOrder .. v
  end
  return buildOrder
end

--TOCA.TotemNum={}
local totemButtonPos_X={}
local totemButtonPos_Y={}
function TOCA.SetTotemOrder()
  local buildOrder = TOCA.GetTotemOrder()
  local totemOrder = split(buildOrder, ",")
  for k,v in ipairs(totemOrder) do
    TOCA.Slot[v]:SetPoint("TOPLEFT", -15+TOCA.SlotPosX[k], -35) --main frame
    TOCA.FrameSetsSlot[v]:SetPoint("TOPLEFT", -60+TOCA.SlotSetsPosX[k], -70) --options frame

    for totemCat,notUsed in pairsByKeys(TOCA.totems) do
      --totemNum = totemNum +1
      totemButtonPos_Y[totemCat] = 0
      totemButtonPos_X[totemCat] = 0
      for i,totemSpell in pairs(TOCA.totems[totemCat]) do
        totemButtonPos_Y[totemCat] = totemButtonPos_Y[totemCat]+TOCA.Slot_h
        totemButtonPos_X[totemCat] = totemButtonPos_X[totemCat]+TOCA.Slot_w
        local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.SlotGrid.VerticalTotemButton[totemCat][i]:GetPoint()
        if (TOCA.SlotGrid.VerticalTotemButton[v][i]) then
          --TOCA.SlotGrid.VerticalTotemButton[v][i]:SetPoint("TOPLEFT", -15+TOCA.SlotPosX[k], yOfs)
					TOCA.SlotGrid.VerticalTotemButton[v][i]:SetPoint("CENTER", 0, yOfs)
          if (TOCA.totems.AIR[1][1] == totemSpell[1]) then
            local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.SlotGrid.VerticalTotemButton.AIR[1]:GetPoint()
            TOCA.SlotGrid.VerticalTimer[4]:SetPoint("TOPLEFT", xOfs, -26)
          end
          if (TOCA.totems.EARTH[1][1] == totemSpell[1]) then
            local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.SlotGrid.VerticalTotemButton.EARTH[1]:GetPoint()
            TOCA.SlotGrid.VerticalTimer[2]:SetPoint("TOPLEFT", xOfs, -26)
          end
          if (TOCA.totems.FIRE[1][1] == totemSpell[1]) then
            local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.SlotGrid.VerticalTotemButton.FIRE[1]:GetPoint()
            TOCA.SlotGrid.VerticalTimer[1]:SetPoint("TOPLEFT", xOfs, -26)
          end
          if (TOCA.totems.WATER[1][1] == totemSpell[1]) then
            local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.SlotGrid.VerticalTotemButton.WATER[1]:GetPoint()
            TOCA.SlotGrid.VerticalTimer[3]:SetPoint("TOPLEFT", xOfs, -26)
          end
        end
      end
      for i,totemSpell in pairs(TOCA.totems[totemCat]) do
        totemButtonPos_Y[totemCat] = totemButtonPos_Y[totemCat]+TOCA.Slot_h
        totemButtonPos_X[totemCat] = totemButtonPos_X[totemCat]+TOCA.Slot_w
        local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.SlotGrid.HorizontalTotemButton[totemCat][i]:GetPoint()
        if (TOCA.SlotGrid.HorizontalTotemButton[v][i]) then
          TOCA.SlotGrid.HorizontalTotemButton[v][i]:SetPoint("TOPLEFT", xOfs, -TOCA.SlotPosX[k]-4)
          if (TOCA.totems.AIR[1][1] == totemSpell[1]) then
            local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.SlotGrid.HorizontalTotemButton.AIR[1]:GetPoint()
            TOCA.SlotGrid.HorizontalTimer[4]:SetPoint("TOPLEFT", 5, yOfs-12)
          end
          if (TOCA.totems.EARTH[1][1] == totemSpell[1]) then
            local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.SlotGrid.HorizontalTotemButton.EARTH[1]:GetPoint()
            TOCA.SlotGrid.HorizontalTimer[2]:SetPoint("TOPLEFT", 5, yOfs-12)
          end
          if (TOCA.totems.FIRE[1][1] == totemSpell[1]) then
            local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.SlotGrid.HorizontalTotemButton.FIRE[1]:GetPoint()
            TOCA.SlotGrid.HorizontalTimer[1]:SetPoint("TOPLEFT", 5, yOfs-12)
          end
          if (TOCA.totems.WATER[1][1] == totemSpell[1]) then
            local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.SlotGrid.HorizontalTotemButton.WATER[1]:GetPoint()
            TOCA.SlotGrid.HorizontalTimer[3]:SetPoint("TOPLEFT", 5, yOfs-12)
          end
        end
      end
    end
  end
  TOCA.Notification("TOCA.SetTotemOrder()", true)
  TOCA.Notification(buildOrder, true)
end

function TOCA.SetTotemOrderDropdown() --handled on Init() ONLY
  local buildOrder = TOCA.GetTotemOrder()
  local totemOrder = split(buildOrder, ",")
  for k,v in ipairs(totemOrder) do
    TOCA.Dropdown.OrderSet[k].text:SetText(v)
  end
end

TOCA.Dropdown.OrderSetMenu=TOCA.AlphaOrder
function TOCA.BuildTotemOrder()
  local buildOrder = ""
  local totemOrder = ""
  for i=1, getn(TOCA.Dropdown.OrderSetMenu) do
    totemOrder = totemOrder .. TOCA.Dropdown.OrderSet[i].text:GetText() .. ","
  end
  buildOrder = totemOrder
  buildOrder = buildOrder:sub(1, -2)
  TOCADB[TOCA.player.combine]["CONFIG"]["TOTEMORDER"] = {buildOrder}
  TOCA.SetTotemOrder()
end

function TOCA.FrameBorder(frame)

end

function TOCA.ReportFeedSend()
	local source = "GUILD"
	if (IsInGuild()) then
		source = "GUILD"
  end
	if (IsInRaid()) then
		source = "RAID"
	elseif (IsInGroup()) then
		source = "PARTY"
	end
	TOCA.SendPacket(TOCA.Net.report_s .. TOCA.player.name .. "," .. source, source)
end
function TOCA.ReportFeedGet(prefix, netpacket)
	local getPacket = TOCA.ParsePacket(netpacket, TOCA.Net.report_s)
	if (getPacket) then
		--print("received signal... sending ...")
		local packet = split(getPacket, ",")
		if (packet[1] ~= TOCA.player.name) then
			TOCA.SendPacket(TOCA.Net.report_g .. packet[1] .. "," .. TOCA.player.name .. "," .. TOCA._G.version .. "," .. packet[2], packet[2])
		end
	end
end
function TOCA.ReportFeedResult(prefix, netpacket)
	local getPacket = TOCA.ParsePacket(netpacket, TOCA.Net.report_g)
	if (getPacket) then
		local packet = split(getPacket, ",")
		if (packet[1] == TOCA.player.name) then --give to requester only
			TOCA.Notification("[" .. packet[4] .. "] " .. packet[2] .. " = " .. packet[3])
		end
	end
end

SLASH_TOCA1 = TOCA._G.CMD
function SlashCmdList.TOCA(cmd)
  if ((cmd == nil) or (cmd == "")) then
    TOCA.Notification("v" .. TOCA._G.version .. "-" .. TOCA._G.suffix .. " ("..GetLocale()..")")
		for int,list in pairs(TOCA._L.COMMANDS) do
			print("|cffffff00".. list[1] .. "|r : " .. list[2] .. "|n")
		end
	end
	local _, _, cmd, args = string.find(cmd, "%s?(%w+)%s?(.*)")
	if (cmd == TOCA._L.COMMANDS[1][1]) then
	  TOCA.FrameOptions:Show()
  elseif (cmd == TOCA._L.COMMANDS[2][1]) then
		TOCA.FrameMain:Show()
		if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMESTYLE"] == TOCA._L.UI.FRAMESTYLES[2]) then --segmented
			for totemCat,v in pairsByKeys(TOCA.totems) do
				TOCA.FrameSeg[totemCat]:Show()
			end
		end
		TOCADB[TOCA.player.combine]["DISABLED"] = "NO"
	elseif (cmd == TOCA._L.COMMANDS[3][1]) then
		TOCA.FrameMain:Hide()
	elseif (cmd == TOCA._L.COMMANDS[4][1]) then
		TOCA.Notification("|r : " .. TOCA.player.combine)
	elseif (cmd == TOCA._L.COMMANDS[5][1]) then
		TOCA.FrameAssignments:Show()
	elseif (cmd == TOCA._L.COMMANDS[6][1]) then
		TOCA.FrameHelp:Show()
	elseif (cmd == TOCA._L.COMMANDS[7][1]) then
		TOCA.DEBUG = true
		TOCA.Notification("DEBUG ON")
	elseif (cmd == TOCA._L.COMMANDS[8][1]) then
		TOCA.DEBUG = false
		TOCA.Notification("DEBUG OFF")
	elseif (cmd == TOCA._L.COMMANDS[9][1]) then
		print(string.format("version = %s, build = %s, date = '%s', tocversion = %s.", __Gversion, __Gbuild, __Gdate, __Gtoc))
	elseif (cmd == "report") then
		TOCA.ReportFeedSend()
	elseif (cmd == "set") then
		if (args ~= "") then
			local existingSet = 0
			for k,v in pairs(TOCADB[TOCA.player.combine]["PROFILES"]) do
				if (k == args) then
					TOCA.SetDDMenu(TOCA.Dropdown.Main, args)
					TOCA.FrameSetsProfile:SetText(args)
					existingSet = 1
				end
			end
			if (existingSet == 1) then
				TOCA.Notification("Set: [" .. args .. "] applied")
			else
				TOCA.Notification("|cfff55320Unknown Set:|r " .. args)
			end
		else
			TOCA.Notification("set <name>")
			TOCA.SetDDMenu(TOCA.Dropdown.Main, TOCA.Dropdown.Menu[1])
			TOCA.FrameSetsProfile:SetText(TOCA.Dropdown.Menu[1])
		end
	end
end
