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

TOCA={}
__Gversion, __Gbuild, __Gdate, __Gtoc = GetBuildInfo()
TOCA.totemspells={}
TOCA.icons={}
TOCA.totems={}
TOCA.locale={}
TOCA.help={}
TOCA.spell = {
	REINCARNATION   = 20608,
  TOTEMIC_CALL    = 36936,
	WATER_SHIELD    = 24398,
	LIGHTNING_SHIELD= 23551,
	EARTH_SHIELD    = 974,
}
TOCA.item = {
  ANKH = 17030,
}
TOCA.AnkhReminder = 3
TOCA.AlphaOrder = {"AIR", "EARTH", "FIRE", "WATER"}
TOCA.GameOrder = {
	FIRE = 1,
	EARTH= 2,
	WATER= 3,
	AIR  = 4,
}
--rank all shield for locales and leveling shamans
TOCA.spell.ShieldRanks = {
  WATER_SHIELD = {
		24398, --rank 1
		33736, --rank 2
	},
	LIGHTNING_SHIELD = {
		324,  --rank 1
		325,  --rank 2
		905,  --rank 3
		945,  --rank 4
		8134, --rank 5
		10431, --rank 6
		10432, --rank 7
		25469, --rank 8
		25472, --rank 9
	},
	EARTH_SHIELD = {
		974, -- rank 1
		32593, --rank 2
		32594, --rank 3
	}
}

--all ranks
TOCA.TotemAuras = {
	AIR = {
		{6495}, --sentry
		{8178}, --grounding
		{8836, 10626, 25360}, --grace of air
		{10596, 10598, 10599, 25573}, --nature resist
		{15108, 15109, 15110, 25576}, --windwall
		{2895}, -- Wrath of Air
		{25909}, --tranquility
	},
	EARTH = {
		{8072, 8156, 8157, 10403, 10404, 10405, 25506, 25507}, --stoneskin
		{8076, 8162, 8163, 10441, 25362, 25527}, --strength of earth
	},
	FIRE = {
		{8182, 10476, 10477, 25559}, --frost resist
		{30706, 30708}, --totem of wrath
	},
	WATER = {
	  {8185, 10534, 10535, 25562}, --fire resist
		{5672, 6371, 6372, 10460, 10461, 25566}, --healing stream
		{5677, 10491, 10493, 10494, 25569}, --mana spring
	}
}

TOCA.TotemAuraExempt = { --totems that don't have an aura id (even hidden)
	AIR = {
		136114, --windfury
	},
	EARTH = {
		136108, --tremor
		136097, --stoneclaw
		136102, --earthbind
	},
	FIRE = {
		135824, --firenova
		136040, --flametongue
		135826, --magma
		135825, --searing

	},
	WATER = {
		136019, --disease cleansing
		135861, --mana tide
		136070, --poison cleansing
	}
}

function arrayToString(array)
  formstring=""
  for k,v in pairs(array) do
    formstring = formstring .. v .. "\n"
  end
  return formstring
end

function split(s, delimiter)
  result = {}
  if (s) then
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
      table.insert(result, match)
    end
  end
  return result
end

function isempty(s)
  return s == nil or s == ''
end

function table.merge(t1, t2)
 for k,v in ipairs(t2) do
    table.insert(t1, v)
 end
  return t1
end

function pairsByKeys(t, f)
  local a = {}
  for n in pairs(t) do table.insert(a, n) end
  table.sort(a, f)
  local i = 0
  local iter = function()
    i = i + 1
    if a[i] == nil then return nil
    else return a[i], t[a[i]]
    end
  end
  return iter
end

function firstToUpper(str)
  return (str:gsub("^%l", string.upper))
end

function getKeyFromValue(_array, value, index)
  if ((index == nil) or (index == 0)) then
		for k,v in pairs(_array) do
			if v==value then return k end
		end
		return nil
  else
	  for k,v in pairs(_array) do
	    if v[index]==value then return k end
	  end
	  return nil
	end
end

function reindexArray(input, reval)
  local n=#input
  for i=1,n do
    if reval[input[i]] then
      input[i]=nil
    end
  end
  local j=0
  for i=1,n do
    if input[i]~=nil then
      j=j+1
      input[j]=input[i]
    end
  end
  for i=j+1,n do
    input[i]=nil
  end
end

function reindexArraySafe(array)
  local n=0
  local newArray={}
  for i,v in pairs(array) do
    n=n+1
    newArray[n] = v
  end
  return newArray
end

function matchString(source, target)
	local _source_match = ""
	local _target_match = ""
	local _source_reiterate = 1
	local _target_reiterate = 1
	if ((source) and (target)) then
		for _split in string.gmatch(source, "%a+") do
			_source_reiterate = _source_reiterate -1
			if (_source_reiterate >= 0) then
				_source_match = _source_match .. string.lower(_split)
		  end
		end
		for _split in string.gmatch(target, "%a+") do
			_target_reiterate = _target_reiterate -1
			if (_target_reiterate >= 0) then
				_target_match = _target_match .. string.lower(_split)
			end
		end

		if (_source_match == _target_match) then
			return 1
		end
	end
end

function TimeSecondsToMinutes(time)
  local minutes = floor(mod(time,3600)/60)
  local seconds = floor(mod(time,60))
  return format("%2d:%02d",minutes,seconds)
end

function round(number)
  if (number - (number % 0.1)) - (number - (number % 1)) < 0.5 then
    number = number - (number % 1)
  else
    number = (number - (number % 1)) + 1
  end
 return number
end

TOCA.player = {
  name   = UnitName("player"),
  realm  = GetRealmName(),
	classID= select(3, UnitClass("player")), --use the class ID, due to locales
  faction= UnitFactionGroup("player"), --first use English for the time being
	GUID   = UnitGUID("player"),
	--target = GetUnitName("PLAYERTARGET"))
}
TOCA.player.combine = TOCA.player.name .. "-" .. TOCA.player.realm

TOCA.colors={}
TOCA.colors.totems = {
	FIRE = {1, 0.2, 0, 1},
	EARTH= {0.5, 1, 0.2, 1},
	WATER= {0.2, 0.5, 0.9, 1},
	AIR  = {0.7, 0.7, 0.8, 1}
}

TOCA.colors.class = {
	{0.78, 0.61, 0.43, "|CFFC69B6D"}, --Warrior
	{0.96, 0.55, 0.73, "|CFFF48CBA"}, --Paladin
	{0.67, 0.83, 0.45, "|CFFAAD372"}, --Hunter
	{1.00, 0.96, 0.41, "|CFFFFF468"}, --Rogue
	{1.00, 1.00, 1.00, "|CFFFFFFFF"}, --Priest
	{0.77, 0.12, 0.23, "|CFFC41E3A"}, --Death Knight
	{0.00, 0.44, 0.87, "|CFF0070DD"}, --Shaman
	{0.25, 0.78, 0.92, "|CFF3FC7EB"}, --Mage
	{0.53, 0.53, 0.93, "|CFF8788EE"}, --Warlock
	{0.00, 1.00, 0.60, "|CFF00FF98"}, --Monk
	{1.00, 0.49, 0.04, "|CFFFF7C0A"}, --Druid
	{0.64, 0.19, 0.79, "|CFFA330C9"}, --Demon Hunter
}
