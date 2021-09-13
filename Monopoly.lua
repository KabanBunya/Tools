script_name('Mono Tools')
script_properties("work-in-pause")
script_version('3.0.5')

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
kamensession = 0
metalsession = 0
bronzasession = 0
silversession = 0
goldsession = 0
sborsession = 0
zpsession = 0
kamenitog = 0
metalitog = 0
bronzaitog = 0
silveritog = 0
golditog = 0
azpodarki = 0
moneypodarki = 0
serebropodarki = 0
serebrorulpodarki = 0
zolotopodarki = 0
chemodanpodarki = 0
itogopodarkov = 0
itogobtc = 0
local font = renderCreateFont('Arial', 10, 5)
local connected = false
local connecting = false
itogoskuptrava = 0
itogoskupbronzarul = 0
itogoskupserebrorul = 0
itogoskupgoldrul = 0
itogoskupplatinarul = 0
itogoskupkamen = 0
itogoskupmetal = 0
itogoskupbronza = 0
itogoskupserebro = 0
itogoskupgold = 0
itogoskuppodarki = 0
itogoskuptalon = 0
itogoskupsemtalon = 0
itogoskupskidtalon = 0
itogoskuptochkamen = 0
itogoskuptochamulet = 0
itogoskuplarec = 0
itogoskuptt = 0
itogoskupmoneta = 0
itogoskuplen = 0
itogoskupxlopok = 0
itogoskuprespekt = 0
itogoskupmaterial = 0
itogoskupdrova = 0
itogoskupantibiotik = 0
itogoskuptsr = 0
itogoskupsemmoneta = 0
itogoskupauto = 0
skuptovaracol = 0
itogoskuptovara = 0
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
local res, wm = pcall(require, "lib.windows.message")
assert(res, 'Library "WIN MESSAGE" должна быть в папке lib и moonloader. Cкачать все нужны файлы и библиотеки, вы можете на форуме БХ - https://www.blast.hk/threads/89343/')
------------------------------------------------------------------
local res = pcall(require, "luairc")
assert(res, 'Library "luairc" должна быть в папке lib и moonloader. Cкачать все нужны файлы и библиотеки, вы можете на форуме БХ - https://www.blast.hk/threads/89343/')
------------------------------------------------------------------

-----------------------------------------------
local new                   = imgui 
local str                   = ffi.string
local jsonDir               = getGameDirectory().."\\moonloader\\config\\Mono\\messanger.json"
-----------------------------------------------

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

mlogo, errorPic, classifiedPic, pentagonPic, accessDeniedPic, gameServer = nil, nil, nil, nil, nil, nil -- 
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
mouseCoord4 = false 
mouseCoord5 = false 
mouseCoord6 = false
mouseCoord7 = false  
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

local cfg1 = {
    message = {
        nick = "User",
        channels = {
            "#monotools" 
        }
    }
}

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
    },
	shahta = {
		kamentime = 0,
		metaltime = 0,
		bronzatime = 0,
		silvertime = 0,
		goldtime = 0,
		zptime = 0,
		sbortime = 0
	},
	adpred = {
		piarsh = 0,
		vippiarsh = 0,
		piarsh1 = 0,
		vippiarsh1 = 0,
		piarsh2 = 0,
		vippiarsh2 = 0,
		piarsh3 = 0,
		vippiarsh3 = 0,
		piarsh4 = 0,
		vippiarsh4 = 0,
		piarsh5 = 0,
		vippiarsh5 = 0,
		piarsh6 = 0,
		vippiarsh6 = 0
	}
}, 'Mono\\mini-games.ini')	
	
local SET = {
 	settings = {
		autologin = false,
		dialogupdate = false,
		dialogfix = false,
		autoryda = false,
		skuptrava = false,
		skupbronzarul = false,
		skupserebrorul = false,
		skupgoldrul = false,
		skupplatinarul = false,
		skupkamen = false,
		skupmetal = false,
		skupbronza = false,
		skupserebro = false,
		skupgold = false,
		skuppodarki = false,
		skuptalon = false,
		skupsemtalon = false,
		skupskidtalon = false,
		skuptochkamen = false,
		skuptochamulet = false,
		skuplarec = false,
		skuptt = false,
		skupmoneta = false,
		skuplen = false,
		skupxlopok = false,
		skuprespekt = false,
		skupmaterial = false,
		skupdrova = false,
		skupantibiotik = false,
		skuptsr = false,
		skupsemmoneta = false,
		skupauto = false,
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
		autokamen = '8000',
		autometal = '4000',
		autobronza = '40000',
		autosilver = '100000',
		autogold = '80000',
		kdpusk = '10',
		napominalkadata = '01.07',
		autopass = '123456',
		autopasspin = '123456',
		autoklava = '114',
		autoklavareload = '115',
		autodrone = '67',
		autodronev2 = '49',
		autodronev3 = '67',
		autodronev4 = '50',
		pismoreal = '1) ',
		pismoreal1 = '2) ',
		pismoreal2 = '3) ',
		pismoreal3 = '4) ',
		pismoreal4 = '5) ',
		adsec = '60',
		vipadsec = '60',
		famadsec = '60',
		vradsec = '60',
		sadsec = '60',
		adredak = 'В 165 баре много девочек и пива.',
		skuptravacol = '1',
		skuptravacena = '1000',
		skupbronzarulcol = '1',
		skupbronzarulcena = '15000',
		skupserebrorulcol = '1',
		skupserebrorulcena = '95000',
		skupgoldrulcol = '1',
		skupgoldrulcena = '300000',
		skupplatinarulcol = '1',
		skupplatinarulcena = '600000',
		skupkamencol = '1',
		skupkamencena = '10000',
		skupmetalcol = '1',
		skupmetalcena = '5000',
		skupbronzacol = '1',
		skupbronzacena = '50000',
		skupserebrocol = '1',
		skupserebrocena = '100000',
		skupgoldcol = '1',
		skupgoldcena = '50000',
		skuppodarkicol = '1',
		skuppodarkicena = '10000',
		skuptaloncol = '1',
		skuptaloncena = '7000',
		skupsemtaloncol = '1',
		skupsemtaloncena = '17000',
		skupskidtaloncol = '1',
		skupskidtaloncena = '2000000',
		skuptochkamencol = '1',
		skuptochkamencena = '80000',
		skuptochamuletcena = '200000',
		skuplareccol = '1',
		skuplareccena = '300000',
		skupttcena = '9000000',
		skupmonetacol = '1',
		skupmonetacena = '2000',
		skuplencol = '1',
		skuplencena = '2000',
		skupxlopokcol = '1',
		skupxlopokcena = '1500',
		skuprespektcol = '1',
		skuprespektcena = '2000',
		skupmaterialcol = '1',
		skupmaterialcena = '100',
		skupdrovacol = '1',
		skupdrovacena = '100',
		skupantibiotikcol = '1',
		skupantibiotikcena = '10000',
		skuptsrcol = '1',
		skuptsrcena = '15000',
		skupsemmonetacol = '1',
		skupsemmonetacena = '5000',
		skupautocena = '2000000',
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
		watertext = '2128',
		timecout = false,
		gangzones = false,
		ryda = false,
		zones = false,
		assistant = false,
		assistant1 = false,
		assistant2 = false,
		tag = '',
		enable_tag = false,
		chatInfo = false,
		raskladka = false,
		recongen = false,
		carsis = false,
		keyT = false,
		launcher = false,
		adcounter = false,
		launcherpc = false,
		launcherm = false,
		deagle = false,
		awp = false,
		m4 = false,
		otgun = false,
		bindreshim = false,
		droneoption = false,
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
		antilomka = false,
		napominalka = false,
		chatcalc = false,
		pismo = false,
		yashik = false,
		yashik1 = false,
		yashik2 = false,
		yashik3 = false,
		otkrytie = true,
		otkrytie2 = false,
		ndr = false,
		toch = false,
		autobike = false,
		styletest = true,
		styletest1 = false,
		autochat = true,
		chatmessage = true,
		infoX = 0,
		infoY = 0,
		infoX2 = 0,
		infoY2 = 0,
		infoX3 = 0,
		infoY3 = 0,
		infoX4 = 0,
		infoY4 = 0,
		spOtr = '',
		timefix = 3,
		enableskin = false,
		skin = 1,
	},
	assistant = {
		asX = 1,
		asY = 1
	},
	assistant1 = {
		asX3 = 1,
		asY3 = 1
	},
	assistant2 = {
		asX4 = 1,
		asY4 = 1
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
	},
	shahtainformer = {
		kamen = true,
		metal = true,
		bronza = true,
		silver = true,
		gold = true,
		zp = true,
		sbor = true
	},
	pismoinformer = {
		
	}
}


local SeleList = {"Досье", "Сведения", "Пентагон"} 

local SeleListBool = {}
for i = 1, #SeleList do
	SeleListBool[i] = imgui.ImBool(false)
end

local win_state = {}
win_state['main'] = imgui.ImBool(false)
win_state['windowspusk'] = imgui.ImBool(false)
win_state['info'] = imgui.ImBool(false)
win_state['settings'] = imgui.ImBool(false)
win_state['hotkeys'] = imgui.ImBool(false)
win_state['leaders'] = imgui.ImBool(false)
win_state['help'] = imgui.ImBool(false)
win_state['nastroikawin'] = imgui.ImBool(false)
win_state['googlewin'] = imgui.ImBool(false)
win_state['updatewin'] = imgui.ImBool(false)
win_state['messanger'] = imgui.ImBool(false)
win_state['prazdnikwin'] = imgui.ImBool(false)
win_state['robotwin'] = imgui.ImBool(false)
win_state['bomjwin'] = imgui.ImBool(false)
win_state['gamer'] = imgui.ImBool(false)
win_state['yashiki'] = imgui.ImBool(false)
win_state['obmentrade'] = imgui.ImBool(false)
win_state['games'] = imgui.ImBool(false)
win_state['redak'] = imgui.ImBool(false)
win_state['bank'] = imgui.ImBool(false)
win_state['noteswin'] = imgui.ImBool(false)
win_state['bitkoinwinokno'] = imgui.ImBool(false)
win_state['kirkawin'] = imgui.ImBool(false)
win_state['tochilki'] = imgui.ImBool(false)
win_state['pcoff'] = imgui.ImBool(false)
win_state['winprofile'] = imgui.ImBool(false)
win_state['piar'] = imgui.ImBool(false)
win_state['skup'] = imgui.ImBool(false)
win_state['skup2'] = imgui.ImBool(false)
win_state['skup3'] = imgui.ImBool(false)
win_state['oscripte'] = imgui.ImBool(false)
win_state['oscriptepeople'] = imgui.ImBool(false)
win_state['shahtamenu'] = imgui.ImBool(false)
win_state['shema'] = imgui.ImBool(false)
win_state['shematext'] = imgui.ImBool(false)
win_state['shemafunks'] = imgui.ImBool(false)
win_state['shemainst'] = imgui.ImBool(false)
win_state['skupshema'] = imgui.ImBool(false)
win_state['pravila2048'] = imgui.ImBool(false)
win_state['pravilapong'] = imgui.ImBool(false)
win_state['pravilasnake'] = imgui.ImBool(false)
win_state['tup'] = imgui.ImBool(false)
win_state['timeyved'] = imgui.ImBool(false)
win_state['carsas'] = imgui.ImBool(false)
win_state['about'] = imgui.ImBool(false)
win_state['update'] = imgui.ImBool(false)
win_state['player'] = imgui.ImBool(false)
win_state['base'] = imgui.ImBool(false)
win_state['informer'] = imgui.ImBool(false)
win_state['pismoinformer'] = imgui.ImBool(false)
win_state['shahtainformer'] = imgui.ImBool(false)
win_state['regst'] = imgui.ImBool(false)
win_state['renew'] = imgui.ImBool(false)
win_state['find'] = imgui.ImBool(false)
win_state['ass'] = imgui.ImBool(false)
win_state['leave'] = imgui.ImBool(false)
local checked_test = imgui.ImBool(false)
local checked_test2 = imgui.ImBool(false)
local checked_test3 = imgui.ImBool(false)
local checked_test4 = imgui.ImBool(false)
local newroulette = imgui.ImBool(false)
local podarki = imgui.ImBool(false)
local water = imgui.ImBool(false)
local btc = imgui.ImBool(false)
local liquid = imgui.ImBool(false)
local pusk = imgui.ImBool(false)
local platina = imgui.ImBool(false)
local labirint = imgui.ImBool(false)
local WHupdate = imgui.ImBool(false)
local prazdnik = imgui.ImBool(false)
local prazdnik1 = imgui.ImBool(false)
local prazdnik2 = imgui.ImBool(false)
local prazdnik3 = imgui.ImBool(false)
local prazdnik4 = imgui.ImBool(false)
local prazdnik5 = imgui.ImBool(false)
local prazdnik6 = imgui.ImBool(false)
robot = imgui.ImBool(false)
robot1 = imgui.ImBool(false)
robot2 = imgui.ImBool(false)
robot3 = imgui.ImBool(false)
robot4 = imgui.ImBool(false)
robot5 = imgui.ImBool(false)
robot6 = imgui.ImBool(false)
robot7 = imgui.ImBool(false)
robot8 = imgui.ImBool(false)
robot9 = imgui.ImBool(false)
robot10 = imgui.ImBool(false)
robot11 = imgui.ImBool(false)
robot12 = imgui.ImBool(false)
robot13 = imgui.ImBool(false)
robot14 = imgui.ImBool(false)
bomj = imgui.ImBool(false)
bomj1 = imgui.ImBool(false)
bomj2 = imgui.ImBool(false)
bomj3 = imgui.ImBool(false)
bomj4 = imgui.ImBool(false)
bomj5 = imgui.ImBool(false)
bomj6 = imgui.ImBool(false)
bomj7 = imgui.ImBool(false)
bomj8 = imgui.ImBool(false)
bomj9 = imgui.ImBool(false)
local moneta = imgui.ImBool(false)
local tochkamen = imgui.ImBool(false)
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
local addad = imgui.ImBool(false)
local vipaddad = imgui.ImBool(false)
local famaddad = imgui.ImBool(false)
local vraddad = imgui.ImBool(false)
local saddad = imgui.ImBool(false)
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
local stringField = imgui.ImBuffer(130)
local changeNickField = imgui.ImBuffer(19)
local chats = cfg1.message.channels
local messages = {}
local users = {}
local lastMessage = 0
local needFocus = false	
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

if doesFileExist(jsonDir) then
    local f = io.open(jsonDir, "a+")
    cfg1 = decodeJson(f:read("*a"))
    f:close()
else
    createDirectory(getGameDirectory().."\\moonloader\\config\\Mono")
    local f = io.open(jsonDir, "w")
    f:write(encodeJson(cfg1))
    f:close()
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

function apply_custom_style1()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
	local ImVec2 = imgui.ImVec2

	style.WindowPadding = ImVec2(0, 0)
    style.WindowRounding = 5.0
	style.FramePadding = ImVec2(5, 5)
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(8, 4)
	style.IndentSpacing = 25.0
    style.ScrollbarSize = 15.0
    style.ScrollbarRounding = 9.0
    style.GrabMinSize = 5.0
    style.GrabRounding = 3.0
    colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.06, 0.53, 0.98, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.00)
    colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Separator]              = ImVec4(0.43, 0.43, 0.50, 0.90)
    colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.07, 0.07, 0.09, 1.00)
    colors[clr.ChildWindowBg]          = ImVec4(0.07, 0.07, 0.09, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.07, 0.07, 0.09, 0.94)
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

function apply_custom_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
	local ImVec2 = imgui.ImVec2

	style.WindowPadding = ImVec2(0, 0)
    style.WindowRounding = 5.0
	style.FramePadding = ImVec2(5, 5)
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(8, 4)
	style.IndentSpacing = 25.0
    style.ScrollbarSize = 15.0
    style.ScrollbarRounding = 9.0
    style.GrabMinSize = 5.0
    style.GrabRounding = 3.0
	
    colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.06, 0.53, 0.98, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.00)
    colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Separator]              = ImVec4(0.43, 0.43, 0.50, 0.90)
    colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.Text]                   = ImVec4(0.07, 0.07, 0.09, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(1.00, 1.00, 1.00, 0.94)
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

apply_custom_style()

function files_add()
	if not doesDirectoryExist("moonloader\\config\\Mono\\icons") then createDirectory('moonloader\\config\\Mono\\icons') end
	if not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\2048.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\bitcoin.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\dollar.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\down.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\edge.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\helper.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\img0.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\info.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\kirka.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\left.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\notes.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\offpc.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\phone.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\pingpong.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\pusk.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\reload.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\right.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\settingwin.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\snakegame.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\sunduk.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\telega.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\tochkamen.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\trade.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\up.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\user.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\arizonanews.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\tools3.0.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\monopolynews.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\aforma.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\arzupdate.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\prazdnik.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\robot.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\bomj.png') or not doesFileExist(getGameDirectory() .. '\\moonloader\\config\\Mono\\icons\\messanger.png') then
	sampAddChatMessage("[Mono Tools]{FFFFFF} {FF0000}Ошибка!{FFFFFF} У вас отсутствуют нужные картинки для работы скрипта, начинаю скачивание.", 0x046D63)
	downloadUrlToFile('https://i.imgur.com/1jMFPBg.png', getWorkingDirectory() .. '/config/Mono/icons/2048.png')
	downloadUrlToFile('https://i.imgur.com/hMrVjAa.png', getWorkingDirectory() .. '/config/Mono/icons/bitcoin.png')
	downloadUrlToFile('https://i.imgur.com/QA52B5Z.png', getWorkingDirectory() .. '/config/Mono/icons/dollar.png')
	downloadUrlToFile('https://i.imgur.com/YcBJsLV.png', getWorkingDirectory() .. '/config/Mono/icons/down.png')
	downloadUrlToFile('https://i.imgur.com/J7SIdEY.png', getWorkingDirectory() .. '/config/Mono/icons/edge.png')
	downloadUrlToFile('https://i.imgur.com/YJRJQZj.png', getWorkingDirectory() .. '/config/Mono/icons/helper.png')
	downloadUrlToFile('https://i.imgur.com/dgj49cm.png', getWorkingDirectory() .. '/config/Mono/icons/img0.png')
	downloadUrlToFile('https://i.imgur.com/FfQIlL5.png', getWorkingDirectory() .. '/config/Mono/icons/info.png')
	downloadUrlToFile('https://i.imgur.com/s385sfd.png', getWorkingDirectory() .. '/config/Mono/icons/kirka.png')
	downloadUrlToFile('https://i.imgur.com/0NN5Y08.png', getWorkingDirectory() .. '/config/Mono/icons/left.png')
	downloadUrlToFile('https://i.imgur.com/scjVjUk.png', getWorkingDirectory() .. '/config/Mono/icons/notes.png')
	downloadUrlToFile('https://i.imgur.com/2AKdbzW.png', getWorkingDirectory() .. '/config/Mono/icons/offpc.png')
	downloadUrlToFile('https://i.imgur.com/1tqlkqP.png', getWorkingDirectory() .. '/config/Mono/icons/phone.png')
	downloadUrlToFile('https://i.imgur.com/7bisQix.png', getWorkingDirectory() .. '/config/Mono/icons/pingpong.png')
	downloadUrlToFile('https://i.imgur.com/R6noq6c.png', getWorkingDirectory() .. '/config/Mono/icons/pusk.png')
	downloadUrlToFile('https://i.imgur.com/yOAN5gD.png', getWorkingDirectory() .. '/config/Mono/icons/reload.png')
	downloadUrlToFile('https://i.imgur.com/yua5Kat.png', getWorkingDirectory() .. '/config/Mono/icons/right.png')
	downloadUrlToFile('https://i.imgur.com/wbv41vM.png', getWorkingDirectory() .. '/config/Mono/icons/settingwin.png')
	downloadUrlToFile('https://i.imgur.com/OFd7FlA.png', getWorkingDirectory() .. '/config/Mono/icons/snakegame.png')
	downloadUrlToFile('https://i.imgur.com/3xAR1s4.png', getWorkingDirectory() .. '/config/Mono/icons/sunduk.png')
	downloadUrlToFile('https://i.imgur.com/9Gbtjyx.png', getWorkingDirectory() .. '/config/Mono/icons/telega.png')
	downloadUrlToFile('https://i.imgur.com/toY7EUD.png', getWorkingDirectory() .. '/config/Mono/icons/tochkamen.png')
	downloadUrlToFile('https://i.imgur.com/t6Od3eq.png', getWorkingDirectory() .. '/config/Mono/icons/trade.png')
	downloadUrlToFile('https://i.imgur.com/PhTODEr.png', getWorkingDirectory() .. '/config/Mono/icons/up.png')
	downloadUrlToFile('https://i.imgur.com/hySXfSC.png', getWorkingDirectory() .. '/config/Mono/icons/user.png')
	downloadUrlToFile('https://i.imgur.com/FlmfCsN.png', getWorkingDirectory() .. '/config/Mono/icons/aforma.png')
	downloadUrlToFile('https://i.imgur.com/qNLWKys.png', getWorkingDirectory() .. '/config/Mono/icons/monopolynews.png')
	downloadUrlToFile('https://i.imgur.com/SIvPMIK.png', getWorkingDirectory() .. '/config/Mono/icons/tools3.0.png')
	downloadUrlToFile('https://i.imgur.com/boLIlH5.png', getWorkingDirectory() .. '/config/Mono/icons/arizonanews.png')
	downloadUrlToFile('https://i.imgur.com/IPtz7GT.png', getWorkingDirectory() .. '/config/Mono/icons/arzupdate.png')
	downloadUrlToFile('https://i.imgur.com/BM1UZXR.png', getWorkingDirectory() .. '/config/Mono/icons/prazdnik.png')
	downloadUrlToFile('https://i.imgur.com/3J2FOpM.png', getWorkingDirectory() .. '/config/Mono/icons/robot.png')
	downloadUrlToFile('https://i.imgur.com/l64AQZQ.png', getWorkingDirectory() .. '/config/Mono/icons/bomj.png')
	downloadUrlToFile('https://i.imgur.com/jvLuHc6.png', getWorkingDirectory() .. '/config/Mono/icons/messanger.png')
	sampAddChatMessage("[Mono Tools]{FFFFFF} Скачивание картинок завершено! Через 10 секунд скрипт запустится, спасибо за ожидание.", 0x046D63)
	photo_load()
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
		elseif win_state['nastroikawin'].v then
			win_state['nastroikawin'].v = not win_state['nastroikawin'].v
		elseif win_state['googlewin'].v then
			win_state['googlewin'].v = not win_state['googlewin'].v
		elseif win_state['updatewin'].v then
			win_state['updatewin'].v = not win_state['updatewin'].v
		elseif win_state['messanger'].v then
			win_state['messanger'].v = not win_state['messanger'].v
		elseif win_state['yashiki'].v then
			win_state['yashiki'].v = not win_state['yashiki'].v
		elseif win_state['obmentrade'].v then
			win_state['obmentrade'].v = not win_state['obmentrade'].v
		elseif win_state['gamer'].v then
			win_state['gamer'].v = not win_state['gamer'].v
		elseif win_state['bank'].v then
			win_state['bank'].v = not win_state['bank'].v
		elseif win_state['noteswin'].v then
			win_state['noteswin'].v = not win_state['noteswin'].v
		elseif win_state['bitkoinwinokno'].v then
			win_state['bitkoinwinokno'].v = not win_state['bitkoinwinokno'].v
		elseif win_state['kirkawin'].v then
			win_state['kirkawin'].v = not win_state['kirkawin'].v
		elseif win_state['tochilki'].v then
			win_state['tochilki'].v = not win_state['tochilki'].v
		elseif win_state['pcoff'].v then
			win_state['pcoff'].v = not win_state['pcoff'].v
		elseif win_state['winprofile'].v then
			win_state['winprofile'].v = not win_state['winprofile'].v
		elseif win_state['windowspusk'].v then
			win_state['windowspusk'].v = not win_state['windowspusk'].v
		elseif win_state['piar'].v then
			win_state['piar'].v = not win_state['piar'].v
		elseif win_state['skup'].v then
			win_state['skup'].v = not win_state['skup'].v
		elseif win_state['skup2'].v then
			win_state['skup2'].v = not win_state['skup2'].v
		elseif win_state['skup3'].v then
			win_state['skup3'].v = not win_state['skup3'].v
		elseif win_state['oscripte'].v then
			win_state['oscripte'].v = not win_state['oscripte'].v
		elseif win_state['oscriptepeople'].v then
			win_state['oscriptepeople'].v = not win_state['oscriptepeople'].v
		elseif win_state['shema'].v then
			win_state['shema'].v = not win_state['shema'].v
		elseif win_state['tup'].v then
			win_state['tup'].v = not win_state['tup'].v
		elseif win_state['timeyved'].v then
			win_state['timeyved'].v = not win_state['timeyved'].v
		elseif win_state['carsas'].v then
			win_state['carsas'].v = not win_state['carsas'].v
		elseif win_state['info'].v then
			win_state['info'].v = not win_state['info'].v
		elseif menu_spur.v then
			menu_spur.v = not menu_spur.v
		end
		if win_state['shemainst'].v then
			win_state['shemainst'].v = not win_state['shemainst'].v
		elseif win_state['shematext'].v then
			win_state['shematext'].v = not win_state['shematext'].v
		elseif win_state['shemafunks'].v then
			win_state['shemafunks'].v = not win_state['shemafunks'].v
		elseif win_state['redak'].v then
			win_state['redak'].v = not win_state['redak'].v
		elseif win_state['games'].v then
			win_state['games'].v = not win_state['games'].v
		elseif win_state['shahtamenu'].v then
			win_state['shahtamenu'].v = not win_state['shahtamenu'].v
		elseif win_state['skupshema'].v then
			win_state['skupshema'].v = not win_state['skupshema'].v
		elseif win_state['pravila2048'].v then
			win_state['pravila2048'].v = not win_state['pravila2048'].v
		elseif win_state['pravilapong'].v then
			win_state['pravilapong'].v = not win_state['pravilapong'].v
		elseif win_state['pravilasnake'].v then
			win_state['pravilasnake'].v = not win_state['pravilasnake'].v
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
	Namenick = userNick:gsub("_.*", "")
	Famnick = userNick:gsub(".*_", "")
	files_add()
	winbackground = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/img0.png')
    winpusk = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/pusk.png')
    winedge = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/edge.png')
    winsetting = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/settingwin.png')
	winyashik = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/sunduk.png')
	windollar = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/dollar.png')
	winphone = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/phone.png')
	wintelega = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/telega.png')
	win2048 = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/2048.png')
	winpingpong = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/pingpong.png')
	winsnakegame = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/snakegame.png')
	winnotes = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/notes.png')
	winbitkoin = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/bitcoin.png')
	winkirka = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/kirka.png')
	winhelper = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/helper.png')
	wininfo = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/info.png')
	wintochkamen = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/tochkamen.png')
	winuser = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/user.png')
	winoffpc = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/offpc.png')
	winreload = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/reload.png')
	wintrade = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/trade.png')
	winup = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/up.png')
	windown = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/down.png')
	winleft = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/left.png')
	winright = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/right.png')
	winarizonanews = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/arizonanews.png')
	wintools3 = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/tools3.0.png')
	winmonopolynews = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/monopolynews.png')
	winaforma = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/aforma.png')
	winarzupdate = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/arzupdate.png')
	winprazdnik = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/prazdnik.png')
	winrobot = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/robot.png')
	winbomj = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/bomj.png')
	winmessage = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/messanger.png')
	podklchat()
	sampAddChatMessage("[Mono Tools]{FFFFFF} Скрипт успешно запущен! Версия: {00C2BB}"..thisScript().version.."{FFFFFF}. Активация: {00C2BB}/"..activator.v.."{FFFFFF}. Тестовые обновления: {00C2BB}/tu", 0x046D63)
	
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
	lua_thread.create(informerperemshahta)
	lua_thread.create(informerperempismo)
	lua_thread.create(rouletteyashik)
	lua_thread.create(roulette)
	lua_thread.create(piarad)
	lua_thread.create(raznoe)
	lua_thread.create(shemamain)
	lua_thread.create(ponggame)
	lua_thread.create(eating)
	lua_thread.create(shahta)
	lua_thread.create(snakegaming)
	lua_thread.create(calculator)
	lua_thread.create(rpgunsin)
	lua_thread.create(strobe)
	lua_thread.create(obnovlenie)
	lua_thread.create(findi)
	lua_thread.create(autobmx)
	lua_thread.create(connectarz)
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
	sampRegisterChatCommand('tu', testupdate) -- регистрируем команду
	sampRegisterChatCommand('mc', monochat) -- регистрируем команду
	sampRegisterChatCommand('pm', pmchat) -- регистрируем команду
	sampRegisterChatCommand("strobes", function()
		if isCharInAnyCar(PLAYER_PED) then
			local car = storeCarCharIsInNoSave(PLAYER_PED)
			local driverPed = getDriverOfCar(car)
			
			if PLAYER_PED == driverPed then
				local state = not isCarSirenOn(car)
				switchCarSiren(car, state)
			end
		end
	end)
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
		if not sampIsChatInputActive() and isKeyJustPressed(u8:decode(autoklavareload.v)) then thisScript():reload() end
		if not sampIsChatInputActive() and isKeyJustPressed(u8:decode(autoklava.v)) then mainmenu() end
		if not sampIsChatInputActive() and isKeyJustPressed(u8:decode(autodronev2.v)) and isKeyJustPressed(u8:decode(autodrone.v)) then drone() end
		
		armourNew = getCharArmour(PLAYER_PED) -- получаем броню
		healNew = getCharHealth(PLAYER_PED) -- получаем ХП
		interior = getActiveInterior() -- получаем инту
		
		local chatstring = sampGetChatString(99)
        if chatstring == "You are banned from this server." and recongen.v then
        sampDisconnectWithReason(false)
            wait(1000) -- задержка
            sampSetGamestate(1)
		end
		
		-- получение названия района на инглише(работает только при включенном английском в настройках игры, иначе иероглифы)
		local zX, zY, zZ = getCharCoordinates(playerPed)
		ZoneInGame = getGxtText(getNameOfZone(zX, zY, zZ))
		
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
		
		imgui.Process = win_state['regst'].v or win_state['main'].v or win_state['update'].v or win_state['player'].v or win_state['base'].v or win_state['informer'].v or win_state['pismoinformer'].v or win_state['prazdnikwin'].v or win_state['robotwin'].v or win_state['bomjwin'].v or win_state['shahtainformer'].v or win_state['renew'].v or win_state['find'].v or win_state['ass'].v or win_state['leave'].v or win_state['games'].v or win_state['redak'].v or win_state['shahtamenu'].v or win_state['shematext'].v or win_state['shemainst'].v or win_state['pravila2048'].v or win_state['pravilapong'].v or win_state['pravilasnake'].v or win_state['tup'].v or win_state['timeyved'].v or ok or help
		
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
		
		if styletest.v then -- стили
			apply_custom_style()
			end
		if styletest1.v then -- стили
			apply_custom_style1()
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
		for i = 0, sampGetMaxPlayerId(true) do
			if sampIsPlayerConnected(i) then
				local result, ped = sampGetCharHandleBySampPlayerId(i)
				if result then
					local positionX, positionY, positionZ = getCharCoordinates(ped)
					local localX, localY, localZ = getCharCoordinates(PLAYER_PED)
					local distance = getDistanceBetweenCoords3d(positionX, positionY, positionZ, localX, localY, localZ)
					if distance >= 1 and droneActive and developMode ~= 1 then
						EmulShowNameTag(i, false)
					elseif droneActive and developMode == 1 then
						EmulShowNameTag(i, true)
					else
						EmulShowNameTag(i, true)
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
	imgui.ReleaseTexture(winbackground)
	imgui.ReleaseTexture(winpusk)
	imgui.ReleaseTexture(winsetting)
	imgui.ReleaseTexture(winedge)
	imgui.ReleaseTexture(winyashik)
	imgui.ReleaseTexture(windollar)
	imgui.ReleaseTexture(winphone)
	imgui.ReleaseTexture(wintelega)
	imgui.ReleaseTexture(win2048)
	imgui.ReleaseTexture(winpinpong)
	imgui.ReleaseTexture(winsnakegame)
	imgui.ReleaseTexture(winnotes)
	imgui.ReleaseTexture(winbitkoin)
	imgui.ReleaseTexture(winkirka)
	imgui.ReleaseTexture(winhelper)
	imgui.ReleaseTexture(wininfo)
	imgui.ReleaseTexture(wintochkamen)
	imgui.ReleaseTexture(winuser)
	imgui.ReleaseTexture(winoffpc)
	imgui.ReleaseTexture(winreload)
	imgui.ReleaseTexture(wintrade)
	imgui.ReleaseTexture(winup)
	imgui.ReleaseTexture(windown)
	imgui.ReleaseTexture(winright)
	imgui.ReleaseTexture(winleft)
	imgui.ReleaseTexture(winarizonanews)
	imgui.ReleaseTexture(wintools3)
	imgui.ReleaseTexture(winmonopolynews)
	imgui.ReleaseTexture(winaforma)
	imgui.ReleaseTexture(winarzupdate)
	imgui.ReleaseTexture(winprazdnik)
	imgui.ReleaseTexture(winrobot)
	imgui.ReleaseTexture(winbomj)
	imgui.ReleaseTexture(winmessage)
end

function onScriptTerminate(script, quitGame)
	if script == thisScript() then
		showCursor(false)
		saveSettings(1)
		saveJson(cfg1, jsonDir) 
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
	
	ini.shahtainformer.kamen = infkamen.v
	ini.shahtainformer.metal = infmetal.v
	ini.shahtainformer.bronza = infbronza.v
	ini.shahtainformer.silver = infsilver.v
	ini.shahtainformer.gold = infgold.v
	ini.shahtainformer.zp = infzp.v
	ini.shahtainformer.sbor = infsbor.v
	
	ini.settings.assistant = assistant.v
	ini.settings.assistant1 = assistant1.v
	ini.settings.assistant2 = assistant2.v
	ini.settings.keyT = keyT.v
	ini.settings.launcher = launcher.v
	ini.settings.adcounter = adcounter.v
	ini.settings.deagle = deagle.v
	ini.settings.awp = awp.v
	ini.settings.m4 = m4.v
	ini.settings.uzi = uzi.v
	ini.settings.ak47 = ak47.v
	ini.settings.tazer = tazer.v
	ini.settings.ybral = ybral.v
	ini.settings.mp5 = mp5.v
	ini.settings.otgun = otgun.v
	ini.settings.bindreshim = bindreshim.v
	ini.settings.droneoption = droneoption.v
	ini.settings.shotgun = shotgun.v
	ini.settings.rifle = rifle.v
	ini.settings.knife = knife.v
	ini.settings.launcherpc = launcherpc.v
	ini.settings.launcherm = launcherm.v
	ini.settings.autochat = autochat.v
	ini.settings.chatmessage = chatmessage.v
	ini.settings.eat = eat.v
	ini.settings.eathouse = eathouse.v
	ini.settings.eatmyso = eatmyso.v
	ini.settings.mvdhelp = mvdhelp.v
	ini.settings.antilomka = antilomka.v
	ini.settings.napominalka = napominalka.v
	ini.settings.chatcalc = chatcalc.v
	ini.settings.pismo = pismo.v
	ini.settings.yashik = yashik.v
	ini.settings.yashik1 = yashik1.v
	ini.settings.yashik2 = yashik2.v
	ini.settings.yashik3 = yashik3.v
	ini.settings.otkrytie = otkrytie.v
	ini.settings.otkrytie2 = otkrytie2.v
	ini.settings.ndr = ndr.v
	ini.settings.toch = toch.v
	ini.settings.autobike = autobike.v
	ini.settings.styletest = styletest.v
	ini.settings.styletest1 = styletest1.v
	ini.settings.timefix = timefix.v
	ini.settings.enableskin = enableskin.v
	ini.settings.skin = localskin.v
	ini.settings.timecout = timecout.v
	ini.settings.gangzones = gangzones.v
	ini.settings.ryda = ryda.v
	ini.settings.zones = zones.v
	ini.settings.chatInfo = chatInfo.v
	ini.settings.raskladka = raskladka.v
	ini.settings.recongen = recongen.v
	ini.settings.carsis = carsis.v
	ini.settings.infoX = infoX
	ini.settings.infoY = infoY
	ini.settings.infoX2 = infoX2
	ini.settings.infoY2 = infoY2
	ini.settings.infoX3 = infoX3
	ini.settings.infoY3 = infoY3
	ini.settings.infoX4 = infoX4
	ini.settings.infoY4 = infoY4
	ini.settings.findX = findX
	ini.settings.findY = findY
	ini.settings.tag = u8:decode(rtag.v)
	
	ini.settings.autokamen = u8:decode(autokamen.v)
	ini.settings.autometal = u8:decode(autometal.v)
	ini.settings.autobronza = u8:decode(autobronza.v)
	ini.settings.autosilver = u8:decode(autosilver.v)
	ini.settings.autogold = u8:decode(autogold.v)
	
	ini.settings.kdpusk = u8:decode(kdpusk.v)
	ini.settings.napominalkadata = u8:decode(napominalkadata.v)
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
	ini.settings.watertext = u8:decode(watertext.v)
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
	ini.settings.autodrone = u8:decode(autodrone.v)
	ini.settings.autodronev2 = u8:decode(autodronev2.v)
	ini.settings.autodronev3 = u8:decode(autodronev3.v)
	ini.settings.autodronev4 = u8:decode(autodronev4.v)
	ini.settings.pismoreal = u8:decode(pismoreal.v)
	ini.settings.pismoreal1 = u8:decode(pismoreal1.v)
	ini.settings.pismoreal2 = u8:decode(pismoreal2.v)
	ini.settings.pismoreal3 = u8:decode(pismoreal3.v)
	ini.settings.pismoreal4 = u8:decode(pismoreal4.v)
	ini.settings.adsec = u8:decode(adsec.v)
	ini.settings.vipadsec = u8:decode(vipadsec.v)
	ini.settings.famadsec = u8:decode(famadsec.v)
	ini.settings.vradsec = u8:decode(vradsec.v)
	ini.settings.sadsec = u8:decode(sadsec.v)
	ini.settings.adredak = u8:decode(adredak.v)
	ini.settings.activator = u8:decode(activator.v)
	ini.settings.autologin = autologin.v
	ini.settings.dialogupdate = dialogupdate.v
	ini.settings.dialogfix = dialogfix.v
	ini.settings.autoryda = autoryda.v
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
	
	ini.settings.skuptravacol = u8:decode(skuptravacol.v)
	ini.settings.skuptravacena = u8:decode(skuptravacena.v)
	ini.settings.skupbronzarulcol = u8:decode(skupbronzarulcol.v)
	ini.settings.skupbronzarulcena = u8:decode(skupbronzarulcena.v)
	ini.settings.skupserebrorulcol = u8:decode(skupserebrorulcol.v)
	ini.settings.skupserebrorulcena = u8:decode(skupserebrorulcena.v)
	ini.settings.skupgoldrulcol = u8:decode(skupgoldrulcol.v)
	ini.settings.skupgoldrulcena = u8:decode(skupgoldrulcena.v)
	ini.settings.skupplatinarulcol = u8:decode(skupplatinarulcol.v)
	ini.settings.skupplatinarulcena = u8:decode(skupplatinarulcena.v)
	ini.settings.skupkamencol = u8:decode(skupkamencol.v)
	ini.settings.skupkamencena = u8:decode(skupkamencena.v)
	ini.settings.skupmetalcol = u8:decode(skupmetalcol.v)
	ini.settings.skupmetalcena = u8:decode(skupmetalcena.v)
	ini.settings.skupbronzacol = u8:decode(skupbronzacol.v)
	ini.settings.skupbronzacena = u8:decode(skupbronzacena.v)
	ini.settings.skupserebrocol = u8:decode(skupserebrocol.v)
	ini.settings.skupserebrocena = u8:decode(skupserebrocena.v)
	ini.settings.skupgoldcol = u8:decode(skupgoldcol.v)
	ini.settings.skupgoldcena = u8:decode(skupgoldcena.v)
	ini.settings.skuppodarkicol = u8:decode(skuppodarkicol.v)
	ini.settings.skuppodarkicena = u8:decode(skuppodarkicena.v)
	ini.settings.skuptaloncol = u8:decode(skuptaloncol.v)
	ini.settings.skuptaloncena = u8:decode(skuptaloncena.v)
	ini.settings.skupsemtaloncol = u8:decode(skupsemtaloncol.v)
	ini.settings.skupsemtaloncena = u8:decode(skupsemtaloncena.v)
	ini.settings.skupskidtaloncol = u8:decode(skupskidtaloncol.v)
	ini.settings.skupskidtaloncena = u8:decode(skupskidtaloncena.v)
	ini.settings.skuptochkamencol = u8:decode(skuptochkamencol.v)
	ini.settings.skuptochkamencena = u8:decode(skuptochkamencena.v)
	ini.settings.skuptochamuletcena = u8:decode(skuptochamuletcena.v)
	ini.settings.skuplareccol = u8:decode(skuplareccol.v)
	ini.settings.skuplareccena = u8:decode(skuplareccena.v)
	ini.settings.skupttcena = u8:decode(skupttcena.v)
	ini.settings.skupmonetacol = u8:decode(skupmonetacol.v)
	ini.settings.skupmonetacena = u8:decode(skupmonetacena.v)
	ini.settings.skuplencol = u8:decode(skuplencol.v)
	ini.settings.skuplencena = u8:decode(skuplencena.v)
	ini.settings.skupxlopokcol = u8:decode(skupxlopokcol.v)
	ini.settings.skupxlopokcena = u8:decode(skupxlopokcena.v)
	ini.settings.skuprespektcol = u8:decode(skuprespektcol.v)
	ini.settings.skuprespektcena = u8:decode(skuprespektcena.v)
	ini.settings.skupmaterialcol = u8:decode(skupmaterialcol.v)
	ini.settings.skupmaterialcena = u8:decode(skupmaterialcena.v)
	ini.settings.skupdrovacol = u8:decode(skupdrovacol.v)
	ini.settings.skupdrovacena = u8:decode(skupdrovacena.v)
	ini.settings.skupantibiotikcol = u8:decode(skupantibiotikcol.v)
	ini.settings.skupantibiotikcena = u8:decode(skupantibiotikcena.v)
	ini.settings.skuptsrcol = u8:decode(skuptsrcol.v)
	ini.settings.skuptsrcena = u8:decode(skuptsrcena.v)
	ini.settings.skupsemmonetacol = u8:decode(skupsemmonetacol.v)
	ini.settings.skupsemmonetacena = u8:decode(skupsemmonetacena.v)
	ini.settings.skupautocena = u8:decode(skupautocena.v)
	
	ini.settings.skuptrava = skuptrava.v
	ini.settings.skupbronzarul = skupbronzarul.v
	ini.settings.skupserebrorul = skupserebrorul.v
	ini.settings.skupgoldrul = skupgoldrul.v
	ini.settings.skupplatinarul = skupplatinarul.v
	ini.settings.skupkamen = skupkamen.v
	ini.settings.skupmetal = skupmetal.v
	ini.settings.skupbronza = skupbronza.v
	ini.settings.skupserebro = skupserebro.v
	ini.settings.skupgold = skupgold.v
	ini.settings.skuppodarki = skuppodarki.v
	ini.settings.skuptalon = skuptalon.v
	ini.settings.skupsemtalon = skupsemtalon.v
	ini.settings.skupskidtalon = skupskidtalon.v
	ini.settings.skuptochkamen = skuptochkamen.v
	ini.settings.skuptochamulet = skuptochamulet.v
	ini.settings.skuplarec = skuplarec.v
	ini.settings.skuptt = skuptt.v
	ini.settings.skupmoneta = skupmoneta.v
	ini.settings.skuplen = skuplen.v
	ini.settings.skupxlopok = skupxlopok.v
	ini.settings.skuprespekt = skuprespekt.v
	ini.settings.skupmaterial = skupmaterial.v
	ini.settings.skupdrova = skupdrova.v
	ini.settings.skupantibiotik = skupantibiotik.v
	ini.settings.skuptsr = skuptsr.v
	ini.settings.skupsemmoneta = skupsemmoneta.v
	ini.settings.skupauto = skupauto.v

	ini.assistant.asX = asX
	ini.assistant.asY = asY
	ini.assistant1.asX3 = asX3
	ini.assistant1.asY3 = asY3
	ini.assistant2.asX4 = asX4
	ini.assistant2.asY4 = asY4

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
	if title:find("Авторизация") and text:find("Добро пожаловать") and not text:find('Неверный пароль!') and autologin.v then -- автологин
		sampSendDialogResponse(dialogId, 1, -1, u8:decode(autopass.v))
		return false
	elseif text:find('Неверный пароль!') then
	sampAddChatMessage('[Mono Tools]{FFFFFF} В настройках скрипта указан неверный пароль! Измените его в настройках или вводите вручную.', 0x046D63)
	end
	if dialogId == 991 and autopin.v then 
		sampSendDialogResponse(dialogId, 1, 0, u8:decode(autopasspin.v))
		return false
	end
	for line in text:gmatch("[^\n]+") do
	if line:find('PIN-код принят!') and autopin.v then
		closeDialog()
		end
	end
	if dialogId == 15330 and dialogupdate.v then
	closeDialog()
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
	if dialogId == 15346 and adcounter.v then
	sendad()
	end
	for line in text:gmatch("[^\n]+") do
	if line:find('Вы были кикнуты за подозрение в читерстве') and recongen.v then
            recongenmenu()
        end
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
  if checked_test5.v and active and otkrytie.v then
    lua_thread.create(function()
	 if data.modelId == 19918 then
		wait(1000)
        sampSendClickTextdraw(id)
		use = true
      end
      if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use and otkrytie.v then
        clickID = id + 1
		wait(500)
        sampSendClickTextdraw(clickID)
        use = false
        close = true
      end
      if close and otkrytie.v then
        wait(300)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
        close = false
        active = false
      end
    end)
  end
  if checked_test6.v and active1 and otkrytie.v then
    lua_thread.create(function()
      if data.modelId == 19613 then
		wait(1000)
        sampSendClickTextdraw(id)
        use1 = true
      end
      if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use1 and otkrytie.v then
        clickID = id + 1
		wait(500)
        sampSendClickTextdraw(clickID)
        use1 = false
        close1 = true
      end
      if close1 and otkrytie.v then
        wait(300)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
        close1 = false
        active1 = false
      end
    end)
  end
  if checked_test7.v and active2 and otkrytie.v then
    lua_thread.create(function()
      if data.modelId == 1353 then
        wait(1000)
        sampSendClickTextdraw(id)
        use2 = true
      end
      if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use2 and otkrytie.v then
        clickID = id + 1
		wait(500)
        sampSendClickTextdraw(clickID)
        use2 = false
        close2 = true
      end
      if close2 and otkrytie.v then
        wait(300)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
        close2 = false
        active2 = false
      end
    end)
  end
    if checked_test8.v and active3 and otkrytie.v then
    lua_thread.create(function()
      if data.modelId == 1240 then
        wait(1000)
        sampSendClickTextdraw(id)
        use3 = true
      end
      if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use3 and otkrytie.v then 
        clickID = id + 1
		wait(500)
        sampSendClickTextdraw(clickID)
		wait(1000)
		sampSendClickTextdraw(2048)
		use3 = false
		close3 = true
	  end
      if close3 and otkrytie.v then
        wait(300)
        setVirtualKeyDown(VK_ESCAPE, true)
		wait(111)
		setVirtualKeyDown(VK_ESCAPE, false)
		close3 = false
        active3 = false
	   end
    end)
  end
  if checked_test9.v and active4 and otkrytie.v then
    lua_thread.create(function()
      if data.modelId == 1240 then
        wait(1000)
        sampSendClickTextdraw(id)
        use4 = true
      end
      if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use4 and otkrytie.v then
        clickID = id + 1
		wait(500)
        sampSendClickTextdraw(clickID)
        use4 = false
        close4 = true
      end
      if close4 and otkrytie.v then
        wait(300)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
        close4 = false
        active4 = false
      end
    end)
  end
	if checked_test10.v and active5 and otkrytie.v then
    lua_thread.create(function()
      if data.modelId == 1733 then
        wait(1000)
        sampSendClickTextdraw(id)
        use5 = true
      end
      if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use5 and otkrytie.v then
        clickID = id + 1
		wait(500)
        sampSendClickTextdraw(clickID)
        use5 = false
        close5 = true
      end
      if close5 and otkrytie.v then
        wait(300)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
        close5 = false
        active5 = false
      end
    end)
  end
	if yashik.v and active and otkrytie.v then
    lua_thread.create(function()
      if data.modelId == 19918 then
        wait(1000)
        sampSendClickTextdraw(id)
        use = true
      end
      if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use and otkrytie.v then
        clickID = id + 1
		wait(500)
        sampSendClickTextdraw(clickID)
        use = false
        close = true
      end
      if close and otkrytie.v then
        wait(300)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
        close = false
        active = false
      end
    end)
  end
  if yashik1.v and active1 and otkrytie.v then
    lua_thread.create(function()
      if data.modelId == 19613 then
        wait(1000)
        sampSendClickTextdraw(id)
        use1 = true
      end
      if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use1 and otkrytie.v then
        clickID = id + 1
		wait(500)
        sampSendClickTextdraw(clickID)
        use1 = false
        close1 = true
      end
      if close1 and otkrytie.v then
        wait(300)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
        close1 = false
        active1 = false
      end
    end)
  end
  if yashik2.v and active2 and otkrytie.v then
    lua_thread.create(function()
      if data.modelId == 1353 then
        wait(1000)
        sampSendClickTextdraw(id)
        use2 = true
      end
      if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use2 and otkrytie.v then
        clickID = id + 1
		wait(500)
        sampSendClickTextdraw(clickID)
        use2 = false
        close2 = true
      end
      if close2 and otkrytie.v then
        wait(300)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
        close2 = false
        active2 = false
      end
    end)
  end
	if yashik3.v and active5 and otkrytie.v then
    lua_thread.create(function()
      if data.modelId == 1733 then
        wait(1000)
        sampSendClickTextdraw(id)
        use3 = true
      end
      if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use3 and otkrytie.v then
        clickID = id + 1
		wait(500)
        sampSendClickTextdraw(clickID)
        use3 = false
        close3 = true
      end
      if close3 and otkrytie.v then
        wait(300)
        sampSendClickTextdraw(2110)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
        close3 = false
        active3 = false
      end
    end)
  end
	 if checked_test5.v and active and otkrytie2.v then
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
  if checked_test6.v and active1 and otkrytie2.v then
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
  if checked_test7.v and active2 and otkrytie2.v then
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
    if checked_test8.v and active3 and otkrytie2.v then
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
  if checked_test9.v and active4 and otkrytie2.v then
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
	if checked_test10.v and active5 and otkrytie2.v then
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
	if yashik.v and active and otkrytie2.v then
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
  if yashik1.v and active1 and otkrytie2.v then
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
  if yashik2.v and active2 and otkrytie2.v then
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
	if yashik3.v and active5 and otkrytie2.v then
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
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
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendDialogResponse(15281, 1 , 1, -1)
        close41 = false
        active41 = false
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
	sampSendClickTextdraw(2110)
	wait(300)
	sendKey(128)
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
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Все выбранные вами налоги успешно оплачены!", 0x046D63)
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
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Все выбранные вами налоги успешно оплачены!", 0x046D63)
end)
end

function sendad()
	lua_thread.create(function() -- начало потока
	sampSendDialogResponse(15346, 1, 1, -1)
	wait(200)
	sampSendDialogResponse(15347, 1, 0, -1)
	wait(100)
	closeDialog()
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
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Все выбранные вами налоги успешно оплачены!", 0x046D63)
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
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Все выбранные вами налоги успешно оплачены!", 0x046D63)
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
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Все выбранные вами налоги успешно оплачены!", 0x046D63)
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
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Все выбранные вами налоги успешно оплачены!", 0x046D63)
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
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Все выбранные вами налоги успешно оплачены!", 0x046D63)
end)
end

function testupdate()
win_state['tup'].v = not win_state['tup'].v
end

function monochat(params)
    if not connected then chatmsg("Вы не подключены к серверу.") return end
    local tempField = string.match(params, "(.*)")
	if tempField == nil or tempField == "" then chatmsg("Используйте: /mc [Сообщение]") return end
    s:sendChat(chats[window_selected], u8(tempField))
    if window_selected ~= 0 then table.insert(messages[chats[window_selected]], string.format("%s: %s", cfg1.message.nick, tempField)) end
	if chatmessage.v then
    sampAddChatMessage("[#monotools] {A77BCA}"..cfg1.message.nick..": {FFFFFF}"..tempField, 0x046D63)
	end
end

function pmchat(params)
    if not connected then chatmsg("Вы не подключены к серверу.") return end
    local toNick, msg = string.match(params, "(%S+) (.*)")
	if toNick == nil or toNick == '' or msg == nil or msg == "" then chatmsg("Используйте: /pm [Ник] [Сообщение]") return end
    s:send(u8(string.format("PRIVMSG %s :%s", toNick, msg)))
    if window_selected ~= 0 then table.insert(messages[chats[window_selected]], string.format("{A77BCA}[PM >> %s]: %s", toNick, msg)) end
	if chatmessage.v then
    sampAddChatMessage("[#monotools] {A77BCA}[PM >> "..toNick.."]: {FFFFFF}"..msg, 0x046D63)
	end
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
	wait(100)
	sampDisconnectWithReason(quit)
	wait(600000)
	sampSetGamestate(1)
end)
end

function recongenmenu()
	lua_thread.create(function()
	wait(100)
	sampDisconnectWithReason(quit)
	wait(15000)
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
 
	local height = imgui.GetTextLineHeightWithSpacing() + (imgui.GetStyle().FramePadding.y / 0.9)
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
	draw_list:AddCircleFilled(imgui.ImVec2(p.x + radius + t * (width - radius * 2.0), p.y + radius), radius - 1.5, imgui.GetColorU32(bool.v and imgui.GetStyle().Colors[imgui.Col.ButtonActive] or imgui.GetStyle().Colors[imgui.Col.FrameBg]))
 
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
	local btn_size25 = imgui.ImVec2(394, 23)
	local input = sampGetInputInfoPtr()
    local input = getStructElement(input, 0x8, 4)
    local windowPosX = getStructElement(input, 0x8, 4)
    local windowPosY = getStructElement(input, 0xC, 4)

	imgui.ShowCursor = not win_state['informer'].v and not win_state['pismoinformer'].v and not win_state['shahtainformer'].v and not win_state['prazdnikwin'].v and not win_state['robotwin'].v and not win_state['bomjwin'].v and not win_state['ass'].v and not win_state['find'].v or win_state['main'].v or win_state['base'].v or win_state['update'].v or win_state['player'].v or win_state['regst'].v or win_state['renew'].v or win_state['leave'].v 
	
	if not win_state['main'].v then 
          imgui.Process = false
       end
	  
	if not win_state['main'].v and win_state['informer'].v then 
          imgui.Process = true
       end
	   
	if not win_state['main'].v and win_state['prazdnikwin'].v then 
          imgui.Process = true
       end
	   
	if not win_state['main'].v and win_state['robotwin'].v then 
          imgui.Process = true
       end
	   
	if not win_state['main'].v and win_state['bomjwin'].v then 
          imgui.Process = true
       end
	   
	if not win_state['main'].v and win_state['pismoinformer'].v then 
          imgui.Process = true
       end
	   
	if not win_state['main'].v and win_state['shahtainformer'].v then 
          imgui.Process = true
       end
	   
	if not win_state['main'].v and win_state['tup'].v then
		 imgui.Process = true
       end
	   
	if not win_state['main'].v and win_state['timeyved'].v then
		 imgui.Process = true
       end
	   
	if win_state['skup'].v or win_state['skup2'].v or win_state['skup3'].v then
		 win_state['skupshema'].v = true
	else
		win_state['skupshema'].v = false
       end
	   
	if win_state['games'].v then
		 win_state['pravila2048'].v = true
	else
		win_state['pravila2048'].v = false
       end
	   
	if pong then
		 win_state['pravilapong'].v = true
	else
		win_state['pravilapong'].v = false
       end
	   
	if snaketaken then
		 win_state['pravilasnake'].v = true
	else
		win_state['pravilasnake'].v = false
       end
	   
	 
    if sampIsChatInputActive() and chatcalc.v and ok then
        imgui.SetNextWindowPos(imgui.ImVec2(windowPosX, windowPosY + 30 + 15), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(result:len()*10, 50))
        imgui.Begin('Solve', window, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
        imgui.Text('')
		imgui.CenterText(u8(number_separator(result)))
        imgui.End()
    end
        if sampIsChatInputActive() and chatcalc.v and help then
            imgui.SetNextWindowPos(imgui.ImVec2(windowPosX, windowPosY + 30 + 15), imgui.Cond.FirstUseEver)
            imgui.SetNextWindowSize(imgui.ImVec2(765, 150))
            imgui.Begin('Help', window2, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
			imgui.Text('')
            imgui.Text(u8[[  23%/100 - найти число исхода из процента. 23 - это процент, 100 это сколько составлает этот процент от неизвестного числа.
  23 процента равные числу 100, в 100 процентах будет 434.
  -
  23%*100 - найти число, которое составл¤ет количество процентов. 23 - это количество процентов, 100 - число от которого 
  нужно найти процент. 23 процента от числа 100 - это 23.
  -
  23/100% - найти процентное соотношение двух чисел. 23 - это число, процентное соотношение от числа 100. Число 23 
  составляет 23 процента от числа 100.]])
            imgui.End()
        end
	   
	if win_state['main'].v then -- основное окошко
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(1000, 652), imgui.Cond.FirstUseEver)
		imgui.Begin(u8'Mono Tools', win_state['main'], imgui.WindowFlags.NoResize)
		imgui.Image(winbackground, imgui.ImVec2(1000, 570), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1))
	imgui.Text('')
	imgui.SameLine(335)	
	if imgui.ImageButton(winpusk, imgui.ImVec2(40, 40), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['windowspusk'].v = not win_state['windowspusk'].v end
	imgui.SameLine()
	if imgui.ImageButton(winsetting, imgui.ImVec2(40, 40), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['nastroikawin'].v = not win_state['nastroikawin'].v end
	imgui.SameLine()
	if imgui.ImageButton(winmessage, imgui.ImVec2(40, 40), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['messanger'].v = not win_state['messanger'].v end
	imgui.SameLine()
	if imgui.ImageButton(winhelper, imgui.ImVec2(40, 40), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['help'].v = not win_state['help'].v end
	imgui.SameLine()
	if imgui.ImageButton(wininfo, imgui.ImVec2(40, 40), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['oscripte'].v = not win_state['oscripte'].v end
	imgui.SameLine()
	if imgui.ImageButton(winedge, imgui.ImVec2(40, 40), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['googlewin'].v = not win_state['googlewin'].v end
	imgui.End()
	end
	
	if win_state['windowspusk'].v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(515, 520), imgui.Cond.FirstUseEver)
		imgui.Begin(u8'##windowspusk', win_state['windowspusk'], imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
				imgui.BeginChild('##asdasasddf3221', imgui.ImVec2(800, 520), false)
				imgui.SameLine(15) 
				if imgui.ImageButton(winyashik, imgui.ImVec2(50, 50), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['yashiki'].v = not win_state['yashiki'].v win_state['windowspusk'].v = false end
				imgui.SameLine(100) 
				if imgui.ImageButton(windollar, imgui.ImVec2(50, 50), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['bank'].v = not win_state['bank'].v win_state['windowspusk'].v = false end
				imgui.SameLine(185)
				if imgui.ImageButton(winphone, imgui.ImVec2(50, 50), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['piar'].v = not win_state['piar'].v win_state['windowspusk'].v = false end
				imgui.SameLine(270)
				if imgui.ImageButton(wintelega, imgui.ImVec2(50, 50), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['skup'].v = not win_state['skup'].v win_state['skup2'].v = false win_state['skup3'].v = false win_state['windowspusk'].v = false end
				imgui.SameLine(355)
				if imgui.ImageButton(win2048, imgui.ImVec2(50, 50), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['games'].v = not win_state['games'].v win_state['windowspusk'].v = false end
				imgui.SameLine(440)
				if imgui.ImageButton(winpingpong, imgui.ImVec2(50, 50), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then pong = not pong win_state['windowspusk'].v = false win_state['main'].v = false win_state['pravilapong'].v = true end
				
				
				imgui.Text('') imgui.SameLine(5) imgui.Text(u8"Roulette Tools")
				imgui.SameLine(100) 
				imgui.Text('') imgui.SameLine(100) imgui.Text(u8"Bank Menu")
				imgui.SameLine(100) 
				imgui.Text('') imgui.SameLine(188) imgui.Text(u8"Piar Menu")
				imgui.SameLine(100) 
				imgui.Text('') imgui.SameLine(270) imgui.Text(u8"Skup Menu")
				imgui.SameLine(100) 
				imgui.Text('') imgui.SameLine(370) imgui.Text(u8"2048")
				imgui.SameLine(100) 
				imgui.Text('') imgui.SameLine(458) imgui.Text(u8"Pong")
				
				imgui.Text('') imgui.SameLine(15) 
				if imgui.ImageButton(winsnakegame, imgui.ImVec2(50, 50), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then snaketaken = not snaketaken win_state['windowspusk'].v = false win_state['main'].v = false win_state['pravilasnake'].v = true end
				imgui.SameLine(100) 
				if imgui.ImageButton(winsetting, imgui.ImVec2(50, 50), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['nastroikawin'].v = not win_state['nastroikawin'].v win_state['windowspusk'].v = false end
				imgui.SameLine(185)
				if imgui.ImageButton(winnotes, imgui.ImVec2(50, 50), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['noteswin'].v = not win_state['noteswin'].v win_state['windowspusk'].v = false end
				imgui.SameLine(270)
				if imgui.ImageButton(winbitkoin, imgui.ImVec2(50, 50), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['bitkoinwinokno'].v = not win_state['bitkoinwinokno'].v win_state['shema'].v = not win_state['shema'].v  win_state['shemafunks'].v = not win_state['shemafunks'].v win_state['windowspusk'].v = false end
				imgui.SameLine(355)
				if imgui.ImageButton(winkirka, imgui.ImVec2(50, 50), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['kirkawin'].v = not win_state['kirkawin'].v win_state['windowspusk'].v = false end
				imgui.SameLine(440)
				if imgui.ImageButton(wintochkamen, imgui.ImVec2(50, 50), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['tochilki'].v = not win_state['tochilki'].v win_state['windowspusk'].v = false end
				
				
				imgui.Text('') imgui.SameLine(30) imgui.Text(u8"Snake")
				imgui.SameLine(100) 
				imgui.Text('') imgui.SameLine(97) imgui.Text(u8"Параметры")
				imgui.SameLine(100) 
				imgui.Text('') imgui.SameLine(190) imgui.Text(u8"Заметки")
				imgui.SameLine(100) 
				imgui.Text('') imgui.SameLine(275) imgui.Text(u8"Майнинг")
				imgui.SameLine(100) 
				imgui.Text('') imgui.SameLine(365) imgui.Text(u8"Шахтёр")
				imgui.SameLine(100) 
				imgui.Text('') imgui.SameLine(440) imgui.Text(u8"Toch Menu")
				
				imgui.Text('') imgui.SameLine(15) 
				if imgui.ImageButton(wintrade, imgui.ImVec2(50, 50), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['obmentrade'].v = not win_state['obmentrade'].v win_state['windowspusk'].v = false end
				imgui.SameLine(100) 
				if imgui.ImageButton(wininfo, imgui.ImVec2(50, 50), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['oscripte'].v = not win_state['oscripte'].v win_state['windowspusk'].v = false end
				imgui.SameLine(185) 
				if imgui.ImageButton(winhelper, imgui.ImVec2(50, 50), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['help'].v = not win_state['help'].v win_state['windowspusk'].v = false end
				imgui.SameLine(270) 
				if imgui.ImageButton(winedge, imgui.ImVec2(50, 50), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['googlewin'].v = not win_state['googlewin'].v win_state['windowspusk'].v = false end
				imgui.SameLine(355) 
				if imgui.ImageButton(winarzupdate, imgui.ImVec2(50, 50), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['updatewin'].v = not win_state['updatewin'].v win_state['windowspusk'].v = false end
				imgui.SameLine(440) 
				if imgui.ImageButton(winmessage, imgui.ImVec2(50, 50), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['messanger'].v = not win_state['messanger'].v win_state['windowspusk'].v = false end
				
				imgui.Text('') imgui.SameLine(12) imgui.Text(u8"Trade Menu")
				imgui.SameLine(100) 
				imgui.Text(u8"О скрипте")
				imgui.SameLine(100) 
				imgui.Text('') imgui.SameLine(192) imgui.Text(u8"Помощь")
				imgui.SameLine(100) 
				imgui.Text('') imgui.SameLine(277) imgui.Text(u8"Браузер")
				imgui.SameLine(100) 
				imgui.Text('') imgui.SameLine(342) imgui.Text(u8"Arizona Update")
				imgui.SameLine(100) 
				imgui.Text('') imgui.SameLine(460) imgui.Text(u8"Чат")
				imgui.Text('')
				imgui.Text('')
				imgui.Separator()
				imgui.Text('') imgui.SameLine(120) imgui.Text(u8'ESC - закрывает все окна, кроме основного.')
				imgui.Text('') imgui.SameLine(90) imgui.Text(u8'F3 или установленная вами клавиша - закрывает все окна.')
				imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Перейти в группу VK скрипта (информация, помощь, предложения)', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-293, 0)) then os.execute("start https://vk.com/mono_tools") end
				imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Перейти в группу VK Monopoly (конкурсы, мероприятия, информация)', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-293, 0)) then os.execute("start https://vk.com/monopolyfam") end
				imgui.Separator()
				imgui.Text('')
				imgui.Text('')
				imgui.Separator()
				imgui.Text('')
				imgui.Text('')
				imgui.SameLine(15) if imgui.ImageButton(winuser, imgui.ImVec2(30, 30), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['winprofile'].v = not win_state['winprofile'].v end
				imgui.SameLine(455) if imgui.ImageButton(winoffpc, imgui.ImVec2(30, 30), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) then win_state['pcoff'].v = not win_state['pcoff'].v end
				imgui.Text('')
				imgui.SameLine(18) imgui.Text(u8''..Namenick)
				
				imgui.EndChild()
		imgui.End()
	end
	
	if win_state['yashiki'].v then 
		yashikisroulette()
	end
	
	if win_state['obmentrade'].v then 
		obmenmenu()
	end
	
	if win_state['bank'].v then
		bankmenu()
	end
	
	if win_state['noteswin'].v then
		notesmenu()
	end
	
	if win_state['bitkoinwinokno'].v then
		bitkoinoknomenu()
	end
	
	if win_state['skupshema'].v then
		shemaskup()
	end
	
	if win_state['pravila2048'].v then
		pravila2048menu()
	end
	
	if win_state['pravilapong'].v then
		pravilapongmenu()
	end
	
	if win_state['pravilasnake'].v then
		pravilasnakemenu()
	end
	
	if win_state['shahtamenu'].v then
		shahtared()
	end
	
	if win_state['kirkawin'].v then
		kirkamenu()
	end
	
	if win_state['tochilki'].v then
		tochmenu()
	end
	
	if win_state['pcoff'].v then
		offpcmenu()
	end
	
	if win_state['winprofile'].v then
		winprofilemenu()
	end

	if win_state['shematext'].v then
		shemamenu()
	end

	if win_state['shemainst'].v then
		shemainstr()
	end
	
	if win_state['shemafunks'].v then
		funksmenu()
	end
	
	if win_state['timeyved'].v then
		timeyveddate()
	end
	
	if win_state['help'].v then
		helpmenu()
	end
	
	if win_state['nastroikawin'].v then
		nastroikamenu()
	end
	
	if win_state['googlewin'].v then
		googlewinmenu()
	end
	
	if win_state['updatewin'].v then
		updatewinmenu()
	end
	
	if win_state['messanger'].v then
		messangerwinmenu()
	end
	
	if win_state['prazdnikwin'].v then
		prazdnikwinmenu()
	end
	
	if win_state['robotwin'].v then
		robotwinmenu()
	end
	
	if win_state['bomjwin'].v then
		bomjwinmenu()
	end
	
	if win_state['redak'].v then 
		rpredak()
	end	
	
	if win_state['tup'].v then
		tupupdate()
	end
	
	if win_state['carsas'].v then
		carsax()
	end

	if win_state['shema'].v then
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(-0.69, 0.867))
		imgui.SetNextWindowSize(imgui.ImVec2(296, 375), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' Схема', win_state['shema'], imgui.WindowFlags.NoResize)
				imgui.BeginChild('##asdasasddf461', imgui.ImVec2(800, 340), false)
				imgui.Text('')
				imgui.PushFont(fontsize)
				imgui.Text('') imgui.SameLine() imgui.Text('INVENTORY'); imgui.SameLine(); imgui.Text('       S'); imgui.SameLine(); imgui.Text('  C'); imgui.SameLine(); imgui.Text('  P'); imgui.SameLine(); imgui.Text('  S');
				imgui.PopFont()
				imgui.Text('') imgui.SameLine() imgui.CustomButton(u8'№1', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-752, 40)) imgui.SameLine(); imgui.CustomButton(u8'№2', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№3', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№4', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№5', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№6', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40))
				imgui.Text('') imgui.SameLine() imgui.CustomButton(u8'№7', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-752, 40)) imgui.SameLine(); imgui.CustomButton(u8'№8', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№9', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№10', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№11', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№12', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40))
				imgui.Text('') imgui.SameLine() imgui.CustomButton(u8'№13', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-752, 40)) imgui.SameLine(); imgui.CustomButton(u8'№14', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№15', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№16', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№17', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№18', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40))
				imgui.Text('') imgui.SameLine() imgui.CustomButton(u8'№19', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-752, 40)) imgui.SameLine(); imgui.CustomButton(u8'№20', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№21', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№22', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№23', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№24', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40))
				imgui.Text('') imgui.SameLine() imgui.CustomButton(u8'№25', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-752, 40)) imgui.SameLine(); imgui.CustomButton(u8'№26', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№27', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№28', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№29', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№30', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40))
				imgui.Text('') imgui.SameLine() imgui.CustomButton(u8'№31', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-752, 40)) imgui.SameLine(); imgui.CustomButton(u8'№32', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№33', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№34', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№35', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40)) imgui.SameLine(); imgui.CustomButton(u8'№34', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(40, 40))
				imgui.Text(u8'                           '); imgui.SameLine(); imgui.RadioButton('', hlam, 2); imgui.SameLine(); imgui.RadioButton('', hlam, 1); imgui.SameLine(); imgui.RadioButton('', hlam, 3)
				imgui.EndChild()
		imgui.End()
	end
	
	if win_state['piar'].v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(651, 377), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' Piar Menu ', win_state['piar'], imgui.WindowFlags.NoResize)
				imgui.BeginChild('##asdasasddf323452354321', imgui.ImVec2(651, 353), false)
				getArizonaName()
				imgui.EndChild()
		imgui.End()
	end
	
	if win_state['skup'].v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.728, 0.685))
		imgui.SetNextWindowSize(imgui.ImVec2(688, 475), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' Skup Menu ', win_state['skup'], imgui.WindowFlags.NoResize)
				imgui.BeginChild('##asdasasddf32345235412', imgui.ImVec2(688, 451), false)
				getArizonaSkup()
				imgui.EndChild()
		imgui.End()
	end
	if win_state['skup2'].v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.728, 0.685))
		imgui.SetNextWindowSize(imgui.ImVec2(688, 475), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' Skup Menu ', win_state['skup2'], imgui.WindowFlags.NoResize)
				imgui.BeginChild('##asdasasddf3234432', imgui.ImVec2(688, 451), false)
				getArizonaSkup2str()
				imgui.EndChild()
		imgui.End()
	end
	if win_state['skup3'].v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.728, 0.685))
		imgui.SetNextWindowSize(imgui.ImVec2(688, 475), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' Skup Menu ', win_state['skup3'], imgui.WindowFlags.NoResize)
				imgui.BeginChild('##asdasasddf2121', imgui.ImVec2(688, 437), false)
				getArizonaSkup3str()
				imgui.EndChild()
		imgui.End()
	end
	
	if win_state['games'].v then
		gamelist()
	end
	
	if win_state['oscripte'].v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(655, 215), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' О скрипте ', win_state['oscripte'], imgui.WindowFlags.NoResize)
				imgui.BeginChild('##asdasasddf4346', imgui.ImVec2(660, 190), false)
				scriptinfo()
				imgui.EndChild()
		imgui.End()
	end
	
	if win_state['oscriptepeople'].v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(617, 95), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' Спасибо всем, а в частности тем, кто перечислен ниже, за их участие в развитий скрипта! ', win_state['oscriptepeople'], imgui.WindowFlags.NoResize)
				imgui.BeginChild('##asdasasddf434665', imgui.ImVec2(651, 70), false)
				scriptinfopeople()
				imgui.EndChild()
		imgui.End()
	end
	
	if win_state['informer'].v then -- окно информера
		imgui.SetNextWindowPos(imgui.ImVec2(infoX, infoY), imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(200, 200), imgui.Cond.FirstUseEver)
		if styletest.v then imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(1.0, 1.0, 1.0, 0.3)) end
		if styletest1.v then imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.07, 0.07, 0.09, 0.3)) end
		if not styletest.v and not styletest1.v then imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(1.0, 1.0, 1.0, 0.3)) end
		if imgui.Begin("Mono Tools3", win_state['informer'], imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoSavedSettings) then
			infobar()
			imgui.End()
			end
		imgui.PopStyleColor()
		end
		
	if win_state['shahtainformer'].v then -- окно информера
		imgui.SetNextWindowPos(imgui.ImVec2(infoX3, infoY3), imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(200, 200), imgui.Cond.FirstUseEver)
		if styletest.v then imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(1.0, 1.0, 1.0, 0.3)) end
		if styletest1.v then imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.07, 0.07, 0.09, 0.3)) end
		if not styletest.v and not styletest1.v then imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(1.0, 1.0, 1.0, 0.3)) end
		if imgui.Begin("Mono Tools1", win_state['shahtainformer'], imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoSavedSettings) then
			infobarshahta()
			imgui.End()
			end
		imgui.PopStyleColor()
		end
	
	if win_state['pismoinformer'].v then -- окно информера
		imgui.SetNextWindowPos(imgui.ImVec2(infoX4, infoY4), imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(200, 200), imgui.Cond.FirstUseEver)
		if styletest.v then imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(1.0, 1.0, 1.0, 0.3)) end
		if styletest1.v then imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.07, 0.07, 0.09, 0.3)) end
		if not styletest.v and not styletest1.v then imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(1.0, 1.0, 1.0, 0.3)) end
		if imgui.Begin("Mono Tools2", win_state['pismoinformer'], imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoSavedSettings) then
			infobarpismo()
			imgui.End()
			end
		imgui.PopStyleColor()
		end
	end
	
function infobar()
			if infHP.v then imgui.Text(u8(" • Здоровье: "..healNew..' ')) end
			if infArmour.v then imgui.Text(u8(" • Броня: "..armourNew..' ')) end
			if infCity.v then imgui.Text(u8(" • Город: "..playerCity..' ')) end
			if infRajon.v then imgui.Text(u8(" • Район: "..ZoneInGame..' ')) end
			if inffps.v then imgui.Text(u8(" • ФПС: "..tostring(fraimrei)..' ')) end
			_, PINGUPDATE = sampGetPlayerIdByCharHandle(PLAYER_PED)
			ping = sampGetPlayerPing(PINGUPDATE)
			if infping.v then imgui.Text(u8(" • Пинг: "..ping..' ')) end
			if isCharInAnyCar(PLAYER_PED) and infhpcar.v then 
				car = storeCarCharIsInNoSave(playerPed)
				carhp = getCarHealth(car)
			imgui.Text(u8(" • ХП т/с: " ..carhp..' ')) end
			if infKv.v then imgui.Text(u8(" • Квадрат: "..tostring(locationPos())..' ')) end
			if infTime.v then imgui.Text(u8(" • Время: "..os.date("%H:%M:%S")..' ')) end
			if infonline.v then imgui.Text(u8(" • Онлайн за сессию: "..get_timer(sessiononline)..' ')) end
		end
		
function infobarshahta()
		if infkamen.v or infmetal.v or infbronza.v or infsilver.v or infgold.v or infzp.v or infsbor.v then imgui.SameLine(140) imgui.VerticalSeparator() imgui.Text(u8"  За сессию") imgui.SameLine() imgui.VerticalSeparator() imgui.Text(u8"  За всё время") imgui.SameLine() imgui.VerticalSeparator() imgui.Text(u8"       Доход       ") end
		if infkamen.v then imgui.Separator() imgui.Text(u8(" • Собрано камня: ")) imgui.SameLine(145) imgui.Text(u8(""..kamensession)) imgui.SameLine(218) imgui.Text(u8(''.. tostring(cfg.shahta.kamentime))) imgui.SameLine(310) imgui.Text(u8(""..kamenitog)) end
		if infmetal.v then imgui.Text(u8(" • Собрано металла: "))imgui.SameLine(145)  imgui.Text(u8(""..metalsession)) imgui.SameLine(218) imgui.Text(u8(''.. tostring(cfg.shahta.metaltime))) imgui.SameLine(310) imgui.Text(u8(""..metalitog)) end
		if infbronza.v then imgui.Text(u8(" • Собрано бронзы: ")) imgui.SameLine(145) imgui.Text(u8(""..bronzasession)) imgui.SameLine(218) imgui.Text(u8(''.. tostring(cfg.shahta.bronzatime))) imgui.SameLine(310) imgui.Text(u8(""..bronzaitog)) end
		if infsilver.v then imgui.Text(u8(" • Собрано серебра: ")) imgui.SameLine(145) imgui.Text(u8(""..silversession)) imgui.SameLine(218) imgui.Text(u8(''.. tostring(cfg.shahta.silvertime))) imgui.SameLine(310) imgui.Text(u8(""..silveritog)) end
		if infgold.v then imgui.Text(u8(" • Собрано золота: ")) imgui.SameLine(145) imgui.Text(u8(""..goldsession)) imgui.SameLine(218) imgui.Text(u8(''.. tostring(cfg.shahta.goldtime))) imgui.SameLine(310) imgui.Text(u8(""..golditog)) end
		if infsbor.v then imgui.Separator() imgui.Text(u8(" • Собрано ресурсов: ")) imgui.SameLine(145) imgui.Text(u8(""..sborsession)) imgui.SameLine(218) imgui.Text(u8(''.. tostring(cfg.shahta.sbortime))) end
		if infzp.v then imgui.Separator() imgui.Text(u8(" • Заработано: ")) imgui.SameLine(145) imgui.Text(u8(""..zpsession)) imgui.SameLine(218) imgui.Text(u8(""..cfg.shahta.zptime)) end
	end
	
function infobarpismo()
		if pismo.v then 
		imgui.Text(pismoreal.v) 
		imgui.Text(pismoreal1.v) 
		imgui.Text(pismoreal2.v) 
		imgui.Text(pismoreal3.v) 
		imgui.Text(pismoreal4.v) 
		end
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
							if bindreshim.v then
							if not g:find("{bwait:") then sampProcessChatInput(tags(tostring(g))) end
							else
							if not g:find("{bwait:") then sampSendChat(tags(tostring(g))) end
								end
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
					if bindreshim.v then
					if not g:find("{bwait:") then sampProcessChatInput(tags(tostring(g))) end
					else
					if not g:find("{bwait:") then sampSendChat(tags(tostring(g))) end
					end
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
		win_state['windowspusk'].v = false
		win_state['tup'].v = false
		win_state['timeyved'].v = false
		win_state['settings'].v = false
		win_state['yashiki'].v = false
		win_state['obmentrade'].v = false
		win_state['gamer'].v = false
		win_state['games'].v = false
		win_state['redak'].v = false
		win_state['shema'].v = false
		win_state['shematext'].v = false
		win_state['shahtamenu'].v = false
		win_state['shemafunks'].v = false
		win_state['shemainst'].v = false
		win_state['skupshema'].v = false
		win_state['pravila2048'].v = false
		pong = false
		snaketaken = false
		win_state['bank'].v = false
		win_state['noteswin'].v = false
		win_state['bitkoinwinokno'].v = false
		win_state['kirkawin'].v = false
		win_state['tochilki'].v = false
		win_state['pcoff'].v = false
		win_state['winprofile'].v = false
		win_state['piar'].v = false
		win_state['skup'].v = false
		win_state['skup2'].v = false
		win_state['skup3'].v = false
		win_state['oscripte'].v = false
		win_state['oscriptepeople'].v = false
		win_state['help'].v = false
		win_state['nastroikawin'].v = false
		win_state['googlewin'].v = false
		win_state['updatewin'].v = false
		win_state['messanger'].v = false
    end
	if not sampIsChatInputActive() and p == 0x1B and win_state['tup'].v then
        consumeWindowMessage()
		win_state['windowspusk'].v = false
		win_state['tup'].v = false
		win_state['timeyved'].v = false
		win_state['settings'].v = false
		win_state['yashiki'].v = false
		win_state['obmentrade'].v = false
		win_state['gamer'].v = false
		win_state['games'].v = false
		win_state['redak'].v = false
		win_state['shema'].v = false
		win_state['shematext'].v = false
		win_state['shahtamenu'].v = false
		win_state['shemafunks'].v = false
		win_state['shemainst'].v = false
		win_state['skupshema'].v = false
		win_state['pravila2048'].v = false
		pong = false
		snaketaken = false
		win_state['bank'].v = false
		win_state['noteswin'].v = false
		win_state['bitkoinwinokno'].v = false
		win_state['kirkawin'].v = false
		win_state['tochilki'].v = false
		win_state['pcoff'].v = false
		win_state['winprofile'].v = false
		win_state['piar'].v = false
		win_state['skup'].v = false
		win_state['skup2'].v = false
		win_state['skup3'].v = false
		win_state['oscripte'].v = false
		win_state['oscriptepeople'].v = false
		win_state['help'].v = false
		win_state['nastroikawin'].v = false
		win_state['googlewin'].v = false
		win_state['updatewin'].v = false
		win_state['messanger'].v = false
    end
	if not sampIsChatInputActive() and p == 0x1B and win_state['timeyved'].v then
        consumeWindowMessage()
		win_state['windowspusk'].v = false
		win_state['tup'].v = false
		win_state['timeyved'].v = false
		win_state['settings'].v = false
		win_state['yashiki'].v = false
		win_state['obmentrade'].v = false
		win_state['gamer'].v = false
		win_state['games'].v = false
		win_state['redak'].v = false
		win_state['shema'].v = false
		win_state['shematext'].v = false
		win_state['shahtamenu'].v = false
		win_state['shemafunks'].v = false
		win_state['shemainst'].v = false
		win_state['skupshema'].v = false
		win_state['pravila2048'].v = false
		pong = false
		snaketaken = false
		win_state['bank'].v = false
		win_state['noteswin'].v = false
		win_state['bitkoinwinokno'].v = false
		win_state['kirkawin'].v = false
		win_state['tochilki'].v = false
		win_state['pcoff'].v = false
		win_state['winprofile'].v = false
		win_state['piar'].v = false
		win_state['skup'].v = false
		win_state['skup2'].v = false
		win_state['skup3'].v = false
		win_state['oscripte'].v = false
		win_state['oscriptepeople'].v = false
		win_state['help'].v = false
		win_state['nastroikawin'].v = false
		win_state['googlewin'].v = false
		win_state['updatewin'].v = false
		win_state['messanger'].v = false
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
		wait(200)
		sampSendDialogResponse(722, 1 , 8, -1)
		wait(200)
		sampCloseCurrentDialogWithButton(1)
		wait(200)
		sampCloseCurrentDialogWithButton(1)
		end)
	end
	
function podklchat()
		if autochat.v then
		win_state['messanger'].v = true 
		if not connecting then startConnect()
		window_selected = 1
		win_state['messanger'].v = false
			end
		end
	end

function sampev.onServerMessage(color, text)
	if color == 1721355519 and text:match("%[F%] .*") then -- получение ранга и ID игрока, который последним написал в /f чат, для тэгов биндера
		lastfradiozv, lastfradioID = text:match('%[F%]%s(.+)%s%a+_%a+%[(%d+)%]: .+')
	elseif color == 869033727 and text:match("%[R%] .*") then -- получение ранга и ID игрока, который последним написал в /r чат, для тэгов биндера
		lastrradiozv, lastrradioID = text:match('%[R%]%s(.+)%s%a+_%a+%[(%d+)%]: .+')
	elseif text:match("^Этот транспорт зарегистрирован на жителя {9ACD32}" ..userNick) and lock.v then
		sampSendChat('/lock')
	elseif text:find("Вам был добавлен предмет") then
		krytim = true
	elseif text:find('%[Подсказка%] %{FFFFFF%}Вы получили +(.+)%$!') then
		krytim = true
	end
	local x, y, z = getCharCoordinates(PLAYER_PED)
	local resultbank, _, _, _, _, _, _, _, _, _ = Search3Dtext(x, y, z, 3, "Касса")
	if text:match("Банковский чек") and resultbank and autopay.v then
		sendchot6()
	elseif text:match("Для получения PayDay вы должны отыграть минимум 20 минут.") and resultbank and autopay.v then
		sendchot6()
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
	if text:match("Добро пожаловать на Arizona Role Play!") and dialogfix.v then
		fixpricecopia()
	end
	local today_date = os.date("%d.%m.%y")
	if text:match("Добро пожаловать на Arizona Role Play!") and napominalka.v then
		if string.find(today_date, napominalkadata.v) then win_state['timeyved'].v = not win_state['timeyved'].v
		end
	end
	if text:match("Дружище, я обменяю тебе шкатулку, только если ты принесешь 20 подарков!") and podarki.v then
		sampAddChatMessage("[Mono Tools]{FFFFFF} Вы успешно обменяли {00C2BB}"..itogopodarkov.."{FFFFFF} подарков! Вам выпало:", 0x046D63)
		sampAddChatMessage("[Mono Tools]{FFFFFF} Деньги: {00C2BB}"..moneypodarki.."{FFFFFF}$ | AZ коины: {00C2BB}"..azpodarki.."{FFFFFF} AZ | Серебро: {00C2BB}"..serebropodarki.."{FFFFFF} шт", 0x046D63)
		sampAddChatMessage("[Mono Tools]{FFFFFF} Серебряная рулетка: {00C2BB}"..serebrorulpodarki.."{FFFFFF} шт | Золотая рулетка: {00C2BB}"..zolotopodarki.."{FFFFFF} шт | Чемодан: {00C2BB}"..chemodanpodarki.."{FFFFFF} шт", 0x046D63)
		podarki.v = false
		azpodarki = 0
		moneypodarki = 0
		serebropodarki = 0
		serebrorulpodarki = 0
		zolotopodarki = 0
		chemodanpodarki = 0
		itogopodarkov = 0
	end
	if text:match("У тебя недостаточно гражданских талонов!") and platina.v then
		platina.v = false
	end
	if text:match("У тебя нет зловещих монет!") and moneta.v then
		moneta.v = false
	end
	if text:match("У тебя нет зловещих монет!") and tochkamen.v then
		tochkamen.v = false
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
	if color == -1104335361 and text:find("Технический рестарт через 02 минут. Советуем завершить текущую сессию") and recongen.v then
		recongeniusis()
	end
	if color == -10270721 and text:find("Сработала защита от реконнекта! Попробуйте переподключиться через (%d+) секунд") and recongen.v then
		recongenmenu()
	end
	if text:find("^Объявление: .+ Отправил: " .. userNick .. "%[%d+%] Тел%. %d+$") then
		if os.date("%A") == 'Monday' then
		cfg.adpred.piarsh = cfg.adpred.piarsh + 1
		end
		if os.date("%A") == 'Tuesday' then
		cfg.adpred.piarsh1 = cfg.adpred.piarsh1 + 1
		end
		if os.date("%A") == 'Wednesday' then
		cfg.adpred.piarsh2 = cfg.adpred.piarsh2 + 1
		end
		if os.date("%A") == 'Thursday' then
		cfg.adpred.piarsh3 = cfg.adpred.piarsh3 + 1
		end
		if os.date("%A") == 'Friday' then
		cfg.adpred.piarsh4 = cfg.adpred.piarsh4 + 1
		end
		if os.date("%A") == 'Saturday' then
		cfg.adpred.piarsh5 = cfg.adpred.piarsh5 + 1
		end
		if os.date("%A") == 'Sunday' then
		cfg.adpred.piarsh6 = cfg.adpred.piarsh6 + 1
		end
		inicfg.save(cfg, 'Mono\\mini-games.ini')
	end
	if text:find("^{%x%x%x%x%x%x}%[VIP%] Объявление: .+ От" .. userNick .. "%[%d+%] Тел%. %d+$") then
		if os.date("%A") == 'Monday' then
		cfg.adpred.vippiarsh = cfg.adpred.vippiarsh + 1
		end
		if os.date("%A") == 'Tuesday' then
		cfg.adpred.vippiarsh1 = cfg.adpred.vippiarsh1 + 1
		end
		if os.date("%A") == 'Wednesday' then
		cfg.adpred.vippiarsh2 = cfg.adpred.vippiarsh2 + 1
		end
		if os.date("%A") == 'Thursday' then
		cfg.adpred.vippiarsh3 = cfg.adpred.vippiarsh3 + 1
		end
		if os.date("%A") == 'Friday' then
		cfg.adpred.vippiarsh4 = cfg.adpred.vippiarsh4 + 1
		end
		if os.date("%A") == 'Saturday' then
		cfg.adpred.vippiarsh5 = cfg.adpred.vippiarsh5 + 1
		end
		if os.date("%A") == 'Sunday' then
		cfg.adpred.vippiarsh6 = cfg.adpred.vippiarsh6 + 1
		end
		inicfg.save(cfg, 'Mono\\mini-games.ini')
	end
	if text:find("Не может быть! Тут целых 5 кусков серебра!") and podarki.v then
		serebropodarki = serebropodarki + 5
		itogopodarkov = itogopodarkov + 20
	elseif text:find("Вам был добавлен предмет 'Серебряная рулетка'.") and podarki.v then
		serebrorulpodarki = serebrorulpodarki + 1
		itogopodarkov = itogopodarkov + 20
	elseif text:find("Вам был добавлен предмет 'Золотая рулетка'.") and podarki.v then
		zolotopodarki = zolotopodarki + 1
		itogopodarkov = itogopodarkov + 20
	elseif text:find("Вам был добавлен предмет 'Чемодан") and podarki.v then
		chemodanpodarki = chemodanpodarki + 1
		itogopodarkov = itogopodarkov + 20
	end
	if text:match("Вы вывели {ffffff}(%d+) BTC{ffff00}, осталось на счету видеокарты:") and btc.v then
		lua_thread.create(function()
		wait(10)
		bitkoin = text:match('(%d+)')
		itogobtc = itogobtc + bitkoin
		end)
	end
	if text:find("У вас нет 2шт. смазки для видеокарты. Её можно скрафтить в подвале дома или купить на центральном рынке.") then
		videoover()
	end
	if text:find("У вас недостаточно монет") then
		newroulette.v = false
	end
	if antilomka.v and text:find('У вас началась сильная ломка') or text:find('Вашему персонажу нужно принять') then return false end
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
	ryda = imgui.ImBool(ini.settings.ryda)
	assistant = imgui.ImBool(ini.settings.assistant)
	assistant1 = imgui.ImBool(ini.settings.assistant1)
	assistant2 = imgui.ImBool(ini.settings.assistant2)
	
	autologin = imgui.ImBool(ini.settings.autologin)
	dialogupdate = imgui.ImBool(ini.settings.dialogupdate)
	dialogfix = imgui.ImBool(ini.settings.dialogfix)
	autoryda = imgui.ImBool(ini.settings.autoryda)
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
	
	skuptrava = imgui.ImBool(ini.settings.skuptrava)
	skupbronzarul = imgui.ImBool(ini.settings.skupbronzarul)
	skupserebrorul = imgui.ImBool(ini.settings.skupserebrorul)
	skupgoldrul = imgui.ImBool(ini.settings.skupgoldrul)
	skupplatinarul = imgui.ImBool(ini.settings.skupplatinarul)
	skupkamen = imgui.ImBool(ini.settings.skupkamen)
	skupmetal = imgui.ImBool(ini.settings.skupmetal)
	skupbronza = imgui.ImBool(ini.settings.skupbronza)
	skupserebro = imgui.ImBool(ini.settings.skupserebro)
	skupgold = imgui.ImBool(ini.settings.skupgold)
	skuppodarki = imgui.ImBool(ini.settings.skuppodarki)
	skuptalon = imgui.ImBool(ini.settings.skuptalon)
	skupsemtalon = imgui.ImBool(ini.settings.skupsemtalon)
	skupskidtalon = imgui.ImBool(ini.settings.skupskidtalon)
	skuptochkamen = imgui.ImBool(ini.settings.skuptochkamen)
	skuptochamulet = imgui.ImBool(ini.settings.skuptochamulet)
	skuplarec = imgui.ImBool(ini.settings.skuplarec)
	skuptt = imgui.ImBool(ini.settings.skuptt)
	skupmoneta = imgui.ImBool(ini.settings.skupmoneta)
	skuplen = imgui.ImBool(ini.settings.skuplen)
	skupxlopok = imgui.ImBool(ini.settings.skupxlopok)
	skuprespekt = imgui.ImBool(ini.settings.skuprespekt)
	skupmaterial = imgui.ImBool(ini.settings.skupmaterial)
	skupdrova = imgui.ImBool(ini.settings.skupdrova)
	skupantibiotik = imgui.ImBool(ini.settings.skupantibiotik)
	skuptsr = imgui.ImBool(ini.settings.skuptsr)
	skupsemmoneta = imgui.ImBool(ini.settings.skupsemmoneta)
	skupauto = imgui.ImBool(ini.settings.skupauto)

	autokamen = imgui.ImBuffer(u8(ini.settings.autokamen), 256)
	autometal = imgui.ImBuffer(u8(ini.settings.autometal), 256)
	autobronza = imgui.ImBuffer(u8(ini.settings.autobronza), 256)
	autosilver = imgui.ImBuffer(u8(ini.settings.autosilver), 256)
	autogold = imgui.ImBuffer(u8(ini.settings.autogold), 256)
	
	kdpusk = imgui.ImBuffer(u8(ini.settings.kdpusk), 256)
	napominalkadata = imgui.ImBuffer(u8(ini.settings.napominalkadata), 256)
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
	autodrone = imgui.ImBuffer(u8(ini.settings.autodrone), 256)
	autodronev2 = imgui.ImBuffer(u8(ini.settings.autodronev2), 256)
	autodronev3 = imgui.ImBuffer(u8(ini.settings.autodronev3), 256)
	autodronev4 = imgui.ImBuffer(u8(ini.settings.autodronev4), 256)
	pismoreal = imgui.ImBuffer(u8(ini.settings.pismoreal), 2560)
	pismoreal1 = imgui.ImBuffer(u8(ini.settings.pismoreal1), 2560)
	pismoreal2 = imgui.ImBuffer(u8(ini.settings.pismoreal2), 2560)
	pismoreal3 = imgui.ImBuffer(u8(ini.settings.pismoreal3), 2560)
	pismoreal4 = imgui.ImBuffer(u8(ini.settings.pismoreal4), 2560)
	adsec = imgui.ImBuffer(u8(ini.settings.adsec), 100)
	vipadsec = imgui.ImBuffer(u8(ini.settings.vipadsec), 100)
	famadsec = imgui.ImBuffer(u8(ini.settings.famadsec), 100)
	vradsec = imgui.ImBuffer(u8(ini.settings.vradsec), 100)
	sadsec = imgui.ImBuffer(u8(ini.settings.sadsec), 100)
	adredak = imgui.ImBuffer(u8(ini.settings.adredak), 1000)
	
	skuptravacol = imgui.ImBuffer(u8(ini.settings.skuptravacol), 256)
	skuptravacena = imgui.ImBuffer(u8(ini.settings.skuptravacena), 256)
	skupbronzarulcol = imgui.ImBuffer(u8(ini.settings.skupbronzarulcol), 256)
	skupbronzarulcena = imgui.ImBuffer(u8(ini.settings.skupbronzarulcena), 256)
	skupserebrorulcol = imgui.ImBuffer(u8(ini.settings.skupserebrorulcol), 256)
	skupserebrorulcena = imgui.ImBuffer(u8(ini.settings.skupserebrorulcena), 256)
	skupgoldrulcol = imgui.ImBuffer(u8(ini.settings.skupgoldrulcol), 256)
	skupgoldrulcena = imgui.ImBuffer(u8(ini.settings.skupgoldrulcena), 256)
	skupplatinarulcol = imgui.ImBuffer(u8(ini.settings.skupplatinarulcol), 256)
	skupplatinarulcena = imgui.ImBuffer(u8(ini.settings.skupplatinarulcena), 256)
	skupkamencol = imgui.ImBuffer(u8(ini.settings.skupkamencol), 256)
	skupkamencena = imgui.ImBuffer(u8(ini.settings.skupkamencena), 256)
	skupmetalcol = imgui.ImBuffer(u8(ini.settings.skupmetalcol), 256)
	skupmetalcena = imgui.ImBuffer(u8(ini.settings.skupmetalcena), 256)
	skupbronzacol = imgui.ImBuffer(u8(ini.settings.skupbronzacol), 256)
	skupbronzacena = imgui.ImBuffer(u8(ini.settings.skupbronzacena), 256)
	skupserebrocol = imgui.ImBuffer(u8(ini.settings.skupserebrocol), 256)
	skupserebrocena = imgui.ImBuffer(u8(ini.settings.skupserebrocena), 256)
	skupgoldcol = imgui.ImBuffer(u8(ini.settings.skupgoldcol), 256)
	skupgoldcena = imgui.ImBuffer(u8(ini.settings.skupgoldcena), 256)
	skuppodarkicol = imgui.ImBuffer(u8(ini.settings.skuppodarkicol), 256)
	skuppodarkicena = imgui.ImBuffer(u8(ini.settings.skuppodarkicena), 256)
	skuptaloncol = imgui.ImBuffer(u8(ini.settings.skuptaloncol), 256)
	skuptaloncena = imgui.ImBuffer(u8(ini.settings.skuptaloncena), 256)
	skupsemtaloncol = imgui.ImBuffer(u8(ini.settings.skupsemtaloncol), 256)
	skupsemtaloncena = imgui.ImBuffer(u8(ini.settings.skupsemtaloncena), 256)
	skupskidtaloncol = imgui.ImBuffer(u8(ini.settings.skupskidtaloncol), 256)
	skupskidtaloncena = imgui.ImBuffer(u8(ini.settings.skupskidtaloncena), 256)
	skuptochkamencol = imgui.ImBuffer(u8(ini.settings.skuptochkamencol), 256)
	skuptochkamencena = imgui.ImBuffer(u8(ini.settings.skuptochkamencena), 256)
	skuptochamuletcena = imgui.ImBuffer(u8(ini.settings.skuptochamuletcena), 256)
	skuplareccol = imgui.ImBuffer(u8(ini.settings.skuplareccol), 256)
	skuplareccena = imgui.ImBuffer(u8(ini.settings.skuplareccena), 256)
	skupttcena = imgui.ImBuffer(u8(ini.settings.skupttcena), 256) 
	skupmonetacol = imgui.ImBuffer(u8(ini.settings.skupmonetacol), 256)
	skupmonetacena = imgui.ImBuffer(u8(ini.settings.skupmonetacena), 256) 
	skuplencol = imgui.ImBuffer(u8(ini.settings.skuplencol), 256)
	skuplencena = imgui.ImBuffer(u8(ini.settings.skuplencena), 256) 
	skupxlopokcol = imgui.ImBuffer(u8(ini.settings.skupxlopokcol), 256)
	skupxlopokcena = imgui.ImBuffer(u8(ini.settings.skupxlopokcena), 256) 
	skuprespektcol = imgui.ImBuffer(u8(ini.settings.skuprespektcol), 256)
	skuprespektcena = imgui.ImBuffer(u8(ini.settings.skuprespektcena), 256) 
	skupmaterialcol = imgui.ImBuffer(u8(ini.settings.skupmaterialcol), 256)
	skupmaterialcena = imgui.ImBuffer(u8(ini.settings.skupmaterialcena), 256)
	skupdrovacol = imgui.ImBuffer(u8(ini.settings.skupdrovacol), 256)
	skupdrovacena = imgui.ImBuffer(u8(ini.settings.skupdrovacena), 256)
	skupantibiotikcol = imgui.ImBuffer(u8(ini.settings.skupantibiotikcol), 256)
	skupantibiotikcena = imgui.ImBuffer(u8(ini.settings.skupantibiotikcena), 256)
	skuptsrcol = imgui.ImBuffer(u8(ini.settings.skuptsrcol), 256)
	skuptsrcena = imgui.ImBuffer(u8(ini.settings.skuptsrcena), 256)
	skupsemmonetacol = imgui.ImBuffer(u8(ini.settings.skupsemmonetacol), 256)
	skupsemmonetacena = imgui.ImBuffer(u8(ini.settings.skupsemmonetacena), 256)
	skupautocena = imgui.ImBuffer(u8(ini.settings.skupautocena), 256)
	
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
	watertext = imgui.ImBuffer(u8(ini.settings.watertext), 256)
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
	bindreshim = imgui.ImBool(ini.settings.bindreshim)
	droneoption = imgui.ImBool(ini.settings.droneoption)

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
	
	infkamen = imgui.ImBool(ini.shahtainformer.kamen)
	infmetal = imgui.ImBool(ini.shahtainformer.metal)
	infbronza = imgui.ImBool(ini.shahtainformer.bronza)
	infsilver = imgui.ImBool(ini.shahtainformer.silver)
	infgold = imgui.ImBool(ini.shahtainformer.gold)
	infzp = imgui.ImBool(ini.shahtainformer.zp)
	infsbor = imgui.ImBool(ini.shahtainformer.sbor)

	keyT = imgui.ImBool(ini.settings.keyT)
	launcher = imgui.ImBool(ini.settings.launcher)
	adcounter = imgui.ImBool(ini.settings.adcounter)
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
	autochat = imgui.ImBool(ini.settings.autochat)
	chatmessage = imgui.ImBool(ini.settings.chatmessage)
	eat = imgui.ImBool(ini.settings.eat)
	eathouse = imgui.ImBool(ini.settings.eathouse)
	eatmyso = imgui.ImBool(ini.settings.eatmyso)
	mvdhelp = imgui.ImBool(ini.settings.mvdhelp)
	antilomka = imgui.ImBool(ini.settings.antilomka)
	napominalka = imgui.ImBool(ini.settings.napominalka)
	chatcalc = imgui.ImBool(ini.settings.chatcalc)
	pismo = imgui.ImBool(ini.settings.pismo)
	yashik = imgui.ImBool(ini.settings.yashik)
	yashik1 = imgui.ImBool(ini.settings.yashik1)
	yashik2 = imgui.ImBool(ini.settings.yashik2)
	yashik3 = imgui.ImBool(ini.settings.yashik3)
	otkrytie = imgui.ImBool(ini.settings.otkrytie)
	otkrytie2 = imgui.ImBool(ini.settings.otkrytie2)
	ndr = imgui.ImBool(ini.settings.ndr)
	toch = imgui.ImBool(ini.settings.toch)
	autobike = imgui.ImBool(ini.settings.autobike)
	styletest = imgui.ImBool(ini.settings.styletest)
	styletest1 = imgui.ImBool(ini.settings.styletest1)
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
	infoX3 = ini.settings.infoX3
	infoY3 = ini.settings.infoY3
	infoX4 = ini.settings.infoX4
	infoY4 = ini.settings.infoY4
	findX = ini.settings.findX
	findY = ini.settings.findY
	asX = ini.assistant.asX
	asY = ini.assistant.asY
	asX3 = ini.assistant1.asX3
	asY3 = ini.assistant1.asY3
	asX4 = ini.assistant2.asX4
	asY4 = ini.assistant2.asY4
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
	  closeDialog()
	  wait(500)
      active6 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext1.v))
      wait(15000)
	end
	if video1.v then
	  closeDialog()
	  wait(500)
      active7 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext2.v))
      wait(15000)
	end
	if video2.v then
	  closeDialog()
	  wait(500)
      active8 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext3.v))
      wait(15000)
	end
	if video3.v then
	  closeDialog()
	  wait(500)
      active9 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext4.v))
      wait(15000)
	end
	if video4.v then
	  closeDialog()
	  wait(500)
      active10 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext5.v))
      wait(15000)
	end
	if video5.v then
	  closeDialog()
	  wait(500)
      active11 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext6.v))
      wait(15000)
	end
	if video6.v then
	  closeDialog()
	  wait(500)
      active12 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext7.v))
      wait(15000)
	end
	if video7.v then
	  closeDialog()
	  wait(500)
      active13 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext8.v))
      wait(15000)
	end
	if video8.v then
	  closeDialog()
	  wait(500)
      active14 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext9.v))
      wait(15000)
	end
	if video9.v then
	  closeDialog()
	  wait(500)
      active15 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext10.v))
      wait(15000)
	end
	if video10.v then
	  closeDialog()
	  wait(500)
      active16 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext11.v))
      wait(15000)
	end
	if video11.v then
	  closeDialog()
	  wait(500)
      active17 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext12.v))
      wait(15000)
	end
	if video12.v then
	  closeDialog()
	  wait(500)
      active18 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext13.v))
      wait(15000)
	end
	if video13.v then
	  closeDialog()
	  wait(500)
      active19 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext14.v))
      wait(15000)
	end
	if video14.v then
	  closeDialog()
	  wait(500)
      active20 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext15.v))
      wait(15000)
	end
	if video15.v then
	  closeDialog()
	  wait(500)
      active21 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext16.v))
      wait(15000)
	end
	if video16.v then
	  closeDialog()
	  wait(500)
      active22 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext17.v))
      wait(15000)
	end
	if video17.v then
	  closeDialog()
	  wait(500)
      active23 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext18.v))
      wait(15000)
	end
	if video18.v then
	  closeDialog()
	  wait(500)
      active24 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext19.v))
      wait(15000)
	end
	if video19.v then
	  closeDialog()
	  wait(500)
      active25 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext20.v))
      wait(15000)
	end
	if video20.v then
	  closeDialog()
	  wait(500)
      active26 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext21.v))
      wait(15000)
	end
	if video21.v then
	  closeDialog()
	  wait(500)
      active27 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext22.v))
      wait(15000)
	end
	if video22.v then
	  closeDialog()
	  wait(500)
      active28 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext23.v))
      wait(15000)
	end
	if video23.v then
	  closeDialog()
	  wait(500)
      active29 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext24.v))
      wait(15000)
	end
	if video24.v then
	  closeDialog()
	  wait(500)
      active30 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext25.v))
      wait(15000)
	end
	if video25.v then
	  closeDialog()
	  wait(500)
      active31 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext26.v))
      wait(15000)
	end
	if video26.v then
	  closeDialog()
	  wait(500)
      active32 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext27.v))
      wait(15000)
	end
	if video27.v then
	  closeDialog()
	  wait(500)
      active33 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext28.v))
      wait(15000)
	end
	if video28.v then
	  closeDialog()
	  wait(500)
      active34 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext29.v))
      wait(15000)
	end
	if video29.v then
	  closeDialog()
	  wait(500)
      active35 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext30.v))
      wait(15000)
	end
	if video30.v then
	  closeDialog()
	  wait(500)
      active36 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext31.v))
      wait(15000)
	end
	if video31.v then
	  closeDialog()
	  wait(500)
      active37 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext32.v))
      wait(15000)
	end
	if video32.v then
	  closeDialog()
	  wait(500)
      active38 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext33.v))
      wait(15000)
	end
	if video33.v then
	  closeDialog()
	  wait(500)
      active39 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext34.v))
      wait(15000)
	end
	if video34.v then
	  closeDialog()
	  wait(500)
      active40 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext35.v))
      wait(15000)
	end
	if video35.v then
	  closeDialog()
	  wait(500)
      active41 = true
      sampSendChat("/invent")
	  wait(500)
	  sampSendClickTextdraw(2108)
	  wait(kdpusk.v*1000)
	  sampSendClickTextdraw(u8:decode(shematext36.v))
      wait(15000)
		end
	wait(0)
	end
end

function stroboscopes(adress, ptr, _1, _2, _3, _4)
	if not isCharInAnyCar(PLAYER_PED) then return end
	
	if not isCarSirenOn(storeCarCharIsInNoSave(PLAYER_PED)) then
		forceCarLights(storeCarCharIsInNoSave(PLAYER_PED), 0)
		callMethod(7086336, ptr, 2, 0, 1, 3)
		callMethod(7086336, ptr, 2, 0, 0, 0)
		callMethod(7086336, ptr, 2, 0, 1, 0)
		markCarAsNoLongerNeeded(storeCarCharIsInNoSave(PLAYER_PED)) 
		return
	end

	callMethod(adress, ptr, _1, _2, _3, _4)
end

function strobe()
	while true do
		wait(0)
		
		if isCharInAnyCar(PLAYER_PED) then
		
			local car = storeCarCharIsInNoSave(PLAYER_PED)
			local driverPed = getDriverOfCar(car)
			
			if isCarSirenOn(car) and PLAYER_PED == driverPed then
			
				local ptr = getCarPointer(car) + 1440
				forceCarLights(car, 2)
				wait(50)
				stroboscopes(7086336, ptr, 2, 0, 1, 3)

				while isCarSirenOn(car) do
					wait(0)
					for i = 1, 12 do
						wait(100)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						wait(100)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						wait(100)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						wait(100)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) then break end
					end
					
					if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) then break end

					for i = 1, 6 do
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 1, 3)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) then break end
						wait(300)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) then break end
					end
					
					if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) then break end

					for i = 1, 3 do
						wait(60)
						stroboscopes(7086336, ptr, 2, 0, 1, 3)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						wait(60)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						wait(60)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						wait(60)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						wait(60)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						wait(60)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						wait(60)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						wait(60)
						if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) then break end
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						wait(60)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						wait(350)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						wait(60)
						if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) then break end
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						wait(50)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						wait(50)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						wait(100)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						wait(100)
						if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) then break end
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						wait(100)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) then break end
					end
					
					if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) then break end
				end
			end
		end
	end
end

function isCharInAnyCar(ped)
	local vehicles = {602, 545, 496, 517, 401, 410, 518, 600, 527, 436, 589, 580, 419, 439, 533, 549, 526, 491, 474, 445, 467, 604, 426, 507, 547, 585, 405, 587, 409, 466, 550, 492, 566, 546, 540, 551, 421, 516, 529, 485, 552, 431, 438, 437, 574, 420, 525, 408, 416, 596, 433, 597, 427, 599, 490, 528, 601, 407, 428, 544, 523, 470, 598, 499, 588, 609, 403, 498, 514, 524, 423, 532, 414, 578, 443, 486, 515, 406, 531, 573, 456, 455, 459, 543, 422, 583, 482, 478, 605, 554, 530, 418, 572, 582, 413, 440, 536, 575, 534, 567, 535, 576, 412, 402, 542, 603, 475, 568, 557, 424, 471, 504, 495, 457, 483, 508, 500, 444, 556, 429, 411, 541, 559, 415, 561, 480, 560, 562, 506, 565, 451, 434, 558, 494, 555, 502, 477, 503, 579, 400, 404, 489, 505, 479, 442, 458}
	for i, v in ipairs(vehicles) do
		if isCharInModel(ped, v) then return true end
	end
	return false
end

function autobmx()
while true do 
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
		wait(0)
	end
end

function connectarz()
while true do 
	if connected then s:think() wait(1000) else wait(0)
		end
	end
end

function roulette()
while true do 
	if checked_test.v and krytim then
	checked_test2.v = false
	checked_test3.v = false
	checked_test4.v = false
	otkrytie.v = false
	otkrytie2.v = false
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
	checked_test.v = false
	checked_test3.v = false
	checked_test4.v = false
	otkrytie.v = false
	otkrytie2.v = false
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
	checked_test2.v = false
	checked_test.v = false
	checked_test4.v = false
	otkrytie.v = false
	otkrytie2.v = false
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
	checked_test2.v = false
	checked_test3.v = false
	checked_test.v = false
	otkrytie.v = false
	otkrytie2.v = false
      rul()
	  wait(111)
	  closeDialog()
      wait(222)
      sampSendClickTextdraw(2110)
	  wait(1000)
      sampSendClickTextdraw(2091)
      krytim = false
	end
	if newroulette.v and krytim then
	checked_test2.v = false
	checked_test3.v = false
	checked_test4.v = false
	checked_test.v = false
	otkrytie.v = false
	otkrytie2.v = false
	  wait(111)
	  closeDialog()
      wait(1000)
      sampSendClickTextdraw(2100)
      krytim = false
			end
		wait(0)
	end
end

function rouletteyashik()
while true do 
	if checked_test5.v and otkrytie.v then
	  sampCloseCurrentDialogWithButton(0) 
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
    end
    if checked_test6.v and otkrytie.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active1 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
    end
    if checked_test7.v and otkrytie.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active2 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
	end
	if checked_test8.v and otkrytie.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active3 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
	end
	if checked_test9.v and otkrytie.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active4 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
	end
	if checked_test10.v and otkrytie.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active5 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
	end
	if yashik.v and otkrytie.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active = true
      sampSendChat("/invent")
      wait(zadervkav2.v*60000)
    end
	if yashik1.v and otkrytie.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active1 = true
      sampSendChat("/invent")
      wait(zadervkav2.v*60000)
    end
	if yashik2.v and otkrytie.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active2 = true
      sampSendChat("/invent")
      wait(zadervkav2.v*60000)
    end
	if yashik3.v and otkrytie.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active5 = true
      sampSendChat("/invent")
      wait(zadervkav2.v*60000)
	end
	if checked_test5.v and otkrytie2.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
    end
    if checked_test6.v and otkrytie2.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active1 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
    end
    if checked_test7.v and otkrytie2.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active2 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
	end
	if checked_test8.v and otkrytie2.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active3 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
	end
	if checked_test9.v and otkrytie2.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active4 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
	end
	if checked_test10.v and otkrytie2.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active5 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
	end
	if yashik.v and otkrytie2.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active = true
      sampSendChat("/invent")
      wait(zadervkav2.v*60000)
    end
	if yashik1.v and otkrytie2.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active1 = true
      sampSendChat("/invent")
      wait(zadervkav2.v*60000)
    end
	if yashik2.v and otkrytie2.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active2 = true
      sampSendChat("/invent")
      wait(zadervkav2.v*60000)
    end
	if yashik3.v and otkrytie2.v then
	  sampCloseCurrentDialogWithButton(0)
	  wait(200)
	  sampSendClickTextdraw(2110)
	  wait(500)
      active5 = true
      sampSendChat("/invent")
      wait(zadervkav2.v*60000)
		end	
		wait(0)
	end
end
	
function raznoe()
while true do 
	if podarki.v then 
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(1449, 1 , 3, -1)
	wait(100)
	closeDialog()
	end
	if water.v then 
	sampSendClickTextdraw(watertext.v)
	wait(200)
	sampSendDialogResponse(3082, 1 , 1, -1)
	wait(100)
	sampCloseCurrentDialogWithButton(0) 
	wait(400)
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
	if moneta.v then 
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(9542, 1 , 24, -1)
	wait(100)
	closeDialog()
	end
	if tochkamen.v then 
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(9542, 1 , 0, -1)
	wait(100)
	closeDialog()
	end
	if btc.v then 
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Подойдите к следующей полке с видеокартами, чтобы забрать прибыль! У вас есть ровно "..kdpusk.v.." секунд(а/ы).", 0x046D63)
	wait(kdpusk.v*1000)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Подойдите к следующей полке с видеокартами, чтобы забрать прибыль! У вас есть ровно "..kdpusk.v.." секунд(а/ы).", 0x046D63)
	wait(kdpusk.v*1000)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Подойдите к следующей полке с видеокартами, чтобы забрать прибыль! У вас есть ровно "..kdpusk.v.." секунд(а/ы).", 0x046D63)
	wait(kdpusk.v*1000)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Подойдите к следующей полке с видеокартами, чтобы забрать прибыль! У вас есть ровно "..kdpusk.v.." секунд(а/ы).", 0x046D63)
	wait(kdpusk.v*1000)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15274, 1 , 1, -1)
	wait(1000)
	closeDialog()
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Вы успешно вывели {00C2BB}"..itogobtc.."{FFFFFF} BTC! Функция выключилась автоматический.", 0x046D63)
	btc.v = false
	itogobtc = 0
	end
	if liquid.v then 
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Подойдите к следующей полке с видеокартами, чтобы залить жидкость! У вас есть ровно "..kdpusk.v.." секунд(а/ы).", 0x046D63)
	wait(kdpusk.v*1000)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Подойдите к следующей полке с видеокартами, чтобы залить жидкость! У вас есть ровно "..kdpusk.v.." секунд(а/ы).", 0x046D63)
	wait(kdpusk.v*1000)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Подойдите к следующей полке с видеокартами, чтобы залить жидкость! У вас есть ровно "..kdpusk.v.." секунд(а/ы).", 0x046D63)
	wait(kdpusk.v*1000)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Подойдите к следующей полке с видеокартами, чтобы залить жидкость! У вас есть ровно "..kdpusk.v.." секунд(а/ы).", 0x046D63)
	wait(kdpusk.v*1000)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 2, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Вы успешно залили жидкость в видеокарты. Функция выключилась автоматический.", 0x046D63)
	liquid.v = false
	end
	if pusk.v then 
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Подойдите к следующей полке с видеокартами, чтобы запустить или остановить видеокарты! У вас есть ровно "..kdpusk.v.." секунд(а/ы).", 0x046D63)
	wait(kdpusk.v*1000)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Подойдите к следующей полке с видеокартами, чтобы запустить или остановить видеокарты! У вас есть ровно "..kdpusk.v.." секунд(а/ы).", 0x046D63)
	wait(kdpusk.v*1000)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Подойдите к следующей полке с видеокартами, чтобы запустить или остановить видеокарты! У вас есть ровно "..kdpusk.v.." секунд(а/ы).", 0x046D63)
	wait(kdpusk.v*1000)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Подойдите к следующей полке с видеокартами, чтобы запустить или остановить видеокарты! У вас есть ровно "..kdpusk.v.." секунд(а/ы).", 0x046D63)
	wait(kdpusk.v*1000)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 0, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 1, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 2, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(200)
	setVirtualKeyDown(key.VK_MENU, true)
    wait(200)
    setVirtualKeyDown(key.VK_MENU, false)
	wait(200)
	sampSendDialogResponse(15272, 1 , 3, -1)
	wait(200)
	sampSendDialogResponse(15273, 1 , 0, -1)
	wait(1000)
	closeDialog()
	wait(1000)
	closeDialog()
	wait(100)
	sampAddChatMessage("[Mono Tools]{FFFFFF} Вы успешно запустили или остановили видеокарты. Функция выключилась автоматический.", 0x046D63)
	pusk.v = false
		end
		wait(0)
	end
end

function piarad()
while true do
	if addad.v then
	closeDialog()
	wait(100)
	sampSendChat(u8:decode ('/ad '..adredak.v))
	wait(300)
	sampSendDialogResponse(15346, 1, 1, -1)
	wait(200)
	sampSendDialogResponse(15347, 1, 0, -1)
	wait(100)
	closeDialog()
	wait(adsec.v*1000)
	end
	if vipaddad.v then
	closeDialog()
	wait(100)
	sampSendChat(u8:decode ('/ad '..adredak.v))
	wait(300)
	sampSendDialogResponse(15346, 1, 2, -1)
	wait(200)
	sampSendDialogResponse(15347, 1, 0, -1)
	wait(100)
	closeDialog()
	wait(vipadsec.v*1000)
	end
	if famaddad.v then
	wait(100)
	sampSendChat(u8:decode ('/fam '..adredak.v))
	wait(famadsec.v*1000)
	end
	if vraddad.v then
	wait(100)
	sampSendChat(u8:decode ('/vr '..adredak.v))
	wait(vradsec.v*1000)
	end
	if saddad.v then
	wait(100)
	sampSendChat(u8:decode ('/s '..adredak.v))
	wait(sadsec.v*1000)
		end
		wait(0)
	end
end

function findi()
while true do
	if afind == 1 then -- проверяем активирован ли скрипт
			sampSendChat('/find '..id_find) -- сообщение в чат
			wait(2000) -- задержка между /find
		end
		wait(0)
	end
end

function obnovlenie()
while true do
	if WHupdate.v then
		for _, obj_hand in pairs(getAllObjects()) do
            local modelid = getObjectModel(obj_hand)
            if modelid == 2886 then
                if isObjectOnScreen(obj_hand) then
                    local x,y,z = getCharCoordinates(PLAYER_PED)
                    local res,x1,y1,z1 = getObjectCoordinates(obj_hand)
                    if res then
                        local dist = getDistanceBetweenCoords3d(x,y,z,x1,y1,z1)
						mils = tonumber(string.format("%.f", dist))
                        local c1,c2 = convert3DCoordsToScreen(x,y,z)
                        local o1,o2 = convert3DCoordsToScreen(x1,y1,z1)
                        local text = '{CD0000}Пропавший предмет\n{ffffff}Дистанция: '..mils..'m.'
                        renderDrawLine(c1,c2,o1,o2,1,-1)
                        renderFontDrawText(font,text,o1,o2,-1)
                    end
				end
			end
			if modelid == 934 then
                if isObjectOnScreen(obj_hand) then
                    local x,y,z = getCharCoordinates(PLAYER_PED)
                    local res,x1,y1,z1 = getObjectCoordinates(obj_hand)
                    if res then
                        local dist = getDistanceBetweenCoords3d(x,y,z,x1,y1,z1)
						mils = tonumber(string.format("%.f", dist))
                        local c1,c2 = convert3DCoordsToScreen(x,y,z)
                        local o1,o2 = convert3DCoordsToScreen(x1,y1,z1)
                        local text = '{FF4500}Покорёженый металл\n{ffffff}Дистанция: '..mils..'m.'
                        renderDrawLine(c1,c2,o1,o2,1,-1)
                        renderFontDrawText(font,text,o1,o2,-1)
						end
					end
				end
			if modelid == 850 then
                if isObjectOnScreen(obj_hand) then
                    local x,y,z = getCharCoordinates(PLAYER_PED)
                    local res,x1,y1,z1 = getObjectCoordinates(obj_hand)
                    if res then
                        local dist = getDistanceBetweenCoords3d(x,y,z,x1,y1,z1)
						mils = tonumber(string.format("%.f", dist))
                        local c1,c2 = convert3DCoordsToScreen(x,y,z)
                        local o1,o2 = convert3DCoordsToScreen(x1,y1,z1)
                        local text = '{FFD700}Железные обломки\n{ffffff}Дистанция: '..mils..'m.'
                        renderDrawLine(c1,c2,o1,o2,1,-1)
                        renderFontDrawText(font,text,o1,o2,-1)
						end
					end
				end
			if modelid == 1362 then
                if isObjectOnScreen(obj_hand) then
                    local x,y,z = getCharCoordinates(PLAYER_PED)
                    local res,x1,y1,z1 = getObjectCoordinates(obj_hand)
                    if res then
                        local dist = getDistanceBetweenCoords3d(x,y,z,x1,y1,z1)
						mils = tonumber(string.format("%.f", dist))
                        local c1,c2 = convert3DCoordsToScreen(x,y,z)
                        local o1,o2 = convert3DCoordsToScreen(x1,y1,z1)
                        local text = '{0000FF}Ржавые детали\n{ffffff}Дистанция: '..mils..'m.'
                        renderDrawLine(c1,c2,o1,o2,1,-1)
                        renderFontDrawText(font,text,o1,o2,-1)
                    end
				end
			end
		end
	end
	if labirint.v then
	createCheckpoint(2, -1410.7764,-15.1167,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1410.9436,-34.0902,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1393.3833,-17.4601,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1396.7317,-26.1053,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1402.2668,-32.2269,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1408.9229,-55.1759,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1411.0349,-67.2609,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1407.7104,-72.5888,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1403.5201,-61.5499,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1387.9364,-39.1543,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1365.8726,-39.3457,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1346.5680,-64.7529,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1341.9646,-56.8953,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1357.2194,-41.7623,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1349.4955,-32.3300,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1340.5527,-37.3811,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1338.9095,-15.4209,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1328.9750,-17.4985,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1317.8438,-17.0559,14.3484, 1, 1, 1, 1)
	createCheckpoint(2, -1323.1193,-27.6095,14.3484, 1, 1, 1, 1)
	createCheckpoint(1, -1310.4318,-37.1627,14.3484, 1, 1, 1, 1)
	end
	if prazdnik.v then
	setMarker(2, -2416.6096,2327.9485,4.9817)
	end
	if prazdnik1.v then
	setMarker(2, -1980.9331,-976.0734,32.2455)
	end
	if prazdnik2.v then
	setMarker(2, 153.8789,-1928.6691,3.7696)
	end
	if prazdnik3.v then
	setMarker(2, 2292.6370,-1443.5712,23.7721)
	end
	if prazdnik4.v then
	setMarker(2, 2462.6140,-35.1453,26.4844)
	end
	if prazdnik5.v then
	setMarker(2, 2361.9404,1952.9669,10.6798)
	end
	if prazdnik6.v then
	setMarker(2, -167.1510,1223.2247,19.7422)
	end
	if robot.v then
	setMarker(2, -1272.4504,2607.3977,89.0648)
	end
	if robot1.v then
	setMarker(2, -781.6836,2107.2927,60.3828)
	end
	if robot2.v then
	setMarker(2, -761.7206,1152.6692,40.8851)
	end
	if robot3.v then
	setMarker(2, -2679.9753,2094.5701,55.5389)
	end
	if robot4.v then
	setMarker(2, -2752.7510,786.8216,53.8019)
	end
	if robot5.v then
	setMarker(2, -2523.0583,-606.1990,132.5625)
	end
	if robot6.v then
	setMarker(2, -94.9065,-1483.7161,3.0192)
	end
	if robot7.v then
	setMarker(2, 1465.3910,-1730.2164,13.3828)
	end
	if robot8.v then
	setMarker(2, 1799.8401,-1892.2474,13.4039)
	end
	if robot9.v then
	setMarker(2, 1880.2222,-1878.9446,13.4776)
	end
	if robot10.v then
	setMarker(2, 2066.6396,-1467.7086,22.0766)
	end
	if robot11.v then
	setMarker(2, 2213.1907,-1166.6251,25.7266)
	end
	if robot12.v then
	setMarker(2, 1238.0437,-619.6649,103.7500)
	end
	if robot13.v then
	setMarker(2, 1724.0112,873.9470,10.1222)
	end
	if robot14.v then
	setMarker(2, 1371.6138,2155.7012,11.0156)
	end
	if bomj.v then
	setMarker(2, -2385.0435,2219.5029,4.9844)
	end
	if bomj1.v then
	setMarker(2, -1702.8809,963.1707,24.9108)
	end
	if bomj2.v then
	setMarker(2, -2430.2134,-37.2204,35.3203)
	end
	if bomj3.v then
	setMarker(2, 273.8956,-182.8439,1.5781)
	end
	if bomj4.v then
	setMarker(2, 712.7630,-502.9526,16.3359)
	end
	if bomj5.v then
	setMarker(2, 2302.9863,2.8028,26.4844)
	end
	if bomj6.v then
	setMarker(2, 2154.3181,1451.4645,10.8125)
	end
	if bomj7.v then
	setMarker(2, 2375.9749,1643.9750,11.0234)
	end
	if bomj8.v then
	setMarker(2, 1049.2964,1841.7837,10.8203)
	end
	if bomj9.v then
	setMarker(2, -2439.3440,424.9268,35.1641)
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

function shahta()
while true do 
	local x, y, z = getCharCoordinates(PLAYER_PED)
	local result, _, _, _, _, _, _, _, _, _ = Search3Dtext(x, y, z, 3, "{73B461}Для добычи ископаемого")
	if autoryda.v and result then
	sendKey(1024)
		end
	wait(0)
	end
end
		
function eating()
while true do 
	if eat.v and eatmyso.v then
		sampSendChat("/meatbag")
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
					win_state['main'].v = true
					win_state['nastroikawin'].v = true
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
	
function informerperemshahta()
while true do
if ryda.v and not workpause then -- показываем информер и его перемещение
			if not win_state['regst'].v then win_state['shahtainformer'].v = true end

			if mouseCoord5 then
				showCursor(true, true)
				infoX3, infoY3 = getCursorPos()
				if isKeyDown(VK_RETURN) then
					infoX3 = math.floor(infoX3)
					infoY3 = math.floor(infoY3)
					mouseCoord5 = false
					showCursor(false, false)
					win_state['main'].v = true
					win_state['kirkawin'].v = true
				end
			end
		else
			win_state['shahtainformer'].v = false
		end

		if assistant1.v and developMode == 1 and isPlayerSoldier then -- координатор и его перемещение
			if not win_state['regst'].v then win_state['ass'].v = true end

			if mouseCoord4 then
				showCursor(true, true)
				asX3, asY3 = getCursorPos()
				if isKeyDown(VK_RETURN) then
					asX3 = math.floor(asX3)
					asY3 = math.floor(asY3)
					mouseCoord4 = false
					showCursor(false, false)
				end
			end
		else
			win_state['ass'].v = false
		end
		wait(0)
		end
	end
	
function informerperempismo()
while true do
if pismo.v and not workpause then -- показываем информер и его перемещение
			if not win_state['regst'].v then win_state['pismoinformer'].v = true end
			if mouseCoord6 then
				showCursor(true, true)
				infoX4, infoY4 = getCursorPos()
				if isKeyDown(VK_RETURN) then
					infoX4 = math.floor(infoX4)
					infoY4 = math.floor(infoY4)
					mouseCoord6 = false
					showCursor(false, false)
					win_state['main'].v = true
					win_state['noteswin'].v = true
				end
			end
		else
			win_state['pismoinformer'].v = false
		end

		if assistant2.v and developMode == 1 and isPlayerSoldier then -- координатор и его перемещение
			if not win_state['regst'].v then win_state['ass'].v = true end

			if mouseCoord7 then
				showCursor(true, true)
				asX4, asY4 = getCursorPos()
				if isKeyDown(VK_RETURN) then
					asX4 = math.floor(asX4)
					asY4 = math.floor(asY4)
					mouseCoord7 = false
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
		sampAddChatMessage("[Mono Tools]{FFFFFF} Завершить пилотирование дроном можно клавишей {00C2BB}Enter{FFFFFF} или установленной вами комбинацией клавиш.", 0x046D63)
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
				if isKeyDown(VK_RETURN) or isKeyJustPressed(u8:decode(autodronev4.v)) and isKeyJustPressed(u8:decode(autodronev3.v)) then
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
	imgui.SetNextWindowSize(imgui.ImVec2(800, 353), imgui.Cond.FirstUseEver)
	imgui.Begin(u8' Редактирование отыгровок', win_state['redak'], imgui.WindowFlags.NoResize)
			imgui.BeginChild('##asdasasddf', imgui.ImVec2(800, 328), false)
			imgui.Columns(2, _, false)
			imgui.InputText(u8'Desert Eagle /do ##26', deagleone)
			imgui.InputText(u8'Desert Eagle /me ##27', deagletwo)
			imgui.NextColumn()
			imgui.InputText(u8'Винтовка M4 /do ##28', m4one)
			imgui.InputText(u8'Винтовка M4 /me ##29', m4two)
			imgui.Separator()
			imgui.NextColumn()
			imgui.InputText(u8'Sniper /do ##30', awpone)
			imgui.InputText(u8'Sniper /me ##31', awptwo)
			imgui.NextColumn()
			imgui.InputText(u8'Узи /do ##32', uzione)
			imgui.InputText(u8'Узи /me ##33', uzitwo)
			imgui.Separator()
			imgui.NextColumn()
			imgui.InputText(u8'Автомат АК-47 /do ##34', ak47one)
			imgui.InputText(u8'Автомат АК-47 /me ##35', ak47two)
			imgui.NextColumn()
			imgui.InputText(u8'MP5 /do ##36', mp5one)
			imgui.InputText(u8'MP5 /me ##37', mp5two)
			imgui.Separator()
			imgui.NextColumn()
			imgui.InputText(u8'ShotGun /do ##38', shotgunone)
			imgui.InputText(u8'ShotGun /me ##39', shotguntwo)
			imgui.NextColumn()
			imgui.InputText(u8'Rifle /do ##40', rifleone)
			imgui.InputText(u8'Rifle /me ##41', rifletwo)
			imgui.Separator()
			imgui.NextColumn()
			imgui.InputText(u8'Нож /do ##42', knifeone)
			imgui.InputText(u8'Нож /me ##43', knifetwo)
			imgui.NextColumn()
			imgui.InputText(u8'Тайзер /do ##44', tazerone)
			imgui.InputText(u8'Тайзер /me ##45', tazertwo)
			imgui.Separator()
			imgui.NextColumn()
			imgui.InputText(u8'Убрать оружие /me ##46', ybralone)
			imgui.EndChild()
			imgui.End()
		end
	
function yashikisroulette()
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(797, 393), imgui.Cond.FirstUseEver)
	imgui.Begin(u8'Roulette Tools', win_state['yashiki'], imgui.WindowFlags.NoResize)
			imgui.BeginChild('##asdasasddf', imgui.ImVec2(800, 360), false)
			imgui.Columns(2, _, false)
			imgui.Text('')
			imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Открыть бронзовые рулетки', checked_test)
			imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Открыть серебряные  рулетки', checked_test2)
			imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Открыть золотые рулетки', checked_test3)
			imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Открыть платиновые рулетки', checked_test4)
			imgui.NextColumn()
			imgui.Text('')
			imgui.AlignTextToFramePadding(); imgui.Text(u8("Способ открытия сундуков №1")); imgui.SameLine(); imgui.ToggleButton(u8'Способ открытия сундуков №1', otkrytie) imgui.SameLine(); imgui.TextQuestion(u8"В скрипте есть 2 способа открытия сундуков, но как мне кажется, способ №1 самый стабильный. Но тестируйте и выбирайте сами, какой способ у вас лучше работает. Также теперь не нужно будет снимать галочки, чтобы прекратить открывать сундуки, ведь вы можете просто выключить данный ползунок и скрипт перестанет открывать сундуки. Также при прокрутке рулеток данная функция выключается т.к скрипт не может открывать и сундуки и рулетки, поэтому, не забывайте после прокрутки рулеток выбрать способ открытия сундуков.")
			imgui.AlignTextToFramePadding(); imgui.Text(u8("Способ открытия сундуков №2")); imgui.SameLine(); imgui.ToggleButton(u8'Способ открытия сундуков №2', otkrytie2)
			if otkrytie.v then otkrytie2.v = false
			elseif otkrytie2.v then otkrytie.v = false
			end
			imgui.Checkbox(u8'Открывать обычный сундук', checked_test5)
			imgui.Checkbox(u8'Открывать донатный сундук', checked_test6)
			imgui.Checkbox(u8'Открывать платиновый сундук', checked_test7)
			imgui.Checkbox(u8'Открывать сундук "Илона Маска"', checked_test10)
			imgui.InputText(u8'Задержка ##47', zadervka)
			imgui.NextColumn()
			imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Всегда открывать обычный сундук")); imgui.SameLine(); imgui.ToggleButton(u8'Всегда открывать обычный сундук', yashik)
			imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Всегда открывать донатный сундук")); imgui.SameLine(); imgui.ToggleButton(u8'Всегда открывать донатный сундук', yashik1)
			imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Всегда открывать платиновый сундук")); imgui.SameLine(); imgui.ToggleButton(u8'Всегда открывать платиновый сундук', yashik2)
			imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Всегда открывать сундук 'Илона Маска'")); imgui.SameLine(); imgui.ToggleButton(u8'Всегда открывать сундук "Илона Маска"', yashik3)
			imgui.Text('') imgui.SameLine() imgui.InputText(u8'Задержка ##48',zadervkav2)
			imgui.NextColumn()
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"*Важно! Включать либо открывать сундук или всегда открывать.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Иначе работать не будет! Если включить 'всегда открывать' -")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"то скрипт будет открывать выбранные сундуки даже после")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"перезахода. Если включить 'открыть сундук' - то скрипт будет")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"открывать выбранные сундуки до перезахода. Также если")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"перестали открываться сундуки, то зайдите в /settings")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"и включите инвентарь на русский и снова на английский.")
			imgui.EndChild()
			imgui.End()
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
		
function obmenmenu()
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(760, 110), imgui.Cond.FirstUseEver)
	imgui.Begin(u8' Trade Menu', win_state['obmentrade'], imgui.WindowFlags.NoResize)
			imgui.Columns(2, _, false)
			imgui.Text('')
			imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Обменять подарки', podarki); imgui.SameLine(); imgui.TextQuestion(u8"Вам нужно встать перед Эдвардом и активировать данную функцию. Функция остановится автоматический после того, как у вас закончатся подарки.")  
			imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Обменять гражданские талоны на рулетки', platina); imgui.SameLine(); imgui.TextQuestion(u8"Вам нужно встать перед Эдвардом и активировать данную функцию. Функция остановится автоматический после того, как у вас закончатся гражданские талоны.")  
			imgui.NextColumn()
			imgui.Text('')
			imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Обменять зловещие монеты на улучшение для авто', moneta); imgui.SameLine(); imgui.TextQuestion(u8"Вам нужно встать перед Хагридом и активировать данную функцию. Функция остановится автоматический после того, как у вас закончатся зловещие монеты.")  
			imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Обменять зловещие монеты на точильные камни', tochkamen); imgui.SameLine(); imgui.TextQuestion(u8"Вам нужно встать перед Хагридом и активировать данную функцию. Функция остановится автоматический после того, как у вас закончатся зловещие монеты.")  
			imgui.End()
		end
		
function notesmenu()
	local sw, sh = getScreenResolution() 
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(750, 225), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' Заметки ', win_state['noteswin'], imgui.WindowFlags.NoResize)
		imgui.Text('')
		imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8(" Заметки")); imgui.SameLine(); imgui.ToggleButton(u8'Заметки', pismo)
				if pismo.v then
					imgui.SameLine()
					if imgui.CustomButton(u8'Переместить', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-97, 0)) then
						sampAddChatMessage("[Mono Tools]{FFFFFF} Выберите позицию и нажмите {00C2BB}Enter{FFFFFF} чтобы сохранить ее.", 0x046D63) 
						win_state['main'].v = false
						win_state['informer'].v = false
						win_state['shahtainformer'].v = false
						win_state['noteswin'].v = false
						mouseCoord6 = true
					end
				end
		imgui.PushItemWidth(645)
		imgui.Text('') imgui.SameLine() imgui.InputText(u8'Введите текст ##92', pismoreal)
		imgui.Text('') imgui.SameLine() imgui.InputText(u8'Введите текст ##93', pismoreal1)
		imgui.Text('') imgui.SameLine() imgui.InputText(u8'Введите текст ##94', pismoreal2)
		imgui.Text('') imgui.SameLine() imgui.InputText(u8'Введите текст ##95', pismoreal3)
		imgui.Text('') imgui.SameLine() imgui.InputText(u8'Введите текст ##96', pismoreal4)
		imgui.PopItemWidth()
		imgui.End()
		end
		
function tochmenu()
			local sw, sh = getScreenResolution() 
			imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(618, 138), imgui.Cond.FirstUseEver)
			imgui.Begin(u8' Toch Menu ', win_state['tochilki'], imgui.WindowFlags.NoResize)
				imgui.Text('')
				imgui.Text('') imgui.SameLine()	imgui.Checkbox(u8'Камни', checked_box2)
				imgui.SameLine()
				imgui.TextQuestion(u8"Авто-заточка аксессуара/скина камнями.")
				imgui.SameLine()
				imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Амулеты', checked_box)
				imgui.SameLine()
				imgui.TextQuestion(u8"Авто-заточка аксессуара/скина амулетами.")
				imgui.SameLine()
				imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Камни и Амулеты', checked_box3)
				imgui.SameLine()
				imgui.TextQuestion(u8"Авто-заточка аксессуара/скина камнями и амулетами.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8'Выберите на сколько будет точиться аксессуар/скин:')
				imgui.Separator()
				imgui.Text('') imgui.SameLine() imgui.RadioButton('+1', checked_radio, 1)
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
				imgui.SameLine()
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
				imgui.End()
			end
			
function offpcmenu()
			local sw, sh = getScreenResolution() 
			local btn_size = imgui.ImVec2(-0.1, 0)
			imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(-0.9, -0.9))
			imgui.SetNextWindowSize(imgui.ImVec2(180, 88), imgui.Cond.FirstUseEver)
			imgui.Begin(u8' Off Menu ', win_state['pcoff'], imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
			imgui.Text('')
			imgui.Text('') imgui.SameLine() imgui.Image(winoffpc, imgui.ImVec2(25, 25), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) imgui.SameLine() if imgui.Button(u8'Завершение работы', btn_size) then thisScript():unload() end
			imgui.Text('') imgui.SameLine() imgui.Image(winreload, imgui.ImVec2(25, 25), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) imgui.SameLine() if imgui.Button(u8'Перезагрузка', btn_size) then thisScript():reload() end
				imgui.End()
			end
			
function winprofilemenu()
			local sw, sh = getScreenResolution() 
			imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(2, -0.55))
			imgui.SetNextWindowSize(imgui.ImVec2(185, 108), imgui.Cond.FirstUseEver)
			imgui.Begin(u8' Profile Menu ', win_state['winprofile'], imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
			_, IDUPDATE = sampGetPlayerIdByCharHandle(PLAYER_PED)
			Lvlnick = sampGetPlayerScore(IDUPDATE)
			Moneynick = getPlayerMoney()
			imgui.Text('')
			imgui.Text('') imgui.SameLine() imgui.Text(u8'Имя: '..Namenick)
			imgui.Text('') imgui.SameLine() imgui.Text(u8'Фамилия: '..Famnick)
			imgui.Text('') imgui.SameLine() imgui.Text(u8'Уровень: '..Lvlnick)
			imgui.Text('') imgui.SameLine() imgui.Text(u8'Денег на руках: '..Moneynick)
			imgui.Text('')
			imgui.End()
			end
		
function kirkamenu()
	local sw, sh = getScreenResolution() 
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(582, 225), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' Шахтёр ', win_state['kirkawin'], imgui.WindowFlags.NoResize)
				imgui.Text('')
				imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Редактировать цены на ресурсы', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-8, 0)) then win_state['shahtamenu'].v = not win_state['shahtamenu'].v end
				imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Автоальт на руде', autoryda)
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Включить счетчик руд")); imgui.SameLine(); imgui.ToggleButton(u8'Включить счетчик руд', ryda)
				if ryda.v then
					imgui.SameLine()
					if imgui.CustomButton(u8'Переместить', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00)) then 
						sampAddChatMessage("[Mono Tools]{FFFFFF} Выберите позицию и нажмите {00C2BB}Enter{FFFFFF} чтобы сохранить ее.", 0x046D63)
						win_state['main'].v = false
						win_state['informer'].v = false
						win_state['pismoinformer'].v = false
						win_state['kirkawin'].v = false
						mouseCoord5 = true 
					end
				end
				imgui.SameLine(380)
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Отображение камня")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение камня', infkamen)
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Отображение металла")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение металла', infmetal)
				imgui.SameLine(380)
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Отображение бронзы")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение бронзы', infbronza)
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Отображение серебра")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение серебра', infsilver)
				imgui.SameLine(380)
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Отображение золота")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение золота', infgold)
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Отображение собранной руды")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение собранной руды', infsbor)
				imgui.SameLine(380)
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Отображение заработка")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение денег', infzp)
				imgui.End()
		end
		
function bitkoinoknomenu()
	local sw, sh = getScreenResolution() 
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(1.331, 1.068))
		imgui.SetNextWindowSize(imgui.ImVec2(375, 305), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' Улучшение видеокарт ', win_state['bitkoinwinokno'], imgui.WindowFlags.NoResize)
				imgui.Text('')
				imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Инструкция', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-210, 0)) then win_state['shemainst'].v = not win_state['shemainst'].v end
				imgui.SameLine()
				if imgui.CustomButton(u8'Редактировать ID Текстдравов', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-8, 0)) then win_state['shematext'].v = not win_state['shematext'].v end
				imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Выбрать первые 20 видеокарт', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-8, 0)) then videotrue() end
				imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Завершить улучшение видеокарт', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-8, 0)) then videofailed() end
				imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'№1  ', video); imgui.SameLine(); imgui.Checkbox(u8'№2  ', video1); imgui.SameLine(); imgui.Checkbox(u8'№3  ', video2); imgui.SameLine(); imgui.Checkbox(u8'№4  ', video3) imgui.SameLine(); imgui.Checkbox(u8'№5  ', video4); imgui.SameLine(); imgui.Checkbox(u8'№6', video5)
			    imgui.Text('') imgui.SameLine()  imgui.Checkbox(u8'№7  ', video6); imgui.SameLine(); imgui.Checkbox(u8'№8  ', video7) imgui.SameLine(); imgui.Checkbox(u8'№9  ', video8); imgui.SameLine(); imgui.Checkbox(u8'№10', video9); imgui.SameLine(); imgui.Checkbox(u8'№11', video10); imgui.SameLine(); imgui.Checkbox(u8'№12', video11)
				imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'№13', video12); imgui.SameLine(); imgui.Checkbox(u8'№14', video13); imgui.SameLine(); imgui.Checkbox(u8'№15', video14); imgui.SameLine(); imgui.Checkbox(u8'№16', video15) imgui.SameLine(); imgui.Checkbox(u8'№17', video16); imgui.SameLine(); imgui.Checkbox(u8'№18', video17)
				imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'№19', video18); imgui.SameLine(); imgui.Checkbox(u8'№20', video19) imgui.SameLine(); imgui.Checkbox(u8'№21', video20); imgui.SameLine(); imgui.Checkbox(u8'№22', video21); imgui.SameLine(); imgui.Checkbox(u8'№23', video22); imgui.SameLine(); imgui.Checkbox(u8'№24', video23)
				imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'№25', video24); imgui.SameLine(); imgui.Checkbox(u8'№26', video25); imgui.SameLine(); imgui.Checkbox(u8'№27', video26); imgui.SameLine(); imgui.Checkbox(u8'№28', video27) imgui.SameLine(); imgui.Checkbox(u8'№29', video28); imgui.SameLine(); imgui.Checkbox(u8'№30', video29)
				imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'№31', video30); imgui.SameLine(); imgui.Checkbox(u8'№32', video31) imgui.SameLine(); imgui.Checkbox(u8'№33', video32); imgui.SameLine(); imgui.Checkbox(u8'№34', video33); imgui.SameLine(); imgui.Checkbox(u8'№35', video34); imgui.SameLine(); imgui.Checkbox(u8'№36', video35)
		imgui.End()
		if not win_state['bitkoinwinokno'].v then win_state['shemafunks'].v = false win_state['shema'].v = false end
		if not win_state['shemafunks'].v then win_state['bitkoinwinokno'].v = false win_state['shema'].v = false end
		if not win_state['shema'].v then win_state['bitkoinwinokno'].v = false win_state['shemafunks'].v = false end
		end
		
function bankmenu()
	local sw, sh = getScreenResolution() 
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(805, 250), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' Bank Menu ', win_state['bank'], imgui.WindowFlags.NoResize)
				imgui.BeginChild('##asdasasddf323452354', imgui.ImVec2(800, 220), false)
				imgui.Columns(2, _, false)
				imgui.Text('')
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Оплата налогов за авто, коммуналку, дом и бизнес")); imgui.SameLine(); imgui.ToggleButton(u8("Оплата налогов за авто, коммуналку, дом и бизнес"), autoopl); imgui.SameLine(); imgui.TextQuestion(u8"Чтобы начать авто-оплату, зайдите в меню Банка на N и нажмите 'Пополнить счёт SIM'.");
				if autoopl.v then
					imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Номера строк:")
					imgui.Text('') imgui.SameLine() imgui.InputText(u8'Авто ##8', autopassopl); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за авто' и вписываете получившиеся номер строки. По умолчанию стоит 6 строка.")
					imgui.Text('') imgui.SameLine() imgui.InputText(u8'Коммуналка ##9', autopassopl1); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата коммуналки' и вписываете получившиеся номер строки. По умолчанию стоит 15 строка.")
					imgui.Text('') imgui.SameLine() imgui.InputText(u8'Дом ##10', autopassopl2); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за дом' и вписываете получившиеся номер строки. По умолчанию стоит 16 строка.")
					imgui.Text('') imgui.SameLine() imgui.InputText(u8'Бизнес ##11', autopassopl3); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за бизнес' и вписываете получившиеся номер строки. По умолчанию стоит 17 строка.")
				end
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Оплата налогов за коммуналку, дом и бизнес")); imgui.SameLine(); imgui.ToggleButton(u8("Оплата налогов за коммуналку, дом и бизнес"), autoopl2); imgui.SameLine(); imgui.TextQuestion(u8"Чтобы начать авто-оплату, зайдите в меню Банка на N и нажмите 'Пополнить счёт SIM'.");
				if autoopl2.v then
					imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Номера строк:")
					imgui.Text('') imgui.SameLine() imgui.InputText(u8'Коммуналка ##12', autopassopl1); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата коммуналки' и вписываете получившиеся номер строки. По умолчанию стоит 15 строка.")
					imgui.Text('') imgui.SameLine() imgui.InputText(u8'Дом ##13', autopassopl2); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за дом' и вписываете получившиеся номер строки. По умолчанию стоит 16 строка.")
					imgui.Text('') imgui.SameLine() imgui.InputText(u8'Бизнес ##14', autopassopl3); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за бизнес' и вписываете получившиеся номер строки. По умолчанию стоит 17 строка.")
				end
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Оплата налогов за авто, коммуналку и дом")); imgui.SameLine(); imgui.ToggleButton(u8("Оплата налогов за авто, коммуналку и дом"), autoopl1); imgui.SameLine(); imgui.TextQuestion(u8"Чтобы начать авто-оплату, зайдите в меню Банка на N и нажмите 'Пополнить счёт SIM'.");
				if autoopl1.v then
					imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Номера строк:")
					imgui.Text('') imgui.SameLine() imgui.InputText(u8'Авто ##15', autopassopl); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за авто' и вписываете получившиеся номер строки. По умолчанию стоит 6 строка.")
					imgui.Text('') imgui.SameLine() imgui.InputText(u8'Коммуналка ##16', autopassopl1); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата коммуналки' и вписываете получившиеся номер строки. По умолчанию стоит 15 строка.")
					imgui.Text('') imgui.SameLine() imgui.InputText(u8'Дом ##17', autopassopl2); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за дом' и вписываете получившиеся номер строки. По умолчанию стоит 16 строка.")
				end
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Оплата налогов за коммуналку и дом")); imgui.SameLine(); imgui.ToggleButton(u8("Оплата налогов за коммуналку и дом"), autoopl5); imgui.SameLine(); imgui.TextQuestion(u8"Чтобы начать авто-оплату, зайдите в меню Банка на N и нажмите 'Пополнить счёт SIM'.");
				if autoopl5.v then
					imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Номера строк:")
					imgui.Text('') imgui.SameLine() imgui.InputText(u8'Коммуналка ##18', autopassopl1); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата коммуналки' и вписываете получившиеся номер строки. По умолчанию стоит 15 строка.")
					imgui.Text('') imgui.SameLine() imgui.InputText(u8'Дом ##19', autopassopl2); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за дом' и вписываете получившиеся номер строки. По умолчанию стоит 16 строка.")
				end
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Оплата налогов за авто и бизнес")); imgui.SameLine(); imgui.ToggleButton(u8("Оплата налогов за авто и бизнес"), autoopl3); imgui.SameLine(); imgui.TextQuestion(u8"Чтобы начать авто-оплату, зайдите в меню Банка на N и нажмите 'Пополнить счёт SIM'.");
				if autoopl3.v then
					imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Номера строк:")
					imgui.Text('') imgui.SameLine() imgui.InputText(u8'Авто ##20', autopassopl); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за авто' и вписываете получившиеся номер строки. По умолчанию стоит 6 строка.")
					imgui.Text('') imgui.SameLine() imgui.InputText(u8'Бизнес ##21', autopassopl3); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за бизнес' и вписываете получившиеся номер строки. По умолчанию стоит 17 строка.")
				end
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Оплата налогов за бизнес")); imgui.SameLine(); imgui.ToggleButton(u8("Оплата налогов за бизнес"), autoopl6); imgui.SameLine(); imgui.TextQuestion(u8"Чтобы начать авто-оплату, зайдите в меню Банка на N и нажмите 'Пополнить счёт SIM'.");
				if autoopl6.v then
					imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Номера строк:")
					imgui.Text('') imgui.SameLine() imgui.InputText(u8'Бизнес ##22', autopassopl3); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за бизнес' и вписываете получившиеся номер строки. По умолчанию стоит 17 строка.")
				end
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Оплата налогов за авто")); imgui.SameLine(); imgui.ToggleButton(u8("Оплата налогов за авто"), autoopl4); imgui.SameLine(); imgui.TextQuestion(u8"Чтобы начать авто-оплату, зайдите в меню Банка на N и нажмите 'Пополнить счёт SIM'.");
				if autoopl4.v then
					imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Номера строк:")
					imgui.Text('') imgui.SameLine() imgui.InputText(u8'Авто ##23', autopassopl); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Оплата налогов за авто' и вписываете получившиеся номер строки. По умолчанию стоит 6 строка.")
				end
				imgui.NextColumn()
				imgui.Text('')
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Пополнение депозита каждый PD")); imgui.SameLine(); imgui.ToggleButton(u8("Пополнение депозита каждый PD"), autopay); imgui.SameLine(); imgui.TextQuestion(u8"Пополняет депозит на указанную сумму когда скрипт видит в чате 'Банковский чек'. Также вы должны в этот момент стоять у кассы в Банке, иначе депозит не пополнится.");
				if autopay.v then
					imgui.Text('') imgui.SameLine(4) imgui.InputText(u8'Номер строки ##24', autopasspaypin); imgui.SameLine(); imgui.TextQuestion(u8"Обязательно нужно указать номер строки в диалоге банковского меню цифрой. Например: первая строка 'Состояние основного счета' имеет номер строки 0, следующая строка будет иметь номер строки 1 и так далее. Таким методом отсчитываете до 'Пополнения Депозита' и вписываете получившиеся номер строки. По умолчанию стоит 8 строка.")
					imgui.Text('') imgui.SameLine(4) imgui.InputText(u8'Сумма ##25', autopasspay); imgui.SameLine(); imgui.TextQuestion(u8"В данном пункте обязательно нужно указать сумму пополнения. По умолчанию стоит 5.000.000$")
			end
				imgui.Text('') imgui.SameLine(4) imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"*Важно! Оплату налогов включать только один из нужных вам")
				imgui.Text('') imgui.SameLine(4) imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"пунктов! Также внимательно читайте как и что нужно настроить.")
				imgui.EndChild()
		imgui.End()
		end
	
function shemamenu()
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(733, 252), imgui.Cond.FirstUseEver)
	imgui.Begin(u8' Редактирование ID Текстдравов', win_state['shematext'], imgui.WindowFlags.NoResize)
			imgui.BeginChild('##asdasasddf2131', imgui.ImVec2(800, 220), false)
			imgui.Text('')
			imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Включить отображение ID Текстдравов', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-440, 0)) then toggle = true end 
			imgui.SameLine()
			if imgui.CustomButton(u8'Выключить отображение ID Текстдравов', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-75, 0)) then toggle = false end
			imgui.PushItemWidth(80)
			imgui.Text('') imgui.SameLine() imgui.InputText(u8'№1 ##49', shematext1); imgui.SameLine(129); imgui.InputText(u8'№2 ##50', shematext2); imgui.SameLine(250); imgui.InputText(u8'№3 ##51', shematext3); imgui.SameLine(371); imgui.InputText(u8'№4 ##52', shematext4); imgui.SameLine(492); imgui.InputText(u8'№5 ##53', shematext5); imgui.SameLine(613); imgui.InputText(u8'№6 ##54', shematext6)
			imgui.Text('') imgui.SameLine() imgui.InputText(u8'№7 ##55', shematext7); imgui.SameLine(129); imgui.InputText(u8'№8 ##56', shematext8); imgui.SameLine(250); imgui.InputText(u8'№9 ##57', shematext9); imgui.SameLine(371); imgui.InputText(u8'№10 ##58', shematext10); imgui.SameLine(); imgui.InputText(u8'№11 ##59', shematext11); imgui.SameLine(); imgui.InputText(u8'№12 ##60', shematext12)
			imgui.Text('') imgui.SameLine() imgui.InputText(u8'№13 ##61', shematext13); imgui.SameLine(); imgui.InputText(u8'№14 ##62', shematext14); imgui.SameLine(); imgui.InputText(u8'№15 ##63', shematext15); imgui.SameLine(); imgui.InputText(u8'№16 ##64', shematext16); imgui.SameLine(); imgui.InputText(u8'№17 ##65', shematext17); imgui.SameLine(); imgui.InputText(u8'№18 ##66', shematext18)
			imgui.Text('') imgui.SameLine() imgui.InputText(u8'№19 ##67', shematext19); imgui.SameLine(); imgui.InputText(u8'№20 ##68', shematext20); imgui.SameLine(); imgui.InputText(u8'№21 ##69', shematext21); imgui.SameLine(); imgui.InputText(u8'№22 ##70', shematext22); imgui.SameLine(); imgui.InputText(u8'№23 ##71', shematext23); imgui.SameLine(); imgui.InputText(u8'№24 ##72', shematext24)
			imgui.Text('') imgui.SameLine() imgui.InputText(u8'№25 ##73', shematext25); imgui.SameLine(); imgui.InputText(u8'№26 ##74', shematext26); imgui.SameLine(); imgui.InputText(u8'№27 ##75', shematext27); imgui.SameLine(); imgui.InputText(u8'№28 ##76', shematext28); imgui.SameLine(); imgui.InputText(u8'№29 ##77', shematext29); imgui.SameLine(); imgui.InputText(u8'№30 ##78', shematext30)
			imgui.Text('') imgui.SameLine() imgui.InputText(u8'№31 ##79', shematext31); imgui.SameLine(); imgui.InputText(u8'№32 ##80', shematext32); imgui.SameLine(); imgui.InputText(u8'№33 ##81', shematext33); imgui.SameLine(); imgui.InputText(u8'№34 ##82', shematext34); imgui.SameLine(); imgui.InputText(u8'№35 ##83', shematext35); imgui.SameLine(); imgui.InputText(u8'№36 ##84', shematext36)
			imgui.PopItemWidth()
			imgui.EndChild()
			imgui.End()
	end
	
function helpmenu()
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(950, 285), imgui.Cond.FirstUseEver)
		imgui.Begin(u8('Помощь'), win_state['help'], imgui.WindowFlags.NoResize)
		imgui.Text('')
		imgui.BeginGroup()
		imgui.Text('') imgui.SameLine() imgui.BeginChild('left pane', imgui.ImVec2(180, 225), true)
		imgui.Text('') imgui.SameLine() if imgui.Selectable(u8"Команды скрипта") then selected2 = 2 end
		imgui.Separator()
		imgui.Text('') imgui.SameLine() if imgui.Selectable(u8"Коды клавиш") then selected2 = 3 end		
		imgui.Separator()
		imgui.EndChild()
		imgui.SameLine()
		imgui.BeginChild('##ddddd', imgui.ImVec2(745, 225), true)
		if selected2 == 0 then selected2 = 1
		elseif selected2 == 3 then
		imgui.Text('') imgui.SameLine() imgui.Text(u8"Коды клавиш")
		imgui.Columns(2, _,false)
		imgui.SetColumnWidth(-1, 800)
		imgui.Separator()
		imgui.Text('') imgui.SameLine() imgui.Text(u8"Tab - 9"); imgui.SameLine(); imgui.Text(u8"Enter - 13"); imgui.SameLine(); imgui.Text(u8"Shift - 16"); imgui.SameLine(); imgui.Text(u8"Ctrl - 17"); imgui.SameLine(); imgui.Text(u8"Alt - 18"); imgui.SameLine(); imgui.Text(u8"Pause - 19"); imgui.SameLine(); imgui.Text(u8"CapsLock - 20"); imgui.SameLine(); imgui.Text(u8"Esc - 27"); imgui.SameLine(); imgui.Text(u8"Пробел - 32"); imgui.SameLine(); imgui.Text(u8"PageUp - 33")
		imgui.Text('') imgui.SameLine() imgui.Text(u8"PageDown - 34"); imgui.SameLine(); imgui.Text(u8"End - 35"); imgui.SameLine(); imgui.Text(u8"Home - 36"); imgui.SameLine(); imgui.Text(u8"Стрелка влево - 37"); imgui.SameLine(); imgui.Text(u8"Стрелка вверх - 38"); imgui.SameLine(); imgui.Text(u8"Стрелка вправо - 39"); imgui.SameLine(); imgui.Text(u8"Стрелка вниз - 40")
		imgui.Text('') imgui.SameLine() imgui.Text(u8"Insert - 45"); imgui.SameLine(); imgui.Text(u8"Delete - 46"); imgui.SameLine(); imgui.Text(u8"0 - 48"); imgui.SameLine(); imgui.Text(u8"1 - 49"); imgui.SameLine(); imgui.Text(u8"2 - 50"); imgui.SameLine(); imgui.Text(u8"3 - 51"); imgui.SameLine(); imgui.Text(u8"4 - 52"); imgui.SameLine(); imgui.Text(u8"5 - 53"); imgui.SameLine(); imgui.Text(u8"6 - 54"); imgui.SameLine(); imgui.Text(u8"7 - 55"); imgui.SameLine(); imgui.Text(u8"8 - 56"); imgui.SameLine(); imgui.Text(u8"9 - 57"); imgui.SameLine(); imgui.Text (u8"A - 65"); imgui.SameLine(); imgui.Text (u8"B - 66")	
		imgui.Text('') imgui.SameLine() imgui.Text (u8"C - 67"); imgui.SameLine(); imgui.Text (u8"D - 68"); imgui.SameLine();	imgui.Text (u8"E - 69"); imgui.SameLine();	imgui.Text (u8"F - 70"); imgui.SameLine();	imgui.Text (u8"G - 71"); imgui.SameLine();	imgui.Text (u8"H - 72"); imgui.SameLine();	imgui.Text (u8"I - 73"); imgui.SameLine();	imgui.Text (u8"J - 74"); imgui.SameLine();	imgui.Text (u8"K - 75"); imgui.SameLine();	imgui.Text (u8"L - 76"); imgui.SameLine();	imgui.Text (u8"M - 77"); imgui.SameLine();	imgui.Text (u8"N - 78"); imgui.SameLine();	imgui.Text (u8"O - 79"); imgui.SameLine();	imgui.Text (u8"P - 80"); imgui.SameLine();	imgui.Text (u8"Q - 81")	
		imgui.Text('') imgui.SameLine() imgui.Text (u8"R - 82"); imgui.SameLine();	imgui.Text (u8"S - 83"); imgui.SameLine();	imgui.Text (u8"T - 84"); imgui.SameLine();	imgui.Text (u8"U - 85"); imgui.SameLine();	imgui.Text (u8"V - 86"); imgui.SameLine();	imgui.Text (u8"W - 87"); imgui.SameLine();	imgui.Text (u8"X - 88"); imgui.SameLine();	imgui.Text (u8"Y - 89"); imgui.SameLine();	imgui.Text (u8"Z - 90"); imgui.SameLine();	imgui.Text (u8"левая клавиша Windows - 91")
		imgui.Text('') imgui.SameLine() imgui.Text (u8"правая клавиша Windows - 92"); imgui.SameLine(); imgui.Text (u8"NumPad 0 - 96"); imgui.SameLine(); imgui.Text (u8"NumPad 1 - 97"); imgui.SameLine(); imgui.Text (u8"NumPad 2 - 98"); imgui.SameLine(); imgui.Text (u8"NumPad 3 - 99"); imgui.SameLine(); imgui.Text (u8"NumPad 4 - 100")
		imgui.Text('') imgui.SameLine() imgui.Text (u8"NumPad 5 - 101"); imgui.SameLine(); imgui.Text (u8"NumPad 6 - 102"); imgui.SameLine(); imgui.Text (u8"NumPad 7 - 103"); imgui.SameLine(); imgui.Text (u8"NumPad 8 - 104"); imgui.SameLine(); imgui.Text (u8"NumPad 9 - 105"); imgui.SameLine(); imgui.Text (u8"NumPad * - 106"); imgui.SameLine(); imgui.Text (u8"NumPad + - 107")
		imgui.Text('') imgui.SameLine() imgui.Text (u8"NumPad - - 109"); imgui.SameLine(); imgui.Text (u8"NumPad . - 119"); imgui.SameLine(); imgui.Text (u8"NumPad / - 111"); imgui.SameLine(); imgui.Text (u8"F3 - 114"); imgui.SameLine(); imgui.Text (u8"F4 - 115"); imgui.SameLine(); imgui.Text (u8"F5 - 116"); imgui.SameLine(); imgui.Text (u8"F6 - 117"); imgui.SameLine(); imgui.Text (u8"F7 - 118"); imgui.SameLine(); imgui.Text (u8"F8 - 119"); imgui.SameLine(); imgui.Text (u8"F9 - 120")
		imgui.Text('') imgui.SameLine() imgui.Text (u8"F10 - 121"); imgui.SameLine(); imgui.Text (u8"F11 - 122"); imgui.SameLine(); imgui.Text (u8"F12 - 123")
		elseif selected2 == 2 then
			imgui.Text('') imgui.SameLine() imgui.Text(u8"Команды скрипта")
			imgui.Separator()
			imgui.Columns(2, _,false)
			imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(0.80, 0.73 , 0, 1.0), u8"/reload - Перезагрузка скрипта.")
				imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(0.80, 0.73 , 0, 1.0), u8"/сс - Очистка чата.")
				imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(0.80, 0.73 , 0, 1.0), u8"/drone - Получить картинку с дрона на территории.")
				imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(0.80, 0.73 , 0, 1.0), u8"/afind - Автопоиск игрока через /find.")
				imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(0.80, 0.73 , 0, 1.0), u8"/sfind - Отключение автопоиска.")
				imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(0.80, 0.73 , 0, 1.0), u8"/recon - Перезайти на сервер через 30 секунд.")
				imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(0.80, 0.73 , 0, 1.0), u8"/recon [время] - Перезайти на сервер через указанное время(в секундах).")
				imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(0.80, 0.73 , 0, 1.0), u8"/strobes - включение/отключение стробоскопов.")
				imgui.Separator()
				imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Важно! Для того, чтобы все функции скрипта работали стабильно, нужно чтобы инвентарь был на английском языке!")
				imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Настройть язык инвентаря вы можете в /settings. Убедительная просьба не выключать автообновления в коде.")
				imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Иначе вы в будущем не получите улучшения или исправление ошибок.")
		end
		imgui.EndChild()
        imgui.EndGroup()
        imgui.End()
	end
	
function googlewinmenu()
	local tLastKeys = {} -- это у нас для клавиш
	local input = sampGetInputInfoPtr()
    local input = getStructElement(input, 0x8, 4)
    local windowPosX = getStructElement(input, 0x8, 4)
    local windowPosY = getStructElement(input, 0xC, 4)
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(950, 520), imgui.Cond.FirstUseEver)
		imgui.Begin(u8('Браузер'), win_state['googlewin'], imgui.WindowFlags.NoResize)
		imgui.BeginGroup()
		imgui.Text('')
		imgui.Text('') imgui.SameLine() imgui.BeginChild('saitgoogle', imgui.ImVec2(935, 20), true)
		imgui.Text('') imgui.SameLine() imgui.Text('https://www.Mono-Tools.com/news_and_advertising')
		imgui.EndChild()
		imgui.Text('') imgui.SameLine() imgui.BeginChild('newsgoogle', imgui.ImVec2(935, 440), true)
		imgui.Separator()
		imgui.Text('') imgui.SameLine(430) imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0),u8'Новости') 
		imgui.Separator()
		imgui.Text('') imgui.SameLine() imgui.Image(winarizonanews, imgui.ImVec2(200, 100), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) 
		imgui.SameLine() 
		imgui.Image(wintools3, imgui.ImVec2(200, 100), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) 
		imgui.SameLine() 
		imgui.Image(winmonopolynews, imgui.ImVec2(200, 100), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) 
		imgui.SameLine() 
		imgui.Image(winaforma, imgui.ImVec2(295, 100), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) 
		imgui.Text('') imgui.SameLine() imgui.Text(u8'Недавно проекту Arizona RP') imgui.SameLine(215) imgui.Text(u8'Mono Tools версия 3.0 уже') imgui.SameLine(435) imgui.Text(u8'Группа в VK "Monopoly"') imgui.SameLine(635) imgui.Text(u8'А вы знали, что у Буни есть еще один скрипт в')
		imgui.Text('') imgui.SameLine() imgui.Text(u8'исполнилось целых 7 лет! А вы') imgui.SameLine(215) imgui.Text(u8'доступна для скачивания! Новый') imgui.SameLine(435) imgui.Text(u8'набрали уже 5.1к подписчиков!') imgui.SameLine(635) imgui.Text(u8'открытом доступе под названием "Aforma"?')
		imgui.Text('') imgui.SameLine() imgui.Text(u8'уже успели пройти квесты и') imgui.SameLine(215) imgui.Text(u8'интерфейс и функции уже ожидают') imgui.SameLine(435) imgui.Text(u8'Поможем добить Монополистам') imgui.SameLine(635) imgui.Text(u8'Скрипт был написан для Администрации')
		imgui.Text('') imgui.SameLine() imgui.Text(u8'получить 1600 аз коин?)') imgui.SameLine(215) imgui.Text(u8'вас. Спасибо, что вы с нами!)') imgui.SameLine(435) imgui.Text(u8'6к?') imgui.SameLine(635) imgui.Text(u8'сервера Прескотт. Но популярным не стал.')
		imgui.Separator()
		imgui.Text('') imgui.SameLine(380) imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0),u8'Реклама и полезные ссылки') 
		imgui.Separator()
		imgui.Text('') imgui.SameLine() imgui.Text(u8'Вы ловец? Или вы игрок с депозитом? Тогда есть для вас крутая новость! Семья "Bynes" на ARZ RP Prescott активно набирает людей в свою семью. Семья')
		imgui.Text('') imgui.SameLine() imgui.Text(u8'имеет галочку, бренд и остальные улучшения. Принимают абсолютно всех с 3-го лвла. Звоните: 55864.')
		imgui.Separator()
		imgui.Text('') imgui.SameLine() imgui.Text(u8'Желаете заработать много денег? Тогда вводи при регистрации на Arizona RP Prescott ник Bunya_Monopoly и первые 12 человек получат по 2.000.000$')
		imgui.Text('') imgui.SameLine() imgui.Text(u8'при достижений 8-го лвла.')
		imgui.Separator()
		imgui.Text('') imgui.SameLine() imgui.Text(u8'А вы знали, что в Монополи есть Ютубер? Его канал "Marquis". Не стесняйтесь, подписывайтесь и пишите ему, что вы от Буни, посмотрим сколько нас!')
		imgui.Separator()
		imgui.Text('') imgui.SameLine() imgui.TextColoredRGB("Промо-код на 09, 11 и 12, за который можно получить 1.000.000$ от Монополистов: {FFA500}#monopoly{FFA500}")
		imgui.Separator()
		imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Жми и поддержи автора лайком!', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-500, 0)) then os.execute("start https://www.blast.hk/threads/89343/") end
		imgui.SameLine()
		if imgui.CustomButton(u8'Много нас тут? Давайте узнаем! Отпишите в теме и посмотрим сколько нас!', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-8, 0)) then os.execute("start https://www.blast.hk/threads/89343/") end
		imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Ты сампер? А может любишь мани? Тогда жми и подпишись на группу Монополи!', imgui.ImVec4(1.00, 0.19, 0.19, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-430, 0)) then os.execute("start https://vk.com/monopolyfam") end
		imgui.SameLine()
		if imgui.CustomButton(u8'Тыкай и будешь приходить на стримы Маркиза каждый день.', imgui.ImVec4(1.00, 0.19, 0.19, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-8, 0)) then os.execute("start https://www.youtube.com/channel/UCJaqtq_cvdFZxTzPPGbwNXw/videos") end
		imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Хочешь предложить новость, идею или заказать рекламу? Тогда жми!', imgui.ImVec4(0.41, 0.19, 0.63, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-500, 0)) then os.execute("start https://vk.com/mono_tools") end
		imgui.SameLine()
		if imgui.CustomButton(u8'Кстати ты можешь стать спонсором скрипта, пожертвовав копеечку на развитие', imgui.ImVec4(0.41, 0.19, 0.63, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-8, 0)) then os.execute("start https://www.donationalerts.com/r/bunya75") end
		imgui.EndChild()
        imgui.EndGroup()
        imgui.End()
	end
	
function updatewinmenu()
	local tLastKeys = {} -- это у нас для клавиш
	local input = sampGetInputInfoPtr()
    local input = getStructElement(input, 0x8, 4)
    local windowPosX = getStructElement(input, 0x8, 4)
    local windowPosY = getStructElement(input, 0xC, 4)
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(950, 520), imgui.Cond.FirstUseEver)
		imgui.Begin(u8('Аризоне 7 лет! Помощь по обновлению и квестам.'), win_state['updatewin'], imgui.WindowFlags.NoResize)
		if imgui.CollapsingHeader(u8'Текст обновления') then
				imgui.BeginChild('##as2dasasdf434345', imgui.ImVec2(930, 465), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"С 22 - 25 Августа и 30 - 31 Августа будет доступен х4 Donate и х4 PayDay!")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"С обновлением добавили:")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1) Праздничную площадь с 3 НПС(Более 40+ Квестов).")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2) За все пройденные квесты , вы заработаете 1600+ Az-Coins.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3) Отдельное Здание Arizona Games.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"4) Почтовое Отделение.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"5) Большого Робота возле ЖДЛС.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"6) Пройдя все ивентовые квесты , вы получите Рулеткой 7-й Годовщины.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"7) Каждый PayDay вы будете получать по 1 Монете 7-й Годовщины.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"8) Добавили новые аксессуары.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"9) На праздничной площади вас будет ждать 3 Мероприятия: Морской Бой, Космические Полёты и Гонки.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"10) Новый остров - Заброшенный Город, там вас будет ждать ларёк новых аксессуаров.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"11) Теперь можно выставлять свой бизнес на Аукцион.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"12) Полностью переделали ТСР (Маппинг , Интерьер)")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"13) Теперь отвозить материалы с ТСР, можно теперь только в другие Армии, а создавать материалы будут - заключённые.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"14) В Гетто добавили нового НПС 'Тёмная Удача'.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"15) Добавили новые закладки для Банд, с которых вам может выпасть машина.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"16) Владельцы 5-ти Домов будут получать каждый день 2 Ларьца Олигарха, для этого вам придется приехать в банк и забрать их.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"17) В Русский Стандарт добавили 3 Новые Машины: Лада Веста SW Cross, УАЗ Патриот и Волга.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"18) Добавили новые 6 Машин, которые будут слетать в LUXE АвтоСалоне.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"19) Добавили ОЧЕНЬ много Скинов.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"20) В Больницах обновили Автопарк.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"21) Для ПД был сделан новый квест, за который вы получите Ламбу или Феру, для этого вам потребуется выполнить 135 Ежедневных Квестов в вашей Фракции.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"22) Для МЗ был сделан новый квест, за который вы получите Dodge (2 Версии) или Ford (2 Версии), для этого вам потребуется выполнить 125 Ежедневных Квестов в вашей Фракции.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"23) Теперь выдавая Мед.Карту или Рецепт, половина будет идти в Банк Фракции, а вторая половина - вам.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"24) Сотрудники полиции теперь смогут пользоваться обновлённым Тайзером.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"25) В ларец премии добавили новые Автомобили.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"26) Добавили новое улучшение для Бизнеса - Музыкальный Центр (23кк), при заходе в ваш бизнес - будет играть рандомная музыка с Бумбокса.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"27) Владельцы Личных Ферм теперь смогут украшать её обьектами для Домов или Бизнесов.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"28) Добавили Солнечные Панели, установив их возле своего дома - вы не будете получать Комуналку.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"29) Убрали ники Владельцев Домов.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"30) Владельцев Домов теперь можно смотреть только через номер 997 и указав номер дома (15+ LvL).")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"31) Узнавать ник владельца можно только 1 раз в 3 Часа.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"32) Были добавлены 2 новых Улучшения: Возможность владеть сразу 2 Фермами и Возможность покупки навыка Дальнобойщика.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"33) В Donate добавили новые скины, стоимость - 1200 Az, старые скины - 500 Az.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"34) Владельцы улучшения 'Планшет' , могут удалять своё обьявление дистанционно.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"35) Были Добавлены 2 Новых Ларька с Едой (Бизнесы): Шахта и Ферма.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"36) На Пляже СМ добавили возможность покупки Энергетических Батончиков.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"37) Теперь можно устанавливать вступительные ранги для семейных Каптов.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"38) Полностью обновили Однорукого Бандита в Казино.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"39) Добавили новый Нарко Притон.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"40) Лидер банды теперь может установить ранг, с которого будут доступны машины или же перевозка денег и ресурсов.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"41) Добавили DM Зону для Банд.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"42) Добавили Поздравления Игрока у которого день рождения, при входе в игру вы попадёте в праздничный интерьер.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"43) В меню GPS были добавлены все Нарко Притоны.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"44) Теперь при закрытии бизнеса будет отображаться игрок который закрыл и причина.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"45) Добавлено отображение Пола и Имущества в Паспорте.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"46) На АБ добавлен пикап, с помощью которого вы сможете посмотреть все цены.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"47) Теперь вы можете одевать абсолютно любой скин , не в зависимости от пола.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"48) Добавили ЗЗ на рынок Лодок.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"49) Исправлен Баг с выдачей АЗ в последнем глобальном достижении.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"50) Увеличены расходы Масла и Двигателя на 15%.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"51) Аренда Билбородов подешевела в 2 раза, а срок аренды увеличен до 200 Часов.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"52) Команда /ticket в ПД снова доступна со 2 Ранга.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"53) Была увеличена зона на Семейных Каптах, в которых учитываются фраги.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8'Ответы на вопросы от квестовых персонажей') then
				imgui.BeginChild('##as2dasasdf45454', imgui.ImVec2(950, 90), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"Клаус - 21133")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"Деймон - 13132")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"Стеффан - 31233")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"Джереми - 22111")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"Мэтта - 12233")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8'Ответы на вопросы Burning Man') then
				imgui.BeginChild('##as2dasasdf45434', imgui.ImVec2(950, 80), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"Вопрос: Правда ли, что на Burning Man можно купить только лед и кофе? Ответ: Да.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"Вопрос: Назовите одного из основателей фестиваля Burning Man. Ответ: Ларри Харви.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"Вопрос: В каком году начали праздновать Burning Man? Ответ: 1986.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"Вопрос: Как переводится Burning Man? Ответ: Горящий человек.")
		imgui.EndChild()
		end
		imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Убирать диалог после входа в игру")); imgui.SameLine(); imgui.ToggleButton(u8("Убирать диалог после входа в игру"), dialogupdate) imgui.SameLine() imgui.TextQuestion(u8"Функция закрывает диалог с поздравлением от Аризоны после спавна персонажа.")
	    imgui.SameLine(320)
		imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Открывать сундук 7-й годовщины', newroulette) imgui.SameLine() imgui.TextQuestion(u8"Функция автоматический крутить рулетку в сундуке 7-й годовщины. Перед активацией функции, сначала откройте рулетку, нажав на сундук. Функция перестанет крутить рулетку, если у вас закончились монеты.")
		imgui.SameLine(598)
		imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Показать маркеры для прохождения лабиринта ##212', labirint) imgui.SameLine() imgui.TextQuestion(u8"Функция ставит чекпоинты в лабиринте, тем самым показывая вам маршрут для его прохождения.")
		imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Фикс инвентаря")); imgui.SameLine(); imgui.ToggleButton(u8("Фикс инвентаря"), dialogfix) imgui.SameLine() imgui.TextQuestion(u8"Функция через 10 секунд после спавна открывает /mm и закрывает, чтобы разбагать инвентарь. Инвентарь багается из-за 'Убирать диалог после входа в игру'.")
		imgui.SameLine(328)
		imgui.Checkbox(u8'ВХ на пропавший предмет, железные обломки, ржавые детали и покорёженый металл', WHupdate) imgui.SameLine() imgui.TextQuestion(u8"Рисует линий на указанные предметы, тем самым показывая вам их местонахождение. Данные предметы находятся на острове и нужны для выполнения квеста или обмена на аксессуары.")
		imgui.Separator()
		imgui.Text('') imgui.SameLine() imgui.Text(u8'Отобразить на карте метку с местонахождением достопримечательностей:') imgui.SameLine() imgui.TextQuestion(u8"Функция активирует на радаре метку с местонахождением достопримечательности. Нужно для прохождения квеста.")
		imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'№1 ##212', prazdnik) 
		imgui.SameLine()
		imgui.Checkbox(u8'№2 ##212', prazdnik1) 
		imgui.SameLine()
		imgui.Checkbox(u8'№3 ##212', prazdnik2) 
		imgui.SameLine()
		imgui.Checkbox(u8'№4 ##212', prazdnik3) 
		imgui.SameLine()
		imgui.Checkbox(u8'№5 ##212', prazdnik4) 
		imgui.SameLine()
		imgui.Checkbox(u8'№6 ##212', prazdnik5) 
		imgui.SameLine()
		imgui.Checkbox(u8'№7 ##212', prazdnik6) 
		imgui.SameLine()
		if imgui.CustomButton(u8'Отображение карты с метками на экране ##1', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-8, 0)) then win_state['prazdnikwin'].v = not win_state['prazdnikwin'].v end
		if prazdnik.v then prazdnik1.v = false prazdnik2.v = false prazdnik3.v = false prazdnik4.v = false prazdnik5.v = false prazdnik6.v = false end
		if prazdnik1.v then prazdnik.v = false prazdnik2.v = false prazdnik3.v = false prazdnik4.v = false prazdnik5.v = false prazdnik6.v = false end
		if prazdnik2.v then prazdnik1.v = false prazdnik.v = false prazdnik3.v = false prazdnik4.v = false prazdnik5.v = false prazdnik6.v = false end
		if prazdnik3.v then prazdnik1.v = false prazdnik2.v = false prazdnik.v = false prazdnik4.v = false prazdnik5.v = false prazdnik6.v = false end
		if prazdnik4.v then prazdnik1.v = false prazdnik2.v = false prazdnik3.v = false prazdnik.v = false prazdnik5.v = false prazdnik6.v = false end
		if prazdnik5.v then prazdnik1.v = false prazdnik2.v = false prazdnik3.v = false prazdnik4.v = false prazdnik.v = false prazdnik6.v = false end
		if prazdnik6.v then prazdnik1.v = false prazdnik2.v = false prazdnik3.v = false prazdnik4.v = false prazdnik5.v = false prazdnik.v = false end
		imgui.Separator()
		imgui.Text('') imgui.SameLine() imgui.Text(u8'Отобразить на карте метку с местонахождением роботов:') imgui.SameLine() imgui.TextQuestion(u8"Функция активирует на радаре метку с местонахождением роботов. Нужно для прохождения квеста.")
		imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'№1 ##213', robot) 
		imgui.SameLine()
		imgui.Checkbox(u8'№2 ##213', robot1) 
		imgui.SameLine()
		imgui.Checkbox(u8'№3 ##213', robot2) 
		imgui.SameLine()
		imgui.Checkbox(u8'№4 ##213', robot3) 
		imgui.SameLine()
		imgui.Checkbox(u8'№5 ##213', robot4) 
		imgui.SameLine()
		imgui.Checkbox(u8'№6 ##213', robot5) 
		imgui.SameLine()
		imgui.Checkbox(u8'№7 ##213', robot6) 
		imgui.SameLine()
		imgui.Checkbox(u8'№8 ##213', robot7) 
		imgui.SameLine()
		imgui.Checkbox(u8'№9 ##213', robot8) 
		imgui.SameLine()
		imgui.Checkbox(u8'№10 ##213', robot9) 
		imgui.SameLine()
		imgui.Checkbox(u8'№11 ##213', robot10) 
		imgui.SameLine()
		imgui.Checkbox(u8'№12 ##213', robot11) 
		imgui.SameLine()
		imgui.Checkbox(u8'№13 ##213', robot12) 
		imgui.SameLine()
		imgui.Checkbox(u8'№14 ##213', robot13) 
		imgui.SameLine()
		imgui.Checkbox(u8'№15 ##213', robot14) 
		imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Отображение карты с метками на экране ##2', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-8, 0)) then win_state['robotwin'].v = not win_state['robotwin'].v end
		if robot.v then robot1.v = false robot2.v = false robot3.v = false robot4.v = false robot5.v = false robot6.v = false robot7.v = false robot8.v = false robot9.v = false robot10.v = false robot11.v = false robot12.v = false robot13.v = false robot14.v = false end
		if robot1.v then robot.v = false robot2.v = false robot3.v = false robot4.v = false robot5.v = false robot6.v = false robot7.v = false robot8.v = false robot9.v = false robot10.v = false robot11.v = false robot12.v = false robot13.v = false robot14.v = false end
		if robot2.v then robot1.v = false robot.v = false robot3.v = false robot4.v = false robot5.v = false robot6.v = false robot7.v = false robot8.v = false robot9.v = false robot10.v = false robot11.v = false robot12.v = false robot13.v = false robot14.v = false end
		if robot3.v then robot1.v = false robot2.v = false robot.v = false robot4.v = false robot5.v = false robot6.v = false robot7.v = false robot8.v = false robot9.v = false robot10.v = false robot11.v = false robot12.v = false robot13.v = false robot14.v = false end
		if robot4.v then robot1.v = false robot2.v = false robot3.v = false robot.v = false robot5.v = false robot6.v = false robot7.v = false robot8.v = false robot9.v = false robot10.v = false robot11.v = false robot12.v = false robot13.v = false robot14.v = false end
		if robot5.v then robot1.v = false robot2.v = false robot3.v = false robot4.v = false robot.v = false robot6.v = false robot7.v = false robot8.v = false robot9.v = false robot10.v = false robot11.v = false robot12.v = false robot13.v = false robot14.v = false end
		if robot6.v then robot1.v = false robot2.v = false robot3.v = false robot4.v = false robot5.v = false robot.v = false robot7.v = false robot8.v = false robot9.v = false robot10.v = false robot11.v = false robot12.v = false robot13.v = false robot14.v = false end
		if robot7.v then robot1.v = false robot2.v = false robot3.v = false robot4.v = false robot5.v = false robot6.v = false robot.v = false robot8.v = false robot9.v = false robot10.v = false robot11.v = false robot12.v = false robot13.v = false robot14.v = false end
		if robot8.v then robot1.v = false robot2.v = false robot3.v = false robot4.v = false robot5.v = false robot6.v = false robot7.v = false robot.v = false robot9.v = false robot10.v = false robot11.v = false robot12.v = false robot13.v = false robot14.v = false end
		if robot9.v then robot1.v = false robot2.v = false robot3.v = false robot4.v = false robot5.v = false robot6.v = false robot7.v = false robot8.v = false robot.v = false robot10.v = false robot11.v = false robot12.v = false robot13.v = false robot14.v = false end
		if robot10.v then robot1.v = false robot2.v = false robot3.v = false robot4.v = false robot5.v = false robot6.v = false robot7.v = false robot8.v = false robot9.v = false robot.v = false robot11.v = false robot12.v = false robot13.v = false robot14.v = false end
		if robot11.v then robot1.v = false robot2.v = false robot3.v = false robot4.v = false robot5.v = false robot6.v = false robot7.v = false robot8.v = false robot9.v = false robot10.v = false robot.v = false robot12.v = false robot13.v = false robot14.v = false end
		if robot12.v then robot1.v = false robot2.v = false robot3.v = false robot4.v = false robot5.v = false robot6.v = false robot7.v = false robot8.v = false robot9.v = false robot10.v = false robot11.v = false robot.v = false robot13.v = false robot14.v = false end
		if robot13.v then robot1.v = false robot2.v = false robot3.v = false robot4.v = false robot5.v = false robot6.v = false robot7.v = false robot8.v = false robot9.v = false robot10.v = false robot11.v = false robot12.v = false robot.v = false robot14.v = false end
		if robot14.v then robot1.v = false robot2.v = false robot3.v = false robot4.v = false robot5.v = false robot6.v = false robot7.v = false robot8.v = false robot9.v = false robot10.v = false robot11.v = false robot12.v = false robot13.v = false robot.v = false end
		imgui.Separator()
		imgui.Text('') imgui.SameLine() imgui.Text(u8'Отобразить на карте метку с местонахождением бомжей:') imgui.SameLine() imgui.TextQuestion(u8"Функция активирует на радаре метку с местонахождением бомжей. Нужно для прохождения квеста.")
		imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'№1 ##214', bomj) 
		imgui.SameLine()
		imgui.Checkbox(u8'№2 ##214', bomj1) 
		imgui.SameLine()
		imgui.Checkbox(u8'№3 ##214', bomj2) 
		imgui.SameLine()
		imgui.Checkbox(u8'№4 ##214', bomj3) 
		imgui.SameLine()
		imgui.Checkbox(u8'№5 ##214', bomj4) 
		imgui.SameLine()
		imgui.Checkbox(u8'№6 ##214', bomj5) 
		imgui.SameLine()
		imgui.Checkbox(u8'№7 ##214', bomj6) 
		imgui.SameLine()
		imgui.Checkbox(u8'№8 ##214', bomj7) 
		imgui.SameLine()
		imgui.Checkbox(u8'№9 ##214', bomj8) 
		imgui.SameLine()
		imgui.Checkbox(u8'№10 ##214', bomj9) 
		imgui.SameLine()
		if imgui.CustomButton(u8'Отображение карты с метками на экране ##3', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-8, 0)) then win_state['bomjwin'].v = not win_state['bomjwin'].v end
		if bomj.v then bomj1.v = false bomj2.v = false bomj3.v = false bomj4.v = false bomj5.v = false bomj6.v = false bomj7.v = false bomj8.v = false bomj9.v = false end
		if bomj1.v then bomj.v = false bomj2.v = false bomj3.v = false bomj4.v = false bomj5.v = false bomj6.v = false bomj7.v = false bomj8.v = false bomj9.v = false end
		if bomj2.v then bomj1.v = false bomj.v = false bomj3.v = false bomj4.v = false bomj5.v = false bomj6.v = false bomj7.v = false bomj8.v = false bomj9.v = false end
		if bomj3.v then bomj1.v = false bomj2.v = false bomj.v = false bomj4.v = false bomj5.v = false bomj6.v = false bomj7.v = false bomj8.v = false bomj9.v = false end
		if bomj4.v then bomj1.v = false bomj2.v = false bomj3.v = false bomj.v = false bomj5.v = false bomj6.v = false bomj7.v = false bomj8.v = false bomj9.v = false end
		if bomj5.v then bomj1.v = false bomj2.v = false bomj3.v = false bomj4.v = false bomj.v = false bomj6.v = false bomj7.v = false bomj8.v = false bomj9.v = false end
		if bomj6.v then bomj1.v = false bomj2.v = false bomj3.v = false bomj4.v = false bomj5.v = false bomj.v = false bomj7.v = false bomj8.v = false bomj9.v = false end
		if bomj7.v then bomj1.v = false bomj2.v = false bomj3.v = false bomj4.v = false bomj5.v = false bomj6.v = false bomj.v = false bomj8.v = false bomj9.v = false end
		if bomj8.v then bomj1.v = false bomj2.v = false bomj3.v = false bomj4.v = false bomj5.v = false bomj6.v = false bomj7.v = false bomj.v = false bomj9.v = false end
		if bomj9.v then bomj1.v = false bomj2.v = false bomj3.v = false bomj4.v = false bomj5.v = false bomj6.v = false bomj7.v = false bomj8.v = false bomj.v = false end
		imgui.Separator()
		imgui.Text('')
		imgui.Text('')
		imgui.Text('')
		imgui.Text('')
		imgui.Text('')
		imgui.Text('')
		imgui.Text('')
		imgui.Text('')
		imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"*Спасибо за информацию группе 'Форумник' и пользователю с БХ под ником Anatoly11323.")
		imgui.End()
	end
	
function messangerwinmenu()
        local sw, sh = getScreenResolution()
        imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(800, 470), imgui.Cond.FirstUseEver)

        imgui.Begin(u8("Чат"), win_state['messanger'], imgui.WindowFlags.NoResize)
            lockPlayerControl(true)
            local drawList = imgui.GetWindowDrawList()
            local draw = imgui.GetCursorScreenPos() 
            
            drawList:AddRectFilled(imgui.ImVec2(draw.x, draw.y), imgui.ImVec2(draw.x+140, draw.y+470), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.18, 0.21, 0.25, 0.25)))
            drawList:AddRectFilled(imgui.ImVec2(draw.x+658, draw.y), imgui.ImVec2(draw.x+800, draw.y+470), imgui.ColorConvertFloat4ToU32(imgui.ImVec4(0.18, 0.21, 0.25, 0.25)))
            
           
            imgui.SetCursorPos(imgui.ImVec2(780, 4))
            imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.65, 0.48, 0.79, 1.00))
            imgui.PopStyleColor()
            imgui.SameLine()
            imgui.SetCursorPos(imgui.ImVec2(780, 4))
            imgui.SetCursorPos(imgui.ImVec2(0, 35))
            imgui.BeginChild('##ChannelsMain', imgui.ImVec2(-0.1, -10), false)
                imgui.BeginChild("##ChannelsList", imgui.ImVec2(140, -0.1), false)
                    imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.65, 0.48, 0.79, 1.00))
                    imgui.CentrText(u8"Чаты:")
                    imgui.PopStyleColor()
                    if #chats ~= 0 and connected then
                        for i = 1, #chats do
                            if chats[i] then
                            imgui.SelectText(u8(chats[i]), i)
                            end
                        end
                    end
                    local wWidth = imgui.GetWindowHeight()
                    imgui.SetCursorPosY(wWidth - (connected and 25 or 25))
					if connected then
						if imgui.CustomButton(u8'Выключить чат', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-0.1, 0)) then
                            serverDisconnect()
                            window_selected = 0
						end
                    end
                imgui.EndChild()
                imgui.SameLine()
                imgui.BeginChild('##ChannelsChat', imgui.ImVec2(505, 0), false)
                    if connected then
                        imgui.BeginChild("##ChannelsMessages", imgui.ImVec2(0, 390), false) 
                            if messages[chats[window_selected]] and #messages[chats[window_selected]] ~= 0 then
                                local clipper = imgui.ImGuiListClipper(#messages[chats[window_selected]])
                                while clipper:Step() do
                                    for i = clipper.DisplayStart + 1, clipper.DisplayEnd do
                                        if messages[chats[window_selected]][i] ~= nil then
                                            imgui.TextColoredRGB(messages[chats[window_selected]][i])
                                        end
                                    end
                                end
							end
                            imgui.SetScrollY(imgui.GetScrollMaxY())
                        imgui.EndChild()
                        imgui.BeginChild('##ChannelsInput', imgui.ImVec2(0, 0), false)
                            local wsize = imgui.GetWindowSize()
                            imgui.SetCursorPosY(wsize.y - 25)
                            imgui.PushItemWidth(wsize.x - 100)
							imgui.PushItemWidth(300)
							if imgui.InputText('##InputMessage', stringField, imgui.InputTextFlags.EnterReturnsTrue) then
								sendMessage()
								stringField.v = ''
                                needFocus = true
							end
							imgui.PopItemWidth()	
                            if connected and window_selected ~= 0 and needFocus then imgui.SetKeyboardFocusHere() needFocus = false end
                            imgui.SameLine(310)
							if imgui.CustomButton(u8'Отправить', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(192, 0)) then
                                sendMessage()
								stringField.v = ''
                            end
                        imgui.EndChild()
                    else
                        local wsize = imgui.GetWindowSize()
                        local tsize = imgui.CalcTextSize(u8"Вы не подключены к чату.")
                        imgui.SetCursorPosX((wsize.x - tsize.x) * 0.5)
                        imgui.SetCursorPosY((wsize.y - tsize.y) * 0.4)
                        imgui.TextDisabled(u8"Вы не подключены к чату.")

                        local tsize = imgui.CalcTextSize(u8"Подключиться")
                        imgui.SetCursorPosX((wsize.x - tsize.x - 10) * 0.5)
                        imgui.SetCursorPosY((wsize.y + tsize.y + 50) * 0.4)
						if imgui.CustomButton(u8'Подключиться', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(100, 0)) then
                            imgui.OpenPopup('##StartConnection')
							window_selected = 1
                        end
                        imgui.SetNextWindowSize(imgui.ImVec2(800, 470), imgui.Cond.Always)
                        if imgui.BeginPopupModal('##StartConnection', _, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
                            local wsize = imgui.GetWindowSize()
                            imgui.SetCursorPosY(wsize.y * 0.4)
                            imgui.CentrText(u8"Подключение...")
                            imgui.CentrText(u8"На время подключения игра может зависнуть.", true)
                            imgui.CentrText(u8"После подключения данное окно пропадет.", true)
							imgui.CentrText(u8"Если скрипт крашнет - перезапустите его и попробуйте снова.", true)
                            if not connecting then startConnect() end
                            imgui.EndPopup() 
                        end
                    end
                imgui.EndChild()
                imgui.SameLine()
                local chatonline = 0
                imgui.BeginChild("##ChannelsUserList", imgui.ImVec2(140, 379), false)
                    imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.65, 0.48, 0.79, 1.00))
                    imgui.CentrText(u8"В сети:")
                    imgui.PopStyleColor()
                    if users[chats[window_selected]] and #users[chats[window_selected]] ~= 0 then
                        local clipper = imgui.ImGuiListClipper(#users[chats[window_selected]])
                        while clipper:Step() do
                            for i = clipper.DisplayStart + 1, clipper.DisplayEnd do
                                if users[chats[window_selected]][i] ~= nil then
                                    imgui.CentrText(u8(users[chats[window_selected]][i]))
                                    chatonline = chatonline + 1
                                end
                            end
                        end
                    end
                imgui.EndChild()
                imgui.SetCursorPos(imgui.ImVec2(659, 379))
                imgui.BeginChild("##SettingButton", imgui.ImVec2(0, 0), false)
                    imgui.Separator()
                    imgui.CentrText(u8(string.format("Всего в сети: %d", chatonline)))
					if imgui.CustomButton(u8'Настройки', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-0.1, 0)) then
                        imgui.OpenPopup('##SettingsList')
                    end
                    imgui.SetNextWindowSize(imgui.ImVec2(800, 470), imgui.Cond.Always)
                    if imgui.BeginPopupModal('##SettingsList', win_state['messanger'], imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
                        local wsize = imgui.GetWindowSize()
                        imgui.SetCursorPosY(wsize.y * 0.4)
                        imgui.SetCursorPosX((wsize.x * 0.5) - 150)
                        imgui.PushItemWidth(300)
                        imgui.NewInputText('##ChangeNick', changeNickField, 300, u8"Введите новый ник (текущий ник: "..cfg1.message.nick..")", 2)
                        imgui.SetCursorPosX((wsize.x * 0.5) - 150)
                        imgui.Text("")
						imgui.SetCursorPosX((wsize.x * 0.5) - 150)
						imgui.Checkbox(u8'Авто-подключение к чату', autochat) imgui.SameLine() imgui.TextQuestion(u8"Если включено, то при запуске скрипта вы будете автоматический подключаться к чату. По умолчанию включено.")
						imgui.SetCursorPosX((wsize.x * 0.5) - 150)
						imgui.Checkbox(u8'Выводить сообщения из чата в игровой чат', chatmessage) imgui.SameLine() imgui.TextQuestion(u8"Если включено, то вы сможете читать сообщения из чата в скрипте в игровом чате и отвечать на них. По умолчанию включено.")
						imgui.SetCursorPosX((wsize.x * 0.5) - 150)
                        imgui.Text("")
						imgui.SetCursorPosX((wsize.x * 0.5) - 150)
						if imgui.CustomButton(u8'Закрыть настройки', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(300, 0)) then
                            local tempField = u8:decode(str(changeNickField.v))
                            local tempField = string.gsub(tempField, " ", "")
                            if #tempField ~= 0 then
                                cfg1.message.nick = tempField
                                if connected then s:send("NICK %s", u8(cfg1.message.nick)) end
								saveSettings(1)
								saveJson(cfg1, jsonDir) 
                            end
                            imgui.Text(changeNickField.v)
                            imgui.CloseCurrentPopup() 
                        end
                        imgui.EndPopup() 
                    end
                imgui.EndChild()
            imgui.EndChild()   
        imgui.End()
    end
	
function prazdnikwinmenu()
	local tLastKeys = {} -- это у нас для клавиш
	local input = sampGetInputInfoPtr()
    local input = getStructElement(input, 0x8, 4)
    local windowPosX = getStructElement(input, 0x8, 4)
    local windowPosY = getStructElement(input, 0xC, 4)
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(950, 520), imgui.Cond.FirstUseEver)
		imgui.Begin(u8('Коорды достопримечательности'), win_state['prazdnikwin'], imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoSavedSettings)
		imgui.Image(winprazdnik, imgui.ImVec2(450, 450), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1))
		imgui.End()
		end
		
function robotwinmenu()
	local tLastKeys = {} -- это у нас для клавиш
	local input = sampGetInputInfoPtr()
    local input = getStructElement(input, 0x8, 4)
    local windowPosX = getStructElement(input, 0x8, 4)
    local windowPosY = getStructElement(input, 0xC, 4)
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(950, 520), imgui.Cond.FirstUseEver)
		imgui.Begin(u8('Коорды с роботами'), win_state['robotwin'], imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoSavedSettings)
		imgui.Image(winrobot, imgui.ImVec2(450, 450), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1))
		imgui.End()
		end
		
function bomjwinmenu()
	local tLastKeys = {} -- это у нас для клавиш
	local input = sampGetInputInfoPtr()
    local input = getStructElement(input, 0x8, 4)
    local windowPosX = getStructElement(input, 0x8, 4)
    local windowPosY = getStructElement(input, 0xC, 4)
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(950, 520), imgui.Cond.FirstUseEver)
		imgui.Begin(u8('Коорды с бомжами'), win_state['bomjwin'], imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoSavedSettings)
		imgui.Image(winbomj, imgui.ImVec2(450, 450), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1))
		imgui.End()
		end
	
function nastroikamenu()
	local tLastKeys = {} -- это у нас для клавиш
	local btn_size = imgui.ImVec2(-0.1, 0) -- а это "шаблоны" размеров кнопок
	local btn_size2 = imgui.ImVec2(160, 0)
	local btn_size3 = imgui.ImVec2(140, 0)
	local btn_size5 = imgui.ImVec2(70, 50)
	local btn_size25 = imgui.ImVec2(394, 23)
	local input = sampGetInputInfoPtr()
    local input = getStructElement(input, 0x8, 4)
    local windowPosX = getStructElement(input, 0x8, 4)
    local windowPosY = getStructElement(input, 0xC, 4)
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(950, 520), imgui.Cond.FirstUseEver)
		imgui.Begin(u8('Параметры'), win_state['nastroikawin'], imgui.WindowFlags.NoResize)
		imgui.Text('')
		imgui.BeginGroup()
		imgui.Text('') imgui.SameLine() imgui.BeginChild('left pane', imgui.ImVec2(180, 460), true)
		imgui.Text('') imgui.SameLine() if imgui.Selectable(u8"Основные настройки") then selected3 = 3 end
		imgui.Separator()
		imgui.Text('') imgui.SameLine() if imgui.Selectable(u8"Биндер") then selected3 = 2 end		
		imgui.Separator()
		imgui.Text('') imgui.SameLine() if imgui.Selectable(u8"Персонализация") then selected3 = 4 end	
		imgui.Separator()
		imgui.Text('') imgui.SameLine() if imgui.Selectable(u8"Для разработчиков") then selected3 = 6 end	
		imgui.Separator()
		imgui.Text('') imgui.SameLine() if imgui.Selectable(u8"Обновления") then selected3 = 5 end				
		imgui.Separator()
		imgui.EndChild()
		imgui.SameLine()
		imgui.BeginChild('##ddddd', imgui.ImVec2(745, 460), true)
		if selected3 == 0 then selected3 = 1
		elseif selected3 == 6 then
			imgui.Columns(2, _, false)
			imgui.Text('') imgui.SameLine() imgui.Text(u8"Для разработчиков")
			imgui.Separator()
			imgui.Text('') imgui.SameLine() imgui.Text(u8'Режим работы Биндера:')
			imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Обычный")); imgui.SameLine(); imgui.ToggleButton(u8' ', bindreshim); imgui.SameLine(); imgui.Text(u8("Продвинутый")) imgui.SameLine() imgui.TextQuestion(u8"Есть 2 режима работы биндера. Режим 'Обычный' - биндер не оставляет написанный текст в чате и не работают скриптовые команды через биндер. Режим 'Продвинутый' - оставляет написанный ранее текст в чате, но зато работают команды скрипта через биндер.")
			imgui.Text('') imgui.SameLine() imgui.Text(u8'Режим работы Дрона:')
			imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Обычный")); imgui.SameLine(); imgui.ToggleButton(u8'  ', droneoption); imgui.SameLine(); imgui.Text(u8("Продвинутый")) imgui.SameLine() imgui.TextQuestion(u8"Есть 2 режима работы дрона. Режим 'Обычный' - убирает ники и прочие надписи на игроках. Режим 'Продвинутый' - не убираются ники и прочие надписи на игроках и встроен ВХ, который показывает не все ники в радиусе, а показывает ник игрока только в том случае, если вы дроном подлетели к нему.")
			if droneoption.v then developMode = 1 end
			imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Включить отображение ID Текстдравов', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(250, 0)) then toggle = true end 
			imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Выключить отображение ID Текстдравов', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(250, 0)) then toggle = false end
			imgui.PushItemWidth(250)
			imgui.Text('') imgui.SameLine() imgui.InputText(u8'water', watertext) imgui.SameLine(); imgui.TextQuestion(u8"В данное поле нужно ввести ID текстдрава в котором находится дистилированная вода. Узнать ID вы сможете зайдя в меню магазина и нажав на кнопку 'Включить отображение ID Текстдравов'.")
		elseif selected3 == 5 then
			imgui.Text('') imgui.SameLine() imgui.Text(u8"Обновления")
			imgui.Separator()
			if imgui.CollapsingHeader(u8' 23.04.2021') then
				imgui.BeginChild('##as2dasasdf354', imgui.ImVec2(750, 135), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. Добавлено автообноление.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. В случае, если у вас не хватает библиотек - скрипт напишет в moonloader.log каких библиотек не хватает")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"и укажет ссылку, где можно их скачать.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3. Убрана авто-оплата налогов т.к с новым семейным улучшением она не нужна.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"4. Теперь можно изменить цвет меню.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"5. Когда вы нажимаете на 'Биндер и настройки' сразу открывается меню с настройками.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 24.04.2021') then
				imgui.BeginChild('##as2dasasdf876', imgui.ImVec2(750, 140), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. Добавлен автобайк и автомото. Если на вашем сервере он запрещен, то используйте на свой страх и риск.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. Добавлены точки в числах.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3. Добавлено запоминание диалогов(полезно тем, кто играет со сборки).")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"4. Вроде бы сделал фикс, что скрипт запускался не с первого раза.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"Но если эта проблема осталась или нашли другую, то пишите в тему на БХ.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"5. Добавлен калькулятор. Меню скрипта - калькулятор.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 25.04.2021') then
				imgui.BeginChild('##as2dasasdf753', imgui.ImVec2(750, 190), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. После обновления скрипт будет писать, что ознакомиться с обновлением вы сможете")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"в Меню скрипта - помощь - обновления. ")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. Добавлено закрытие меню скрипта на ESC.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3. Исправлен баг когда при использовании точек в числах не работали текстдравы.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"4. Добавлена возможность включить открывание ящиков навсегда.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"5. Также меню с рулетками и ящиками перенесено на главное меню в /"..activator.v..".")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"6. В информер добавлен счетчик FPS, но он требует доработки.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"7. Также обнаружен баг, когда окно информера пропадает при использований функции")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"открытия ящиков. Будет исправлено позже.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 26.04.2021') then
				imgui.BeginChild('##as2dasasdf8767', imgui.ImVec2(750, 190), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. В новую функцию открытия сундуков добавлен ползунок с задержкой")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"(по умолчанию 3 минуты)")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. В Roolette Tools добавлена инструкция по использованию.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3. Исправлена невозможность сменить стиль если открываются сундуки.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"4. Фикс закрытия меню на esc(не закрывалось, если открыт информер).")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"5. Исправлены баги связанные с информером.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"6. После спавна на экране появлялась мышка - исправлено. ")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"7. После спавна, если выбран пункт 'всегда открывать сундуки',")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"через 10 секунд открывается инвентарь, чтобы открытие сундуков сработало.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 28.04.2021') then
				imgui.BeginChild('##as2dasasdf645', imgui.ImVec2(750, 70), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. Добавлен в модификации Фикс для тех, кто использует МВД Хелпер(МВД блочит инвентарь при спавне).")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. В информер добавлено ХП транспорта.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3. После смерти, если включено 'всегда открывать сундуки' у вас не открывается инвентарь.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 03.05.2021') then
				imgui.BeginChild('##as2dasasdf213', imgui.ImVec2(750, 160), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. Добавлено сохранение задержки для сундуков.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. Добавлена автоеда дома с кд в 3 часа на всякий случай.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3. 'Bank Menu' перенесен в главное меню.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"4. Полностью переписана система пополнения депозита.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"5. Вернул улучшенную версию авто оплаты налогов.(находится в 'Bank Menu')")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"6. Теперь в 'Модификации' можно настроить кнопку на открытие/закрытие скрипта.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"7. В помощь добавлен пункт 'Коды клавиш'.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 07.05.2021') then
				imgui.BeginChild('##as2dasasdf124', imgui.ImVec2(750, 40), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. Добавлен в 'Биндер и Настройки' пункт 'Майнинг'. Там вы сможете улучшать свои видеокарты.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. В 'Roulette Tools' добавлено золотое яйцо.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 08.05.2021') then
				imgui.BeginChild('##as2dasasdf687', imgui.ImVec2(750, 45), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. Фикс улучшения видеокарт. Также скрипт работает только на Юме и Прескотте. Если нужно добавить другие")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"сервера или обнаружили баги - пишите в теме на БХ.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 22.05.2021') then
				imgui.BeginChild('##as2dasasdf358', imgui.ImVec2(750, 120), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. Добавлена возможность перезагрузки скрипта на кнопку.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. Фикс когда меню не открывалось при открытий сундуков.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3. Переписан эмулятор лаунчера. Теперь можно активировать ПК версию или мобаил версию.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"Преимущества мобаил - виден luxe транспорт.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"4. Добавлена возможность изменить команду открытия скрипта.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 23.05.2021') then
				imgui.BeginChild('##as2dasasdf146', imgui.ImVec2(750, 70), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. Добавлен autofind. /afind - начать поиск игрока. /sfind - закончить поиск. ")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. Убрано золотое яйцо т.к уже неактуально")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3. Добавлена авто-отыгровка некоторого оружия.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 28.05.2021') then
				imgui.BeginChild('##as2dasasdf34', imgui.ImVec2(750, 70), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. Фикс того, что если убирали код клавиши в активаций скрипта - было невозможно писать в других полях.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. Добавлен Input Chat. Теперь даже на русской раскладке можно будет писать команды на английском языке.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3. Фикс когда открытие сундуков останавливало работу некоторых функций скрипта.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 29.05.2021') then
				imgui.BeginChild('##as2dasasdf6453', imgui.ImVec2(750, 140), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. Фикс того, что если не выбрано в RP gun оружие, то если вы убрали оружие с рук не будет рп отыгровки")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"/me убрал оружие.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. Убран флуд в чат при заточке аксессуаров/скинов и все уведомления идут в imgui уведомления.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3. Добавлен пинг в информер.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"4. Фикс ФПС в информере.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"5. Добавлен онлайн за сессию в информер.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 31.05.2021') then
				imgui.BeginChild('##as2dasasdf546', imgui.ImVec2(750, 215), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. Добавлена возможность каждые 30 минут есть из мешка с мясом в 'автоеда'.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. В 'RP Gun' добавлен тайзер.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3. Добавлена возможность изменить отыгровку на '/me убрал оружие', но работает в общем случае для всего оружия.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"4. Добавлен реконнект после рестарта через 10 минут. Также по команде /recon можно перезайти на сервер")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"через 30 секунд.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"5. Добавлено 'редактирование диалога /cars'. Можно использовать, например, чтобы подписать местоположение")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"машин, изменить цвет строк в диалоге и тому подобное.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"6. Переходя в 'помощь', теперь вместо списка обновлений, открываются команды скрипта.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"7. В помощь добавлен пункт 'О скрипте', где перечислены автор и люди, которые помогают.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"А также кнопка, по нажатию на которую, вы перейдете в тему на БХ.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 3.06.2021') then
				imgui.BeginChild('##as2dasasdf457', imgui.ImVec2(750, 180), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. Добавлено автооткрытие подарков в меню 'Roulette Tools'. Теперь вам нужно всего лишь подойти к Эдварду,")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"поставить галочку и вы в автоматическом режиме обменяете все свои подарки на призы. Функция выключится")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"автоматический, если у вас закончатся подарки.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. Добавлено то, что если слот в бронзовой рулетке обновляется, то прокрутка рулетки останавливается.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"Сделано для того, чтобы после смены слота ваши рулетки не крутились впустую.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3. Добавлен Chat Сalculator от 'Adrian G'. Если функция включена, то пишите пример в чат и получаете")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"под чатом ответ.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 10.06.2021') then
				imgui.BeginChild('##as2dasasdf4576', imgui.ImVec2(750, 215), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. Теперь можно перезайти в игру через нужное вам время - /recon (время в сек). Если написать просто /recon -")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"то вы перезайдете на сервер через 30 секунд.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. Убран калькулятор на imgui т.к есть калькулятор в чат и он удобнее.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3. Добавлены мини игры '2048' от CaJlaT, 'Пинг Понг' и 'Змейка' от arsuhinars.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"4. Переписана система RP Guns.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"5. Фиксы, которые относятся к меню скрипта.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"6. Фикс, когда закрывался скрипт, если закрыть чат на ESC.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"7. Фикс, когда автобайк срабатывал при открытом чате.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"8. В 'Roulette Tools' добавлена возможность обменять гражданские талоны на платиновые рулетки.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 26.06.2021') then
				imgui.BeginChild('##as2dasasdf457546', imgui.ImVec2(750, 110), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. Фикс сундуков, рулеток и автоточилок.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. Теперь при заточке аксессуаров или скинов, камни и амулеты могут быть на любой странице.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3. Обновлен 'Умный реконнект'. Теперь вы автоматический перезайдете на сервер после рестарта, при кике")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"античитом и при срабатываний защиты от реконнекта.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"4. Переписан 'Майнинг'. Теперь вы сможете улучшать ваши видеокарты на любом сервере Аризоны.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 30.06.2021') then
				imgui.BeginChild('##as2dasasdf4572146', imgui.ImVec2(700, 215), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. Фикс 'Умного реконнекта', когда из-за данной функций вас рестартило с сервера.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. Фикс закрытия меню на клавишу, когда открыты более 3-х imgui окна.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3. Фикс 'Открытия меню на клавишу' и 'Перезагрузка скрипта на клавишу'.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"4. Добавлена задержка на перезаход после кика в 15 секунд.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"5. В 'Умный реконнект' добавлен перезаход, если сервер запоролен.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"6. Добавлена возможность смотреть тестовые обновления '/tu'. Тестовые обновления содержат в себе фиксы и")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"исправления.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"7. В 'Майнинг' добавлен пункт 'Прочие функции'. В пункте есть 'Авто-покупка Дистилированной воды',")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"'Забрать прибыль (BTC)', 'Запустить/Остановить видеокарты' и 'Залить охлаждающую жидкость'.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"8. Добавлено то, что если у вас кончается смазка для улучшения видеокарт, то функция отключается")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"автоматический.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"9. Добавлена команда /strobes для включения и отключения стробоскопов у стандартных машин.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"10. Добавлен 'Фикс adCounter'. Данный фикс предназначен для скрипта 'adCounter' и добавлен по просьбе")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"пиарщиков.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"11. Пароль от аккаунта и Пин-Код от карты теперь скрыты.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"12. Теперь авто-оплата налогов после завершения функции не перезагружает скрипт, а просто")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"останавливает работу функций.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 11.07.2021') then
				imgui.BeginChild('##as2dasasdf45722146', imgui.ImVec2(700, 215), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. фикс функции 'Улучшение видеокарт'. Больше при улучшений видеокарт не закрывается инвентарь.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. Фикс функционала в 'Прочие Функции' в Майнинге.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3. Фикс 'Пополнение депозита', когда с открытым инвентарем не работало пополнение.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"4. Фикс Текстовых окон в меню.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"5. Фикс, когда при включенном автолоке, если вы садились в чужой автомобиль, то удалялась строчка из чата,")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"кому принадлежит данный автомобиль.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"6. Фикс, когда срабатывала команда /lock в чужом транспорте.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"7. Фикс функции 'Пополнение Депозита', когда пополнение не работало в свернутом режиме.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"8. Добавлена кнопка 'Завершить улучшение видеокарт'. Нужна для того, чтобы быстро снять все галочки и")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"завершить улучшение видеокарт.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"9. В 'Прочие функции' добавлена возможность менять задержку для включения видеокарт, заливки жидкости и")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"так далее.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"10. В 'Биндер и Настройки' добавлен пункт 'Шахтёр'. В данном пункте можно включить счетчик руд и автоальт.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"Автоальт срабатывает только на шахте у руды.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"11. В 'Биндер и Настройки' - 'Модификации' добавлена функция 'Заметки'. С данной функцией вы сможете")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"разместить окно с заметкой у себя на экране с нужным вам текстом и перемещать его в любое место на экране.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"12. В 'Биндер и Настройки' - 'Модификации' добавлена возможность настроить клавиши на включение")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"и отключение дрона.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"13. Добавлен пукнт 'Piar Menu'. С помощью данного функционала вы сможете подавать объявление в /ad")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"в автоматическом режиме с нужной вам задержкой. Также тут имеется счетчик поданных объявлений,")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"который каждый день обнуляется.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"14. В 'Roulette Tools' добавлена возможность обменять зловещие монеты на улучшение для автомобиля.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"15. Окно 'О скрипте' перенесено из 'Помощь' в меню скрипта.")
		imgui.EndChild()
		end
		if imgui.CollapsingHeader(u8' 30.07.2021') then
				imgui.BeginChild('##as2dasasdf457434', imgui.ImVec2(700, 215), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. Фикс сундуков (кикало за флуд функциями)")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. Фикс улучшения видеокарт (кикало за флуд функциями)")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3. Фикс ложного срабатывания 'Пополнение депозита' (кикало за флуд функциями)")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"4. Фикс imgui окон (некоторые окна не сворачивались)")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"5. Фикс 'Умного реконнекта' (иногда крашило игру и реагировал на сообщения от игроков)")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"6. Фикс открытия рулеток (не работало, если включено открытие сундуков)")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"7. Добавлено 'Skup Menu'. Теперь вы сможете быстро выставлять нужные товары на скупку.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"8. В 'Roulette Tools' добавлен пункт 'Обмен зловещих монет на точильные камни'.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"9. В 'Roulette Tools' добавлено 2 способа открытия сундуков. Тестируйте сами, какой из способов у вас работает")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"стабильнее.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"10. В 'Piar Menu' добавлена возможность отправлять ваш текст в /vr и /fam.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"11. В 'Умный реконнект' добавлен перезаход после 'You are banned from this server'.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"12. В 'Авторизация' добавлено то, что если в настройках указан неверный пароль, то скрипт больше не пробует")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"зайти, используя сразу 3 попытки, а пишет в чате, что введенен неверный пароль и даёт возможность ввести его")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"вручную.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"13. В 'Майнинг' - 'Прочие функции' добавлена функция 'Напоминание'. Если функция включена, то в указанный")
				imgui.Text('') imgui.SameLine() imgui.Text(u8" день скрипт уведомит вас о том, что нужно забрать биткоины и обслужить видеокарты.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"14. Теперь задержка в 'Майнинг' - 'Прочие функции' влияет на улучшение видеокарт.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"15. Теперь после авто-обмена подарков пишется, чего и сколько вы получили с обмена и сколько подарков на")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"это потратили.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"16. После авто-сбора биткоинов пишется, сколько биткоинов вы собрали.")
		imgui.EndChild()
		end	
		if imgui.CollapsingHeader(u8' 25.08.2021') then
				imgui.BeginChild('##as2dasasdf54545', imgui.ImVec2(720, 215), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text('') imgui.SameLine() imgui.Text(u8"1. Фикс 'Измененный cars' (не работала функция и крашил скрипт)")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"2. Фикс 'Улучшение видеокарт' (не выключалась функция, когда заканчивались смазки)")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"3. Фикс 'Обмен зловещих монет на точилки' (не работала функция)")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"4. Фикс 'Skup Menu' (больше не крашит скрипт, если убрать данные с полей ввода)")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"5. Фикс открытия сундуков (не открывались при открытом диалоге)")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"6. Фикс биндера (не работали команды скрипта, если их забиндить в биндер)")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"7. Фикс команды /afind (при активаций команды не работал некоторый функционал скрипта, не отправлялись")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"сообщения в чате и не работал автобайк)")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"8. Добавлен новой интерфейс скрипта в Бета режиме. Он еще не полностью доделан так, как хотелось мне,")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"но основа уже есть и будет доделываться постепенно с последующими обновлениями.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"9. В 'Piar Menu' добавлен чат /s.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"10. В 'Piar Menu' добавлена возможность отправлять ваш текст в /vr и /fam.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"11. Добавлена возможность изменить дату напоминания в майнинге прямо в окне с уведомлением.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"12. Теперь на клавишу ESC закрываются все окна скрипта, кроме основого, а на F3 или другую установленную")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"клавишу закрываются все, включая и основное окно.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"13. Добавлен 'Arizona Update'. В честь дня рождения Аризоны, Аризона выпустила новое обновление и квесты.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"Именно поэтому и был создан функционал, который поможет вам пройти квесты.")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"В 'Arizona Update' имеется:")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"текст обновления; ответы на вопросы от квестовых персонажей; возможность убрать диалог с поздравлением от")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"Аризоны при спавне персонажа; маркеры(чекпоинты) для прохождения лабиринта; возможность ставить метки на")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"карте с местоположением достопримечательностей, роботов и бомжей; карта с метками местоположения")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"достопримечательностей, роботов и бомжей; ВХ на пропавший предмет, железные обломки, ржавые детали и")
				imgui.Text('') imgui.SameLine() imgui.Text(u8"покорёженый металл(предметы с острова); автопрокрутка рулетки из нового сундука.")
		imgui.EndChild()
		end	
		elseif selected3 == 4 then
			imgui.Text('') imgui.SameLine() imgui.Text(u8"Персонализация")
			imgui.Separator()
			imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8'Данный пункт находится в разработке, но вы можете выбрать 2 доступных стиля. Белый или тёмный.')
			imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Белый")); imgui.SameLine(); imgui.ToggleButton(u8'Белый', styletest)
			imgui.SameLine(300)
			imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Тёмный")); imgui.SameLine(); imgui.ToggleButton(u8'Тёмный', styletest1)
			if styletest.v then -- стили
			apply_custom_style()
			end
			if styletest1.v then -- стили
			apply_custom_style1()
			end
			if styletest.v then styletest1.v = false end
			if styletest1.v then styletest.v = false end
		elseif selected3 == 3 then
			imgui.Text('') imgui.SameLine() imgui.Text(u8"Основные настройки")
			imgui.Separator()
			if imgui.CollapsingHeader(u8'Модификации') then
				imgui.BeginChild('##as2dasasdf468', imgui.ImVec2(745, 370), false)
				imgui.Columns(2, _, false)
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("ChatInfo")); imgui.SameLine(); imgui.ToggleButton(u8'ChatInfo', chatInfo)
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Чат на клавишу Т")); imgui.SameLine(); imgui.ToggleButton(u8'Чат на клавишу T', keyT)
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Эмулятор лаунчера")); imgui.SameLine(); imgui.ToggleButton(u8'Эмулятор лаунчера', launcher); imgui.SameLine(); imgui.TextQuestion(u8"Если включено, то вы сможете открывать сундуки с рулетками, получать увеличенный депозит и 10.000$ в час. После включения данной функций нужно перезайти в игру. PC - не отображает luxe машины. Mobile - отображает luxe машины.")
				if launcher.v then
				if launcherpc.v then launcherm.v = false end
				if launcherm.v then launcherpc.v = false end
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("PC")); imgui.SameLine(); imgui.ToggleButton(u8'PC', launcherpc); imgui.SameLine(); 
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Mobile")); imgui.SameLine(); imgui.ToggleButton(u8'Mobile', launcherm)
				end
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Авто Байк и Мото")); imgui.SameLine(); imgui.ToggleButton(u8'Авто Байк и Мото', autobike); imgui.SameLine(); imgui.TextQuestion(u8"Если включено, то вам больше не надо будет нажимать W на велосипеде и не нужно будет нажимать стрелочку на мотоцикле. Просто зажимаете Левый Shift и едите.")
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Запоминание диалогов")); imgui.SameLine(); imgui.ToggleButton(u8'Запоминание диалогов', ndr)
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Автоеда")); imgui.SameLine(); imgui.ToggleButton(u8'Автоеда', eat) 
				if eat.v then
				if eathouse.v then eatmyso.v = false end
				if eatmyso.v then eathouse.v = false end
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Дом")); imgui.SameLine(); imgui.ToggleButton(u8'Дом', eathouse); ; imgui.SameLine(); imgui.TextQuestion(u8"Персонаж будет раз в 3 часа есть еду с холодильника, стоимостью 300 продуктов. Полезно тем, у кого нет аксессуара на хилл или слетел инвентарь и вы ждете отката."); imgui.SameLine();
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Мешок с мясом")); imgui.SameLine(); imgui.ToggleButton(u8'Мешок с мясом', eatmyso); ; imgui.SameLine(); imgui.TextQuestion(u8"Персонаж будет раз в 30 минут есть еду из мешка с мясом.")
				end
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Input Chat")); imgui.SameLine(); imgui.ToggleButton(u8'Input Chat', raskladka); imgui.SameLine(); imgui.TextQuestion(u8"Скрипт вводит команды на английском языке на русской раскладке. После включения или отключения данной функций необходимо перезапустить скрипт.")
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Умный реконнект")); imgui.SameLine(); imgui.ToggleButton(u8'Умный реконнект', recongen); imgui.SameLine(); imgui.TextQuestion(u8"Если включено, то скрипт будет перезаходить в игру, если вас кикнул античит, сработала защита от реконнекта, сервер запоролен, пишет 'You are banned from this server' и после рестарта.")
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Фикс adCounter")); imgui.SameLine(); imgui.ToggleButton(u8'Фикс adCounter', adcounter); imgui.SameLine(); imgui.TextQuestion(u8"Фикс для скрипта adCounter, т.к тот скрипт не отправляет объявления из-за новой системы /ad.");
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Фикс MVD Helper")); imgui.SameLine(); imgui.ToggleButton(u8'Фикс MVD Helper', mvdhelp); imgui.SameLine(); imgui.TextQuestion(u8"Если включено, то после спавна пропишется /mm и закроется. Нужно для того, чтобы разбагать инвентарь(MVD Helper его как то багает)")
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Анти-ломка")); imgui.SameLine(); imgui.ToggleButton(u8'Анти-ломка', antilomka); imgui.SameLine(); imgui.TextQuestion(u8"Если включено, то при ломке у вас больше не будет тряски камеры.")
				
				imgui.NextColumn()
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Авто закрытие дверей(/lock)")); imgui.SameLine(); imgui.ToggleButton(u8'Авто закрытие дверей(/lock)', lock)
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Точки в числах")); imgui.SameLine(); imgui.ToggleButton(u8'Точки в числах', toch)
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Chat Calculator")); imgui.SameLine(); imgui.ToggleButton(u8'Chat Calculator', chatcalc); imgui.SameLine(); imgui.TextQuestion(u8"Если включено, то вы сможете использовать калькулятор в чате. Например: пишите в чате 2+2 и под чатом вам напишется ответ. Можно высчитывать и примеры по типу: (3*3)*(2+2) и тому подобное. Также если напишите в чате 'calchelp', то вам покажет как высчитывать проценты.")
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Измененный cars")); imgui.SameLine(); imgui.ToggleButton(u8'Измененный cars', carsis); imgui.SameLine(); imgui.TextQuestion(u8"Редактирование диалога /cars. Можно использовать, например, чтобы подписать местоположение машин, изменить цвет строк в диалоге и тому подобное.");
				if carsis.v and imgui.CustomButton(u8'Редактировать cars', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-124, 0)) then carsys() end
				imgui.Text(u8("Открытие меню на клавишу")); imgui.SameLine(); imgui.TextQuestion(u8"В поле нужно ввести код клавиши для открытия или закрытия скрипта. По умолчанию поставлено на F3. Коды клавиш вы можете посмотреть в помощь - коды клавиш.") 
					imgui.InputText(u8'##1', autoklava)
				imgui.Text(u8("Перезагрузка скрипта на клавишу")); imgui.SameLine(); imgui.TextQuestion(u8"В поле нужно ввести код клавиши для перезагрузки скрипта. По умолчанию поставлено на F4. Коды клавиш вы можете посмотреть в помощь - коды клавиш.")
					imgui.InputText(u8'##2', autoklavareload)
				imgui.Text(u8("Запуск дрона на клавиши")); imgui.SameLine(); imgui.TextQuestion(u8"В полях нужно ввести коды клавиш для запуска дрона. По умолчанию поставлено на С + 1. Коды клавиш вы можете посмотреть в помощь - коды клавиш.") 
					imgui.PushItemWidth(111)
					imgui.InputText(u8'##3', autodrone) imgui.SameLine() imgui.Text(u8("+")) imgui.SameLine() imgui.InputText(u8'##4', autodronev2)
					imgui.PopItemWidth()
				imgui.Text(u8("Закрытие дрона на клавиши")); imgui.SameLine(); imgui.TextQuestion(u8"В полях нужно ввести коды клавиш для запуска дрона. По умолчанию поставлено на С + 2. Коды клавиш вы можете посмотреть в помощь - коды клавиш.") 
					imgui.PushItemWidth(111)
					imgui.InputText(u8'##5', autodronev3) imgui.SameLine() imgui.Text(u8("+")) imgui.SameLine() imgui.InputText(u8'##6', autodronev4)
					imgui.PopItemWidth()
				imgui.Text(u8("Команда для открытия меню скрипта")); imgui.SameLine(); imgui.TextQuestion(u8"В поле нужно ввести команду (без /) открытия меню(вводить команду на английском). По умолчанию - /mono. После того, как вписали команду, необходимо перезапустить скрипт!")
					imgui.InputText(u8'##7', activator)
				imgui.EndChild()
			end
			if imgui.CollapsingHeader(u8'Информер') then
				imgui.BeginChild('##25252', imgui.ImVec2(745, 170), false)
				imgui.Columns(2, _, false)
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Включить информер")); imgui.SameLine(); imgui.ToggleButton(u8'Включить информер', zones)
				if zones.v then
					imgui.SameLine()
					if imgui.CustomButton(u8'Переместить', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(0, 0)) then 
						sampAddChatMessage("[Mono Tools]{FFFFFF} Выберите позицию и нажмите {00C2BB}Enter{FFFFFF} чтобы сохранить ее.", 0x046D63)
						win_state['nastroikawin'].v = false
						win_state['main'].v = false
						win_state['shahtainformer'].v = false
						win_state['pismoinformer'].v = false
						mouseCoord = true 
					end
				end
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Отображение здоровья")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение здоровья', infHP)
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Отображение брони")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение брони', infArmour)
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Отображение квадрата")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение квадрата', infKv)
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Отображение пинга")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение пинга', infping)
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Отображение онлайна за сессию")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение онлайна за сессию', infonline); imgui.SameLine(); imgui.TextQuestion(u8"Сбрасывается при перезагрузке скрипта или после перезахода в игру.") 
				imgui.NextColumn()
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Отображение города")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение города', infCity)
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Отображение района")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение района', infRajon)
				imgui.SameLine()
				imgui.TextQuestion(u8"Если отображаются иероглифы - сделайте игру на английский язык в настройках.")
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Отображение ХП т/с")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение ХП т/с', infhpcar)
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Отображение ФПС")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение ФПС', inffps)
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Отображение времени")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение времени', infTime)
				imgui.EndChild()
			end
			if imgui.CollapsingHeader(u8'RP Guns') then
				rpguns()
			end
			if imgui.CollapsingHeader(u8'Авторизация') then
				imgui.BeginChild('##asdasasddf764', imgui.ImVec2(750, 60), false)
				imgui.Columns(2, _, false)
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Автологин")); imgui.SameLine(); imgui.ToggleButton(u8("Автологин"), autologin)
				if autologin.v then
					imgui.Text('') imgui.SameLine() imgui.InputText(u8'Пароль', autopass, imgui.InputTextFlags.Password)
				end
				imgui.NextColumn()
				imgui.AlignTextToFramePadding(); imgui.Text(u8("Автопин")); imgui.SameLine(); imgui.ToggleButton(u8("Автопин"), autopin)
				if autopin.v then
					imgui.InputText(u8'Pin-код', autopasspin, imgui.InputTextFlags.Password)
				end
				imgui.EndChild()
			end
			if imgui.CollapsingHeader(u8'Таймцикл') then
				if weather.v == -1 then weather.v = readMemory(0xC81320, 1, true) end
				if gametime.v == -1 then gametime.v = readMemory(0xB70153, 1, true) end
				imgui.Text('') imgui.SameLine() imgui.SliderInt(u8"ID погоды", weather, 0, 50)
				imgui.Text('') imgui.SameLine() imgui.SliderInt(u8"Игровой час", gametime, 0, 23)
			end
			if imgui.CollapsingHeader(u8'Прочие настройки') then
				imgui.Text('') imgui.SameLine() imgui.AlignTextToFramePadding(); imgui.Text(u8("Визуальный скин")); imgui.SameLine(); imgui.ToggleButton(u8("Визуальный скин"), enableskin)
				if enableskin.v then
					imgui.Text('') imgui.SameLine() imgui.InputInt("##229", localskin, 0, 0)
					imgui.SameLine()
					if imgui.CustomButton(u8'Применить', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(0, 0)) then
						if localskin.v <= 0 or localskin.v == 74 or localskin.v == 53 then
							localskin.v = 1
						end
						changeSkin(-1, localskin.v)
					end
				end
				imgui.Text('') imgui.SameLine() imgui.SliderInt(u8" Коррекция времени", timefix, 0, 5)
			end
		elseif selected3 == 2 then
		imgui.Text('') imgui.SameLine() imgui.Text(u8"Биндер")
		imgui.Separator()
		imgui.Columns(4, _, false)
			imgui.NextColumn()
			imgui.NextColumn()
			imgui.NextColumn()
			for k, v in ipairs(mass_bind) do -- выводим все бинды
				imgui.NextColumn()
				imgui.Text('') imgui.SameLine() if hk.HotKey("##ID" .. k, v, tLastKeys, 100) then -- выводим окошко, куда будем тыкать, чтобы назначить клавишу
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
				if imgui.CustomButton(u8("Редактировать бинд ##"..k), imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(0, 0)) then imgui.OpenPopup(u8"Установка клавиши ##modal"..k) end
				if k ~= 0 then
					imgui.NextColumn()
					if imgui.CustomButton(u8("Удалить бинд ##"..k), imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(0, 0)) then
						if v.cmd ~= "-" then sampUnregisterChatCommand(v.cmd) end
						if rkeys.isHotKeyDefined(tLastKeys.v) then rkeys.unRegisterHotKey(tLastKeys.v) end
						table.remove(mass_bind, k)
						saveSettings(3, "DROP BIND")
					end
				end
				if imgui.BeginPopupModal(u8"Установка клавиши ##modal"..k, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
					if imgui.CustomButton(u8('Сменить/Назначить команду'), imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(200, 0)) then
						imgui.OpenPopup(u8"Команда - /"..v.cmd)
					end		
					if imgui.CustomButton(u8('Редактировать содержимое'), imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(200, 0)) then
						cmd_text.v = u8(v.text):gsub("~", "\n")
						binddelay.v = v.delay
						imgui.OpenPopup(u8'Редактор текста ##second'..k)
					end

					if imgui.BeginPopupModal(u8"Команда - /"..v.cmd, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize) then
						imgui.Text('') imgui.SameLine() imgui.Text(u8"Введите название команды, которую хотите применить к бинду, указывайте без '/':  ")						
						imgui.Text('') imgui.SameLine() imgui.Text(u8"Чтобы удалить комманду, введите прочерк и сохраните.")
						imgui.PushItemWidth(495)
						imgui.Text('') imgui.SameLine() imgui.InputText("##FUCKITTIKCUF_1", cmd_name)
						imgui.PopItemWidth()
						
						imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8('Сохранить'), imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(244, 0)) then
							v.cmd = u8:decode(cmd_name.v)

							if u8:decode(cmd_name.v) ~= "-" then
								rcmd(v.cmd, v.text, v.delay)
								cmd_name.v = ""
							end
							saveSettings(3, "CMD "..v.cmd)
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.CustomButton(u8('Закрыть'), imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(243, 0)) then
							cmd_name.v = ""
							imgui.CloseCurrentPopup()
						end
						imgui.EndPopup()
					end
					if imgui.BeginPopupModal(u8'Редактор текста ##second'..k, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize) then
						imgui.BeginChild('##sdaadasdd', imgui.ImVec2(1074, 590), true)
						imgui.Columns(2, _, false)
						imgui.Text('')
						imgui.Text('') imgui.SameLine() imgui.TextWrapped(u8("Параметр {bwait:time} обязателен после каждой строки. Задержка автоматически не выставляется."))
						imgui.Text('') imgui.SameLine() imgui.TextWrapped(u8"Редактор текста биндера:")
						imgui.Text('') imgui.SameLine() imgui.InputTextMultiline('##FUCKITTIKCUF_2', cmd_text, imgui.ImVec2(550, 300))
						
						imgui.Text('') imgui.SameLine() imgui.Text(u8("Результат:"))
						local example = tags(u8:decode(cmd_text.v))
						imgui.Text('') imgui.SameLine() imgui.Text(u8(example))
						imgui.NextColumn()
						imgui.Text('')
						imgui.BeginChild('##sdaadddasdd', imgui.ImVec2(525, 480), true)
						imgui.TextColoredRGB(' • {bwait:1500} {21BDBF}- задержка между строк - {FF8000}ОБЯЗАТЕЛЬНЫЙ ПАРАМЕТР')
						imgui.Separator()
						
						imgui.TextColoredRGB(' • {params} {21BDBF}- параметр команды - {FF8000}/'..v.cmd..' [параметр]')
						imgui.TextColoredRGB(' • {paramNickByID} {21BDBF}- цифровой параметр, получаем ник по ID.')
						imgui.TextColoredRGB(' • {paramFullNameByID} {21BDBF}- цифровой параметр, получаем РП ник по ID.')
						imgui.TextColoredRGB(' • {paramNameByID} {21BDBF}- цифровой параметр, получаем имя по ID.')
						imgui.TextColoredRGB(' • {paramSurnameByID} {21BDBF}- цифровой параметр, получаем фамилию по ID.')

						imgui.Separator()
						imgui.TextColoredRGB(' • {mynick} {21BDBF}- ваш полный ник - {FF8000}'..tostring(userNick))
						imgui.TextColoredRGB(' • {myfname} {21BDBF}- ваш РП ник - {FF8000}'..tostring(nickName))
						imgui.TextColoredRGB(' • {myname} {21BDBF}- ваше имя - {FF8000}'..tostring(userNick:gsub("_.*", "")))
						imgui.TextColoredRGB(' • {mysurname} {21BDBF}- ваша фамилия - {FF8000}'..tostring(userNick:gsub(".*_", "")))
						imgui.TextColoredRGB(' • {myid} {21BDBF}- ваш ID - {FF8000}'..tostring(myID))
						imgui.TextColoredRGB(' • {myhp} {21BDBF}- ваш уровень HP - {FF8000}'..tostring(healNew))
						imgui.TextColoredRGB(' • {myarm} {21BDBF}- ваш уровень брони - {FF8000}'..tostring(armourNew))
						imgui.Separator()
						imgui.TextColoredRGB(' • {city} {21BDBF}- город, в котором находитесь - {FF8000}'..tostring(playerCity))
						imgui.TextColoredRGB(' • {kvadrat} {21BDBF}- определение квадрата - {FF8000}'..tostring(locationPos()))
						imgui.TextColoredRGB(' • {zone} {21BDBF}- определение района - {FF8000}'..tostring(ZoneInGame))
						imgui.TextColoredRGB(' • {time} {21BDBF}- МСК время - {FF8000}'..string.format(os.date('%H:%M:%S', moscow_time)))		
						imgui.EndChild()
						imgui.NewLine()
						
						if imgui.CustomButton(u8('Сохранить'), imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-8, 0)) then

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
					
						if imgui.CustomButton(u8('Закрыть не сохраняя'), imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-8, 0)) then
							imgui.CloseCurrentPopup()
						end
						imgui.EndChild()
						imgui.EndPopup()
					end

					if imgui.CustomButton(u8('Закрыть'), imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(200, 0)) then
						imgui.CloseCurrentPopup()
					end
					imgui.EndPopup()
				end
			end
			imgui.NextColumn()
			imgui.NewLine()
			imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8("Добавить бинд"), imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(0, 0)) then mass_bind[#mass_bind + 1] = {delay = "3", v = {}, text = "n/a", cmd = "-"} end	
		end
		imgui.EndChild()
        imgui.EndGroup()
        imgui.End()
	end
	
function shahtared()
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(723, 195), imgui.Cond.FirstUseEver)
	imgui.Begin(u8' Редактирование цен на ресурсы', win_state['shahtamenu'], imgui.WindowFlags.NoResize)
			imgui.Text('')
			imgui.Text('') imgui.SameLine() imgui.BeginChild('##asdasasddf4324', imgui.ImVec2(800, 150), false)
			imgui.Text('') imgui.SameLine() imgui.InputText(u8'Введите стоймость камня ##85', autokamen)
			imgui.Text('') imgui.SameLine() imgui.InputText(u8'Введите стоймость металла ##86', autometal)
			imgui.Text('') imgui.SameLine() imgui.InputText(u8'Введите стоймость бронзы ##87', autobronza)
			imgui.Text('') imgui.SameLine() imgui.InputText(u8'Введите стоймость серебра ##88', autosilver)
			imgui.Text('') imgui.SameLine() imgui.InputText(u8'Введите стоймость золота ##89', autogold)
			imgui.EndChild()
			imgui.End()
	end
	
function funksmenu()
	local sw, sh = getScreenResolution()
	local btn_size12 = imgui.ImVec2(370, 30)
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, -0.38))
	imgui.SetNextWindowSize(imgui.ImVec2(670, 195), imgui.Cond.FirstUseEver)
	imgui.Begin(u8' Прочие функции', win_state['shemafunks'], imgui.WindowFlags.NoResize)
		imgui.BeginChild('##asdasasddf2131543', imgui.ImVec2(800, 160), false)
		imgui.Text('')
		imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Авто-покупка Дистилированной воды', water); imgui.SameLine(); imgui.TextQuestion(u8"В 24/7 вам нужно открыть меню покупки(нажать на N у кассы - купить) и активировать данную функцию. Чтобы перестать скупать воду, выключите данную функцию или перезапустите скрипт. Если не работает - значит сменился ID текстдрава и вам нужно его поменять. Узнать ID текстдрава и изменить его вы сможете в 'Параметры' - 'Для разработчиков'.")
		imgui.SameLine(400)
		imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Запустить/Остановить видеокарты', pusk); imgui.SameLine(); imgui.TextQuestion(u8"Данная функция в автоматическом режиме запускает или останавливает видеокарты. При активаций функции вы должны стоять у полки с видеокартами.")
		imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Забрать прибыль (BTC)', btc); imgui.SameLine(); imgui.TextQuestion(u8"Данная функция в автоматическом режиме заберет прибыль с видеокарт. При активаций функции вы должны стоять у полки с видеокартами.")
		imgui.SameLine(400)
		imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Залить охлаждающую жидкость', liquid); imgui.SameLine(); imgui.TextQuestion(u8"Данная функция в автоматическом режиме зальет охлаждающую жидкость в видеокарты. При активаций функции вы должны стоять у полки с видеокартами.")
		imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Напоминание', napominalka); imgui.SameLine(); imgui.TextQuestion(u8"Если включено, то в назначенную вами дату придет уведомление о том, что пора забрать биткоины и обслужить ваши видеокарты.")
		imgui.PushItemWidth(422)
		imgui.Text('') imgui.SameLine() imgui.InputText(u8'Дата срабатывания напоминания ##90', napominalkadata); imgui.SameLine(); imgui.TextQuestion(u8"Дату нужно указать в формате - 'день.месяц' (Пример: 01.07).")
		imgui.Text('') imgui.SameLine() imgui.InputText(u8'Задержка для майнинг функций ##91', kdpusk); imgui.SameLine(); imgui.TextQuestion(u8"Задержка по умолчанию - 10 секунд. Задержка влияет на запуск видеокарт, заливку жидкости, улучшение видеокарт и так далее.")
		imgui.PopItemWidth()
		imgui.EndChild()
		imgui.End()
	end
	
function shemainstr()
	local sw, sh = getScreenResolution()
	local btn_size12 = imgui.ImVec2(370, 30)
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(813, 200), imgui.Cond.FirstUseEver)
	imgui.Begin(u8'Инструкция', win_state['shemainst'], imgui.WindowFlags.NoResize)
			imgui.BeginChild('##asdasasddf2131', imgui.ImVec2(800, 165), false)
			imgui.Text('')
			imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Видеокарты должны быть на второй странице инвентаря и идти по порядку! Т.е в слот №1 ложите видеокарту, следующую ложите в")
			imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"слот №2 и так далее. Чтобы узнать номер слота - смотрите схему. Если вы играете не на Arizona RP Prescott, то зайдите в")
			imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"'Редактирование ID Текстдравов' и исправьте значения на свои. Чтобы узнать ID текстдравов, откройте инвентарь, перейдите на")
			imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"вторую страницу и нажмите на кнопку 'Включить отображение ID Текстдравов'. Чтобы отобразились верные ID текстдравов, у вас")
			imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"на второй странице должны лежать видеокарты, начиная от слота №1 и так по порядку. Выключить отображение ID текстдравов вы")
			imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"можете, нажав на 'Выключить отображение ID Текстдравов'. Также помните, что ID текстдравов могут измениться из-за телефона,")
			imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"или из-за меню крафта, поэтому, если доставали телефон или открывали меню крафта, то лучше перезайти в игру.")
			imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Чтобы прервать процесс улучшения - нажмите на кнопку 'Завершить улучшение видеокарт'.")
			imgui.EndChild()
			imgui.End()
	end
	
function shemaskup()
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, -1.17))
	imgui.SetNextWindowSize(imgui.ImVec2(1000, 125), imgui.Cond.FirstUseEver)
	imgui.Begin(u8' Инструкция', win_state['skupshema'], imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
		imgui.BeginChild('##asdasasddf21312122', imgui.ImVec2(1000, 110), false)
		imgui.Text('')
		imgui.Text('') imgui.SameLine() imgui.Text(u8"1) Для начала поставьте галочку на тех товарах, которые хотите скупать. 2) Введите количество товара и цену за штуку в соответствующих полях.")
		imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"*ВАЖНО! НЕ НАЖИМАЙТЕ НА КНОПКУ 'РАССЧИТАТЬ ТОВАРЫ', ЕСЛИ ЗАПОЛНИЛИ НЕ ВСЕ ПОЛЯ!")
		imgui.Text('') imgui.SameLine() imgui.Text(u8"3) Встаньте в лавку, введите название, и нажмите альт, чтобы попасть в начальное меню лавки. Далее откройте меню скрипта - 'Skup Menu' и нажмите на кнопку")
		imgui.Text('') imgui.SameLine() imgui.Text(u8"'Выставить товары на скуп'.")
		imgui.EndChild()
		imgui.End()
	end
	
function pravila2048menu()
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(-2, 1.5))
	imgui.SetNextWindowSize(imgui.ImVec2(140, 165), imgui.Cond.FirstUseEver)
	imgui.Begin(u8'Правила 2048', win_state['pravila2048'], imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
		imgui.BeginChild('##asdasasddf21234', imgui.ImVec2(1000, 150), false)
		imgui.Text('')
		imgui.Text('') imgui.SameLine(30) imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Управление:")
		imgui.Text('')
		imgui.Text('') imgui.SameLine() imgui.Image(winup, imgui.ImVec2(15, 15), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) imgui.SameLine(28) imgui.Text(u8'- стрелка вверх')
		imgui.Text('') imgui.SameLine() imgui.Image(winright, imgui.ImVec2(15, 15), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) imgui.SameLine(28) imgui.Text(u8'- стрелка вправо')
		imgui.Text('') imgui.SameLine() imgui.Image(winleft, imgui.ImVec2(15, 15), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) imgui.SameLine(28) imgui.Text(u8'- стрелка влево')
		imgui.Text('') imgui.SameLine() imgui.Image(windown, imgui.ImVec2(15, 15), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) imgui.SameLine(28) imgui.Text(u8'- стрелка вниз')
		imgui.Text('') imgui.SameLine() imgui.Text(u8'Esc - закрыть игру')
		imgui.EndChild()
		imgui.End()
	end
	
function pravilapongmenu()
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(-4.3, 1.52))
	imgui.SetNextWindowSize(imgui.ImVec2(152, 179), imgui.Cond.FirstUseEver)
	imgui.Begin(u8'Правила Pong', win_state['pravilapong'], imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
		imgui.BeginChild('##asdasasddf2443645', imgui.ImVec2(1000, 160), false)
		imgui.Text('')
		imgui.Text('') imgui.SameLine(38) imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Управление:")
		imgui.Text('')
		imgui.Text('') imgui.SameLine() imgui.Image(winup, imgui.ImVec2(15, 15), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) imgui.SameLine(28) imgui.Text(u8'- стрелка вверх')
		imgui.Text('') imgui.SameLine() imgui.Image(windown, imgui.ImVec2(15, 15), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) imgui.SameLine(28) imgui.Text(u8'- стрелка вниз')
		imgui.Text('') imgui.SameLine() imgui.Text(u8'New Game - новая игра')
		imgui.Text('') imgui.SameLine() imgui.Text(u8'Difficulty - сложность')
		imgui.Text('') imgui.SameLine() imgui.Text(u8'Pause - пауза')
		imgui.Text('') imgui.SameLine() imgui.Text(u8'Start - начать игру')
		imgui.EndChild()
		imgui.End()
	end
	
function pravilasnakemenu()
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(-2.3, 1.5))
	imgui.SetNextWindowSize(imgui.ImVec2(137, 179), imgui.Cond.FirstUseEver)
	imgui.Begin(u8'Правила Snake', win_state['pravilasnake'], imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
		imgui.BeginChild('##asdasasddf2443645545', imgui.ImVec2(1000, 160), false)
		imgui.Text('')
		imgui.Text('') imgui.SameLine(30) imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Управление:")
		imgui.Text('')
		imgui.Text('') imgui.SameLine() imgui.Image(winup, imgui.ImVec2(15, 15), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) imgui.SameLine(28) imgui.Text(u8'- стрелка вверх')
		imgui.Text('') imgui.SameLine() imgui.Image(winright, imgui.ImVec2(15, 15), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) imgui.SameLine(28) imgui.Text(u8'- стрелка вправо')
		imgui.Text('') imgui.SameLine() imgui.Image(winleft, imgui.ImVec2(15, 15), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) imgui.SameLine(28) imgui.Text(u8'- стрелка влево')
		imgui.Text('') imgui.SameLine() imgui.Image(windown, imgui.ImVec2(15, 15), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1)) imgui.SameLine(28) imgui.Text(u8'- стрелка вниз')
		imgui.Text('') imgui.SameLine() imgui.Text(u8'E - начать игру')
		imgui.Text('') imgui.SameLine() imgui.Text(u8'R - выйти из игры')
		imgui.EndChild()
		imgui.End()
	end
	
function tupupdate()
	local sw, sh = getScreenResolution()
	local btn_size12 = imgui.ImVec2(370, 30)
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(855, 660), imgui.Cond.FirstUseEver)
	imgui.Begin(u8' Тестовые обновления v3.0', win_state['tup'], imgui.WindowFlags.NoResize)
			imgui.BeginChild('##asdasasddf531', imgui.ImVec2(855, 630), false)
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - Фикс фпс при включений ВХ на острове.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - Фикс таблички информера и пинга(пинг иногда отображался неверно)")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - Фикс 'Piar Menu'(крашил скрипт, если зайти в данное меню при заходе в игру)")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - Фикс дистилированной воды.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - Фикс таймцикла при использовании автобайка.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - Убраны числа в ВХ на предметы после точки.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - В 'Майнинг' добавлена возможность выбрать сразу 20 видеокарт на улучшение.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - В 'Piar Menu' добавлен сервер 'Show Low'.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - В 'Параметры' добавлен новый пункт 'Для разработчиков', в котором есть - режим смены работы биндера(Есть 2 режима работы биндера.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" Режим 'Обычный' - биндер не оставляет написанный текст в чате и не работают скриптовые команды через биндер. Режим 'Продвинутый' -")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" оставляет написанный ранее текст в чате, но зато работают команды скрипта через биндер), WallHack(позволяет увидеть ник игрока,")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" находясь далеко от него. Также не палится на скриншотах, если скриншот сделан на F8), настройка режима дрона(Есть 2 режима работы")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" дрона. Режим 'Обычный' - убирает ники и прочие надписи на игроках. Режим 'Продвинутый' - не убирает ники и прочие надписи на игроках")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" и встроен ВХ, который показывает не все ники в радиусе, а показывает ники игроков только в том случае, если вы дроном подлетели к нему).")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - В 'Arizona Update' добавлена функция 'Фикс Инвентаря'. Из-за функции для убирания диалога при спавне персонажа, багается инвентарь.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" Данная функция откроет /mm и закроет его, тем самым, разбагает инвентарь.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - Обновлены пользователи в меню 'Игроки, которые предлагали идеи и они были осуществлены'.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - В 'Параметры' - 'Модификации' добавлена анти-ломка. Теперь при ломке не будет качаться камера.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - В 'Параметры' - 'Для разработчиков' добавлены 2 кнопки - 'Включение и отключение ID текстдравов'.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - В 'Параметры' - 'Для разработчиков' добавлена возможность изменить ID текстдрава для покупки дестилированной воды.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - В 'Piar Menu' добавлен счётчик объявлений на неделю и кнопка для обнуления счётчика.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - Добавлен 'Чат' в тестовом режиме (исходник взял у Котовский)")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - Добавлено 'Авто-подключение к чату'. Теперь вам не нужно заходить в меню и подключаться к чату - скрипт сделает всё сам при входе в")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" игру или после перезагрузки скрипта. По умолчанию - включено.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - Добавлено 'Выводить сообщения из чата в игровой чат'. Теперь вы сможете общаться друг с другом не заходя в меню скрипта. Если")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" функция включена, то вы будете видеть сообщения других пользователей в обычном чате и сможете отвечать на них.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" По умолчанию - включено.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 1.0, 1.0), u8" [13.09.2021]")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - Фикс 'Skup Menu'(вместо ларьцов выставлялись точильные амулеты)")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - Фикс 'Trade Menu'(не работал обмен монет на точильные камни)")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - Из скрипта убран WallHack(по вашим просьбам)")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - Авто-еда из мешка с мясом теперь работает через команду, а не инвентарь.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - Добавлено напоминание в чате о том, как сменить ник, выключить сообщения из чата в скрипте в игровой чат и выключить")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" авто-подключению к чату.")
			imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8" - Теперь настройки чата сохраняются, если вы нажали 'Закрыть настройки'.")
			imgui.EndChild()
			imgui.End()
		end
	
function timeyveddate()
	local sw, sh = getScreenResolution()
	local btn_size12 = imgui.ImVec2(370, 30)
	imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(688, 125), imgui.Cond.FirstUseEver)
	imgui.Begin(u8' Напоминание сработало! Не забудьте сменить дату срабатывания или выключить функцию.', win_state['timeyved'], imgui.WindowFlags.NoResize)
			imgui.BeginChild('##asdasasddf531354', imgui.ImVec2(688, 90), false)
			imgui.Text('')
			imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8'Напоминаю вам, что вы установили напоминание, чтобы забрать прибыль и обслужить ваши видеокарты.')
			imgui.Text('') imgui.SameLine() imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8'Вы можете изменить дату напоминания прямо сейчас или позже в меню "Майнинг".')
			imgui.Text('') imgui.SameLine() imgui.InputText(u8'Дата срабатывания напоминания ##90', napominalkadata); imgui.SameLine(); imgui.TextQuestion(u8"Дату нужно указать в формате - 'день.месяц' (Пример: 01.07).")
			imgui.EndChild()
			imgui.End()
	end
	
function getArizonaName()
	if sampGetCurrentServerAddress() == "185.169.134.3" then gameServer = "Phoenix"
	elseif sampGetCurrentServerAddress() == "185.169.134.4" then gameServer = "Tucson"
	elseif sampGetCurrentServerAddress() == "185.169.134.43" then gameServer = "Scottdale"
	elseif sampGetCurrentServerAddress() == "185.169.134.44" then gameServer = "Chandler"
	elseif sampGetCurrentServerAddress() == "185.169.134.45" then gameServer = "Brainburg"
	elseif sampGetCurrentServerAddress() == "185.169.134.5" then gameServer = "Saint Rose"
	elseif sampGetCurrentServerAddress() == "185.169.134.59" then gameServer = "Mesa" 
	elseif sampGetCurrentServerAddress() == "185.169.134.61" then gameServer = "Red Rock"
	elseif sampGetCurrentServerAddress() == "185.169.134.107" then gameServer = "Yuma" 
	elseif sampGetCurrentServerAddress() == "185.169.134.109" then gameServer = "Surprise"
	elseif sampGetCurrentServerAddress() == "185.169.134.166" then gameServer = "Prescott"
	elseif sampGetCurrentServerAddress() == "185.169.134.171" then gameServer = "Glendale"
	elseif sampGetCurrentServerAddress() == "185.169.134.172" then gameServer = "Kingman"
	elseif sampGetCurrentServerAddress() == "185.169.134.173" then gameServer = "Winslow"
	elseif sampGetCurrentServerAddress() == "185.169.134.174" then gameServer = "Payson"
	elseif sampGetCurrentServerAddress() == "80.66.82.191" then gameServer = "Gilbert"
	elseif sampGetCurrentServerAddress() == "80.66.82.190" then gameServer = "Show Low"
	else gameServer = "Неизвестно" 
	end
	imgui.VerticalSeparator() imgui.SameLine(650) imgui.VerticalSeparator()
	imgui.Separator()
	imgui.Text(u8('  '..gameServer)) imgui.SameLine() imgui.Text("|") imgui.SameLine() imgui.Text(u8(nickName))
	imgui.Separator()
	imgui.Text(u8('  Понедельник')) imgui.SameLine() imgui.Text(u8('|')) imgui.SameLine() imgui.Text(u8('Обычных объявлений отправлено: ' ..cfg.adpred.piarsh)) imgui.SameLine() imgui.Text(u8('|')) imgui.SameLine() imgui.Text(u8('VIP объявлений отправлено: ' ..cfg.adpred.vippiarsh))
	imgui.Text(u8('  Вторник')) imgui.SameLine(93) imgui.Text(u8('|')) imgui.SameLine() imgui.Text(u8('Обычных объявлений отправлено: ' ..cfg.adpred.piarsh1)) imgui.SameLine() imgui.Text(u8('|')) imgui.SameLine() imgui.Text(u8('VIP объявлений отправлено: ' ..cfg.adpred.vippiarsh1))
	imgui.Text(u8('  Среда')) imgui.SameLine(93) imgui.Text(u8('|')) imgui.SameLine() imgui.Text(u8('Обычных объявлений отправлено: ' ..cfg.adpred.piarsh2)) imgui.SameLine() imgui.Text(u8('|')) imgui.SameLine() imgui.Text(u8('VIP объявлений отправлено: ' ..cfg.adpred.vippiarsh2))
	imgui.Text(u8('  Четверг')) imgui.SameLine(93) imgui.Text(u8('|')) imgui.SameLine() imgui.Text(u8('Обычных объявлений отправлено: ' ..cfg.adpred.piarsh3)) imgui.SameLine() imgui.Text(u8('|')) imgui.SameLine() imgui.Text(u8('VIP объявлений отправлено: ' ..cfg.adpred.vippiarsh3))
	imgui.Text(u8('  Пятница')) imgui.SameLine(93) imgui.Text(u8('|')) imgui.SameLine() imgui.Text(u8('Обычных объявлений отправлено: ' ..cfg.adpred.piarsh4)) imgui.SameLine() imgui.Text(u8('|')) imgui.SameLine() imgui.Text(u8('VIP объявлений отправлено: ' ..cfg.adpred.vippiarsh4))
	imgui.Text(u8('  Суббота')) imgui.SameLine(93) imgui.Text(u8('|')) imgui.SameLine() imgui.Text(u8('Обычных объявлений отправлено: ' ..cfg.adpred.piarsh5)) imgui.SameLine() imgui.Text(u8('|')) imgui.SameLine() imgui.Text(u8('VIP объявлений отправлено: ' ..cfg.adpred.vippiarsh5))
	imgui.Text(u8('  Воскресенье')) imgui.SameLine(93) imgui.Text(u8('|')) imgui.SameLine() imgui.Text(u8('Обычных объявлений отправлено: ' ..cfg.adpred.piarsh6)) imgui.SameLine() imgui.Text(u8('|')) imgui.SameLine() imgui.Text(u8('VIP объявлений отправлено: ' ..cfg.adpred.vippiarsh6))
	imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Обнулить счётчик объявлений', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-8, 0)) then 
	cfg.adpred.piarsh = 0 
	cfg.adpred.vippiarsh = 0 
	cfg.adpred.piarsh1 = 0 
	cfg.adpred.vippiarsh1 = 0  
	cfg.adpred.piarsh2 = 0 
	cfg.adpred.vippiarsh2 = 0  
	cfg.adpred.piarsh3 = 0 
	cfg.adpred.vippiarsh3 = 0  
	cfg.adpred.piarsh4 = 0 
	cfg.adpred.vippiarsh4 = 0  
	cfg.adpred.piarsh5 = 0 
	cfg.adpred.vippiarsh5 = 0  
	cfg.adpred.piarsh6 = 0 
	cfg.adpred.vippiarsh6 = 0  
	inicfg.save(cfg, 'Mono\\mini-games.ini')
	end
	imgui.PushItemWidth(50)
	imgui.Separator()
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Отправлять обычные объявления', addad) imgui.SameLine(254) imgui.InputText(u8'Задержка(сек) ##97', adsec)
	imgui.SameLine()
	if imgui.CustomButton(u8'Отправить объявление сейчас', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(237, 0)) then adtravel() end
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Отправлять VIP объявления', vipaddad) imgui.SameLine(254) imgui.InputText(u8'Задержка(сeк) ##98', vipadsec)
	imgui.SameLine() 
	if imgui.CustomButton(u8'Отправить VIP объявление сейчас', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(237, 0)) then adtravel2() end
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Отправлять текст в /fam', famaddad) imgui.SameLine(254) imgui.InputText(u8'Задержка(сeк) ##199', famadsec)
	imgui.SameLine() 
	if imgui.CustomButton(u8'Отправить текст в /fam сейчас', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(237, 0)) then adtravel3() end
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Отправлять текст в /vr', vraddad) imgui.SameLine(254) imgui.InputText(u8'Задержка(сeк) ##200', vradsec)
	imgui.SameLine() 
	if imgui.CustomButton(u8'Отправить текст в /vr сейчас', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(237, 0)) then adtravel4() end
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Отправлять текст в /s', saddad) imgui.SameLine(254) imgui.InputText(u8'Задержка(сeк) ##2000', sadsec)
	imgui.SameLine() 
	if imgui.CustomButton(u8'Отправить текст в /s сейчас', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(237, 0)) then adtravel5() end
	imgui.PopItemWidth()
	imgui.PushItemWidth(634)
	imgui.Text('') imgui.SameLine() imgui.InputText(u8'##99', adredak)
	imgui.Separator()
	imgui.PopItemWidth()
end

function getArizonaSkup()
	imgui.PushItemWidth(83)
	imgui.VerticalSeparator() imgui.SameLine(687) imgui.VerticalSeparator()
	imgui.Separator()
	imgui.Text('') imgui.SameLine(60) imgui.Text(u8("Название")) imgui.SameLine(183) imgui.Text(u8("Количество")) imgui.SameLine(307) imgui.Text(u8("Цена")) imgui.SameLine(490) imgui.Text(u8("Итого"))
    imgui.Separator()
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Счастливая травка', skuptrava) imgui.SameLine(177) imgui.InputText(u8'##100', skuptravacol) imgui.SameLine(281) imgui.InputText(u8'##101', skuptravacena) imgui.SameLine(385) imgui.Text(u8("За "..skuptravacol.v.." шт. товара нужно заплатить "..itogoskuptrava..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Бронзовая рулетка', skupbronzarul) imgui.SameLine(177) imgui.InputText(u8'##102', skupbronzarulcol) imgui.SameLine(281) imgui.InputText(u8'##103', skupbronzarulcena) imgui.SameLine(385) imgui.Text(u8("За "..skupbronzarulcol.v.." шт. товара нужно заплатить "..itogoskupbronzarul..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Серебряная рулетка', skupserebrorul) imgui.SameLine(177) imgui.InputText(u8'##104', skupserebrorulcol) imgui.SameLine(281) imgui.InputText(u8'##133', skupserebrorulcena) imgui.SameLine(385) imgui.Text(u8("За "..skupserebrorulcol.v.." шт. товара нужно заплатить "..itogoskupserebrorul..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Золотая рулетка', skupgoldrul) imgui.SameLine(177) imgui.InputText(u8'##105', skupgoldrulcol) imgui.SameLine(281) imgui.InputText(u8'##134', skupgoldrulcena) imgui.SameLine(385) imgui.Text(u8("За "..skupgoldrulcol.v.." шт. товара нужно заплатить "..itogoskupgoldrul..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Платиновая рулетка', skupplatinarul) imgui.SameLine(177) imgui.InputText(u8'##106', skupplatinarulcol) imgui.SameLine(281) imgui.InputText(u8'##135', skupplatinarulcena) imgui.SameLine(385) imgui.Text(u8("За "..skupplatinarulcol.v.." шт. товара нужно заплатить "..itogoskupplatinarul..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Камень', skupkamen) imgui.SameLine(177) imgui.InputText(u8'##107', skupkamencol) imgui.SameLine(281) imgui.InputText(u8'##136', skupkamencena) imgui.SameLine(385) imgui.Text(u8("За "..skupkamencol.v.." шт. товара нужно заплатить "..itogoskupkamen..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Металл', skupmetal) imgui.SameLine(177) imgui.InputText(u8'##108', skupmetalcol) imgui.SameLine(281) imgui.InputText(u8'##137', skupmetalcena) imgui.SameLine(385) imgui.Text(u8("За "..skupmetalcol.v.." шт. товара нужно заплатить "..itogoskupmetal..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Бронза', skupbronza) imgui.SameLine(177) imgui.InputText(u8'##109', skupbronzacol) imgui.SameLine(281) imgui.InputText(u8'##138', skupbronzacena) imgui.SameLine(385) imgui.Text(u8("За "..skupbronzacol.v.." шт. товара нужно заплатить "..itogoskupbronza..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Серебро', skupserebro) imgui.SameLine(177) imgui.InputText(u8'##110', skupserebrocol) imgui.SameLine(281) imgui.InputText(u8'##139', skupserebrocena) imgui.SameLine(385) imgui.Text(u8("За "..skupserebrocol.v.." шт. товара нужно заплатить "..itogoskupserebro..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Золото', skupgold) imgui.SameLine(177) imgui.InputText(u8'##111', skupgoldcol) imgui.SameLine(281) imgui.InputText(u8'##140', skupgoldcena) imgui.SameLine(385) imgui.Text(u8("За "..skupgoldcol.v.." шт. товара нужно заплатить "..itogoskupgold..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Подарки', skuppodarki) imgui.SameLine(177) imgui.InputText(u8'##112', skuppodarkicol) imgui.SameLine(281) imgui.InputText(u8'##141', skuppodarkicena) imgui.SameLine(385) imgui.Text(u8("За "..skuppodarkicol.v.." шт. товара нужно заплатить "..itogoskuppodarki..'$')) 
	imgui.Separator()
	imgui.Text('') imgui.SameLine(210) imgui.Text(u8("Итого за "..skuptovaracol.." шт. товара нужно заплатить "..itogoskuptovara..'$')) 
	imgui.Separator()
	imgui.Text('')
	imgui.SameLine(285)
	if imgui.CustomButton(u8'1', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(30, 30)) then
	win_state['skup'].v = true
	win_state['skup2'].v = false 
	win_state['skup3'].v = false 
	end
	imgui.SameLine()
	if imgui.CustomButton(u8'2', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(30, 30)) then 
	win_state['skup2'].v = true
	win_state['skup'].v = false 
	win_state['skup3'].v = false 
	end
	imgui.SameLine()
	if imgui.CustomButton(u8'3', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(30, 30)) then
	win_state['skup3'].v = true
	win_state['skup'].v = false  
	win_state['skup2'].v = false  
	end
	imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Вернуть значения скупа по умолчанию', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(332, 0)) then skuppoymol() end 
	imgui.SameLine() if imgui.CustomButton(u8'Рассчитать товары', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(332, 0)) then load_static() end
	imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Выставить товары на скуп', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(672, 0)) then skuptovarov() end
	imgui.Separator()
	imgui.PopItemWidth()
end

function getArizonaSkup2str()
	imgui.PushItemWidth(83)
	imgui.VerticalSeparator() imgui.SameLine(687) imgui.VerticalSeparator()
	imgui.Separator()
	imgui.Text('') imgui.SameLine(60) imgui.Text(u8("Название")) imgui.SameLine(183) imgui.Text(u8("Количество")) imgui.SameLine(307) imgui.Text(u8("Цена")) imgui.SameLine(490) imgui.Text(u8("Итого"))
    imgui.Separator()
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Гражданский талон', skuptalon) imgui.SameLine(177) imgui.InputText(u8'##113', skuptaloncol) imgui.SameLine(281) imgui.InputText(u8'##142', skuptaloncena) imgui.SameLine(385) imgui.Text(u8("За "..skuptaloncol.v.." шт. товара нужно заплатить "..itogoskuptalon..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Семейный талон', skupsemtalon) imgui.SameLine(177) imgui.InputText(u8'##117', skupsemtaloncol) imgui.SameLine(281) imgui.InputText(u8'##146', skupsemtaloncena) imgui.SameLine(385) imgui.Text(u8("За "..skupsemtaloncol.v.." шт. товара нужно заплатить "..itogoskupsemtalon..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Скидочный талон', skupskidtalon) imgui.SameLine(177) imgui.InputText(u8'##118', skupskidtaloncol) imgui.SameLine(281) imgui.InputText(u8'##147', skupskidtaloncena) imgui.SameLine(385) imgui.Text(u8("За "..skupskidtaloncol.v.." шт. товара нужно заплатить "..itogoskupskidtalon..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Точильный камень', skuptochkamen) imgui.SameLine(177) imgui.InputText(u8'##114', skuptochkamencol) imgui.SameLine(281) imgui.InputText(u8'##143', skuptochkamencena) imgui.SameLine(385) imgui.Text(u8("За "..skuptochkamencol.v.." шт. товара нужно заплатить "..itogoskuptochkamen..'$')) 
	imgui.PushItemWidth(187)
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Точильный амулет', skuptochamulet) imgui.SameLine(177) imgui.InputText(u8'##144', skuptochamuletcena) imgui.SameLine(385) imgui.Text(u8("За 1 шт. товара нужно заплатить "..itogoskuptochamulet..'$')) 
	imgui.PopItemWidth()
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Ларец с премией', skuplarec) imgui.SameLine(177) imgui.InputText(u8'##116', skuplareccol) imgui.SameLine(281) imgui.InputText(u8'##145', skuplareccena) imgui.SameLine(385) imgui.Text(u8("За "..skuplareccol.v.." шт. товара нужно заплатить "..itogoskuplarec..'$')) 
	imgui.PushItemWidth(187)
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Твин Турбо', skuptt) imgui.SameLine(177) imgui.InputText(u8'##148', skupttcena) imgui.SameLine(385) imgui.Text(u8("За 1 шт. товара нужно заплатить "..itogoskuptt..'$')) 
	imgui.PopItemWidth()
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Зловещая монета', skupmoneta) imgui.SameLine(177) imgui.InputText(u8'##120', skupmonetacol) imgui.SameLine(281) imgui.InputText(u8'##149', skupmonetacena) imgui.SameLine(385) imgui.Text(u8("За "..skupmonetacol.v.." шт. товара нужно заплатить "..itogoskupmoneta..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Лён', skuplen) imgui.SameLine(177) imgui.InputText(u8'##121', skuplencol) imgui.SameLine(281) imgui.InputText(u8'##150', skuplencena) imgui.SameLine(385) imgui.Text(u8("За "..skuplencol.v.." шт. товара нужно заплатить "..itogoskuplen..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Хлопок', skupxlopok) imgui.SameLine(177) imgui.InputText(u8'##122', skupxlopokcol) imgui.SameLine(281) imgui.InputText(u8'##151', skupxlopokcena) imgui.SameLine(385) imgui.Text(u8("За "..skupxlopokcol.v.." шт. товара нужно заплатить "..itogoskupxlopok..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Бандитский респект', skuprespekt) imgui.SameLine(177) imgui.InputText(u8'##123', skuprespektcol) imgui.SameLine(281) imgui.InputText(u8'##152', skuprespektcena) imgui.SameLine(385) imgui.Text(u8("За "..skuprespektcol.v.." шт. товара нужно заплатить "..itogoskuprespekt..'$')) 
	imgui.Separator()
	imgui.Text('') imgui.SameLine(210) imgui.Text(u8("Итого за "..skuptovaracol.." шт. товара нужно заплатить "..itogoskuptovara..'$')) 
	imgui.Separator()
	imgui.Text('')
	imgui.SameLine(285)
	if imgui.CustomButton(u8'1', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(30, 30)) then
	win_state['skup'].v = true
	win_state['skup2'].v = false 
	win_state['skup3'].v = false 
	end
	imgui.SameLine()
	if imgui.CustomButton(u8'2', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(30, 30)) then 
	win_state['skup2'].v = true
	win_state['skup'].v = false 
	win_state['skup3'].v = false 
	end
	imgui.SameLine()
	if imgui.CustomButton(u8'3', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(30, 30)) then
	win_state['skup3'].v = true
	win_state['skup'].v = false  
	win_state['skup2'].v = false  
	end
	imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Вернуть значения скупа по умолчанию', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(332, 0)) then skuppoymol() end 
	imgui.SameLine() if imgui.CustomButton(u8'Рассчитать товары', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(332, 0)) then load_static() end
	imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Выставить товары на скуп', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(672, 0)) then skuptovarov() end
	imgui.Separator()
	imgui.PopItemWidth()
end

function getArizonaSkup3str()
	imgui.PushItemWidth(83)
	imgui.VerticalSeparator() imgui.SameLine(687) imgui.VerticalSeparator()
	imgui.Separator()
	imgui.Text('') imgui.SameLine(60) imgui.Text(u8("Название")) imgui.SameLine(183) imgui.Text(u8("Количество")) imgui.SameLine(307) imgui.Text(u8("Цена")) imgui.SameLine(490) imgui.Text(u8("Итого"))
    imgui.Separator()
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Материалы', skupmaterial) imgui.SameLine(177) imgui.InputText(u8'##124', skupmaterialcol) imgui.SameLine(281) imgui.InputText(u8'##153', skupmaterialcena) imgui.SameLine(385) imgui.Text(u8("За "..skupmaterialcol.v.." шт. товара нужно заплатить "..itogoskupmaterial..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Дрова', skupdrova) imgui.SameLine(177) imgui.InputText(u8'##125', skupdrovacol) imgui.SameLine(281) imgui.InputText(u8'##154', skupdrovacena) imgui.SameLine(385) imgui.Text(u8("За "..skupdrovacol.v.." шт. товара нужно заплатить "..itogoskupdrova..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Антибиотики', skupantibiotik) imgui.SameLine(177) imgui.InputText(u8'##126', skupantibiotikcol) imgui.SameLine(281) imgui.InputText(u8'##155', skupantibiotikcena) imgui.SameLine(385) imgui.Text(u8("За "..skupantibiotikcol.v.." шт. товара нужно заплатить "..itogoskupantibiotik..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Отмычки от ТСР', skuptsr) imgui.SameLine(177) imgui.InputText(u8'##127', skuptsrcol) imgui.SameLine(281) imgui.InputText(u8'##156', skuptsrcena) imgui.SameLine(385) imgui.Text(u8("За "..skuptsrcol.v.." шт. товара нужно заплатить "..itogoskuptsr..'$')) 
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Семейные монеты', skupsemmoneta) imgui.SameLine(177) imgui.InputText(u8'##128', skupsemmonetacol) imgui.SameLine(281) imgui.InputText(u8'##157', skupsemmonetacena) imgui.SameLine(385) imgui.Text(u8("За "..skupsemmonetacol.v.." шт. товара нужно заплатить "..itogoskupsemmoneta..'$')) 
	imgui.PushItemWidth(187)
	imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Улучшение для авто', skupauto) imgui.SameLine(177) imgui.InputText(u8'##158', skupautocena) imgui.SameLine(385) imgui.Text(u8("За 1 шт. товара нужно заплатить "..itogoskupauto..'$')) 
	imgui.PopItemWidth()
	imgui.Text('')
	imgui.Text('')
	imgui.Text('')
	imgui.Text('')
	imgui.Text('')
	imgui.Text('')
	imgui.Text('')
	imgui.Separator()
	imgui.Text('') imgui.SameLine(210) imgui.Text(u8("Итого за "..skuptovaracol.." шт. товара нужно заплатить "..itogoskuptovara..'$')) 
	imgui.Separator()
	imgui.Text('')
	imgui.SameLine(285)
	if imgui.CustomButton(u8'1', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(30, 30)) then
	win_state['skup'].v = true
	win_state['skup2'].v = false 
	win_state['skup3'].v = false 
	end
	imgui.SameLine()
	if imgui.CustomButton(u8'2', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(30, 30)) then 
	win_state['skup2'].v = true
	win_state['skup'].v = false 
	win_state['skup3'].v = false 
	end
	imgui.SameLine()
	if imgui.CustomButton(u8'3', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(30, 30)) then
	win_state['skup3'].v = true
	win_state['skup'].v = false  
	win_state['skup2'].v = false  
	end
	imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Вернуть значения скупа по умолчанию', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(332, 0)) then skuppoymol() end 
	imgui.SameLine() if imgui.CustomButton(u8'Рассчитать товары', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(332, 0)) then load_static() end
	imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Выставить товары на скуп', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(672, 0)) then skuptovarov() end
	imgui.Separator()
	imgui.PopItemWidth()
end
	
function rpguns()
	imgui.BeginChild('##as2dasasdf433433', imgui.ImVec2(2000, 225), false)
		imgui.Columns(2, _, false)
		imgui.Text('') imgui.SameLine(90) imgui.AlignTextToFramePadding(); imgui.Text(u8(" Отыгровка оружия, когда оно у вас в руках")); imgui.SameLine(); imgui.ToggleButton(u8'', otgun); imgui.SameLine(); imgui.Text(u8(" Отыгровка оружия при прицеливании"))
		imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Редактировать отыгровки', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(730, 0)) then win_state['redak'].v = not win_state['redak'].v end
		imgui.NextColumn()
		imgui.NextColumn()
		imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Desert Eagle', deagle)
		imgui.SameLine(375,10)
		imgui.Checkbox(u8'Винтовка M4', m4)
		imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Снайперская винтовка', awp)
		imgui.SameLine(375,10)
		imgui.Checkbox(u8'Узи', uzi)
		imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Автомат АК-47', ak47)
		imgui.SameLine(375,10)
		imgui.Checkbox(u8'MP5', mp5)
		imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'ShotGun', shotgun)
		imgui.SameLine(375,10)
		imgui.Checkbox(u8'Rifle', rifle)
		imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Нож', knife)
		imgui.SameLine(375,10)
		imgui.Checkbox(u8'Тайзер', tazer)
		imgui.Text('') imgui.SameLine() imgui.Checkbox(u8'Убрать оружие', ybral)
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
	imgui.SetNextWindowSize(imgui.ImVec2(498, 492), imgui.Cond.FirstUseEver)
	imgui.Begin(u8' Редактировать cars', win_state['carsas'], imgui.WindowFlags.NoResize)
        if imgui.InputTextMultiline(u8'', buf, imgui.ImVec2(498, 420)) then 
            sampShowDialog(INFO[1],INFO[3],u8:decode(buf.v),INFO[4],INFO[5],INFO[2])
            sampSetDialogClientside(false)
		end	
		if imgui.CustomButton(u8'Сохранить', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(175, 40)) then 
			savedialog()
		end
		imgui.SameLine(323)
		if imgui.CustomButton(u8'Удалить', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(175, 40)) then 
			if ini.DIALOG_EDITOR["DIALOG_" .. INFO[1]] ~= nil then 
				ini.DIALOG_EDITOR["DIALOG_" .. INFO[1]] = nil
				sampShowDialog(INFO[1],INFO[3],INFO[6],INFO[4],INFO[5],INFO[2]) 
				sampSetDialogClientside(false)
			end
		end
        imgui.End()
end

function scriptinfo()
	imgui.Columns(2, _,false)
	imgui.SetColumnWidth(-1, 800)
	imgui.Text('')
	imgui.Text('') imgui.SameLine() imgui.TextColoredRGB("Автор: {FF0000}Bunya{FF0000}")
	imgui.Text('') imgui.SameLine() imgui.TextColoredRGB("Помогает в тестировании: {008000}Роман{008000}")
	imgui.Text('') imgui.SameLine() imgui.Text(u8("Группа в VK, на которую стоит подписаться:")) imgui.SameLine(272) imgui.TextColoredRGB("{0F52BA}click{0F52BA}") imgui.SameLine(272) imgui.Link('https://vk.com/monopolyfam','click')
	
	imgui.Text('') imgui.SameLine() imgui.TextColoredRGB("Промо-код на 09, 11 и 12, за который можно получить 1.000.000$ от Монополистов: {FFA500}#monopoly{FFA500}")
	imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Игроки, которые предлагали идеи и они были осуществлены', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-8, 0)) then win_state['oscriptepeople'].v = not win_state['oscriptepeople'].v end
	imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Поддержать Автора лайком и оставить отзыв', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-330, 0)) then os.execute("start https://www.blast.hk/threads/89343/") end
	imgui.SameLine()
	if imgui.CustomButton(u8'Поддержать Автора материально', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-8, 0)) then os.execute("start https://www.donationalerts.com/r/bunya75") end
	imgui.Text('') imgui.SameLine() if imgui.CustomButton(u8'Сообщить о баге или предложить идею', imgui.ImVec4(0.26, 0.59, 0.98, 0.60), imgui.ImVec4(0.26, 0.59, 0.98, 1.00), imgui.ImVec4(0.06, 0.53, 0.98, 1.00), imgui.ImVec2(-8, 0)) then os.execute("start https://www.blast.hk/threads/89343/page-30000") end
end

function scriptinfopeople()
	imgui.Columns(2, _,false)
	imgui.SetColumnWidth(-1, 800)
	imgui.Text('')
	imgui.Text('') imgui.SameLine() imgui.TextColoredRGB("{800080}Роман, Июнь, Саня, Алексей, kriper2009, Islamov, Эмиль, mizert, rodriguez_7777, Graph_Bavles, Илья,{800080}")
	imgui.Text('') imgui.SameLine() imgui.TextColoredRGB("{800080}COSMIK, arabKRYT, TodFox и Владимир.{800080}")
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
	imgui.Text('') imgui.SameLine(14)
    imgui.BeginChild("game", imgui.ImVec2(385, 365), true)
        if game == 0 then
            if imgui.Button('Start', imgui.ImVec2(-1,-1)) then
                math.randomseed(os.time())  
                game_board[math.random(1, #game_board)] = 2
                game_board[math.random(1, #game_board)] = 2
                score = 0
                game = 1
            end
        elseif game == 1 then
			 imgui.Text('')
            lockPlayerControl(true)
            for i=1,#game_board do
               imgui.Text('') imgui.SameLine() 
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

function onReceivePacket(id)
	if recongen.v then
	    if id == 37 then
			i, p = sampGetCurrentServerAddress()
			sampConnectToServer(i, p)
		end
	end
end

function videofailed()
	video.v = false
	video1.v = false
	video2.v = false
	video3.v = false
	video4.v = false
	video5.v = false
	video6.v = false
	video7.v = false
	video8.v = false
	video9.v = false
	video10.v = false
	video11.v = false
	video12.v = false
	video13.v = false
	video14.v = false
	video15.v = false
	video16.v = false
	video17.v = false
	video18.v = false
	video19.v = false
	video20.v = false
	video21.v = false
	video22.v = false
	video23.v = false
	video24.v = false
	video25.v = false
	video26.v = false
	video27.v = false
	video28.v = false
	video29.v = false
	video30.v = false
	video31.v = false
	video32.v = false
	video33.v = false
	video34.v = false
	video35.v = false
end

function videotrue()
	video.v = true
	video1.v = true
	video2.v = true
	video3.v = true
	video4.v = true
	video5.v = true
	video6.v = true
	video7.v = true
	video8.v = true
	video9.v = true
	video10.v = true
	video11.v = true
	video12.v = true
	video13.v = true
	video14.v = true
	video15.v = true
	video16.v = true
	video17.v = true
	video18.v = true
	video19.v = true
end

function sendKey(key)
    local _, myId = sampGetPlayerIdByCharHandle(PLAYER_PED)
    local data = allocateMemory(68)
    sampStorePlayerOnfootData(myId, data)
    setStructElement(data, 4, 2, key, false)
	setStructElement(data, 36, 1, key, false)
    sampSendOnfootData(data)
    freeMemory(data)
end

function Search3Dtext(x, y, z, radius, patern)
    local text = ""
    local color = 0
    local posX = 0.0
    local posY = 0.0
    local posZ = 0.0
    local distance = 0.0
    local ignoreWalls = false
    local player = -1
    local vehicle = -1
    local result = false

    for id = 0, 2048 do
        if sampIs3dTextDefined(id) then
            local text2, color2, posX2, posY2, posZ2, distance2, ignoreWalls2, player2, vehicle2 = sampGet3dTextInfoById(id)
            if getDistanceBetweenCoords3d(x, y, z, posX2, posY2, posZ2) < radius then
                if string.len(patern) ~= 0 then
                    if string.match(text2, patern, 0) ~= nil then result = true end
                else
                    result = true
                end
                if result then
                    text = text2
                    color = color2
                    posX = posX2
                    posY = posY2
                    posZ = posZ2
                    distance = distance2
                    ignoreWalls = ignoreWalls2
                    player = player2
                    vehicle = vehicle2
                    radius = getDistanceBetweenCoords3d(x, y, z, posX, posY, posZ)
                end
            end
        end
    end
    return result, text, color, posX, posY, posZ, distance, ignoreWalls, player, vehicle
end

function sampev.onDisplayGameText(style, tm, text)
	if text == "stone + 1" then
		kamensession = kamensession + 1
		kamenitog = kamensession * autokamen.v
		cfg.shahta.kamentime = cfg.shahta.kamentime + 1
		inicfg.save(cfg, 'Mono\\mini-games.ini')
	elseif text == "stone + 2" then
		kamensession = kamensession + 2
		kamenitog = kamensession * autokamen.v
		cfg.shahta.kamentime = cfg.shahta.kamentime + 2
		inicfg.save(cfg, 'Mono\\mini-games.ini')
	end
	if text == "metal + 1" then
		metalsession = metalsession + 1
		metalitog = metalsession * autometal.v
		cfg.shahta.metaltime = cfg.shahta.metaltime + 1
		inicfg.save(cfg, 'Mono\\mini-games.ini')
	elseif text == "metal + 2" then
		metalsession = metalsession + 2
		metalitog = metalsession * autometal.v
		cfg.shahta.metaltime = cfg.shahta.metaltime + 2
		inicfg.save(cfg, 'Mono\\mini-games.ini')
	end
	if text == "bronze + 1" then
		bronzasession = bronzasession + 1
		bronzaitog = bronzasession * autobronza.v
		cfg.shahta.bronzatime = cfg.shahta.bronzatime + 1
		inicfg.save(cfg, 'Mono\\mini-games.ini')
	elseif text == "bronze + 2" then
		bronzasession = bronzasession + 2
		bronzaitog = bronzasession * autobronza.v
		cfg.shahta.bronzatime = cfg.shahta.bronzatime + 2
		inicfg.save(cfg, 'Mono\\mini-games.ini')
	end
	if text == "silver + 1" then
		silversession = silversession + 1
		silveritog = silversession * autosilver.v
		cfg.shahta.silvertime = cfg.shahta.silvertime + 1
		inicfg.save(cfg, 'Mono\\mini-games.ini')
	elseif text == "silver + 2" then
		silversession = silversession + 2
		silveritog = silversession * autosilver.v
		cfg.shahta.silvertime = cfg.shahta.silvertime + 2
		inicfg.save(cfg, 'Mono\\mini-games.ini')
	end
	if text == "gold + 1" then
		goldsession = goldsession + 1
		golditog = goldsession * autogold.v
		cfg.shahta.goldtime = cfg.shahta.goldtime + 1
		inicfg.save(cfg, 'Mono\\mini-games.ini')
	elseif text == "gold + 2" then
		goldsession = goldsession + 2
		golditog = goldsession * autogold.v
		cfg.shahta.goldtime = cfg.shahta.goldtime + 2
		inicfg.save(cfg, 'Mono\\mini-games.ini')
	end	
	if text:find('+20 AZ') and podarki.v then 
		azpodarki = azpodarki + 20
		itogopodarkov = itogopodarkov + 20
	elseif text:find('+30 AZ') and podarki.v then 
		azpodarki = azpodarki + 30
		itogopodarkov = itogopodarkov + 20
	elseif text:find('+40 AZ') and podarki.v then 
		azpodarki = azpodarki + 40
		itogopodarkov = itogopodarkov + 20
	elseif text:find('+50 AZ') and podarki.v then 
		azpodarki = azpodarki + 50
		itogopodarkov = itogopodarkov + 20
	elseif text:find('+80 AZ') and podarki.v then 
		azpodarki = azpodarki + 80
		itogopodarkov = itogopodarkov + 20
	end
	if text:find('+3000') and podarki.v then 
		moneypodarki = moneypodarki + 3000
		itogopodarkov = itogopodarkov + 20
	elseif text:find('+5000') and podarki.v then 
		moneypodarki = moneypodarki + 5000
		itogopodarkov = itogopodarkov + 20
	elseif text:find('+50000') and podarki.v then 
		moneypodarki = moneypodarki + 50000
		itogopodarkov = itogopodarkov + 20
	end
	sborsession = kamensession + metalsession + bronzasession + silversession + goldsession
	zpsession = kamenitog + metalitog + bronzaitog + silveritog + golditog
	cfg.shahta.zptime = (cfg.shahta.kamentime*autokamen.v) + (cfg.shahta.metaltime*autometal.v) + (cfg.shahta.bronzatime*autobronza.v) + (cfg.shahta.silvertime*autosilver.v) + (cfg.shahta.goldtime*autogold.v)
	cfg.shahta.sbortime = cfg.shahta.kamentime + cfg.shahta.metaltime + cfg.shahta.bronzatime + cfg.shahta.silvertime + cfg.shahta.goldtime
	inicfg.save(cfg, 'Mono\\mini-games.ini')
end

function imgui.VerticalSeparator()
    local p = imgui.GetCursorScreenPos()
    imgui.GetWindowDrawList():AddLine(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x, p.y + imgui.GetContentRegionMax().y), imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.Separator]))
end	

function adtravel()
lua_thread.create(function()
	closeDialog()
	wait(100)
	sampSendChat(u8:decode ('/ad '..adredak.v))
	wait(300)
	sampSendDialogResponse(15346, 1, 1, -1)
	wait(200)
	sampSendDialogResponse(15347, 1, 0, -1)
	wait(100)
	closeDialog()
		end)
	end
	
function adtravel2()
lua_thread.create(function()
	closeDialog()
	wait(100)
	sampSendChat(u8:decode ('/ad '..adredak.v))
	wait(300)
	sampSendDialogResponse(15346, 1, 2, -1)
	wait(200)
	sampSendDialogResponse(15347, 1, 0, -1)
	wait(100)
	closeDialog()
	end)
end

function adtravel3()
lua_thread.create(function()
	sampSendChat(u8:decode ('/fam '..adredak.v))
	end)
end

function adtravel4()
lua_thread.create(function()
	sampSendChat(u8:decode ('/vr '..adredak.v))
	end)
end

function adtravel5()
lua_thread.create(function()
	sampSendChat(u8:decode ('/s '..adredak.v))
	end)
end

function photo_load()
	wait(10000)
	winbackground = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/img0.png')
    winpusk = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/pusk.png')
    winedge = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/edge.png')
    winsetting = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/settingwin.png')
	winyashik = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/sunduk.png')
	windollar = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/dollar.png')
	winphone = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/phone.png')
	wintelega = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/telega.png')
	win2048 = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/2048.png')
	winpingpong = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/pingpong.png')
	winsnakegame = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/snakegame.png')
	winnotes = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/notes.png')
	winbitkoin = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/bitcoin.png')
	winkirka = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/kirka.png')
	winhelper = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/helper.png')
	wininfo = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/info.png')
	wintochkamen = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/tochkamen.png')
	winuser = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/user.png')
	winoffpc = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/offpc.png')
	winreload = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/reload.png')
	wintrade = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/trade.png')
	winup = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/up.png')
	windown = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/down.png')
	winleft = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/left.png')
	winright = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/right.png')
	winarizonanews = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/arizonanews.png')
	wintools3 = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/wintools3.0.png')
	winmonopolynews = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/monopolynews.png')
	winaforma = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/aforma.png')
	winarzupdate = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/arzupdate.png')
	winprazdnik = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/prazdnik.png')
	winrobot = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/robot.png')
	winbomj = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/bomj.png')
	winmessage = imgui.CreateTextureFromFile('moonloader/config/Mono/icons/messanger.png')
	end

function load_static()
	itogoskuptrava = skuptravacol.v * skuptravacena.v
	itogoskupbronzarul = skupbronzarulcol.v * skupbronzarulcena.v
	itogoskupserebrorul = skupserebrorulcol.v * skupserebrorulcena.v
	itogoskupgoldrul = skupgoldrulcol.v * skupgoldrulcena.v
	itogoskupplatinarul = skupplatinarulcol.v * skupplatinarulcena.v
	itogoskupkamen = skupkamencol.v * skupkamencena.v
	itogoskupmetal = skupmetalcol.v * skupmetalcena.v
	itogoskupbronza = skupbronzacol.v * skupbronzacena.v
	itogoskupserebro = skupserebrocol.v * skupserebrocena.v
	itogoskupgold = skupgoldcol.v * skupgoldcena.v
	itogoskuppodarki = skuppodarkicol.v * skuppodarkicena.v
	itogoskuptalon = skuptaloncol.v * skuptaloncena.v
	itogoskupsemtalon = skupsemtaloncol.v * skupsemtaloncena.v
	itogoskupskidtalon = skupskidtaloncol.v * skupskidtaloncena.v
	itogoskuptochkamen = skuptochkamencol.v * skuptochkamencena.v
	itogoskuptochamulet = 1 * skuptochamuletcena.v
	itogoskuplarec = skuplareccol.v * skuplareccena.v
	itogoskuptt = 1 * skupttcena.v
	itogoskupmoneta = skupmonetacol.v * skupmonetacena.v
	itogoskuplen = skuplencol.v * skuplencena.v
	itogoskupxlopok = skupxlopokcol.v * skupxlopokcena.v
	itogoskuprespekt = skuprespektcol.v * skuprespektcena.v
	itogoskupmaterial = skupmaterialcol.v * skupmaterialcena.v
	itogoskupdrova = skupdrovacol.v * skupdrovacena.v
	itogoskupantibiotik = skupantibiotikcol.v * skupantibiotikcena.v
	itogoskuptsr = skuptsrcol.v * skuptsrcena.v
	itogoskupsemmoneta = skupsemmonetacol.v * skupsemmonetacena.v
	itogoskupauto = 1 * skupautocena.v
	
	if skuptrava.v then skuptravacool = skuptravacol.v else skuptravacool = 0 end
	if skupbronzarul.v then skupbronzarulcool = skupbronzarulcol.v else skupbronzarulcool = 0 end
	if skupserebrorul.v then skupserebrorulcool = skupserebrorulcol.v else skupserebrorulcool = 0 end
	if skupgoldrul.v then skupgoldrulcool = skupgoldrulcol.v else skupgoldrulcool = 0 end
	if skupplatinarul.v then skupplatinarulcool = skupplatinarulcol.v else skupplatinarulcool = 0 end
	if skupkamen.v then skupkamencool = skupkamencol.v else skupkamencool = 0 end
	if skupmetal.v then skupmetalcool = skupmetalcol.v else skupmetalcool = 0 end
	if skupbronza.v then skupbronzacool = skupbronzacol.v else skupbronzacool = 0 end
	if skupserebro.v then skupserebrocool = skupserebrocol.v else skupserebrocool = 0 end
	if skupgold.v then skupgoldcool = skupgoldcol.v else skupgoldcool = 0 end
	if skuppodarki.v then skuppodarkicool = skuppodarkicol.v else skuppodarkicool = 0 end
	if skuptrava.v then skuptravacennik = itogoskuptrava else skuptravacennik = 0 end
	if skupbronzarul.v then skupbronzarulcennik = itogoskupbronzarul else skupbronzarulcennik = 0 end
	if skupserebrorul.v then skupserebrorulcennik = itogoskupserebrorul else skupserebrorulcennik = 0 end
	if skupgoldrul.v then skupgoldrulcennik = itogoskupgoldrul else skupgoldrulcennik = 0 end
	if skupplatinarul.v then skupplatinarulcennik = itogoskupplatinarul else skupplatinarulcennik = 0 end
	if skupkamen.v then skupkamencennik = itogoskupkamen else skupkamencennik = 0 end
	if skupmetal.v then skupmetalcennik = itogoskupmetal else skupmetalcennik = 0 end
	if skupbronza.v then skupbronzacennik = itogoskupbronza else skupbronzacennik = 0 end
	if skupserebro.v then skupserebrocennik = itogoskupserebro else skupserebrocennik = 0 end
	if skupgold.v then skupgoldcennik = itogoskupgold else skupgoldcennik = 0 end
	if skuppodarki.v then skuppodarkicennik = itogoskuppodarki else skuppodarkicennik = 0 end
	if skuptalon.v then skuptaloncool = skuptaloncol.v else skuptaloncool = 0 end
	if skupsemtalon.v then skupsemtaloncool = skupsemtaloncol.v else skupsemtaloncool = 0 end
	if skupskidtalon.v then skupskidtaloncool = skupskidtaloncol.v else skupskidtaloncool = 0 end
	if skuptochkamen.v then skuptochkamencool = skuptochkamencol.v else skuptochkamencool = 0 end
	if skuptochamulet.v then skuptochamuletcool = 1 else skuptochamuletcool = 0 end
	if skuplarec.v then skuplareccool = skuplareccol.v else skuplareccool = 0 end
	if skuptt.v then skupttcool = 1 else skupttcool = 0 end
	if skupmoneta.v then skupmonetacool = skupmonetacol.v else skupmonetacool = 0 end
	if skuplen.v then skuplencool = skuplencol.v else skuplencool = 0 end
	if skupxlopok.v then skupxlopokcool = skupxlopokcol.v else skupxlopokcool = 0 end
	if skuprespekt.v then skuprespektcool = skuprespektcol.v else skuprespektcool = 0 end
	if skuptalon.v then skuptaloncennik = itogoskuptalon else skuptaloncennik = 0 end
	if skupsemtalon.v then skupsemtaloncennik = itogoskupsemtalon else skupsemtaloncennik = 0 end
	if skupskidtalon.v then skupskidtaloncennik = itogoskupskidtalon else skupskidtaloncennik = 0 end
	if skuptochkamen.v then skuptochkamencennik = itogoskuptochkamen else skuptochkamencennik = 0 end
	if skuptochamulet.v then skuptochamuletcennik = itogoskuptochamulet else skuptochamuletcennik = 0 end
	if skuplarec.v then skuplareccennik = itogoskuplarec else skuplareccennik = 0 end
	if skuptt.v then skupttcennik = itogoskuptt else skupttcennik = 0 end
	if skupmoneta.v then skupmonetacennik = itogoskupmoneta else skupmonetacennik = 0 end
	if skuplen.v then skuplencennik = itogoskuplen else skuplencennik = 0 end
	if skupxlopok.v then skupxlopokcennik = itogoskupxlopok else skupxlopokcennik = 0 end
	if skuprespekt.v then skuprespektcennik = itogoskuprespekt else skuprespektcennik = 0 end
	if skupmaterial.v then skupmaterialcool = skupmaterialcol.v else skupmaterialcool = 0 end
	if skupdrova.v then skupdrovacool = skupdrovacol.v else skupdrovacool = 0 end
	if skupantibiotik.v then skupantibiotikcool = skupantibiotikcol.v else skupantibiotikcool = 0 end
	if skuptsr.v then skuptsrcool = skuptsrcol.v else skuptsrcool = 0 end
	if skupsemmoneta.v then skupsemmonetacool = skupsemmonetacol.v else skupsemmonetacool = 0 end
	if skupauto.v then skupautocool = 1 else skupautocool = 0 end
	if skupmaterial.v then skupmaterialcennik = itogoskupmaterial else skupmaterialcennik = 0 end
	if skupdrova.v then skupdrovacennik = itogoskupdrova else skupdrovacennik = 0 end
	if skupantibiotik.v then skupantibiotikcennik = itogoskupantibiotik else skupantibiotikcennik = 0 end
	if skuptsr.v then skuptsrcennik = itogoskuptsr else skuptsrcennik = 0 end
	if skupsemmoneta.v then skupsemmonetacennik = itogoskupsemmoneta else skupsemmonetacennik = 0 end
	if skupauto.v then skupautocennik = itogoskupauto else skupautocennik = 0 end
	
	skuptovaracol = skuptravacool + skupbronzarulcool + skupserebrorulcool + skupgoldrulcool + skupplatinarulcool + skupkamencool + skupmetalcool + skupbronzacool + skupserebrocool + skupgoldcool + skuppodarkicool + skuptaloncool + skupsemtaloncool + skupskidtaloncool + skuptochkamencool + skuptochamuletcool + skuplareccool + skupttcool + skupmonetacool + skuplencool + skupxlopokcool + skuprespektcool + skupmaterialcool + skupdrovacool + skupantibiotikcool + skuptsrcool + skupsemmonetacool + skupautocool
	itogoskuptovara = skuptravacennik + skupbronzarulcennik + skupserebrorulcennik + skupgoldrulcennik + skupplatinarulcennik + skupkamencennik + skupmetalcennik + skupbronzacennik + skupserebrocennik + skupgoldcennik + skuppodarkicennik + skuptaloncennik + skupsemtaloncennik + skupskidtaloncennik + skuptochkamencennik + skuptochamuletcennik + skuplareccennik + skupttcennik + skupmonetacennik + skuplencennik + skupxlopokcennik + skuprespektcennik + skupmaterialcennik + skupdrovacennik + skupantibiotikcennik + skuptsrcennik + skupsemmonetacennik + skupautocennik
end

function skuptovarov()
lua_thread.create(function()
	if skuptrava.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 1, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skuptravacol.v..','..skuptravacena.v)
	end
	if skupbronzarul.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 8, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupbronzarulcol.v..','..skupbronzarulcena.v)
	end
	if skupserebrorul.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 9, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupserebrorulcol.v..','..skupserebrorulcena.v)
	end
	if skupgoldrul.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 10, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupgoldrulcol.v..','..skupgoldrulcena.v)
	end
	if skupplatinarul.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 10, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupplatinarulcol.v..','..skupplatinarulcena.v)
	end
	if skupkamen.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 4, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupkamencol.v..','..skupkamencena.v)
	end
	if skupmetal.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 5, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupmetalcol.v..','..skupmetalcena.v)
	end
	if skupbronza.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 6, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupbronzacol.v..','..skupbronzacena.v)
	end
	if skupserebro.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 7, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupserebrocol.v..','..skupserebrocena.v)
	end
	if skupgold.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 8, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupgoldcol.v..','..skupgoldcena.v)
	end
	if skuppodarki.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 5, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skuppodarkicol.v..','..skuppodarkicena.v)
	end
	if skuptalon.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 5, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skuptaloncol.v..','..skuptaloncena.v)
	end
	if skupsemtalon.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 12, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupsemtaloncol.v..','..skupsemtaloncena.v)
	end
	if skupskidtalon.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 4, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupskidtaloncol.v..','..skupskidtaloncena.v)
	end
	if skuptochkamen.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 18, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skuptochkamencol.v..','..skuptochkamencena.v)
	end
	if skuptochamulet.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skuptochamuletcena.v)
	end
	if skuplarec.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 2, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skuplareccol.v..','..skuplareccena.v)
	end
	if skuptt.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 7, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupttcena.v)
	end
	if skupmoneta.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 17, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupmonetacol.v..','..skupmonetacena.v)
	end
	if skuplen.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 3, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skuplencol.v..','..skuplencena.v)
	end
	if skupxlopok.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 2, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupxlopokcol.v..','..skupxlopokcena.v)
	end
	if skuprespekt.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 16, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skuprespektcol.v..','..skuprespektcena.v)
	end
	if skupmaterial.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 1, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupmaterialcol.v..','..skupmaterialcena.v)
	end
	if skupdrova.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 18, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupdrovacol.v..','..skupdrovacena.v)
	end
	if skupantibiotik.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 6, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupantibiotikcol.v..','..skupantibiotikcena.v)
	end
	if skuptsr.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 7, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skuptsrcol.v..','..skuptsrcena.v)
	end
	if skupsemmoneta.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 14, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupsemmonetacol.v..','..skupsemmonetacena.v)
	end
	if skupauto.v then 
	sampSendDialogResponse(3040, 1, 0, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 19, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 20, -1)
	wait(500)
	sampSendDialogResponse(3050, 1, 8, -1)
	wait(500)
	sampSendDialogResponse(3060, 1, 1, ''..skupautocena.v)
		end
	end)
end

function skuppoymol()
		skuptravacol.v = '1'
		skuptravacena.v = '1000'
		skupbronzarulcol.v = '1'
		skupbronzarulcena.v = '15000'
		skupserebrorulcol.v = '1'
		skupserebrorulcena.v = '95000'
		skupgoldrulcol.v = '1'
		skupgoldrulcena.v = '300000'
		skupplatinarulcol.v = '1'
		skupplatinarulcena.v = '600000'
		skupkamencol.v = '1'
		skupkamencena.v = '10000'
		skupmetalcol.v = '1'
		skupmetalcena.v = '5000'
		skupbronzacol.v = '1'
		skupbronzacena.v = '50000'
		skupserebrocol.v = '1'
		skupserebrocena.v = '100000'
		skupgoldcol.v = '1'
		skupgoldcena.v = '50000'
		skuppodarkicol.v = '1'
		skuppodarkicena.v = '10000'
		skuptaloncol.v = '1'
		skuptaloncena.v = '7000'
		skupsemtaloncol.v = '1'
		skupsemtaloncena.v = '17000'
		skupskidtaloncol.v = '1'
		skupskidtaloncena.v = '2000000'
		skuptochkamencol.v = '1'
		skuptochkamencena.v = '80000'
		skuptochamuletcena.v = '200000'
		skuplareccol.v = '1'
		skuplareccena.v = '300000'
		skupttcena.v = '9000000'
		skupmonetacol.v = '1'
		skupmonetacena.v = '2000'
		skuplencol.v = '1'
		skuplencena.v = '2000'
		skupxlopokcol.v = '1'
		skupxlopokcena.v = '1500'
		skuprespektcol.v = '1'
		skuprespektcena.v = '2000'
		skupmaterialcol.v = '1'
		skupmaterialcena.v = '100'
		skupdrovacol.v = '1'
		skupdrovacena.v = '100'
		skupantibiotikcol.v = '1'
		skupantibiotikcena.v = '10000'
		skuptsrcol.v = '1'
		skuptsrcena.v = '15000'
		skupsemmonetacol.v = '1'
		skupsemmonetacena.v = '5000'
		skupautocena.v = '2000000'
		saveSettings(4)
	end
	
function videoover()
	video.v = false
	video1.v = false
	video2.v = false
	video3.v = false
	video4.v = false
	video5.v = false
	video6.v = false
	video7.v = false
	video8.v = false
	video9.v = false
	video10.v = false
	video11.v = false
	video12.v = false
	video13.v = false
	video14.v = false
	video15.v = false
	video16.v = false
	video17.v = false
	video18.v = false
	video19.v = false
	video20.v = false
	video21.v = false
	video22.v = false
	video23.v = false
	video24.v = false
	video25.v = false
	video26.v = false
	video27.v = false
	video28.v = false
	video29.v = false
	video30.v = false
	video31.v = false
	video32.v = false
	video33.v = false
	video34.v = false
	video35.v = false
end

function setMarker(type, x, y, z) 
	bs = raknetNewBitStream() 
	raknetBitStreamWriteInt8(bs, type) 
	raknetBitStreamWriteFloat(bs, x) 
	raknetBitStreamWriteFloat(bs, y) 
	raknetBitStreamWriteFloat(bs, z) 
	raknetBitStreamWriteFloat(bs, 0) 
	raknetBitStreamWriteFloat(bs, 0) 
	raknetBitStreamWriteFloat(bs, 0) 
	raknetBitStreamWriteFloat(bs, 2) 
	raknetEmulRpcReceiveBitStream(38, bs) 
	raknetDeleteBitStream(bs)
addOneOffSound(0, 0, 0, 1149)
end

function nameTagOn()
	local pStSet = sampGetServerSettingsPtr()
	NTdist = memory.getfloat(pStSet + 39)
	NTwalls = memory.getint8(pStSet + 47)
	NTshow = memory.getint8(pStSet + 56)
	memory.setfloat(pStSet + 39, 1488.0)
	memory.setint8(pStSet + 47, 0)
	memory.setint8(pStSet + 56, 1)
end

function nameTagOff()
    lua_thread.create(function()
	local pStSet = sampGetServerSettingsPtr()
	memory.setfloat(pStSet + 39, NTdist)
	memory.setint8(pStSet + 47, NTwalls)
	memory.setint8(pStSet + 56, NTshow)
end)
end

function sampev.onSetPlayerDrunk(drunkLevel)
	if antilomka.v then
    return {1}
	end
end

function chatmsg(text)
    sampAddChatMessage(string.format("[Mono Tools]{FFFFFF} %s", text), 0x046D63)
end

function startConnect()
    lua_thread.create(function()
        if not connected and not connecting then
            connecting = true
            wait(100)
            s = irc.new{nick = cfg1.message.nick} --! Проверка на ник.
            s:connect("irc.esper.net")
            for k, v in pairs(chats) do
                s:join(v)
                messages[v] = {}
                users[v] = {}
            end
            s:hook("OnChat", onIRCMessage)
            s:hook("OnRaw", onIRCRaw)
            s:hook("OnJoin", onIRCJoin)
            s:hook("OnPart", onIRCPart)
            s:hook("OnQuit", onIRCQuit)
            s:hook("NickChange", onIRCNickChange)
            s:hook("OnKick", onIRCKick)
            s:hook("OnModeChange", onIRCModeChange)
            s:hook("OnDisconnect", onIRCDisconnect)
            connected = true
            connecting = false
        end
    end)
end

function serverDisconnect()
    if connected then
        connected = false
        s:disconnect()
        for k, v in pairs(chats) do
            if chats[i] then
                messages[v] = nil
                users[v] = nil
                chats[i] = nil
            end
        end
        window_selected = 0
    end
end

function sendMessage()
    if window_selected ~= 0 then
        local tempField = u8:decode(str(stringField.v))
        local tempCheck = string.gsub(tempField, " ", "")
        if tempCheck ~= '' and tempCheck ~= nil then
            if os.time() - lastMessage > 1 then
                if tempField:sub(1, 1) ~= "/" then
                    s:sendChat(chats[window_selected], u8(tempField))
                    table.insert(messages[chats[window_selected]], string.format("%s: %s", cfg1.message.nick, tempField))
					if chatmessage.v then
					sampAddChatMessage("[#monotools] {A77BCA}"..cfg1.message.nick..": {FFFFFF}"..tempField, 0x046D63)
					end
                else
                    if tempField:find("/pm") then
                        local toNick, message = tempField:match("/pm (%S+) (.*)")

                        s:send(u8(string.format("PRIVMSG %s :%s", toNick, message)))
                        table.insert(messages[chats[window_selected]], string.format("{A77BCA}[PM >> %s]: %s", toNick, message))
						if chatmessage.v then
						sampAddChatMessage("[#monotools] {A77BCA}[PM >> "..toNick.."]: {FFFFFF}"..message, 0x046D63)
						end
                    else
                        table.insert(messages[chats[window_selected]], "{A77BCA}[*] {C3C3C3}Неизвестная команда!")
                    end
                end
                imgui.Text(stringField.v)
                lastMessage = os.time()
            else
                table.insert(messages[chats[window_selected]], "{A77BCA}[*] {C3C3C3}Пожалуйста, не флудите.")
                imgui.Text(stringField.v)
            end
        end
    end
end

  function imgui.SelectText(text, index)
        if imgui.Selectable(text, (window_selected == index and true or false)) then window_selected = index end
    end
    function imgui.CentrText(text, disabled)
        local width = imgui.GetWindowSize().x
        local calc = imgui.CalcTextSize(text).x 
        imgui.SetCursorPosX((width - calc) * 0.5)
        if disabled then
            imgui.TextDisabled(text)
        else
            imgui.Text(text)
        end
    end
    function imgui.RightText(text, disabled)
        local width = imgui.GetWindowSize().x
        local calc = imgui.CalcTextSize(text).x 
        imgui.SetCursorPosX((width - calc) - 5)
        if disabled then
            imgui.TextDisabled(text)
        else
            imgui.Text(text)
        end
    end
	
function onIRCMessage(user, channel, message)
    if channel and messages[channel] then
        table.insert(messages[channel], u8:decode(string.format("%s: %s", user.nick, message)))
		if chatmessage.v then
		sampAddChatMessage(u8:decode(string.format("[#monotools] {A77BCA}"..user.nick..": {FFFFFF}"..message.." {C3C3C3}(/mc)")), 0x046D63)
		end
	end
    if channel == cfg1.message.nick then
        if window_selected ~= 0 then table.insert(messages[chats[window_selected]], u8:decode(string.format("{A77BCA}[PM << %s]: %s", user.nick, message)))
		if chatmessage.v then
		sampAddChatMessage(u8:decode(string.format("[#monotools] {A77BCA}[PM << %s]: {FFFFFF}%s {C3C3C3}(/pm)", user.nick, message)), 0x046D63)
		end
       end
    end
end
function onIRCRaw(line)
    print(line)
    if line:find(cfg1.message.nick.." = .* :(.*)") then        
        local channel, nick = line:match(cfg1.message.nick.." = (.*) :(.*)")
        for w in string.gmatch(nick, "%S+") do
            local w = string.gsub(w, "@", "")
            table.insert(users[channel], w)
        end
    end
    if line:find("Cannot join channel %(%+b%) %- you are banned") then
        local channel = line:match(cfg1.message.nick.." (%S+).*%:Cannot join channel %(%+b%) %- you are banned")
        table.insert(messages[channel], "{FA8072}Вы заблокированы в данном чате.")
    end
end
function onIRCJoin(user, channel)
    local userNick = string.gsub(user.nick, "@", "")
    if userNick:find(cfg1.message.nick) then
        table.insert(messages[channel], "{A77BCA}[*] {C3C3C3}Вы подключились к чату.")
        table.insert(messages[channel], "{A77BCA}[*] {C3C3C3}Выключить или включить 'Авто-подключение к чату при заходе в игру', сменить")
		table.insert(messages[channel], "{A77BCA}[*] {C3C3C3}ник, выключить или включить сообщения в чате вы можете в настройках чата.")
		if chatmessage.v then 
		sampAddChatMessage("[#monotools] {C3C3C3}Вы подключились к чату.", 0x046D63)
		sampAddChatMessage("[#monotools] {C3C3C3}Доступные команды:", 0x046D63)
		sampAddChatMessage("[#monotools] {C3C3C3}/mc [message] - обычное сообщение.", 0x046D63)
		sampAddChatMessage("[#monotools] {C3C3C3}/pm [nick] [message] - приватное сообщение.", 0x046D63)
		sampAddChatMessage("[#monotools] {FF5C40}Важно! {C3C3C3}Выключить 'Авто-подключение к чату при заходе в игру' вы можете в 'Меню скрипта' - 'Чат' - 'Настройки'.", 0x046D63)
		sampAddChatMessage("[#monotools] {FF5C40}Важно! {C3C3C3}Сменить ник вы можете в 'Меню скрипта' - 'Чат' - 'Настройки'.", 0x046D63)
		sampAddChatMessage("[#monotools] {FF5C40}Важно! {C3C3C3}Выключить сообщения в чате вы можете в 'Меню скрипта' - 'Чат' - 'Настройки'.", 0x046D63)
		sampAddChatMessage("[#monotools] {FF5C40}Важно! {C3C3C3}Группа VK скрипта - {A77BCA}https://vk.com/mono_tools {C3C3C3}(подпишись, если не сложно)", 0x046D63)
		end
        table.insert(messages[channel], "{A77BCA}[*] {C3C3C3}Доступные команды:")
        table.insert(messages[channel], "{A77BCA}[*] {C3C3C3}/pm [nick] [message] - приватное сообщение.")
		table.insert(messages[channel], "{A77BCA}[*] {FF5C40}Группа VK скрипта - {A77BCA}https://vk.com/mono_tools {FF5C40}(подпишись, если не сложно)")
    else
        table.insert(users[channel], userNick)
        table.insert(messages[channel], string.format("{A77BCA}[*] {C3C3C3}%s подключился к чату.", userNick))
		if chatmessage.v then 
		sampAddChatMessage("[#monotools] {C3C3C3}"..userNick.." подключился к чату.", 0x046D63)
		end
    end
end
function onIRCPart(user, channel)
    local userNick = string.gsub(user.nick, "@", "")
    if users[channel] then
        for i=1, #users[channel] do
            if users[channel][i] == userNick then
                table.remove(users[channel], i)
                break
            end
        end
        if messages[channel] then table.insert(messages[channel], string.format("{A77BCA}[*] {C3C3C3}%s вышел из чата.", userNick)) end
    end
end
function onIRCQuit(user, message)
    local userNick = string.gsub(user.nick, "@", "")
    if users[channel] then
        for i=1, #users[channel] do
            if users[channel][i] == userNick then
                table.remove(users[channel], i)
                break
            end
        end
        if messages[channel] then table.insert(messages[channel], string.format("{A77BCA}[*] {C3C3C3}%s отключился от чата.", userNick)) end
    end
end
function onIRCNickChange(user, newnick, channel)
    local userNick = string.gsub(user.nick, "@", "")
    if users[channel] then
        for i=1, #users[channel] do
            if users[channel][i] == userNick then
                table.remove(users[channel], i)
                table.insert(users[channel], newnick)
                break
            end
        end
        if messages[channel] then table.insert(messages[channel], string.format("{A77BCA}[*] {C3C3C3}%s изменил ник на %s", userNick, newnick)) end
    end
end
function onIRCKick(channel, nick, kicker, reason)
    if users[channel] then
        for i=1, #users[channel] do
            if users[channel][i] == nick then
                table.remove(users[channel], i)
                break
            end
        end
        if messages[channel] then table.insert(messages[channel], string.format("{A77BCA}[*] {C3C3C3}%s был кикнут администратором %s", nick, kicker.nick)) end
    end
end
function onIRCModeChange(user, target, modes, ...)
    if modes:find("b") then
        local banNick = string.match(..., "(%S+)!")
        if modes == "-b" then
            if messages[target] then table.insert(messages[target], string.format("{A77BCA}[*] {C3C3C3}%s был разблокирован администратором %s", banNick, user.nick)) end
        else
            if messages[target] then table.insert(messages[target], string.format("{A77BCA}[*] {C3C3C3}%s был заблокирован администратором %s", banNick, user.nick)) end
        end
    end 
end
function onIRCDisconnect(message, error)
    if error then
        if connected then
            connected = false
            s:disconnect()
            for k, v in pairs(chats) do
                if chats[i] then
                    messages[v] = nil
                    users[v] = nil
                    chats[i] = nil
                end
            end
            window_selected = 0
            chatmsg("Вы были отключены от сервера за AFK")
        end
    end
end

function memset(addr, arr)
	for i = 1, #arr do
		memory.write(addr + i - 1, arr[i], 1, true)
	end
end

function imgui.NewInputText(lable, val, width, hint, hintpos)
    local hint = hint and hint or ''
    local hintpos = tonumber(hintpos) and tonumber(hintpos) or 1
    local cPos = imgui.GetCursorPos()
    imgui.PushItemWidth(width)
    local result = imgui.InputText(lable, val)
    if #val.v == 0 then
        local hintSize = imgui.CalcTextSize(hint)
        if hintpos == 2 then imgui.SameLine(cPos.x + (width - hintSize.x) / 2)
        elseif hintpos == 3 then imgui.SameLine(cPos.x + (width - hintSize.x - 5))
        else imgui.SameLine(cPos.x + 5) end
        imgui.TextColored(imgui.ImVec4(1.00, 1.00, 1.00, 0.40), tostring(hint))
    end
    imgui.PopItemWidth()
    return result
end

function saveJson(data, path)
    if doesFileExist(path) then os.remove(path) end
    if type(data) ~= 'table' then return end
    local f = io.open(path, 'a+')
    local writing_data = encodeJson(data)
    f:write(writing_data)
    f:close()
end

	




	
	
