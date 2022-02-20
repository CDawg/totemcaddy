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
	TOCA.TotemRadius[i]:SetFrameStrata("FULLSCREEN")
	TOCA.TotemRadius[i]:Hide()
	TOCA.TotemRadius[i].radius = TOCA.TotemRadius[i]:CreateTexture(nil, "ARTWORK")
	TOCA.TotemRadius[i].radius:SetSize(TOCA.TotemRadius[i]:GetWidth(), TOCA.TotemRadius[i]:GetHeight())
	TOCA.TotemRadius[i].radius:SetPoint("CENTER", 0, 0)
	TOCA.TotemRadius[i].radius:SetTexture(TOCA.Global.dir .. "images/radius.tga")
	TOCA.TotemRadius[i].radius:SetBlendMode("BLEND")
	TOCA.TotemRadius[i].radius:SetVertexColor(0, 1, 0, TotemRadiusAlpha) --default a green just in case
	if (i == 1) then --FIRE
		TOCA.TotemRadius[i].radius:SetVertexColor(0.8, 0.4, 0, TOCA.TotemRadiusAlpha)
	elseif (i == 2) then --EARTH
		TOCA.TotemRadius[i].radius:SetVertexColor(0.5, 0.5, 0, TOCA.TotemRadiusAlpha)
	elseif (i == 3) then --WATER
		TOCA.TotemRadius[i].radius:SetVertexColor(0, 0.8, 1, TOCA.TotemRadiusAlpha)
	elseif (i == 4) then --AIR
		TOCA.TotemRadius[i].radius:SetVertexColor(0.5, 0.9, 1, TOCA.TotemRadiusAlpha)
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
		local point, relativeTo, relativePoint, xOfs, yOfs = totem:GetPoint()
		--GetCVar("rotateMinimap")
		--if(Minimap:GetZoom()
		if ((xOfs ~= 0) or (yOfs ~= 0)) then
			--totem.oX = xOfs
			--totem.oY = yOfs
			totem.frame = 0
			totem:SetScript("OnUpdate", function(self, lapse)
				local map = C_Map.GetBestMapForUnit("player")
				local position = C_Map.GetPlayerMapPosition(map, "player")
				local playerX, playerY = position:GetXY()
				local playerD = GetPlayerFacing()
				local mapSize = 4 --the outside world needs to calc above 3
				--local x, y, z, instanceID = UnitPosition("player")
				--print(playerX)
				--print(x)
				--point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
				distX = stampX - playerX
				distY = stampY - playerY
				--totemX = stampX - distX *(_GMMapW+_GMMapH)*math.pi --*playerX * 20	/ (_GMMapW+_GMMapH) --factor = (mapRadius - iconDiameter) / dist;
				--totemY = stampY - distY *(_GMMapW+_GMMapH)*math.pi --*playerY * 20 / (_GMMapW+_GMMapH)
				if (IsResting()) then
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
				xOfs = self.oX -- + 5
				yOfs = self.oY -- + 5
				self:ClearAllPoints()
				--print("TX " .. totemX)
				--print("PX " .. playerX)
				--print("DX " .. distX)
				--print(totemY)
				self:SetPoint(point, relativeTo, relativePoint, -totemX, totemY)
			end)
		end

	end
end

TOCA.RadiusTotem={}
TOCA.RadiusTotem.X={}
TOCA.RadiusTotem.Y={}
function TOCA.TotemStampPos(totemCat) --stamp the last pos for the specific totem
	if (totemCat) then --just in case a conflict with a bogus spell
		local map = C_Map.GetBestMapForUnit("player")
		local position = C_Map.GetPlayerMapPosition(map, "player")
		local playerD = GetPlayerFacing()
		local posX, posY = position:GetXY()

		WorldMapFrame:Hide()

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

		--print(playerD)
		TOCA.UpdateTotemPosition(TOCA.TotemRadius[totemCat], totemCat, TOCA.RadiusTotem.X[TOCA.TotemName[totemCat]], TOCA.RadiusTotem.Y[TOCA.TotemName[totemCat]])

	end
end
