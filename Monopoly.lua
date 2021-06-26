script_name('Mono Tools')
script_properties("work-in-pause")
script_version('2.6')

local use = false
local close = false
local use1 = false
local use2 = false
local use3 = false
local use4 = false
local use5 = false
local close1 = false
local close2 = false
local close3 = false
local close4 = false
local close5 = false
local fontsize = nil
krytim = true

local restore_text = false
local dialogs_data = {}
local dialogIncoming = 0
local game_board = {
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0,
}
local game = 0 -- 0 - not started, 1 - active, 2 - over
local score = 0
local pong = false
local vec = {1, 1}
local ball = {}
local player = {}
local bot = {}
local state = 0
local player_score = 0
local bot_score = 0
local game_speed = 1
local bot_brain = 1
local dif = 1
local dif_colors = {
	0xFF03fcfc, 0xFF02f563, 0xFFFFFF00, 0xFFFF0000
}

bike = {[481] = true, [509] = true, [510] = true}
moto = {[448] = true, [461] = true, [462] = true, [463] = true, [468] = true, [471] = true, [521] = true, [522] = true, [523] = true, [581] = true, [586] = true}

local res = pcall(require, "lib.moonloader")
assert(res, 'Library "lib.moonloader" не найдена. Cкачать все нужны файлы и библиотеки, вы можете на форуме БХ - https://www.blast.hk/threads/89343/')
---------------------------------------------------------------
local res, ffi = pcall(require, 'ffi')
assert(res, 'Library "ffi" не найдена. Cкачать все нужны файлы и библиотеки, вы можете на форуме БХ - https://www.blast.hk/threads/89343/')
---------------------------------------------------------------
local res = pcall(require, 'lib.sampfuncs')
assert(res, 'Library "lib.sampfuncs" не найдена. Cкачать все нужны файлы и библиотеки, вы можете на форуме БХ - https://www.blast.hk/threads/89343/')
---------------------------------------------------------------
local res, sampev = pcall(require, 'lib.samp.events')
assert(res, 'Library "SAMP Events" не найдена. Cкачать все нужны файлы и библиотеки, вы можете на форуме БХ - https://www.blast.hk/threads/89343/')
---------------------------------------------------------------
local res, key = pcall(require, "vkeys")
assert(res, 'Library "vkeys" не найдена. Cкачать все нужны файлы и библиотеки, вы можете на форуме БХ - https://www.blast.hk/threads/89343/')
---------------------------------------------------------------
local res, imgui = pcall(require, "imgui")
assert(res, 'Library "imgui" не найдена. Cкачать все нужны файлы и библиотеки, вы можете на форуме БХ - https://www.blast.hk/threads/89343/')
---------------------------------------------------------------
local res, encoding = pcall(require, "encoding")
assert(res, 'Library "encoding" не найдена. Cкачать все нужны файлы и библиотеки, вы можете на форуме БХ - https://www.blast.hk/threads/89343/')
---------------------------------------------------------------
local res, inicfg = pcall(require, "inicfg")
assert(res, 'Library "inicfg" не найдена. Cкачать все нужны файлы и библиотеки, вы можете на форуме БХ - https://www.blast.hk/threads/89343/')
---------------------------------------------------------------
local res, memory = pcall(require, "memory")
assert(res, 'Library "memory" не найдена. Cкачать все нужны файлы и библиотеки, вы можете на форуме БХ - https://www.blast.hk/threads/89343/')
---------------------------------------------------------------
local res, rkeys = pcall(require, "rkeys")
assert(res, 'Library "rkeys" не найдена. Cкачать все нужны файлы и библиотеки, вы можете на форуме БХ - https://www.blast.hk/threads/89343/')
---------------------------------------------------------------
local res, hk = pcall(require, 'lib.imcustom.hotkey')
assert(res, 'Library "imcustom" не найдена. Cкачать все нужны файлы и библиотеки, вы можете на форуме БХ - https://www.blast.hk/threads/89343/')
------------------------------------------------------------------
local res, notf = pcall(import, "imgui_notf.lua")
assert(res, 'Library "imgui_notf.lua" должна быть в папке lib и moonloader. Cкачать все нужны файлы и библиотеки, вы можете на форуме БХ - https://www.blast.hk/threads/89343/')
------------------------------------------------------------------

local function closeDialog()
	sampSetDialogClientside(true)
	sampCloseCurrentDialogWithButton(0)
	sampSetDialogClientside(false)
end

encoding.default = 'CP1251'
u8 = encoding.UTF8

ffi.cdef[[
	short GetKeyState(int nVirtKey);
	bool GetKeyboardLayoutNameA(char* pwszKLID);
	int GetLocaleInfoA(int Locale, int LCType, char* lpLCData, int cchData);
	
	void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);
	uint32_t __stdcall CoInitializeEx(void*, uint32_t);

	int __stdcall GetVolumeInformationA(
    const char* lpRootPathName,
    char* lpVolumeNameBuffer,
    uint32_t nVolumeNameSize,
    uint32_t* lpVolumeSerialNumber,
    uint32_t* lpMaximumComponentLength,
    uint32_t* lpFileSystemFlags,
    char* lpFileSystemNameBuffer,
    uint32_t nFileSystemNameSize
);
]]
local LocalSerial = ffi.new("unsigned long[1]", 0)
ffi.C.GetVolumeInformationA(nil, nil, 0, LocalSerial, nil, nil, nil, 0)
LocalSerial = LocalSerial[0]

local BuffSize = 32
local KeyboardLayoutName = ffi.new("char[?]", BuffSize)
local LocalInfo = ffi.new("char[?]", BuffSize)
local shell32 = ffi.load 'Shell32'
local ole32 = ffi.load 'Ole32'

chars = {
	["й"] = "q", ["ц"] = "w", ["у"] = "e", ["к"] = "r", ["е"] = "t", ["н"] = "y", ["г"] = "u", ["ш"] = "i", ["щ"] = "o", ["з"] = "p", ["х"] = "[", ["ъ"] = "]", ["ф"] = "a",
	["ы"] = "s", ["в"] = "d", ["а"] = "f", ["п"] = "g", ["р"] = "h", ["о"] = "j", ["л"] = "k", ["д"] = "l", ["ж"] = ";", ["э"] = "'", ["я"] = "z", ["ч"] = "x", ["с"] = "c", ["м"] = "v",
	["и"] = "b", ["т"] = "n", ["ь"] = "m", ["б"] = ",", ["ю"] = ".", ["Й"] = "Q", ["Ц"] = "W", ["У"] = "E", ["К"] = "R", ["Е"] = "T", ["Н"] = "Y", ["Г"] = "U", ["Ш"] = "I",
	["Щ"] = "O", ["З"] = "P", ["Х"] = "{", ["Ъ"] = "}", ["Ф"] = "A", ["Ы"] = "S", ["В"] = "D", ["А"] = "F", ["П"] = "G", ["Р"] = "H", ["О"] = "J", ["Л"] = "K", ["Д"] = "L",
	["Ж"] = ":", ["Э"] = "\"", ["Я"] = "Z", ["Ч"] = "X", ["С"] = "C", ["М"] = "V", ["И"] = "B", ["Т"] = "N", ["Ь"] = "M", ["Б"] = "<", ["Ю"] = ">"
}

ole32.CoInitializeEx(nil, 2 + 4)

mlogo, errorPic, classifiedPic, pentagonPic, accessDeniedPic, gameServer, nasosal_rang = nil, nil, nil, nil, nil, nil -- 
srv, arm = nil, nil -- 
whitelist, superID, vigcout, narcout, order = 0, 0, 0, 0, 0
regDialogOpen, regAcc, UpdateNahuy, checking, getLeader, checkupd = false, false, false, false, false
ScriptUse = 3 
offscript = 0 
pentcout, pentsrv, pentinv, pentuv = 0,0,0,0
regStatus = false -- 
gmsg = false -- 
gosButton, AccessBe = true 
dostupLvl = nil 
activated = nil 
isLocalPlayerSoldier = false 
getMOLeader = "Not Registred" 
getSVLeader = "Not Registred" 
getVVSLeader = "Not Registred"  
getVMFLeader = "Not Registred" 
pidr = false -- 
errorSearch = nil 
flymode = 0 
isPlayerSoldier = false -- 
speed = 0.2 
bstatus = 0 
state = false 
keystatus = false 
mouseCoord = false 
token = 1 
mouseCoord2 = false 
mouseCoord3 = false 
getServerColored = '' 

blackbase = {} -- 
names = {} -- 
SecNames = {}
SecNames2 = {}

files							= {}
window_file						= {}
menu_spur						= imgui.ImBool(false)
name_add_spur					= imgui.ImBuffer(256)
name_edit_spur					= imgui.ImBuffer(256)
find_name_spur					= imgui.ImBuffer(256)
find_text_spur					= imgui.ImBuffer(256)
edit_text_spur					= imgui.ImBuffer(65536)
edit_size_x						= imgui.ImInt(-1)
edit_size_y						= imgui.ImInt(-1)
russian_characters				= { [168] = 'Ё', [184] = 'ё', [192] = 'А', [193] = 'Б', [194] = 'В', [195] = 'Г', [196] = 'Д', [197] = 'Е', [198] = 'Ж', [199] = 'З', [200] = 'И', [201] = 'Й', [202] = 'К', [203] = 'Л', [204] = 'М', [205] = 'Н', [206] = 'О', [207] = 'П', [208] = 'Р', [209] = 'С', [210] = 'Т', [211] = 'У', [212] = 'Ф', [213] = 'Х', [214] = 'Ц', [215] = 'Ч', [216] = 'Ш', [217] = 'Щ', [218] = 'Ъ', [219] = 'Ы', [220] = 'Ь', [221] = 'Э', [222] = 'Ю', [223] = 'Я', [224] = 'а', [225] = 'б', [226] = 'в', [227] = 'г', [228] = 'д', [229] = 'е', [230] = 'ж', [231] = 'з', [232] = 'и', [233] = 'й', [234] = 'к', [235] = 'л', [236] = 'м', [237] = 'н', [238] = 'о', [239] = 'п', [240] = 'р', [241] = 'с', [242] = 'т', [243] = 'у', [244] = 'ф', [245] = 'х', [246] = 'ц', [247] = 'ч', [248] = 'ш', [249] = 'щ', [250] = 'ъ', [251] = 'ы', [252] = 'ь', [253] = 'э', [254] = 'ю', [255] = 'я' }
magicChar						= { '\\', '/', ':', '*', '?', '"', '>', '<', '|' }
	
local SET = {
 	settings = {
		autologin = false,
		autopin = false,
		autopay = false,
		autoopl = false,
		autoopl1 = false,
		autoopl2 = false,
		autoopl3 = false,
		autoopl4 = false,
		autoopl5 = false,
		autoopl6 = false,
		lock = false,
		autopass = '',
		autopasspin = '',
		autoklava = '114',
		autoklavareload = '115',
		activator = 'mono',
		autopassopl = '6',
		autopassopl1 = '15',
		autopassopl2 = '16',
		autopassopl3 = '17',
		zadervka = '3',
		zadervkav2 = '3',
		autopasspay = '5000000',
		autopasspaypin = '8',
		deagleone = '/do "Desert Eagle" в кобуре.',
		deagletwo = '/me достал "Desert Eagle" из кобуры и снял с предохранителя',
		m4one = '/do Винтовка "M4" висит на плече.',
		m4two = '/me снял винтовку с плеча и снял с предохранителя',
		awpone = '/do Снайперская винтовка висит на плече.',
		awptwo = '/me снял cнайперскую винтовку с плеча',
		uzione = '/do Микро Узи висят на спине.',
		uzitwo = '/me достал Микро Узи из-за спины и снял с предохранителя',
		ak47one = '/do Автомат "АК-47" висит на плече.',
		ak47two = '/me снял автомат с плеча и снял с предохранителя',
		mp5one = '/do Полуавтомат "MP5" висит на плече.',
		mp5two = '/me снял с плеча полуавтомат MP5 и снял с предохранителя',
		shotgunone = '/do Дробовик "Shotgun" находится за спиной.',
		shotguntwo = '/me достал дробовик "Shotgun" из-за спины и снял с предохранителя',
		rifleone = '/do Охотничье ружье висит на плече.',
		rifletwo = '/me снял охотничье ружье с плеча и снял с предохранителя',
		knifeone = '/do Нож находится в ножне.',
		knifetwo = '/me правой рукой достай нож из ножны',
		tazerone = '/do Тайзер в кобуре.',
		tazertwo = '/me достал тайзер из кобуры',
		ybralone = '/me убрал оружие',
		shematext1 = '2138',
		shematext2 = '2140',
		shematext3 = '2142',
		shematext4 = '2144',
		shematext5 = '2146',
		shematext6 = '2148',
		shematext7 = '2150',
		shematext8 = '2152',
		shematext9 = '2154',
		shematext10 = '2156',
		shematext11 = '2158',
		shematext12 = '2160',
		shematext13 = '2162',
		shematext14 = '2164',
		shematext15 = '2166',
		shematext16 = '2168',
		shematext17 = '2170',
		shematext18 = '2172',
		shematext19 = '2174',
		shematext20 = '2176',
		shematext21 = '2178',
		shematext22 = '2180',
		shematext23 = '2182',
		shematext24 = '2184',
		shematext25 = '2186',
		shematext26 = '2188',
		shematext27 = '2190',
		shematext28 = '2192',
		shematext29 = '2194',
		shematext30 = '2196',
		shematext31 = '2198',
		shematext32 = '2200',
		shematext33 = '2202',
		shematext34 = '2204',
		shematext35 = '2206',
		shematext36 = '2208',
		timecout = false,
		gangzones = false,
		zones = false,
		assistant = false,
		tag = '',
		enable_tag = false,
		chatInfo = false,
		raskladka = false,
		recongen = false,
		carsis = false,
		keyT = false,
		launcher = false,
		launcherpc = false,
		launcherm = false,
		deagle = false,
		awp = false,
		m4 = false,
		otgun = false,
		uzi = false,
		ak47 = false,
		tazer = false,
		ybral = false,
		mp5 = false,
		shotgun = false,
		rifle = false,
		knife = false,
		eat = false,
		eathouse = false,
		eatmyso = false,
		mvdhelp = false,
		chatcalc = false,
		yashik = false,
		yashik1 = false,
		yashik2 = false,
		yashik3 = false,
		ndr = false,
		toch = false,
		klava = false,
		autobike = false,
		styletest = false,
		styletest1 = false,
		styletest2 = false,
		styletest3 = false,
		styletest4 = false,
		styletest5 = false,
		infoX = 0,
		infoY = 0,
		infoX2 = 0,
		infoY2 = 0,
		spOtr = '',
		timefix = 3,
		enableskin = false,
		skin = 1,
	},
	assistant = {
		asX = 1,
		asY = 1
	},
	DIALOG_EDITOR = 
		{

	},
	informer = {
		hp = true,
		armour = true,
		city = true,
		kv = true,
		time = true,
		rajon = true,
		fps = true,
		online = true,
		ping = true,
		hpcar = true
	}
}


local SeleList = {"Досье", "Сведения", "Пентагон"} 

local SeleListBool = {}
for i = 1, #SeleList do
	SeleListBool[i] = imgui.ImBool(false)
end

local win_state = {}
win_state['main'] = imgui.ImBool(false)
win_state['info'] = imgui.ImBool(false)
win_state['settings'] = imgui.ImBool(false)
win_state['hotkeys'] = imgui.ImBool(false)
win_state['leaders'] = imgui.ImBool(false)
win_state['help'] = imgui.ImBool(false)
win_state['gamer'] = imgui.ImBool(false)
win_state['yashiki'] = imgui.ImBool(false)
win_state['games'] = imgui.ImBool(false)
win_state['redak'] = imgui.ImBool(false)
win_state['bank'] = imgui.ImBool(false)
win_state['shema'] = imgui.ImBool(false)
win_state['shematext'] = imgui.ImBool(false)
win_state['shemainst'] = imgui.ImBool(false)
win_state['carsas'] = imgui.ImBool(false)
win_state['about'] = imgui.ImBool(false)
win_state['update'] = imgui.ImBool(false)
win_state['player'] = imgui.ImBool(false)
win_state['base'] = imgui.ImBool(false)
win_state['informer'] = imgui.ImBool(false)
win_state['regst'] = imgui.ImBool(false)
win_state['renew'] = imgui.ImBool(false)
win_state['find'] = imgui.ImBool(false)
win_state['ass'] = imgui.ImBool(false)
win_state['leave'] = imgui.ImBool(false)
local checked_test = imgui.ImBool(false)
local checked_test2 = imgui.ImBool(false)
local checked_test3 = imgui.ImBool(false)
local checked_test4 = imgui.ImBool(false)
local podarki = imgui.ImBool(false)
local platina = imgui.ImBool(false)
local checked_test5 = imgui.ImBool(false)
local checked_test6 = imgui.ImBool(false)
local checked_test7 = imgui.ImBool(false)
local checked_test8 = imgui.ImBool(false)
local checked_test9 = imgui.ImBool(false)
local checked_test10 = imgui.ImBool(false)
local video = imgui.ImBool(false)
local video1 = imgui.ImBool(false)
local video2 = imgui.ImBool(false)
local video3 = imgui.ImBool(false)
local video4 = imgui.ImBool(false)
local video5 = imgui.ImBool(false)
local video6 = imgui.ImBool(false)
local video7 = imgui.ImBool(false)
local video8 = imgui.ImBool(false)
local video9 = imgui.ImBool(false)
local video10 = imgui.ImBool(false)
local video11 = imgui.ImBool(false)
local video12 = imgui.ImBool(false)
local video13 = imgui.ImBool(false)
local video14 = imgui.ImBool(false)
local video15 = imgui.ImBool(false)
local video16 = imgui.ImBool(false)
local video17 = imgui.ImBool(false)
local video18 = imgui.ImBool(false)
local video19 = imgui.ImBool(false)
local video20 = imgui.ImBool(false)
local video21 = imgui.ImBool(false)
local video22 = imgui.ImBool(false)
local video23 = imgui.ImBool(false)
local video24 = imgui.ImBool(false)
local video25 = imgui.ImBool(false)
local video26 = imgui.ImBool(false)
local video27 = imgui.ImBool(false)
local video28 = imgui.ImBool(false)
local video29 = imgui.ImBool(false)
local video30 = imgui.ImBool(false)
local video31 = imgui.ImBool(false)
local video32 = imgui.ImBool(false)
local video33 = imgui.ImBool(false)
local video34 = imgui.ImBool(false)
local video35 = imgui.ImBool(false)
local checktochilki = false
local checktochilki1 = false
local checktochilki2 = false
local checked_box = imgui.ImBool(false)
local checked_box2 = imgui.ImBool(false)
local checked_box3 = imgui.ImBool(false)
local result = '';
local inputBufferText = imgui.ImBuffer(256)
local sessionStart = os.time()
local sessiononline = 0
local buf = imgui.ImBuffer(2056)
local INFO = {
    nil,
    nil,
    nil,
    nil,
    nil,
    nil
}

function savedialog()
	ini.DIALOG_EDITOR["DIALOG_" .. INFO[1]] = u8:decode(buf.v):gsub('\n', '|_TB_|')
end

pozivnoy = imgui.ImBuffer(256) 
cmd_name = imgui.ImBuffer(256) 
cmd_text = imgui.ImBuffer(65536) 
searchn = imgui.ImBuffer(256) 
specOtr = imgui.ImBuffer(256) 
weather = imgui.ImInt(-1) 
gametime = imgui.ImInt(-1) 
binddelay = imgui.ImInt(3) 
local checked_radio = imgui.ImInt(1)
local hlam = imgui.ImInt(1)

if doesFileExist(getWorkingDirectory() .. "\\config\\Mono\\keys.bind") then 
	os.remove(getWorkingDirectory() .. "\\config\\Mono\\keys.bind")
end

hk._SETTINGS.noKeysMessage = u8("Пусто")
local bfile = getWorkingDirectory() .. "\\config\\Mono\\key.bind" 
local tBindList = {}
if doesFileExist(bfile) then
	local fkey = io.open(bfile, "r")
	if fkey then
		tBindList = decodeJson(fkey:read("a*"))
		fkey:close()
	end
end


local bindfile = getWorkingDirectory() .. '\\config\\Mono\\binder.bind'
local mass_bind = {}
if doesFileExist(bindfile) then
	local fbind = io.open(bindfile, "r")
	if fbind then
		mass_bind = decodeJson(fbind:read("a*"))
		fbind:close()
	end
else
	mass_bind = {
		[1] = { cmd = "-", v = {}, text = "Any text", delay = 3 },
		[2] = { cmd = "-", v = {}, text = "Any text", delay = 3 },
		[3] = { cmd = "-", v = {}, text = "Any text", delay = 3 },
		[4] = { cmd = "-", v = {}, text = "Any text", delay = 3 },
		[5] = { cmd = "-", v = {}, text = "Any text", delay = 3 }
	}
end

writeMemory(0x555854, 4, -1869574000, true)
writeMemory(0x555858, 1, 144, true)

function patch()
	if memory.getuint8(0x748C2B) == 0xE8 then
		memory.fill(0x748C2B, 0x90, 5, true)
	elseif memory.getuint8(0x748C7B) == 0xE8 then
		memory.fill(0x748C7B, 0x90, 5, true)
	end
	if memory.getuint8(0x5909AA) == 0xBE then
		memory.write(0x5909AB, 1, 1, true)
	end
	if memory.getuint8(0x590A1D) == 0xBE then
		memory.write(0x590A1D, 0xE9, 1, true)
		memory.write(0x590A1E, 0x8D, 4, true)
	end
	if memory.getuint8(0x748C6B) == 0xC6 then
		memory.fill(0x748C6B, 0x90, 7, true)
	elseif memory.getuint8(0x748CBB) == 0xC6 then
		memory.fill(0x748CBB, 0x90, 7, true)
	end
	if memory.getuint8(0x590AF0) == 0xA1 then
		memory.write(0x590AF0, 0xE9, 1, true)
		memory.write(0x590AF1, 0x140, 4, true)
	end
end
patch()

function new_style() -- 

	imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = ImVec2(15, 15)
    style.WindowRounding = 5.0
    style.FramePadding = ImVec2(5, 5)
    style.FrameRounding = 4.0
    style.ItemSpacing = ImVec2(12, 8)
    style.ItemInnerSpacing = ImVec2(8, 6)
    style.IndentSpacing = 25.0
    style.ScrollbarSize = 15.0
    style.ScrollbarRounding = 9.0
    style.GrabMinSize = 5.0
	style.GrabRounding = 3.0
	style.WindowTitleAlign = ImVec2(0.5, 0.5)


	colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
    colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 0.50)
    colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 0.80)
    colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
    colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
	colors[clr.TitleBgCollapsed] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.TitleBgActive] = ImVec4(0.07, 0.07, 0.09, 1.00)
	colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 0.50) 	
    colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 0.50)
    colors[clr.CheckMark] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.SliderGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.SliderGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.HeaderHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
    colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
    colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
    colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
    colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
    colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
    colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
    colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
    colors[clr.ModalWindowDarkening] = ImVec4(0.00, 0.00, 0.00, 0.80)

	colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 0.98)
    colors[clr.FrameBg] = ImVec4(0.13, 0.12, 0.15, 1.00)
    colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
	colors[clr.TitleBg] = ImVec4(0.10, 0.09, 0.12, 0.50)

end

function apply_custom_style() -- 

	imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = ImVec2(15, 15)
    style.WindowRounding = 5.0
    style.FramePadding = ImVec2(5, 5)
    style.FrameRounding = 4.0
    style.ItemSpacing = ImVec2(12, 8)
    style.ItemInnerSpacing = ImVec2(8, 6)
    style.IndentSpacing = 25.0
    style.ScrollbarSize = 15.0
    style.ScrollbarRounding = 9.0
    style.GrabMinSize = 5.0
	style.GrabRounding = 3.0
	style.WindowTitleAlign = ImVec2(0.5, 0.5)

	colors[clr.Text] = ImVec4(0.71, 0.94, 0.93, 1.00) 
	colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00) 
	colors[clr.WindowBg] = ImVec4(0.00, 0.06, 0.08, 0.91) 
	colors[clr.ChildWindowBg] = ImVec4(0.00, 0.07, 0.07, 0.91) 
	colors[clr.PopupBg] = ImVec4(0.02, 0.08, 0.09, 0.94) 
	colors[clr.Border] = ImVec4(0.04, 0.60, 0.55, 0.88) 
	colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00) 
	colors[clr.FrameBg] = ImVec4(0.02, 0.60, 0.56, 0.49) 
	colors[clr.FrameBgHovered] = ImVec4(0.10, 0.63, 0.69, 0.72) 
	colors[clr.FrameBgActive] = ImVec4(0.04, 0.54, 0.60, 1.00) 
	colors[clr.TitleBg] = ImVec4(0.00, 0.26, 0.30, 0.94) 
	colors[clr.TitleBgActive] = ImVec4(0.00, 0.26, 0.29, 0.94) 
	colors[clr.TitleBgCollapsed] = ImVec4(0.01, 0.28, 0.40, 0.66) 
	colors[clr.MenuBarBg] = ImVec4(0.00, 0.22, 0.22, 0.73) 
	colors[clr.ScrollbarBg] = ImVec4(0.01, 0.44, 0.43, 0.60) 
	colors[clr.ScrollbarGrab] = ImVec4(0.00, 0.93, 1.00, 0.31) 
	colors[clr.ScrollbarGrabHovered] = ImVec4(0.17, 0.64, 0.79, 1.00) 
	colors[clr.ScrollbarGrabActive] = ImVec4(0.01, 0.48, 0.57, 1.00) 
	colors[clr.ComboBg] = ImVec4(0.01, 0.51, 0.50, 0.74) 
	colors[clr.CheckMark] = ImVec4(0.17, 0.87, 0.85, 0.62) 
	colors[clr.SliderGrab] = ImVec4(0.10, 0.84, 0.87, 0.31) 
	colors[clr.SliderGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00) 
	colors[clr.Button] = ImVec4(0.09, 0.70, 0.75, 0.48) 
	colors[clr.ButtonHovered] = ImVec4(0.15, 0.72, 0.75, 0.69) 
	colors[clr.ButtonActive] = ImVec4(0.13, 0.92, 0.98, 0.47) 
	colors[clr.Header] = ImVec4(0.09, 0.65, 0.69, 0.47) 
	colors[clr.HeaderHovered] = ImVec4(0.07, 0.54, 0.58, 0.47) 
	colors[clr.HeaderActive] = ImVec4(0.06, 0.50, 0.53, 0.47) 
	colors[clr.Separator] = ImVec4(0.00, 0.20, 0.23, 1.00) 
	colors[clr.SeparatorHovered] = ImVec4(0.00, 0.20, 0.23, 1.00) 
	colors[clr.SeparatorActive] = ImVec4(0.00, 0.20, 0.23, 1.00) 
	colors[clr.ResizeGrip] = ImVec4(0.06, 0.90, 0.78, 0.16) 
	colors[clr.ResizeGripHovered] = ImVec4(0.04, 0.54, 0.48, 1.00) 
	colors[clr.ResizeGripActive] = ImVec4(0.01, 0.28, 0.41, 1.00) 
	colors[clr.CloseButton] = ImVec4(0.00, 0.94, 0.96, 0.25) 
	colors[clr.CloseButtonHovered] = ImVec4(0.15, 0.63, 0.61, 0.39) 
	colors[clr.CloseButtonActive] = ImVec4(0.15, 0.63, 0.61, 0.39) 
	colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63) 
	colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00) 
	colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63) 
	colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00) 
	colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43) 
	colors[clr.ModalWindowDarkening] = ImVec4(0.00, 0.00, 0.00, 0.80)

end

