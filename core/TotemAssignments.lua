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
TOCA.NoTanks = "No Tanks Assigned!"
TOCA.ClearESQueue = "- empty -"
TOCA.EarthShieldIcon = "spell_nature_skinofearth"

TOCA.Button.Assignments= CreateFrame("Button", nil, TOCA.FrameMain, "BackdropTemplate")
TOCA.Button.Assignments:SetSize(21, 21)
TOCA.Button.Assignments:SetPoint("TOPLEFT", 2, -2)
TOCA.Button.Assignments:SetBackdrop(TOCA.SetIcon(TOCA.EarthShieldIcon))
TOCA.Button.Assignments:SetScript("OnEnter", function(self)
	if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
		self:SetBackdropBorderColor(1, 1, 1, 0)
	else
		self:SetBackdropBorderColor(0.7, 0.7, 1, 1)
	end
	TOCA.TooltipDisplay(self, TOCA._L.UI.OPTIONS[10][1], TOCA._L.UI.OPTIONS[10][2])
end)
TOCA.Button.Assignments:SetScript("OnLeave", function(self)
	if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
		self:SetBackdropBorderColor(1, 1, 1, 0)
	else
		self:SetBackdropBorderColor(1, 1, 1, 0.6)
	end
  TOCA.CloseAllMenus()
end)
TOCA.Button.Assignments:SetScript("OnClick", function(self)
  TOCA.CloseAllMenus()
	--TOCA.AssignmentESRaidSend() --send data
	if (TOCA.AssignmentsOpen == 1) then
 		TOCA.AssignmentsOpen = 0
		TOCA.FrameAssignments:Hide()
	else
		TOCA.BuildRaidAssignments(true)
		TOCA.AssignmentsOpen = 1
		TOCA.FrameAssignments:Show()
	end
end)
TOCA.Button.Assignments:Hide()

TOCA.FrameAssignments={}
TOCA.FrameAssignments = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
TOCA.FrameAssignments:SetWidth(350)
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
TOCA.FrameAssignments.title:SetPoint("TOPLEFT", TOCA.FrameAssignments, "TOPLEFT", 25, -8)
TOCA.FrameAssignments.title:SetText(TOCA._G.title .. " " .. TOCA._L.UI.OPTIONS[10][1])
TOCA.FrameAssignments.icon = TOCA.FrameAssignments:CreateTexture(nil, "ARTWORK")
TOCA.FrameAssignments.icon:SetSize(18, 18)
TOCA.FrameAssignments.icon:SetPoint("TOPLEFT", 4, -4)
TOCA.FrameAssignments.icon:SetTexture("Interface/ICONS/" .. TOCA.EarthShieldIcon)
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
	TOCA.AssignmentsOpen = 0
	TOCA.FrameAssignments:Hide()
end)

TOCA.Dropdown.FrameAssignments={}
TOCA.FrameAssignments.MTName={}
TOCA.FrameAssignments.MTClass={}
TOCA.FrameAssignments.divider={}
TOCA.Dropdown.FrameAssignmentMenu={""}

local rowHeight = 40
for i=1, MAX_RAID_MEMBERS do
	TOCA.FrameAssignments.MTName[i] = {}
	TOCA.FrameAssignments.MTName[i] = TOCA.FrameAssignments:CreateFontString(nil, "ARTWORK")
	TOCA.FrameAssignments.MTName[i]:SetFont(TOCA._G.font, 11)
	TOCA.FrameAssignments.MTName[i]:SetPoint("TOPLEFT", 30, -i*rowHeight-12)
	TOCA.FrameAssignments.MTName[i]:SetText(TOCA.NoTanks)
	TOCA.FrameAssignments.MTName[i]:Hide()

  TOCA.FrameAssignments.MTClass[i] = {}
	TOCA.FrameAssignments.MTClass[i] = TOCA.FrameAssignments:CreateTexture(nil, "ARTWORK")
	TOCA.FrameAssignments.MTClass[i]:SetSize(14, 14)
	TOCA.FrameAssignments.MTClass[i]:SetPoint("TOPLEFT", 10, -i*rowHeight-12)
	TOCA.FrameAssignments.MTClass[i]:SetTexture("")

	--build blank dropdowns
	TOCA.Dropdown.FrameAssignments[i] = {}
	TOCA.Dropdown.FrameAssignments[i] = CreateFrame("Frame", nil, TOCA.FrameAssignments, "UIDropDownMenuTemplate")
	TOCA.Dropdown.FrameAssignments[i]:SetPoint("TOPLEFT", 115, -i*rowHeight-2)
	TOCA.Dropdown.FrameAssignments[i].displayMode = "MENU"
	TOCA.Dropdown.FrameAssignments[i].text = TOCA.Dropdown.FrameAssignments[i]:CreateFontString(nil, "ARTWORK")
	TOCA.Dropdown.FrameAssignments[i].text:SetFont(TOCA._G.font, 11)
	TOCA.Dropdown.FrameAssignments[i].text:SetPoint("TOPLEFT", TOCA.Dropdown.FrameAssignments[i], "TOPLEFT", 30, -8)
	TOCA.Dropdown.FrameAssignments[i].text:SetText("")
	TOCA.Dropdown.FrameAssignments[i].onClick = function(self, checked)
		TOCA.Dropdown.FrameAssignments[i].text:SetText(self.value)
		local shamanSelection = nil
		local tankSelection = nil
		TOCA.BuildRaidAssignments(false) --get raid details first, num tanks/shams
		TOCA.SendAuthorAssignment()
		if (TOCA.NumTanks >= 1) then --single selection update
			local shamanSelection = TOCA.Dropdown.FrameAssignments[i].text:GetText()
			local tankSelection = TOCA.FrameAssignments.MTName[i]:GetText()
			if ((shamanSelection) and (tankSelection)) then
				TOCA.SendPacket(TOCA.Net.assign_es .. i .. ",".. tankSelection .. "," .. shamanSelection, "RAID") --send author
			end
		end
	end
	UIDropDownMenu_SetWidth(TOCA.Dropdown.FrameAssignments[i], 120)
	TOCA.Dropdown.FrameAssignments[i]:Hide()

	TOCA.FrameAssignments.divider[i] = {}
	TOCA.FrameAssignments.divider[i] = TOCA.FrameAssignments:CreateTexture(nil, "ARTWORK")
	TOCA.FrameAssignments.divider[i]:SetSize(TOCA.FrameAssignments:GetWidth()-8, 8)
	TOCA.FrameAssignments.divider[i]:SetPoint("TOPLEFT", 4, -i*rowHeight-32)
	TOCA.FrameAssignments.divider[i]:SetTexture("Interface/DialogFrame/DialogFrame-TOP")
	TOCA.FrameAssignments.divider[i]:Hide()
