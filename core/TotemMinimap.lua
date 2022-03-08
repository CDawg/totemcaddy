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

--(.08, .92, .08, .92) --borderless texture

-- this only works outside of instances, so will have to improvise on aura radius
-- https://worldofwarcraft.com/en-us/news/20335228/patch-notes-world-of-warcraft-71-return-to-karazhan

TOCA.TotemRadiusAlpha = 0.8
TOCA.TotemRadius={}
TOCA.TotemRadiusSize = 32 --yards
--mapzoom in = 32
--get spell leanred increase totems??
for i=1, 4 do
	--TOCA.TotemRadius[i] = CreateFrame("Frame", nil, UIParent)
	TOCA.TotemRadius[i] = CreateFrame("Button", nil, Minimap)
	TOCA.TotemRadius[i]:SetSize(TOCA.TotemRadiusSize, TOCA.TotemRadiusSize)
	TOCA.TotemRadius[i]:SetPoint("CENTER", 0, 0)
	TOCA.TotemRadius[i]:SetFrameStrata(Minimap:GetFrameStrata())
	TOCA.TotemRadius[i]:SetFrameLevel(Minimap:GetFrameLevel())
	TOCA.TotemRadius[i]:Hide()
	TOCA.TotemRadius[i]:SetAlpha(1)
	TOCA.TotemRadius[i].icon = TOCA.TotemRadius[i]:CreateTexture(nil, "ARTWORK")
	TOCA.TotemRadius[i].icon:SetSize(8, 8)
	TOCA.TotemRadius[i].icon:SetPoint("CENTER", 0, 0)
	TOCA.TotemRadius[i].icon:SetTexture("")
	TOCA.TotemRadius[i].radius = TOCA.TotemRadius[i]:CreateTexture(nil, "ARTWORK")
	TOCA.TotemRadius[i].radius:SetSize(TOCA.TotemRadius[i]:GetWidth(), TOCA.TotemRadius[i]:GetHeight())
	TOCA.TotemRadius[i].radius:SetPoint("CENTER", 0, 0)
	TOCA.TotemRadius[i].radius:SetTexture(TOCA.Global.dir .. "images/radius_ring.tga")
	TOCA.TotemRadius[i].radius:SetBlendMode("BLEND")
	TOCA.TotemRadius[i].radius:SetVertexColor(0, 1, 0, TOCA.TotemRadiusAlpha) --default a green just in case
	--TOCA.TotemRadius[i].icon:SetBlendMode("BLEND")
	if (i == 1) then --FIRE
		TOCA.TotemRadius[i].radius:SetVertexColor(TOCA.colors.totems.FIRE[1], TOCA.colors.totems.FIRE[2], TOCA.colors.totems.FIRE[3], TOCA.TotemRadiusAlpha)
	elseif (i == 2) then --EARTH
		TOCA.TotemRadius[i].radius:SetVertexColor(TOCA.colors.totems.EARTH[1], TOCA.colors.totems.EARTH[2], TOCA.colors.totems.EARTH[3], TOCA.TotemRadiusAlpha)
	elseif (i == 3) then --WATER
		TOCA.TotemRadius[i].radius:SetVertexColor(TOCA.colors.totems.WATER[1], TOCA.colors.totems.WATER[2], TOCA.colors.totems.WATER[3], TOCA.TotemRadiusAlpha)
	elseif (i == 4) then --AIR
		TOCA.TotemRadius[i].radius:SetVertexColor(TOCA.colors.totems.AIR[1], TOCA.colors.totems.AIR[2], TOCA.colors.totems.AIR[3], TOCA.TotemRadiusAlpha)
	end
	--TOCA.TotemRadius[i].radius:SetTexCoord(0.1, 0.9, 0.1, 0.9)
end

--[==[
hooksecurefunc(WorldMapFrame, "OnMapChanged", function()
  local mapID = WorldMapFrame.mapID
end)
]==]--