function apply_custom_style1()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
	local ImVec2 = imgui.ImVec2

	style.WindowPadding = ImVec2(15, 15)
    style.WindowRounding = 5.0
	style.FramePadding = ImVec2(5, 5)
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(12.0, 8.0)
	style.IndentSpacing = 25.0
    style.ScrollbarSize = 15.0
    style.ScrollbarRounding = 9.0
    style.GrabMinSize = 5.0
    style.GrabRounding = 3.0

    colors[clr.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.Button]                 = ImVec4(0.98, 0.26, 0.26, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
    colors[clr.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.98, 0.26, 0.26, 0.40)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function apply_custom_style2()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
	local ImVec2 = imgui.ImVec2

	style.WindowPadding = ImVec2(15, 15)
    style.WindowRounding = 5.0
	style.FramePadding = ImVec2(5, 5)
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(12.0, 8.0)
	style.IndentSpacing = 25.0
    style.ScrollbarSize = 15.0
    style.ScrollbarRounding = 9.0
    style.GrabMinSize = 5.0
    style.GrabRounding = 3.0

    colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function apply_custom_style4()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
	local ImVec2 = imgui.ImVec2

	style.WindowPadding = ImVec2(15, 15)
    style.WindowRounding = 5.0
	style.FramePadding = ImVec2(5, 5)
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(12.0, 8.0)
	style.IndentSpacing = 25.0
    style.ScrollbarSize = 15.0
    style.ScrollbarRounding = 9.0
    style.GrabMinSize = 5.0
    style.GrabRounding = 3.0
	
    colors[clr.WindowBg]              = ImVec4(0.14, 0.12, 0.16, 1.00);
    colors[clr.ChildWindowBg]         = ImVec4(0.30, 0.20, 0.39, 0.00);
    colors[clr.PopupBg]               = ImVec4(0.05, 0.05, 0.10, 0.90);
    colors[clr.Border]                = ImVec4(0.89, 0.85, 0.92, 0.30);
    colors[clr.BorderShadow]          = ImVec4(0.00, 0.00, 0.00, 0.00);
    colors[clr.FrameBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
    colors[clr.FrameBgHovered]        = ImVec4(0.41, 0.19, 0.63, 0.68);
    colors[clr.FrameBgActive]         = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.TitleBg]               = ImVec4(0.41, 0.19, 0.63, 0.45);
    colors[clr.TitleBgCollapsed]      = ImVec4(0.41, 0.19, 0.63, 0.35);
    colors[clr.TitleBgActive]         = ImVec4(0.41, 0.19, 0.63, 0.78);
    colors[clr.MenuBarBg]             = ImVec4(0.30, 0.20, 0.39, 0.57);
    colors[clr.ScrollbarBg]           = ImVec4(0.30, 0.20, 0.39, 1.00);
    colors[clr.ScrollbarGrab]         = ImVec4(0.41, 0.19, 0.63, 0.31);
    colors[clr.ScrollbarGrabHovered]  = ImVec4(0.41, 0.19, 0.63, 0.78);
    colors[clr.ScrollbarGrabActive]   = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.ComboBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
    colors[clr.CheckMark]             = ImVec4(0.56, 0.61, 1.00, 1.00);
    colors[clr.SliderGrab]            = ImVec4(0.41, 0.19, 0.63, 0.24);
    colors[clr.SliderGrabActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.Button]                = ImVec4(0.41, 0.19, 0.63, 0.44);
    colors[clr.ButtonHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
    colors[clr.ButtonActive]          = ImVec4(0.64, 0.33, 0.94, 1.00);
    colors[clr.Header]                = ImVec4(0.41, 0.19, 0.63, 0.76);
    colors[clr.HeaderHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
    colors[clr.HeaderActive]          = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.ResizeGrip]            = ImVec4(0.41, 0.19, 0.63, 0.20);
    colors[clr.ResizeGripHovered]     = ImVec4(0.41, 0.19, 0.63, 0.78);
    colors[clr.ResizeGripActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.CloseButton]           = ImVec4(1.00, 1.00, 1.00, 0.75);
    colors[clr.CloseButtonHovered]    = ImVec4(0.88, 0.74, 1.00, 0.59);
    colors[clr.CloseButtonActive]     = ImVec4(0.88, 0.85, 0.92, 1.00);
    colors[clr.PlotLines]             = ImVec4(0.89, 0.85, 0.92, 0.63);
    colors[clr.PlotLinesHovered]      = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.PlotHistogram]         = ImVec4(0.89, 0.85, 0.92, 0.63);
    colors[clr.PlotHistogramHovered]  = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.TextSelectedBg]        = ImVec4(0.41, 0.19, 0.63, 0.43);
    colors[clr.ModalWindowDarkening]  = ImVec4(0.20, 0.20, 0.20, 0.35);
end

function apply_custom_style5() 
	imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
	local ImVec2 = imgui.ImVec2

	style.WindowPadding = ImVec2(15, 15)
    style.WindowRounding = 5.0
	style.FramePadding = ImVec2(5, 5)
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(12.0, 8.0)
	style.IndentSpacing = 25.0
    style.ScrollbarSize = 15.0
    style.ScrollbarRounding = 9.0
    style.GrabMinSize = 5.0
    style.GrabRounding = 3.0
  
    colors[clr.Text] = ImVec4(0.95, 0.96, 0.98, 1.00)
    colors[clr.TextDisabled] = ImVec4(0.36, 0.42, 0.47, 1.00)
    colors[clr.WindowBg] = ImVec4(0.11, 0.15, 0.17, 1.00)
    colors[clr.ChildWindowBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
    colors[clr.PopupBg] = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.Border] = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
    colors[clr.FrameBgHovered] = ImVec4(0.12, 0.20, 0.28, 1.00)
    colors[clr.FrameBgActive] = ImVec4(0.09, 0.12, 0.14, 1.00)
    colors[clr.TitleBg] = ImVec4(0.09, 0.12, 0.14, 0.65)
    colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.TitleBgActive] = ImVec4(0.08, 0.10, 0.12, 1.00)
    colors[clr.MenuBarBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
    colors[clr.ScrollbarBg] = ImVec4(0.02, 0.02, 0.02, 0.39)
    colors[clr.ScrollbarGrab] = ImVec4(0.20, 0.25, 0.29, 1.00)
    colors[clr.ScrollbarGrabHovered] = ImVec4(0.18, 0.22, 0.25, 1.00)
    colors[clr.ScrollbarGrabActive] = ImVec4(0.09, 0.21, 0.31, 1.00)
    colors[clr.ComboBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
    colors[clr.CheckMark] = ImVec4(0.28, 0.56, 1.00, 1.00)
    colors[clr.SliderGrab] = ImVec4(0.28, 0.56, 1.00, 1.00)
    colors[clr.SliderGrabActive] = ImVec4(0.37, 0.61, 1.00, 1.00)
    colors[clr.Button] = ImVec4(0.20, 0.25, 0.29, 1.00)
    colors[clr.ButtonHovered] = ImVec4(0.28, 0.56, 1.00, 1.00)
    colors[clr.ButtonActive] = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.Header] = ImVec4(0.20, 0.25, 0.29, 0.55)
    colors[clr.HeaderHovered] = ImVec4(0.26, 0.59, 0.98, 0.80)
    colors[clr.HeaderActive] = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip] = ImVec4(0.26, 0.59, 0.98, 0.25)
    colors[clr.ResizeGripHovered] = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
    colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
    colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
    colors[clr.PlotLines] = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram] = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
    colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end

apply_custom_style()

function files_add()
	if not doesFileExist(getGameDirectory()..'\\moonloader\\config\\Mono\\settings.ini') then 
		inicfg.save(SET, 'config\\Mono\\settings.ini')
	end
end

function rkeys.onHotKey(id, keys) 
	if sampIsChatInputActive() or sampIsDialogActive() or isSampfuncsConsoleActive() or win_state['base'].v or win_state['update'].v or win_state['player'].v or droneActive or keystatus then
		return false
	end
end

function onHotKey(id, keys)
	local sKeys = tostring(table.concat(keys, " "))
	for k, v in pairs(tBindList) do
		if sKeys == tostring(table.concat(v.v, " ")) then
			if k == 7 then 
				reconnect()
				return
			elseif k == 13 then 
				mainmenu()
				return
			end
		end
	end

	for i, p in pairs(mass_bind) do 
		if sKeys == tostring(table.concat(p.v, " ")) then
			rcmd(nil, p.text, p.delay)		
		end
	end
end

function calc(m) 
    local func = load('return '..tostring(m))
    local a = select(2, pcall(func))
    return type(a) == 'number' and a or nil
end

function WorkInBackground(work)
    local memory = require 'memory'
	if work then -- on
        memory.setuint8(7634870, 1) 
        memory.setuint8(7635034, 1)
        memory.fill(7623723, 144, 8)
        memory.fill(5499528, 144, 6)
	else -- off
        memory.setuint8(7634870, 0)
        memory.setuint8(7635034, 0)
        memory.hex2bin('5051FF1500838500', 7623723, 8)
        memory.hex2bin('0F847B010000', 5499528, 6)
    end 
end

function WriteLog(text, path, file) 
	if not doesDirectoryExist(getWorkingDirectory()..'\\'..path..'\\') then
		createDirectory(getWorkingDirectory()..'\\'..path..'\\')
	end
	local file = io.open(getWorkingDirectory()..'\\'..path..'\\'..file..'.txt', 'a+')
	file:write(text..'\n')
	file:flush()
	file:close()
end

local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/' 
function en(data)
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end
function dc(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char(c)
    end))
end

function tags(args)

	args = args:gsub("{params}", tostring(cmdparams))
	args = args:gsub("{paramNickByID}", tostring(sampGetPlayerNickname(cmdparams)))
	args = args:gsub("{paramFullNameByID}", tostring(sampGetPlayerNickname(cmdparams):gsub("_", " ")))
	args = args:gsub("{paramNameByID}", tostring(sampGetPlayerNickname(cmdparams):gsub("_.*", "")))
	args = args:gsub("{paramSurnameByID}", tostring(sampGetPlayerNickname(cmdparams):gsub(".*_", "")))

	args = args:gsub("{mynick}", tostring(userNick))
	args = args:gsub("{myid}", tostring(myID))
	args = args:gsub("{myhp}", tostring(healNew))
	args = args:gsub("{myrang}", tostring(rang))
	args = args:gsub("{myarm}", tostring(armourNew))
	args = args:gsub("{city}", tostring(playerCity))
	args = args:gsub("{org}", tostring(org))
	args = args:gsub("{rtag}", tostring(u8:decode(rtag.v)))
	args = args:gsub("{kvadrat}", tostring(locationPos()))

	args = args:gsub("{time}", string.format(os.date('%H:%M:%S', moscow_time)))
	args = args:gsub("{myfname}", tostring(nickName))
	args = args:gsub("{myname}", tostring(userNick:gsub("_.*", "")))
	args = args:gsub("{mysurname}", tostring(userNick:gsub(".*_", "")))
	args = args:gsub("{zone}", tostring(ZoneInGame))
	args = args:gsub("{fid}", tostring(lastfradioID))
	args = args:gsub("{rid}", tostring(lastrradioID))
	args = args:gsub("{ridrang}", tostring(lastrradiozv))
	args = args:gsub("{fidrang}", tostring(lastfradiozv))
	args = args:gsub("{ridnick}", tostring(sampGetPlayerNickname(lastrradioID)))
	args = args:gsub("{fidnick}", tostring(sampGetPlayerNickname(lastfradioID)))
	args = args:gsub("{ridfname}", tostring(sampGetPlayerNickname(lastrradioID):gsub("_", " ")))
	args = args:gsub("{fidfname}", tostring(sampGetPlayerNickname(lastfradioID):gsub("_", " ")))
	args = args:gsub("{ridname}", tostring(sampGetPlayerNickname(lastrradioID):gsub("_.*", " ")))
	args = args:gsub("{fidname}", tostring(sampGetPlayerNickname(lastfradioID):gsub("_.*", " ")))
	args = args:gsub("{ridsurname}", tostring(sampGetPlayerNickname(lastrradioID):gsub(".*_", " ")))
	args = args:gsub("{fidsurname}", tostring(sampGetPlayerNickname(lastfradioID):gsub(".*_", " ")))

	if newmark ~= nil then
		args = args:gsub("{targetfname}", tostring(sampGetPlayerNickname(blipID):gsub("_", " ")))
		args = args:gsub("{targetname}", tostring(sampGetPlayerNickname(blipID):gsub("_.*", "")))
		args = args:gsub("{targetsurname}", tostring(sampGetPlayerNickname(blipID):gsub(".*_", "")))
		args = args:gsub("{targetnick}", tostring(sampGetPlayerNickname(blipID)))
		args = args:gsub("{tID}", tostring(blipID))
	end
	return args
end

function mainmenu()
	if not win_state['player'].v and not win_state['update'].v and not win_state['base'].v and not win_state['regst'].v then
		if win_state['settings'].v then
			win_state['settings'].v = not win_state['settings'].v
		elseif win_state['leaders'].v then
			win_state['leaders'].v = not win_state['leaders'].v
		elseif win_state['about'].v then
			win_state['about'].v = not win_state['about'].v
		elseif win_state['help'].v then
			win_state['help'].v = not win_state['help'].v
		elseif win_state['yashiki'].v then
			win_state['yashiki'].v = not win_state['yashiki'].v
		elseif win_state['gamer'].v then
			win_state['gamer'].v = not win_state['gamer'].v
		elseif win_state['games'].v then
			win_state['games'].v = not win_state['games'].v
		elseif win_state['redak'].v then
			win_state['redak'].v = not win_state['redak'].v
		elseif win_state['bank'].v then
			win_state['bank'].v = not win_state['bank'].v
		elseif win_state['shema'].v then
			win_state['shema'].v = not win_state['shema'].v
		elseif win_state['shematext'].v then
			win_state['shematext'].v = not win_state['shematext'].v
		elseif win_state['shemainst'].v then
			win_state['shemainst'].v = not win_state['shemainst'].v
		elseif win_state['carsas'].v then
			win_state['carsas'].v = not win_state['carsas'].v
		elseif win_state['info'].v then
			win_state['info'].v = not win_state['info'].v
		elseif menu_spur.v then
			menu_spur.v = not menu_spur.v
		end
		win_state['main'].v = not win_state['main'].v
		imgui.Process = win_state['main'].v

		offscript = 0
		selected = 1
		selected2 = 2
		selected3 = 3
		showSet = 1
		leadSet = 1
	end
end

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	load_settings()
	getfps()
	_, myID = sampGetPlayerIdByCharHandle(PLAYER_PED)
	userNick = sampGetPlayerNickname(myID)
	nickName = userNick:gsub('_', ' ')
	sampAddChatMessage("[Mono Tools]{FFFFFF} Скрипт успешно запущен! Версия: {00C2BB}"..thisScript().version.."{FFFFFF}. Активация {00C2BB}/"..activator.v.."{FFFFFF}", 0x046D63)
	
	if mass_bind ~= nil then
		for k, p in ipairs(mass_bind) do
			if p.cmd ~= "-" then
				rcmd(p.cmd, p.text, p.delay)
			end
		end
	else
		mass_bind = {
			[1] = { cmd = "-", v = {}, text = "Any text", delay = 3 },
			[2] = { cmd = "-", v = {}, text = "Any text", delay = 3 },
			[3] = { cmd = "-", v = {}, text = "Any text", delay = 3 },
			[4] = { cmd = "-", v = {}, text = "Any text", delay = 3 },
			[5] = { cmd = "-", v = {}, text = "Any text", delay = 3 }
		}
	end
	for i, g in pairs(mass_bind) do
		rkeys.registerHotKey(g.v, true, onHotKey)
	end
	
	local font = renderCreateFont("Arial", 8, 5)
    sampRegisterChatCommand("td_get", function(i)
        print(sampTextdrawGetString(i))
        sampAddChatMessage(sampTextdrawGetString(i), -1)
    end)

	inputHelpText = renderCreateFont("Arial", 10, FCR_BORDER + FCR_BOLD)
	lua_thread.create(showInputHelp)
	lua_thread.create(informerperem)
	lua_thread.create(roulette)
	lua_thread.create(shemamain)
	lua_thread.create(ponggame)
	lua_thread.create(eating)
	lua_thread.create(snakegaming)
	lua_thread.create(calculator)
	lua_thread.create(rpgunsin)
	if raskladka.v then
	lua_thread.create(inputChat)
	end
	
	sampRegisterChatCommand("cc", ClearChat) -- очистка чата
	sampRegisterChatCommand("drone", drone) -- дроны
	sampRegisterChatCommand("leave", function() if not win_state['player'].v and not win_state['update'].v and not win_state['main'].v then win_state['leave'].v = not win_state['leave'].v end end) -- не вводить команду, она нужна не для этого.
	sampRegisterChatCommand("reload", rel) -- перезагрузка скрипта
	sampRegisterChatCommand("changeskin", ex_skin) -- не вводить команду, она нужна не для этого.
	sampRegisterChatCommand(activator.v, mainmenu) -- меню скрипта
	sampRegisterChatCommand('rul', rul) -- не вводить команду, она нужна не для этого.
	sampRegisterChatCommand('afind', afind) -- регистрируем команду
	sampRegisterChatCommand('sfind', sfind) -- регистрируем команду
	sampRegisterChatCommand('recon', recongenius) -- регистрируем команду
	autoupdate("https://raw.githubusercontent.com/KabanBunya/Tools/main/update.json", '['..string.upper(thisScript().name)..']: ')
	while token == 0 do wait(0) end
	if enableskin.v then changeSkin(-1, localskin.v) end
	while true do
		wait(0)
		unix_time = os.time(os.date('!*t'))
		moscow_time = unix_time + timefix.v * 60 * 60
		
		if sampGetGamestate() == 3 then sessiononline = os.time() - sessionStart end
		if gametime.v ~= -1 then writeMemory(0xB70153, 1, gametime.v, true) end -- установка игрового времени
		if weather.v ~= -1 then writeMemory(0xC81320, 1, weather.v, true) end -- установка игровой погоды
		if not sampIsChatInputActive() and klava.v and isKeyJustPressed(u8:decode(autoklavareload.v)) then thisScript():reload() end
		if not sampIsChatInputActive() and klava.v and isKeyJustPressed(u8:decode(autoklava.v)) then mainmenu() end
		
		armourNew = getCharArmour(PLAYER_PED) -- получаем броню
		healNew = getCharHealth(PLAYER_PED) -- получаем ХП
		ping = sampGetPlayerPing(myID)
		interior = getActiveInterior() -- получаем инту
		
		-- получение названия района на инглише(работает только при включенном английском в настройках игры, иначе иероглифы)
		local zX, zY, zZ = getCharCoordinates(playerPed)
		ZoneInGame = getGxtText(getNameOfZone(zX, zY, zZ))
		
		if afind == 1 then -- проверяем активирован ли скрипт
			sampSendChat('/find '..id_find) -- сообщение в чат
			wait(2000) -- задержка между /find
		end
		
		if toggle then --params that not declared has a nil value that same as false
			for a = 0, 2304	do --cycle trough all textdeaw id
				if sampTextdrawIsExists(a) then --if textdeaw exists then
					x, y = sampTextdrawGetPos(a) --we get it's position. value returns in game coords
					x1, y1 = convertGameScreenCoordsToWindowScreenCoords(x, y) --so we convert it to screen cuz render needs screen coords
					renderFontDrawText(font, a, x1, y1, 0xFFBEBEBE) --and then we draw it's id on textdeaw position
				end
			end
		end
			
		-- определение города
		local citiesList = {'Los-Santos', 'San-Fierro', 'Las-Venturas'}
		local city = getCityPlayerIsIn(PLAYER_HANDLE)
		if city > 0 then playerCity = citiesList[city] else playerCity = "Нет сигнала" end

		-- задаем названия зонам по координатам
		if vmfZone then ZoneText = "Navy Base"
		elseif vvsZone then ZoneText = "Air Forces Base"
		elseif avikZone then ZoneText = "AirCraft Carrier"
		elseif svZone then ZoneText = "Ground Forces"
		else ZoneText = "-" end
		
		if files[1] then
			for i, k in pairs(files) do
				if k and not imgui.Process then imgui.Process = menu_spur.v or window_file[i].v end
			end
		else imgui.Process = menu_spur.v end
		
		imgui.Process = win_state['regst'].v or win_state['main'].v or win_state['update'].v or win_state['player'].v or win_state['base'].v or win_state['informer'].v or win_state['renew'].v or win_state['find'].v or win_state['ass'].v or win_state['leave'].v or win_state['games'].v or win_state['redak'].v or win_state['shematext'].v or win_state['shemainst'].v or ok or help
		
		if menu_spur.v or win_state['settings'].v or win_state['leaders'].v or win_state['player'].v or win_state['base'].v or win_state['regst'].v or win_state['renew'].v or win_state['leave'].v then
			if not isCharInAnyCar(PLAYER_PED) then
				lockPlayerControl(false)
			end
		elseif droneActive then
			lockPlayerControl(true)
		elseif win_state['games'].v then
			lockPlayerControl(true)
		elseif pong then
			lockPlayerControl(true)
		elseif snaketaken then
			lockPlayerControl(true)
		elseif workpause then
			if userNick ~= "" then
				sampSetChatInputEnabled(false)
			end
			lockPlayerControl(true)
		else
			lockPlayerControl(false)
		end

		if keyT.v then -- чат на русскую Т
			if(isKeyDown(key.VK_T) and wasKeyPressed(key.VK_T))then
				if(not sampIsChatInputActive() and not sampIsDialogActive()) then
					sampSetChatInputEnabled(true)
				end
			end
		end
		
		if not sampIsChatInputActive() and isCharOnAnyBike(playerPed) and isKeyDown(0xA0) and autobike.v then
			if bike[getCarModel(storeCarCharIsInNoSave(playerPed))] then
				setGameKeyState(16, 255)
				wait(10)
				setGameKeyState(16, 0)
			elseif not sampIsChatInputActive() and moto[getCarModel(storeCarCharIsInNoSave(playerPed))] and autobike.v then
				setGameKeyState(1, -128)
				wait(10)
				setGameKeyState(1, 0)
			end
		end
		
		if dialogIncoming ~= 0 and dialogs_data[dialogIncoming] and ndr.v then
		local data = dialogs_data[dialogIncoming]
		if data[1] and not restore_text then
			sampSetCurrentDialogListItem(data[1])
		end
		if data[2] then
			sampSetCurrentDialogEditboxText(data[2])
		end
		dialogIncoming = 0
		end
		if styletest.v then -- стили
			apply_custom_style1()
			end
		if styletest1.v then -- стили
			apply_custom_style()
			end
		if styletest2.v then -- стили
			apply_custom_style2()
			end
		if styletest3.v then -- стили
			new_style()
			end
		if styletest4.v then -- стили
			apply_custom_style4()
			end
		if styletest5.v then -- стили
			apply_custom_style5()
			end
		for i = 0, sampGetMaxPlayerId(true) do 
			if sampIsPlayerConnected(i) then
				local result, ped = sampGetCharHandleBySampPlayerId(i)
				if result then
					local positionX, positionY, positionZ = getCharCoordinates(ped)
					local localX, localY, localZ = getCharCoordinates(PLAYER_PED)
					local distance = getDistanceBetweenCoords3d(positionX, positionY, positionZ, localX, localY, localZ)
					if droneActive then
						EmulShowNameTag(i, false)
					end
				end
			end
		end
	end
end

function EmulShowNameTag(id, value)
    local bs = raknetNewBitStream()
    raknetBitStreamWriteInt16(bs, id)
    raknetBitStreamWriteBool(bs, value)
    raknetEmulRpcReceiveBitStream(80, bs)
    raknetDeleteBitStream(bs)
end

function sampev.onSendSpawn()
	showCursor(false)
end

function onQuitGame()
	saveSettings(2)
end

function onScriptTerminate(script, quitGame)
	if script == thisScript() then
		showCursor(false)
		saveSettings(1)
			end
		end

function saveSettings(args, key)

	if doesFileExist(bindfile) then
		os.remove(bindfile)
	end
	local f2 = io.open(bindfile, "w")
	if f2 then
		f2:write(encodeJson(mass_bind))
		f2:close()
	end

	ini.informer.hp = infHP.v
	ini.informer.armour = infArmour.v
	ini.informer.city = infCity.v
	ini.informer.kv = infKv.v
	ini.informer.time = infTime.v
	ini.informer.rajon = infRajon.v
	ini.informer.fps = inffps.v
	ini.informer.online = infonline.v
	ini.informer.ping = infping.v
	ini.informer.hpcar = infhpcar.v
	ini.settings.assistant = assistant.v
	ini.settings.keyT = keyT.v
	ini.settings.launcher = launcher.v
	ini.settings.deagle = deagle.v
	ini.settings.awp = awp.v
	ini.settings.m4 = m4.v
	ini.settings.uzi = uzi.v
	ini.settings.ak47 = ak47.v
	ini.settings.tazer = tazer.v
	ini.settings.ybral = ybral.v
	ini.settings.mp5 = mp5.v
	ini.settings.otgun = otgun.v
	ini.settings.shotgun = shotgun.v
	ini.settings.rifle = rifle.v
	ini.settings.knife = knife.v
	ini.settings.launcherpc = launcherpc.v
	ini.settings.launcherm = launcherm.v
	ini.settings.eat = eat.v
	ini.settings.eathouse = eathouse.v
	ini.settings.eatmyso = eatmyso.v
	ini.settings.mvdhelp = mvdhelp.v
	ini.settings.chatcalc = chatcalc.v
	ini.settings.yashik = yashik.v
	ini.settings.yashik1 = yashik1.v
	ini.settings.yashik2 = yashik2.v
	ini.settings.yashik3 = yashik3.v
	ini.settings.ndr = ndr.v
	ini.settings.toch = toch.v
	ini.settings.klava = klava.v
	ini.settings.autobike = autobike.v
	ini.settings.styletest = styletest.v
	ini.settings.styletest1 = styletest1.v
	ini.settings.styletest2 = styletest2.v
	ini.settings.styletest3 = styletest3.v
	ini.settings.styletest4 = styletest4.v
	ini.settings.styletest5 = styletest5.v
	ini.settings.timefix = timefix.v
	ini.settings.enableskin = enableskin.v
	ini.settings.skin = localskin.v
	ini.settings.timecout = timecout.v
	ini.settings.gangzones = gangzones.v
	ini.settings.zones = zones.v
	ini.settings.chatInfo = chatInfo.v
	ini.settings.raskladka = raskladka.v
	ini.settings.recongen = recongen.v
	ini.settings.carsis = carsis.v
	ini.settings.infoX = infoX
	ini.settings.infoY = infoY
	ini.settings.infoX2 = infoX2
	ini.settings.infoY2 = infoY2
	ini.settings.findX = findX
	ini.settings.findY = findY
	ini.settings.tag = u8:decode(rtag.v)
	
	ini.settings.autopass = u8:decode(autopass.v)
	ini.settings.autopasspay = u8:decode(autopasspay.v)
	ini.settings.autopasspaypin = u8:decode(autopasspaypin.v)
	ini.settings.autopasspin = u8:decode(autopasspin.v)
	ini.settings.zadervka = u8:decode(zadervka.v)
	ini.settings.zadervkav2 = u8:decode(zadervkav2.v)
	ini.settings.autopassopl = u8:decode(autopassopl.v)
	ini.settings.autopassopl1 = u8:decode(autopassopl1.v)
	ini.settings.autopassopl2 = u8:decode(autopassopl2.v)
	ini.settings.autopassopl3 = u8:decode(autopassopl3.v)
	ini.settings.autoklava = u8:decode(autoklava.v)
	ini.settings.shematext1 = u8:decode(shematext1.v)
	ini.settings.shematext2 = u8:decode(shematext2.v)
	ini.settings.shematext3 = u8:decode(shematext3.v)
	ini.settings.shematext4 = u8:decode(shematext4.v)
	ini.settings.shematext5 = u8:decode(shematext5.v)
	ini.settings.shematext6 = u8:decode(shematext6.v)
	ini.settings.shematext7 = u8:decode(shematext7.v)
	ini.settings.shematext8 = u8:decode(shematext8.v)
	ini.settings.shematext9 = u8:decode(shematext9.v)
	ini.settings.shematext10 = u8:decode(shematext10.v)
	ini.settings.shematext11 = u8:decode(shematext11.v)
	ini.settings.shematext12 = u8:decode(shematext12.v)
	ini.settings.shematext13 = u8:decode(shematext13.v)
	ini.settings.shematext14 = u8:decode(shematext14.v)
	ini.settings.shematext15 = u8:decode(shematext15.v)
	ini.settings.shematext16 = u8:decode(shematext16.v)
	ini.settings.shematext17 = u8:decode(shematext17.v)
	ini.settings.shematext18 = u8:decode(shematext18.v)
	ini.settings.shematext19 = u8:decode(shematext19.v)
	ini.settings.shematext20 = u8:decode(shematext20.v)
	ini.settings.shematext21 = u8:decode(shematext21.v)
	ini.settings.shematext22 = u8:decode(shematext22.v)
	ini.settings.shematext23 = u8:decode(shematext23.v)
	ini.settings.shematext24 = u8:decode(shematext24.v)
	ini.settings.shematext25 = u8:decode(shematext25.v)
	ini.settings.shematext26 = u8:decode(shematext26.v)
	ini.settings.shematext27 = u8:decode(shematext27.v)
	ini.settings.shematext28 = u8:decode(shematext28.v)
	ini.settings.shematext29 = u8:decode(shematext29.v)
	ini.settings.shematext30 = u8:decode(shematext30.v)
	ini.settings.shematext31 = u8:decode(shematext31.v)
	ini.settings.shematext32 = u8:decode(shematext32.v)
	ini.settings.shematext33 = u8:decode(shematext33.v)
	ini.settings.shematext34 = u8:decode(shematext34.v)
	ini.settings.shematext35 = u8:decode(shematext35.v)
	ini.settings.shematext36 = u8:decode(shematext36.v)
	ini.settings.deagleone = u8:decode(deagleone.v)
	ini.settings.deagletwo = u8:decode(deagletwo.v)
	ini.settings.awpone = u8:decode(awpone.v)
	ini.settings.awptwo = u8:decode(awptwo.v)
	ini.settings.m4one = u8:decode(m4one.v)
	ini.settings.m4two = u8:decode(m4two.v)
	ini.settings.uzione = u8:decode(uzione.v)
	ini.settings.uzitwo = u8:decode(uzitwo.v)
	ini.settings.ak47one = u8:decode(ak47one.v)
	ini.settings.ak47two = u8:decode(ak47two.v)
	ini.settings.tazerone = u8:decode(tazerone.v)
	ini.settings.tazertwo = u8:decode(tazertwo.v)
	ini.settings.ybralone = u8:decode(ybralone.v)
	ini.settings.mp5one = u8:decode(mp5one.v)
	ini.settings.mp5two = u8:decode(mp5two.v)
	ini.settings.shotgunone = u8:decode(shotgunone.v)
	ini.settings.shotguntwo = u8:decode(shotguntwo.v)
	ini.settings.rifleone = u8:decode(rifleone.v)
	ini.settings.rifletwo = u8:decode(rifletwo.v)
	ini.settings.knifeone = u8:decode(knifeone.v)
	ini.settings.knifetwo = u8:decode(knifetwo.v)
	ini.settings.autoklavareload = u8:decode(autoklavareload.v)
	ini.settings.activator = u8:decode(activator.v)
	ini.settings.autologin = autologin.v
	ini.settings.autopin = autopin.v
	ini.settings.autoopl = autoopl.v
	ini.settings.autoopl1 = autoopl1.v
	ini.settings.autoopl2 = autoopl2.v
	ini.settings.autoopl3 = autoopl3.v
	ini.settings.autoopl4 = autoopl4.v
	ini.settings.autoopl5 = autoopl5.v
	ini.settings.autoopl6 = autoopl6.v
	ini.settings.autopay = autopay.v
	ini.settings.lock = lock.v

	ini.assistant.asX = asX
	ini.assistant.asY = asY

	ini.settings.enable_tag = enable_tag.v
	ini.settings.spOtr = u8:decode(spOtr.v)
	inicfg.save(SET, "/Mono/settings.ini")
	end