end

TOCA.FrameAssignments.author={}
TOCA.FrameAssignments.author = TOCA.FrameAssignments:CreateFontString(nil, "ARTWORK")
TOCA.FrameAssignments.author:SetFont(TOCA._G.font, 11)
TOCA.FrameAssignments.author:SetPoint("BOTTOMLEFT", 6, 6)
TOCA.FrameAssignments.author:SetText("Last Update:")
TOCA.FrameAssignments.author:SetTextColor(1, 1, 1, 0.6)
--TOCA.FrameAssignments.author:Hide()

TOCA.FrameAssignmentPersonal={}
TOCA.FrameAssignmentPersonal = CreateFrame("Button", nil, UIParent, "BackdropTemplate")
TOCA.FrameAssignmentPersonal:SetWidth(100)
TOCA.FrameAssignmentPersonal:SetHeight(28)
TOCA.FrameAssignmentPersonal:SetPoint("TOPLEFT", GetScreenWidth()/2 -TOCA.FrameAssignmentPersonal:GetWidth(), -TOCA.FrameAssignmentPersonal:GetHeight()+20)
TOCA.FrameAssignmentPersonal:RegisterForClicks("RightButtonDown", "LeftButtonDown")
TOCA.FrameAssignmentPersonal:SetBackdrop({
	bgFile  = "Interface/RAIDFRAME/Raid-Bar-Hp-Fill",
	edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
	edgeSize= 8,
	insets  = {left=2, right=2, top=2, bottom=2},
})
TOCA.FrameAssignmentPersonal:SetBackdropColor(1, 0, 0, 0.6)
TOCA.FrameAssignmentPersonal:SetMovable(true)
TOCA.FrameAssignmentPersonal:EnableMouse(true)
TOCA.FrameAssignmentPersonal:RegisterForDrag("LeftButton")
TOCA.FrameAssignmentPersonal:SetScript("OnDragStart", function()
  TOCA.FrameAssignmentPersonal:StartMoving()
end)
TOCA.FrameAssignmentPersonal:SetScript("OnDragStop", function()
  TOCA.FrameAssignmentPersonal:StopMovingOrSizing()
  local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.FrameAssignmentPersonal:GetPoint()
  TOCADB[TOCA.player.combine]["CONFIG"]["ESPERSPOS"] = point .. "," .. xOfs .. "," .. yOfs
end)
TOCA.FrameAssignmentPersonal.TankIcon = TOCA.FrameAssignmentPersonal:CreateTexture(nil, "ARTWORK")
TOCA.FrameAssignmentPersonal.TankIcon:SetSize(20, 20)
TOCA.FrameAssignmentPersonal.TankIcon:SetPoint("TOPLEFT", 4, -4)
TOCA.FrameAssignmentPersonal.TankIcon:SetTexture(TOCA.colors.class[1][5]) --default
TOCA.FrameAssignmentPersonal.ESIcon = TOCA.FrameAssignmentPersonal:CreateTexture(nil, "ARTWORK")
TOCA.FrameAssignmentPersonal.ESIcon:SetSize(18, 18)
TOCA.FrameAssignmentPersonal.ESIcon:SetPoint("TOPRIGHT", -5, -4)
TOCA.FrameAssignmentPersonal.ESIcon:SetTexture("Interface/ICONS/" .. TOCA.EarthShieldIcon)
TOCA.FrameAssignmentPersonal.ESIcon:Hide()
TOCA.FrameAssignmentPersonal.ESCount = TOCA.FrameAssignmentPersonal:CreateFontString(nil, "ARTWORK")
TOCA.FrameAssignmentPersonal.ESCount:SetFont(TOCA._G.font, 12, "OUTLINE")
TOCA.FrameAssignmentPersonal.ESCount:SetPoint("TOPRIGHT", -2, -10)
TOCA.FrameAssignmentPersonal.ESCount:SetText("")
TOCA.FrameAssignmentPersonal.tank = TOCA.FrameAssignmentPersonal:CreateFontString(nil, "ARTWORK")
TOCA.FrameAssignmentPersonal.tank:SetFont(TOCA._G.font, 10)
TOCA.FrameAssignmentPersonal.tank:SetPoint("TOPLEFT", 26, -10)
TOCA.FrameAssignmentPersonal.tank:SetText("Tank 1")
TOCA.FrameAssignmentPersonal:SetScript("OnClick", function(self, button)
	if (button == "RightButton") then
		TOCA.AssignmentsOpen = 1
		TOCA.FrameAssignments:Show()
		if (TOCA.FrameAssignmentPersonal.tank:GetText()) then
			--TargetUnit(TOCA.FrameAssignmentPersonal.tank:GetText())
			--TargetUnit()
			--"*type1" --protected
		end
	else --leftbutton
	end
end)
TOCA.FrameAssignmentPersonal:SetScript("OnEnter", function(self)
  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
    self:SetBackdropBorderColor(1, 1, 1, 0)
  else
    self:SetBackdropBorderColor(1, 1, 1, 1)
  end
	if (TOCA.FrameAssignmentPersonal.tank:GetText()) then
		TOCA.TooltipDisplay(self, "Earth Shield Assignments |cfff7cb45["..TOCA.FrameAssignmentPersonal.tank:GetText().."]", "|cffffffffDrag and drop anywhere to save position.|nRight Click - To open the Earth Shield Assignments", 1)
	end
end)
TOCA.FrameAssignmentPersonal:SetScript("OnLeave", function(self)
	TOCA.CloseAllMenus()
  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
    self:SetBackdropBorderColor(1, 1, 1, 0)
  else
    self:SetBackdropBorderColor(1, 1, 1, 0.6)
  end
end)
TOCA.FrameAssignmentPersonal:Hide()

