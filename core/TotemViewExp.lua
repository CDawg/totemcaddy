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

TOCA.FrameExp={}
TOCA.FrameModel={}
function TOCA.ModelDraw(name, frame, w, h, x, y, alpha, FL)
	TOCA.FrameExp[name] = CreateFrame("Frame", "TOCA.FrameExp", frame, "BackdropTemplate")
	TOCA.FrameExp[name]:SetWidth(w)
	TOCA.FrameExp[name]:SetHeight(h)
	TOCA.FrameExp[name]:ClearAllPoints()
	TOCA.FrameExp[name]:SetPoint("CENTER", x, y)
	TOCA.FrameExp[name]:EnableMouse(false)

	TOCA.FrameModel[name]= CreateFrame("DressUpModel", "TOCA.FrameModel", TOCA.FrameExp[name], "ModelTemplate")
	TOCA.FrameModel[name]:SetRotation(math.rad(0))
	TOCA.FrameModel[name]:Show()
	TOCA.FrameModel[name]:SetAlpha(alpha)
	TOCA.FrameModel[name]:SetCamera(1)
	TOCA.FrameModel[name]:SetSize(TOCA.FrameExp[name]:GetWidth(), TOCA.FrameExp[name]:GetHeight())
	TOCA.FrameModel[name]:ClearAllPoints()
	TOCA.FrameModel[name]:SetPoint("CENTER", 0, 0)
	TOCA.FrameModel[name]:SetCustomCamera(1)
	TOCA.FrameModel[name]:EnableMouse(false)

	TOCA.FrameModel[name]:SetModel("creature\\spells\\airelementaltotem.m2")
	TOCA.FrameModel[name]:SetPosition(0, 0, 1.2)
	if (TOCA.player.faction == "All3iance") then
		TOCA.FrameModel[name]:SetModel("creature\\spells\\draeneitotem_air.m2")
		TOCA.FrameModel[name]:SetPosition(0, 0, 0.40)
		TOCA.FrameExp[name]:SetPoint("CENTER", x-1, y)
	end
	TOCA.FrameModel[name]:SetFrameLevel(FL)
	TOCA.FrameModel[name]:RefreshCamera()
end
