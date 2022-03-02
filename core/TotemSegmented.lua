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

local totemButtonPos_X={}
local totemButtonPos_Y={}
TOCA.SegBarSize={}
TOCA.TotemNum["SEG"] = 0
for totemCat,v in pairsByKeys(TOCA.totems) do
	TOCA.TotemNum["SEG"] = TOCA.TotemNum["SEG"] +1
	totemButtonPos_X[totemCat] = 0
	totemButtonPos_Y[totemCat] = 0
	TOCA.FrameSeg[totemCat] = CreateFrame("Frame", "TOCA.FrameSeg", UIParent, "BackdropTemplate") --independent
	TOCA.FrameSeg[totemCat]:SetWidth(41)
	TOCA.FrameSeg[totemCat]:SetHeight(40)
	--local _defaultPointSet = (TOCA.FrameSeg[totemCat]:GetWidth()/2)-(TOCA.TotemNum["SEG"]*TOCA.FrameSeg[totemCat]:GetWidth())
	local _defaultPointSet = TOCA.TotemNum["SEG"]*TOCA.FrameSeg[totemCat]:GetWidth()
	TOCA.FrameSeg[totemCat]:SetPoint("TOPLEFT", 200+_defaultPointSet, -200)
	TOCA.FrameSeg[totemCat]:SetMovable(true)
	TOCA.FrameSeg[totemCat]:EnableMouse(true)
	TOCA.FrameSeg[totemCat]:RegisterForDrag("LeftButton")
	TOCA.FrameSeg[totemCat]:SetScript("OnDragStart", function()
	  TOCA.FrameSeg[totemCat]:StartMoving()
	end)
	TOCA.FrameSeg[totemCat]:SetScript("OnDragStop", function()
	  TOCA.FrameSeg[totemCat]:StopMovingOrSizing()
	  local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.FrameSeg[totemCat]:GetPoint()
	  TOCADB[TOCA.player.combine]["CONFIG"]["SEG_POS_" .. totemCat] = point .. "," .. xOfs .. "," .. yOfs
	end)
	TOCA.FrameSeg[totemCat]:SetScript("OnEnter", function()
		--print("good " .. totemCat)
	end)
	TOCA.FrameSeg[totemCat]:SetScript("OnLeave", function()
		--print("good")
	end)
	TOCA.FrameSeg[totemCat]:Hide()

	TOCA.FrameSeg[totemCat].Background = CreateFrame("Frame", nil, TOCA.FrameSeg[totemCat], "BackdropTemplate", -6)
	TOCA.FrameSeg[totemCat].Background:SetWidth(TOCA.FrameSeg[totemCat]:GetWidth())
	TOCA.FrameSeg[totemCat].Background:SetHeight(TOCA.FrameSeg[totemCat]:GetHeight())
	TOCA.FrameSeg[totemCat].Background:SetPoint("CENTER", 0, 0)
	TOCA.FrameSeg[totemCat].Background:SetBackdrop(TOCA.Backdrop.General)
	TOCA.FrameSeg[totemCat].Background:SetBackdropColor(
	TOCA.colors.totems[totemCat][1],
	TOCA.colors.totems[totemCat][2],
	TOCA.colors.totems[totemCat][3],
	TOCA.colors.totems[totemCat][4])
	TOCA.FrameSeg[totemCat].Background:SetBackdropBorderColor(
	TOCA.colors.totems[totemCat][1],
	TOCA.colors.totems[totemCat][2],
	TOCA.colors.totems[totemCat][3],
	TOCA.colors.totems[totemCat][4])
	TOCA.FrameSeg[totemCat].Background:SetFrameLevel(TOCA.Framelevel.Background)

	for i,totemSpell in pairs(TOCA.totems[totemCat]) do
		totemButtonPos_X[totemCat] = totemButtonPos_X[totemCat]+TOCA.Slot_w
		totemButtonPos_Y[totemCat] = totemButtonPos_Y[totemCat]+TOCA.Slot_h
		TOCA.FrameSeg.Button[totemCat][i] = CreateFrame("Button", nil, TOCA.FrameSeg[totemCat], "BackdropTemplate")
		--TOCA.FrameSeg.Button[totemCat][i] = CreateFrame("Button", nil, TOCA.FrameSeg[totemCat], "SecureActionButtonTemplate")
	  TOCA.FrameSeg.Button[totemCat][i]:SetSize(TOCA.Slot_w, TOCA.Slot_h)
		TOCA.FrameSeg.Button[totemCat][i]:SetPoint("TOPLEFT", 3, -15.1-totemButtonPos_Y[totemCat]+TOCA.Slot_h)
		TOCA.FrameSeg.Button[totemCat][i]:SetFrameLevel(TOCA.Framelevel.Buttons)
		TOCA.FrameSeg.Button[totemCat][i]:SetBackdrop(TOCA.SetIcon(totemSpell[2]))
		TOCA.FrameSeg.Button[totemCat][i]:SetAttribute("type", "spell")
		TOCA.FrameSeg.Button[totemCat][i]:SetAttribute("spell", totemSpell[1])
		TOCA.FrameSeg.Button[totemCat][i].action = CreateFrame("Button", nil, TOCA.FrameSeg.Button[totemCat][i], "SecureActionButtonTemplate")
		TOCA.FrameSeg.Button[totemCat][i].action:SetSize(TOCA.Slot_w, TOCA.Slot_h)
		TOCA.FrameSeg.Button[totemCat][i].action:SetPoint("CENTER", 0, 0)
		TOCA.FrameSeg.Button[totemCat][i].action:SetAttribute("type", "spell")
		TOCA.FrameSeg.Button[totemCat][i].action:SetAttribute("spell", totemSpell[1])
	end

	TOCA.FrameSeg.Button[totemCat].close= CreateFrame("Button", nil, TOCA.FrameSeg[totemCat], "BackdropTemplate")
	TOCA.FrameSeg.Button[totemCat].close:SetSize(16, 16)
	TOCA.FrameSeg.Button[totemCat].close:SetPoint("TOPRIGHT", -1, 0)
	TOCA.FrameSeg.Button[totemCat].close:SetBackdrop(TOCA.Backdrop.Button)
	TOCA.FrameSeg.Button[totemCat].close:SetBackdropColor(0.6, 0, 0, 1)
	TOCA.FrameSeg.Button[totemCat].close:SetBackdropBorderColor(1, 1, 1, 0.6)
	TOCA.FrameSeg.Button[totemCat].close:Hide()
	TOCA.FrameSeg.Button[totemCat].close.icon = TOCA.FrameSeg.Button[totemCat].close:CreateTexture(nil, "ARTWORK")
	TOCA.FrameSeg.Button[totemCat].close.icon:SetSize(12, 12)
	TOCA.FrameSeg.Button[totemCat].close.icon:SetPoint("CENTER", 0, 0)
	TOCA.FrameSeg.Button[totemCat].close.icon:SetTexture("Interface/Buttons/UI-StopButton")
	TOCA.FrameSeg.Button[totemCat].close:SetScript("OnEnter", function(self)
	  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
	    self:SetBackdropBorderColor(1, 1, 1, 0)
	  else
	    self:SetBackdropBorderColor(1, 1, 1, 1)
	  end
	end)
	TOCA.FrameSeg.Button[totemCat].close:SetScript("OnLeave", function(self)
	  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
	    self:SetBackdropBorderColor(1, 1, 1, 0)
	  else
	    self:SetBackdropBorderColor(1, 1, 1, 0.6)
	  end
	end)
	TOCA.FrameSeg.Button[totemCat].close:SetScript("OnClick", function()
	  TOCA.CloseAllMenus()
	  TOCA.FrameMain:Hide()
	  TOCADB[TOCA.player.combine]["DISABLED"] = "YES"
	  TOCA.Notification("closed. Type '"..TCCMD.." show' to reopen.")
	end)

end
