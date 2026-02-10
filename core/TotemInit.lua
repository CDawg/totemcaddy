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

function TOCA.Init()
  TOCA.FrameMain:Hide()
  TOCA.FrameWeap:Hide()
  if (TOCA.player.classID == 7) then --shaman
    TOCA.FrameMain:Show()
    --TOCA.FrameWeap:Show()
		TOCA.Button.Minimap:Show()
  else
    TOCA.FrameHelp:Hide()
		TOCA.Button.Minimap:Hide()
  end
  if (TOCADB == nil) then
    TOCADB = {}
  end

  if (TOCADB[TOCA.player.combine] == nil) then
    TOCADB[TOCA.player.combine] = {}
    if (TOCADB[TOCA.player.combine]["CONFIG"] == nil) then
      TOCADB[TOCA.player.combine]["CONFIG"] = {}
    end
    if (TOCADB[TOCA.player.combine]["PROFILES"] == nil) then
      TOCADB[TOCA.player.combine]["PROFILES"] = {}
    end
    if (TOCADB[TOCA.player.combine]["LASTSAVED"] == nil) then
      TOCADB[TOCA.player.combine]["LASTSAVED"] = TOCA.Dropdown.Menu[1]
    end
    if (TOCADB[TOCA.player.combine]["DISABLED"] == nil) then
      TOCADB[TOCA.player.combine]["DISABLED"] = "NO"
    end
    if (TOCADB[TOCA.player.combine]["HELP"] == nil) then
      TOCADB[TOCA.player.combine]["HELP"] = "YES"
    end
		if (TOCADB[TOCA.player.combine]["RAID"] == nil) then
			TOCADB[TOCA.player.combine]["RAID"] = {}
		end
    TOCA.Notification(TOCA._L.INIT[1] .. ": " .. TOCA.player.combine)
    TOCADB[TOCA.player.combine]["PROFILES"][TOCA.Dropdown.Menu[1]] = {TOCA_AIR=TOCA.cache[1], TOCA_EARTH=TOCA.cache[2], TOCA_FIRE=TOCA.cache[3], TOCA_WATER=TOCA.cache[4]}
    TOCA.UpdateTotemSet()
		TOCA.UpdateMapButton()
  else
		if (TOCADB[TOCA.player.combine]["RAID"] == nil) then
			TOCADB[TOCA.player.combine]["RAID"] = {}
		end
    --loading profile
    TOCA.Notification(TOCA._L.INIT[2] .. ": " .. TOCA.player.combine)
    if (TOCADB[TOCA.player.combine]["DISABLED"] == "YES") then
      TOCA.FrameMain:Hide()
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["SCALE"]) then
      TOCA.Slider.Scale:SetValue(TOCADB[TOCA.player.combine]["CONFIG"]["SCALE"])
      TOCA.Slider.Scale.Val:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["SCALE"])
    end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["SCALEPERS"]) then
      TOCA.FrameAssignmentPersonalOptions.Scale:SetValue(TOCADB[TOCA.player.combine]["CONFIG"]["SCALEPERS"])
      TOCA.FrameAssignmentPersonalOptions.Scale.Val:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["SCALEPERS"])
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["MAINMENU"] == "OFF") then
      TOCA.Button.CloseMain:Hide()
      TOCA.Checkbox.MainMenu:SetChecked(nil)
      TOCA.FrameMain.Background:SetPoint("CENTER", 0, 0)
    end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["MAINMENUOPT"] == "ON") then
			TOCA.Button.Options:Show()
			TOCA.Checkbox.MainMenuOpt:SetChecked(1)
		end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMEBORDER"] == "OFF") then
      TOCA.Checkbox.FrameBorder:SetChecked(nil)
      TOCA.BorderFrame(false)
			TOCA.BorderFrames = 0
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["ENDCAPS"] == "OFF") then
      TOCA.Button.TotemicCall.ECL:Hide()
      TOCA.Button.TotemicCall.ECR:Hide()
      TOCA.Checkbox.EndCaps:SetChecked(nil)
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["TOTEMICCALL"] == "OFF") then
      TOCA.Button.TotemicCall.ECL:Hide()
      TOCA.Button.TotemicCall.ECR:Hide()
      TOCA.Checkbox.EndCaps:SetAlpha(0.5)
      TOCA.Dropdown.FrameGryphons:SetAlpha(0.5)
      TOCA.Checkbox.Totemic:SetChecked(nil)
      --TOCA.Checkbox.EndCaps:SetChecked(nil)
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["TIMERS"] == "OFF") then
      for i=1, 4 do
        TOCA.Slot.Timer[i]:Hide()
        TOCA.SlotGrid.VerticalTimer[i]:Hide()
        TOCA.SlotGrid.HorizontalTimer[i]:Hide()
      end
      TOCA.Checkbox.Timers:SetChecked(nil)
      TOCA.Checkbox.TimersInMinutes:SetAlpha(0.4)
      --TOCA.Checkbox.TimersInMinutes:SetChecked(nil)
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["TIMERSMINUTES"] == "OFF") then
      TOCA._GTimerInMinutes = false
      TOCA.Checkbox.TimersInMinutes:SetChecked(nil)
    end

		if (TOCADB[TOCA.player.combine]["CONFIG"]["SHIELD"] == "OFF") then
			TOCA.FrameMain.ShieldFrame:Hide()
			TOCA.Checkbox.AuraShield:SetChecked(nil)
		end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["REINC"] == "OFF") then
      TOCA.FrameMain.ReincFrame:Hide()
      TOCA.Checkbox.Reinc:SetChecked(nil)
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["ANKH"] == "OFF") then
      TOCA.FrameMain.AnkhFrame:Hide()
      TOCA.Checkbox.Ankh:SetChecked(nil)
    end

		if (TOCADB[TOCA.player.combine]["CONFIG"]["NOTIFYCOMBAT"] == "OFF") then
			TOCA.Checkbox.NotifyCombat:SetChecked(nil)
	  end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["EXPIREMESSAGE"] == "OFF") then
			TOCA.Checkbox.ExpireMessage:SetChecked(nil)
		end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["EXPIRESOUND"] == "OFF") then
			TOCA.Checkbox.ExpireSound:SetChecked(nil)
			TOCA.Dropdown.Sound.TotemExpire:SetAlpha(0.4)
		end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDFILE"]) then
			TOCA.Dropdown.Sound.TotemExpire.text:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDFILE"])
		end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["EXPIREMESSAGESHIELD"] == "OFF") then
			TOCA.Checkbox.ShieldMessage:SetChecked(nil)
		end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["EXPIRESHIELD"] == "OFF") then
			TOCA.Checkbox.ShieldExpire:SetChecked(nil)
			TOCA.Dropdown.Sound.ShieldExpire:SetAlpha(0.4)
		end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDSHIELDFILE"]) then
			TOCA.Dropdown.Sound.ShieldExpire.text:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["SOUNDSHIELDFILE"])
		end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["TOTEMRADIUSVISUAL"] == "OFF") then
			TOCA.Checkbox.TotemRadiusVisual:SetChecked(nil)
		end

    if (TOCADB[TOCA.player.combine]["CONFIG"]["TOTEMORDER"]) then
      TOCA.SetTotemOrderDropdown()
      TOCA.SetTotemOrder()
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["OPACITY"]) then
      TOCA.Slider.OpacityBG:SetValue(TOCADB[TOCA.player.combine]["CONFIG"]["OPACITY"])
      TOCA.Slider.OpacityBG.Val:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["OPACITY"])
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["OPACITYFG"]) then
      TOCA.Slider.OpacityFG:SetValue(TOCADB[TOCA.player.combine]["CONFIG"]["OPACITYFG"])
      TOCA.Slider.OpacityFG.Val:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["OPACITYFG"])
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMESTYLE"]) then
      TOCA.FrameStyleSet(TOCADB[TOCA.player.combine]["CONFIG"]["FRAMESTYLE"])
      TOCA.Dropdown.FrameStyle.text:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["FRAMESTYLE"])
    else
      TOCA.FrameStyleSet(TOCA._L.UI.FRAMESTYLES[1]) --default
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["FRAMELEVEL"]) then
      TOCA.FrameMain:SetFrameStrata(TOCADB[TOCA.player.combine]["CONFIG"]["FRAMELEVEL"])
      TOCA.FrameWeap:SetFrameStrata(TOCADB[TOCA.player.combine]["CONFIG"]["FRAMELEVEL"])
      TOCA.Dropdown.FrameStrat.text:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["FRAMELEVEL"])
    end
    if (TOCADB[TOCA.player.combine]["LASTSAVED"]) then
      TOCA.SetDDMenu(TOCA.Dropdown.Main, TOCADB[TOCA.player.combine]["LASTSAVED"])
      TOCA.FrameSetsProfile:SetText(TOCADB[TOCA.player.combine]["LASTSAVED"])
      TOCA.Button.DropdownMain.text:SetText(string.sub(TOCADB[TOCA.player.combine]["LASTSAVED"], 0, 18))
    end
    if (TOCADB[TOCA.player.combine]["HELP"] == TOCA._G.version) then
      TOCA.FrameHelp:Hide()
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["MAINPOS"]) then
      local TOCAFrameMainPos = {}
      TOCAFrameMainPos = split(TOCADB[TOCA.player.combine]["CONFIG"]["MAINPOS"], ",")
      TOCA.FrameMain:ClearAllPoints()
      TOCA.FrameMain:SetPoint(TOCAFrameMainPos[1], tonumber(TOCAFrameMainPos[2]), tonumber(TOCAFrameMainPos[3]))
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["WEAPPOS"]) then
      local TOCAFrameWeapPos = {}
      TOCAFrameWeapPos = split(TOCADB[TOCA.player.combine]["CONFIG"]["WEAPPOS"], ",")
      TOCA.FrameWeap:ClearAllPoints()
      TOCA.FrameWeap:SetPoint(TOCAFrameWeapPos[1], tonumber(TOCAFrameWeapPos[2]), tonumber(TOCAFrameWeapPos[3]))
    end
		for totemCat,v in pairsByKeys(TOCA.totems) do
			if (TOCADB[TOCA.player.combine]["CONFIG"]["SEG_POS_" .. totemCat]) then
				local TOCAFrameMainPos = {}
				TOCAFrameMainPos = split(TOCADB[TOCA.player.combine]["CONFIG"]["SEG_POS_" .. totemCat], ",")
				TOCA.FrameSeg[totemCat]:ClearAllPoints()
				TOCA.FrameSeg[totemCat]:SetPoint(TOCAFrameMainPos[1], tonumber(TOCAFrameMainPos[2]), tonumber(TOCAFrameMainPos[3]))
			end
		end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["EXPLODEPOS"]) then
      local TOCAFrameExplodePos = {}
      TOCAFrameExplodePos = split(TOCADB[TOCA.player.combine]["CONFIG"]["EXPLODEPOS"], ",")
      TOCA.FrameExplode:ClearAllPoints()
      TOCA.FrameExplode:SetPoint(TOCAFrameExplodePos[1], tonumber(TOCAFrameExplodePos[2]), tonumber(TOCAFrameExplodePos[3]))
    end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["ESPOS"]) then
			local TOCAFrameESPos = {}
			TOCAFrameESPos = split(TOCADB[TOCA.player.combine]["CONFIG"]["ESPOS"], ",")
			TOCA.FrameAssignments:ClearAllPoints()
			TOCA.FrameAssignments:SetPoint(TOCAFrameESPos[1], tonumber(TOCAFrameESPos[2]), tonumber(TOCAFrameESPos[3]))
		end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["ESPERSPOS"]) then
			local TOCAFrameESPos = {}
			TOCAFrameESPos = split(TOCADB[TOCA.player.combine]["CONFIG"]["ESPERSPOS"], ",")
			TOCA.FrameAssignmentPersonal:ClearAllPoints()
			TOCA.FrameAssignmentPersonal:SetPoint(TOCAFrameESPos[1], tonumber(TOCAFrameESPos[2]), tonumber(TOCAFrameESPos[3]))
		end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["TOOLON"] == "OFF") then
      TOCA.Checkbox.Tooltip:SetChecked(nil)
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["COMBATLOCK"] == "OFF") then
      TOCA.Checkbox.MainLock:SetChecked(nil)
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["ENDCAPSTYLE"] == "Lions") then
      TOCA.Dropdown.FrameGryphons.text:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["ENDCAPSTYLE"])
      TOCA.Button.TotemicCall.ECL:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Human")
      TOCA.Button.TotemicCall.ECR:SetTexture("Interface/MainMenuBar/UI-MainMenuBar-EndCap-Human")
    end
    if (TOCADB[TOCA.player.combine]["CONFIG"]["TOOLPOS"]) then
      local TOCAFrameToolPos = {}
      TOCAFrameToolPos = split(TOCADB[TOCA.player.combine]["CONFIG"]["TOOLPOS"], ",")
      TOCA.Tooltip:ClearAllPoints()
      TOCA.Tooltip:SetPoint(TOCAFrameToolPos[1], tonumber(TOCAFrameToolPos[2]), tonumber(TOCAFrameToolPos[3]))
    end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["MINIMAP_ICON"] == "OFF") then
			TOCA.Checkbox.MinimapButton:SetChecked(nil)
			TOCA.Button.Minimap:Hide()
		end
		TOCA.UpdateMapButton()
		if (TOCADB[TOCA.player.combine]["CONFIG"]["MINIMAP_ICON_POS"]) then
	    local minimapIconPos = split(TOCADB[TOCA.player.combine]["CONFIG"]["MINIMAP_ICON_POS"], ",")
	    if ((minimapIconPos[1]) and (minimapIconPos[2])) then
	      TOCA.Button.Minimap:SetPoint("TOPLEFT", Minimap, "TOPLEFT", minimapIconPos[1]+130, minimapIconPos[2]+22)
	    end
	  end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["MINIMAP_TOTEMS"] == "OFF") then
			TOCA.Checkbox.MinimapTotems:SetChecked(nil)
			TOCA.Checkbox.MinimapTotemSolid:SetAlpha(0.4)
			TOCA.Checkbox.MinimapTotemRings:SetAlpha(0.4)
			TOCA.Checkbox.MinimapTotemIcons:SetAlpha(0.4)
		end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["MINIMAP_TOTEM_RINGS"] == "OFF") then
			TOCA.Checkbox.MinimapTotemRings:SetChecked(nil)
		end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["MINIMAP_TOTEM_SOLID"] == "OFF") then
			TOCA.Checkbox.MinimapTotemSolid:SetChecked(nil)
		end
		if (TOCADB[TOCA.player.combine]["CONFIG"]["MINIMAP_TOTEM_ICONS"] == "OFF") then
			TOCA.Checkbox.MinimapTotemIcons:SetChecked(nil)
		end

		if (TOCADB[TOCA.player.combine]["CONFIG"]["ESASSIGNMSG"]) then
			TOCA.Dropdown.FrameAssignmentPost.text:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["ESASSIGNMSG"])
			if (TOCADB[TOCA.player.combine]["CONFIG"]["ESASSIGNMSG"] == "Custom") then
				TOCA.FrameAssignmentPostChannelTitle:Show()
				TOCA.FrameAssignmentPostChannel:Show()
				if (TOCADB[TOCA.player.combine]["CONFIG"]["ESASSIGNCHANNEL"]) then
					TOCA.FrameAssignmentPostChannel:SetText(TOCADB[TOCA.player.combine]["CONFIG"]["ESASSIGNCHANNEL"])
				end
		  end
		end
    TOCA.UpdateTotemSet()
    TOCA.UpdateDDMenu(TOCA.Dropdown.Main)
    TOCA.UpdateDDMenu(TOCA.Dropdown.Sets)
  end

  TOCA.FrameOptionsMain.name = TOCA._G.title
  --InterfaceOptions_AddCategory(TOCA.FrameOptionsMain)

  TOCA.HideUnknownSpells(false) --check game version first

  if (TOCADB[TOCA.player.combine]["CONFIG"]["TOTEMICCALL"] == "OFF") then
    TOCA.Button.TotemicCall:Hide()
    TOCA.Button.TotemicCall.ECL:Hide()
    TOCA.Button.TotemicCall.ECR:Hide()
  else
		--TOCA.ModelDraw("m_totemiccall", TOCA.Button.TotemicCall, 30, 40, 0, 6, 0.5, 50)
	end
	TOCA.ModelDraw("m_minimap", TOCA.Button.Minimap, 32, 42, 0, 5, 1, 500)

  TOCA.INTROLOG = arrayToString(TOCA._L.INTRO[1]) .. TOCA.CHANGELOG:gsub("###", "") --:gsub("* ", "|r|cfffab734")
  TOCA.TextFrame.text:SetText(TOCA.INTROLOG)

  TOCA.Notification("TOCA.Init()", true)
end
