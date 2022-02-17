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

TOCA.DEBUG = false

TOCA.Global = {
  title  = "|cff0070DD".. TOCA.locale.TITLE .."|r",
  author = "Porthias of Myzrael",
  version= 2.47,
  command= "toca",
  width  = 150,
  height = 85,
  font   = "Fonts/FRIZQT__.TTF",
  dir    = "Interface/Addons/TotemCaddy/",
  prefix = "TotemCaddy",
  suffix = "BCC",
	date   = date("%Y%m%d"),
	update = 20220320,
}
--local _LName, _LTitle = GetAddOnInfo(TOCA.Global.prefix)
--TOCA.Global.version = tonumber(string.sub(_LTitle, 26, 29))

TOCA.Game={}
TOCA.Game.version = tonumber(string.sub(__Gversion, 1, 1))
if (TOCA.Game.version == 1) then
  TOCA.Global.suffix = "Classic"
end

TOCA.Net = {
  prefix = "0xEFVe",
}

TCCMD = "/"..TOCA.Global.command

TOCA.Backdrop={}
TOCA.Backdrop.General = {
  bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
}

TOCA.Backdrop.Main = {
  bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
  edgeFile= "Interface/TUTORIALFRAME/TUTORIALFRAMEBORDER",
  edgeSize= 20,
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

TOCA.Backdrop.Borderless = {
  bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
  edgeFile= "",
  edgeSize= 20,
  insets  = {left=2, right=2, top=2, bottom=2},
}

TOCA.Backdrop.BorderOnly= {
  bgFile  = "",
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
}

--all icons must be in order to sync with totemspells[locales] by category
TOCA.icons = {
	 FIRE = {
	  "spell_fire_sealoffire",
	  "spell_nature_guardianward",
	  "spell_frostresistancetotem_01",
	  "spell_fire_selfdestruct",
	  "spell_fire_searingtotem",
	  "spell_fire_totemofwrath",
  },
	EARTH = {
	  "spell_nature_strengthofearthtotem02",
	  "spell_nature_stoneclawtotem",
	  "spell_nature_stoneskintotem",
	  "spell_nature_earthbindtotem",
	  "spell_nature_tremortotem",
	},
  WATER = {
	  "spell_nature_diseasecleansingtotem",
	  "spell_fireresistancetotem_01",
	  "inv_spear_04",
	  "spell_nature_manaregentotem",
	  "spell_frost_summonwaterelemental",
	  "spell_nature_poisoncleansingtotem",
	},
	AIR = {
	  "spell_nature_invisibilitytotem",
	  "spell_nature_groundingtotem",
	  "spell_nature_natureresistancetotem",
	  "spell_nature_removecurse",
	  "spell_nature_brilliance",
	  "spell_nature_windfury",
	  "spell_nature_earthbind",
	  "spell_nature_slowingtotem",
	}
}

--TOCA.IdentifySpellName(15107) --fire nova totem
TOCA.totems.ID = {}
TOCA.totems.ID.FIRE = {
	1535, --fire nova
	8227, --flametongue
	8181, --frost resist
	8190, --magma
	3599, --searing
	30706, --totem of wrath
}
TOCA.totems.ID.EARTH = {
  2484, --eathbind
	5730, --stoneclaw
  8071, --stoneskin
	8075, --strength of earth
	8143, --tremor
}
TOCA.totems.ID.WATER = {
	8170, --disease cleanse
	8184, --fire resist
	5394, --healing stream
  5675, --mana spring
	16190, --mana tide
	38306, --poison cleansing
}
TOCA.totems.ID.AIR = {
	8835, --grace
	8177, --grounding
	10595, --nature resist
	6495, --sentry
	25908, --tranquil air
	8512, --windfury
	15107, --windwall
	3738, --wrath of air
}

function TOCA.IdentifySpell(spellID) --used for different languages
  local spell = GetSpellInfo(spellID)
	if (spell) then return spell end
end

--build all totems for the respective language (rank 1)
TOCA.locale.TOTEMS = {FIRE={}, EARTH={}, WATER={}, AIR={}}
for totemCat,v in pairsByKeys(TOCA.totems.ID) do
	for k,v in pairsByKeys(TOCA.totems.ID[totemCat]) do
		TOCA.locale.TOTEMS[totemCat][k] = TOCA.IdentifySpell(TOCA.totems.ID[totemCat][k])
	end
end

TOCA.locale.SPELLS.Reincarnation = TOCA.IdentifySpell(TOCA.spell.REINCARNATION)
TOCA.locale.SPELLS.TotemicCall = TOCA.IdentifySpell(TOCA.spell.TOTEMIC_CALL)
TOCA.locale.SPELLS.SHIELDS = {
	TOCA.IdentifySpell(TOCA.spell.WATER_SHIELD),
	TOCA.IdentifySpell(TOCA.spell.LIGHTNING_SHIELD),
	TOCA.IdentifySpell(TOCA.spell.EARTH_SHIELD),
}

--match the totems spells to their respective icons
TOCA.totems = {FIRE={}, EARTH={}, WATER={}, AIR={}} --cached order
for totemCat,v in pairsByKeys(TOCA.totems) do
	for k,v in pairsByKeys(TOCA.locale.TOTEMS[totemCat]) do
		TOCA.totems[totemCat][k] = {}
		TOCA.totems[totemCat][k][1] = TOCA.locale.TOTEMS[totemCat][k]
		TOCA.totems[totemCat][k][2] = TOCA.icons[totemCat][k]
	end
end

TOCA.version_alerted = 0
function TOCA.VersionControl(netprefix, netpacket)
	if (TOCA.version_alerted == 0) then
	  if (netprefix == TOCA.Global.prefix) then
	    local getPacket = TOCA.ParsePacket(netpacket, TOCA.Net.prefix)
	    if (getPacket) then
	      local latest_version = tonumber(getPacket)
	      local my_version = tonumber(TOCA.Global.version)
	      if (latest_version > my_version) then --2 minor
	        TOCA.Notification("|cfffc2121" .. TOCA.locale.INIT[7] .. ". Latest version:|cffffedad " .. latest_version)
	        TOCA.version_alerted = tonumber(latest_version)
	      end
	    end
	  end
		if (tonumber(TOCA.Global.date) >= tonumber(TOCA.Global.update)) then
	    TOCA.Notification("|cfffc2121" .. TOCA.locale.INIT[7])
			TOCA.version_alerted = 1
		end
	end
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
TOCA.globalTimerInMinutes = true --default
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

if (TOCA.Game.version == 1) then --classic
  table.remove(TOCA.totems.FIRE, 6) --totem of wrath
  table.remove(TOCA.totems.AIR, 2) --grounding totem
end

--default totem slots
TOCA.cache={}
for totemInt,totemCat in pairsByKeys(TOCA.AlphaOrder) do
	TOCA.cache[totemInt] = TOCA.totems[totemCat][1][1]
end

function TOCA.Notification(msg, debug)
  if ((debug) and (TOCA.DEBUG)) then
    print(TOCA.Global.title .. " DEBUG: " .. msg)
  end
  if (not debug) then
    print(TOCA.Global.title .. " " .. msg)
  end
end

function TOCA.BuildKeyBindsInit()
  BINDING_HEADER_TOTEMCADDY = TOCA.Global.title
  for KeyBK,KeyBV in pairsByKeys(TOCA.locale.KEYBINDS) do
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
    bgFile="Interface/AddOns/".. TOCA.Global.prefix .."/images/" .. icon,
    edgeFile="Interface/ToolTips/UI-Tooltip-Border",
    edgeSize=12,
    insets={left=2, right=2, top=2, bottom=2},
  }
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
	    TOCA.SetKeyBindReset(title, TOCA.locale.SPELLS.TotemicCall)
			--TOCA.Button.KeyBind[1].Title:SetText(TOCA.locale.KEYBINDS[title])
			--TOCA.Button.KeyBind[1].Text:SetText(GetBindingKey(title))
		end

		if (TOCA.cache[1]) then
			local title = "TOTEM_AIR"
      TOCA.SetKeyBindReset(title, TOCA.cache[1])
			--TOCA.Button.KeyBind[2].Title:SetText(TOCA.locale.KEYBINDS[title])
			--TOCA.Button.KeyBind[2].Text:SetText(GetBindingKey(title))
    end
    if (TOCA.cache[2]) then
			local title = "TOTEM_EARTH"
      TOCA.SetKeyBindReset(title, TOCA.cache[2])
			--TOCA.Button.KeyBind[3].Title:SetText(TOCA.locale.KEYBINDS[title])
			--TOCA.Button.KeyBind[3].Text:SetText(GetBindingKey(title))
    end
    if (TOCA.cache[3]) then
			local title = "TOTEM_FIRE"
      TOCA.SetKeyBindReset(title, TOCA.cache[3])
			--TOCA.Button.KeyBind[4].Title:SetText(TOCA.locale.KEYBINDS[title])
			--TOCA.Button.KeyBind[4].Text:SetText(GetBindingKey(title))
    end
    if (TOCA.cache[4]) then
			local title = "TOTEM_WATER"
      TOCA.SetKeyBindReset(title, TOCA.cache[4])
			--TOCA.Button.KeyBind[5].Title:SetText(TOCA.locale.KEYBINDS[title])
			--TOCA.Button.KeyBind[5].Text:SetText(GetBindingKey(title))
    end
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