do
	function TOCA.UpdateTotemPosition(totem, totemCat, stampX, stampY, totemID)
		local _GMMapW = Minimap:GetWidth()
		local _GMMapH = Minimap:GetHeight()
		local _GMMRotate = tonumber(GetCVar("rotateMinimap"))
		--local _GMMZoom = Minimap:GetZoom()
		local point, relativeTo, relativePoint, xOfs, yOfs = totem:GetPoint()
		local mapSize = 2 --default. the outside world is much larger, some areas are by 3
		local mapEdgeClip = _GMMapW -102 --this is assuming a box/round shaped map of a default 140x140
		local TOTEMIC_MASTERY_TALENT = TOCA.GetOwnerSpell(TOCA.spell.TOTEMIC_MASTERY) --resto shamans with totemic mastery have an increase of 40 yards
		local totemRadius = TOCA.TotemRadiusSize
		if (TOTEMIC_MASTERY_TALENT) then
			totemRadius = totemRadius+10
		end

		if ((xOfs ~= 0) or (yOfs ~= 0)) then
			totem.frame = 0
			totem:SetScript("OnUpdate", function(self, lapse)
				local inInstance, instanceType = IsInInstance()
				local position = {}
				local playerX, playerY = 0.1
				if (totem) then
					totem:SetAlpha(0) --just in case someone left a totem outside or disabled the minimap totems on the fly
					if (TOCADB[TOCA.player.combine]["CONFIG"]["MINIMAP_TOTEMS"] == "OFF") then
						return
					end
					if (not inInstance) then
						local mapData = C_Map.GetBestMapForUnit("player")
						if (mapData) then
							position = C_Map.GetPlayerMapPosition(mapData, "player")
							playerX, playerY = position:GetXY()
							local playerFC = math.cos(GetPlayerFacing())
							local playerFS = math.sin(GetPlayerFacing())
						end
						local _GMMZoom = Minimap:GetZoom()
						local iconMinSize = 6
						local iconMaxSize = iconMinSize*_GMMZoom/2
						if (iconMaxSize < 6) then
							iconMaxSize = iconMinSize
						end

						self.icon:SetSize(iconMaxSize, iconMaxSize)
						self.radius:SetSize(totemRadius, totemRadius)

						if (_GMMZoom >= 1) then
							self.radius:SetSize((_GMMZoom*math.pi)+totemRadius, (_GMMZoom*math.pi)+totemRadius)
							self.icon:SetSize(iconMaxSize, iconMaxSize)
						end
						--print("icms " .. iconMaxSize)

						if (TOCADB[TOCA.player.combine]["CONFIG"]["MINIMAP_TOTEM_ICON"] ~= "OFF") then
							if (totemID) then
							  self.icon:SetTexture(totemID)
						  end
						end

						if ((playerY) and (playerX)) then
							distX = stampX - playerX
							distY = stampY - playerY
						else
							return --something went wrong, abort
						end

						mapSize = math.ceil(_GMMZoom)
						if (mapSize <= 1) then
							mapSize = 2
						end
						if (mapSize > 4) then
							mapSize = 4
						end
						if ((IsIndoors()) or (IsResting())) then --in a city, underground or contained map
							mapSize = 1
						end

						--print(mapSize)

						totemX = stampX - distX *(_GMMapW+_GMMapH)*math.pi *mapSize
						totemY = stampY - distY *(_GMMapW+_GMMapH)*math.pi *mapSize

		        self.frame = self.frame + lapse
						if (self.frame >= 7500) then --roughly 2mins
							return --no reason to continue if a totem mismatches after expiring
						end
						self:ClearAllPoints()
						if (totem) then
							totem:SetAlpha(1)
							if ((totemX < -mapEdgeClip) or (totemX > mapEdgeClip) or (totemY < -mapEdgeClip) or (totemY > mapEdgeClip)) then --calc the edge of the map
								totem:SetAlpha(0)
							end
						end

						self:SetPoint(point, relativeTo, relativePoint, -totemX, totemY)

						if (_GMMRotate == 1) then
							--local dx, dy = totemX, totemY
							local RDistX = totemX*playerFC - totemY*playerFS
							local RDistY = totemX*playerFS + totemY*playerFC
							self:SetPoint("CENTER", relativeTo, "CENTER", -RDistX, RDistY)
						end
					end --does not work in instances
				end
			end)
		end

	end
