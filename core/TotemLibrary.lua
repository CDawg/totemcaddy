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
--TOCA.locale = {TOTEMS = {FIRE={}, EARTH={}, WATER={}, AIR={}}} --this order regardless of language

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
  class  = UnitClass("player"),
  faction= UnitFactionGroup("player"),
	GUID   = UnitGUID("player"),
}
TOCA.player.combine = TOCA.player.name .. "-" .. TOCA.player.realm