TOCA.SlotSelectTotemDisabled={}
TOCA.FrameSetsSlotDisabled={}
TOCA.SlotGrid={}
TOCA.SlotGrid.VerticalTotemButton={}
TOCA.SlotGrid.HorizontalTotemButton={}
for totemCat,v in pairsByKeys(TOCA.totems) do
  TOCA.SlotSelectTotemDisabled[totemCat]={}
  TOCA.FrameSetsSlotDisabled[totemCat]={}
  TOCA.SlotGrid.VerticalTotemButton[totemCat]={}
  TOCA.SlotGrid.HorizontalTotemButton[totemCat]={}
end

function TOCA.EnableTotems(enable)
  if (enable) then
    TOCA.TotemsEnabled = true
    for totemCat,v in pairsByKeys(TOCA.totems) do
      TOCA.Slot.Disable[totemCat]:Hide()
      for i,totemSpell in pairs(TOCA.totems[totemCat]) do
        TOCA.SlotGrid.VerticalTotemButton[totemCat][i].disable:Hide()
        TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].disable:Hide()
      end
    end
    TOCA.Notification("TOCA.EnableTotems()", true)
  else
    TOCA.TotemsEnabled = false
    for totemCat,v in pairsByKeys(TOCA.totems) do
      TOCA.Slot.Disable[totemCat]:Show()
      for i,totemSpell in pairs(TOCA.totems[totemCat]) do
        TOCA.SlotGrid.VerticalTotemButton[totemCat][i].disable:Show()
        TOCA.SlotGrid.HorizontalTotemButton[totemCat][i].disable:Show()
      end
    end
  end
