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

TOCA.AssignmentsOpen = 0
TOCA.FrameAssignmentsHeight = 120
TOCA.NumTanks = 0

TOCA.Button.Assignments= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
TOCA.Button.Assignments:SetSize(21, 21)
TOCA.Button.Assignments:SetPoint("TOPLEFT", 2, -2)
TOCA.Button.Assignments:SetBackdrop(TOCA.SetIcon("spell_nature_skinofearth"))
TOCA.Button.Assignments:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, TOCA._L.UI.OPTIONS[10][1], TOCA._L.UI.OPTIONS[10][2])
end)
TOCA.Button.Assignments:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)
TOCA.Button.Assignments:SetScript("OnClick", function(self)
  TOCA.CloseAllMenus()
	--TOCA.AssignmentESRaidSend() --send data
	if (TOCA.AssignmentsOpen == 1) then
 		TOCA.AssignmentsOpen = 0
		TOCA.FrameAssignments:Hide()
	else
		TOCA.BuildRaid()
		TOCA.AssignmentsOpen = 1
		TOCA.FrameAssignments:Show()
	end
end)
TOCA.Button.Assignments:Hide()

TOCA.FrameAssignments={}
TOCA.FrameAssignments = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
TOCA.FrameAssignments:SetWidth(300)
TOCA.FrameAssignments:SetHeight(TOCA.FrameAssignmentsHeight)
TOCA.FrameAssignments:SetPoint("CENTER", 0, 60)
TOCA.FrameAssignments:SetBackdrop(TOCA.Backdrop.General)
TOCA.FrameAssignments:SetBackdropColor(0, 0, 0, 1)
TOCA.FrameAssignments:SetMovable(true)
TOCA.FrameAssignments:EnableMouse(true)
TOCA.FrameAssignments:RegisterForDrag("LeftButton")
TOCA.FrameAssignments:SetScript("OnDragStart", function()
  TOCA.FrameAssignments:StartMoving()
end)
TOCA.FrameAssignments:SetScript("OnDragStop", function()
  TOCA.FrameAssignments:StopMovingOrSizing()
  local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.FrameAssignments:GetPoint()
  TOCADB[TOCA.player.combine]["CONFIG"]["ESPOS"] = point .. "," .. xOfs .. "," .. yOfs
end)
TOCA.FrameAssignments.title = TOCA.FrameAssignments:CreateFontString(nil, "ARTWORK")
TOCA.FrameAssignments.title:SetFont(TOCA._G.font, 11)
TOCA.FrameAssignments.title:SetPoint("TOPLEFT", TOCA.FrameAssignments, "TOPLEFT", 15, -8)
TOCA.FrameAssignments.title:SetText(TOCA._G.title .. " : " .. TOCA._L.UI.OPTIONS[10][1])
TOCA.FrameAssignments:Hide()

TOCA.Button.FrameAssignmentsClose={}
TOCA.Button.FrameAssignmentsClose = CreateFrame("Button", nil, TOCA.FrameAssignments, "BackdropTemplate")
TOCA.Button.FrameAssignmentsClose:SetSize(18, 18)
TOCA.Button.FrameAssignmentsClose:SetPoint("TOPRIGHT", -2, -2)
TOCA.Button.FrameAssignmentsClose:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.FrameAssignmentsClose:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.FrameAssignmentsClose:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.FrameAssignmentsClose.icon = TOCA.Button.FrameAssignmentsClose:CreateTexture(nil, "ARTWORK")
TOCA.Button.FrameAssignmentsClose.icon:SetSize(12, 12)
TOCA.Button.FrameAssignmentsClose.icon:SetPoint("CENTER", 0, 0)
TOCA.Button.FrameAssignmentsClose.icon:SetTexture("Interface/Buttons/UI-StopButton")
TOCA.Button.FrameAssignmentsClose:SetScript("OnEnter", function(self)
  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
    self:SetBackdropBorderColor(1, 1, 1, 0)
  else
    self:SetBackdropBorderColor(1, 1, 1, 1)
  end
end)
TOCA.Button.FrameAssignmentsClose:SetScript("OnLeave", function(self)
  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
    self:SetBackdropBorderColor(1, 1, 1, 0)
  else
    self:SetBackdropBorderColor(1, 1, 1, 0.6)
  end
end)
TOCA.Button.FrameAssignmentsClose:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
	TOCA.FrameAssignments:Hide()
	TOCA.AssignmentsOpen = 0
	TOCA.FrameAssignments:Hide()
end)

