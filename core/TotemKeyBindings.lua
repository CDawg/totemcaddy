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

--[==[
TOCA.Button.KeyBind={}
for i=1, 5 do
	TOCA.Button.KeyBind[i] = CreateFrame("Button", nil, TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[4]], "BackdropTemplate")
	TOCA.Button.KeyBind[i]:SetSize(140, 25)
	TOCA.Button.KeyBind[i]:SetPoint("TOPLEFT", 160, -i*25-2)
	TOCA.Button.KeyBind[i]:SetBackdrop(TOCA.Backdrop.Button)
	TOCA.Button.KeyBind[i]:SetBackdropColor(0.6, 0, 0, 1)
	TOCA.Button.KeyBind[i]:SetBackdropBorderColor(1, 1, 1, 0.6)
	TOCA.Button.KeyBind[i]:SetScript("OnEnter", function(self)
	  self:SetBackdropBorderColor(1, 1, 0.8, 1)
	end)
	TOCA.Button.KeyBind[i]:SetScript("OnLeave", function(self)
	  self:SetBackdropBorderColor(1, 1, 1, 0.6)
	end)
	TOCA.Button.KeyBind[i]:SetScript("OnClick", function()
		TOCA.CloseAllMenus()
		TOCA.FrameOptions:Hide()
		--KeyBindingFrame:Show()
	end)
	TOCA.Button.KeyBind[i].Text = TOCA.Button.KeyBind[i]:CreateFontString(nil, "ARTWORK")
	TOCA.Button.KeyBind[i].Text:SetFont(TOCA.Global.font, 11)
	TOCA.Button.KeyBind[i].Text:SetPoint("CENTER", 0, 0)
	TOCA.Button.KeyBind[i].Text:SetText(i)

	TOCA.Button.KeyBind[i].Title = TOCA.FrameOptionsPage[TOCA.locale.UI.TABS.OPTIONS[4]]:CreateFontString(nil, "ARTWORK")
	TOCA.Button.KeyBind[i].Title:SetFont(TOCA.Global.font, 12)
	TOCA.Button.KeyBind[i].Title:SetPoint("TOPLEFT", 20, -i*25-10)
	TOCA.Button.KeyBind[i].Title:SetText(i)
end
]==]--
