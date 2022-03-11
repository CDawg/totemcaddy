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

TOCA.Main = CreateFrame("Frame")
TOCA.Main:RegisterEvent("ADDON_LOADED")
TOCA.Main:RegisterEvent("PLAYER_LOGIN")
TOCA.Main:RegisterEvent("PLAYER_TOTEM_UPDATE")
TOCA.Main:RegisterEvent("PLAYER_FLAGS_CHANGED") --resting
TOCA.Main:RegisterEvent("PLAYER_CONTROL_GAINED")
TOCA.Main:RegisterEvent("PLAYER_CONTROL_LOST")
TOCA.Main:RegisterEvent("PLAYER_STARTED_MOVING")
TOCA.Main:RegisterEvent("PLAYER_STOPPED_MOVING")
TOCA.Main:RegisterEvent("PLAYER_REGEN_ENABLED")
TOCA.Main:RegisterEvent("PLAYER_REGEN_DISABLED")
TOCA.Main:RegisterEvent("PLAYER_ROLES_ASSIGNED")
TOCA.Main:RegisterEvent("PLAYER_DEAD")
TOCA.Main:RegisterEvent("UNIT_SPELLCAST_START")
TOCA.Main:RegisterEvent("UNIT_SPELLCAST_STOP")
TOCA.Main:RegisterEvent("UNIT_SPELLCAST_SENT")
TOCA.Main:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
TOCA.Main:RegisterEvent("UNIT_AURA")
TOCA.Main:RegisterEvent("UNIT_MAXPOWER")
TOCA.Main:RegisterEvent("UNIT_POWER_FREQUENT")
TOCA.Main:RegisterEvent("UNIT_INVENTORY_CHANGED")
TOCA.Main:RegisterEvent("UNIT_ENTERED_VEHICLE")
TOCA.Main:RegisterEvent("UNIT_EXITED_VEHICLE")
TOCA.Main:RegisterEvent("BAG_UPDATE")
TOCA.Main:RegisterEvent("CHAT_MSG_ADDON")
TOCA.Main:RegisterEvent("MINIMAP_UPDATE_ZOOM")
TOCA.Main:RegisterEvent("PLAYER_ENTERING_WORLD")
TOCA.Main:RegisterEvent("NEW_WMO_CHUNK") --new worldmap data - one time only (event doesnt fire if the map data is already cached)
TOCA.Main:RegisterEvent("ZONE_CHANGED")
TOCA.Main:RegisterEvent("ZONE_CHANGED_NEW_AREA")
TOCA.Main:RegisterEvent("GROUP_ROSTER_UPDATE")
--TOCA.Main:SetScript("OnUpdate", function(self, lapse)
--end)
TOCA.Main:SetScript("OnEvent", function(self, event, prefix, netpacket, _casted, _spellID)
  TOCA.EventManager(self, event, prefix, netpacket, _casted, _spellID)
end)