TOCA.Dropdown.FrameAssignments={}
TOCA.FrameAssignments.MTName={}
TOCA.FrameAssignments.MTClass={}
TOCA.Dropdown.FrameAssignmentMenu={""}
--local columHeight = 0
for i=1, MAX_RAID_MEMBERS do
	--columnHeight = columnHeight +1
	TOCA.FrameAssignments.text = TOCA.FrameAssignments:CreateFontString(nil, "ARTWORK")
	TOCA.FrameAssignments.text:SetFont(TOCA._G.font, 11)
	TOCA.FrameAssignments.text:SetPoint("TOPLEFT", 10, -i*14)
	TOCA.FrameAssignments.text:SetText("")
  --[==[
	TOCA.FrameAssignments.MTClass[i]={}
	TOCA.FrameAssignments.MTClass[i] = TOCA.FrameAssignments:CreateFontString(nil, "ARTWORK")
	TOCA.FrameAssignments.MTClass[i]:SetFont(TOCA._G.font, 11)
	TOCA.FrameAssignments.MTClass[i]:SetPoint("TOPLEFT", 10, -i*32+12)
	TOCA.FrameAssignments.MTClass[i]:SetText("")
	TOCA.FrameAssignments.MTClass[i]:Hide()
	]==]--
	TOCA.FrameAssignments.MTName[i]={}
	TOCA.FrameAssignments.MTName[i] = TOCA.FrameAssignments:CreateFontString(nil, "ARTWORK")
	TOCA.FrameAssignments.MTName[i]:SetFont(TOCA._G.font, 11)
	TOCA.FrameAssignments.MTName[i]:SetPoint("TOPLEFT", 20, -i*32-12)
	TOCA.FrameAssignments.MTName[i]:SetText("")
	TOCA.FrameAssignments.MTName[i]:Hide()

	--build blank dropdowns
	TOCA.Dropdown.FrameAssignments[i] = {}
	TOCA.Dropdown.FrameAssignments[i] = CreateFrame("Frame", nil, TOCA.FrameAssignments, "UIDropDownMenuTemplate")
	TOCA.Dropdown.FrameAssignments[i]:SetPoint("TOPLEFT", 100, -i*32-4)
	TOCA.Dropdown.FrameAssignments[i].displayMode = "MENU"
	TOCA.Dropdown.FrameAssignments[i].text = TOCA.Dropdown.FrameAssignments[i]:CreateFontString(nil, "ARTWORK")
	TOCA.Dropdown.FrameAssignments[i].text:SetFont(TOCA._G.font, 11)
	TOCA.Dropdown.FrameAssignments[i].text:SetPoint("TOPLEFT", TOCA.Dropdown.FrameAssignments[i], "TOPLEFT", 25, -8)
	TOCA.Dropdown.FrameAssignments[i].text:SetText("")
	TOCA.Dropdown.FrameAssignments[i].onClick = function(self, checked)
		TOCA.Dropdown.FrameAssignments[i].text:SetText(self.value)
		local thisSelection = nil
		local tankSelection = nil
	  --print("net sent packet here!")
		--TOCA.SendPacket(TOCA.Net.assign_es .. TOCA.player.name, "RAID") --send packet only if im a resto sham
		TOCA.SendPacket(TOCA.Net.assign_au .. TOCA.player.name, "RAID") --send author

		TOCA.BuildRaid() --get raid details first, num tanks/shams
		if (TOCA.NumTanks >= 1) then --sengle selection update
			local thisSelection = TOCA.Dropdown.FrameAssignments[i].text:GetText()
			local tankSelection = TOCA.FrameAssignments.MTName[i]:GetText()
			if ((thisSelection) and (tankSelection)) then
				TOCA.SendPacket(TOCA.Net.assign_es .. i .. ",".. tankSelection .. "," .. thisSelection, "RAID") --send author
			end
		end

	end
	UIDropDownMenu_SetWidth(TOCA.Dropdown.FrameAssignments[i], 120)
	TOCA.Dropdown.FrameAssignments[i]:Hide()
end
TOCA.FrameAssignments.author={}
TOCA.FrameAssignments.author = TOCA.FrameAssignments:CreateFontString(nil, "ARTWORK")
TOCA.FrameAssignments.author:SetFont(TOCA._G.font, 11)
TOCA.FrameAssignments.author:SetPoint("BOTTOMLEFT", 6, 6)
TOCA.FrameAssignments.author:SetText("Last Update:")
TOCA.FrameAssignments.author:SetTextColor(1, 1, 1, 0.6)
--TOCA.FrameAssignments.author:Hide()

local listSortNameTanks = {}
local listSortNameShamans = {}