function sampev.onPlayerChatBubble(id, color, distance, dur, text)
	if droneActive then -- тут мы меняем дальность действия текста над головой
		return {id, color, 25, dur, text}
	end
end

function comma_value(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

function separator(text)
	if text:find("$") then
	    for S in string.gmatch(text, "%$%d+") do
	    	local replace = comma_value(S)
	    	text = string.gsub(text, S, replace)
	    end
	    for S in string.gmatch(text, "%d+%$") do
	    	S = string.sub(S, 0, #S-1)
	    	local replace = comma_value(S)
	    	text = string.gsub(text, S, replace)
	    end
	end
	return text
end

function sampev.onSendDialogResponse(dialogId , button , listboxId , input)
	if ndr.v then
	dialogs_data[dialogId] = {listboxId, input}
	end
end

function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
	if carsis.v then
    INFO[1] = dialogId; INFO[3] = title; INFO[5] = button2;
    INFO[2] = style; INFO[4] = button1; INFO[6] = text
	buf.v = u8(text)
		if ini.DIALOG_EDITOR["DIALOG_" .. dialogId] ~= nil then 
			text = ini.DIALOG_EDITOR["DIALOG_" .. dialogId] 
			text = text:gsub('|_TB_|', '\n')
		return {dialogId, style, title, button1, button2, text}
	end
end
	if ndr.v then
		dialogIncoming = dialogId
	end
	if title:find("Авторизация") and text:find("Добро пожаловать") and autologin.v then -- автологин
		sampSendDialogResponse(dialogId, 1, 0, u8:decode(autopass.v))
		return false
	end
	if dialogId == 991 and autopin.v then 
		sampSendDialogResponse(dialogId, 1, 0, u8:decode(autopasspin.v))
		sampCloseCurrentDialogWithButton(0)
		return false
	end
	if dialogId == 119 and autoopl.v then
	sendchot5()
	end
	if dialogId == 119 and autoopl1.v then
	sendchot8()
	end
	if dialogId == 119 and autoopl2.v then
	sendchot9()
	end
	if dialogId == 119 and autoopl3.v then
	sendchot10()
	end
	if dialogId == 119 and autoopl4.v then
	sendchot11()
	end
	if dialogId == 119 and autoopl5.v then
	sendchot12()
	end
	if dialogId == 119 and autoopl6.v then
	sendchot13()
	end
	if dialogId == 0 and recongen.v then
	recongenmenu()
	end
    if dialogId == 722 and nodial then
    nodial = false
    return false
  end
  if checked_test.v or checked_test2.v or checked_test3.v or checked_test4.v then
      if dialogId == 9238 then
        checked_test.v = false
        checked_test2.v = false
        checked_test3.v = false
        checked_test4.v = false
        krytim = true
        sampAddChatMessage('{FFB140}Рулетки закончились.', 0xFFB140)
      end
  end
  if text:find('Поздравляем с получением') and checked_test.v then
    return false
  end
	if toch.v then
  		text = separator(text)
		title = separator(title)
		return {dialogId, style, title, button1, button2, text}
	end
end

function sampev.onShowTextDraw(id, data, textdrawId)
  if checked_test5.v and active then
    lua_thread.create(function()
      if data.modelId == 19918 then
        wait(111)
        sampSendClickTextdraw(id)
		wait(222)
		sampSendClickTextdraw(2302)
        wait(333)
        sampSendClickTextdraw(2110)
		wait(444)
		sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        active = false
      end
    end)
  end
  if checked_test6.v and active1 then
    lua_thread.create(function()
      if data.modelId == 19613 then
        wait(111)
        sampSendClickTextdraw(id)
        wait(222)
		sampSendClickTextdraw(2302)
        wait(333)
        sampSendClickTextdraw(2110)
		wait(444)
		sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        active1 = false
      end
    end)
  end
  if checked_test7.v and active2 then
    lua_thread.create(function()
      if data.modelId == 1353 then
        wait(111)
        sampSendClickTextdraw(id)
        wait(222)
		sampSendClickTextdraw(2302)
        wait(333)
        sampSendClickTextdraw(2110)
		wait(444)
		sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        active2 = false
      end
    end)
  end
    if checked_test8.v and active3 then
    lua_thread.create(function()
      if data.modelId == 1240 then
        wait(111)
        sampSendClickTextdraw(id)
        use3 = true
      end
      if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use3 then 
        clickID = id + 1
        sampSendClickTextdraw(clickID)
		wait(1000)
		sampSendClickTextdraw(2048)
		use3 = false
		close3 = true
	  end
      if close3 then
        wait(111)
        setVirtualKeyDown(VK_ESCAPE, true)
		wait(111)
		setVirtualKeyDown(VK_ESCAPE, false)
		close3 = false
        active3 = false
	   end
    end)
  end
  if checked_test9.v and active4 then
    lua_thread.create(function()
      if data.modelId == 1240 then
        wait(111)
        sampSendClickTextdraw(id)
        wait(222)
		sampSendClickTextdraw(2302)
        wait(333)
        sampSendClickTextdraw(2110)
		wait(444)
		sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        active4 = false
		end
	 end)
	end
	if checked_test10.v and active5 then
    lua_thread.create(function()
      if data.modelId == 1733 then
        wait(111)
        sampSendClickTextdraw(id)
        wait(222)
		sampSendClickTextdraw(2302)
        wait(333)
        sampSendClickTextdraw(2110)
		wait(444)
		sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        active5 = false
      end
    end)
  end
	if yashik.v and active then
    lua_thread.create(function()
      if data.modelId == 19918 then
        wait(111)
        sampSendClickTextdraw(id)
       wait(222)
		sampSendClickTextdraw(2302)
        wait(333)
        sampSendClickTextdraw(2110)
		wait(444)
		sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        active = false
      end
    end)
  end
  if yashik1.v and active1 then
    lua_thread.create(function()
      if data.modelId == 19613 then
        wait(111)
		sampSendClickTextdraw(id)
        wait(222)
		sampSendClickTextdraw(2302)
        wait(333)
        sampSendClickTextdraw(2110)
		wait(444)
		sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        active1 = false
      end
    end)
  end
  if yashik2.v and active2 then
    lua_thread.create(function()
      if data.modelId == 1353 then
        wait(111)
        sampSendClickTextdraw(id)
        wait(222)
		sampSendClickTextdraw(2302)
        wait(333)
        sampSendClickTextdraw(2110)
		wait(444)
		sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        active2 = false
      end
    end)
  end
	if yashik3.v and active5 then
    lua_thread.create(function()
      if data.modelId == 1733 then
        wait(111)
        sampSendClickTextdraw(id)
        wait(222)
		sampSendClickTextdraw(2302)
        wait(333)
        sampSendClickTextdraw(2110)
		wait(444)
		sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        active5 = false
      end
    end)
  end
	if video.v and active6 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use6 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use6 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use6 = false
        close6 = true
		end
		if close6 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close6 = false
        active6 = false
      end
    end)
  end
	if video1.v and active7 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use7 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use7 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use7 = false
        close7 = true
		end
		if close7 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close7 = false
        active7 = false
      end
    end)
  end
  if video2.v and active8 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use8 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use8 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use8 = false
        close8 = true
		end
		if close8 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close8 = false
        active8 = false
      end
    end)
  end
  if video3.v and active9 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use9 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use9 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use9 = false
        close9 = true
		end
		if close9 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close9 = false
        active9 = false
      end
    end)
  end
  if video4.v and active10 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use10 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use10 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use10 = false
        close10 = true
		end
		if close10 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close10 = false
        active10 = false
      end
    end)
  end
  if video5.v and active11 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use11 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use11 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use11 = false
        close11 = true
		end
		if close11 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close11 = false
        active11 = false
      end
    end)
  end
  if video6.v and active12 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use12 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use12 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use12 = false
        close12 = true
		end
		if close12 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close12 = false
        active12 = false
      end
    end)
  end
  if video7.v and active13 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use13 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use13 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use13 = false
        close13 = true
		end
		if close13 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close13 = false
        active13 = false
      end
    end)
  end
  if video8.v and active14 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use14 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use14 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use14 = false
        close14 = true
		end
		if close14 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close14 = false
        active14 = false
      end
    end)
  end
  if video9.v and active15 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use15 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use15 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use15 = false
        close15 = true
		end
		if close15 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close15 = false
        active15 = false
      end
    end)
  end
  if video10.v and active16 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use16 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use16 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use16 = false
        close16 = true
		end
		if close16 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close16 = false
        active16 = false
      end
    end)
  end
  if video11.v and active17 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use17 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use17 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use17 = false
        close17 = true
		end
		if close17 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close17 = false
        active17 = false
      end
    end)
  end
  if video12.v and active18 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use18 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use18 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use18 = false
        close18 = true
		end
		if close18 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close18 = false
        active18 = false
      end
    end)
  end
  if video13.v and active19 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use19 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use19 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use19 = false
        close19 = true
		end
		if close19 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close19 = false
        active19 = false
      end
    end)
  end
  if video14.v and active20 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use20 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use20 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use20 = false
        close20 = true
		end
		if close20 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close20 = false
        active20 = false
      end
    end)
  end
  if video15.v and active21 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use21 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use21 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use21 = false
        close21 = true
		end
		if close21 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close21 = false
        active21 = false
      end
    end)
  end
  if video16.v and active22 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use22 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use22 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use22 = false
        close22 = true
		end
		if close22 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close22 = false
        active22 = false
      end
    end)
  end
  if video17.v and active23 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use23 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use23 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use23 = false
        close23 = true
		end
		if close23 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close23 = false
        active23 = false
      end
    end)
  end
  if video18.v and active24 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use24 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use24 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use24 = false
        close24 = true
		end
		if close24 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close24 = false
        active24 = false
      end
    end)
  end
  if video19.v and active25 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use25 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use25 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use25 = false
        close25 = true
		end
		if close25 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close25 = false
        active25 = false
      end
    end)
  end
  if video20.v and active26 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use26 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use26 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use26 = false
        close26 = true
		end
		if close26 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close26 = false
        active26 = false
      end
    end)
  end
  if video21.v and active27 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use27 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use27 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use27 = false
        close27 = true
		end
		if close27 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close27 = false
        active27 = false
      end
    end)
  end
  if video22.v and active28 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use28 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use28 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use28 = false
        close28 = true
		end
		if close28 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close28 = false
        active28 = false
      end
    end)
  end
  if video23.v and active29 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use29 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use29 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use29 = false
        close29 = true
		end
		if close29 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close29 = false
        active29 = false
      end
    end)
  end
  if video24.v and active30 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use30 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use30 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use30 = false
        close30 = true
		end
		if close30 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close30 = false
        active30 = false
      end
    end)
  end
  if video25.v and active31 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use31 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use31 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use31 = false
        close31 = true
		end
		if close31 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close31 = false
        active31 = false
      end
    end)
  end
  if video26.v and active32 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use32 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use32 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use32 = false
        close32 = true
		end
		if close32 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close32 = false
        active32 = false
      end
    end)
  end
  if video27.v and active33 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use33 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use33 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use33 = false
        close33 = true
		end
		if close33 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close33 = false
        active33 = false
      end
    end)
  end
  if video28.v and active34 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use34 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use34 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use34 = false
        close34 = true
		end
		if close34 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close34 = false
        active34 = false
      end
    end)
  end
  if video29.v and active35 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use35 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use35 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use35 = false
        close35 = true
		end
		if close35 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close35 = false
        active35 = false
      end
    end)
  end
  if video30.v and active36 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use36 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use36 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use36 = false
        close36 = true
		end
		if close36 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close36 = false
        active36 = false
      end
    end)
  end
  if video31.v and active37 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use37 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use37 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use37 = false
        close37 = true
		end
		if close37 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close37 = false
        active37 = false
      end
    end)
  end
  if video32.v and active38 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use38 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use38 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use38 = false
        close38 = true
		end
		if close38 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close38 = false
        active38 = false
      end
    end)
  end
  if video33.v and active39 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use39 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use39 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use39 = false
        close39 = true
		end
		if close39 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close39 = false
        active39 = false
      end
    end)
  end
  if video34.v and active40 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use40 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use40 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use40 = false
        close40 = true
		end
		if close40 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close40 = false
        active40 = false
      end
    end)
  end
  if video35.v and active41 then
		lua_thread.create(function()
		if data.modelId == 962 then
		 use41 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use41 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use41 = false
        close41 = true
		end
		if close41 then
        wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close41 = false
        active41 = false
      end
    end)
  end
	if eatmyso.v and active42 then 
	 lua_thread.create(function()
		if data.modelId == 2805 then 
		sampSendClickTextdraw(2132)
		use42 = true
		end
		if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use42 then 
		clickID = id + 1
		sampSendClickTextdraw(clickID)
		use42 = false
        close42 = true
		end
		if close42 then
		wait(111)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close42 = false
        active42 = false
		end
	end)
end
	lua_thread.create(function()
	if data.modelId == 1615 and checktochilki then
		if id ~= 2108 and checktochilki then
			sampSendClickTextdraw(id)
			checktochilki = false
		end
	elseif data.modelId == 16112 and checktochilki1 then
		if id ~= 2108 and checktochilki1 then
			sampSendClickTextdraw(id)
			checktochilki1 = false
		end
	elseif data.modelId == 16112 and checktochilki2 then
		if id ~= 2108 and checktochilki2 then
			sampSendClickTextdraw(id)
			checktochilki2 = false
		end
	elseif data.modelId == 1615 and checktochilki2 then
		if id ~= 2108 and checktochilki2 then
			sampSendClickTextdraw(id)
			checktochilki2 = false
			end
		end
	end)
end

function rul(respond)
  nodial = true
  sampSendChat('/mn')
  sampSendDialogResponse(722, 1, 7, _)
end

function sendchot6()
	lua_thread.create(function() -- начало потока
	closeDialog()
	wait(100)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopasspaypin.v), -1)
	wait(200)
	sampSendDialogResponse(4498, 1, 0, u8:decode(autopasspay.v))
	wait(100)
	closeDialog()
	wait(100)
	closeDialog()
	end)
end

function sendchot9()
	lua_thread.create(function() -- начало потока
	closeDialog()
	wait(100)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 4, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 4, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(100)
	closeDialog()
	thisScript():reload()
end)
end
	
function sendchot5()
	lua_thread.create(function() -- начало потока
	closeDialog()
	wait(100)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl.v), -1)
	wait(200)
	sampSendDialogResponse(881, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(882, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl.v), -1)
	wait(200)
	sampSendDialogResponse(881, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(882, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 4, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 4, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(100)
	closeDialog()
	thisScript():reload()
end)
end

function sendchot13()
	lua_thread.create(function() -- начало потока
	closeDialog()
	wait(100)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(100)
	closeDialog()
	thisScript():reload()
end)
end

function sendchot12()
	lua_thread.create(function() -- начало потока
	closeDialog()
	wait(100)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 4, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 4, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(100)
	closeDialog()
	thisScript():reload()
end)
end

function sendchot10()
	lua_thread.create(function() -- начало потока
	closeDialog()
	wait(100)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl.v), -1)
	wait(200)
	sampSendDialogResponse(881, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(882, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl.v), -1)
	wait(200)
	sampSendDialogResponse(881, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(882, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(200)
	closeDialog()
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl3.v), -1)
	wait(200)
	sampSendDialogResponse(9762, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(784, 1 , 0, -1)
	wait(100)
	closeDialog()
	thisScript():reload()
end)
end

function sendchot11()
	lua_thread.create(function() -- начало потока
	closeDialog()
	wait(100)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl.v), -1)
	wait(200)
	sampSendDialogResponse(881, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(882, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl.v), -1)
	wait(100)
	closeDialog()
	thisScript():reload()
end)
end

function sendchot8()
	lua_thread.create(function() -- начало потока
	closeDialog()
	wait(100)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl.v), -1)
	wait(200)
	sampSendDialogResponse(881, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(882, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl.v), -1)
	wait(200)
	sampSendDialogResponse(881, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(882, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl1.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 4, -1)
	wait(200)
	sampSendDialogResponse(1783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(200)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_N, true)
    wait(200)
    setVirtualKeyDown(key.VK_N, false)
	wait(200)
	sampSendDialogResponse(33, 1 , u8:decode(autopassopl2.v), -1)
	wait(200)
	sampSendDialogResponse(7238, 1 , 4, -1)
	wait(200)
	sampSendDialogResponse(783, 1 , 0, -1)
	wait(100)
	closeDialog()
	thisScript():reload()
end)
end

function afind(arg)
	if arg == '' then
		notf.addNotification("[Mono Tools]: введите ID", 3, 3) -- когда не введено ID
	else
		if tonumber(arg) and sampIsPlayerConnected(arg) then
			id_find = arg
			afind = 1
			notf.addNotification("[Mono Tools]: Автопоиск включен для ID: [" ..id_find.. "]", 3, 2) -- при активации скрипта уведомление
		else
			notf.addNotification("[Mono Tools]: Указан неверный ID", 3, 3) -- при введении неверного ID уведомление
		end
	end
end

function sfind()
	id_find = 5000
	afind = 0
	notf.addNotification("[Mono Tools]: Автопоиск отключён.", 3, 3) -- при остановке скрипта уведомление
end

function recongenius(param)
	time = tonumber(param)
	lua_thread.create(function()
	if time ~= nil then
	sampDisconnectWithReason(quit)
	wait(time*1000)
	sampSetGamestate(1)
	else 
	if time == nil then
	sampDisconnectWithReason(quit)
	wait(30000)
	sampSetGamestate(1)
end
end
end)
end

function recongeniusis()
	lua_thread.create(function()
	sampDisconnectWithReason(quit)
	wait(600000)
	sampSetGamestate(1)
end)
end

function recongenmenu()
	lua_thread.create(function()
	sampDisconnectWithReason(quit)
	sampSetGamestate(1)
end)
end

function sampev.onSendClientJoin(Ver, mod, nick, response, authKey, clientver, unk)
	if launcherpc.v then clientver = 'Arizona PC' end
	if launcherm.v then clientver = 'arizona-mobile' end
	return {Ver, mod, nick, response, authKey, clientver, unk}
end

function imgui.ToggleButton(str_id, bool)

	local rBool = false
 
	if LastActiveTime == nil then
	   LastActiveTime = {}
	end
	if LastActive == nil then
	   LastActive = {}
	end
 
	local function ImSaturate(f)
	   return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f)
	end
  
	local p = imgui.GetCursorScreenPos()
	local draw_list = imgui.GetWindowDrawList()
 
	local height = imgui.GetTextLineHeightWithSpacing() + (imgui.GetStyle().FramePadding.y / 2)
	local width = height * 1.55
	local radius = height * 0.50
	local ANIM_SPEED = 0.15
 
	if imgui.InvisibleButton(str_id, imgui.ImVec2(width, height)) then
	   bool.v = not bool.v
	   rBool = true
	   LastActiveTime[tostring(str_id)] = os.clock()
	   LastActive[str_id] = true
	end
 
	local t = bool.v and 1.0 or 0.0
 
	if LastActive[str_id] then
	   local time = os.clock() - LastActiveTime[tostring(str_id)]
	   if time <= ANIM_SPEED then
		  local t_anim = ImSaturate(time / ANIM_SPEED)
		  t = bool.v and t_anim or 1.0 - t_anim
	   else
		  LastActive[str_id] = false
	   end
	end
 
	local col_bg
	if imgui.IsItemHovered() then
	   col_bg = imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.FrameBgHovered])
	else
	   col_bg = imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.FrameBg])
	end
 
	draw_list:AddRectFilled(p, imgui.ImVec2(p.x + width, p.y + height), col_bg, height * 0.5)
	draw_list:AddCircleFilled(imgui.ImVec2(p.x + radius + t * (width - radius * 2.0), p.y + radius), radius - 1.5, imgui.GetColorU32(bool.v and imgui.GetStyle().Colors[imgui.Col.ButtonActive] or imgui.GetStyle().Colors[imgui.Col.Button]))
 
	return rBool
end

function imgui.BeforeDrawFrame()
    if fontsize == nil then
        fontsize = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 25.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic()) -- вместо 30 любой нужный размер
    end
end