end

--print(Minimap:GetTexture())
--print(Minimap:GetFrameLevel())

TOCA.RadiusTotem={}
TOCA.RadiusTotem.X={}
TOCA.RadiusTotem.Y={}
function TOCA.TotemStampPos(totemCat) --stamp the last pos for the specific totem
	if (TOCADB[TOCA.player.combine]["CONFIG"]["MINIMAP_TOTEMS"] == "OFF") then
		return
	end

	if (totemCat) then --just in case a conflict with a bogus spell
		local map = C_Map.GetBestMapForUnit("player")
		local position = C_Map.GetPlayerMapPosition(map, "player")
		local playerFC = math.cos(GetPlayerFacing())
		local playerFS = math.sin(GetPlayerFacing())
		local posX, posY = position:GetXY()

		--WorldMapFrame:Hide() --testing. this is dangerous

		TOCA.TotemPresent[totemCat], TOCA.TotemName[totemCat], TOCA.TotemStartTime[totemCat], TOCA.TotemDuration[totemCat], TOCA.TotemID[totemCat] = GetTotemInfo(totemCat)
		if (TOCA.TotemPresent[totemCat]) then
			if (TOCA.TotemName[totemCat]) then
				TOCA.RadiusTotem.X[TOCA.TotemName[totemCat]] = posX --math.floor(posX*10000)
				--print(TOCA.RadiusTotem.X[TOCA.TotemName[totemCat]])
				TOCA.RadiusTotem.Y[TOCA.TotemName[totemCat]] = posY --math.floor(posY*10000)
				--print(TOCA.RadiusTotem.Y[TOCA.TotemName[totemCat]])
			end
		end

		TOCA.TotemRadius[totemCat]:Hide()
		if ((TOCA.RadiusTotem.X[TOCA.TotemName[totemCat]]) and (TOCA.RadiusTotem.X[TOCA.TotemName[totemCat]])) then
			TOCA.TotemRadius[totemCat]:Show()
			TOCA.TotemRadius[totemCat]:ClearAllPoints()
		  TOCA.TotemRadius[totemCat]:SetPoint("CENTER", Minimap, "CENTER", TOCA.RadiusTotem.X[TOCA.TotemName[totemCat]], TOCA.RadiusTotem.Y[TOCA.TotemName[totemCat]])
		end

		local getPlayerFC = 0
		local getPlayerFS = 0
		if (playerFC) then
			getPlayerFC = playerFC - playerFS --must always have a value to prevent LUA errors
		end
		if (playerFS) then
			getPlayerFS = playerFS + playerFC
		end

		if ((TOCA.RadiusTotem.X[TOCA.TotemName[totemCat]]) and (TOCA.RadiusTotem.Y[TOCA.TotemName[totemCat]])) then
			if (totemCat == 1) then
				TOCA.UpdateTotemPosition(TOCA.TotemRadius[totemCat], totemCat, TOCA.RadiusTotem.X[TOCA.TotemName[totemCat]]-0.002*getPlayerFS, TOCA.RadiusTotem.Y[TOCA.TotemName[totemCat]]-0.002*getPlayerFC, TOCA.TotemID[totemCat])
			end
			if (totemCat == 2) then
			TOCA.UpdateTotemPosition(TOCA.TotemRadius[totemCat], totemCat, TOCA.RadiusTotem.X[TOCA.TotemName[totemCat]]+0.002*getPlayerFC, TOCA.RadiusTotem.Y[TOCA.TotemName[totemCat]]-0.002*getPlayerFS, TOCA.TotemID[totemCat])
			end
			if (totemCat == 3) then
				TOCA.UpdateTotemPosition(TOCA.TotemRadius[totemCat], totemCat, TOCA.RadiusTotem.X[TOCA.TotemName[totemCat]]+0.002*getPlayerFS, TOCA.RadiusTotem.Y[TOCA.TotemName[totemCat]]+0.002*getPlayerFC, TOCA.TotemID[totemCat])
			end
			if (totemCat == 4) then
				TOCA.UpdateTotemPosition(TOCA.TotemRadius[totemCat], totemCat, TOCA.RadiusTotem.X[TOCA.TotemName[totemCat]]-0.002*getPlayerFC, TOCA.RadiusTotem.Y[TOCA.TotemName[totemCat]]+0.002*getPlayerFS, TOCA.TotemID[totemCat])
			end
		end

	end
