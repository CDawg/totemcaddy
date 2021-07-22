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

TOCA.FrameExp = CreateFrame("Button", TOCA.FrameExp, UIParent, "BackdropTemplate")
TOCA.FrameExp:SetWidth(100)
TOCA.FrameExp:SetHeight(120)
TOCA.FrameExp:SetPoint("CENTER", 0, -140)
TOCA.FrameExp:SetMovable(true)
TOCA.FrameExp:EnableMouse(true)
TOCA.FrameExp:RegisterForDrag("LeftButton")
TOCA.FrameExp:SetScript("OnDragStart", function()
  TOCA.FrameExp:StartMoving()
end)
TOCA.FrameExp:SetScript("OnDragStop", function()
  TOCA.FrameExp:StopMovingOrSizing()
  local point, relativeTo, relativePoint, xOfs, yOfs = TOCA.FrameExp:GetPoint()
  --TOCADB[TOCA.player.combine]["CONFIG"]["MAINPOS"] = point .. "," .. xOfs .. "," .. yOfs
end)
TOCA.FrameExp:Hide()

TOCA.FrameModel= CreateFrame("DressUpModel", TOCA.FrameModel, TOCA.FrameExp, "ModelTemplate")
TOCA.FrameModel:SetRotation(math.rad(0))
TOCA.FrameModel:Show()
TOCA.FrameModel:SetAlpha(1)
TOCA.FrameModel:SetCamera(1)
TOCA.FrameModel:SetSize(TOCA.FrameExp:GetWidth(), TOCA.FrameExp:GetHeight())
TOCA.FrameModel:SetPoint("CENTER", 0, 0)
TOCA.FrameModel:SetCustomCamera(1)

--alliance totem
TOCA.FrameModel:SetModel("creature\\spells\\draeneitotem_air.m2")
TOCA.FrameModel:SetPosition(0, 0, 0.40)

--horde totem
--TOCA.FrameModel:SetModel("creature\\spells\\airelementaltotem.m2")
--TOCA.FrameModel:SetPosition(0, 0, 1.2)

TOCA.FrameModel:SetFrameLevel(1)
TOCA.FrameModel:RefreshCamera()

TOCA.FrameLock = CreateFrame("Frame", TOCA.FrameLock, TOCA.FrameExp, "BackdropTemplate")
TOCA.FrameLock:SetWidth(TOCA.FrameExp:GetWidth())
TOCA.FrameLock:SetHeight(TOCA.FrameExp:GetHeight())
TOCA.FrameLock:SetPoint("CENTER", 0, 0)
TOCA.FrameLock:SetFrameLevel(10)
TOCA.FrameLock:SetBackdrop({
  bgFile  = "",
  --edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
  edgeSize= 12,
  insets  = {left=2, right=2, top=2, bottom=2},
})