function imgui.OnDrawFrame()
	local tLastKeys = {} -- это у нас для клавиш
	local sw, sh = getScreenResolution() -- получаем разрешение экрана
	local btn_size = imgui.ImVec2(-0.1, 0) -- а это "шаблоны" размеров кнопок
	local btn_size2 = imgui.ImVec2(160, 0)
	local btn_size3 = imgui.ImVec2(140, 0)
	local btn_size5 = imgui.ImVec2(70, 50)
	local input = sampGetInputInfoPtr()
    local input = getStructElement(input, 0x8, 4)
    local windowPosX = getStructElement(input, 0x8, 4)
    local windowPosY = getStructElement(input, 0xC, 4)

	-- тут мы подстраиваем курсор под адекватность
	imgui.ShowCursor = not win_state['informer'].v and not win_state['ass'].v and not win_state['find'].v or win_state['main'].v or win_state['base'].v or win_state['update'].v or win_state['player'].v or win_state['regst'].v or win_state['renew'].v or win_state['leave'].v
	
	if not win_state['main'].v  then 
          imgui.Process = false
       end
	  
	if not win_state['main'].v and win_state['informer'].v then 
          imgui.Process = true
       end
	
	if win_state['main'].v then -- основное окошко
		
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(260, 205), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' Mono Tools ', win_state['main'], imgui.WindowFlags.NoResize)
		if imgui.Button(u8' Биндер и Настройки', btn_size) then win_state['settings'].v = not win_state['settings'].v end
		if imgui.Button(u8' Roulette Tools', btn_size) then win_state['yashiki'].v = not win_state['yashiki'].v end
		if imgui.Button(u8' Bank Menu', btn_size) then win_state['bank'].v = not win_state['bank'].v end
		if imgui.Button(u8' Помощь', btn_size) then win_state['help'].v = not win_state['help'].v end
		if imgui.Button(u8' Мини игры', btn_size) then win_state['gamer'].v = not win_state['gamer'].v end
		imgui.End()
	end
    
    if sampIsChatInputActive() and chatcalc.v and ok then
        imgui.SetNextWindowPos(imgui.ImVec2(windowPosX, windowPosY + 30 + 15), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(result:len()*10, 30))
        imgui.Begin('Solve', window, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
        imgui.CenterText(u8(number_separator(result)))
        imgui.End()
    end
        if sampIsChatInputActive() and chatcalc.v and help then
            imgui.SetNextWindowPos(imgui.ImVec2(windowPosX, windowPosY + 30 + 15), imgui.Cond.FirstUseEver)
            imgui.SetNextWindowSize(imgui.ImVec2(800, 130))
            imgui.Begin('Help', window2, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
            imgui.Text(u8[[23%/100 - найти число исхода из процента. 23 - это процент, 100 это сколько составлает этот процент от неизвестного числа.
23 процента равные числу 100, в 100 процентах будет 434.
-
23%*100 - найти число, которое составл¤ет количество процентов. 23 - это количество процентов, 
100 - число от которого нужно найти процент. 23 процента от числа 100 - это 23.
-
23/100% - найти процентное соотношение двух чисел. 23 - это число, процентное соотношение от числа 100.
число 23 составл¤ет 23 процента от числа 100.]])
            imgui.End()
        end
	
	if win_state['settings'].v then -- окно с настройками
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(850, 530), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' Биндер и Настройки', win_state['settings'], imgui.WindowFlags.NoResize + imgui.WindowFlags.MenuBar)
		if imgui.BeginMenuBar() then
			if imgui.BeginMenu(u8(" Навигация по настройкам")) then
				if imgui.MenuItem(u8(" Биндер")) then
					showSet = 2
				elseif imgui.MenuItem(u8(" Настройки")) then
					showSet = 1
				elseif imgui.MenuItem(u8(" Стили")) then
					showSet = 5
				end
				imgui.EndMenu()
			end
			imgui.EndMenuBar()
		end
		if showSet == 5 then
		imgui.Columns(2, _, false)
		imgui.AlignTextToFramePadding(); imgui.Text(u8(" Red")); imgui.SameLine(); imgui.ToggleButton(u8'Red', styletest)
		imgui.AlignTextToFramePadding(); imgui.Text(u8(" Green")); imgui.SameLine(); imgui.ToggleButton(u8'Green', styletest1)
		imgui.AlignTextToFramePadding(); imgui.Text(u8(" Blue")); imgui.SameLine(); imgui.ToggleButton(u8'Blue', styletest2)
		imgui.NextColumn()
		imgui.AlignTextToFramePadding(); imgui.Text(u8(" Black")); imgui.SameLine(); imgui.ToggleButton(u8'Black', styletest3)
		imgui.AlignTextToFramePadding(); imgui.Text(u8(" Purple")); imgui.SameLine(); imgui.ToggleButton(u8'Purple', styletest4)
		imgui.AlignTextToFramePadding(); imgui.Text(u8(" Gray")); imgui.SameLine(); imgui.ToggleButton(u8'Gray', styletest5)
		if styletest.v then -- стили
			apply_custom_style1()
			end
		if styletest1.v then -- стили
			apply_custom_style()
			end
		if styletest2.v then -- стили
			apply_custom_style2()
			end
		if styletest3.v then -- стили
			new_style()
			end
		if styletest4.v then -- стили
			apply_custom_style4()
			end
		if styletest5.v then -- стили
			apply_custom_style5()
			end
		end
		if showSet == 1 then
			if imgui.CollapsingHeader(u8' Майнинг') then
				imgui.BeginChild('##asdasasddf', imgui.ImVec2(800, 380), false)
				if imgui.Button(u8' Инструкция', btn_size) then win_state['shemainst'].v = not win_state['shemainst'].v end
				if imgui.Button(u8' Схема', btn_size) then win_state['shema'].v = not win_state['shema'].v end
				if imgui.Button(u8' Редактировать ID Текстдравов', btn_size) then win_state['shematext'].v = not win_state['shematext'].v end
				imgui.Checkbox(u8'Улучшать видеокарту №1  ', video); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №2  ', video1); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №3  ', video2); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №4', video3)
				imgui.Checkbox(u8'Улучшать видеокарту №5  ', video4); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №6  ', video5); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №7  ', video6); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №8', video7)
				imgui.Checkbox(u8'Улучшать видеокарту №9  ', video8); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №10', video9); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №11', video10); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №12', video11)
				imgui.Checkbox(u8'Улучшать видеокарту №13', video12); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №14', video13); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №15', video14); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №16', video15)
				imgui.Checkbox(u8'Улучшать видеокарту №17', video16); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №18', video17); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №19', video18); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №20', video19)
				imgui.Checkbox(u8'Улучшать видеокарту №21', video20); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №22', video21); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №23', video22); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №24', video23)
				imgui.Checkbox(u8'Улучшать видеокарту №25', video24); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №26', video25); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №27', video26); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №28', video27)
				imgui.Checkbox(u8'Улучшать видеокарту №29', video28); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №30', video29); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №31', video30); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №32', video31)
				imgui.Checkbox(u8'Улучшать видеокарту №33', video32); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №34', video33); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №35', video34); imgui.SameLine(); imgui.Checkbox(u8'Улучшать видеокарту №36', video35)
				imgui.EndChild()
			end
			if imgui.CollapsingHeader(u8' Модификации') then
				imgui.BeginChild('##as2dasasdf468', imgui.ImVec2(750, 315), false)
				imgui.Columns(2, _, false)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" ChatInfo")); imgui.SameLine(); imgui.ToggleButton(u8'ChatInfo', chatInfo)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Эмулятор лаунчера")); imgui.SameLine(); imgui.ToggleButton(u8'Эмулятор лаунчера', launcher); imgui.SameLine(); imgui.TextQuestion(u8"Если включено, то вы сможете открывать сундуки с рулетками, получать увеличенный депозит и 10.000$ в час. После включения данной функций нужно перезайти в игру. PC - не отображает luxe машины. Mobile - отображает luxe машины.")
				if launcher.v then
				if launcherpc.v then launcherm.v = false end
				if launcherm.v then launcherpc.v = false end
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" PC")); imgui.SameLine(); imgui.ToggleButton(u8'PC', launcherpc); imgui.SameLine(); 
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Mobile")); imgui.SameLine(); imgui.ToggleButton(u8'Mobile', launcherm)
				end
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Авто Байк и Мото")); imgui.SameLine(); imgui.ToggleButton(u8'Авто Байк и Мото', autobike); imgui.SameLine(); imgui.TextQuestion(u8"Если включено, то вам больше не надо будет нажимать W на велосипеде и не нужно будет нажимать стрелочку на мотоцикле. Просто зажимаете Левый Shift и едите.")
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Запоминание диалогов")); imgui.SameLine(); imgui.ToggleButton(u8'Запоминание диалогов', ndr)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Автоеда")); imgui.SameLine(); imgui.ToggleButton(u8'Автоеда', eat) 
				if eat.v then
				if eathouse.v then eatmyso.v = false end
				if eatmyso.v then eathouse.v = false end
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Дом")); imgui.SameLine(); imgui.ToggleButton(u8'Дом', eathouse); ; imgui.SameLine(); imgui.TextQuestion(u8"Персонаж будет раз в 3 часа есть еду с холодильника, стоимостью 300 продуктов. Полезно тем, у кого нет аксессуара на хилл или слетел инвентарь и вы ждете отката."); imgui.SameLine();
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Мешок с мясом")); imgui.SameLine(); imgui.ToggleButton(u8'Мешок с мясом', eatmyso); ; imgui.SameLine(); imgui.TextQuestion(u8"Персонаж будет раз в 30 минут есть еду из мешка с мясом.")
				end
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Input Chat")); imgui.SameLine(); imgui.ToggleButton(u8'Input Chat', raskladka); imgui.SameLine(); imgui.TextQuestion(u8"Скрипт вводит команды на английском языке на русской раскладке. После включения или отключения данной функций необходимо перезапустить скрипт.")
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Умный реконнект")); imgui.SameLine(); imgui.ToggleButton(u8'Умный реконнект', recongen); imgui.SameLine(); imgui.TextQuestion(u8"Если включено, то скрипт будет перезаходить в игру, если вас кикнул античит, сработала защита от реконнекта и после рестарта.")
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Измененный cars")); imgui.SameLine(); imgui.ToggleButton(u8'Измененный cars', carsis); imgui.SameLine(); imgui.TextQuestion(u8"Редактирование диалога /cars. Можно использовать, например, чтобы подписать местоположение машин, изменить цвет строк в диалоге и тому подобное.");
				if carsis.v and imgui.Button(u8' Редактировать cars', btn_size) then carsys() end
				imgui.NextColumn()
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Чат на клавишу Т")); imgui.SameLine(); imgui.ToggleButton(u8'Чат на клавишу T', keyT)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Авто закрытие дверей(/lock)")); imgui.SameLine(); imgui.ToggleButton(u8'Авто закрытие дверей(/lock)', lock)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Точки в числах")); imgui.SameLine(); imgui.ToggleButton(u8'Точки в числах', toch)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Фикс MVD Helper")); imgui.SameLine(); imgui.ToggleButton(u8'Фикс MVD Helper', mvdhelp); imgui.SameLine(); imgui.TextQuestion(u8"Если включено, то после спавна пропишется /mm и закроется. Нужно для того, чтобы разбагать инвентарь(MVD Helper его как то багает)")
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Chat Calculator")); imgui.SameLine(); imgui.ToggleButton(u8'Chat Calculator', chatcalc); imgui.SameLine(); imgui.TextQuestion(u8"Если включено, то вы сможете использовать калькулятор в чате. Например: пишите в чате 2+2 и под чатом вам напишется ответ. Можно высчитывать и примеры по типу: (3*3)*(2+2) и тому подобное. Также если напишите в чате 'calchelp', то вам покажет как высчитывать проценты.")
				imgui.Text(u8(" Открытие меню на клавишу")); imgui.SameLine(); imgui.TextQuestion(u8"В поле нужно ввести код клавиши для открытия скрипта. По умолчанию поставлено на F3. Коды клавиш вы можете посмотреть в помощь - коды клавиш.") 
					imgui.InputText(u8'', autoklava)
					imgui.Text(u8(" Перезагрузка скрипта на клавишу")); imgui.SameLine(); imgui.TextQuestion(u8"В поле нужно ввести код клавиши для перезагрузки скрипта. По умолчанию поставлено на F4. Коды клавиш вы можете посмотреть в помощь - коды клавиш.")
					imgui.InputText(u8' ', autoklavareload)
					imgui.Text(u8(" Команда для открытия меню скрипта")); imgui.SameLine(); imgui.TextQuestion(u8"В поле нужно ввести команду (без /) открытия меню(вводить команду на английском). По умолчанию - /mono. После того, как вписали команду, необходимо перезапустить скрипт!")
					imgui.InputText(u8'  ', activator)
				imgui.EndChild()
			end
			if imgui.CollapsingHeader(u8' RP Guns') then
				rpguns()
			end
			if imgui.CollapsingHeader(u8' Информер') then
				imgui.BeginChild('##25252', imgui.ImVec2(750, 190), false)
				imgui.Columns(2, _, false)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Включить информер")); imgui.SameLine(); imgui.ToggleButton(u8'Включить информер', zones)
				if zones.v then
					imgui.SameLine()
					if imgui.Button(u8'Переместить') then 
						sampAddChatMessage("[Mono Tools]{FFFFFF} Выберите позицию и нажмите {00C2BB}Enter{FFFFFF} чтобы сохранить ее.", 0x046D63)
						win_state['settings'].v = not win_state['settings'].v 
						win_state['main'].v = not win_state['main'].v 
						mouseCoord = true 
					end
				end
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Отображение здоровья")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение здоровья', infHP)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Отображение брони")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение брони', infArmour)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Отображение квадрата")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение квадрата', infKv)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Отображение пинга")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение пинга', infping)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Отображение онлайна за сессию")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение онлайна за сессию', infonline); imgui.SameLine(); imgui.TextQuestion(u8"Сбрасывается при перезагрузке скрипта или после перезахода в игру.") 
				imgui.NextColumn()
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Отображение города")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение города', infCity)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Отображение района")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение района', infRajon)
				imgui.SameLine()
				imgui.TextQuestion(u8"Если отображаются иероглифы - сделайте игру на английский язык в настройках.")
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Отображение ХП т/с")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение ХП т/с', infhpcar)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Отображение ФПС")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение ФПС', inffps)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Отображение времени")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение времени', infTime)
				imgui.EndChild()
			end
			if imgui.CollapsingHeader(u8' Авторизация') then
				imgui.BeginChild('##asdasasddf764', imgui.ImVec2(750, 60), false)
				imgui.Columns(2, _, false)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Автологин")); imgui.SameLine(); imgui.ToggleButton(u8("Автологин"), autologin)
				if autologin.v then
					imgui.InputText(u8'Пароль', autopass)
				end
				imgui.NextColumn()
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Автопин")); imgui.SameLine(); imgui.ToggleButton(u8("Автопин"), autopin)
				if autopin.v then
					imgui.InputText(u8'Pin-код', autopasspin)
				end
				imgui.EndChild()
			end
			if imgui.CollapsingHeader(u8' Toch Menu') then
				imgui.BeginChild('##asdasasddf1245', imgui.ImVec2(800, 100), false)
				imgui.Columns(2, _, false)
				imgui.Checkbox(u8'Камни', checked_box2)
				imgui.SameLine()
				imgui.TextQuestion(u8"Авто-заточка аксессуара/скина камнями.")
				imgui.SameLine()
				imgui.Checkbox(u8'Амулеты', checked_box)
				imgui.SameLine()
				imgui.TextQuestion(u8"Авто-заточка аксессуара/скина амулетами.")
				imgui.SameLine()
				imgui.Checkbox(u8'Камни и Амулеты', checked_box3)
				imgui.SameLine()
				imgui.TextQuestion(u8"Авто-заточка аксессуара/скина камнями и амулетами.")
				imgui.Text(u8'Выберите на сколько будет точиться аксессуар/скин:')
				imgui.Separator()
				imgui.RadioButton('+1', checked_radio, 1)
				imgui.SameLine()
				imgui.RadioButton('+2', checked_radio, 2)
				imgui.SameLine()
				imgui.RadioButton('+3', checked_radio, 3)
				imgui.SameLine()
				imgui.RadioButton('+4', checked_radio, 4)
				imgui.SameLine()
				imgui.RadioButton('+5', checked_radio, 5)
				imgui.SameLine()
				imgui.RadioButton('+6', checked_radio, 6)
				imgui.SameLine()
				imgui.RadioButton('+7', checked_radio, 7)
				imgui.NextColumn()
				imgui.RadioButton('+8', checked_radio, 8)
				imgui.SameLine()
				imgui.RadioButton('+9', checked_radio, 9)
				imgui.SameLine()
				imgui.RadioButton('+10', checked_radio, 10)
				imgui.SameLine()
				imgui.RadioButton('+11', checked_radio, 11)
				imgui.SameLine()
				imgui.RadioButton('+12', checked_radio, 12)
				imgui.Separator()
				imgui.EndChild()
			end
			if imgui.CollapsingHeader(u8' Таймцикл') then
				if weather.v == -1 then weather.v = readMemory(0xC81320, 1, true) end
				if gametime.v == -1 then gametime.v = readMemory(0xB70153, 1, true) end
				imgui.SliderInt(u8"ID погоды", weather, 0, 50)
				imgui.SliderInt(u8"Игровой час", gametime, 0, 23)
			end
			if imgui.CollapsingHeader(u8' Прочие настройки') then
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Визуальный скин")); imgui.SameLine(); imgui.ToggleButton(u8("Визуальный скин"), enableskin)
				if enableskin.v then
					imgui.InputInt("##229", localskin, 0, 0)
					imgui.SameLine()
					if imgui.Button(u8("Применить")) then
						if localskin.v <= 0 or localskin.v == 74 or localskin.v == 53 then
							localskin.v = 1
						end
						changeSkin(-1, localskin.v)
					end
				end
				imgui.SliderInt(u8" Коррекция времени", timefix, 0, 5)
			end
		elseif showSet == 3 then -- настройки клавиш
			imgui.Columns(2, _, false)
			for k, v in ipairs(tBindList) do
					if k ~= 2 and k ~= 8 and k ~= 9 and k ~= 10 then
						if hk.HotKey("##HK" .. k, v, tLastKeys, 100) then
							if not rkeys.isHotKeyDefined(v.v) then
								if rkeys.isHotKeyDefined(tLastKeys.v) then
									rkeys.unRegisterHotKey(tLastKeys.v)
								end
							end
							rkeys.registerHotKey(v.v, true, onHotKey)
							saveSettings(3, "KEY")
						end
						imgui.SameLine()
						imgui.Text(u8(v.text))
					end
				--end
				if k >= 6 and imgui.GetColumnIndex() ~= 1 then imgui.NextColumn() end
			end
		elseif showSet == 2 then -- меню биндера
			imgui.Columns(4, _, false)
			imgui.NextColumn()
			imgui.NextColumn()
			imgui.NextColumn()
			for k, v in ipairs(mass_bind) do -- выводим все бинды
				imgui.NextColumn()
				if hk.HotKey("##ID" .. k, v, tLastKeys, 100) then -- выводим окошко, куда будем тыкать, чтобы назначить клавишу
					if not rkeys.isHotKeyDefined(v.v) then
						if rkeys.isHotKeyDefined(tLastKeys.v) then
							rkeys.unRegisterHotKey(tLastKeys.v)
						end
					end
					rkeys.registerHotKey(v.v, true, onHotKey)
					saveSettings(3, "KEY") -- сохраняем настройки
				end
				imgui.NextColumn()
				if v.cmd ~= "-" then -- условие вывода текста
					imgui.Text(u8("Команда: /"..v.cmd))
				else
					imgui.Text(u8("Команда не назначена"))
				end
				imgui.NextColumn()
				if imgui.Button(u8(" Редактировать бинд ##"..k)) then imgui.OpenPopup(u8"Установка клавиши ##modal"..k) end
				if k ~= 0 then
					imgui.NextColumn()
					if imgui.Button(u8(" Удалить бинд ##"..k)) then
						if v.cmd ~= "-" then sampUnregisterChatCommand(v.cmd) end
						if rkeys.isHotKeyDefined(tLastKeys.v) then rkeys.unRegisterHotKey(tLastKeys.v) end
						table.remove(mass_bind, k)
						saveSettings(3, "DROP BIND")
					end
				end
				if imgui.BeginPopupModal(u8"Установка клавиши ##modal"..k, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
					if imgui.Button(u8(' Сменить/Назначить команду'), imgui.ImVec2(200, 0)) then
						imgui.OpenPopup(u8"Команда - /"..v.cmd)
					end
					if imgui.Button(u8(' Редактировать содержимое'), imgui.ImVec2(200, 0)) then
						cmd_text.v = u8(v.text):gsub("~", "\n")
						binddelay.v = v.delay
						imgui.OpenPopup(u8'Редактор текста ##second'..k)
					end

					if imgui.BeginPopupModal(u8"Команда - /"..v.cmd, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize) then
						imgui.Text(u8"Введите название команды, которую хотите применить к бинду, указывайте без '/':")						
						imgui.Text(u8"Чтобы удалить комманду, введите прочерк и сохраните.")						
						imgui.InputText("##FUCKITTIKCUF_1", cmd_name)

						if imgui.Button(u8" Сохранить", imgui.ImVec2(100, 0)) then
							v.cmd = u8:decode(cmd_name.v)

							if u8:decode(cmd_name.v) ~= "-" then
								rcmd(v.cmd, v.text, v.delay)
								cmd_name.v = ""
							end
							saveSettings(3, "CMD "..v.cmd)
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(u8" Закрыть") then
							cmd_name.v = ""
							imgui.CloseCurrentPopup()
						end
						imgui.EndPopup()
					end
					if imgui.BeginPopupModal(u8'Редактор текста ##second'..k, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize) then
						imgui.BeginChild('##sdaadasdd', imgui.ImVec2(1100, 600), true)
						imgui.Columns(2, _, false)
						imgui.TextWrapped(u8("Параметр {bwait:time} обязателен после каждой строки. Задержка автоматически не выставляется."))
						imgui.TextWrapped(u8"Редактор текста биндера:")
						imgui.InputTextMultiline('##FUCKITTIKCUF_2', cmd_text, imgui.ImVec2(550, 300))
						
						imgui.Text(u8("Результат:"))
						local example = tags(u8:decode(cmd_text.v))
						imgui.Text(u8(example))
						imgui.NextColumn()
						imgui.BeginChild('##sdaadddasdd', imgui.ImVec2(525, 480), true)
						imgui.TextColoredRGB('• {bwait:1500} {21BDBF}- задержка между строк - {fff555}ОБЯЗАТЕЛЬНЫЙ ПАРАМЕТР')
						imgui.Separator()
						
						imgui.TextColoredRGB('• {params} {21BDBF}- параметр команды - {fff555}/'..v.cmd..' [параметр]')
						imgui.TextColoredRGB('• {paramNickByID} {21BDBF}- цифровой параметр, получаем ник по ID.')
						imgui.TextColoredRGB('• {paramFullNameByID} {21BDBF}- цифровой параметр, получаем РП ник по ID.')
						imgui.TextColoredRGB('• {paramNameByID} {21BDBF}- цифровой параметр, получаем имя по ID.')
						imgui.TextColoredRGB('• {paramSurnameByID} {21BDBF}- цифровой параметр, получаем фамилию по ID.')

						imgui.Separator()
						imgui.TextColoredRGB('• {mynick} {21BDBF}- ваш полный ник - {fff555}'..tostring(userNick))
						imgui.TextColoredRGB('• {myfname} {21BDBF}- ваш РП ник - {fff555}'..tostring(nickName))
						imgui.TextColoredRGB('• {myname} {21BDBF}- ваше имя - {fff555}'..tostring(userNick:gsub("_.*", "")))
						imgui.TextColoredRGB('• {mysurname} {21BDBF}- ваша фамилия - {fff555}'..tostring(userNick:gsub(".*_", "")))
						imgui.TextColoredRGB('• {myid} {21BDBF}- ваш ID - {fff555}'..tostring(myID))
						imgui.TextColoredRGB('• {myhp} {21BDBF}- ваш уровень HP - {fff555}'..tostring(healNew))
						imgui.TextColoredRGB('• {myarm} {21BDBF}- ваш уровень брони - {fff555}'..tostring(armourNew))
						imgui.Separator()
						imgui.TextColoredRGB('• {city} {21BDBF}- город, в котором находитесь - {fff555}'..tostring(playerCity))
						imgui.TextColoredRGB('• {kvadrat} {21BDBF}- определение квадрата - {fff555}'..tostring(locationPos()))
						imgui.TextColoredRGB('• {zone} {21BDBF}- определение района - {fff555}'..tostring(ZoneInGame))
						imgui.TextColoredRGB('• {time} {21BDBF}- МСК время - {fff555}'..string.format(os.date('%H:%M:%S', moscow_time)))		
						imgui.EndChild()
						imgui.NewLine()
						if imgui.Button(u8" Сохранить", btn_size) then

							v.text = u8:decode(cmd_text.v):gsub("\n", '~')
							v.delay = binddelay.v
							if v.cmd ~= nil then
								rcmd(v.cmd, v.text, v.delay)
							else
								rcmd(nil, v.text, v.delay)
							end
							saveSettings(3, "BIND TEXT")
							imgui.CloseCurrentPopup()
						end

						if imgui.Button(u8" Закрыть не сохраняя", btn_size) then
							imgui.CloseCurrentPopup()
						end
						imgui.EndChild()
						imgui.EndPopup()
					end

					if imgui.Button(u8" Закрыть", imgui.ImVec2(200, 0)) then
						imgui.CloseCurrentPopup()
					end
					imgui.EndPopup()
				end
			end
			imgui.NextColumn()
			imgui.NewLine()
			if imgui.Button(u8(" Добавить бинд")) then mass_bind[#mass_bind + 1] = {delay = "3", v = {}, text = "n/a", cmd = "-"} end	
		end

		imgui.End()
	end
	if win_state['yashiki'].v then -- окно с настройками
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(850, 465), imgui.Cond.FirstUseEver)
		if imgui.Begin(u8' Roulette Tools', win_state['yashiki'], imgui.WindowFlags.NoResize + imgui.WindowFlags.MenuBar) then
				imgui.BeginChild('##asdasasddf', imgui.ImVec2(800, 380), false)
				imgui.Columns(2, _, false)
				imgui.Checkbox(u8'Открыть бронзовые рулетки', checked_test)
				imgui.Checkbox(u8'Открыть серебряные  рулетки', checked_test2)
				imgui.Checkbox(u8'Открыть золотые рулетки', checked_test3)
				imgui.Checkbox(u8'Открыть платиновые рулетки', checked_test4)
				imgui.Checkbox(u8'Обменять подарки', podarki); imgui.SameLine(); imgui.TextQuestion(u8"Вам нужно встать перед Эдвардом и активировать данную функцию. Функция остановится автоматический после того, как у вас закончатся подарки.")  
				imgui.Checkbox(u8'Обменять гражданские талоны на рулетки', platina); imgui.SameLine(); imgui.TextQuestion(u8"Вам нужно встать перед Эдвардом и активировать данную функцию. Функция остановится автоматический после того, как у вас закончатся гражданские талоны.")  
				imgui.NextColumn()
				imgui.Checkbox(u8'Открывать обычный сундук', checked_test5)
				imgui.Checkbox(u8'Открывать донатный сундук', checked_test6)
				imgui.Checkbox(u8'Открывать платиновый сундук', checked_test7)
				imgui.Checkbox(u8'Открывать сундук "Илона Маска"', checked_test10)
				imgui.InputText(u8'Задержка', zadervka)
				imgui.NextColumn()
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Всегда открывать обычный сундук")); imgui.SameLine(); imgui.ToggleButton(u8'Всегда открывать обычный сундук', yashik)
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Всегда открывать донатный сундук")); imgui.SameLine(); imgui.ToggleButton(u8'Всегда открывать донатный сундук', yashik1)
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Всегда открывать платиновый сундук")); imgui.SameLine(); imgui.ToggleButton(u8'Всегда открывать платиновый сундук', yashik2)
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Всегда открывать сундук 'Илона Маска'")); imgui.SameLine(); imgui.ToggleButton(u8'Всегда открывать сундук "Илона Маска"', yashik3)
				imgui.InputText(u8'Задержка ',zadervkav2)
				imgui.NextColumn()
				imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"*Важно! Включать либо открывать сундук или всегда открывать.")
				imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Иначе работать не будет! Если включить 'всегда открывать' -")
				imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"то скрипт будет открывать выбранные сундуки даже после")
				imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"перезахода. Если включить 'открыть сундук' - то скрипт будет")
				imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"открывать выбранные сундуки до перезахода. Также если")
				imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"перестали открываться сундуки, то зайдите в /settings")
				imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"и включите инвентарь на русский и снова на английский.")
				imgui.EndChild()
			end
			if checked_test.v then
			checked_test.v = true
			checked_test2.v = false
			checked_test3.v = false
			checked_test4.v = false
			end
			if checked_test2.v then
			checked_test2.v = true
			checked_test.v = false
			checked_test3.v = false
			checked_test4.v = false
			end
			if checked_test3.v then
			checked_test4.v = false
			checked_test3.v = true
			checked_test2.v = false
			checked_test.v = false
			end
			if checked_test4.v then
			checked_test3.v = false
			checked_test2.v = false
			checked_test.v = false
			checked_test4.v = true
			end
		imgui.End()
	end
	if win_state['redak'].v then 
		rpredak()
	end	
	if win_state['shema'].v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(510, 470), imgui.Cond.FirstUseEver)
		if imgui.Begin(u8' Схема', win_state['shema'], imgui.WindowFlags.NoResize) then
				imgui.BeginChild('##asdasasddf461', imgui.ImVec2(800, 430), false)
				imgui.PushFont(fontsize)
				imgui.Text('   INVENTORY'); imgui.SameLine(); imgui.Text('                       S'); imgui.SameLine(); imgui.Text('     C'); imgui.SameLine(); imgui.Text('    P'); imgui.SameLine(); imgui.Text('     S');
				imgui.PopFont()
				imgui.Button(u8' №1', btn_size5); imgui.SameLine(); imgui.Button(u8' №2', btn_size5); imgui.SameLine(); imgui.Button(u8' №3', btn_size5); imgui.SameLine(); imgui.Button(u8' №4', btn_size5); imgui.SameLine(); imgui.Button(u8' №5', btn_size5); imgui.SameLine(); imgui.Button(u8' №6', btn_size5)
				imgui.Button(u8' №7', btn_size5); imgui.SameLine(); imgui.Button(u8' №8', btn_size5); imgui.SameLine(); imgui.Button(u8' №9', btn_size5); imgui.SameLine(); imgui.Button(u8' №10', btn_size5); imgui.SameLine(); imgui.Button(u8' №11', btn_size5); imgui.SameLine(); imgui.Button(u8' №12', btn_size5)
				imgui.Button(u8' №13', btn_size5); imgui.SameLine(); imgui.Button(u8' №14', btn_size5); imgui.SameLine(); imgui.Button(u8' №15', btn_size5); imgui.SameLine(); imgui.Button(u8' №16', btn_size5); imgui.SameLine(); imgui.Button(u8' №17', btn_size5); imgui.SameLine(); imgui.Button(u8' №18', btn_size5)
				imgui.Button(u8' №19', btn_size5); imgui.SameLine(); imgui.Button(u8' №20', btn_size5); imgui.SameLine(); imgui.Button(u8' №21', btn_size5); imgui.SameLine(); imgui.Button(u8' №22', btn_size5); imgui.SameLine(); imgui.Button(u8' №23', btn_size5); imgui.SameLine(); imgui.Button(u8' №24', btn_size5)
				imgui.Button(u8' №25', btn_size5); imgui.SameLine(); imgui.Button(u8' №26', btn_size5); imgui.SameLine(); imgui.Button(u8' №27', btn_size5); imgui.SameLine(); imgui.Button(u8' №28', btn_size5); imgui.SameLine(); imgui.Button(u8' №29', btn_size5); imgui.SameLine(); imgui.Button(u8' №30', btn_size5)
				imgui.Button(u8' №31', btn_size5); imgui.SameLine(); imgui.Button(u8' №32', btn_size5); imgui.SameLine(); imgui.Button(u8' №33', btn_size5); imgui.SameLine(); imgui.Button(u8' №34', btn_size5); imgui.SameLine(); imgui.Button(u8' №35', btn_size5); imgui.SameLine(); imgui.Button(u8' №36', btn_size5)
				imgui.Text(u8'                                                 '); imgui.SameLine(); imgui.RadioButton('', hlam, 2); imgui.SameLine(); imgui.RadioButton('', hlam, 1); imgui.SameLine(); imgui.RadioButton('', hlam, 3)
				imgui.EndChild()
			end
		imgui.End()
	end
	if win_state['shematext'].v then
		shemamenu()
	end
	if win_state['shemainst'].v then
		shemainstr()
	end
	if win_state['carsas'].v then
		carsax()
	end
	if win_state['bank'].v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(850, 400), imgui.Cond.FirstUseEver)
		if imgui.Begin(u8' Bank Menu ', win_state['bank'], imgui.WindowFlags.NoResize + imgui.WindowFlags.MenuBar) then
				imgui.BeginChild('##asdasasddf', imgui.ImVec2(800, 330), false)
				imgui.Columns(2, _, false)
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Оплата налогов за авто, коммуналку, дом и бизнес")); imgui.SameLine(); imgui.ToggleButton(u8("Оплата налогов за авто, коммуналку, дом и бизнес"), autoopl); imgui.SameLine(); imgui.TextQuestion(u8"Чтобы начать авто-оплату, зайдите в меню Банка на N и нажмите 'Пополнить счёт SIM'.");
				if autoopl.v then
					imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Номера строк:")
					imgui.InputText(u8'Авто', autopassopl); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за авто' и вписываете получившиеся номер строки. По умолчанию стоит 6 строка.")
					imgui.InputText(u8'Коммуналка', autopassopl1); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата коммуналки' и вписываете получившиеся номер строки. По умолчанию стоит 15 строка.")
					imgui.InputText(u8'Дом', autopassopl2); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за дом' и вписываете получившиеся номер строки. По умолчанию стоит 16 строка.")
					imgui.InputText(u8'Бизнес', autopassopl3); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за бизнес' и вписываете получившиеся номер строки. По умолчанию стоит 17 строка.")
				end
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Оплата налогов за коммуналку, дом и бизнес")); imgui.SameLine(); imgui.ToggleButton(u8("Оплата налогов за коммуналку, дом и бизнес"), autoopl2); imgui.SameLine(); imgui.TextQuestion(u8"Чтобы начать авто-оплату, зайдите в меню Банка на N и нажмите 'Пополнить счёт SIM'.");
				if autoopl2.v then
					imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Номера строк:")
					imgui.InputText(u8'Коммуналка ', autopassopl1); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата коммуналки' и вписываете получившиеся номер строки. По умолчанию стоит 15 строка.")
					imgui.InputText(u8'Дом ', autopassopl2); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за дом' и вписываете получившиеся номер строки. По умолчанию стоит 16 строка.")
					imgui.InputText(u8'Бизнес ', autopassopl3); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за бизнес' и вписываете получившиеся номер строки. По умолчанию стоит 17 строка.")
				end
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Оплата налогов за авто, коммуналку и дом")); imgui.SameLine(); imgui.ToggleButton(u8("Оплата налогов за авто, коммуналку и дом"), autoopl1); imgui.SameLine(); imgui.TextQuestion(u8"Чтобы начать авто-оплату, зайдите в меню Банка на N и нажмите 'Пополнить счёт SIM'.");
				if autoopl1.v then
					imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Номера строк:")
					imgui.InputText(u8'Авто ', autopassopl); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за авто' и вписываете получившиеся номер строки. По умолчанию стоит 6 строка.")
					imgui.InputText(u8'Коммуналка  ', autopassopl1); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата коммуналки' и вписываете получившиеся номер строки. По умолчанию стоит 15 строка.")
					imgui.InputText(u8'Дом  ', autopassopl2); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за дом' и вписываете получившиеся номер строки. По умолчанию стоит 16 строка.")
				end
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Оплата налогов за коммуналку и дом")); imgui.SameLine(); imgui.ToggleButton(u8("Оплата налогов за коммуналку и дом"), autoopl5); imgui.SameLine(); imgui.TextQuestion(u8"Чтобы начать авто-оплату, зайдите в меню Банка на N и нажмите 'Пополнить счёт SIM'.");
				if autoopl5.v then
					imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Номера строк:")
					imgui.InputText(u8'Коммуналка   ', autopassopl1); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата коммуналки' и вписываете получившиеся номер строки. По умолчанию стоит 15 строка.")
					imgui.InputText(u8'Дом   ', autopassopl2); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за дом' и вписываете получившиеся номер строки. По умолчанию стоит 16 строка.")
				end
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Оплата налогов за авто и бизнес")); imgui.SameLine(); imgui.ToggleButton(u8("Оплата налогов за авто и бизнес"), autoopl3); imgui.SameLine(); imgui.TextQuestion(u8"Чтобы начать авто-оплату, зайдите в меню Банка на N и нажмите 'Пополнить счёт SIM'.");
				if autoopl3.v then
					imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Номера строк:")
					imgui.InputText(u8'Авто  ', autopassopl); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за авто' и вписываете получившиеся номер строки. По умолчанию стоит 6 строка.")
					imgui.InputText(u8'Бизнес  ', autopassopl3); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за бизнес' и вписываете получившиеся номер строки. По умолчанию стоит 17 строка.")
				end
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Оплата налогов за бизнес")); imgui.SameLine(); imgui.ToggleButton(u8("Оплата налогов за бизнес"), autoopl6); imgui.SameLine(); imgui.TextQuestion(u8"Чтобы начать авто-оплату, зайдите в меню Банка на N и нажмите 'Пополнить счёт SIM'.");
				if autoopl6.v then
					imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Номера строк:")
					imgui.InputText(u8'Бизнес   ', autopassopl3); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за бизнес' и вписываете получившиеся номер строки. По умолчанию стоит 17 строка.")
				end
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Оплата налогов за авто")); imgui.SameLine(); imgui.ToggleButton(u8("Оплата налогов за авто"), autoopl4); imgui.SameLine(); imgui.TextQuestion(u8"Чтобы начать авто-оплату, зайдите в меню Банка на N и нажмите 'Пополнить счёт SIM'.");
				if autoopl4.v then
					imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Номера строк:")
					imgui.InputText(u8'Авто    ', autopassopl); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за авто' и вписываете получившиеся номер строки. По умолчанию стоит 6 строка.")
				end
				imgui.NextColumn()
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Пополнение депозита каждый PD")); imgui.SameLine(); imgui.ToggleButton(u8("Пополнение депозита каждый PD"), autopay); imgui.SameLine(); imgui.TextQuestion(u8"Пополняет депозит на указанную сумму когда скрипт видит в чате 'Банковский чек'. Также вы должны в этот момент стоять у кассы в Банке, иначе депозит не пополнится.");
				if autopay.v then
					imgui.InputText(u8'Номер строки', autopasspaypin); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Пополнения Депозита' и вписываете получившиеся номер строки. По умолчанию стоит 8 строка.")
					imgui.InputText(u8'Сумма', autopasspay); imgui.SameLine(); imgui.TextQuestion(u8"В данном пункте обязательно нужно указать сумму пополнения. По умолчанию стоит 5.000.000$")
			end
				imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"*Важно! Оплату налогов включать только один из нужных вам")
				imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"пунктов! Также внимательно читайте как и что нужно настроить.")
				imgui.EndChild()
			end
		imgui.End()
	end
	if win_state['gamer'].v then -- основное окошко
		local btn_size23 = imgui.ImVec2(-25, 0) -- а это "шаблоны" размеров кнопок
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(260, 145), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' Мини игры ', win_state['gamer'], imgui.WindowFlags.NoResize)
		if imgui.Button(u8' Играть в 2048', btn_size23) then win_state['games'].v = not win_state['games'].v end
		imgui.SameLine(); imgui.TextQuestion(u8"Правила:\n 1) В каждом раунде появляется плитка номинала «2».\n 2) Нажатием стрелки игрок может скинуть все плитки игрового поля в одну из 4 сторон. Если при сбрасывании две плитки одного номинала «налетают» одна на другую, то они превращаются в одну, номинал которой равен сумме соединившихся плиток. После каждого хода на свободной секции поля появляется новая плитка номиналом «2». Если при нажатии кнопки местоположение плиток или их номинал не изменится, то ход не совершается.\n 3) За каждое соединение игровые очки увеличиваются на номинал получившейся плитки.\n 4) Игра заканчивается поражением, если после очередного хода невозможно совершить действие.\n\n Управление:\n ^ - стрелка вверх.\n > - стрелка вправо.\n < - стрелка влево.\n v - стрелка вниз.\n ESC - закрыть игру.")
		if imgui.Button(u8' Играть в Pong', btn_size23) then pong = not pong end
		imgui.SameLine(); imgui.TextQuestion(u8"Правила:\n 1) Игра не имеет ограничений по времени и счету.\n 2) Перед началом игры нужно нажать кнопку 'New Game'.\n 3) Всего в игре 4 уровня сложности и 8 скоростей.\n 4) Скорость увеличивается постепенно(зависит от счета и сложности).\n 5) Цель игры - отбивать летящий в вашу сторону мяч.\n\n Управление:\n ^ - стрелка вверх.\n v - стрелка вниз.\n 'New Game' - загружает игру или сбрасывает вашу старую игру.\n 'Start' - начать игру.\n 'Pause/Resume' - поставить игру на паузу/продолжить игру.\n 'Difficulty' - уровень сложности.\n 'Speed' - скорость игры.")
		if imgui.Button(u8' Играть в змейку', btn_size23) then snaketaken = not snaketaken end
		imgui.SameLine(); imgui.TextQuestion(u8"Цель игры: съесть как можно больше яблок и не врезаться в самого себя.\n\n Управление:\n ^ - стрелка вверх.\n > - стрелка вправо.\n < - стрелка влево.\n v - стрелка вниз.\n E - начать игру.\n R - закрыть игру.")
		imgui.End()
	end
	if win_state['games'].v then -- окно с настройками
		gamelist()
	end
	if win_state['help'].v then -- окно "помощь"
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(970, 400), imgui.Cond.FirstUseEver)
		imgui.Begin(u8('Помощь'), win_state['help'], imgui.WindowFlags.NoResize)
		imgui.BeginGroup()
		imgui.BeginChild('left pane', imgui.ImVec2(180, 350), true)
		if imgui.Selectable(u8"Команды скрипта") then selected2 = 2 end
		imgui.Separator()
		if imgui.Selectable(u8"Обновления скрипта") then selected2 = 1 end
		imgui.Separator()
		if imgui.Selectable(u8"Коды клавиш") then selected2 = 3 end			
		imgui.Separator()
		if imgui.Selectable(u8"О скрипте") then selected2 = 4 end			
		imgui.Separator()
		imgui.EndChild()
		imgui.SameLine()
		imgui.BeginChild('##ddddd', imgui.ImVec2(745, 350), true)
		if selected2 == 0 then selected2 = 1
		elseif selected2 == 4 then
		scriptinfo()
		elseif selected2 == 3 then
		imgui.Text(u8"Коды клавиш")
		imgui.Columns(2, _,false)
		imgui.SetColumnWidth(-1, 800)
		imgui.Separator()
		imgui.Text(u8"Tab - 9"); imgui.SameLine(); imgui.Text(u8"Enter - 13"); imgui.SameLine(); imgui.Text(u8"Shift - 16"); imgui.SameLine(); imgui.Text(u8"Ctrl - 17"); imgui.SameLine(); imgui.Text(u8"Alt - 18"); imgui.SameLine(); imgui.Text(u8"Pause - 19"); imgui.SameLine(); imgui.Text(u8"CapsLock - 20"); imgui.SameLine(); imgui.Text(u8"Esc - 27"); imgui.SameLine(); imgui.Text(u8"Пробел - 32"); imgui.SameLine(); imgui.Text(u8"PageUp - 33")
		imgui.Text(u8"PageDown - 34"); imgui.SameLine(); imgui.Text(u8"End - 35"); imgui.SameLine(); imgui.Text(u8"Home - 36"); imgui.SameLine(); imgui.Text(u8"Стрелка влево - 37"); imgui.SameLine(); imgui.Text(u8"Стрелка вверх - 38"); imgui.SameLine(); imgui.Text(u8"Стрелка вправо - 39"); imgui.SameLine(); imgui.Text(u8"Стрелка вниз - 40")
		imgui.Text(u8"Insert - 45"); imgui.SameLine(); imgui.Text(u8"Delete - 46"); imgui.SameLine(); imgui.Text(u8"0 - 48"); imgui.SameLine(); imgui.Text(u8"1 - 49"); imgui.SameLine(); imgui.Text(u8"2 - 50"); imgui.SameLine(); imgui.Text(u8"3 - 51"); imgui.SameLine(); imgui.Text(u8"4 - 52"); imgui.SameLine(); imgui.Text(u8"5 - 53"); imgui.SameLine(); imgui.Text(u8"6 - 54"); imgui.SameLine(); imgui.Text(u8"7 - 55"); imgui.SameLine(); imgui.Text(u8"8 - 56"); imgui.SameLine(); imgui.Text(u8"9 - 57"); imgui.SameLine(); imgui.Text (u8"A - 65"); imgui.SameLine(); imgui.Text (u8"B - 66")	
		imgui.Text (u8"C - 67"); imgui.SameLine(); imgui.Text (u8"D - 68"); imgui.SameLine();	imgui.Text (u8"E - 69"); imgui.SameLine();	imgui.Text (u8"F - 70"); imgui.SameLine();	imgui.Text (u8"G - 71"); imgui.SameLine();	imgui.Text (u8"H - 72"); imgui.SameLine();	imgui.Text (u8"I - 73"); imgui.SameLine();	imgui.Text (u8"J - 74"); imgui.SameLine();	imgui.Text (u8"K - 75"); imgui.SameLine();	imgui.Text (u8"L - 76"); imgui.SameLine();	imgui.Text (u8"M - 77"); imgui.SameLine();	imgui.Text (u8"N - 78"); imgui.SameLine();	imgui.Text (u8"O - 79"); imgui.SameLine();	imgui.Text (u8"P - 80"); imgui.SameLine();	imgui.Text (u8"Q - 81")	
		imgui.Text (u8"R - 82"); imgui.SameLine();	imgui.Text (u8"S - 83"); imgui.SameLine();	imgui.Text (u8"T - 84"); imgui.SameLine();	imgui.Text (u8"U - 85"); imgui.SameLine();	imgui.Text (u8"V - 86"); imgui.SameLine();	imgui.Text (u8"W - 87"); imgui.SameLine();	imgui.Text (u8"X - 88"); imgui.SameLine();	imgui.Text (u8"Y - 89"); imgui.SameLine();	imgui.Text (u8"Z - 90"); imgui.SameLine();	imgui.Text (u8"левая клавиша Windows - 91")
		imgui.Text (u8"правая клавиша Windows - 92"); imgui.SameLine(); imgui.Text (u8"NumPad 0 - 96"); imgui.SameLine(); imgui.Text (u8"NumPad 1 - 97"); imgui.SameLine(); imgui.Text (u8"NumPad 2 - 98"); imgui.SameLine(); imgui.Text (u8"NumPad 3 - 99"); imgui.SameLine(); imgui.Text (u8"NumPad 4 - 100")
		imgui.Text (u8"NumPad 5 - 101"); imgui.SameLine(); imgui.Text (u8"NumPad 6 - 102"); imgui.SameLine(); imgui.Text (u8"NumPad 7 - 103"); imgui.SameLine(); imgui.Text (u8"NumPad 8 - 104"); imgui.SameLine(); imgui.Text (u8"NumPad 9 - 105"); imgui.SameLine(); imgui.Text (u8"NumPad * - 106"); imgui.SameLine(); imgui.Text (u8"NumPad + - 107")
		imgui.Text (u8"NumPad - - 109"); imgui.SameLine(); imgui.Text (u8"NumPad . - 119"); imgui.SameLine(); imgui.Text (u8"NumPad / - 111"); imgui.SameLine(); imgui.Text (u8"F3 - 114"); imgui.SameLine(); imgui.Text (u8"F4 - 115"); imgui.SameLine(); imgui.Text (u8"F5 - 116"); imgui.SameLine(); imgui.Text (u8"F6 - 117"); imgui.SameLine(); imgui.Text (u8"F7 - 118"); imgui.SameLine(); imgui.Text (u8"F8 - 119"); imgui.SameLine(); imgui.Text (u8"F9 - 120")
		imgui.Text (u8"F10 - 121"); imgui.SameLine(); imgui.Text (u8"F11 - 122"); imgui.SameLine(); imgui.Text (u8"F12 - 123")
		elseif selected2 == 1 then
		imgui.Text(u8"Обновления")
		imgui.Columns(2, _,false)
		imgui.SetColumnWidth(-1, 800)
		imgui.Separator()
		if imgui.CollapsingHeader(u8' 23.04.2021') then
				imgui.BeginChild('##as2dasasdf354', imgui.ImVec2(750, 135), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text(u8"1. Добавлено автообноление.")
				imgui.Text(u8"2. В случае, если у вас не хватает библиотек - скрипт напишет в moonloader.log каких библиотек не хватает")
				imgui.Text(u8"и укажет ссылку, где можно их скачать.")
				imgui.Text(u8"3. Убрана авто-оплата налогов т.к с новым семейным улучшением она не нужна.")
				imgui.Text(u8"4. Теперь можно изменить цвет меню.")
				imgui.Text(u8"5. Когда вы нажимаете на 'Биндер и настройки' сразу открывается меню с настройками.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 24.04.2021') then
				imgui.BeginChild('##as2dasasdf876', imgui.ImVec2(750, 140), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text(u8"1. Добавлен автобайк и автомото. Если на вашем сервере он запрещен, то используйте на свой страх и риск.")
				imgui.Text(u8"2. Добавлены точки в числах.")
				imgui.Text(u8"3. Добавлено запоминание диалогов(полезно тем, кто играет со сборки).")
				imgui.Text(u8"4. Вроде бы сделал фикс, что скрипт запускался не с первого раза.")
				imgui.Text(u8"Но если эта проблема осталась или нашли другую, то пишите в тему на БХ.")
				imgui.Text(u8"5. Добавлен калькулятор. Меню скрипта - калькулятор.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 25.04.2021') then
				imgui.BeginChild('##as2dasasdf753', imgui.ImVec2(750, 190), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text(u8"1. После обновления скрипт будет писать, что ознакомиться с обновлением вы сможете")
				imgui.Text(u8"в Меню скрипта - помощь - обновления. ")
				imgui.Text(u8"2. Добавлено закрытие меню скрипта на ESC.")
				imgui.Text(u8"3. Исправлен баг когда при использовании точек в числах не работали текстдравы.")
				imgui.Text(u8"4. Добавлена возможность включить открывание ящиков навсегда.")
				imgui.Text(u8"5. Также меню с рулетками и ящиками перенесено на главное меню в /"..activator.v..".")
				imgui.Text(u8"6. В информер добавлен счетчик FPS, но он требует доработки.")
				imgui.Text(u8"7. Также обнаружен баг, когда окно информера пропадает при использований функции")
				imgui.Text(u8"открытия ящиков. Будет исправлено позже.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 26.04.2021') then
				imgui.BeginChild('##as2dasasdf8767', imgui.ImVec2(750, 190), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text(u8"1. В новую функцию открытия сундуков добавлен ползунок с задержкой")
				imgui.Text(u8"(по умолчанию 3 минуты)")
				imgui.Text(u8"2. В Roolette Tools добавлена инструкция по использованию.")
				imgui.Text(u8"3. Исправлена невозможность сменить стиль если открываются сундуки.")
				imgui.Text(u8"4. Фикс закрытия меню на esc(не закрывалось, если открыт информер).")
				imgui.Text(u8"5. Исправлены баги связанные с информером.")
				imgui.Text(u8"6. После спавна на экране появлялась мышка - исправлено. ")
				imgui.Text(u8"7. После спавна, если выбран пункт 'всегда открывать сундуки',")
				imgui.Text(u8"через 10 секунд открывается инвентарь, чтобы открытие сундуков сработало.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 28.04.2021') then
				imgui.BeginChild('##as2dasasdf645', imgui.ImVec2(750, 70), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text(u8"1. Добавлен в модификации Фикс для тех, кто использует МВД Хелпер(МВД блочит инвентарь при спавне).")
				imgui.Text(u8"2. В информер добавлено ХП транспорта.")
				imgui.Text(u8"3. После смерти, если включено 'всегда открывать сундуки' у вас не открывается инвентарь.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 03.05.2021') then
				imgui.BeginChild('##as2dasasdf213', imgui.ImVec2(750, 160), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text(u8"1. Добавлено сохранение задержки для сундуков.")
				imgui.Text(u8"2. Добавлена автоеда дома с кд в 3 часа на всякий случай.")
				imgui.Text(u8"3. 'Bank Menu' перенесен в главное меню.")
				imgui.Text(u8"4. Полностью переписана система пополнения депозита.")
				imgui.Text(u8"5. Вернул улучшенную версию авто оплаты налогов.(находится в 'Bank Menu')")
				imgui.Text(u8"6. Теперь в 'Модификации' можно настроить кнопку на открытие/закрытие скрипта.")
				imgui.Text(u8"7. В помощь добавлен пункт 'Коды клавиш'.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 07.05.2021') then
				imgui.BeginChild('##as2dasasdf124', imgui.ImVec2(750, 40), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text(u8"1. Добавлен в 'Биндер и Настройки' пункт 'Майнинг'. Там вы сможете улучшать свои видеокарты.")
				imgui.Text(u8"2. В 'Roulette Tools' добавлено золотое яйцо.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 08.05.2021') then
				imgui.BeginChild('##as2dasasdf687', imgui.ImVec2(750, 45), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text(u8"1. Фикс улучшения видеокарт. Также скрипт работает только на Юме и Прескотте. Если нужно добавить другие")
				imgui.Text(u8"сервера или обнаружили баги - пишите в теме на БХ.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 22.05.2021') then
				imgui.BeginChild('##as2dasasdf358', imgui.ImVec2(750, 120), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text(u8"1. Добавлена возможность перезагрузки скрипта на кнопку.")
				imgui.Text(u8"2. Фикс когда меню не открывалось при открытий сундуков.")
				imgui.Text(u8"3. Переписан эмулятор лаунчера. Теперь можно активировать ПК версию или мобаил версию.")
				imgui.Text(u8"Преимущества мобаил - виден luxe транспорт.")
				imgui.Text(u8"4. Добавлена возможность изменить команду открытия скрипта.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 23.05.2021') then
				imgui.BeginChild('##as2dasasdf146', imgui.ImVec2(750, 70), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text(u8"1. Добавлен autofind. /afind - начать поиск игрока. /sfind - закончить поиск. ")
				imgui.Text(u8"2. Убрано золотое яйцо т.к уже неактуально")
				imgui.Text(u8"3. Добавлена авто-отыгровка некоторого оружия.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 28.05.2021') then
				imgui.BeginChild('##as2dasasdf34', imgui.ImVec2(750, 70), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text(u8"1. Фикс того, что если убирали код клавиши в активаций скрипта - было невозможно писать в других полях.")
				imgui.Text(u8"2. Добавлен Input Chat. Теперь даже на русской раскладке можно будет писать команды на английском языке.")
				imgui.Text(u8"3. Фикс когда открытие сундуков останавливало работу некоторых функций скрипта.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 29.05.2021') then
				imgui.BeginChild('##as2dasasdf6453', imgui.ImVec2(750, 140), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text(u8"1. Фикс того, что если не выбрано в RP gun оружие, то если вы убрали оружие с рук не будет рп отыгровки")
				imgui.Text(u8"/me убрал оружие.")
				imgui.Text(u8"2. Убран флуд в чат при заточке аксессуаров/скинов и все уведомления идут в imgui уведомления.")
				imgui.Text(u8"3. Добавлен пинг в информер.")
				imgui.Text(u8"4. Фикс ФПС в информере.")
				imgui.Text(u8"5. Добавлен онлайн за сессию в информер.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 31.05.2021') then
				imgui.BeginChild('##as2dasasdf546', imgui.ImVec2(750, 215), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text(u8"1. Добавлена возможность каждые 30 минут есть из мешка с мясом в 'автоеда'.")
				imgui.Text(u8"2. В 'RP Gun' добавлен тайзер.")
				imgui.Text(u8"3. Добавлена возможность изменить отыгровку на '/me убрал оружие', но работает в общем случае для всего оружия.")
				imgui.Text(u8"4. Добавлен реконнект после рестарта через 10 минут. Также по команде /recon можно перезайти на сервер")
				imgui.Text(u8"через 30 секунд.")
				imgui.Text(u8"5. Добавлено 'редактирование диалога /cars'. Можно использовать, например, чтобы подписать местоположение")
				imgui.Text(u8"машин, изменить цвет строк в диалоге и тому подобное.")
				imgui.Text(u8"6. Переходя в 'помощь', теперь вместо списка обновлений, открываются команды скрипта.")
				imgui.Text(u8"7. В помощь добавлен пункт 'О скрипте', где перечислены автор и люди, которые помогают.")
				imgui.Text(u8"А также кнопка, по нажатию на которую, вы перейдете в тему на БХ.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 3.06.2021') then
				imgui.BeginChild('##as2dasasdf457', imgui.ImVec2(750, 180), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text(u8"1. Добавлено автооткрытие подарков в меню 'Roulette Tools'. Теперь вам нужно всего лишь подойти к Эдварду,")
				imgui.Text(u8"поставить галочку и вы в автоматическом режиме обменяете все свои подарки на призы. Функция выключится")
				imgui.Text(u8"автоматический, если у вас закончатся подарки.")
				imgui.Text(u8"2. Добавлено то, что если слот в бронзовой рулетке обновляется, то прокрутка рулетки останавливается.")
				imgui.Text(u8"Сделано для того, чтобы после смены слота ваши рулетки не крутились впустую.")
				imgui.Text(u8"3. Добавлен Chat Сalculator от 'Adrian G'. Если функция включена, то пишите пример в чат и получаете")
				imgui.Text(u8"под чатом ответ.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 10.06.2021') then
				imgui.BeginChild('##as2dasasdf4576', imgui.ImVec2(750, 215), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text(u8"1. Теперь можно перезайти в игру через нужное вам время - /recon (время в сек). Если написать просто /recon -")
				imgui.Text(u8"то вы перезайдете на сервер через 30 секунд.")
				imgui.Text(u8"2. Убран калькулятор на imgui т.к есть калькулятор в чат и он удобнее.")
				imgui.Text(u8"3. Добавлены мини игры '2048' от CaJlaT, 'Пинг Понг' и 'Змейка' от arsuhinars.")
				imgui.Text(u8"4. Переписана система RP Guns.")
				imgui.Text(u8"5. Фиксы, которые относятся к меню скрипта.")
				imgui.Text(u8"6. Фикс, когда закрывался скрипт, если закрыть чат на ESC.")
				imgui.Text(u8"7. Фикс, когда автобайк срабатывал при открытом чате.")
				imgui.Text(u8"8. В 'Roulette Tools' добавлена возможность обменять гражданские талоны на платиновые рулетки.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 26.06.2021') then
				imgui.BeginChild('##as2dasasdf457546', imgui.ImVec2(750, 215), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text(u8"1. Фикс сундуков, рулеток и автоточилок.")
				imgui.Text(u8"2. Теперь при заточке аксессуаров или скинов, камни и амулеты могут быть на любой странице.")
				imgui.Text(u8"3. Обновлен 'Умный реконнект'. Теперь вы автоматический перезайдете на сервер после рестарта, при кике")
				imgui.Text(u8"античитом и при срабатываний защиты от реконнекта.")
				imgui.Text(u8"4. Переписан 'Майнинг'. Теперь вы сможете улучшать ваши видеокарты на любом сервере Аризоны.")
		imgui.EndChild()
		end
		elseif selected2 == 2 then
			imgui.Text(u8"Команды скрипта")
			imgui.Separator()
			imgui.Columns(2, _,false)
			imgui.SetColumnWidth(-1, 800)
				imgui.TextColored(imgui.ImVec4(0.80, 0.73 , 0, 1.0), u8"/reload - Перезагрузка скрипта.")
				imgui.TextColored(imgui.ImVec4(0.80, 0.73 , 0, 1.0), u8"/сс - Очистка чата.")
				imgui.TextColored(imgui.ImVec4(0.80, 0.73 , 0, 1.0), u8"/drone - Получить картинку с дрона на территории.")
				imgui.TextColored(imgui.ImVec4(0.80, 0.73 , 0, 1.0), u8"/afind - Автопоиск игрока через /find.")
				imgui.TextColored(imgui.ImVec4(0.80, 0.73 , 0, 1.0), u8"/sfind - Отключение автопоиска.")
				imgui.TextColored(imgui.ImVec4(0.80, 0.73 , 0, 1.0), u8"/recon - Перезайти на сервер через 30 секунд.")
				imgui.TextColored(imgui.ImVec4(0.80, 0.73 , 0, 1.0), u8"/recon [время] - Перезайти на сервер через указанное время(в секундах).")
				imgui.Separator()
				imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Важно! Для того, чтобы все функции скрипта работали стабильно, нужно чтобы инвентарь был на английском языке!")
				imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Настройть язык инвентаря вы можете в /settings. Убедительная просьба не выключать автообновления в коде.")
				imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Иначе вы в будущем не получите улучшения или исправление ошибок.")
		end
		imgui.EndChild()
        imgui.EndGroup()
        imgui.End()
	end
	if win_state['informer'].v then -- окно информера
		imgui.SetNextWindowPos(imgui.ImVec2(infoX, infoY), imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(200, 200), imgui.Cond.FirstUseEver)
		imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.0, 0.0, 0.0, 0.3))
		if imgui.Begin("Mono Tools", win_state['informer'], imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoSavedSettings) then
			infobar()
			imgui.End()
			end
		imgui.PopStyleColor()
		end
	end
	
function infobar()
			if infHP.v then imgui.Text(u8("• Здоровье: "..healNew)) end
			if infArmour.v then imgui.Text(u8("• Броня: "..armourNew)) end
			if infCity.v then imgui.Text(u8("• Город: "..playerCity)) end
			if infRajon.v then imgui.Text(u8("• Район: "..ZoneInGame)) end
			if inffps.v then imgui.Text(u8("• ФПС: "..tostring(fraimrei))) end
			if infping.v then imgui.Text(u8("• Пинг: "..ping)) end
			if isCharInAnyCar(PLAYER_PED) and infhpcar.v then 
				car = storeCarCharIsInNoSave(playerPed)
				carhp = getCarHealth(car)
			imgui.Text(u8("• ХП т/с: " ..carhp)) end
			if infKv.v then imgui.Text(u8("• Квадрат: "..tostring(locationPos()))) end
			if infTime.v then imgui.Text(u8("• Время: "..os.date("%H:%M:%S"))) end
			if infonline.v then imgui.Text(u8("• Онлайн за сессию: "..get_timer(sessiononline))) end
		end

function imgui.Link(link,name,myfunc)
  myfunc = type(name) == 'boolean' and name or myfunc or false
  name = type(name) == 'string' and name or type(name) == 'boolean' and link or link
  local size = imgui.CalcTextSize(name)
  local p2 = imgui.GetCursorPos()
  local resultBtn = imgui.InvisibleButton('##'..link..name, size)
  if resultBtn then
      if not myfunc then
          os.execute('explorer '..link)
      end
  end
  imgui.SetCursorPos(p2)
  if imgui.IsItemHovered() then
      imgui.TextColored(imgui.GetStyle().Colors[imgui.Col.ButtonHovered], name)
  else
      imgui.TextColored(imgui.GetStyle().Colors[imgui.Col.Button], name)
  end
  return resultBtn
end

function getfps()
    lua_thread.create(function()
        wait(400)
            fraimrei = math.floor(memory.getfloat(0xB7CB50, true))
        return true
    end)
end

function imgui.TextQuestion(text)
	imgui.TextDisabled('(?)')
	if imgui.IsItemHovered() then
		imgui.BeginTooltip()
		imgui.PushTextWrapPos(450)
		imgui.TextUnformatted(text)
		imgui.PopTextWrapPos()
		imgui.EndTooltip()
	end
end

function rcmd(cmd, text, delay) -- функция для биндера, без которой не будет ни команд, ни клавиш.
	if cmd ~= nil then -- обрабатываем биндер, который работает по команде
		if cmd ~= '-' then sampUnregisterChatCommand(cmd) end -- делаем это для перерегистрации команд
		sampRegisterChatCommand(cmd, function(params) -- регистрируем команду + задаем функцию
			globalcmd = lua_thread.create(function() -- поток гасим в переменную, чтобы потом я мог стопить бинды, но что-то пошло не так и они обратно не запускались ;D
				if not keystatus then -- проверяем, не активен ли сейчас иной бинд
					cmdparams = params -- задаем параметры тэгам
					if text:find("{param") and cmdparams == '' then -- если в тексте бинда есть намек на тэг параметра и параметр пуст, говорим заполнить его
						local partype = '' -- объявим локальную переменную
						if text:find("ByID}") then partype = "ID" else partype = "Параметр" end -- зададим ей значение из условия
						sampAddChatMessage("[Mono Tools]{FFFFFF} Используйте: /"..cmd.." ["..partype.."].", 0x046D63)
					else
						keystatus = true
						local strings = split(text, '~', false) -- обрабатываем текст бинда
						for i, g in ipairs(strings) do -- начинаем непосредественный вывод текста по строкам
							if not g:find("{bwait:") then sampSendChat(tags(tostring(g))) end
							wait(g:match("%{bwait:(%d+)%}"))
						end
						keystatus = false
						cmdparams = nil -- обнуляем параметры после использования
					end
				end
			end)
		end)
	else
		globalkey = lua_thread.create(function()
			if text:find("{params}") then
				sampAddChatMessage("[Mono Tools]{FFFFFF} В данном бинде установлен параметр, использование клавишами невозможно.", 0x046D63)
			else

				local strings = split(text, '~', false)
				keystatus = true
				for i, g in ipairs(strings) do
					if not g:find("{bwait:") then sampSendChat(tags(tostring(g))) end
					wait(g:match("%{bwait:(%d+)%}"))
				end
				keystatus = false
			end
		end)
	end
end

function split(str, delim, plain)
    local tokens, pos, plain = {}, 1, not (plain == false) 
    repeat
        local npos, epos = string.find(str, delim, pos, plain)
        table.insert(tokens, string.sub(str, pos, npos and npos - 1))
        pos = epos and epos + 1
    until not pos
    return tokens
end

function showHelp(param) -- "вопросик" для скрипта
    imgui.TextDisabled('(?)')
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(imgui.GetFontSize() * 35.0)
        imgui.TextUnformatted(param)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

function onWindowMessage(m, p)
    if not sampIsChatInputActive() and p == 0x1B and win_state['main'].v then
        consumeWindowMessage()
        win_state['main'].v = false
		win_state['settings'].v = false
		win_state['yashiki'].v = false
		win_state['gamer'].v = false
		win_state['games'].v = false
		win_state['redak'].v = false
		win_state['shema'].v = false
		win_state['shematext'].v = false
		win_state['shemainst'].v = false
		pong = false
		snaketaken = false
		win_state['bank'].v = false
		win_state['help'].v = false
    end
end

function all_trim(s)
   return s:match( "^%s*(.-)%s*$" )
end

function ClearChat() -- очистка чата
    memory.fill(sampGetChatInfoPtr() + 306, 0x0, 25200)
    memory.write(sampGetChatInfoPtr() + 306, 25562, 4, 0x0)
    memory.write(sampGetChatInfoPtr() + 0x63DA, 1, 1)
end

function locationPos() -- получение квадрата игрока
	if not workpause then
		if interior == 0 then
			local KV = {
				[1] = "А",
				[2] = "Б",
				[3] = "В",
				[4] = "Г",
				[5] = "Д",
				[6] = "Ж",
				[7] = "З",
				[8] = "И",
				[9] = "К",
				[10] = "Л",
				[11] = "М",
				[12] = "Н",
				[13] = "О",
				[14] = "П",
				[15] = "Р",
				[16] = "С",
				[17] = "Т",
				[18] = "У",
				[19] = "Ф",
				[20] = "Х",
				[21] = "Ц",
				[22] = "Ч",
				[23] = "Ш",
				[24] = "Я",
			}
			local X, Y, Z = getCharCoordinates(PLAYER_PED)
			X = math.ceil((X + 3000) / 250)
			Y = math.ceil((Y * - 1 + 3000) / 250)
			Y = KV[Y]
			if Y ~= nil then
				KVX = (Y.."-"..X)
				if getActiveInterior() == 0 then BOL = KVX end
				if getActiveInterior() == 0 then cX, cY, cZ = getCharCoordinates(PLAYER_PED) cX = math.ceil(cX) cY = math.ceil(cY) cZ = math.ceil(cZ) end
				return KVX
			else
				KVX = ("ZERO -"..X)
				if getActiveInterior() == 0 then BOL = KVX end
				if getActiveInterior() == 0 then cX, cY, cZ = getCharCoordinates(PLAYER_PED) cX = math.ceil(cX) cY = math.ceil(cY) cZ = math.ceil(cZ) end
				return KVX
			end
		else
			return "N/A"
		end
	end
end

function ARGBtoRGB(color) return bit32 or require'bit'.band(color, 0xFFFFFF) end -- конверт цветов

function rel() -- перезагрузка скрипта
	sampAddChatMessage("[Mono Tools]{FFFFFF} Скрипт перезагружается.", 0x046D63)
	reloadScript = true
	thisScript():reload()
end

function clearSeleListBool(var)
	for i = 1, #SeleList do
		SeleListBool[i].v = false
	end
	SeleListBool[var].v = true
end

function cmd_color()
	local text, prefix, color, pcolor = sampGetChatString(99)
	sampAddChatMessage(string.format("Цвет последней строки чата - {934054}[%d] (скопирован в буфер обмена)",color),-1)
	setClipboardText(color)
end

function changeSkin(id, skinId)
    bs = raknetNewBitStream()
    if id == -1 then _, id = sampGetPlayerIdByCharHandle(PLAYER_PED) end
    raknetBitStreamWriteInt32(bs, id)
    raknetBitStreamWriteInt32(bs, skinId)
    raknetEmulRpcReceiveBitStream(153, bs)
    raknetDeleteBitStream(bs)
end

function sampev.onSendPlayerSync(data)
	if workpause then -- костыль для работы скрипта при свернутой игре
		return false
	end
end

function fixprice()
	lua_thread.create(function()
		wait(15000)
		thisScript():reload()
		end)
	end
	
function fixpricecopia()
	lua_thread.create(function()
		wait(10000)
		sampSendChat("/mm")
		wait(500)
		setVirtualKeyDown(VK_ESCAPE, true)
		wait(40)
		setVirtualKeyDown(VK_ESCAPE, false)
		end)
	end

function sampev.onServerMessage(color, text)
	if color == 1721355519 and text:match("%[F%] .*") then -- получение ранга и ID игрока, который последним написал в /f чат, для тэгов биндера
		lastfradiozv, lastfradioID = text:match('%[F%]%s(.+)%s%a+_%a+%[(%d+)%]: .+')
	elseif color == 869033727 and text:match("%[R%] .*") then -- получение ранга и ID игрока, который последним написал в /r чат, для тэгов биндера
		lastrradiozv, lastrradioID = text:match('%[R%]%s(.+)%s%a+_%a+%[(%d+)%]: .+')
	elseif text:match("Банковский чек") and autopay.v then
		sendchot6()
	elseif text:match("Этот транспорт зарегистрирован") and lock.v then
		sampSendChat('/lock')
	elseif text:find("Вам был добавлен предмет") then
		krytim = true
	elseif text:find('%[Подсказка%] %{FFFFFF%}Вы получили +(.+)%$!') then
		krytim = true
	end
	if text:match("Добро пожаловать на Arizona Role Play!") and yashik.v then
		fixprice()
	end
	if text:match("Добро пожаловать на Arizona Role Play!") and yashik1.v then
		fixprice()
	end
	if text:match("Добро пожаловать на Arizona Role Play!") and yashik2.v then
		fixprice()
	end
	if text:match("Добро пожаловать на Arizona Role Play!") and yashik3.v then
		fixprice()
	end
	if text:match("Добро пожаловать на Arizona Role Play!") and mvdhelp.v then
		fixpricecopia()
	end
	if text:match("Дружище, я обменяю тебе шкатулку, только если ты принесешь 20 подарков!") and podarki.v then
		podarki.v = false
	end
	if text:match("У тебя недостаточно гражданских талонов!") and platina.v then
		platina.v = false
	end
	if text:match("Вам был добавлен предмет 'Сертификат") or text:match("Вам был добавлен предмет 'Золото'. Чтобы открыть инвентарь используйте клавишу 'Y' или /invent") or text:match("Вам был добавлен предмет 'Серебро'. Чтобы открыть инвентарь используйте клавишу 'Y' или /invent") and checked_test.v then
		checked_test.v = false
	end
	if text:find('Увы, вам не удалось улучшить предмет') and checked_box.v then
		checktochilki = true
		inventory()
	end
	if text:find('Успех! Вам удалось улучшить предмет') and checked_box.v then
		number = string.match(text, 'на ++(%d+)')+0
		if number < checked_radio.v and checked_box.v then
			checktochilki = true
			inventory()
	end
end
	if text:find('Увы, вам не удалось улучшить предмет') and checked_box2.v then
		checktochilki1 = true
		inventory()
	end
	if text:find('Успех! Вам удалось улучшить предмет') and checked_box2.v then
		number = string.match(text, 'на ++(%d+)')+0
		if number < checked_radio.v and checked_box2.v then
			checktochilki1 = true
			inventory()
	end
end
	if text:find('Увы, вам не удалось улучшить предмет') and checked_box3.v then
		checktochilki2 = true
		inventory()
	end
	if text:find('Успех! Вам удалось улучшить предмет') and checked_box3.v then
		number = string.match(text, 'на ++(%d+)')+0
		if number < checked_radio.v and checked_box3.v then
		checktochilki2 = true
		inventory()
		end
	end
	if text:find("Игрок находится") then
			notf.addNotification("Цель укрывается в здании.", 3, 3)
			return false
	end
	if text:find("отмечено на карте красным маркером!") then
			notf.addNotification("Цель обнаружена! Она отмечена на карте красным маркером.", 3, 2)
			return false
	end
	if text:find("Увы, вам не удалось улучшить предмет") then
			notf.addNotification("Вам не удалось улучшить скин или аксессуар, попробуйте еще раз!", 3, 3)
			return false
	end
	if text:find("Успех! Вам удалось улучшить предмет") then
			notf.addNotification("Вам удалось улучшить скин или аксессуар, поздравляем!", 3, 2)
			return false
	end
	if text:find("Технический рестарт через 02 минут. Советуем завершить текущую сессию") and recongen.v then
		recongeniusis()
	end
	if text:find("Сработала защита от реконнекта! Попробуйте переподключиться через") and recongen.v then
		recongenmenu()
	end
	if toch.v then
		text = separator(text)
		return {color, text}
	end
end

function sampev.onCreate3DText(id, color, position, distance, testLOS, attachedPlayerId, attachedVehicleId, text)
	if toch.v then
		text = separator(text)
		return {id, color, position, distance, testLOS, attachedPlayerId, attachedVehicleId, text}
	end
end

function sampGetPlayerIdByNickname(nick)
  nick = tostring(nick)
  local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
  if nick == sampGetPlayerNickname(myid) then return myid end
  for i = 0, 1003 do
    if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == nick then
      return i
    end
  end
end

function autoupdate(json_url, prefix, url)
  local dlstatus = require('moonloader').download_status
  local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
  if doesFileExist(json) then os.remove(json) end
  downloadUrlToFile(json_url, json,
    function(id, status, p1, p2)
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
          local f = io.open(json, 'r')
          if f then
            local info = decodeJson(f:read('*a'))
            updatelink = info.updateurl
            updateversion = info.latest
            f:close()
            os.remove(json)
            if updateversion ~= thisScript().version then
              lua_thread.create(function(prefix)
                local dlstatus = require('moonloader').download_status
                local color = -1
                sampAddChatMessage(('[Mono Tools]{FFFFFF} Доступно новое обновление! Пытаюсь обновиться c '..thisScript().version..' на '..updateversion), 0x046D63)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      sampAddChatMessage(('[Mono Tools]{FFFFFF} Скрипт успешно обновлён.'), 0x046D63)
					  sampAddChatMessage(('[Mono Tools]{FFFFFF} Ознакомиться со всеми обновлениями вы сможете в Меню скрипта - помощь - обновления.'), 0x046D63)
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage(('[Mono Tools]{FFFFFF} Не удалось обновить скрипт! Обратитесь к автору скрипта.'), 0x046D63)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
            end
          end
        else
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end

function load_settings() -- загрузка настроек
	ini = inicfg.load(SET, getGameDirectory()..'\\moonloader\\config\\Mono\\settings.ini')
	
	gangzones = imgui.ImBool(ini.settings.gangzones)
	zones = imgui.ImBool(ini.settings.zones)
	assistant = imgui.ImBool(ini.settings.assistant)
	
	autologin = imgui.ImBool(ini.settings.autologin)
	autopin = imgui.ImBool(ini.settings.autopin)
	autoopl = imgui.ImBool(ini.settings.autoopl)
	autoopl1 = imgui.ImBool(ini.settings.autoopl1)
	autoopl2 = imgui.ImBool(ini.settings.autoopl2)
	autoopl3 = imgui.ImBool(ini.settings.autoopl3)
	autoopl4 = imgui.ImBool(ini.settings.autoopl4)
	autoopl5 = imgui.ImBool(ini.settings.autoopl5)
	autoopl6 = imgui.ImBool(ini.settings.autoopl6)
	autopay = imgui.ImBool(ini.settings.autopay)
	lock = imgui.ImBool(ini.settings.lock)
	autopass = imgui.ImBuffer(u8(ini.settings.autopass), 256)
	autopasspay = imgui.ImBuffer(u8(ini.settings.autopasspay), 256)
	autopasspaypin = imgui.ImBuffer(u8(ini.settings.autopasspaypin), 256)
	autopasspin = imgui.ImBuffer(u8(ini.settings.autopasspin), 256)
	zadervka = imgui.ImBuffer(u8(ini.settings.zadervka), 256)
	zadervkav2 = imgui.ImBuffer(u8(ini.settings.zadervkav2), 256)
	autopassopl = imgui.ImBuffer(u8(ini.settings.autopassopl), 256)
	autopassopl1 = imgui.ImBuffer(u8(ini.settings.autopassopl1), 256)
	autopassopl2 = imgui.ImBuffer(u8(ini.settings.autopassopl2), 256)
	autopassopl3 = imgui.ImBuffer(u8(ini.settings.autopassopl3), 256)
	autoklava = imgui.ImBuffer(u8(ini.settings.autoklava), 256)
	autoklavareload = imgui.ImBuffer(u8(ini.settings.autoklavareload), 256)
	shematext1 = imgui.ImBuffer(u8(ini.settings.shematext1), 256)
	shematext2 = imgui.ImBuffer(u8(ini.settings.shematext2), 256)
	shematext3 = imgui.ImBuffer(u8(ini.settings.shematext3), 256)
	shematext4 = imgui.ImBuffer(u8(ini.settings.shematext4), 256)
	shematext5 = imgui.ImBuffer(u8(ini.settings.shematext5), 256)
	shematext6 = imgui.ImBuffer(u8(ini.settings.shematext6), 256)
	shematext7 = imgui.ImBuffer(u8(ini.settings.shematext7), 256)
	shematext8 = imgui.ImBuffer(u8(ini.settings.shematext8), 256)
	shematext9 = imgui.ImBuffer(u8(ini.settings.shematext9), 256)
	shematext10 = imgui.ImBuffer(u8(ini.settings.shematext10), 256)
	shematext11 = imgui.ImBuffer(u8(ini.settings.shematext11), 256)
	shematext12 = imgui.ImBuffer(u8(ini.settings.shematext12), 256)
	shematext13 = imgui.ImBuffer(u8(ini.settings.shematext13), 256)
	shematext14 = imgui.ImBuffer(u8(ini.settings.shematext14), 256)
	shematext15 = imgui.ImBuffer(u8(ini.settings.shematext15), 256)
	shematext16 = imgui.ImBuffer(u8(ini.settings.shematext16), 256)
	shematext17 = imgui.ImBuffer(u8(ini.settings.shematext17), 256)
	shematext18 = imgui.ImBuffer(u8(ini.settings.shematext18), 256)
	shematext19 = imgui.ImBuffer(u8(ini.settings.shematext19), 256)
	shematext20 = imgui.ImBuffer(u8(ini.settings.shematext20), 256)
	shematext21 = imgui.ImBuffer(u8(ini.settings.shematext21), 256)
	shematext22 = imgui.ImBuffer(u8(ini.settings.shematext22), 256)
	shematext23 = imgui.ImBuffer(u8(ini.settings.shematext23), 256)
	shematext24 = imgui.ImBuffer(u8(ini.settings.shematext24), 256)
	shematext25 = imgui.ImBuffer(u8(ini.settings.shematext25), 256)
	shematext26 = imgui.ImBuffer(u8(ini.settings.shematext26), 256)
	shematext27 = imgui.ImBuffer(u8(ini.settings.shematext27), 256)
	shematext28 = imgui.ImBuffer(u8(ini.settings.shematext28), 256)
	shematext29 = imgui.ImBuffer(u8(ini.settings.shematext29), 256)
	shematext30 = imgui.ImBuffer(u8(ini.settings.shematext30), 256)
	shematext31 = imgui.ImBuffer(u8(ini.settings.shematext31), 256)
	shematext32 = imgui.ImBuffer(u8(ini.settings.shematext32), 256)
	shematext33 = imgui.ImBuffer(u8(ini.settings.shematext33), 256)
	shematext34 = imgui.ImBuffer(u8(ini.settings.shematext34), 256)
	shematext35 = imgui.ImBuffer(u8(ini.settings.shematext35), 256)
	shematext36 = imgui.ImBuffer(u8(ini.settings.shematext36), 256)
	activator = imgui.ImBuffer(u8(ini.settings.activator), 256)
	deagleone = imgui.ImBuffer(u8(ini.settings.deagleone), 256)
	deagletwo = imgui.ImBuffer(u8(ini.settings.deagletwo), 256)
	awpone = imgui.ImBuffer(u8(ini.settings.awpone), 256)
	awptwo = imgui.ImBuffer(u8(ini.settings.awptwo), 256)
	m4one = imgui.ImBuffer(u8(ini.settings.m4one), 256)
	m4two = imgui.ImBuffer(u8(ini.settings.m4two), 256)
	uzione = imgui.ImBuffer(u8(ini.settings.uzione), 256)
	uzitwo = imgui.ImBuffer(u8(ini.settings.uzitwo), 256)
	ak47one = imgui.ImBuffer(u8(ini.settings.ak47one), 256)
	ak47two = imgui.ImBuffer(u8(ini.settings.ak47two), 256)
	tazerone = imgui.ImBuffer(u8(ini.settings.tazerone), 256)
	tazertwo = imgui.ImBuffer(u8(ini.settings.tazertwo), 256)
	ybralone = imgui.ImBuffer(u8(ini.settings.ybralone), 256)
	mp5one = imgui.ImBuffer(u8(ini.settings.mp5one), 256)
	mp5two = imgui.ImBuffer(u8(ini.settings.mp5two), 256)
	shotgunone = imgui.ImBuffer(u8(ini.settings.shotgunone), 256)
	shotguntwo = imgui.ImBuffer(u8(ini.settings.shotguntwo), 256)
	rifleone = imgui.ImBuffer(u8(ini.settings.rifleone), 256)
	rifletwo = imgui.ImBuffer(u8(ini.settings.rifletwo), 256)
	knifeone = imgui.ImBuffer(u8(ini.settings.knifeone), 256)
	knifetwo = imgui.ImBuffer(u8(ini.settings.knifetwo), 256)
	timefix = imgui.ImInt(ini.settings.timefix)
	localskin = imgui.ImInt(ini.settings.skin)
	enableskin = imgui.ImBool(ini.settings.enableskin)
	otgun = imgui.ImBool(ini.settings.otgun)

	infHP = imgui.ImBool(ini.informer.hp)
	infArmour = imgui.ImBool(ini.informer.armour)
	infCity = imgui.ImBool(ini.informer.city)
	infKv = imgui.ImBool(ini.informer.kv)
	infTime = imgui.ImBool(ini.informer.time)
	infRajon = imgui.ImBool(ini.informer.rajon)
	inffps = imgui.ImBool(ini.informer.fps)
	infonline = imgui.ImBool(ini.informer.online)
	infping = imgui.ImBool(ini.informer.ping)
	infhpcar = imgui.ImBool(ini.informer.hpcar)

	keyT = imgui.ImBool(ini.settings.keyT)
	launcher = imgui.ImBool(ini.settings.launcher)
	deagle = imgui.ImBool(ini.settings.deagle)
	awp = imgui.ImBool(ini.settings.awp)
	m4 = imgui.ImBool(ini.settings.m4)
	uzi = imgui.ImBool(ini.settings.uzi)
	ak47 = imgui.ImBool(ini.settings.ak47)
	tazer = imgui.ImBool(ini.settings.tazer)
	ybral = imgui.ImBool(ini.settings.ybral)
	mp5 = imgui.ImBool(ini.settings.mp5)
	shotgun = imgui.ImBool(ini.settings.shotgun)
	rifle = imgui.ImBool(ini.settings.rifle)
	knife = imgui.ImBool(ini.settings.knife)
	launcherpc = imgui.ImBool(ini.settings.launcherpc)
	launcherm = imgui.ImBool(ini.settings.launcherm)
	eat = imgui.ImBool(ini.settings.eat)
	eathouse = imgui.ImBool(ini.settings.eathouse)
	eatmyso = imgui.ImBool(ini.settings.eatmyso)
	mvdhelp = imgui.ImBool(ini.settings.mvdhelp)
	chatcalc = imgui.ImBool(ini.settings.chatcalc)
	yashik = imgui.ImBool(ini.settings.yashik)
	yashik1 = imgui.ImBool(ini.settings.yashik1)
	yashik2 = imgui.ImBool(ini.settings.yashik2)
	yashik3 = imgui.ImBool(ini.settings.yashik3)
	ndr = imgui.ImBool(ini.settings.ndr)
	toch = imgui.ImBool(ini.settings.toch)
	klava = imgui.ImBool(ini.settings.klava)
	autobike = imgui.ImBool(ini.settings.autobike)
	styletest = imgui.ImBool(ini.settings.styletest)
	styletest1 = imgui.ImBool(ini.settings.styletest1)
	styletest2 = imgui.ImBool(ini.settings.styletest2)
	styletest3 = imgui.ImBool(ini.settings.styletest3)
	styletest4 = imgui.ImBool(ini.settings.styletest4)
	styletest5 = imgui.ImBool(ini.settings.styletest5)
	chatInfo = imgui.ImBool(ini.settings.chatInfo)
	raskladka = imgui.ImBool(ini.settings.raskladka)
	recongen = imgui.ImBool(ini.settings.recongen)
	carsis = imgui.ImBool(ini.settings.carsis)
	timecout = imgui.ImBool(ini.settings.timecout)
	rtag = imgui.ImBuffer(u8(ini.settings.tag), 256)
	enable_tag = imgui.ImBool(ini.settings.enable_tag)
	
	spOtr = imgui.ImBuffer(u8(ini.settings.spOtr), 256)
	infoX = ini.settings.infoX
	infoY = ini.settings.infoY
	infoX2 = ini.settings.infoX2
	infoY2 = ini.settings.infoY2
	findX = ini.settings.findX
	findY = ini.settings.findY
	asX = ini.assistant.asX
	asY = ini.assistant.asY
end

function showInputHelp()
	while true do
		local chat = sampIsChatInputActive()
		if chat == true then
			local in1 = getStructElement(sampGetInputInfoPtr(), 0x8, 4)
			local in2 = getStructElement(in1, 0x8, 4)
			local in3 = getStructElement(in1, 0xC, 4)
			fib = in3 + 48
			fib2 = in2 + 10
			local _, mmyID = sampGetPlayerIdByCharHandle(PLAYER_PED)
			local nname = sampGetPlayerNickname(mmyID)
			local score = sampGetPlayerScore(mmyID)
			local color = sampGetPlayerColor(mmyID)
			local capsState = ffi.C.GetKeyState(20)
			local success = ffi.C.GetKeyboardLayoutNameA(KeyboardLayoutName)
			local errorCode = ffi.C.GetLocaleInfoA(tonumber(ffi.string(KeyboardLayoutName), 16), 0x00000002, LocalInfo, BuffSize)
			local localName = ffi.string(LocalInfo)
			local text = string.format(
				"%s :: {%0.6x}%s[%d] {ffffff}:: Капс: %s {FFFFFF}:: Язык: {ffeeaa}%s{ffffff}",
				os.date("%H:%M:%S"), bit.band(color,0xffffff), nname, mmyID, getStrByState(capsState), string.match(localName, "([^%(]*)")
			)
			
			if chatInfo.v and sampIsLocalPlayerSpawned() and nname ~= nil then renderFontDrawText(inputHelpText, text, fib2, fib, 0xD7FFFFFF) end
			end
		wait(0)
	end
end

function translite(text)
	for k, v in pairs(chars) do
		text = string.gsub(text, k, v)
	end
	return text
end

function inputChat()
	while true do
		if(sampIsChatInputActive())then
			local getInput = sampGetChatInputText()
			if(oldText ~= getInput and #getInput > 0)then
				local firstChar = string.sub(getInput, 1, 1)
				if(firstChar == "." or firstChar == "/")then
					local cmd, text = string.match(getInput, "^([^ ]+)(.*)")
					local nText = "/" .. translite(string.sub(cmd, 2)) .. text
					local chatInfoPtr = sampGetInputInfoPtr()
					local chatBoxInfo = getStructElement(chatInfoPtr, 0x8, 4)
					local lastPos = memory.getint8(chatBoxInfo + 0x11E)
					sampSetChatInputText(nText)
					memory.setint8(chatBoxInfo + 0x11E, lastPos)
					memory.setint8(chatBoxInfo + 0x119, lastPos)
					oldText = nText
				end
			end
		end
		wait(0)
	end
end

function snakegaming()
	while true do
	wait(0)
	updatesnake()
    rendersnake()
	end
end

function ponggame()
	local font = renderCreateFont('Arial', 10, 5)
	local score_font = renderCreateFont('Arial', 40, 1)
	while true do 
		if pong then
			showCursor(true)
			local mX, mY = getCursorPos()
			local x, y = convertGameScreenCoordsToWindowScreenCoords(100, 120)
			local X, Y = getScreenResolution()
			ball_size = Y/90
			player_size = {X/110, Y/15}
			X, Y = X/1.5, Y/1.9
			if state == 1 then
				math.randomseed(os.time())
				ball[1] = ball[1] + vec[1]
				ball[2] = ball[2] + vec[2]
				--Ауты
				game_speed = math.floor((bot_score + player_score) / 5) > 0 and math.floor((bot_score + player_score) / 5) or 1
				game_speed = game_speed > dif * 2 and dif * 2 or game_speed
				vec[1] = vec[1] < 0 and -game_speed*2 or game_speed*2
				if ball[1] >= (x+X) - player_size[1] - ball_size then
					bot_score = bot_score + 1
					ball = {(x*2+X)/2-ball_size, (y*2+Y+2)/2-ball_size}
					vec[1] = math.random(-4,1) < 0 and vec[1] * -1 or vec[1]
					vec[2] = math.random(-4,1) < 0 and vec[2] * -1 or vec[2]
					addOneOffSound(_, _, _, 1053)
				end
				if ball[1] <= x + player_size[1] then
					player_score = player_score + 1
					ball = {(x*2+X)/2-ball_size, (y*2+Y+2)/2-ball_size}
					vec[1] = math.random(-4,1) < 0 and vec[1] * -1 or vec[1]
					vec[2] = math.random(-4,1) < 0 and vec[2] * -1 or vec[2]
					addOneOffSound(_, _, _, 1052)
				end
				--Стены
				if ball[2] <= y+4 then
					vec[2] = vec[2] * -1
					addOneOffSound(_, _, _, 1137)
				end
				if ball[2] >= (y+Y) -4 - ball_size then
					vec[2] = vec[2] * -1
					addOneOffSound(_, _, _, 1137)
				end
				--Ракетки
				if ball[1] > player[1] - ball_size and ball[2] <= player[2] + player_size[2] and ball[2] >= player[2] - ball_size then
					local delta = math.random(20, 40)
					vec[1] = math.random(-15, 15) < 0 and vec[1] * - delta/10 or vec[1] * - 1
					print(vec[1])
					ball[1] = ball[1] - 10
					addOneOffSound(_, _, _, 1137)
				end 
				if ball[1] < bot[1] + player_size[1] and ball[2] <= bot[2] + player_size[2] and ball[2] >= bot[2] - ball_size then
					local delta = math.random(10, 25)
					vec[1] = math.random(-15, 10) < 0 and vec[1] * - delta/10 or vec[1] * - 1
					print(vec[1])
					ball[1] = ball[1] + 10
					addOneOffSound(_, _, _, 1137)
				end
				bot_brain = coerce(bot_brain + math.random(-1, 1), -10, 10)
				local delta = ball[2] - bot[2] + bot_brain
				if delta > 0 then delta = math.max(delta-10, 0) end
				if delta < 0 then delta = math.min(delta+10, 0) end
				delta = coerce(delta, -game_speed, game_speed)
				bot[2] = coerce(bot[2] + delta, 20 + player_size[2]/2, X+x-player_size[2]/2) + player_size[2] < y+Y-4 and coerce(bot[2] + delta, 20 + player_size[2]/2, X+x-player_size[2]/2) or bot[2]
			elseif state == 0 then
				ball = {(x*2+X-ball_size)/2, (y*2+Y-ball_size)/2}
				player = {X+x-player_size[1]*2, (y*2+Y-player_size[2])/2}
				bot = {x+player_size[1], (y*2+Y-player_size[2])/2}
			end
			if not sampIsChatInputActive() and isKeyDown(38) and player[2] > y + 4 then -- up
				player[2] = player[2] - 2*game_speed
			end
			if not sampIsChatInputActive() and isKeyDown(40) and player[2] + player_size[2] < y+Y-4 then -- down
				player[2] = player[2] + 2*game_speed
			end
			renderDrawBoxWithBorder(x, y, X, Y, 0xFF323232, 4, 0xFF232323)
			renderDrawLine((x*2+X)/2+4, y, (x*2+X)/2+4, y+Y, 5, 0xFF232323)
			renderFontDrawText(score_font, tostring(bot_score), x+x/1.2, (y+Y)/2.8, 0xFF232323)
			renderFontDrawText(score_font, tostring(player_score), (x+X)/1.3, (y+Y)/2.8, 0xFF232323)
			renderDrawBox(ball[1], ball[2], ball_size, ball_size, -1)
			renderDrawBox(player[1], player[2], player_size[1], player_size[2], 0xFF15eb83)
			renderDrawBox(bot[1], bot[2], player_size[1], player_size[2], -1)
			renderDrawBox(x, y-25, X, 25, 0xFF242424)
			if renderDrawButton(font, 'Start', x, y-25, 60, 29, mX, mY, 0xFF0bb563, 0xFF0afa86, -1, -1) then state = 1 end
			if renderDrawButton(font, (state == 2 and 'Resume' or 'Pause'), x+60, y-25, 60, 29, mX, mY, 0xFF0bb563, 0xFF0afa86, -1, -1) then state = state == 2 and 1 or 2 end
			if renderDrawButton(font, 'Difficulty: '..dif, x+120, y-25, 90, 29, mX, mY, dif_colors[dif], dif_colors[dif], -1, -1) then 
				dif = dif == 4 and 1 or dif + 1
				bot_brain = dif * 5
				state = 0
				bot_score = 0
				player_score = 0
			end
			if renderDrawButton(font, 'New Game', x+210, y-25, 100, 29, mX, mY, 0xFF0bb563, 0xFF0afa86, -1, -1) then 
				state = 0
				bot_score = 0
				player_score = 0
			end
			renderDrawBoxWithBorder(x+310, y-25, 80, 29, 0xFF323232, 4, 0xFF242424)
			renderFontDrawText(font, 'Speed: '..game_speed, x+310+(80-renderGetFontDrawTextLength(font, 'Speed: '..game_speed))/2, y-25+(29-renderGetFontDrawHeight(font))/2, -1)
			if renderDrawButton(font, 'X', x+X-32, y-25, 30, 29, mX, mY, 0xFF0bb563, 0xFF0afa86, -1, -1) then 
				pong = false 
				showCursor(false, false) 
			end
			if state == 2 then
				renderDrawBox((x*2+X-(X/3))/2, (y*2+Y-(X/3))/2, X/3, X/3, 0xFF232323)
				renderDrawBox((x*2+X-(X/3)+(X/10))/2, (y*2+Y-(X/3)+(X/10))/2, X/6-(X/10), X/3-(X/10), -1)
				renderDrawBox((x*2+X+(X/10))/2, (y*2+Y-(X/3)+(X/10))/2, X/6-(X/10), X/3-(X/10), -1)
			end
		end
	wait(0)
	end
end

function rpgunsin()
while true do 
		if lastgun ~= getCurrentCharWeapon(PLAYER_PED) then
            local gun = getCurrentCharWeapon(PLAYER_PED)
			if otgun.v then
			if isKeyJustPressed(key.VK_RBUTTON) and gun == 24 and deagle.v then
                sampSendChat(u8:decode (deagleone.v))
				wait(1500)
				sampSendChat(u8:decode (deagletwo.v))
            elseif isKeyJustPressed(key.VK_RBUTTON) and gun == 31 and m4.v then
                sampSendChat(u8:decode (m4one.v))
				wait(1500)
				sampSendChat(u8:decode (m4two.v))
			elseif isKeyJustPressed(key.VK_RBUTTON) and gun == 34 and awp.v then
                sampSendChat(u8:decode (awpone.v))
				wait(1500)
				sampSendChat(u8:decode (awptwo.v))
			elseif isKeyJustPressed(key.VK_RBUTTON) and gun == 28 and uzi.v then
                sampSendChat(u8:decode (uzione.v))
				wait(1500)
				sampSendChat(u8:decode (uzitwo.v))
			elseif isKeyJustPressed(key.VK_RBUTTON) and gun == 30 and ak47.v then
                sampSendChat(u8:decode (ak47one.v))
				wait(1500)
				sampSendChat(u8:decode (ak47two.v))
			elseif isKeyJustPressed(key.VK_RBUTTON) and gun == 29 and mp5.v then
                sampSendChat(u8:decode (mp5one.v))
				wait(1500)
				sampSendChat(u8:decode (mp5two.v))
			elseif isKeyJustPressed(key.VK_RBUTTON) and gun == 25 and shotgun.v then
                sampSendChat(u8:decode (shotgunone.v))
				wait(1500)
				sampSendChat(u8:decode (shotguntwo.v))
			elseif isKeyJustPressed(key.VK_RBUTTON) and gun == 33 and rifle.v then
                sampSendChat(u8:decode (rifleone.v))
				wait(1500)
				sampSendChat(u8:decode (rifletwo.v))
			elseif isKeyJustPressed(key.VK_RBUTTON) and gun == 4 and knife.v then
                sampSendChat(u8:decode (knifeone.v))
				wait(1500)
				sampSendChat(u8:decode (knifetwo.v))
			elseif isKeyJustPressed(key.VK_RBUTTON) and gun == 23 and tazer.v then
                sampSendChat(u8:decode (tazerone.v))
				wait(1500)
				sampSendChat(u8:decode (tazertwo.v))
			elseif isKeyJustPressed(key.VK_RBUTTON) and gun == 0 and ybral.v then
                sampSendChat(u8:decode (ybralone.v))
			end
			else
            if gun == 24 and deagle.v then
                sampSendChat(u8:decode (deagleone.v))
				wait(1500)
				sampSendChat(u8:decode (deagletwo.v))
            elseif gun == 31 and m4.v then
                sampSendChat(u8:decode (m4one.v))
				wait(1500)
				sampSendChat(u8:decode (m4two.v))
			elseif gun == 34 and awp.v then
                sampSendChat(u8:decode (awpone.v))
				wait(1500)
				sampSendChat(u8:decode (awptwo.v))
			elseif gun == 28 and uzi.v then
                sampSendChat(u8:decode (uzione.v))
				wait(1500)
				sampSendChat(u8:decode (uzitwo.v))
			elseif gun == 30 and ak47.v then
                sampSendChat(u8:decode (ak47one.v))
				wait(1500)
				sampSendChat(u8:decode (ak47two.v))
			elseif gun == 29 and mp5.v then
                sampSendChat(u8:decode (mp5one.v))
				wait(1500)
				sampSendChat(u8:decode (mp5two.v))
			elseif gun == 25 and shotgun.v then
                sampSendChat(u8:decode (shotgunone.v))
				wait(1500)
				sampSendChat(u8:decode (shotguntwo.v))
			elseif gun == 33 and rifle.v then
                sampSendChat(u8:decode (rifleone.v))
				wait(1500)
				sampSendChat(u8:decode (rifletwo.v))
			elseif gun == 4 and knife.v then
                sampSendChat(u8:decode (knifeone.v))
				wait(1500)
				sampSendChat(u8:decode (knifetwo.v))
			elseif gun == 23 and tazer.v then
                sampSendChat(u8:decode (tazerone.v))
				wait(1500)
				sampSendChat(u8:decode (tazertwo.v))
			elseif gun == 0 and ybral.v then
                sampSendChat(u8:decode (ybralone.v))
				end
            lastgun = gun
			end
		end
		wait(0)
	end
end

function shemamain()
while true do 
	if video.v then
      active6 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext1.v))
      wait(15000)
	end
	if video1.v then
      active7 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext2.v))
      wait(15000)
	end
	if video2.v then
      active8 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext3.v))
      wait(15000)
	end
	if video3.v then
      active9 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext4.v))
      wait(15000)
	end
	if video4.v then
      active10 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext5.v))
      wait(15000)
	end
	if video5.v then
      active11 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext6.v))
      wait(15000)
	end
	if video6.v then
      active12 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext7.v))
      wait(15000)
	end
	if video7.v then
      active13 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext8.v))
      wait(15000)
	end
	if video8.v then
      active14 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext9.v))
      wait(15000)
	end
	if video9.v then
      active15 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext10.v))
      wait(15000)
	end
	if video10.v then
      active16 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext11.v))
      wait(15000)
	end
	if video11.v then
      active17 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext12.v))
      wait(15000)
	end
	if video12.v then
      active18 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext13.v))
      wait(15000)
	end
	if video13.v then
      active19 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext14.v))
      wait(15000)
	end
	if video14.v then
      active20 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext15.v))
      wait(15000)
	end
	if video15.v then
      active21 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext16.v))
      wait(15000)
	end
	if video16.v then
      active22 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext17.v))
      wait(15000)
	end
	if video17.v then
      active23 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext18.v))
      wait(15000)
	end
	if video18.v then
      active24 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext19.v))
      wait(15000)
	end
	if video19.v then
      active25 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext20.v))
      wait(15000)
	end
	if video20.v then
      active26 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext21.v))
      wait(15000)
	end
	if video21.v then
      active27 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext22.v))
      wait(15000)
	end
	if video22.v then
      active28 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext23.v))
      wait(15000)
	end
	if video23.v then
      active29 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext24.v))
      wait(15000)
	end
	if video24.v then
      active30 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext25.v))
      wait(15000)
	end
	if video25.v then
      active31 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext26.v))
      wait(15000)
	end
	if video26.v then
      active32 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext27.v))
      wait(15000)
	end
	if video27.v then
      active33 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext28.v))
      wait(15000)
	end
	if video28.v then
      active34 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext29.v))
      wait(15000)
	end
	if video29.v then
      active35 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext30.v))
      wait(15000)
	end
	if video30.v then
      active36 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext31.v))
      wait(15000)
	end
	if video31.v then
      active37 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext32.v))
      wait(15000)
	end
	if video32.v then
      active38 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext33.v))
      wait(15000)
	end
	if video33.v then
      active39 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext34.v))
      wait(15000)
	end
	if video34.v then
      active40 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext35.v))
      wait(15000)
	end
	if video35.v then
      active41 = true
      sampSendChat("/invent")
	  wait(200)
	  sampSendClickTextdraw(2108)
	  wait(200)
	  sampSendClickTextdraw(u8:decode(shematext36.v))
      wait(15000)
		end
	wait(0)
	end