end

function TOCA.EnableKnownTotems()
  if (TOCA.TotemsEnabled) then
		local TotemicCall = GetSpellInfo(TOCA.locale.SPELLS.TotemicCall)
		if (not TotemicCall) then
			TOCA.HideUnknownSpells(true)
		end

    if (TOCA.isInCombat) then
      TOCA.Notification("In Combat, do nothing! TOCA.EnableKnownTotems()", true)
    else
      for totemCat,v in pairsByKeys(TOCA.totems) do
        for i,totemSpell in pairs(TOCA.totems[totemCat]) do
          TOCA.SlotSelectTotemDisabled[totemCat][i]:Show()
          TOCA.FrameSetsSlotDisabled[totemCat][i]:Show()
          TOCA.SlotGrid.VerticalTotemButton[totemCat][i]:Hide()
          TOCA.SlotGrid.HorizontalTotemButton[totemCat][i]:Hide()
          local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(totemSpell[1])
          if (name) then
            TOCA.SlotSelectTotemDisabled[totemCat][i]:Hide()
            TOCA.FrameSetsSlotDisabled[totemCat][i]:Hide()
            TOCA.SlotGrid.VerticalTotemButton[totemCat][i]:Show()
            TOCA.SlotGrid.HorizontalTotemButton[totemCat][i]:Show()
          end
        end
      end
      TOCA.Notification("TOCA.EnableKnownTotems()", true)
    end
  end
end

function TOCA.FrameStyleDefault()
  TOCA.FrameMain:SetHeight(TOCA.Global.height)
  TOCA.FrameMain:SetWidth(TOCA.Global.width)
  TOCA.FrameMain.Background:SetWidth(TOCA.Global.width)
  TOCA.FrameMain.Background:SetHeight(TOCA.Global.height)
  TOCA.Button.TotemicCall:SetPoint("CENTER", 0, 40)
