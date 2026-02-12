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

local totemPalette={}
for totemCat,v in pairsByKeys(TOCA.totems) do
	totemPalette[totemCat] = {TOCA.colors.totems[totemCat][1], TOCA.colors.totems[totemCat][2], TOCA.colors.totems[totemCat][3], TOCA.colors.totems[totemCat][4]}
end

function TOCA.SegmentedButtonMenu(totemCat, show)
	TOCA.CloseAllMenus()
	if ((show) and (not TOCA.isInCombat)) then
		TOCA.FrameSeg[totemCat].Menu:Show()
	end
end

for totemCat,v in pairsByKeys(TOCA.totems) do
	TOCA.TotemNum["SEG"] = TOCA.TotemNum["SEG"] +1
	totemButtonPos_X[totemCat] = 0
	totemButtonPos_Y[totemCat] = 0
	TOCA.FrameSeg[totemCat] = CreateFrame("Frame", "TOCA.FrameSeg"..totemCat, UIParent, "BackdropTemplate") --independent
	TOCA.FrameSeg[totemCat]:SetWidth(41)
	TOCA.FrameSeg[totemCat]:SetHeight(40)
	--local _defaultPointSet = (TOCA.FrameSeg[totemCat]:GetWidth()/2)-(TOCA.TotemNum["SEG"]*TOCA.FrameSeg[totemCat]:GetWidth())
	local _defaultPointSet = TOCA.TotemNum["SEG"]*TOCA.FrameSeg[totemCat]:GetWidth()
	TOCA.FrameSeg[totemCat]:SetPoint("CENTER", -100+_defaultPointSet, -20)
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
		TOCA.SegmentedButtonMenu(totemCat, true)
	end)
	TOCA.FrameSeg[totemCat]:SetScript("OnLeave", function()
		TOCA.SegmentedButtonMenu(totemCat, false)
	end)
	TOCA.FrameSeg[totemCat]:Hide()

	--button menu options
	TOCA.FrameSeg[totemCat].Header = CreateFrame("Frame", nil, TOCA.FrameSeg[totemCat], "BackdropTemplate", 1)
	TOCA.FrameSeg[totemCat].Header:SetWidth(TOCA.FrameSeg[totemCat]:GetWidth()-4)
	TOCA.FrameSeg[totemCat].Header:SetHeight(14)
	TOCA.FrameSeg[totemCat].Header:SetPoint("TOPLEFT", 2, -3)
	TOCA.FrameSeg[totemCat].Header:SetBackdrop({
	  bgFile  = "Interface/Tooltips/UI-Tooltip-Background",
	  edgeFile= "",
	  edgeSize= 12,
	  insets  = {left=2, right=2, top=2, bottom=2}})
	TOCA.FrameSeg[totemCat].Header:SetBackdropColor(0, 0, 0, 1)
	TOCA.FrameSeg[totemCat].Header:EnableMouse(true)
	TOCA.FrameSeg[totemCat].Header:RegisterForDrag("LeftButton")
	TOCA.FrameSeg[totemCat].Header:SetScript("OnEnter", function()
	  TOCA.SegmentedButtonMenu(totemCat, true)
	end)
	TOCA.FrameSeg[totemCat].Header:SetScript("OnLeave", function()
		TOCA.SegmentedButtonMenu(totemCat, false)
	end)
	TOCA.FrameSeg[totemCat].Header:SetScript("OnDragStart", function()
		TOCA.FrameSeg[totemCat]:StartMoving()
	end)
	TOCA.FrameSeg[totemCat].Header:SetScript("OnDragStop", function()
		TOCA.FrameSeg[totemCat]:StopMovingOrSizing()
		local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.FrameSeg[totemCat]:GetPoint()
		TOCADB[TOCA.player.combine]["CONFIG"]["SEG_POS_" .. totemCat] = point .. "," .. xOfs .. "," .. yOfs
	end)

	--button menu options
	TOCA.FrameSeg[totemCat].Menu = CreateFrame("Frame", nil, TOCA.FrameSeg[totemCat], "BackdropTemplate", 1)
	TOCA.FrameSeg[totemCat].Menu:SetWidth(22)
	TOCA.FrameSeg[totemCat].Menu:SetHeight(40)
	TOCA.FrameSeg[totemCat].Menu:SetPoint("TOPLEFT", TOCA.FrameSeg[totemCat]:GetWidth()-1, -4)
	TOCA.FrameSeg[totemCat].Menu:SetBackdrop({})
	TOCA.FrameSeg[totemCat].Menu:Hide()
	TOCA.FrameSeg[totemCat].Menu:SetScript("OnEnter", function()
		TOCA.SegmentedButtonMenu(totemCat, true)
	end)
	TOCA.FrameSeg[totemCat].Menu:SetScript("OnLeave", function()
		TOCA.SegmentedButtonMenu(totemCat, false)
	end)

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
		TOCA.FrameSeg.Button[totemCat][i].recharge = CreateFrame("Cooldown", nil, TOCA.FrameSeg.Button[totemCat][i], "CooldownFrameTemplate")
		TOCA.FrameSeg.Button[totemCat][i].recharge:SetSize(TOCA.FrameSeg.Button[totemCat][i]:GetWidth(), TOCA.FrameSeg.Button[totemCat][i]:GetHeight())
		TOCA.FrameSeg.Button[totemCat][i].recharge:SetPoint("CENTER", 0, 0)
		TOCA.FrameSeg.Button[totemCat][i].recharge:SetAllPoints()
		TOCA.FrameSeg.Button[totemCat][i].recharge:SetCooldown(GetTime(), 2)
		TOCA.FrameSeg.Button[totemCat][i].recharge:SetEdgeScale(0)
		TOCA.FrameSeg.Button[totemCat][i].action = CreateFrame("Button", nil, TOCA.FrameSeg.Button[totemCat][i], "SecureActionButtonTemplate")
		TOCA.FrameSeg.Button[totemCat][i].action:SetSize(TOCA.FrameSeg.Button[totemCat][i]:GetWidth(), TOCA.FrameSeg.Button[totemCat][i]:GetHeight())
		TOCA.FrameSeg.Button[totemCat][i].action:SetPoint("CENTER", 0, 0)
		TOCA.FrameSeg.Button[totemCat][i].action:RegisterForClicks("AnyDown", "AnyUp")
		TOCA.FrameSeg.Button[totemCat][i].action:SetAttribute("type", "spell")
		TOCA.FrameSeg.Button[totemCat][i].action:SetAttribute("spell", totemSpell[1])
		TOCA.FrameSeg.Button[totemCat][i].highlight = TOCA.FrameSeg.Button[totemCat][i]:CreateTexture(nil, "ARTWORK")
		TOCA.FrameSeg.Button[totemCat][i].highlight:SetSize(TOCA.FrameSeg.Button[totemCat][i]:GetWidth(), TOCA.FrameSeg.Button[totemCat][i]:GetHeight())
		TOCA.FrameSeg.Button[totemCat][i].highlight:SetPoint("CENTER", 0, 0)
		TOCA.FrameSeg.Button[totemCat][i].highlight:SetTexture("Interface/Buttons/ButtonHilight-Square")
		TOCA.FrameSeg.Button[totemCat][i].highlight:SetBlendMode("ADD")
		TOCA.FrameSeg.Button[totemCat][i].highlight:Hide()
		TOCA.FrameSeg.Button[totemCat][i].radius = TOCA.FrameSeg.Button[totemCat][i]:CreateTexture(nil, "ARTWORK")
		TOCA.FrameSeg.Button[totemCat][i].radius:SetSize(TOCA.Slot_w, TOCA.Slot_h)
		TOCA.FrameSeg.Button[totemCat][i].radius:SetPoint("CENTER", 0, 0)
		TOCA.FrameSeg.Button[totemCat][i].radius:SetTexture("Interface/ContainerFrame/UI-Icon-QuestBorder")
		TOCA.FrameSeg.Button[totemCat][i].radius:SetVertexColor(1, 0, 0, 1)
		TOCA.FrameSeg.Button[totemCat][i].radius:SetBlendMode("BLEND")
		TOCA.FrameSeg.Button[totemCat][i].radius:Hide()
		TOCA.FrameSeg.Button[totemCat][i].ID = TOCA.FrameSeg.Button[totemCat][i]:CreateFontString(nil, "ARTWORK")
		TOCA.FrameSeg.Button[totemCat][i].ID:SetFont(TOCA._G.font, 12, "OUTLINE")
		TOCA.FrameSeg.Button[totemCat][i].ID:SetPoint("CENTER", 0, 0)
		TOCA.FrameSeg.Button[totemCat][i].ID:SetText(totemSpell[1])
		TOCA.FrameSeg.Button[totemCat][i].ID:Hide()
		--print(totemSpell[1] .. " = " .. i) --pull IDs
		TOCA.FrameSeg.Button[totemCat][i].timer = TOCA.FrameSeg.Button[totemCat][i]:CreateFontString(nil, "ARTWORK")
		TOCA.FrameSeg.Button[totemCat][i].timer:SetFont(TOCA._G.font, 12, "OUTLINE")
		TOCA.FrameSeg.Button[totemCat][i].timer:SetPoint("CENTER", 0, -8)
		TOCA.FrameSeg.Button[totemCat][i].timer:SetText("")
		TOCA.FrameSeg.Button[totemCat][i].disable = CreateFrame("Frame", nil, TOCA.FrameSeg.Button[totemCat][i], "BackdropTemplate")
		TOCA.FrameSeg.Button[totemCat][i].disable:SetSize(TOCA.FrameSeg.Button[totemCat][i]:GetWidth(), TOCA.FrameSeg.Button[totemCat][i]:GetHeight())
		TOCA.FrameSeg.Button[totemCat][i].disable:SetPoint("CENTER", 0, 0)
		TOCA.FrameSeg.Button[totemCat][i].disable:SetBackdrop(TOCA.Backdrop.General)
		TOCA.FrameSeg.Button[totemCat][i].disable:SetBackdropColor(0, 0, 0, 1)
		TOCA.FrameSeg.Button[totemCat][i].disable:SetBackdropBorderColor(1, 1, 1, 0)
		TOCA.FrameSeg.Button[totemCat][i].disable:Hide()
		TOCA.FrameSeg.Button[totemCat][i].action:SetScript("OnEnter", function(self)
			TOCA.FrameSeg.Button[totemCat][i].highlight:Show()
			TOCA.TooltipDisplay(self, totemSpell[1])
		end)
		TOCA.FrameSeg.Button[totemCat][i].action:SetScript("OnLeave", function(self)
			TOCA.FrameSeg.Button[totemCat][i].highlight:Hide()
		end)
	end

	TOCA.FrameSeg.Button[totemCat].close = CreateFrame("Button", nil, TOCA.FrameSeg[totemCat].Menu, "BackdropTemplate")
	TOCA.FrameSeg.Button[totemCat].close:SetSize(18, 18)
	TOCA.FrameSeg.Button[totemCat].close:SetPoint("TOPLEFT", 2, -2)
	TOCA.FrameSeg.Button[totemCat].close:SetFrameLevel(TOCA.Framelevel.Buttons)
	TOCA.FrameSeg.Button[totemCat].close:SetBackdrop(TOCA.Backdrop.Button)
	TOCA.FrameSeg.Button[totemCat].close:SetBackdropColor(0.6, 0, 0, 1)
	TOCA.FrameSeg.Button[totemCat].close:SetBackdropBorderColor(1, 1, 1, 0.6)
	TOCA.FrameSeg.Button[totemCat].close.icon = TOCA.FrameSeg.Button[totemCat].close:CreateTexture(nil, "ARTWORK")
	TOCA.FrameSeg.Button[totemCat].close.icon:SetSize(12, 12)
	TOCA.FrameSeg.Button[totemCat].close.icon:SetPoint("CENTER", 0, 0)
	TOCA.FrameSeg.Button[totemCat].close.icon:SetTexture("Interface/Buttons/UI-StopButton")
	TOCA.FrameSeg.Button[totemCat].close:SetScript("OnClick", function(self)
		TOCA.CloseAllMenus()
		TOCA.FrameSeg[totemCat]:Hide()
		TOCA.Notification(string.lower(totemCat) .. " bar closed. Type '" .. TOCA._G.CMD .. " show' to reopen.")
	end)
	TOCA.FrameSeg.Button[totemCat].close:SetScript("OnEnter", function(self)
	  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
	    self:SetBackdropBorderColor(1, 1, 1, 0)
	  else
	    self:SetBackdropBorderColor(1, 1, 1, 1)
	  end
		--TOCA.SegmentedButtonMenu(totemCat, true)
		TOCA.TooltipDisplay(self, TOCA._L.UI.TOOLTIP[3][1], TOCA._L.UI.TOOLTIP[3][2]) -- hide this bar
	end)
	TOCA.FrameSeg.Button[totemCat].close:SetScript("OnLeave", function(self)
	  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
	    self:SetBackdropBorderColor(1, 1, 1, 0)
	  else
	    self:SetBackdropBorderColor(1, 1, 1, 0.6)
	  end
	end)

	TOCA.FrameSeg.Button[totemCat].orientation = CreateFrame("Button", nil, TOCA.FrameSeg[totemCat].Menu, "BackdropTemplate")
	TOCA.FrameSeg.Button[totemCat].orientation:SetSize(18, 18)
	TOCA.FrameSeg.Button[totemCat].orientation:SetPoint("TOPLEFT", 2, -18)
	TOCA.FrameSeg.Button[totemCat].orientation:SetFrameLevel(TOCA.Framelevel.Buttons)
	TOCA.FrameSeg.Button[totemCat].orientation:SetBackdrop(TOCA.Backdrop.Button)
	TOCA.FrameSeg.Button[totemCat].orientation:SetBackdropColor(0.6, 0, 0, 1)
	TOCA.FrameSeg.Button[totemCat].orientation:SetBackdropBorderColor(1, 1, 1, 0.6)
	TOCA.FrameSeg.Button[totemCat].orientation.icon = TOCA.FrameSeg.Button[totemCat].orientation:CreateTexture(nil, "ARTWORK")
	TOCA.FrameSeg.Button[totemCat].orientation.icon:SetSize(11, 11)
	TOCA.FrameSeg.Button[totemCat].orientation.icon:SetPoint("CENTER", 0, 0)
	TOCA.FrameSeg.Button[totemCat].orientation.icon:SetTexture("Interface/AddOns/".. TOCA._G.prefix .."/images/btn_orientation.tga")
	TOCA.FrameSeg.Button[totemCat].orientation:SetScript("OnClick", function()
    if (TOCADB[TOCA.player.combine]["CONFIG"]["SEG_OR_"..totemCat] == "H") then
			TOCADB[TOCA.player.combine]["CONFIG"]["SEG_OR_"..totemCat] = "V"
		else
			TOCADB[TOCA.player.combine]["CONFIG"]["SEG_OR_"..totemCat] = "H"
		end
		TOCA.EnableKnownTotems() --size the bars to the number of totems we know
	end)
	TOCA.FrameSeg.Button[totemCat].orientation:SetScript("OnEnter", function(self)
	  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
	    self:SetBackdropBorderColor(1, 1, 1, 0)
	  else
	    self:SetBackdropBorderColor(1, 1, 1, 1)
	  end
		--TOCA.SegmentedButtonMenu(totemCat, true)
		TOCA.TooltipDisplay(self, TOCA._L.UI.TOOLTIP[4][1], TOCA._L.UI.TOOLTIP[4][2]) -- flip the bar
	end)
	TOCA.FrameSeg.Button[totemCat].orientation:SetScript("OnLeave", function(self)
	  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
	    self:SetBackdropBorderColor(1, 1, 1, 0)
	  else
	    self:SetBackdropBorderColor(1, 1, 1, 0.6)
	  end
	end)

end