end

function roulette()
while true do 
	if checked_test.v and krytim then
      rul()
	  wait(111)
	  closeDialog()
      wait(222)
      sampSendClickTextdraw(2080)
	  wait(1000)
      sampSendClickTextdraw(2091)
      krytim = false
    end
    if checked_test2.v and krytim then
      rul()
	  wait(111)
	  closeDialog()
      wait(222)
      sampSendClickTextdraw(2085)
	  wait(1000)
      sampSendClickTextdraw(2091)
      krytim = false
    end
      if checked_test3.v and krytim then
      rul()
	  wait(111)
	  closeDialog()
      wait(222)
      sampSendClickTextdraw(2090)
	  wait(1000)
      sampSendClickTextdraw(2091)
      krytim = false
    end
    if checked_test4.v and krytim then
      rul()
	  wait(111)
	  closeDialog()
      wait(222)
      sampSendClickTextdraw(2110)
	  wait(1000)
      sampSendClickTextdraw(2091)
      krytim = false
	end
	if checked_test5.v then
	  sampSendClickTextdraw(2110)
	  wait(500)
      active = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
    end
    if checked_test6.v then
	  sampSendClickTextdraw(2110)
	  wait(500)
      active1 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
    end
    if checked_test7.v then
	  sampSendClickTextdraw(2110)
	  wait(500)
      active2 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
	end
	if checked_test8.v then
	  sampSendClickTextdraw(2110)
	  wait(500)
      active3 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
	end
	if checked_test9.v then
	  sampSendClickTextdraw(2110)
	  wait(500)
      active4 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
	end
	if checked_test10.v then
	  sampSendClickTextdraw(2110)
	  wait(500)
      active5 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
	end
	if yashik.v then
	  sampSendClickTextdraw(2110)
	  wait(500)
      active = true
      sampSendChat("/invent")
      wait(zadervkav2.v*60000)
    end
	if yashik1.v then
	  sampSendClickTextdraw(2110)
	  wait(500)
      active1 = true
      sampSendChat("/invent")
      wait(zadervkav2.v*60000)
    end
	if yashik2.v then
	  sampSendClickTextdraw(2110)
	  wait(500)
      active2 = true
      sampSendChat("/invent")
      wait(zadervkav2.v*60000)
    end
	if yashik3.v then
	  sampSendClickTextdraw(2110)
	  wait(500)
      active5 = true
      sampSendChat("/invent")
      wait(zadervkav2.v*60000)
	end
	if podarki.v then 
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(1449, 1 , 3, -1)
	wait(100)
	closeDialog()
	end
	if platina.v then 
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(1449, 1 , 4, -1)
	wait(200)
	sampSendDialogResponse(8672, 1 , 17, -1)
	wait(100)
	closeDialog()
			end
		wait(0)
	end
