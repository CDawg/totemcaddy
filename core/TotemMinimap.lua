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

--MiniMapTrackingIcon:SetTexCoord(.08, .92, .08, .92) --function round icon

-- this only works outside of instances, so will have to improvise on aura raidus
-- https://worldofwarcraft.com/en-us/news/20335228/patch-notes-world-of-warcraft-71-return-to-karazhan

TOCA.TotemRadiusAlpha = 0.5
TOCA.TotemRadius={}
--mapzoom in = 32
--get spell leanred increase totems??
for i=1, 4 do
	--TOCA.TotemRadius[i] = CreateFrame("Frame", nil, UIParent)
	TOCA.TotemRadius[i] = CreateFrame("Button", nil, Minimap)
	TOCA.TotemRadius[i]:SetWidth(42)
	TOCA.TotemRadius[i]:SetHeight(42)
	TOCA.TotemRadius[i]:SetPoint("CENTER", 0, 0)
	TOCA.TotemRadius[i]:SetFrameStrata(Minimap:GetFrameStrata())
	TOCA.TotemRadius[i]:SetFrameLevel(Minimap:GetFrameLevel())
	TOCA.TotemRadius[i]:Hide()
	TOCA.TotemRadius[i]:SetAlpha(1)
	TOCA.TotemRadius[i].radius = TOCA.TotemRadius[i]:CreateTexture(nil, "ARTWORK")
	TOCA.TotemRadius[i].radius:SetSize(TOCA.TotemRadius[i]:GetWidth(), TOCA.TotemRadius[i]:GetHeight())
	TOCA.TotemRadius[i].radius:SetPoint("CENTER", 0, 0)
	TOCA.TotemRadius[i].radius:SetTexture(TOCA.Global.dir .. "images/radius.tga")
	TOCA.TotemRadius[i].radius:SetBlendMode("BLEND")
	TOCA.TotemRadius[i].radius:SetVertexColor(0, 1, 0, TOCA.TotemRadiusAlpha) --default a green just in case
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
	function TOCA.UpdateTotemPosition(totem, totemCat, stampX, stampY)
		local _GMMapW = Minimap:GetWidth()
		local _GMMapH = Minimap:GetHeight()
		local _GMMRotate = tonumber(GetCVar("rotateMinimap"))
		local _GMMZoom = Minimap:GetZoom()
		local point, relativeTo, relativePoint, xOfs, yOfs = totem:GetPoint()
		local mapSize = 4 --the outside world needs to calc above 3 (Pi)
		local mapEdgeClip = _GMMapW -102 --this is assuming a box/round shaped map of a default 140x140

		if ((xOfs ~= 0) or (yOfs ~= 0)) then
			--totem.oX = xOfs
			--totem.oY = yOfs
			totem.frame = 0
			totem:SetScript("OnUpdate", function(self, lapse)
				local map = C_Map.GetBestMapForUnit("player")
				local position = C_Map.GetPlayerMapPosition(map, "player")
				local playerX, playerY = position:GetXY()
				local playerFC = math.cos(GetPlayerFacing())
				local playerFS = math.sin(GetPlayerFacing())
				--local playerD = GetPlayerFacing()
				--local x, y, z, instanceID = UnitPosition("player")
				--print(playerX)
				--print(x)
				--point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
				distX = stampX - playerX
				distY = stampY - playerY
				--totemX = stampX - distX *(_GMMapW+_GMMapH)*math.pi --*playerX * 20	/ (_GMMapW+_GMMapH) --factor = (mapRadius - iconDiameter) / dist;
				--totemY = stampY - distY *(_GMMapW+_GMMapH)*math.pi --*playerY * 20 / (_GMMapW+_GMMapH)
				if ((IsIndoors()) or (IsResting())) then --in a city, underground or contained map
					mapSize = 1
				end
				--print(mapSize)
				totemX = stampX - distX *(_GMMapW+_GMMapH)*math.pi *mapSize --*playerX * 20	/ (_GMMapW+_GMMapH) --factor = (mapRadius - iconDiameter) / dist;
				totemY = stampY - distY *(_GMMapW+_GMMapH)*math.pi *mapSize --*playerY * 20 / (_GMMapW+_GMMapH)
				--print(IsIndoors())
				--local mapFileName, textureHeight, textureWidth, isMicrodungeon, microDungeonMapName = GetMapInfo(map)
				--print(mapID)
        self.frame = self.frame + lapse
				if (self.frame >= 7500) then --roughly 2mins
					return --no reason to continue if a totem mismatches after expiring
				end
				--[==[
				if self.lastUpdate >= 1.5 then
					self:SetScript("OnUpdate", nil)
					totem.IsShaking = false
					--core:TotemUpdate(self.totemGUID, GetPlayerMapPosition("player"))
					--print(self.lastUpdate)
					return
				end
				xOfs = self.oX + (math_random(0, 10) - 5)
				yOfs = self.oY + (math_random(0, 10) - 5)

				if (totemCat == 4) then
					xOfs = self.oX + 5
					yOfs = self.oY + 5
				end
				]==]--
				--xOfs = self.oX -- + 5
				--yOfs = self.oY -- + 5
				self:ClearAllPoints()
				--local distanceTotal = totemX - totemY
				--print("totemX " .. totemX)
				--print("totemY " .. totemY)
				--print("total " .. distanceTotal)
				if (totem) then
					--print("totemX " .. totemX)
					--print("totemY " .. totemY)
					totem:SetAlpha(1)
					if ((totemX < -mapEdgeClip) or (totemX > mapEdgeClip) or (totemY < -mapEdgeClip) or (totemY > mapEdgeClip)) then --calc the edge of the map
						totem:SetAlpha(0)
					end
				end
				--print("PX " .. playerX)
				--print(totemCat)
				--print(totemY)

				self:SetPoint(point, relativeTo, relativePoint, -totemX, totemY)

				if (_GMMRotate == 1) then
					print(_GMMRotate)
					local dx, dy = totemX, totemY
					local xDist = dx*playerFC - dy*playerFS
					local yDist = dx*playerFS + dy*playerFC
					--print(playerFC)
					--print(xDist)
					self:SetPoint("CENTER", relativeTo, "CENTER", -xDist, yDist)
					--print("rotate is on")
				end
			end)
		end

	end
