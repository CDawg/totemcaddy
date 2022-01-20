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
TOCA.locale={}
TOCA.totems={}
TOCA.icons={}
TOCA.help={}
TOCA.spell = {
  TOTEMIC_CALL = 36936,
}

TOCA.item = {
  ANKH = 17030,
}

TOCA.orderGame = { --how the ingame sorts totems
  FIRE = 1,
  EARTH= 2,
  WATER= 3,
  AIR  = 4,
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

function TimeSecondsToMinutes(time)
  local minutes = floor(mod(time,3600)/60)
  local seconds = floor(mod(time,60))
  return format("%2d:%02d",minutes,seconds)
end

TOCA.player = {
  name   = UnitName("player"),
  realm  = GetRealmName(),
  class  = UnitClass("player"),
  faction= UnitFactionGroup("player"),
}
TOCA.player.combine = TOCA.player.name .. "-" .. TOCA.player.realm