end

function calculator()
while true do 
	text = sampGetChatInputText()
        if text:find('%d+') and text:find('[-+/*^%%]') and not text:find('%a+') and text ~= nil then
            ok, number = pcall(load('return '..text))
            result = 'Результат: '..number
            if not isKeyDown(0x08) then
            setClipboardText(number)
            end
        end
        if text:find('%d+%%%*%d+') then
            number1, number2 = text:match('(%d+)%%%*(%d+)')
            number = number1*number2/100
            ok, number = pcall(load('return '..number))
            result = 'Результат: '..number
            if not isKeyDown(0x08) and ok then
            setClipboardText(number)
            end
        end
        if text:find('%d+%%%/%d+') then
            number1, number2 = text:match('(%d+)%%%/(%d+)')
            number = number2/number1*100
            ok, number = pcall(load('return '..number))
            result = 'Результат: '..number
            if not isKeyDown(0x08) and ok then
            setClipboardText(number)
            end
        end
        if text:find('%d+/%d+%%') then
            number1, number2 = text:match('(%d+)/(%d+)%%')
            number = number1*100/number2
            ok, number = pcall(load('return '..number))
            result = 'Результат: '..number..'%'
            if not isKeyDown(0x08) and ok then
                setClipboardText(number..'%')
            end
        end
        if text == 'calchelp' then
            help = true
        else
            help = false
        end
        if text == '' then
            ok = false
		end
		wait(0)
	end