end

--print(Minimap:GetTexture())
print(Minimap:GetFrameLevel())

TOCA.RadiusTotem={}
TOCA.RadiusTotem.X={}
TOCA.RadiusTotem.Y={}
function TOCA.TotemStampPos(totemCat) --stamp the last pos for the specific totem
	if (totemCat) then --just in case a conflict with a bogus spell
		local map = C_Map.GetBestMapForUnit("player")
		local position = C_Map.GetPlayerMapPosition(map, "player")
		local playerFC = math.cos(GetPlayerFacing())
		local playerFS = math.sin(GetPlayerFacing())
		local posX, posY = position:GetXY()

		--WorldMapFrame:Hide()

		TOCA.TotemPresent[totemCat], TOCA.TotemName[totemCat], TOCA.TotemStartTime[totemCat], TOCA.TotemDuration[totemCat] = GetTotemInfo(totemCat)
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
			--Minimap:SetPoint('CENTER', nil, 'CENTER', TOCA.RadiusTotem.X[TOCA.TotemName[totemCat]], TOCA.RadiusTotem.Y[TOCA.TotemName[totemCat]])
		  TOCA.TotemRadius[totemCat]:SetPoint("CENTER", Minimap, "CENTER", TOCA.RadiusTotem.X[TOCA.TotemName[totemCat]], TOCA.RadiusTotem.Y[TOCA.TotemName[totemCat]])
			--TOCA.TotemRadius[totemCat]:SetPoint("CENTER", Minimap, "CENTER", 0, 0)
			--PlayerFrame:SetUserPlaced(true)
		end

		--print("playerFC " .. playerFC)
		--print("playerFC " .. playerFS)
		local getPlayerFC = 0
		local getPlayerFS = 0
		--[==[
		if (playerFC) then
			getPlayerFC = playerFC --must always have a value to prevent LUA errors
		end
		if (playerFS) then
			getPlayerFS = playerFS
		end
		]==]--

		if ((TOCA.RadiusTotem.X[TOCA.TotemName[totemCat]]) and (TOCA.RadiusTotem.Y[TOCA.TotemName[totemCat]])) then
			if (totemCat == 1) then
				print("fire")
				TOCA.UpdateTotemPosition(TOCA.TotemRadius[totemCat], totemCat, TOCA.RadiusTotem.X[TOCA.TotemName[totemCat]]-0.004*getPlayerFC, TOCA.RadiusTotem.Y[TOCA.TotemName[totemCat]]-0.004*getPlayerFS)
			end
			if (totemCat == 2) then
				print("earth")
				TOCA.UpdateTotemPosition(TOCA.TotemRadius[totemCat], totemCat, TOCA.RadiusTotem.X[TOCA.TotemName[totemCat]]+0.004*getPlayerFC, TOCA.RadiusTotem.Y[TOCA.TotemName[totemCat]]-0.004*getPlayerFS)
			end
			if (totemCat == 3) then
				print("water")
				TOCA.UpdateTotemPosition(TOCA.TotemRadius[totemCat], totemCat, TOCA.RadiusTotem.X[TOCA.TotemName[totemCat]]+0.004*getPlayerFC, TOCA.RadiusTotem.Y[TOCA.TotemName[totemCat]]+0.004*getPlayerFS)
			end
			if (totemCat == 4) then
				print("air")
				TOCA.UpdateTotemPosition(TOCA.TotemRadius[totemCat], totemCat, TOCA.RadiusTotem.X[TOCA.TotemName[totemCat]]-0.004*getPlayerFC, TOCA.RadiusTotem.Y[TOCA.TotemName[totemCat]]+0.004*getPlayerFS)
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
local function UpdateMapButton()
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
    TOCA.Button.Minimap:SetScript("OnUpdate", UpdateMapButton)
end)
TOCA.Button.Minimap:SetScript("OnDragStop", function()
    TOCA.Button.Minimap:StopMovingOrSizing()
    TOCA.Button.Minimap:SetScript("OnUpdate", nil)
    local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.Button.Minimap:GetPoint()
		TOCADB[TOCA.player.combine]["CONFIG"]["MINIMAP_ICON_POS"] = math.ceil(xOfs) .. "," .. math.ceil(yOfs)
    UpdateMapButton()
end)
TOCA.Button.Minimap:ClearAllPoints()
TOCA.Button.Minimap:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 60 - (80 * cos(thisIconPos)),(80 * sin(thisIconPos)) - 56)
TOCA.Button.Minimap:SetScript("OnClick", function()
	TOCA.CloseAllMenus()
	if (TOCA.OptionMenuOpen == 1) then
		TOCA.FrameOptions:Hide()
		TOCA.OptionMenuOpen = 0
	else
		TOCA.OptionMenuOpen = 1
	  TOCA.FrameOptions:Show()
	end
end)