TOCA.Button.FrameAssignmentsSendAll = {}
TOCA.Button.FrameAssignmentsSendAll = CreateFrame("Button", nil, TOCA.FrameAssignments, "BackdropTemplate")
TOCA.Button.FrameAssignmentsSendAll:SetSize(80, 24)
TOCA.Button.FrameAssignmentsSendAll:SetPoint("BOTTOMRIGHT", -4, 4)
TOCA.Button.FrameAssignmentsSendAll:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.FrameAssignmentsSendAll:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.FrameAssignmentsSendAll:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.FrameAssignmentsSendAll.text = TOCA.Button.FrameAssignmentsSendAll:CreateFontString(nil, "ARTWORK")
TOCA.Button.FrameAssignmentsSendAll.text:SetFont(TOCA._G.font, 11)
TOCA.Button.FrameAssignmentsSendAll.text:SetPoint("CENTER", 0, 0)
TOCA.Button.FrameAssignmentsSendAll.text:SetText("Assign")
TOCA.Button.FrameAssignmentsSendAll:SetScript("OnEnter", function(self)
  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
    self:SetBackdropBorderColor(1, 1, 1, 0)
  else
    self:SetBackdropBorderColor(1, 1, 1, 1)
  end
end)
TOCA.Button.FrameAssignmentsSendAll:SetScript("OnLeave", function(self)
  if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
    self:SetBackdropBorderColor(1, 1, 1, 0)
  else
    self:SetBackdropBorderColor(1, 1, 1, 0.6)
  end
end)
TOCA.Button.FrameAssignmentsSendAll:SetScript("OnClick", function()
	TOCA.SendAllAssignments()
end)
TOCA.Button.FrameAssignmentsSendAll:Hide()

local listSortNameTanks = {}
local listSortNameShamans = {}

function TOCA.NoTanksAssigned()
	TOCA.FrameAssignments.MTName[1]:SetText(TOCA.NoTanks)
	TOCA.FrameAssignments.MTName[1]:SetTextColor(1, 0.5, 0.4, 1)
end

function TOCA.SendAuthorAssignment()
	TOCA.SendPacket(TOCA.Net.assign_au .. TOCA.player.name .. " [" .. date("%Y-%m-%d %H:%M:%S") .. "]", "RAID") --send author
end

