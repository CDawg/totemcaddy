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

TOCATotems = {}
TOCATotems.FIRE = {
  {"Fire Nova Totem",       "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Flametongue Totem",     "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Frost Resistance Totem","Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Magma Totem",      "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Searing Totem",    "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Totem of Wrath",    "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
}
TOCATotems.EARTH = {
  {"Earthbind Totem",        "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Stoneclaw Totem",        "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Stoneskin Totem",        "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Strength of Earth Totem","Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Tremor Totem","Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
}
TOCATotems.WATER = {
  {"Disease Cleansing Totem","Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Fire Resistance Totem",  "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Healing Stream Totem",   "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Mana Spring Totem",      "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Poison Cleansing Totem", "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
}
TOCATotems.AIR = {
  {"Grace of Air Totem", "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Grounding Totem", "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Healing Stream Totem", "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Nature Resitance Totem", "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Sentry Totem", "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Tranquil Air Totem", "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Windfury Totem", "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
  {"Windwall Totem", "Interface/GLUES/LoadingScreens/LoadScreenMoltenCore"},
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

TOCAPlayer = {
  name   = UnitName("player"),
  realm  = GetRealmName(),
  class  = UnitClass("player"),
  faction= UnitFactionGroup("player"),
}
TOCAPlayer.combine = TOCAPlayer.name .. "-" .. TOCAPlayer.realm