end

--handle the icon down here
TOCA.Button.Minimap = CreateFrame("Button", nil, Minimap)
TOCA.Button.Minimap:SetFrameLevel(499)
TOCA.Button.Minimap:SetFrameStrata("TOOLTIP")
TOCA.Button.Minimap:SetSize(26, 26)
TOCA.Button.Minimap:SetMovable(true)
local MMIcon = TOCA.Global.dir .. "images/totem_icon_minimap.tga"
TOCA.Button.Minimap:SetNormalTexture(MMIcon)
TOCA.Button.Minimap:SetPushedTexture(MMIcon)
TOCA.Button.Minimap:SetHighlightTexture(MMIcon)

local thisIconPos = 0
function TOCA.SaveMapButtonPos()
	local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.Button.Minimap:GetPoint()
	TOCADB[TOCA.player.combine]["CONFIG"]["MINIMAP_ICON_POS"] = math.ceil(xOfs) .. "," .. math.ceil(yOfs)
	TOCA.UpdateMapButton()
end

function TOCA.UpdateMapButton()
  local Xpoa, Ypoa = GetCursorPosition()
  local Xmin, Ymin = Minimap:GetLeft(), Minimap:GetBottom()
  Xpoa = Xmin - Xpoa / Minimap:GetEffectiveScale() + 70
  Ypoa = Ypoa / Minimap:GetEffectiveScale() - Ymin - 70
  thisIconPos = math.deg(math.atan2(Ypoa, Xpoa))
  TOCA.Button.Minimap:ClearAllPoints()
  TOCA.Button.Minimap:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 60 - (80 * cos(thisIconPos)), (80 * sin(thisIconPos)) - 56)
end
TOCA.Button.Minimap:RegisterForDrag("LeftButton")
TOCA.Button.Minimap:SetScript("OnDragStart", function()
    TOCA.Button.Minimap:StartMoving()
    TOCA.Button.Minimap:SetScript("OnUpdate", TOCA.UpdateMapButton)
end)
TOCA.Button.Minimap:SetScript("OnDragStop", function()
    TOCA.Button.Minimap:StopMovingOrSizing()
    TOCA.Button.Minimap:SetScript("OnUpdate", nil)
		TOCA.SaveMapButtonPos()
end)

TOCA.Button.Minimap:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, TOCA.Global.title, "v" .. TOCA.Global.version .. "-" .. TOCA.Global.suffix .. " ("..GetLocale()..")", "", true)
end)
TOCA.Button.Minimap:SetScript("OnLeave", function(self)
	TOCA.CloseAllMenus()
end)

TOCA.Button.Minimap:SetScript("OnClick", function()
	TOCA.CloseAllMenus()
	if (TOCA.OptionMenuOpen == 1) then
		TOCA.FrameOptions:Hide()
		TOCA.OptionMenuOpen = 0
	else
		TOCA.OptionMenuOpen = 1
	  TOCA.FrameOptions:Show()
	end
	TOCA.FrameMain:Show()
end)

TOCA.FrameOptions.Title.Minimap={}
TOCA.FrameOptions.Title.Minimap = TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[4]]:CreateFontString(nil, "ARTWORK")
TOCA.FrameOptions.Title.Minimap:SetFont(TOCA.Global.font, 12)
TOCA.FrameOptions.Title.Minimap:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], -20)
TOCA.FrameOptions.Title.Minimap:SetText(TOCA.locale.UI.TABS.OPTIONS[4])
TOCA.FrameOptions.Title.Minimap:SetTextColor(1, 1, 0.5, 1)