end
		
function eating()
while true do 
	if eat.v and eatmyso.v then
		active42 = true
		sampSendChat("/invent")
		wait(1800000)
		end
	if eat.v and eathouse.v then 
		sampSendChat("/house")
		wait(100)
		sampSendDialogResponse(174, 1 , 1, -1)
		wait(100)
		sampSendDialogResponse(2431, 1 , 2, -1)
		wait(100)
		sampSendDialogResponse(185, 1 , 6, -1)
		wait(100)
		closeDialog()
		wait(10800000)
		end
		wait(0)
	end
end

function informerperem()
while true do
if zones.v and not workpause then -- показываем информер и его перемещение
			if not win_state['regst'].v then win_state['informer'].v = true end

			if mouseCoord then
				showCursor(true, true)
				infoX, infoY = getCursorPos()
				if isKeyDown(VK_RETURN) then
					infoX = math.floor(infoX)
					infoY = math.floor(infoY)
					mouseCoord = false
					showCursor(false, false)
					win_state['main'].v = not win_state['main'].v
					win_state['settings'].v = not win_state['settings'].v
				end
			end
		else
			win_state['informer'].v = false
		end

		if assistant.v and developMode == 1 and isPlayerSoldier then -- координатор и его перемещение
			if not win_state['regst'].v then win_state['ass'].v = true end

			if mouseCoord3 then
				showCursor(true, true)
				asX, asY = getCursorPos()
				if isKeyDown(VK_RETURN) then
					asX = math.floor(asX)
					asY = math.floor(asY)
					mouseCoord3 = false
					showCursor(false, false)
				end
			end
		else
			win_state['ass'].v = false
		end
		wait(0)
		end
	end

function getStrByState(keyState) -- состояние клавиш для chatinfo
	if keyState == 0 then
		return "{ffeeaa}Выкл{ffffff}"
	end
	return "{9EC73D}Вкл{ffffff}"
end

function drone()
	lua_thread.create(function()
		if droneActive then
			sampAddChatMessage("[Mono Tools]{FFFFFF} На данный момент вы уже управляете дроном.", 0x046D63)
			return
		end
		sampAddChatMessage("[Mono Tools]{FFFFFF} Управление дроном клавишами: {00C2BB}W, A, S, D, Space, Shift{FFFFFF}.", 0x046D63)
		sampAddChatMessage("[Mono Tools]{FFFFFF} Режимы дрона: {00C2BB}Numpad1, Numpad2, Numpad3{FFFFFF}.", 0x046D63)
		sampAddChatMessage("[Mono Tools]{FFFFFF} Скорость полета дрона: {00C2BB}+(быстрей), -(медленней){FFFFFF}.", 0x046D63)
		sampAddChatMessage("[Mono Tools]{FFFFFF} Заверешить пилотирование дроном можно клавишей {00C2BB}Enter{FFFFFF}.", 0x046D63)
		while true do
			wait(0)
			if flymode == 0 then
				droneActive = true
				posX, posY, posZ = getCharCoordinates(playerPed)
				angZ = getCharHeading(playerPed)
				angZ = angZ * -1.0
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
				angY = 0.0
				flymode = 1
			end
			if flymode == 1 and not sampIsChatInputActive() and not isSampfuncsConsoleActive() then
				offMouX, offMouY = getPcMouseMovement()  
				offMouX = offMouX / 4.0
				offMouY = offMouY / 4.0
				angZ = angZ + offMouX
				angY = angY + offMouY
				
				if angZ > 360.0 then angZ = angZ - 360.0 end
				if angZ < 0.0 then angZ = angZ + 360.0 end
		
				if angY > 89.0 then angY = 89.0 end
				if angY < -89.0  then angY = -89.0 end   

				if isKeyDown(VK_W) then      
					radZ = math.rad(angZ) 
					radY = math.rad(angY)                   
					sinZ = math.sin(radZ)
					cosZ = math.cos(radZ)      
					sinY = math.sin(radY)
					cosY = math.cos(radY)       
					sinZ = sinZ * cosY      
					cosZ = cosZ * cosY 
					sinZ = sinZ * speed      
					cosZ = cosZ * speed       
					sinY = sinY * speed  
					posX = posX + sinZ 
					posY = posY + cosZ 
					posZ = posZ + sinY      
					setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)      
				end 
				
				if isKeyDown(VK_S) then  
					curZ = angZ + 180.0
					curY = angY * -1.0      
					radZ = math.rad(curZ) 
					radY = math.rad(curY)                   
					sinZ = math.sin(radZ)
					cosZ = math.cos(radZ)      
					sinY = math.sin(radY)
					cosY = math.cos(radY)       
					sinZ = sinZ * cosY      
					cosZ = cosZ * cosY 
					sinZ = sinZ * speed      
					cosZ = cosZ * speed       
					sinY = sinY * speed                       
					posX = posX + sinZ 
					posY = posY + cosZ 
					posZ = posZ + sinY      
					setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)      
				end 
				
		
				if isKeyDown(VK_A) then  
					curZ = angZ - 90.0      
					radZ = math.rad(curZ) 
					radY = math.rad(angY)                   
					sinZ = math.sin(radZ)
					cosZ = math.cos(radZ)       
					sinZ = sinZ * speed      
					cosZ = cosZ * speed                             
					posX = posX + sinZ 
					posY = posY + cosZ      
					setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)     
				end 
		
				radZ = math.rad(angZ) 
				radY = math.rad(angY)             
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)      
				sinY = math.sin(radY)
				cosY = math.cos(radY)       
				sinZ = sinZ * cosY      
				cosZ = cosZ * cosY 
				sinZ = sinZ * 1.0      
				cosZ = cosZ * 1.0     
				sinY = sinY * 1.0        
				poiX = posX
				poiY = posY
				poiZ = posZ      
				poiX = poiX + sinZ 
				poiY = poiY + cosZ 
				poiZ = poiZ + sinY      
				pointCameraAtPoint(poiX, poiY, poiZ, 2)       
		
				if isKeyDown(VK_D) then  
					curZ = angZ + 90.0      
					radZ = math.rad(curZ) 
					radY = math.rad(angY)                   
					sinZ = math.sin(radZ)
					cosZ = math.cos(radZ)       
					sinZ = sinZ * speed      
					cosZ = cosZ * speed                             
					posX = posX + sinZ 
					posY = posY + cosZ      
					setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)      
				end 
		
				radZ = math.rad(angZ) 
				radY = math.rad(angY)             
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)      
				sinY = math.sin(radY)
				cosY = math.cos(radY)       
				sinZ = sinZ * cosY      
				cosZ = cosZ * cosY 
				sinZ = sinZ * 1.0      
				cosZ = cosZ * 1.0     
				sinY = sinY * 1.0        
				poiX = posX
				poiY = posY
				poiZ = posZ      
				poiX = poiX + sinZ 
				poiY = poiY + cosZ 
				poiZ = poiZ + sinY      
				pointCameraAtPoint(poiX, poiY, poiZ, 2)   
		
				if isKeyDown(VK_SPACE) then  
					posZ = posZ + speed      
					setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)      
				end 
		
				radZ = math.rad(angZ) 
				radY = math.rad(angY)             
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)      
				sinY = math.sin(radY)
				cosY = math.cos(radY)       
				sinZ = sinZ * cosY      
				cosZ = cosZ * cosY 
				sinZ = sinZ * 1.0      
				cosZ = cosZ * 1.0     
				sinY = sinY * 1.0       
				poiX = posX
				poiY = posY
				poiZ = posZ      
				poiX = poiX + sinZ 
				poiY = poiY + cosZ 
				poiZ = poiZ + sinY      
				pointCameraAtPoint(poiX, poiY, poiZ, 2)
				
				if isKeyDown(VK_SHIFT) then  
					posZ = posZ - speed
					setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)      
				end 
				
				radZ = math.rad(angZ) 
				radY = math.rad(angY)             
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)      
				sinY = math.sin(radY)
				cosY = math.cos(radY)       
				sinZ = sinZ * cosY      
				cosZ = cosZ * cosY 
				sinZ = sinZ * 1.0      
				cosZ = cosZ * 1.0     
				sinY = sinY * 1.0       
				poiX = posX
				poiY = posY
				poiZ = posZ      
				poiX = poiX + sinZ 
				poiY = poiY + cosZ 
				poiZ = poiZ + sinY      
				pointCameraAtPoint(poiX, poiY, poiZ, 2) 
			
				if isKeyDown(187) then 
					speed = speed + 0.01
				end 
				if isKeyDown(189) then
					speed = speed - 0.01
					if speed < 0.01 then speed = 0.01 end
				end
				if isKeyDown(VK_NUMPAD1) then
					setInfraredVision(true)
				end
				if isKeyDown(VK_NUMPAD2) then
					setNightVision(true)
				end
				if isKeyDown(VK_NUMPAD3) then
					setInfraredVision(false)
					setNightVision(false)
				end
				if isKeyDown(VK_RETURN) then
					setInfraredVision(false)
					setNightVision(false)
					restoreCameraJumpcut()
					setCameraBehindPlayer()
					flymode = 0
					droneActive = false
					break
				end
			end
		end
	end)
end

function string.rlower(s)
	s = s:lower()
	local strlen = s:len()
	if strlen == 0 then return s end
	s = s:lower()
	local output = ''
	for i = 1, strlen do
		local ch = s:byte(i)
		if ch >= 192 and ch <= 223 then
			output = output .. russian_characters[ch + 32]
		elseif ch == 168 then
			output = output .. russian_characters[184]
		else
			output = output .. string.char(ch)
		end
	end
	return output
end

function string.rupper(s)
	s = s:upper()
	local strlen = s:len()
	if strlen == 0 then return s end
	s = s:upper()
	local output = ''
	for i = 1, strlen do
		local ch = s:byte(i)
		if ch >= 224 and ch <= 255 then
			output = output .. russian_characters[ch - 32]
		elseif ch == 184 then
			output = output .. russian_characters[168]
		else
			output = output .. string.char(ch)
		end
	end
	return output
end

function imgui.TextColoredRGB(string, max_float)

	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local u8 = require 'encoding'.UTF8

	local function color_imvec4(color)
		if color:upper():sub(1, 6) == 'SSSSSS' then return imgui.ImVec4(colors[clr.Text].x, colors[clr.Text].y, colors[clr.Text].z, tonumber(color:sub(7, 8), 16) and tonumber(color:sub(7, 8), 16)/255 or colors[clr.Text].w) end
		local color = type(color) == 'number' and ('%X'):format(color):upper() or color:upper()
		local rgb = {}
		for i = 1, #color/2 do rgb[#rgb+1] = tonumber(color:sub(2*i-1, 2*i), 16) end
		return imgui.ImVec4(rgb[1]/255, rgb[2]/255, rgb[3]/255, rgb[4] and rgb[4]/255 or colors[clr.Text].w)
	end

	local function render_text(string)
		for w in string:gmatch('[^\r\n]+') do
			local text, color = {}, {}
			local render_text = 1
			local m = 1
			if w:sub(1, 8) == '[center]' then
				render_text = 2
				w = w:sub(9)
			elseif w:sub(1, 7) == '[right]' then
				render_text = 3
				w = w:sub(8)
			end
			w = w:gsub('{(......)}', '{%1FF}')
			while w:find('{........}') do
				local n, k = w:find('{........}')
				if tonumber(w:sub(n+1, k-1), 16) or (w:sub(n+1, k-3):upper() == 'SSSSSS' and tonumber(w:sub(k-2, k-1), 16) or w:sub(k-2, k-1):upper() == 'SS') then
					text[#text], text[#text+1] = w:sub(m, n-1), w:sub(k+1, #w)
					color[#color+1] = color_imvec4(w:sub(n+1, k-1))
					w = w:sub(1, n-1)..w:sub(k+1, #w)
					m = n
				else w = w:sub(1, n-1)..w:sub(n, k-3)..'}'..w:sub(k+1, #w) end
			end
			local length = imgui.CalcTextSize(u8(w))
			if render_text == 2 then
				imgui.NewLine()
				imgui.SameLine(max_float / 2 - ( length.x / 2 ))
			elseif render_text == 3 then
				imgui.NewLine()
				imgui.SameLine(max_float - length.x - 5 )
			end
			if text[0] then
				for i, k in pairs(text) do
					imgui.TextColored(color[i] or colors[clr.Text], u8(k))
					imgui.SameLine(nil, 0)
				end
				imgui.NewLine()
			else imgui.Text(u8(w)) end
		end
	end

	render_text(string)
end

function removeMagicChar(text)
	for i = 1, #magicChar do text = text:gsub(magicChar[i], '') end
	return text
end

function imgui.GetMaxWidthByText(text)
	local max = imgui.GetWindowWidth()
	for w in text:gmatch('[^\r\n]+') do
		local size = imgui.CalcTextSize(w)
		if size.x > max then max = size.x end
	end
	return max - 15
end

function rpredak()
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(835, 445), imgui.Cond.FirstUseEver)
	if imgui.Begin(u8' Редактирование отыгровок', win_state['redak'], imgui.WindowFlags.NoResize) then
			imgui.BeginChild('##asdasasddf', imgui.ImVec2(800, 400), false)
			imgui.Columns(2, _, false)
			imgui.InputText(u8'Desert Eagle /do', deagleone)
			imgui.InputText(u8'Desert Eagle /me', deagletwo)
			imgui.NextColumn()
			imgui.InputText(u8'Винтовка M4 /do', m4one)
			imgui.InputText(u8'Винтовка M4 /me', m4two)
			imgui.Separator()
			imgui.NextColumn()
			imgui.InputText(u8'Sniper /do', awpone)
			imgui.InputText(u8'Sniper /me', awptwo)
			imgui.NextColumn()
			imgui.InputText(u8'Узи /do', uzione)
			imgui.InputText(u8'Узи /me', uzitwo)
			imgui.Separator()
			imgui.NextColumn()
			imgui.InputText(u8'Автомат АК-47 /do', ak47one)
			imgui.InputText(u8'Автомат АК-47 /me', ak47two)
			imgui.NextColumn()
			imgui.InputText(u8'MP5 /do', mp5one)
			imgui.InputText(u8'MP5 /me', mp5two)
			imgui.Separator()
			imgui.NextColumn()
			imgui.InputText(u8'ShotGun /do', shotgunone)
			imgui.InputText(u8'ShotGun /me', shotguntwo)
			imgui.NextColumn()
			imgui.InputText(u8'Rifle /do', rifleone)
			imgui.InputText(u8'Rifle /me', rifletwo)
			imgui.Separator()
			imgui.NextColumn()
			imgui.InputText(u8'Нож /do', knifeone)
			imgui.InputText(u8'Нож /me', knifetwo)
			imgui.NextColumn()
			imgui.InputText(u8'Тайзер /do', tazerone)
			imgui.InputText(u8'Тайзер /me', tazertwo)
			imgui.Separator()
			imgui.NextColumn()
			imgui.InputText(u8'Убрать оружие /me', ybralone)
			imgui.EndChild()
			imgui.End()
		end
	end
	
function shemamenu()
	local sw, sh = getScreenResolution()
	local btn_size12 = imgui.ImVec2(370, 30)
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(782, 275), imgui.Cond.FirstUseEver)
	if imgui.Begin(u8' Редактирование ID Текстдравов', win_state['shematext'], imgui.WindowFlags.NoResize) then
			imgui.BeginChild('##asdasasddf2131', imgui.ImVec2(800, 230), false)
			if imgui.Button(u8' Включить отображение ID Текстдравов', btn_size12) then toggle = true end 
			imgui.SameLine()
			if imgui.Button(u8' Выключить отображение ID Текстдравов', btn_size12) then toggle = false end
			imgui.PushItemWidth(80)
			imgui.InputText(u8'№1', shematext1); imgui.SameLine(125); imgui.InputText(u8'№2', shematext2); imgui.SameLine(250); imgui.InputText(u8'№3', shematext3); imgui.SameLine(375); imgui.InputText(u8'№4', shematext4); imgui.SameLine(500); imgui.InputText(u8'№5', shematext5); imgui.SameLine(625); imgui.InputText(u8'№6', shematext6)
			imgui.InputText(u8'№7', shematext7); imgui.SameLine(125); imgui.InputText(u8'№8', shematext8); imgui.SameLine(250); imgui.InputText(u8'№9', shematext9); imgui.SameLine(375); imgui.InputText(u8'№10', shematext10); imgui.SameLine(); imgui.InputText(u8'№11', shematext11); imgui.SameLine(); imgui.InputText(u8'№12', shematext12)
			imgui.InputText(u8'№13', shematext13); imgui.SameLine(); imgui.InputText(u8'№14', shematext14); imgui.SameLine(); imgui.InputText(u8'№15', shematext15); imgui.SameLine(); imgui.InputText(u8'№16', shematext16); imgui.SameLine(); imgui.InputText(u8'№17', shematext17); imgui.SameLine(); imgui.InputText(u8'№18', shematext18)
			imgui.InputText(u8'№19', shematext19); imgui.SameLine(); imgui.InputText(u8'№20', shematext20); imgui.SameLine(); imgui.InputText(u8'№21', shematext21); imgui.SameLine(); imgui.InputText(u8'№22', shematext22); imgui.SameLine(); imgui.InputText(u8'№23', shematext23); imgui.SameLine(); imgui.InputText(u8'№24', shematext24)
			imgui.InputText(u8'№25', shematext25); imgui.SameLine(); imgui.InputText(u8'№26', shematext26); imgui.SameLine(); imgui.InputText(u8'№27', shematext27); imgui.SameLine(); imgui.InputText(u8'№28', shematext28); imgui.SameLine(); imgui.InputText(u8'№29', shematext29); imgui.SameLine(); imgui.InputText(u8'№30', shematext30)
			imgui.InputText(u8'№31', shematext31); imgui.SameLine(); imgui.InputText(u8'№32', shematext32); imgui.SameLine(); imgui.InputText(u8'№33', shematext33); imgui.SameLine(); imgui.InputText(u8'№34', shematext34); imgui.SameLine(); imgui.InputText(u8'№35', shematext35); imgui.SameLine(); imgui.InputText(u8'№36', shematext36)
			imgui.PopItemWidth()
			imgui.EndChild()
			imgui.End()
		end
	end
	
function shemainstr()
	local sw, sh = getScreenResolution()
	local btn_size12 = imgui.ImVec2(370, 30)
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(850, 250), imgui.Cond.FirstUseEver)
	if imgui.Begin(u8' Инструкция', win_state['shemainst'], imgui.WindowFlags.NoResize) then
			imgui.BeginChild('##asdasasddf2131', imgui.ImVec2(800, 230), false)
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Видеокарты должны быть на второй странице инвентаря и идти по порядку! Т.е в слот №1 ложите видеокарту, следующую ложите в")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"слот №2 и так далее. Чтобы узнать номер слота - смотрите схему. Если вы играете не на Arizona RP Prescott, то зайдите в")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"'Редактирование ID Текстдравов' и исправьте значения на свои. Чтобы узнать ID текстдравов, откройте инвентарь, перейдите на")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"вторую страницу и нажмите на кнопку 'Включить отображение ID Текстдравов'. Чтобы отобразились верные ID текстдравов, у вас")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"на второй странице должны лежать видеокарты, начиная от слота №1 и так по порядку. Выключить отображение ID текстдравов вы")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"можете, нажав на 'Выключить отображение ID Текстдравов'. Также помните, что ID текстдравов могут измениться из-за телефона,")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"поэтому, если доставали телефон, то лучше перезайти в игру. Чтобы прервать процесс улучшения - уберите галочки с 'Улучшение'")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"видеокарт №*' или перезагрузите скрипт через клавишу или /reload. После завершения улучшения видеокарт, рекомендую")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"перезагрузить скрипт.")
			imgui.EndChild()
			imgui.End()
		end
	end

function rpguns()
	local btn_size12 = imgui.ImVec2(810, 30)
	imgui.BeginChild('##as2dasasdf433433', imgui.ImVec2(2000, 260), false)
		imgui.Columns(2, _, false)
		imgui.AlignTextToFramePadding(); imgui.Text(u8(" Отыгровка оружия, когда оно у вас в руках")); imgui.SameLine(); imgui.ToggleButton(u8'', otgun); imgui.SameLine(); imgui.Text(u8(" Отыгровка оружия при прицеливании"))
		if imgui.Button(u8' Редактировать отыгровки', btn_size12) then win_state['redak'].v = not win_state['redak'].v end
		imgui.NextColumn()
		imgui.NextColumn()
		imgui.Checkbox(u8'Desert Eagle', deagle)
		imgui.SameLine(380,10)
		imgui.Checkbox(u8'Винтовка M4', m4)
		imgui.Checkbox(u8'Снайперская винтовка', awp)
		imgui.SameLine(380,10)
		imgui.Checkbox(u8'Узи', uzi)
		imgui.Checkbox(u8'Автомат АК-47', ak47)
		imgui.SameLine(380,10)
		imgui.Checkbox(u8'MP5', mp5)
		imgui.Checkbox(u8'ShotGun', shotgun)
		imgui.SameLine(380,10)
		imgui.Checkbox(u8'Rifle', rifle)
		imgui.Checkbox(u8'Нож', knife)
		imgui.SameLine(380,10)
		imgui.Checkbox(u8'Тайзер', tazer)
		imgui.Checkbox(u8'Убрать оружие', ybral)
		imgui.EndChild()
	end

function get_timer(time)
return string.format("%s:%s:%s",string.format("%s%s",((tonumber(os.date("%H",time)) < tonumber(os.date("%H",0)) and (24 + tonumber(os.date("%H",time))) - tonumber(os.date("%H",0)) or tonumber(os.date("%H",time)) - (tonumber(os.date("%H",0)))) < 10 and 0 or ""),(tonumber(os.date("%H",time)) < tonumber(os.date("%H",0)) and (24 + tonumber(os.date("%H",time))) - tonumber(os.date("%H",0)) or tonumber(os.date("%H",time)) - (tonumber(os.date("%H",0))))),os.date("%M",time),os.date("%S",time))
end

function carsys(param)
	sampSendChat('/cars')
	win_state['carsas'].v = not win_state['carsas'].v
	end

function carsax()
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(510, 520), imgui.Cond.FirstUseEver)
	if imgui.Begin(u8' Редактировать cars', win_state['carsas'], imgui.WindowFlags.NoResize) then
        if imgui.InputTextMultiline(u8'', buf, imgui.ImVec2(485, 420)) then 
            sampShowDialog(INFO[1],INFO[3],u8:decode(buf.v),INFO[4],INFO[5],INFO[2])
            sampSetDialogClientside(false)
		end
		if imgui.Button(u8"Сохранить", imgui.ImVec2(175, 40)) then 
			savedialog()
		end
		imgui.SameLine(323)
		if imgui.Button(u8"Удалить", imgui.ImVec2(175, 40)) then 
			if ini.DIALOG_EDITOR["DIALOG_" .. INFO[1]] ~= nil then 
				ini.DIALOG_EDITOR["DIALOG_" .. INFO[1]] = nil
				sampShowDialog(INFO[1],INFO[3],INFO[6],INFO[4],INFO[5],INFO[2]) 
				sampSetDialogClientside(false)
			end
		end
        imgui.End()
    end
