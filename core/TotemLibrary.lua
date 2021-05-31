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

TOCA={}
TOCA.totems = {}
TOCA.totems.FIRE = {
  {"Fire Nova Totem",       "spell_fire_sealoffire"},
  {"Flametongue Totem",     "spell_nature_guardianward"},
  {"Frost Resistance Totem","spell_frostresistancetotem_01"},
  {"Magma Totem",           "spell_fire_selfdestruct"},
  {"Searing Totem",         "spell_fire_searingtotem"},
  {"Totem of Wrath",        "spell_fire_totemofwrath"},
}
TOCA.totems.EARTH = {
  {"Earthbind Totem",        "spell_nature_strengthofearthtotem02"},
  {"Stoneclaw Totem",        "spell_nature_stoneclawtotem"},
  {"Stoneskin Totem",        "spell_nature_stoneskintotem"},
  {"Strength of Earth Totem","spell_nature_earthbindtotem"},
  {"Tremor Totem",           "spell_nature_tremortotem"},
}
TOCA.totems.WATER = {
  {"Disease Cleansing Totem","spell_nature_diseasecleansingtotem"},
  {"Fire Resistance Totem",  "spell_fireresistancetotem_01"},
  {"Healing Stream Totem",   "inv_spear_04"},
  {"Mana Spring Totem",      "spell_nature_manaregentotem"},
  {"Poison Cleansing Totem", "spell_nature_poisoncleansingtotem"},
}
TOCA.totems.AIR = {
  {"Grace of Air Totem",     "spell_nature_invisibilitytotem"},
  {"Grounding Totem",        "spell_nature_groundingtotem"},
  {"Nature Resistance Totem","spell_nature_natureresistancetotem"},
  {"Sentry Totem",           "spell_nature_removecurse"},
  {"Tranquil Air Totem",     "spell_nature_brilliance"},
  {"Windfury Totem",         "spell_nature_windfury"},
  {"Windwall Totem",         "spell_nature_earthbind"},
}

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

function multiKeyFromValue(_array, value, index)
  if ((index == nil) or (index == 0)) then
    index = 1
  end
  for k,v in pairs(_array) do
    if v[index]==value then return k end
  end
  return nil
end

TOCA.player = {
  name   = UnitName("player"),
  realm  = GetRealmName(),
  class  = UnitClass("player"),
  faction= UnitFactionGroup("player"),
}
TOCA.player.combine = TOCA.player.name .. "-" .. TOCA.player.realm