end
function TOCA.FrameStyleSet(style)
  if (style == TOCA.Dropdown.FrameStyles[1]) then --classic
    TOCA.FrameStyleDefault()
    TOCA.FrameMain.ReincFrame:SetPoint("TOPLEFT", TOCA.Global.width-4, -14)
    TOCA.FrameMain.AnkhFrame:SetPoint("TOPLEFT", TOCA.Global.width-4, -44)
    TOCA.Button.TotemicCall.ECL:SetPoint("CENTER", -30, 61)
    TOCA.Button.TotemicCall.ECR:SetPoint("CENTER", 30, 61)
    for totemCat,v in pairsByKeys(TOCA.totems) do
      TOCA.Slot[totemCat]:Show()
      TOCA.Button.DropdownMain:Show()
      TOCA.FrameMainGridVertical:Hide()
      TOCA.FrameMainGridHorizontal:Hide()
    end
  elseif (style == TOCA.Dropdown.FrameStyles[2]) then --vert
    TOCA.FrameStyleDefault()
    TOCA.FrameMain.ReincFrame:SetPoint("TOPLEFT", TOCA.Global.width-4, -14)
    TOCA.FrameMain.AnkhFrame:SetPoint("TOPLEFT", TOCA.Global.width-4, -44)
    TOCA.FrameMain:SetHeight(TOCA.Global.height+240)
    TOCA.FrameMain.Background:SetHeight(TOCA.Global.height+240)
    TOCA.Button.TotemicCall:SetPoint("CENTER", 0, 160)
    TOCA.Button.TotemicCall.ECL:SetPoint("CENTER", -30, 181)
    TOCA.Button.TotemicCall.ECR:SetPoint("CENTER", 30, 181)
    for totemCat,v in pairsByKeys(TOCA.totems) do
      TOCA.Slot[totemCat]:Hide()
      TOCA.Button.DropdownMain:Hide()
      TOCA.FrameMainGridVertical:Show()
      TOCA.FrameMainGridHorizontal:Hide()
    end
  elseif (style == TOCA.Dropdown.FrameStyles[3]) then --horz
    TOCA.FrameStyleDefault()
    TOCA.FrameMain.ReincFrame:SetPoint("TOPLEFT", TOCA.Global.width+171, -22)
    TOCA.FrameMain.AnkhFrame:SetPoint("TOPLEFT", TOCA.Global.width+171, -52)
    TOCA.FrameMain:SetHeight(TOCA.Global.height+84)
    TOCA.FrameMain.Background:SetHeight(TOCA.Global.height+84)
    TOCA.FrameMain:SetWidth(TOCA.Global.height+240)
    TOCA.FrameMain.Background:SetWidth(TOCA.Global.height+240)
    TOCA.Button.TotemicCall:SetPoint("CENTER", 0, 84)
    TOCA.Button.TotemicCall.ECL:SetPoint("CENTER", -30, 103)
    TOCA.Button.TotemicCall.ECR:SetPoint("CENTER", 30, 103)
    for totemCat,v in pairsByKeys(TOCA.totems) do
      TOCA.Slot[totemCat]:Hide()
      TOCA.Button.DropdownMain:Hide()
      TOCA.FrameMainGridVertical:Hide()
      TOCA.FrameMainGridHorizontal:Show()
    end
  end
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
    TOCA.Button.Options:SetBackdropBorderColor(1, 1, 1, 0.8)
    TOCA.Button.CloseMain:SetBackdropBorderColor(1, 1, 1, 0.8)
    TOCA.Button.DropdownMain:SetBackdropBorderColor(1, 1, 1, 0.6)
    TOCA.FrameMain.ReincFrame:SetBackdropBorderColor(1, 1, 1, 0.6)
    TOCA.FrameMain.AnkhFrame:SetBackdropBorderColor(1, 1, 1, 0.6)
    for totemCat,v in pairsByKeys(TOCA.totems) do
      TOCA.Slot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
      TOCA.SlotSelect[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
      TOCA.SlotSelectMenu[totemCat]:SetBackdropBorderColor(1, 1, 1, 0.6)
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
      end
    end
  else
    TOCA.FrameMain.Background:SetBackdropBorderColor(1, 1, 1, 0)
    TOCA.Button.TotemicCall:SetBackdropBorderColor(1, 1, 1, 0)
    TOCA.Button.Options:SetBackdropBorderColor(1, 1, 1, 0)
    TOCA.Button.CloseMain:SetBackdropBorderColor(1, 1, 1, 0)
    TOCA.Button.DropdownMain:SetBackdropBorderColor(1, 1, 1, 0)
    TOCA.FrameMain.ReincFrame:SetBackdropBorderColor(1, 1, 1, 0)
    TOCA.FrameMain.AnkhFrame:SetBackdropBorderColor(1, 1, 1, 0)
    for totemCat,v in pairsByKeys(TOCA.totems) do
      TOCA.Slot[totemCat]:SetBackdropBorderColor(1, 1, 1, 0)
      TOCA.SlotSelect[totemCat]:SetBackdropBorderColor(1, 1, 1, 0)
      TOCA.SlotSelectMenu[totemCat]:SetBackdropBorderColor(1, 1, 1, 0)
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
      end
    end
  end
  TOCA.Notification("TOCA.BorderFrame()", true)
end

function TOCA.HideUnknownSpells(force)
	if ((TOCA.Game.version == 1) or (force)) then
		TOCA.Button.TotemicCall:Hide()
		TOCA.Button.TotemicCall.ECL:Hide()
		TOCA.Button.TotemicCall.ECR:Hide()
		TOCA.Checkbox.EndCaps:Hide()
		TOCA.Checkbox.Totemic:Hide()
		TOCA.Dropdown.FrameGryphons:Hide()
	end
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
    TOCA.Notification(TOCA.locale.INIT[1] .. ": " .. TOCA.player.combine)
    TOCADB[TOCA.player.combine]["PROFILES"][TOCA.Dropdown.Menu[1]] = {TOCA_AIR=TOCA.cache[1], TOCA_EARTH=TOCA.cache[2], TOCA_FIRE=TOCA.cache[3], TOCA_WATER=TOCA.cache[4]}
    TOCA.UpdateTotemSet()
  else
    TOCA.Notification(TOCA.locale.INIT[2] .. ": " .. TOCA.player.combine)
    if (TOCADB[TOCA.player.combine]["DISABLED"] == "YES") then
      TOCA.FrameMain:Hide()
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["SCALE"]) then
      TOCA.Slider.Scale:SetValue(TOCADB[TOCA.player.combine]["CONFIG"]["SCALE"])
      TOCA.Slider.Scale.Val:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["SCALE"])
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["MAINMENU"] == "OFF") then
      --TOCA.FrameMain.Background:SetBackdrop(TOCA.Backdrop.General)
      TOCA.Button.CloseMain:Hide()
      TOCA.Button.Options:Hide()
      TOCA.Checkbox.MainMenu:SetChecked(nil)
      TOCA.FrameMain.Background:SetPoint("CENTER", 0, 0)
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
      TOCA.Checkbox.FrameBorder:SetChecked(nil)
      TOCA.BorderFrame(false)
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["ENDCAPS"] == "OFF") then
      TOCA.Button.TotemicCall.ECL:Hide()
      TOCA.Button.TotemicCall.ECR:Hide()
      TOCA.Checkbox.EndCaps:SetChecked(nil)
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["TOTEMICCALL"] == "OFF") then
      TOCA.Button.TotemicCall.ECL:Hide()
      TOCA.Button.TotemicCall.ECR:Hide()
      TOCA.Checkbox.EndCaps:SetAlpha(0.5)
      TOCA.Dropdown.FrameGryphons:SetAlpha(0.5)
      TOCA.Checkbox.Totemic:SetChecked(nil)
      --TOCA.Checkbox.EndCaps:SetChecked(nil)
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["TIMERS"] == "OFF") then
      for i=1, 4 do
        TOCA.Slot.Timer[i]:Hide()
        TOCA.SlotGrid.VerticalTimer[i]:Hide()
        TOCA.SlotGrid.HorizontalTimer[i]:Hide()
      end
      TOCA.Checkbox.Timers:SetChecked(nil)
      TOCA.Checkbox.TimersInMinutes:SetAlpha(0.5)
      --TOCA.Checkbox.TimersInMinutes:SetChecked(nil)
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["TIMERSMINUTES"] == "OFF") then
      TOCA.globalTimerInMinutes = false
      TOCA.Checkbox.TimersInMinutes:SetChecked(nil)
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["REINC"] == "OFF") then
      TOCA.FrameMain.ReincFrame:Hide()
      TOCA.Checkbox.Reinc:SetChecked(nil)
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["ANKH"] == "OFF") then
      TOCA.FrameMain.AnkhFrame:Hide()
      TOCA.Checkbox.Ankh:SetChecked(nil)
    end

		if (TOCADB[TOCA.player.combine]["CONFIG"]["NOTIFYCOMBAT"] == "OFF") then
			TOCA.Checkbox.NotifyCombat:SetChecked(nil)
	  end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["EXPIREMESSAGE"] == "OFF") then
			TOCA.Checkbox.ExpireMessage:SetChecked(nil)
		end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["EXPIRESOUND"] == "OFF") then
			TOCA.Checkbox.ExpireSound:SetChecked(nil)
		end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDFILE"]) then
			TOCA.Dropdown.Sound.TotemExpire.text:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDFILE"])
		end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["EXPIREMESSAGESHIELD"] == "OFF") then
			TOCA.Checkbox.ShieldMessage:SetChecked(nil)
		end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["EXPIRESHIELD"] == "OFF") then
			TOCA.Checkbox.ShieldExpire:SetChecked(nil)
		end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDSHIELDFILE"]) then
			TOCA.Dropdown.Sound.ShieldExpire.text:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDSHIELDFILE"])
		end

    if (TOCADB[TOCA.player.combine]["CONFIG"]["TOTEMORDER"]) then
      TOCA.SetTotemOrderDropdown()
      TOCA.SetTotemOrder()
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["OPACITY"]) then
      TOCA.Slider.OpacityBG:SetValue(TOCADB[TOCA.player.combine]["CONFIG"]["OPACITY"])
      TOCA.Slider.OpacityBG.Val:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["OPACITY"])
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["OPACITYFG"]) then
      TOCA.Slider.OpacityFG:SetValue(TOCADB[TOCA.player.combine]["CONFIG"]["OPACITYFG"])
      TOCA.Slider.OpacityFG.Val:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["OPACITYFG"])
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMESTYLE"]) then
      TOCA.FrameStyleSet(TOCADB[TOCA.player.combine]["CONFIG"]["FRAMESTYLE"])
      TOCA.Dropdown.FrameStyle.text:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["FRAMESTYLE"])
    else
      TOCA.FrameStyleSet(TOCA.Dropdown.FrameStyles[1])
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
    if (TOCADB[TOCA.player.combine]["CONFIG"]["TOOLON"] == "OFF") then
      TOCA.Checkbox.Tooltip:SetChecked(nil)
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["TOOLMOUSE"] == "OFF") then
      TOCA.Checkbox.TooltipMouse:SetChecked(nil)
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["COMBATLOCK"] == "OFF") then
      TOCA.Checkbox.MainLock:SetChecked(nil)
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["ENDCAPSTYLE"] == "Lions") then
      TOCA.Dropdown.FrameGryphons.text:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["ENDCAPSTYLE"])
      TOCA.Button.TotemicCall.ECL:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Human")
      TOCA.Button.TotemicCall.ECR:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Human")
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

  TOCA.FrameOptionsMain.name = TOCA.Global.title
  InterfaceOptions_AddCategory(TOCA.FrameOptionsMain)

  TOCA.HideUnknownSpells(false) --check game version first

  if (TOCADB[TOCA.player.combine]["CONFIG"]["TOTEMICCALL"] == "OFF") then
    TOCA.Button.TotemicCall:Hide()
    TOCA.Button.TotemicCall.ECL:Hide()
    TOCA.Button.TotemicCall.ECR:Hide()
  end

  TOCA.Notification("TOCA.Init()", true)