function TOCA.SendAllAssignments()
	if (TOCA.NumTanks >= 1) then --single selection update
		for i=1, TOCA.NumTanks do
			local shamanSelection = TOCA.Dropdown.FrameAssignments[i].text:GetText()
			local tankSelection = TOCA.FrameAssignments.MTName[i]:GetText()
			if ((shamanSelection) and (tankSelection)) then
				TOCA.SendPacket(TOCA.Net.assign_es .. i .. ",".. tankSelection .. "," .. shamanSelection, "RAID") --send author
				--if (shamanSelection ~= TOCA.player.name) then
					if ((tankSelection) and (UnitInRaid(shamanSelection))) then
						if (TOCADB[TOCA.player.combine]["CONFIG"]["ESASSIGNMSG"] == "Custom") then
							if (TOCADB[TOCA.player.combine]["CONFIG"]["ESASSIGNCHANNEL"]) then
								local channelID = GetChannelName(TOCADB[TOCA.player.combine]["CONFIG"]["ESASSIGNCHANNEL"])
								if (channelID) then
									--print(channelID)
							    SendChatMessage("<".. TOCA._L.TITLE .."> " .. TOCA.player.name .. " has assigned " .. shamanSelection .. " [" .. tankSelection .. "] for Earth Shield", "CHANNEL", nil, channelID)
							  else
									SendChatMessage("<".. TOCA._L.TITLE .."> " .. TOCA.player.name .. " has assigned " .. shamanSelection .. " [" .. tankSelection .. "] for Earth Shield", "RAID", nil, shamanSelection)
								end
							else --if all else fails, go to the raid
								SendChatMessage("<".. TOCA._L.TITLE .."> " .. TOCA.player.name .. " has assigned " .. shamanSelection .. " [" .. tankSelection .. "] for Earth Shield", "RAID", nil, shamanSelection)
							end
						elseif (TOCADB[TOCA.player.combine]["CONFIG"]["ESASSIGNMSG"] == "Whisper") then
							SendChatMessage("<".. TOCA._L.TITLE .."> " .. TOCA.player.name .. " has assigned you [" .. tankSelection .. "] for Earth Shield", "WHISPER", nil, shamanSelection)
					  else
							SendChatMessage("<".. TOCA._L.TITLE .."> " .. TOCA.player.name .. " has assigned " .. shamanSelection .. " [" .. tankSelection .. "] for Earth Shield", "RAID", nil, shamanSelection)
						end
					end
				--end
			end
		end
	end
	--TOCA.Notification("Sending Earth Shield Assignments")
	TOCA.SendAuthorAssignment()
end

function TOCA.BuildRaidAssignments(loadSaved) --get saved variables
	local classIndex = select(3, UnitClass("player")) --users that use TC and not a shaman
	--if (classIndex ~= 7) then --is a sham
		--return
	--end

	if (IsInRaid()) then
		listSortNameTanks = {}
		listSortNameShamans = {TOCA.ClearESQueue}
		TOCA.NumTanks = 0

		if (classIndex == 7) then --is a sham
			local isKnown = IsSpellKnown(TOCA.spell.EARTH_SHIELD, false) --we know earth shield, show the assignments button
			if (isKnown) then
				TOCA.Button.Assignments:Show()
			end
		end

		--build the tanks and shamans and order in alpha
		for i=1, MAX_RAID_MEMBERS do
			TOCA.FrameAssignments.MTName[i]:Hide()
			TOCA.FrameAssignments.MTClass[i]:Hide()
			TOCA.FrameAssignments.divider[i]:Hide()
			TOCA.Dropdown.FrameAssignments[i]:Hide()
			--if (TOCA.Dropdown.FrameAssignments[i].text:GetText() == TOCA.ClearESQueue) then
				--TOCA.Dropdown.FrameAssignments[i].text:SetText("")
			--end
			TOCA.NoTanksAssigned()
			TOCA.FrameAssignments.MTName[1]:Show() -- show first line for empty tank message
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
			TOCA.FrameAssignments.MTClass[k]:Show()
			TOCA.FrameAssignments.divider[k]:Show()
			local classIndex = select(3, UnitClass(v))
			TOCA.FrameAssignments.MTName[k]:SetText(v)
			TOCA.FrameAssignments.MTName[k]:SetTextColor(
			TOCA.colors.class[classIndex][1],
			TOCA.colors.class[classIndex][2],
			TOCA.colors.class[classIndex][3], 1)
			TOCA.FrameAssignments.MTClass[k]:SetTexture(TOCA.colors.class[classIndex][5])
		end

		TOCA.Button.FrameAssignmentsSendAll:Hide()
		table.sort(listSortNameShamans) --alpha order shams
		if (TOCA.NumTanks >= 1) then --go by the number of tanks for dropdowns
			TOCA.Button.FrameAssignmentsSendAll:Show()
			for i=1, TOCA.NumTanks do
				TOCA.Dropdown.FrameAssignments[i]:Show()
				if (listSortNameShamans[1]) then --make sure we have at least one sham in the raid
					TOCA.AddDDItem(TOCA.Dropdown.FrameAssignments[i], listSortNameShamans)
				end
			end
		end

		if (loadSaved) then --login or reload
			for i=1, MAX_RAID_MEMBERS do
				if (TOCADB[TOCA.player.combine]["RAID"][TOCA.FrameAssignments.MTName[i]:GetText()]) then
					TOCA.Dropdown.FrameAssignments[i].text:SetText(TOCADB[TOCA.player.combine]["RAID"][TOCA.FrameAssignments.MTName[i]:GetText()])
					--print("loading " .. i .. " "  .. TOCADB[TOCA.player.combine]["RAID"][TOCA.FrameAssignments.MTName[i]:GetText()])
				end
			end
		end

		TOCA.FrameAssignmentPersonal:Hide()
		TOCA.HasAssignment = 0
		if (TOCA.NumTanks >= 1) then --count the active tanks once again then assign
			for i=1, TOCA.NumTanks do --go by the first tanks, just in case a personal assignment was from a previous raid and number 4-5 down the list.
				if (TOCA.Dropdown.FrameAssignments[i].text:GetText() == TOCA.player.name) then
					TOCA.HasAssignment = TOCA.HasAssignment +1
					--if (TOCA.HasAssignment == 1) then --assign the first tank, not others
						--print("you are assigned " .. TOCA.FrameAssignments.MTName[i]:GetText())
						TOCA.FrameAssignmentPersonal.tank:SetText(TOCA.FrameAssignments.MTName[i]:GetText())
						local classIndex = select(3, UnitClass(TOCA.FrameAssignments.MTName[i]:GetText()))
						TOCA.FrameAssignmentPersonal.TankIcon:SetTexture(TOCA.colors.class[classIndex][5])
						TOCA.FrameAssignmentPersonal:Show()
					--end
				end
			end
		else -- there are no tanks, clear them all out
			for i=1, MAX_RAID_MEMBERS do
				if (TOCADB[TOCA.player.combine]["RAID"]) then
					TOCADB[TOCA.player.combine]["RAID"]={}
				end
				TOCA.FrameAssignments.MTName[i]:SetText("")
				TOCA.Dropdown.FrameAssignments[i].text:SetText("")
				--print("clearing tank queue")
			end
			TOCA.NoTanksAssigned()
		end

		TOCA.FrameAssignments:SetHeight(TOCA.FrameAssignmentsHeight+TOCA.NumTanks*rowHeight)
  else --left raid
		TOCA.FrameAssignmentPersonal:Hide()
		TOCA.Button.Assignments:Hide()
		TOCA.FrameAssignments:Hide()
  end --isinraid
