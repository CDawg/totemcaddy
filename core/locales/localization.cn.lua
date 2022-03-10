if GetLocale() ~= "zhCN" then return end --Simplified

TOCA._L = {
  TITLE = "图腾球童",

	SPELLS = {
		Unknown = "未知",
	},

	KEYBINDS = {
		TOTEM_RECALL    = "图腾召唤",
		TOTEM_AIR       = "图腾槽：空气",
		TOTEM_EARTH     = "图腾槽：地球",
		TOTEM_FIRE      = "图腾槽：火",
		TOTEM_WATER     = "图腾槽：水",
		SHIELD_WATER    = "盾牌：水",
		SHIELD_LIGHTNING= "盾牌：闪电",
		SHIELD_EARTH    = "盾牌：地球",
	},

	INIT = {
	  "建筑简介",
	  "加载配置文件",
		"十字章提醒",
		"即将到期!",
		"欢迎来到",
		"初始化",
		"过时的版本"
	},

  UI = {
		FRAMESTYLES = {"经典的", "分段的", "网格垂直", "水平网格"},
		BUTTON = {"关闭", "保存", "删除", "是的", "不"},

		TABS = {
		  OPTIONS= {"框架", "图腾集", "通知", "小地图", "键盘"},
		  HELP   = {"更新", "接触", "信用"}
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
			{"Earth Shield Assignments", "Toggle Earth Shield Assignments|n Only displays for raid and Restoration Shamans"},
		},
		FRAME = {
			TITLE = "Frame Menu",
		  {"Lock Frame While In Combat",       "Lock the frame position while in combat.|nThis will prevent the accidental moving of the frame|nwhile accessing/clicking totems."},
		  {"Display Main Menu/Options Buttons","Toggle the Options and Close menu buttons from the frame.|nType |cffffffff/toca show|r if the frame is closed.", "Menu header disabled. Type '/toca options' to reopen."},
			{"Display Frame/Button Borders",     "Toggle borders around the frames/buttons.|n|nBorder enabled is default."},
			{"Display Totemic Call Button",      "Toggle the Totemic Call button to display.|n|nDisplaying the Totemic Call button is by default."},
			{"Display End Caps",                 "Toggle the cosmetic end caps on the main frame.|n|nEnabled (Gryphons) by Default"},
		},
		TIMERS = {
			TITLE = "Timers",
			{"Display Totem Timers",                  "Toggle the current totem living timer in world to|ndisplay on the current totem dropped."},
			{"Display Totem Timers In Minutes",       "Toggle the totem timer display in total seconds|nor minutes and seconds.|nBoth are default."},
			{"Display Reincarnation Timer (Cooldown)","Display the Reincarnation timer at the right top|nof the frame when you have activated Reincarnation.|nThe cooldown timer is live and also displayed."},
			{"Display Shield Details On Frame",       "Display your current shield on the Frame."},
			{"Display Ankh Inventory Count Reminder", "Display a reminder when the Ankh reagent is low in|nyour current inventory.|nThis will display when you have less than " .. TOCA.AnkhReminder .. " Ankhs."},
		},
		TOOLTIP = {
			TITLE = "Tooltip",
			{"Display Totem Tooltip",   "Toggle the mouseover of totem/spell details."},
			{"Anchor Tooltip to Cursor","Toggle the tooltip to follow over the mouse cursor."}
		},

		TOTEMSET = {
			{"设置选择", ""},
			{"设置名称", ""},
			{"图腾秩序", ""},
			{"Delete Totem Set", ""},
			{"Save Totem Set",   ""},
			{"Unable to remove", ""},
			{"Totem Set Saved",  ""},
			{"Totem Set Updated",""},
		},

		NOTIFICATIONS = {
			TITLE = "Notifications",
			{"Trigger Notifications Only During Combat",        "Notifications will only trigger while in combat."},
			{"Notify Me When A Totem Is Expiring",              "A personal notification in the chat window will alert when a totem is expiring."},
			{"Play A Sound When A Totem Is Expiring",           "A chime will sound off when a totem is expiring.|n This is only during combat."},
			{"Notify Me When A Shield Is Expiring Or Low",      "A personal notification in the chat window will alert when your shield is running low or expiring."},
			{"Play A Sound When A Shield Is Expiring Or Low",   "A chime will sound off when your shield is low or expiring."},
			{"Show a Visual Alert When A Totem Is Out Of Range","A visual red border will display when you are out of range of a totem.|n Only totems that benefit an aura."},
		},

		MINIMAP = {
			{"Display Minimap Options Button",     "Hide or display the Minimap Options Button"},
			{"Display Totems On The Minimap",      "Hide or display the Minimap Totem Radius circles. (Only works outside of instances)"},
			{"Display Minimap Totem Radius Solid", "Hide or display the totem radius solid on the Minimap"},
			{"Display Minimap Totem Radius Rings", "Hide or display the totem radius rings on the Minimap"},
			{"Display Minimap Totem Icons",        "Hide or display the totem icons on the Minimap"},
		}
	},

	COMMANDS = {
		{"options",  "Open Totem Caddy Options"},
		{"show",     "Display Totem Caddy (regardless of class)"},
		{"hide",     "Close Totem Caddy"},
		{"profile",  "Display the current saved profile"},
		{"assign",   "Open the Earth Shield Raid Assignment panel"},
		{"help",     "Display the help introduction"},
		{"debug on", "Enable Debug Mode (Very Spammy)"},
		{"debug off","Disable Debug Mode (/reload)"},
		{"build",    "View latest game version and build"},
	}
}

function TOCA._L.Ankh()
	return "Ankhs: |cffffffff".. TOCA.InventoryCountItem(TOCA.item.ANKH) .."|r|n|nAnkh Inventory Count Reminder.|nThis will display when you have less than " .. TOCA.AnkhReminder .. " Ankhs"
end