function TOCA.BuildRaid()
	if (IsInRaid()) then
		listSortNameTanks = {}
		listSortNameShamans = {}
		TOCA.NumTanks = 0

		--local isKnown = IsSpellKnown(TOCA.spell.EARTH_SHIELD, false)
		local classIndex = select(3, UnitClass("player")) --users that use TC and not a shaman
		if (classIndex == 7) then --is a sham
			TOCA.Button.Assignments:Show() --we know earth shield, show the assignments button
		end

		--build the tanks and shamans and order in alpha
		for i=1, MAX_RAID_MEMBERS do
			TOCA.FrameAssignments.MTName[i]:Hide()
			TOCA.Dropdown.FrameAssignments[i]:Hide()
			local name, rank, subgroup, level, class, fileName, zone, online, isDead, role = GetRaidRosterInfo(i)
			if (name) then
				if (role == "MAINTANK") then
					table.insert(listSortNameTanks, name)
					--print("tank = " .. name)
				end
				local classIndex = select(3, UnitClass(name))
				if (classIndex == 7) then
					table.insert(listSortNameShamans, name)
					--print("sham = " .. name)
				end
			end
		end

		table.sort(listSortNameTanks) --alpha order tanks
		for k,v in pairsByKeys(listSortNameTanks) do
			TOCA.NumTanks = TOCA.NumTanks +1
			TOCA.FrameAssignments.MTName[k]:Show()
			local classIndex = select(3, UnitClass(v))
			TOCA.FrameAssignments.MTName[k]:SetText(v)
			TOCA.FrameAssignments.MTName[k]:SetTextColor(
			TOCA.colors.class[classIndex][1],
			TOCA.colors.class[classIndex][2],
			TOCA.colors.class[classIndex][3], 1)
		end

		table.sort(listSortNameShamans) --alpha order shams
		if (TOCA.NumTanks >= 1) then --go by the number of tanks for dropdowns
			for i=1, TOCA.NumTanks do
				TOCA.Dropdown.FrameAssignments[i]:Show()
				if (listSortNameShamans[1]) then --make sure we have at least one sham in the raid
					TOCA.AddDDItem(TOCA.Dropdown.FrameAssignments[i], listSortNameShamans)
				end
			end
		end

		TOCA.FrameAssignments:SetHeight(TOCA.FrameAssignmentsHeight+TOCA.NumTanks*20)
	end --isinraid
end

--[==[
function TOCA.AssignmentESRaidGet(prefix, netpacket)
	TOCA.NumRestoShams = 0 --reset
	if (prefix == TOCA._G.prefix) then
		--print("getting data " .. netpacket)
		local getPacket = TOCA.ParsePacket(netpacket, TOCA.Net.assign_es)
		if (getPacket) then
			print(getPacket)
			TOCA.Raid.Name[getPacket] = 1 --build raid array without dupes
		end

		--print("getting ES packet!")
	end
end
]==]--

--[==[
function TOCA.AssignmentESRaidSend()
	TOCA.NumTanks = 0 --reset
	if (IsInRaid()) then
		local isKnown = IsSpellKnown(TOCA.spell.EARTH_SHIELD, false)
		local classIndex = select(3, UnitClass("player")) --users that use TC and not a shaman
		if (classIndex == 7) then --is a sham
		   --if (isKnown) then
			--print("I have ES")
			--TOCA.SendPacket(TOCA.Net.assign_es .. TOCA.player.name, "RAID") --send packet only if im a resto sham
			TOCA.Button.Assignments:Show()
		end

		--build the assignments for other raid members that have TC
		local tankListSortName = {}
		--local tankListSortClass = {}
		for i=1, MAX_RAID_MEMBERS do
			--TOCA.FrameAssignments.MTClass[i]:Hide()
			TOCA.FrameAssignments.MTName[i]:Hide()
			local name, rank, subgroup, level, class, fileName, zone, online, isDead, role = GetRaidRosterInfo(i)
			if (name) then
				if (role == "MAINTANK") then
					table.insert(tankListSortName, name)
				end
			end
		end
		table.sort(tankListSortName)
		for k,v in pairsByKeys(tankListSortName) do
			TOCA.NumTanks = TOCA.NumTanks +1
			if (TOCADB[TOCA.player.combine]["RAID"][v] == nil) then
			  TOCADB[TOCA.player.combine]["RAID"][v] = ""
			end
			--TOCA.FrameAssignments.MTClass[k]:Show()
			TOCA.FrameAssignments.MTName[k]:Show()
			local classIndex = select(3, UnitClass(v))
			--TOCA.FrameAssignments.MTClass[k]:SetText(classIndex)
			TOCA.FrameAssignments.MTName[k]:SetText(v)
			TOCA.FrameAssignments.MTName[k]:SetTextColor(TOCA.colors.class[classIndex][1], TOCA.colors.class[classIndex][2], TOCA.colors.class[classIndex][3], 1)
		end
		print("num tanks " .. TOCA.NumTanks)
		print("sending packet!")
	end
end
]==]--