end

function TOCA.AssignmentESRaidGet(prefix, netpacket)
	 	--get the author of es assignments
	local getPacket = TOCA.ParsePacket(netpacket, TOCA.Net.assign_au)
	if (getPacket) then
		TOCA.FrameAssignments.author:SetText("Last Update: " .. getPacket)
	end

	--get the es assignments
	local getPacket = TOCA.ParsePacket(netpacket, TOCA.Net.assign_es)
	if (getPacket) then
		--print("getting " .. getPacket)
		local assign = split(getPacket, ",")
		local ddID = tonumber(assign[1])
		local tank = assign[2]
		local shaman=assign[3]
		for i=1, MAX_RAID_MEMBERS do
			if (TOCA.FrameAssignments.MTName[i]:GetText() == tank) then
				TOCA.Dropdown.FrameAssignments[ddID].text:SetText(shaman)
				--TOCA.Dropdown.FrameAssignments[i].text:SetText(assign[3])
				TOCADB[TOCA.player.combine]["RAID"][tank] = shaman
				--print("saved " .. tank .. " " .. shaman)
			end
		end
	end
	TOCA.BuildRaidAssignments(false)
end

function TOCA.GetShieldFromTanks()
	local tankToShaman = nil
	local classIndex = select(3, UnitClass(TOCA.player.name))
	--go red
	TOCA.FrameAssignmentPersonal:SetBackdropColor(1, 0, 0, 0.6)
	TOCA.FrameAssignmentPersonal.ESIcon:Hide()
	TOCA.FrameAssignmentPersonal.ESCount:SetText("")
	if (TOCADB[TOCA.player.combine]["CONFIG"]["ESASSIGNMENTS"] == "OFF") then
	  TOCA.FrameAssignmentPersonal:Hide()
		return
	end
	if (classIndex == 7) then --dont even bother if it's not a shaman
		if (IsInRaid()) then
			for i=1, MAX_RAID_MEMBERS do
				if (TOCA.Dropdown.FrameAssignments[i].text:GetText() == TOCA.player.name) then
					tankToShaman = TOCA.FrameAssignments.MTName[i]:GetText()
				end
			end
			--print(tankToShaman) --debug

			if (tankToShaman) then --shaman specific tank
				TOCA.FrameAssignmentPersonal:Show()
				if (UnitIsConnected(tankToShaman)) then --is the tank in raid but not logged on
					local _Uindex = 1
					while UnitAura(tankToShaman, _Uindex) do
						local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura(tankToShaman, _Uindex)
						for k,v in pairs(TOCA._L.SPELLS.SHIELDS) do --just rank all shields regardless.
							if (string.find(name, v)) then
								--local timeDuration = duration + expirationTime - GetTime()
								--timeDuration = timeDuration / 120
								--print(name) --found a shield
								TOCA.FrameAssignmentPersonal.ESIcon:Show()
								TOCA.FrameAssignmentPersonal:SetBackdropColor(0, 1, 0, 0.6)
								if (count) then
									TOCA.FrameAssignmentPersonal.ESCount:SetText(count)
									if (count <= 4) then
										TOCA.FrameAssignmentPersonal:SetBackdropColor(0.3, 0.7, 0, 0.6)
										if (count <= 2) then
											TOCA.FrameAssignmentPersonal:SetBackdropColor(0.5, 0.6, 0, 0.6)
											if (count <= 1) then
												TOCA.FrameAssignmentPersonal:SetBackdropColor(0.7, 0.3, 0, 0.6)
											end
										end
									end
								end
							end
						end
						_Uindex = _Uindex + 1
					end
				else
					TOCA.FrameAssignmentPersonal:Hide()
			  end --tank connected
			end
	  end --isinraid
	end
