if GetLocale() ~= "koKR" then return end

TOCA.locale = {
  TITLE = "토템 캐디",

	SPELLS = {
		Unknown = "알려지지 않은",
	},

	KEYBINDS = {
		TOTEM_RECALL= "토템 콜",
		TOTEM_AIR   = "토템 슬롯: 공기",
		TOTEM_EARTH = "토템 슬롯: 대지",
		TOTEM_FIRE  = "토템 슬롯: 불",
		TOTEM_WATER = "토템 슬롯: 물",
	},

	INIT = {
	  "건물 프로필",
	  "프로필 로드 중",
		"앙크 리마인더",
		"만료됩니다!",
		"에 오신 것을 환영합니다",
		"초기화 중",
		"오래된 버전!"
	},

  UI = {
		BUTTON = {"닫다", "구하다", "삭제", "네", "아니"},

		TABS = {
		  OPTIONS= {"액자", "토템 세트", "알림", "건반"},
		  HELP   = {"업데이트", "연락하다", "신용 거래"}
		},

		OPTIONS = {
			TITLE = "Options Menu",
		  {"Frame Totem Layout",       "|n|cffffffffClassic|r|nFour primary totems that are commonly used and selectable or profile built selection.|n|n|cffffffffGrid Vertical|r|nAll known Totems are displayed vertically organized by category row.|n|n|cffffffffGrid Horizontal|r|nAll known Totems are displayed horizontally organized by category row.|n|n|cffffffffThe totem category orders are configurable in the options menu."},
			{"Frame Layer",              "Sets the overlap over other menu and action bar items|non your screen.|nHigher frames will take precedence over items on screen."},
			{"Frame Scale",              "Increase/Decrease the size of the frame."},
			{"Reset Scale",              "Reset the frame scale to the default size."},
			{"Reset Position",           "Resets the frame position to center of screen."},
			{"Background Opacity",       "Increase/Decrease the background frame transparency."},
			{"Reset Background Opacity", "Reset the background opacity to the default value."},
		  {"Foreground Opacity",       "Increase/Decrease the foreground buttons/dropdown|ntransparency levels."},
			{"Reset Foreground Opacity", "Reset the foreground opacity to the default value."},
		},
		FRAME = {
			TITLE = "Frame Menu",
		  {"Lock Frame While In Combat",       "Lock the frame position while in combat.|nThis will prevent the accidental moving of the frame|nwhile accessing/clicking totems."},
		  {"Display Main Menu/Options Buttons","Toggle the Options and Close menu buttons from the frame.|nType |cffffffff/toca show|r if the frame is closed.", "Menu header disabled. Type '/toca options' to reopen."},
			{"Display Frame/Button Borders",     "Toggle borders around the frames/buttons.|n|nBorder enabled is default."},
			{"Display Totemic Call Button",      "Toggle the Totemic Call button to display.|n|nDisplaying the Totemic Call button is by default."},
			{"Display Gryphons",                 "Toggle the cosmetic end caps on the main frame.|n|nEnabled (Gryphons) by Default"},
		},
		TIMERS = {
			TITLE = "Timers",
			{"Display Totem Timers",                  "Toggle the current totem living timer in world to|ndisplay on the current totem dropped."},
			{"Display Totem Timers In Minutes",       "Toggle the totem timer display in total seconds|nor minutes and seconds.|nBoth are default."},
			{"Display Reincarnation Timer (Cooldown)","Display the Reincarnation timer at the right top|nof the frame when you have activated Reincarnation.|nThe cooldown timer is live and also displayed."},
			{"Display Ankh Inventory Count Reminder", "Display a reminder when the Ankh reagent is low in|ncurrent your inventory.|nThis will display when you have less than " .. TOCA.AnkhReminder .. " Ankhs."},
		},
		TOOLTIP = {
			TITLE = "Tooltip",
			{"Display Totem Tooltip", "Toggle the mouseover of totem/spell details."},
		},

		TOTEMSET = {
			"선택 설정",
			"세트 이름",
			"토템 주문",
		},

		NOTIFICATIONS = {
			TITLE = "Notifications",
			{"Trigger Notifications Only During Combat",    "Notifications will only trigger while in combat."},
			{"Notify Me When A Totem Is Expiring",          "A personal notification in the chat window will alert when a totem is expiring."},
			{"Play A Sound When A Totem Is Expiring",       "A chime will sound off when a totem is expiring.|nThis is only during combat."},
			{"Notify Me When A Shield Is Expiring Or Low",  "A personal notification in the chat window will alert when your shield is running low or expiring."},
			{"Play A Sound When A Shield Is Expiring Or Low","A chime will sound off when your shield is low or expiring."},
		}
	},

	COMMANDS = {
		{"options",  "Open Totem Caddy Options"},
		{"show",     "Display Totem Caddy (regardless of class)."},
		{"hide",     "Close Totem Caddy."},
		{"profile",  "Display the current saved profile."},
		{"help",     "Display the help introduction."},
		{"debug on", "Enable Debug Mode (Very Spammy)"},
		{"debug off","Disable Debug Mode (/reload)"},
		{"build",    "View latest game version and build"},
	}
}

function TOCA.locale.Ankh()
	return "Ankhs: |cffffffff".. TOCA.InventoryCountItem(TOCA.item.ANKH) .."|r|n|nAnkh Inventory Count Reminder.|nThis will display when you have less than " .. TOCA.AnkhReminder .. " Ankhs"
end