end

function scriptinfo()
	imgui.Text(u8"О скрипте")
	imgui.Columns(2, _,false)
	imgui.SetColumnWidth(-1, 800)
	imgui.Separator()
	imgui.TextColoredRGB("Автор: {FF0000}Bunya{FF0000}")
	imgui.TextColoredRGB("Помогает в тестировании: {008000}Роман{008000}")
	imgui.TextColoredRGB("Идеи, которые были осуществлены в скрипте, предлагали: {FFD700}Роман, Июнь, Саня, Алексей, kriper2009 и Islamov.{FFD700}")
	imgui.TextColoredRGB("Актуальная версия скрипта: {00C2BB}"..thisScript().version.."{FFFFFF}")
	if imgui.Button(u8"Тема на БХ", imgui.ImVec2(720, 25)) then os.execute("start https://www.blast.hk/threads/89343/") end
end

function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end

function number_separator(n) 
	local left, num, right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1 '):reverse())..right
end

function imgui.CustomButton(gg, color, colorHovered, colorActive, size)
    local clr = imgui.Col
    imgui.PushStyleColor(clr.Button, color)
    imgui.PushStyleColor(clr.ButtonHovered, colorHovered)
    imgui.PushStyleColor(clr.ButtonActive, colorActive)
    if not size then size = imgui.ImVec2(0, 0) end
    local result = imgui.Button(gg, size)
    imgui.PopStyleColor(3)
    return result
end

local cfg = inicfg.load({
    databest = {
        best = 0
    },
	paramssnake = {
       fontColor = 0xFFFFFFFF,
       snakeColor = 0xFF1E90FF,
       deadSnakeColor = 0xFF0000CD,
       bgColor = 0xC8000000,
       ceilColor = 0xFF696969,
       appleColor = 0xFFFF0000,
       wallColor = 0xFFC0C0C0,
       speedsnake = 0.5,
       fieldSize = 12,
       hasWalls = false
    },
    datasnake = {
        record = 0
    }
}, 'Mono\\mini-games.ini')

function gamelist()
    local X, Y = getScreenResolution()
    imgui.SetNextWindowSize(imgui.ImVec2(415, 500), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2(X / 2, Y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	if imgui.Begin(u8' 2048', win_state['games'], imgui.WindowFlags.NoResize) then
    imgui.BeginChild("Score", imgui.ImVec2(105, 60))
        imgui.SetCursorPosX((105-imgui.CalcTextSize('Score: '..score).x)/2)
        imgui.SetCursorPosY((60-imgui.CalcTextSize('Score: '..score).y)/2)
        imgui.Text('Score: '..score)
	imgui.EndChild()
    imgui.SameLine()
    imgui.BeginChild("Best", imgui.ImVec2(105, 60))
        imgui.SetCursorPosX((105-imgui.CalcTextSize('Record: '.. tostring(cfg.databest.best)).x)/2)
        imgui.SetCursorPosY((60-imgui.CalcTextSize('Record: '.. tostring(cfg.databest.best)).y)/2)
        imgui.Text('Record: '.. tostring(cfg.databest.best))
    imgui.EndChild()
    imgui.BeginChild("game", imgui.ImVec2(385, 375), true)
        if game == 0 then
            if imgui.Button('Start', imgui.ImVec2(-1,-1)) then
                math.randomseed(os.time())  
                game_board[math.random(1, #game_board)] = 2
                game_board[math.random(1, #game_board)] = 2
                score = 0
                game = 1
            end
        elseif game == 1 then
            lockPlayerControl(true)
            for i=1,#game_board do
                if i == 4 or i == 8 or i == 12 or i == 16 then
                    if game_board[i] == 0 then imgui.CustomButton('', imgui.ImVec4(0.2,0.2,0.2,1), imgui.ImVec4(0.2,0.2,0.2,1), imgui.ImVec4(0.2,0.2,0.2,1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 2 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(0.3, 0.3, 0.2, 1), imgui.ImVec4(0.3, 0.3, 0.2, 1), imgui.ImVec4(0.3, 0.3, 0.2, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 4 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(0.48, 0.48, 0.25, 1), imgui.ImVec4(0.48, 0.48, 0.25, 1), imgui.ImVec4(0.48, 0.48, 0.25, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 8 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(0.64, 0.64, 0.2, 1), imgui.ImVec4(0.64, 0.64, 0.2, 1), imgui.ImVec4(0.64, 0.64, 0.2, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 16 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(0.83, 0.63, 0.13, 1), imgui.ImVec4(0.83, 0.63, 0.13, 1), imgui.ImVec4(0.83, 0.63, 0.13, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 32 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0.54, 0.02, 1), imgui.ImVec4(1, 0.54, 0.02, 1), imgui.ImVec4(1, 0.54, 0.02, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 64 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0.37, 0, 1), imgui.ImVec4(1, 0.37, 0, 1), imgui.ImVec4(1, 0.37, 0, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 128 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0.23, 0, 1), imgui.ImVec4(1, 0.23, 0, 1), imgui.ImVec4(1, 0.23, 0, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 256 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0.12, 0, 1), imgui.ImVec4(1, 0.12, 0, 1), imgui.ImVec4(1, 0.12, 0, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 512 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 1024 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 2048 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 4096 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 8192 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 16384 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 32768 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec2(80,80)) end
                else
                    if game_board[i] == 0 then imgui.CustomButton('', imgui.ImVec4(0.2,0.2,0.2,1), imgui.ImVec4(0.2,0.2,0.2,1), imgui.ImVec4(0.2,0.2,0.2,1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 2 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(0.3, 0.3, 0.2, 1), imgui.ImVec4(0.3, 0.3, 0.2, 1), imgui.ImVec4(0.3, 0.3, 0.2, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 4 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(0.48, 0.48, 0.25, 1), imgui.ImVec4(0.48, 0.48, 0.25, 1), imgui.ImVec4(0.48, 0.48, 0.25, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 8 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(0.64, 0.64, 0.2, 1), imgui.ImVec4(0.64, 0.64, 0.2, 1), imgui.ImVec4(0.64, 0.64, 0.2, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 16 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(0.83, 0.63, 0.13, 1), imgui.ImVec4(0.83, 0.63, 0.13, 1), imgui.ImVec4(0.83, 0.63, 0.13, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 32 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0.54, 0.02, 1), imgui.ImVec4(1, 0.54, 0.02, 1), imgui.ImVec4(1, 0.54, 0.02, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 64 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0.37, 0, 1), imgui.ImVec4(1, 0.37, 0, 1), imgui.ImVec4(1, 0.37, 0, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 128 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0.23, 0, 1), imgui.ImVec4(1, 0.23, 0, 1), imgui.ImVec4(1, 0.23, 0, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 256 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0.12, 0, 1), imgui.ImVec4(1, 0.12, 0, 1), imgui.ImVec4(1, 0.12, 0, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 512 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 1024 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 2048 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 4096 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 8192 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 16384 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec2(80,80)) end
                    if game_board[i] == 32768 then imgui.CustomButton(tostring(game_board[i]), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec4(1, 0, 0, 1), imgui.ImVec2(80,80)) end
                    imgui.SameLine()
                end
            end
            if not sampIsChatInputActive() and isKeyJustPressed(38) then -- up
                for i = 16, 5, -1 do
                    local loop_next = i-4
                    if game_board[i] ~= 0 then
                        if game_board[loop_next] == game_board[i] then
                            game_board[loop_next] = game_board[loop_next] + game_board[i]
                            score = score + game_board[i]
                            game_board[i] = 0
                        end
                        if game_board[loop_next] == 0 then
                            game_board[loop_next] = game_board[i]
                            game_board[i] = 0
                        end
                    end
                end 
                -- много циклов не бывает ;)
                for i = 16, 5, -1 do
                    local loop_next = i-4
                    if game_board[i] ~= 0 then
                        if game_board[loop_next] == game_board[i] then
                            game_board[loop_next] = game_board[loop_next] + game_board[i]
                            score = score + game_board[i]
                            game_board[i] = 0
                        end
                        if game_board[loop_next] == 0 then
                            game_board[loop_next] = game_board[i]
                            game_board[i] = 0
                        end
                    end
                end
                local random = {}
                for i=1,#game_board do
                    if game_board[i] == 0 then table.insert(random, i) end
                end
                if #random == 0 then game = 2 
                elseif #random >= 2 then
                    math.randomseed(os.time())
                    game_board[random[math.random(1, #random)]] = 2
                    game_board[random[math.random(1, #random)]] = 2
                else
                    math.randomseed(os.time())
                    game_board[random[math.random(1, #random)]] = 2
                end
            end
            if not sampIsChatInputActive() and isKeyJustPressed(40) then -- down
                for i=1,12 do
                    local loop_next = i+4
                    if loop_next > 16 then return end
                    if game_board[loop_next] == game_board[i] then
                        score = score + game_board[i]
                        game_board[loop_next] = game_board[loop_next] + game_board[i]
                        game_board[i] = 0
                    end
                    if game_board[loop_next] == 0 then
                        game_board[loop_next] = game_board[i]
                        game_board[i] = 0
                    end
                end
                -- много циклов не бывает ;)
                for i=1,12 do
                    local loop_next = i+4
                    if loop_next > 16 then return end
                    if game_board[loop_next] == game_board[i] then
                        score = score + game_board[i]
                        game_board[loop_next] = game_board[loop_next] + game_board[i]
                        game_board[i] = 0
                    end
                    if game_board[loop_next] == 0 then
                        game_board[loop_next] = game_board[i]
                        game_board[i] = 0
                    end
                end
                local random = {}
                for i=1,#game_board do
                    if game_board[i] == 0 then table.insert(random, i) end
                end
                if #random == 0 then game = 2 
                elseif #random >= 2 then
                    math.randomseed(os.time())
                    game_board[random[math.random(1, #random)]] = 2
                    game_board[random[math.random(1, #random)]] = 2
                else
                    math.randomseed(os.time())
                    game_board[random[math.random(1, #random)]] = 2
                end
            end
            if not sampIsChatInputActive() and isKeyJustPressed(37) then -- left
                for i=16,1, -1 do
                    local loop_next = i-1
                    if loop_next ~= 12 and loop_next ~= 8 and loop_next ~= 4 then
                        if game_board[i] ~= 0 then
                            if game_board[loop_next] == game_board[i] then
                                game_board[loop_next] = game_board[loop_next] + game_board[i]
                                score = score + game_board[i]
                                game_board[i] = 0
                            end
                            if game_board[loop_next] == 0 then
                                game_board[loop_next] = game_board[i]
                                game_board[i] = 0
                            end
                        end
                    end
                end
                -- много циклов не бывает ;)
                for i=16,1, -1 do
                    local loop_next = i-1
                    if loop_next ~= 12 and loop_next ~= 8 and loop_next ~= 4 then
                        if game_board[i] ~= 0 then
                            if game_board[loop_next] == game_board[i] then
                                game_board[loop_next] = game_board[loop_next] + game_board[i]
                                score = score + game_board[i]
                                game_board[i] = 0
                            end
                            if game_board[loop_next] == 0 then
                                game_board[loop_next] = game_board[i]
                                game_board[i] = 0
                            end
                        end
                    end
                end
                local random = {}
                for i=1,#game_board do
                    if game_board[i] == 0 then table.insert(random, i) end
                end
                if #random == 0 then game = 2 
                elseif #random >= 2 then
                    math.randomseed(os.time())
                    game_board[random[math.random(1, #random)]] = 2
                    game_board[random[math.random(1, #random)]] = 2
                else
                    math.randomseed(os.time())
                    game_board[random[math.random(1, #random)]] = 2
                end
            end
            if not sampIsChatInputActive() and isKeyJustPressed(39) then -- right
                for i=1,15 do
                    local loop_next = i+1
                    if loop_next ~= 13 and loop_next ~= 9 and loop_next ~= 5 then
                        if game_board[i] ~= 0 then
                            if game_board[loop_next] == game_board[i] then
                                game_board[loop_next] = game_board[loop_next] + game_board[i]
                                score = score + game_board[i]
                                game_board[i] = 0
                            end
                            if game_board[loop_next] == 0 then
                                game_board[loop_next] = game_board[i]
                                game_board[i] = 0
                            end
                        end
                    end
                end
                -- много циклов не бывает ;)
                for i=1,15 do
                    local loop_next = i+1
                    if loop_next ~= 13 and loop_next ~= 9 and loop_next ~= 5 then
                        if game_board[i] ~= 0 then
                            if game_board[loop_next] == game_board[i] then
                                game_board[loop_next] = game_board[loop_next] + game_board[i]
                                score = score + game_board[i]
                                game_board[i] = 0
                            end
                            if game_board[loop_next] == 0 then
                                game_board[loop_next] = game_board[i]
                                game_board[i] = 0
                            end
                        end
                    end
                end
                local random = {}
                for i=1,#game_board do
                    if game_board[i] == 0 then table.insert(random, i) end
                end
                if #random == 0 then game = 2 
                elseif #random >= 2 then
                    math.randomseed(os.time())
                    game_board[random[math.random(1, #random)]] = 2
                    game_board[random[math.random(1, #random)]] = 2
                else
                    math.randomseed(os.time())
                    game_board[random[math.random(1, #random)]] = 2
                end
            end
        elseif game == 2 then
            if imgui.Button('Game Over\n\n\n   Restart',imgui.ImVec2(-1,-1)) then
                game_board = {
                    0, 0, 0, 0,
                    0, 0, 0, 0,
                    0, 0, 0, 0,
                    0, 0, 0, 0,
                }
                math.randomseed(os.time())
                game_board[math.random(1, #game_board)] = 2
                game_board[math.random(1, #game_board)] = 2
				if score > cfg.databest.best then 
				cfg.databest.best = score
				inicfg.save(cfg, 'Mono\\mini-games.ini')
				end
                score = 0
                game = 1
            end
        end
    imgui.EndChild()
    imgui.End()
end
end

function renderDrawButton(d3dFont, Title, posX, posY, sizeX, sizeY, targetX, targetY, boxColor, targetBoxColor, textColor, targetTextColor)
    local bool = false
    local currentBoxColor= boxColor
    local currentTextColor= textColor

    if targetX > posX and targetX < posX + sizeX and targetY > posY and targetY < posY + sizeY then
        currentBoxColor = targetBoxColor
        currentTextColor = targetTextColor
        if isKeyJustPressed(1) then bool = true end
    end
    renderDrawBoxWithBorder(posX, posY, sizeX, sizeY, currentBoxColor, 4, 0xFF242424)
    renderFontDrawText(d3dFont, Title, posX+(sizeX-renderGetFontDrawTextLength(d3dFont, Title))/2, posY+(sizeY-renderGetFontDrawHeight(d3dFont))/2, currentTextColor)
    return bool
	end

function coerce(x, lo, hi)
    return math.max(math.min(x, hi), lo)
end

-- Получаем разрешение экрана и находим размер и позицию окна игры
local resX, resY = getScreenResolution()
local winSize = resY / 2
local winX = (resX - winSize) / 2
local winY = (resY - winSize) / 2
local fieldOffset = winSize * 0.15                      -- Отступ для поля
local ceilSize = winSize * 0.7 / cfg.paramssnake.fieldSize   -- Размер одной клетки
local ceilOffset = ceilSize * 0.1                       -- Отступ для клетки
local realCeilSize = ceilSize * 0.8                     -- Реальный размер клетки
local paddingsnake = resX * 0.01                             -- Отступ для текста

-- Состояние игры
local isActivated = false
local isStarted = false
local scoresnake = 0             -- Текущий счет
local lastUpdate = 0.0      -- Время прошлого кадра
local timeDelta = 0.0       -- Разница между предыдущим кадром и текущим(секунды)

-- Шрифт игры
local fontSizesnake = resY * 0.02
local fontsnake = renderCreateFont('Arial', fontSizesnake)

local snake = {}        -- Массив всех клеток змеи
local apple = {}        -- Координата яблока
local moveSide = 0      -- Сторона, в которую движется змейка(0 - вверх, 1 - вправо, 2 - вниз, 3 - влево)
local nextMoveSide = 0  -- Сторона движения змейки при следующем обновлении
local timersnake = 0.0       -- Таймер игры

function updatesnake()
    if snaketaken then
		showCursor(true)
		isActivated = true
	else
		isActivated = false
    end

    timeDelta = gameClock() - lastUpdate
    lastUpdate = gameClock()

    -- Обновляем, только если включен скрипт
    if not isActivated then 
        return end

    -- Если игра не начата и нажата клавиша E
    if not sampIsChatInputActive() and not isStarted and wasKeyPressed(key.VK_E) then
        startGame()
    end
	
	if not sampIsChatInputActive() and isStarted and wasKeyPressed(key.VK_R) then
        snaketaken = false
		showCursor(false)
    end

    -- Продолжаем только если игра запущена
    if not isStarted then
        return end

    -- Проверяем нажатие клавиш
    if not sampIsChatInputActive() and isKeyJustPressed(38) and moveSide ~= 2 then
        nextMoveSide = 0
    elseif not sampIsChatInputActive() and isKeyJustPressed(39) and moveSide ~= 3 then
        nextMoveSide = 1
    elseif not sampIsChatInputActive() and isKeyJustPressed(40) and moveSide ~= 0 then
        nextMoveSide = 2
    elseif not sampIsChatInputActive() and isKeyJustPressed(37) and moveSide ~= 1 then
        nextMoveSide = 3
    end

    -- Продолжаем только если пришло время обновления
    timersnake = timersnake + timeDelta
    if timersnake < cfg.paramssnake.speedsnake then
        return end
    timersnake = 0

    moveSide = nextMoveSide

    -- Двигаем хвост к голове
    for i = table.maxn(snake), 2, -1 do
        snake[i].x = snake[i - 1].x
        snake[i].y = snake[i - 1].y
    end

    -- Двигаем голову
    headPos = {}
    if moveSide == 0 then       -- Движемся наверх
        headPos.x = snake[1].x
        headPos.y = snake[1].y - 1
    elseif moveSide == 1 then   -- Движемся вправо
        headPos.x = snake[1].x + 1
        headPos.y = snake[1].y
    elseif moveSide == 2 then   -- Движемся вниз
        headPos.x = snake[1].x
        headPos.y = snake[1].y + 1
    elseif moveSide == 3 then   -- Движемся влево
        headPos.x = snake[1].x - 1
        headPos.y = snake[1].y
    end

    -- Проверяем, скушала ли змейка яблоко
    if snake[1].x == apple.x and snake[1].y == apple.y then
        scoresnake = scoresnake + 1
        spawnApple()
        table.insert(snake, 1, headPos)
    else
        snake[1] = headPos
    end

    if not cfg.paramssnake.hasWalls then
        -- Если голова ушла за границу поля по горизонтали, то возвращаяем её на другой стороне.
        if snake[1].x < 0 then
            snake[1].x = cfg.paramssnake.fieldSize - 1
        elseif snake[1].x >= cfg.paramssnake.fieldSize then
            snake[1].x = 0
        end

        -- ...по вертикали
        if snake[1].y < 0 then
            snake[1].y = cfg.paramssnake.fieldSize - 1
        elseif snake[1].y >= cfg.paramssnake.fieldSize then
            snake[1].y = 0
        end
    else
        -- Проверка столкновения змейки со стеной
        if snake[1].x == 0 or snake[1].x == cfg.paramssnake.fieldSize - 1 or snake[1].y == 0 or snake[1].y == cfg.paramssnake.fieldSize - 1 then
            isStarted = false
            return
        end
    end

    -- Проверяем столкновение змейки с собой
    for i = 2, table.maxn(snake) do
        if snake[1].x == snake[i].x and snake[1].y == snake[i].y then
            isStarted = false
            return
        end
    end
end

-- Функция запуска игры
function startGame()
    isStarted = true

    -- Если побили рекорд
    if scoresnake > cfg.datasnake.record then
        cfg.datasnake.record = scoresnake
        inicfg.save(cfg, 'snake.ini')
    end
    scoresnake = 0

    snake = {}
    moveSide = 0
    nextMoveSide = 0
    local center = cfg.paramssnake.fieldSize / 2
    for i = 2, 0, -1 do
        table.insert(snake, {
            x = center,
            y = center - i
        })
    end
    
    spawnApple()    -- Спавним яблоко
end

-- Функция спавна яблока
function spawnApple()
    if not cfg.paramssnake.hasWalls then
        apple = {
            x = math.random(0, cfg.paramssnake.fieldSize - 1),
            y = math.random(0, cfg.paramssnake.fieldSize - 1)
        }
    else
        apple = {
            x = math.random(1, cfg.paramssnake.fieldSize - 2),
            y = math.random(1, cfg.paramssnake.fieldSize - 2)
        }
    end
end

-- Функция отрисовки игры
function rendersnake()
    -- Отрисовываем, только если включен скрипт
    if not isActivated then
        return end

    -- Рисуем фон
    renderDrawBox(winX, winY, winSize, winSize, cfg.paramssnake.bgColor)

    -- Рисуем поле
    for x = 1, cfg.paramssnake.fieldSize do
        for y = 1, cfg.paramssnake.fieldSize do
            if cfg.paramssnake.hasWalls and (x == 1 or y == 1 or x == cfg.paramssnake.fieldSize or y == cfg.paramssnake.fieldSize) then
                renderCeil(x - 1, y - 1, cfg.paramssnake.wallColor)
            else
                renderCeil(x - 1, y - 1, cfg.paramssnake.ceilColor)
            end
        end
    end

    -- Рисуем яблоко
    if apple.x ~= nil and apple.y ~= nil then
        renderCeil(apple.x, apple.y, cfg.paramssnake.appleColor)
    end

    -- Рисуем змейку
    for i = 1, table.maxn(snake) do
        renderCeil(snake[i].x, snake[i].y, cfg.paramssnake.snakeColor)
    end

    if not isStarted and table.maxn(snake) > 0 then
        renderCeil(snake[1].x, snake[1].y, cfg.paramssnake.deadSnakeColor)
    end

    -- Рисуем тексты
    renderFontDrawText(fontsnake, 'Score: ' .. tostring(scoresnake), winX + paddingsnake, winY + paddingsnake, cfg.paramssnake.fontColor)

    local text = 'Record: ' .. tostring(cfg.datasnake.record)
    local length = renderGetFontDrawTextLength(fontsnake, text)
    renderFontDrawText(fontsnake, text, winX + winSize - paddingsnake - length, winY + paddingsnake, cfg.paramssnake.fontColor)

    if not isStarted then
        text = 'Press E to start'
        length = renderGetFontDrawTextLength(fontsnake, text)
        renderFontDrawText(fontsnake, text, winX + (winSize - length) / 2, winY + winSize - fontSizesnake - paddingsnake, cfg.paramssnake.fontColor)
    end
	if isStarted then
        text = 'Press R to exit'
        length = renderGetFontDrawTextLength(fontsnake, text)
        renderFontDrawText(fontsnake, text, winX + (winSize - length) / 2, winY + winSize - fontSizesnake - paddingsnake, cfg.paramssnake.fontColor)
    end
end

-- Функция отрисовки клетки
function renderCeil(x, y, color)
    renderDrawBox(
        winX + fieldOffset + ceilSize * x + ceilOffset,
        winY + fieldOffset + ceilSize * y + ceilOffset,
        realCeilSize, realCeilSize, color)
end

function inventory()
		lua_thread.create(function()
		sampSendClickTextdraw(2092)
		wait(1500)
		sampSendClickTextdraw(2093)
		wait(1500)
		sampSendClickTextdraw(2094)
		wait(1000)
		sampSendClickTextdraw(2077)
end)
end