end

TOCA.FrameAssignmentPersonalOptionsTitle = TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[5]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameAssignmentPersonalOptionsTitle:SetFont(TOCA._G.font, 12)
TOCA.FrameAssignmentPersonalOptionsTitle:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -20)
TOCA.FrameAssignmentPersonalOptionsTitle:SetText(TOCA._L.UI.ASSIGNMENTS.TITLE)
TOCA.FrameAssignmentPersonalOptionsTitle:SetTextColor(1, 1, 0.5, 1)

TOCA.Button.FrameAssignmentPersonalTest={}
TOCA.Button.FrameAssignmentPersonalTest= CreateFrame("Button", nil, TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[5]], "BackdropTemplate")
TOCA.Button.FrameAssignmentPersonalTest:SetSize(120, 25)
TOCA.Button.FrameAssignmentPersonalTest:SetPoint("TOPLEFT", 20, -50)
TOCA.Button.FrameAssignmentPersonalTest:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.FrameAssignmentPersonalTest:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.FrameAssignmentPersonalTest:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.FrameAssignmentPersonalTest.text = TOCA.Button.FrameAssignmentPersonalTest:CreateFontString(nil, "ARTWORK")
TOCA.Button.FrameAssignmentPersonalTest.text:SetFont(TOCA._G.font, 12)
TOCA.Button.FrameAssignmentPersonalTest.text:SetPoint("CENTER", 0, 0)
TOCA.Button.FrameAssignmentPersonalTest.text:SetText(TOCA._L.UI.ASSIGNMENTS[1][1])
TOCA.Button.FrameAssignmentPersonalTest:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
  TOCA.TooltipDisplay(self, TOCA._L.UI.ASSIGNMENTS[1][1], TOCA._L.UI.ASSIGNMENTS[1][2])
end)
TOCA.Button.FrameAssignmentPersonalTest:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.CloseAllMenus()
end)
TOCA.Button.FrameAssignmentPersonalTest:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
	--TOCA.FrameAssignments:Show()
	TOCA.FrameAssignmentPersonal:Show()
end)
TOCA.Checkbox.FrameAssignments={}
TOCA.Checkbox.FrameAssignments = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[5]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.FrameAssignments:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -90)
TOCA.Checkbox.FrameAssignments:SetChecked(1)
TOCA.Checkbox.FrameAssignments.text = TOCA.Checkbox.FrameAssignments:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.FrameAssignments.text:SetFont(TOCA._G.font, 12, "OUTLINE")
TOCA.Checkbox.FrameAssignments.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.FrameAssignments.text:SetText(TOCA._L.UI.ASSIGNMENTS[2][1])
TOCA.Checkbox.FrameAssignments:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), TOCA._L.UI.ASSIGNMENTS[2][2])
end)
TOCA.Checkbox.FrameAssignments:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)
TOCA.Checkbox.FrameAssignments:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["ESASSIGNMENTS"] = "ON"
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["ESASSIGNMENTS"] = "OFF"
		TOCA.FrameAssignmentPersonal:Hide()
  end
end)

