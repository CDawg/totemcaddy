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

function TOCA.EventManager(_self, event, prefix, netpacket, _casted, _spellID)
	if (event) then
		if ((event == "ADDON_LOADED") and (prefix == TOCA.Global.prefix)) then
	    TOCA.Notification("v" .. TOCA.Global.version .. "-" .. TOCA.Global.suffix .. " (" .. GetLocale() .. ") " .. TOCA.locale.INIT[6] .. ". Type /" .. TOCA.Global.command .. " for commands.")
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
	    TOCA.SendPacket(TOCA.Net.version .. TOCA.Global.version, "GUILD")
	    if (TOCA.KeyBindsSetOnLoad == 1) then
	      TOCA.SetKeyBindOnLoad()
	      TOCA.KeyBindsSetOnLoad = 2
	    end
	    TOCA.EnableKnownTotems()
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
			--TOCA.AssignmentESRaidSend() --send my resto data
		end

		--Load event last
	  if (event == "CHAT_MSG_ADDON") then
			TOCA.VersionControl(prefix, netpacket) --get version from guild
			--TOCA.AssignmentESRaidGet()
	  end
	end
end