end

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
  if (TOCADB[TOCA.player.combine]["CONFIG"]["TOOLON"] == "OFF") then
    return
  end
  local spellName, spellRank, spellID = GetSpellBookItemName(title)
  if (spellID) then --assure that there is a valid spell
    local knownSpell = TOCA.GetOwnerSpell(spellName)
    if (knownSpell) then
      if (anchor) then
        GameTooltip:SetOwner(owner, anchor)
      else
        if (TOCADB[TOCA.player.combine]["CONFIG"]["TOOLMOUSE"] == "OFF") then
          GameTooltip:SetOwner(owner, "ANCHOR_PRESERVE")
        else
          GameTooltip:SetOwner(owner, "ANCHOR_TOPLEFT")
        end
      end
      GameTooltip:ClearLines()
      GameTooltip:SetSpellBookItem(knownSpell, BOOKTYPE_SPELL)
      GameTooltip:Show()
    end
  else --manual
    if (anchor) then
      GameTooltip:SetOwner(owner, anchor)
    else
      if (TOCADB[TOCA.player.combine]["CONFIG"]["TOOLMOUSE"] == "OFF") then
        GameTooltip:SetOwner(owner, "ANCHOR_PRESERVE")
      else
        GameTooltip:SetOwner(owner, "ANCHOR_TOPLEFT")
      end
    end
    GameTooltip:ClearLines()
    if (title) then
      GameTooltip:AddLine(title, 1, 1, 1, 1)
      if (msg) then
        GameTooltip:AddDoubleLine(msg, "", 1, 0.8, 0, 0,0,1)
      else
        GameTooltip:AddDoubleLine(TOCA.locale.SPELLS.Unknown, "", 1, 0, 0, 0,0,1)
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
TOCA.TotemFunc={}