TOCA.FrameAssignmentPersonalOptions={}
TOCA.FrameAssignmentPersonalOptions.Scale={}
TOCA.FrameAssignmentPersonalOptions.Scale = CreateFrame("Slider", "TOCA.FrameAssignmentPersonalOptions.Scale", TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[5]], TOCA.Backdrop.Slider.Template)
TOCA.FrameAssignmentPersonalOptions.Scale:SetWidth(140)
TOCA.FrameAssignmentPersonalOptions.Scale:SetHeight(14)
TOCA.FrameAssignmentPersonalOptions.Scale:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -150)
TOCA.FrameAssignmentPersonalOptions.Scale:SetOrientation('HORIZONTAL')
TOCA.FrameAssignmentPersonalOptions.Scale:EnableMouse(true)
TOCA.FrameAssignmentPersonalOptions.Scale:SetMinMaxValues(0.50, 2.00)
TOCA.FrameAssignmentPersonalOptions.ScaleMin, TOCA.FrameAssignmentPersonalOptions.ScaleMax = TOCA.FrameAssignmentPersonalOptions.Scale:GetMinMaxValues()
TOCA.FrameAssignmentPersonalOptions.Scale:SetValue(1.0)
TOCA.FrameAssignmentPersonalOptions.Scale.Val = TOCA.FrameAssignmentPersonalOptions.Scale:CreateFontString(nil, "ARTWORK")
TOCA.FrameAssignmentPersonalOptions.Scale.Val:SetFont(TOCA._G.font, 11, "OUTLINE")
TOCA.FrameAssignmentPersonalOptions.Scale.Val:SetPoint("CENTER", 0, -14)
TOCA.FrameAssignmentPersonalOptions.Scale.Val:SetText("")
TOCA.FrameAssignmentPersonalOptions.Scale.Title = TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[5]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameAssignmentPersonalOptions.Scale.Title:SetFont(TOCA._G.font, 12)
TOCA.FrameAssignmentPersonalOptions.Scale.Title:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -130)
TOCA.FrameAssignmentPersonalOptions.Scale.Title:SetText(TOCA._L.UI.OPTIONS[3][1])
TOCA.FrameAssignmentPersonalOptions.Scale.Title:SetTextColor(1, 1, 0.5, 1)
getglobal(TOCA.FrameAssignmentPersonalOptions.Scale:GetName() .. 'Low'):SetText('0.50')
getglobal(TOCA.FrameAssignmentPersonalOptions.Scale:GetName() .. 'High'):SetText('2')
TOCA.FrameAssignmentPersonalOptions.Scale:SetScript("OnValueChanged", function()
  TOCA.FrameAssignmentPersonal:SetScale(TOCA.Round(TOCA.FrameAssignmentPersonalOptions.Scale:GetValue(), 2))
  TOCA.FrameAssignmentPersonalOptions.Scale.Val:SetText(TOCA.Round(TOCA.FrameAssignmentPersonalOptions.Scale:GetValue(), 2))
end)
TOCA.FrameAssignmentPersonalOptions.Scale:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, TOCA.FrameAssignmentPersonalOptions.Scale.Title:GetText(), TOCA._L.UI.ASSIGNMENTS[3][2])
end)
TOCA.FrameAssignmentPersonalOptions.Scale:SetScript("OnLeave", function()
  TOCADB[TOCA.player.combine]["CONFIG"]["SCALEPERS"] = TOCA.Round(TOCA.FrameAssignmentPersonalOptions.Scale:GetValue(), 2)
  TOCA.CloseAllMenus()
end)
TOCA.Button.FrameAssignmentPersonalOptionsReset= CreateFrame("Button", nil, TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[5]], "BackdropTemplate")
TOCA.Button.FrameAssignmentPersonalOptionsReset:SetSize(25, 25)
TOCA.Button.FrameAssignmentPersonalOptionsReset:SetPoint("TOPLEFT", 180, -140)
TOCA.Button.FrameAssignmentPersonalOptionsReset:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.FrameAssignmentPersonalOptionsReset:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.FrameAssignmentPersonalOptionsReset:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.FrameAssignmentPersonalOptionsReset:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
  TOCA.TooltipDisplay(self, TOCA._L.UI.OPTIONS[4][1], TOCA._L.UI.OPTIONS[4][2])
end)
TOCA.Button.FrameAssignmentPersonalOptionsReset:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
  TOCA.CloseAllMenus()
end)
TOCA.Button.FrameAssignmentPersonalOptionsReset:SetScript("OnClick", function()
  TOCA.CloseAllMenus()
  TOCA.FrameAssignmentPersonalOptions.Scale:SetValue(1.0)
  TOCADB[TOCA.player.combine]["CONFIG"]["SCALEPERS"] = "1.0"
end)
TOCA.Button.FrameAssignmentPersonalOptionsReset.icon = TOCA.Button.FrameAssignmentPersonalOptionsReset:CreateTexture(nil, "ARTWORK")
TOCA.Button.FrameAssignmentPersonalOptionsReset.icon:SetSize(16, 16)
TOCA.Button.FrameAssignmentPersonalOptionsReset.icon:SetPoint("CENTER", 0, 0)
TOCA.Button.FrameAssignmentPersonalOptionsReset.icon:SetTexture("Interface/Buttons/UI-RefreshButton")

TOCA.Dropdown.FrameAssignmentPostTitle={}
TOCA.Dropdown.FrameAssignmentPostTitle = TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[5]]:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.FrameAssignmentPostTitle:SetFont(TOCA._G.font, 12)
TOCA.Dropdown.FrameAssignmentPostTitle:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -200)
TOCA.Dropdown.FrameAssignmentPostTitle:SetText(TOCA._L.UI.ASSIGNMENTS[4][1])
TOCA.Dropdown.FrameAssignmentPostTitle:SetTextColor(1, 1, 0.5, 1)
--TOCA.FrameAssignmentPersonalOptions.Scale.Title:SetTextColor(1, 1, 0.5, 1)
TOCA.Dropdown.FrameAssignmentPost={}