TOCA.Checkbox.MinimapButton={}
TOCA.Checkbox.MinimapButton = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[4]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.MinimapButton:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], TOCA.OptionsPosition_y["FRAMEMENU"]-40)
TOCA.Checkbox.MinimapButton:SetChecked(1)
TOCA.Checkbox.MinimapButton.text = TOCA.Checkbox.MinimapButton:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.MinimapButton.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.MinimapButton.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.MinimapButton.text:SetText(TOCA.locale.UI.MINIMAP[1][1])
TOCA.Checkbox.MinimapButton:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), TOCA.locale.UI.MINIMAP[1][2])
end)
TOCA.Checkbox.MinimapButton:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)
TOCA.Checkbox.MinimapButton:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["MINIMAP_ICON"] = "ON"
		TOCA.Button.Minimap:Show()
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["MINIMAP_ICON"] = "OFF"
		TOCA.Button.Minimap:Hide()
  end
end)

TOCA.Button.MinimapReset= CreateFrame("Button", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[4]], "BackdropTemplate")
TOCA.Button.MinimapReset:SetSize(100, 25)
--TOCA.Button.MinimapReset:SetPoint("CENTER", 0, -180)
TOCA.Button.MinimapReset:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"]+250, TOCA.OptionsPosition_y["FRAMEMENU"]-40)
TOCA.Button.MinimapReset:SetBackdrop(TOCA.Backdrop.Button)
TOCA.Button.MinimapReset:SetBackdropColor(0.6, 0, 0, 1)
TOCA.Button.MinimapReset:SetBackdropBorderColor(1, 1, 1, 0.6)
TOCA.Button.MinimapReset:SetScript("OnEnter", function(self)
  self:SetBackdropBorderColor(1, 1, 0.8, 1)
end)
TOCA.Button.MinimapReset:SetScript("OnLeave", function(self)
  self:SetBackdropBorderColor(1, 1, 1, 0.6)
end)
TOCA.Button.MinimapReset:SetScript("OnClick", function()
	TOCA.SaveMapButtonPos()
end)
TOCA.Button.MinimapResetText = TOCA.Button.MinimapReset:CreateFontString(nil, "ARTWORK")
TOCA.Button.MinimapResetText:SetFont(TOCA.Global.font, 11)
TOCA.Button.MinimapResetText:SetPoint("CENTER", 0, 0)
TOCA.Button.MinimapResetText:SetText(TOCA.locale.UI.OPTIONS[5][1])
TOCA.Button.MinimapReset:SetFrameStrata("TOOLTIP")

TOCA.Checkbox.MinimapTotems={}
TOCA.Checkbox.MinimapTotems = CreateFrame("CheckButton", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[4]], "ChatConfigCheckButtonTemplate")
TOCA.Checkbox.MinimapTotems:SetPoint("TOPLEFT", TOCA.OptionsPosition_x["LEFT"], TOCA.OptionsPosition_y["FRAMEMENU"]-80)
TOCA.Checkbox.MinimapTotems:SetChecked(1)
TOCA.Checkbox.MinimapTotems.text = TOCA.Checkbox.MinimapTotems:CreateFontString(nil, "ARTWORK")
TOCA.Checkbox.MinimapTotems.text:SetFont(TOCA.Global.font, 12, "OUTLINE")
TOCA.Checkbox.MinimapTotems.text:SetPoint("TOPLEFT", 25, -6)
TOCA.Checkbox.MinimapTotems.text:SetText(TOCA.locale.UI.MINIMAP[2][1])
TOCA.Checkbox.MinimapTotems:SetScript("OnEnter", function(self)
  TOCA.TooltipDisplay(self, self.text:GetText(), TOCA.locale.UI.MINIMAP[2][2])
end)
TOCA.Checkbox.MinimapTotems:SetScript("OnLeave", function(self)
  TOCA.CloseAllMenus()
end)
TOCA.Checkbox.MinimapTotems:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    TOCADB[TOCA.player.combine]["CONFIG"]["MINIMAP_TOTEMS"] = "ON"
  else
    TOCADB[TOCA.player.combine]["CONFIG"]["MINIMAP_TOTEMS"] = "OFF"
  end
end)
