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

--print(Minimap:GetZoom())
--MinimapBorder:SetTexture("")
--GetCVar("rotateMinimap")
--if(Minimap:GetZoom()

local _GMMapW = Minimap:GetWidth()
local _GMMapH = Minimap:GetHeight()
TOCA.TotemRadius={}
for i=1, 4 do
	TOCA.TotemRadius[i] = CreateFrame("Frame", nil, UIParent)
	TOCA.TotemRadius[i]:SetWidth(24)
	TOCA.TotemRadius[i]:SetHeight(24)
	TOCA.TotemRadius[i]:SetPoint("CENTER", 0, 0)
	TOCA.TotemRadius[i]:SetFrameStrata("TOOLTIP")
	TOCA.TotemRadius[i]:Hide()
	TOCA.TotemRadius[i].radius = TOCA.TotemRadius[i]:CreateTexture(nil, "ARTWORK")
	TOCA.TotemRadius[i].radius:SetSize(TOCA.TotemRadius[i]:GetWidth(), TOCA.TotemRadius[i]:GetHeight())
	TOCA.TotemRadius[i].radius:SetPoint("CENTER", 0, 0)
	TOCA.TotemRadius[i].radius:SetTexture(TOCA.Global.dir .. "images/radius.tga")
	TOCA.TotemRadius[i].radius:SetBlendMode("BLEND")
	--if (i  )
	TOCA.TotemRadius[i].radius:SetVertexColor(0, 1, 0, 0.4)
	--TOCA.TotemRadius[i].radius:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	--Minimap:SetWidth(_MMapW)
	--Minimap:SetHeight(_MMapH)
end

do
	local GetPlayerMapPosition = GetPlayerMapPosition
	local math_random = math.random
	local point, relativeTo, relativePoint, xOfs, yOfs
	function TOCA.UpdateTotemPosition(totem)
	  point, relativeTo, relativePoint, xOfs, yOfs = totem:GetPoint()
		if xOfs ~= 0 or yOfs ~= 0 then
			totem.oX = xOfs
			totem.oY = yOfs
			totem.IsShaking = true
			totem.lastUpdate = 0
			totem:SetScript("OnUpdate", function(self, elapsed)
				self.lastUpdate = self.lastUpdate + elapsed
				point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
				if self.lastUpdate >= 0.5 then
					self:SetScript("OnUpdate", nil)
					totem.IsShaking = false
					--core:TotemUpdate(self.totemGUID, GetPlayerMapPosition("player"))
					print(self.lastUpdate)
					return
				end
				xOfs = self.oX + (math_random(0, 10) - 5)
				yOfs = self.oY + (math_random(0, 10) - 5)
				self:ClearAllPoints()
				self:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
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
		local posX, posY = position:GetXY()

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

		TOCA.UpdateTotemPosition(TOCA.TotemRadius[totemCat])

	end
end