TOCA.Channels={"Raid", "Whisper", "Custom"}
TOCA.Dropdown.FrameAssignmentPost = CreateFrame("Frame", nil, TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[5]], "UIDropDownMenuTemplate")
TOCA.Dropdown.FrameAssignmentPost:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"]-20, -220)
TOCA.Dropdown.FrameAssignmentPost.displayMode = "MENU"
TOCA.Dropdown.FrameAssignmentPost:SetAlpha(1)
TOCA.Dropdown.FrameAssignmentPost.text = TOCA.Dropdown.FrameAssignmentPost:CreateFontString(nil, "ARTWORK")
TOCA.Dropdown.FrameAssignmentPost.text:SetFont(TOCA._G.font, 11)
TOCA.Dropdown.FrameAssignmentPost.text:SetPoint("TOPLEFT", TOCA.Dropdown.FrameAssignmentPost, "TOPLEFT", 25, -8)
TOCA.Dropdown.FrameAssignmentPost.text:SetText(TOCA.Channels[1])
TOCA.Dropdown.FrameAssignmentPost.onClick = function(self, checked)
  TOCA.Dropdown.FrameAssignmentPost.text:SetText(self.value)
  TOCADB[TOCA.player.combine]["CONFIG"]["ESASSIGNMSG"] = self.value
	--local channelID = GetChannelName("redheals")
	--print(channelID)
	TOCA.FrameAssignmentPostChannelTitle:Hide()
	TOCA.FrameAssignmentPostChannel:Hide()
	if (self.value == "Custom") then
		TOCA.FrameAssignmentPostChannelTitle:Show()
		TOCA.FrameAssignmentPostChannel:Show()
	end
end
TOCA.Dropdown.FrameAssignmentPost.initialize = function(self, level)
  local info = UIDropDownMenu_CreateInfo()
  local i = 0
  for k,v in pairs(TOCA.Channels) do
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
UIDropDownMenu_SetWidth(TOCA.Dropdown.FrameAssignmentPost, 125)

--TOCA.FrameAssignmentPostChannelTitle={}
TOCA.FrameAssignmentPostChannelTitle = TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[5]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameAssignmentPostChannelTitle:SetFont(TOCA._G.font, 12)
TOCA.FrameAssignmentPostChannelTitle:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"]+4, -260)
TOCA.FrameAssignmentPostChannelTitle:SetText(TOCA._L.UI.ASSIGNMENTS[5][1])
TOCA.FrameAssignmentPostChannelTitle:SetTextColor(1, 1, 0.5, 1)
TOCA.FrameAssignmentPostChannelTitle:Hide()

TOCA.FrameAssignmentPostChannel = CreateFrame("EditBox", nil, TOCA.FrameOptionsPage[TOCA._L.UI.TABS.OPTIONS[5]], "BackdropTemplate")
TOCA.FrameAssignmentPostChannel:SetWidth(150)
TOCA.FrameAssignmentPostChannel:SetHeight(24)
TOCA.FrameAssignmentPostChannel:SetFontObject(GameFontWhite)
TOCA.FrameAssignmentPostChannel:SetBackdrop({
  bgFile  = "Interface/ToolTips/CHATBUBBLE-BACKGROUND",
  insets  = {left=-2, right=6, top=2, bottom=2},
})
--TOCA.FrameAssignmentPostChannel:SetAlpha(0.5)
TOCA.FrameAssignmentPostChannel:SetBackdropColor(0, 0, 0, 1)
TOCA.FrameAssignmentPostChannel:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"]+4, -275)
TOCA.FrameAssignmentPostChannel:ClearFocus(self)
TOCA.FrameAssignmentPostChannel:SetAutoFocus(false)
TOCA.FrameAssignmentPostChannel:SetMaxLetters(25)
TOCA.FrameAssignmentPostChannel:SetText("")
TOCA.FrameAssignmentPostChannel.border = CreateFrame("Frame", nil, TOCA.FrameAssignmentPostChannel, "BackdropTemplate")
TOCA.FrameAssignmentPostChannel.border:SetWidth(150)
TOCA.FrameAssignmentPostChannel.border:SetHeight(24)
TOCA.FrameAssignmentPostChannel.border:SetPoint("TOPLEFT", -4, 0)
TOCA.FrameAssignmentPostChannel.border:SetBackdrop({
  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
})
TOCA.FrameAssignmentPostChannel:SetScript("OnKeyUp", function(self)
	if (self:GetText()) then
		TOCADB[TOCA.player.combine]["CONFIG"]["ESASSIGNCHANNEL"] = self:GetText()
	end
  TOCA.CloseAllMenus()
end)
TOCA.FrameAssignmentPostChannel:Hide()