function TOCA.EventManager(self, event, prefix, netpacket, _casted, _spellID)
	if (event) then
		if ((event == "ADDON_LOADED") and (prefix == TOCA._G.prefix)) then
	    TOCA.Notification("v" .. TOCA._G.version .. "-" .. TOCA._G.suffix .. " (" .. GetLocale() .. ") " .. TOCA._L.INIT[6] .. ". Type " .. TOCA._G.CMD .. " for commands.")
	    TOCA.Init()
	  end

		if ((event == "UNIT_SPELLCAST_START") or
		(event == "UNIT_SPELLCAST_STOP") or
	  (event == "UNIT_POWER_FREQUENT")) then
	    TOCA.TotemBarUpdate(event)
	  end

		if (event == "UNIT_SPELLCAST_START") then
			if ((prefix == "player") and (_casted)) then
				TOCA.TimerRechargeStart(_casted, false)
			end
		end

	  --technically, this needs to be handled on a different event
	  if (event == "UNIT_SPELLCAST_SENT") then
	    TOCA.TotemBarUpdate(event)
	    if ((prefix == "player") and (_spellID)) then
	      if(_spellID == TOCA.spell.TOTEMIC_CALL) then
	        TOCA.TotemTimerReset("all")
	      end
	      if(_spellID) then
	        --print("debug spell: " .. _spellID)
	        TOCA.TotemTimerResetBySpell(_spellID)
	      end
	    end
	  end
		if (event == "UNIT_SPELLCAST_SUCCEEDED") then
			if ((prefix == "player") and (_casted)) then --spell came from self
				--print("debug spell: " .. _casted)
				TOCA.TimerRechargeStart(_casted, true)
			end
		end

	  if (event == "UNIT_MAXPOWER") then
	    TOCA.TotemBarUpdate(event)
	  end
	  if (event == "UNIT_AURA") then --more accurate on usable spells
	    TOCA.TotemBarUpdate(event)
	  end
	  if (event == "PLAYER_TOTEM_UPDATE") then
	    TOCA.TotemBarUpdate(event)
	    TOCA.TotemBarTimerStart()
			local inInstance, instanceType = IsInInstance()
			if (not inInstance) then
				if (prefix) then
				  TOCA.TotemStampPos(prefix) --totemCat
				end
		  end
	  end

		if ((event == "PLAYER_TOTEM_UPDATE") or
		(event == "PLAYER_STARTED_MOVING") or
		(event == "PLAYER_STOPPED_MOVING")) then
		  TOCA.TotemBarUpdate(event)
		end

	  if (event == "PLAYER_DEAD") then
	    TOCA.TotemTimerReset("all")
	  end

	  if (event == "PLAYER_LOGIN") then
			TOCA.SendPacket(TOCA.Net.version .. TOCA._G.version, "GUILD")
			if (IsInRaid()) then
				TOCA.SendPacket(TOCA.Net.version .. TOCA._G.version, "RAID")
			end
	    if (TOCA.KeyBindsSetOnLoad == 1) then
	      TOCA.SetKeyBindOnLoad()
	      TOCA.KeyBindsSetOnLoad = 2
	    end
	    TOCA.EnableKnownTotems()
			TOCA.BuildRaid()
			--TOCA.AssignmentESRaidSend() --send my resto data
	  end

	  if (event == "BAG_UPDATE") then
	    TOCA.TotemBarUpdate(event) --fire off when enable/disable
	  end

	  if (event == "PLAYER_CONTROL_GAINED") then
	    TOCA.EnableTotems(true)
	    TOCA.Button.TotemicCall.disable:Hide()
	    TOCA.Notification("PLAYER_CONTROL_GAINED", true)
	  end

	  if (event == "PLAYER_CONTROL_LOST") then
	    TOCA.EnableTotems(false)
	    TOCA.Button.TotemicCall.disable:Show()
	    TOCA.Notification("PLAYER_CONTROL_LOST", true)
	  end

	  TOCA.Combat(event)

		if ((event == "GROUP_ROSTER_UPDATE") or (event == "PLAYER_ROLES_ASSIGNED")) then
			TOCA.BuildRaid()
		end

		--Load event last
	  if (event == "CHAT_MSG_ADDON") then
			if (prefix) then
				TOCA.VersionControl(prefix, netpacket) --get version from guild/raid
				--TOCA.AssignmentESRaidGet(prefix, netpacket)

				--get the author of es assignments
				local getPacket = TOCA.ParsePacket(netpacket, TOCA.Net.assign_au)
				if (getPacket) then
					--print(getPacket)
					TOCA.FrameAssignments.author:SetText("Last Update: " .. getPacket)
				end

				--get the es assignments
				local getPacket = TOCA.ParsePacket(netpacket, TOCA.Net.assign_es)
				if (getPacket) then
					print(getPacket)
				end
			end
	  end

	end
end