TOCA.TotemTimer={}
for i=1, 4 do
  TOCA.TotemTimer[i] = 0
  TOCA.TotemDuration[i] = 0
end

function TOCA.ExpireNotificationsTotems(totemname, totemtimer)
	if (totemtimer == 10) then
		if ((totemname ~= nil) or (totemname ~= "")) then
			if (TOCADB[TOCA.player.combine]["CONFIG"]["EXPIREMESSAGE"] ~= "OFF") then
				TOCA.Notification("|cfff6d526" .. totemname .. "|r ".. TOCA.locale.INIT[4])
			end
			if (TOCADB[TOCA.player.combine]["CONFIG"]["EXPIRESOUND"] ~= "OFF") then
				if (TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDFILE"]) then
					PlaySoundFile(TOCA.Global.dir .. "sounds/" .. TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDFILE"] .. ".ogg")
				else
					PlaySoundFile(TOCA.Global.dir .. "sounds/totemexpire_1.ogg")
				end
			end
		end
	end
end

shamanShieldDuration = 10 --10 minutes on ALL shields
notificationAlertShield = 0
function TOCA.ExpireNotificationsShield()
	local _Uindex = 1
	while UnitAura("player", _Uindex) do
		local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura("player", _Uindex)
		for k,v in pairs(TOCA.locale.SPELLS.SHIELDS) do
			if (string.find(name, v)) then
				local timeDuration = duration + expirationTime - GetTime()
				timeDuration = timeDuration / 120
				--timeDuration = floor(timeDuration)
				--print(timeDuration)
				if ((timeDuration >= shamanShieldDuration) and (count >= 2)) then
				  notificationAlertShield = 0 --reset / refreshed the aura
			  else
					if ((timeDuration < 1.0) or (count <= 1)) then
						if (notificationAlertShield ~= 1) then
							notificationAlertShield = 1
							if (TOCADB[TOCA.player.combine]["CONFIG"]["EXPIREMESSAGESHIELD"] ~= "OFF") then
								TOCA.Notification("|cfff6d526" .. name .. "|r ".. TOCA.locale.INIT[4])
							end
							if (TOCADB[TOCA.player.combine]["CONFIG"]["EXPIRESHIELD"] ~= "OFF") then
								if (TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDSHIELDFILE"]) then
									PlaySoundFile(TOCA.Global.dir .. "sounds/" .. TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDSHIELDFILE"] .. ".ogg")
								else
									PlaySoundFile(TOCA.Global.dir .. "sounds/shieldexpire_1.ogg")
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

function TOCA.TimerFrame(i)
  TOCA.TotemPresent[i], TOCA.TotemName[i], TOCA.TotemStartTime[i], TOCA.TotemDuration[i] = GetTotemInfo(i)
  if (TOCA.TotemPresent[i]) then
    TOCA.TotemTimer[i] = TOCA.TotemTimer[i] -1
    if (TOCA.globalTimerInMinutes) then
      TOCA.Slot.Timer[i]:SetText(TimeSecondsToMinutes(TOCA.TotemTimer[i]))
      TOCA.SlotGrid.VerticalTimer[i]:SetText(TimeSecondsToMinutes(TOCA.TotemTimer[i]))
      TOCA.SlotGrid.HorizontalTimer[i]:SetText(TimeSecondsToMinutes(TOCA.TotemTimer[i]))
    else
      TOCA.Slot.Timer[i]:SetText(TOCA.TotemTimer[i])
      TOCA.SlotGrid.VerticalTimer[i]:SetText(TOCA.TotemTimer[i])
      TOCA.SlotGrid.HorizontalTimer[i]:SetText(TOCA.TotemTimer[i])
    end
  else
    TOCA.Slot.Timer[i]:SetText("")
    TOCA.SlotGrid.VerticalTimer[i]:SetText("")
    TOCA.SlotGrid.HorizontalTimer[i]:SetText("")
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
    return
  end

  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMESTYLE"] == TOCA.Dropdown.FrameStyles[1]) then --classic
    for i=1, 4 do
      TOCA.Slot.Timer[i]:Show()
      TOCA.SlotGrid.VerticalTimer[i]:Hide()
      TOCA.SlotGrid.HorizontalTimer[i]:Hide()
    end
  end

  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMESTYLE"] == TOCA.Dropdown.FrameStyles[2]) then --vert
    for i=1, 4 do
      TOCA.Slot.Timer[i]:Hide()
      TOCA.SlotGrid.VerticalTimer[i]:Show()
      TOCA.SlotGrid.HorizontalTimer[i]:Hide()
    end
  end

  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMESTYLE"] == TOCA.Dropdown.FrameStyles[3]) then --horz
    for i=1, 4 do
      TOCA.Slot.Timer[i]:Hide()
      TOCA.SlotGrid.VerticalTimer[i]:Hide()
      TOCA.SlotGrid.HorizontalTimer[i]:Show()
    end
  end
end

TOCA.RechargeTimer = 0
function TOCA.TimerFrameRecharge()
	TOCA.RechargeTimer = TOCA.RechargeTimer -1
	--print(TOCA.RechargeTimer)
	local rechargeFadeHeight = TOCA.RechargeTimer-10
	if (rechargeFadeHeight <= 1) then
		rechargeFadeHeight = 0
	end
	--print(rechargeFadeHeight)
	TOCA.Button.TotemicCall.recharge:SetSize(40, -rechargeFadeHeight-4)
	for totemCat,v in pairs(TOCA.totems) do
		TOCA.Slot.Recharge[totemCat]:SetSize(TOCA.Slot_w, -rechargeFadeHeight-4)
	end
end

--build timers
for i=1, 4 do
  TOCA.TotemFunc[i] = 0
  TOCA.TotemFunc[i] = C_Timer.NewTicker(0, function() TOCA.TimerFrame(i) end, 0)
  TOCA.TotemFunc[i]:Cancel()
end
TOCA.TotemRechargeFunc = 0
TOCA.TotemRechargeFunc = C_Timer.NewTicker(0, function() TOCA.TimerFrameRecharge() end, 0)
TOCA.TotemRechargeFunc:Cancel()

--trigger only on totem drops
function TOCA.TimerRechargeStart(spell, instant)
	local msCountdown = 0.010
	local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(spell)
	--local manaConsume = GetSpellPowerCost(name)
	--print(manaConsume.cost)
	if (name) then
		local skillType, contextualID = GetSpellBookItemInfo(name)
		if (skillType == "SPELL") then
			if (instant) then --trigger only on totems
				for totemCat,k in pairs(TOCA.totems) do
					for totemSpell,v in pairs(TOCA.totems[totemCat]) do
						if (v[1] == name) then
							TOCA.TotemRechargeFunc = C_Timer.NewTicker(msCountdown, function() TOCA.TimerFrameRecharge() end, 50)
							TOCA.RechargeTimer = 50
						end
					end
				end
				if (name == TOCA.locale.SPELLS.TotemicCall) then
					TOCA.TotemRechargeFunc = C_Timer.NewTicker(msCountdown, function() TOCA.TimerFrameRecharge() end, 50)
					TOCA.RechargeTimer = 50
				end
				for spellCat,v in pairs(TOCA.locale.SPELLS.SHIELDS) do
					if (v == name) then
						TOCA.TotemRechargeFunc = C_Timer.NewTicker(msCountdown, function() TOCA.TimerFrameRecharge() end, 50)
						TOCA.RechargeTimer = 50
					end
				end
			else
				TOCA.TotemRechargeFunc = C_Timer.NewTicker(msCountdown, function() TOCA.TimerFrameRecharge() end, 50)
				TOCA.RechargeTimer = 50
			end
		end
	end
end

function TOCA.TotemBarTimerStart()
  for i=1, 4 do
    TOCA.TotemPresent[i], TOCA.TotemName[i], TOCA.TotemStartTime[i], TOCA.TotemDuration[i] = GetTotemInfo(i)
    if (TOCA.TotemTimer[i] <= 0) then
      TOCA.TotemFunc[i] = C_Timer.NewTicker(1, function() TOCA.TimerFrame(i) end, TOCA.TotemDuration[i])
      TOCA.TotemTimer[i] = TOCA.TotemDuration[i]
    end
  end
end

function TOCA.GetReincTimer() --always checking
  local lC, eC, cI = UnitClass("player")
  if (eC == "SHAMAN") then
    local numTabs = GetNumTalentTabs()
    local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(TOCA.locale.SPELLS.Reincarnation)
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
          TOCA.FrameMain.ReincFrame.text:SetText(TOCA.ReincTimer.."m")
          TOCA.FrameMain.ReincFrame:Show()
        else
          TOCA.FrameMain.ReincFrame:Hide()
          --TOCA.Notification(name.." is ready.", true)
        end
      end
    end
  end
  if (TOCA.Game.version == 1) then
    TOCA.FrameMain.ReincFrame:Hide()
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
  else
    TOCA.TotemFunc[i]:Cancel()
    TOCA.TotemTimer[i] = 0
    TOCA.Slot.Timer[i]:SetText("")
    TOCA.SlotGrid.VerticalTimer[i]:SetText("")
    TOCA.SlotGrid.HorizontalTimer[i]:SetText("")
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

function TOCA.TotemBarUpdate()
  local percMana = (UnitPower("player")/UnitPowerMax("player"))*100
  local percMana = floor(percMana+0.5)
  local onTaxi = UnitOnTaxi("player")
  --TOCA.Notification("mana: " .. percMana, true)
  TOCA.Button.TotemicCall.flash:Hide()
  if ((UnitOnTaxi("player")) or (percMana <= 1)) then
    TOCA.EnableTotems(false)
  else
    TOCA.EnableTotems(true)
  end

  for i=1, 4 do
    TOCA.TotemPresent[i], TOCA.TotemName[i], TOCA.TotemStartTime[i], TOCA.TotemDuration[i] = GetTotemInfo(i)
    if (TOCA.TotemPresent[i]) then
      TOCA.Button.TotemicCall.flash:Show()
    end
  end

  TOCA.GetReincTimer()
  TOCA.DisplayAnkhFrame()
	TOCA.HandleShieldAlert()
end

function TOCA.Combat(event)
  for totemCat,v in pairsByKeys(TOCA.totems) do
    if (event == "PLAYER_REGEN_DISABLED") then
      TOCA.isInCombat = true
      TOCA.SlotSelect[totemCat]:Hide()
      TOCA.Button.DropdownMain:Hide()
      TOCA.Button.Options:Hide()
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
        TOCA.Button.Options:Hide()
      else
        TOCA.Button.Options:Show()
        TOCA.Button.CloseMain:Show()
      end
      TOCA.Notification("Combat Ended", true)
    end
  end
end

function TOCA.InventoryCountItem(itemID)
  local i = 0
  for bag = 0, NUM_BAG_SLOTS do
    for slot=1,GetContainerNumSlots(bag) do
      if (itemID == GetContainerItemID(bag,slot)) then
        i=i+(select(2, GetContainerItemInfo(bag, slot)))
      end
    end
  end
  return i
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
  if (IsInGuild()) then
    C_ChatInfo.SendAddonMessage(TOCA.Global.prefix, filteredPacket, msg_to)
    TOCA.Notification("sending packet " .. filteredPacket, true)
  end
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

local totemNum = 0
local totemButtonPos_X={}
local totemButtonPos_Y={}
function TOCA.SetTotemOrder()
  local buildOrder = TOCA.GetTotemOrder()
  local totemOrder = split(buildOrder, ",")
  for k,v in ipairs(totemOrder) do
    TOCA.Slot[v]:SetPoint("TOPLEFT", -15+TOCA.SlotPosX[k], -35) --main frame
    TOCA.FrameSetsSlot[v]:SetPoint("TOPLEFT", -60+TOCA.SlotSetsPosX[k], -70) --options frame

    for totemCat,notUsed in pairsByKeys(TOCA.totems) do
      totemNum = totemNum +1
      totemButtonPos_Y[totemCat] = 0
      totemButtonPos_X[totemCat] = 0
      for i,totemSpell in pairs(TOCA.totems[totemCat]) do
        totemButtonPos_Y[totemCat] = totemButtonPos_Y[totemCat]+TOCA.Slot_h
        totemButtonPos_X[totemCat] = totemButtonPos_X[totemCat]+TOCA.Slot_w
        local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.SlotGrid.VerticalTotemButton[totemCat][i]:GetPoint()
        if (TOCA.SlotGrid.VerticalTotemButton[v][i]) then
          TOCA.SlotGrid.VerticalTotemButton[v][i]:SetPoint("TOPLEFT", -15+TOCA.SlotPosX[k], yOfs)
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

SLASH_TOCA1 = TCCMD
function SlashCmdList.TOCA(cmd)
  if ((cmd == nil) or (cmd == "")) then
    TOCA.Notification("v" .. TOCA.Global.version .. "-" .. TOCA.Global.suffix .. " ("..GetLocale()..")")
		for int,list in pairs(TOCA.locale.COMMANDS) do
			print("|cffffff00".. list[1] .. "|r : " .. list[2] .. "|n")
		end
	end
	if (cmd == TOCA.locale.COMMANDS[1][1]) then
	  TOCA.FrameOptions:Show()
  elseif (cmd == TOCA.locale.COMMANDS[2][1]) then
		TOCA.FrameMain:Show()
		TOCADB[TOCA.player.combine]["DISABLED"] = "NO"
	elseif (cmd == TOCA.locale.COMMANDS[3][1]) then
		TOCA.FrameMain:Hide()
	elseif (cmd == TOCA.locale.COMMANDS[4][1]) then
		TOCA.Notification("|r : " .. TOCA.player.combine)
	elseif (cmd == TOCA.locale.COMMANDS[5][1]) then
		TOCA.FrameHelp:Show()
	elseif (cmd == TOCA.locale.COMMANDS[6][1]) then
		TOCA.DEBUG = true
		TOCA.Notification("DEBUG ON")
	elseif (cmd == TOCA.locale.COMMANDS[7][1]) then
		TOCA.DEBUG = false
		TOCA.Notification("DEBUG OFF")
	elseif (cmd == TOCA.locale.COMMANDS[8][1]) then
		print(string.format("version = %s, build = %s, date = '%s', tocversion = %s.", __Gversion, __Gbuild, __Gdate, __Gtoc))
	end
end
