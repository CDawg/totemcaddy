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
TOCA.totems = {}
TOCA.totems.FIRE = {
  --{"Fire Elemental Totem",  "spell_fire_sealoffire",         "Summons a totem at the feet of the caster that inflicts fire damage to enemies within 10 yards."},
  {"Fire Nova Totem",       "spell_fire_sealoffire",         "Summons a totem at the feet of the caster that inflicts fire damage to enemies within 10 yards."},
  {"Flametongue Totem",     "spell_nature_guardianward",     "Summons a totem at the feet of the caster that enchants all party members' main-hand weapons with fire if they are within 20 yards.\nLasts 2 mins."},
  {"Frost Resistance Totem","spell_frostresistancetotem_01", "Summons a totem at the feet of the caster that increases party members' frost resistance within 20 yards."},
  {"Magma Totem",           "spell_fire_selfdestruct",       "Summons a totem at the feet of the caster for 20 seconds that causes fire damage to creatures within 8 yards every 2 seconds."},
  {"Searing Totem",         "spell_fire_searingtotem",       "Summons a totem at the feet of the caster for 1 minute that repeatedly attacks a random enemy within 20 yards with fire damage."},
  {"Totem of Wrath",        "spell_fire_totemofwrath",       "Summons a totem at the feet of the caster increasing the chance to hit and critically strike with spells by 3% for all party members within 20 yards.\nLasts 2 mins."},
}
TOCA.totems.EARTH = {
  {"Earthbind Totem",        "spell_nature_strengthofearthtotem02","Summons a totem at the feet of the caster that slows the movement speed of enemies within 12 yards."},
  {"Stoneclaw Totem",        "spell_nature_stoneclawtotem",        "Summons a totem at the feet of the caster that taunts creatures within 8 yards to attack it. Enemies attacking the stoneclaw have a 50% chance to be stunned for 3 seconds."},
  {"Stoneskin Totem",        "spell_nature_stoneskintotem",        "Summons a totem at the feet of the caster that protects party members within 20 yards, reducing damage taken.\nLasts 2 mins."},
  {"Strength of Earth Totem","spell_nature_earthbindtotem",        "Summons a totem at the feet of the caster that increases the strength of party members within 20 yards.\nLasts 2 mins."},
  {"Tremor Totem",           "spell_nature_tremortotem",           "Summons a totem at the feet of the caster that shakes the ground around it, removing Fear, Charm and Sleep effects from party members within 30 yards.\nLast 2 mins."},
}
TOCA.totems.WATER = {
  {"Disease Cleansing Totem","spell_nature_diseasecleansingtotem","Summons a totem at the feet of the caster that attempts to remove 1 disease effect from party members within 20 yards for every 5 seconds.\nLast 2 mins."},
  {"Fire Resistance Totem",  "spell_fireresistancetotem_01",      "Summons a totem at the feet of the caster that increases party members' fire resistance within 20 yards."},
  {"Healing Stream Totem",   "inv_spear_04",                      "Summons a totem at the feet of the caster that heals the group members within 20 yards every 2 seconds."},
  {"Mana Spring Totem",      "spell_nature_manaregentotem",       "Summons a totem at the feet of the caster that restores mana every 2 seconds to all group members within 20 yards.\nLast 2 mins."},
  {"Mana Tide Totem",        "spell_frost_summonwaterelemental",  "Summons a totem at the feet of the caster that restores 6% of the total mana every 3 seconds to group members within 20 yards.\n5 min cooldown.\nLast 12 seconds."},
  {"Poison Cleansing Totem", "spell_nature_poisoncleansingtotem", "Summons a totem at the feet of the caster that attempts to remove 1 poison effect from party members within 20 yards every 5 seconds.\nLasts 2 mins."},
}
TOCA.totems.AIR = {
  {"Grace of Air Totem",     "spell_nature_invisibilitytotem",    "Summons a totem at the feet of the caster that increases agility to all party members."},
  {"Grounding Totem",        "spell_nature_groundingtotem"       ,"Summons a totem at the feet of the caster that will redirect harmful spell cast on a nearby party member to itself destrying the totem. Will not redirect AoE speels.\nLasts 45 seconds."},
  {"Nature Resistance Totem","spell_nature_natureresistancetotem","Summons a totem at the feet of the caster that increases party members' nature resistance within 20 yards."},
  {"Sentry Totem",           "spell_nature_removecurse",          "Summons a totem at the feet of the caster that allows vision of nearby area and warns of enemies that attack it. Right-Click on buff to switch back and forth between totem sight and shaman sight."},
  {"Tranquil Air Totem",     "spell_nature_brilliance",           "Summons a totem at the feet of the caster that reduces threat caused by all party members within 20 yards for 20%.\nLasts 2 mins."},
  {"Windfury Totem",         "spell_nature_windfury",             "Summons a totem at the feet of the caster that enchants all pary members' main-hand weapons with wind within 20 yards of totem. Each hit has a 20% chance of granting an extra attack.\nLasts 2 mins."},
  {"Windwall Totem",         "spell_nature_earthbind",            "Summons a totem at the feet of the caster that protects party members within 20 yards and reduces ranged damage taken.\nLasts 2 mins."},
  {"Wrath of Air Totem",     "spell_nature_slowingtotem",         "Summons a totem at the feet of the caster that increases party members' spell damage and healing that are within 20 yards.\nLasts 2 mins."},
}

TOCA.spell = {
  TOTEMIC_CALL = 36936,
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

function pairsByKeys (t, f)
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

--single key
function singleKeyFromValue(_array, value)
  for k,v in pairs(_array) do
    if v==value then return k end
  end
  return nil
end
-- matrix key
function multiKeyFromValue(_array, value, index)
  if ((index == nil) or (index == 0)) then
    index = 1
  end
  for k,v in pairs(_array) do
    if v[index]==value then return k end
  end
  return nil
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
