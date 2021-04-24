script_name('Mono Tools')
script_properties("work-in-pause")
script_version('1.2')

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
krytim = true

local restore_text = false
local dialogs_data = {}
local dialogIncoming = 0

bike = {[481] = true, [509] = true, [510] = true}
moto = {[448] = true, [461] = true, [462] = true, [463] = true, [468] = true, [471] = true, [521] = true, [522] = true, [523] = true, [581] = true, [586] = true}

local res = pcall(require, "lib.moonloader")
assert(res, 'Library "lib.moonloader" не найдена. Чтобы скачать все нужны файлы и библиотеки, перейдите по ссылке - https://cloud.mail.ru/public/kue3/rYYaeFHoT')
---------------------------------------------------------------
local res, ffi = pcall(require, 'ffi')
assert(res, 'Library "ffi" не найдена. Чтобы скачать все нужны файлы и библиотеки, перейдите по ссылке - https://cloud.mail.ru/public/kue3/rYYaeFHoT')
---------------------------------------------------------------
local res = pcall(require, 'lib.sampfuncs')
assert(res, 'Library "lib.sampfuncs" не найдена. Чтобы скачать все нужны файлы и библиотеки, перейдите по ссылке - https://cloud.mail.ru/public/kue3/rYYaeFHoT')
---------------------------------------------------------------
local res, sampev = pcall(require, 'lib.samp.events')
assert(res, 'Library "SAMP Events" не найдена. Чтобы скачать все нужны файлы и библиотеки, перейдите по ссылке - https://cloud.mail.ru/public/kue3/rYYaeFHoT')
---------------------------------------------------------------
local res, key = pcall(require, "vkeys")
assert(res, 'Library "vkeys" не найдена. Чтобы скачать все нужны файлы и библиотеки, перейдите по ссылке - https://cloud.mail.ru/public/kue3/rYYaeFHoT')
---------------------------------------------------------------
local res, imgui = pcall(require, "imgui")
assert(res, 'Library "imgui" не найдена. Чтобы скачать все нужны файлы и библиотеки, перейдите по ссылке - https://cloud.mail.ru/public/kue3/rYYaeFHoT')
---------------------------------------------------------------
local res, encoding = pcall(require, "encoding")
assert(res, 'Library "encoding" не найдена. Чтобы скачать все нужны файлы и библиотеки, перейдите по ссылке - https://cloud.mail.ru/public/kue3/rYYaeFHoT')
---------------------------------------------------------------
local res, inicfg = pcall(require, "inicfg")
assert(res, 'Library "inicfg" не найдена. Чтобы скачать все нужны файлы и библиотеки, перейдите по ссылке - https://cloud.mail.ru/public/kue3/rYYaeFHoT')
---------------------------------------------------------------
local res, memory = pcall(require, "memory")
assert(res, 'Library "memory" не найдена. Чтобы скачать все нужны файлы и библиотеки, перейдите по ссылке - https://cloud.mail.ru/public/kue3/rYYaeFHoT')
---------------------------------------------------------------
local res, rkeys = pcall(require, "rkeys")
assert(res, 'Library "rkeys" не найдена. Чтобы скачать все нужны файлы и библиотеки, перейдите по ссылке - https://cloud.mail.ru/public/kue3/rYYaeFHoT')
---------------------------------------------------------------
local res, hk = pcall(require, 'lib.imcustom.hotkey')
assert(res, 'Library "imcustom" не найдена. Чтобы скачать все нужны файлы и библиотеки, перейдите по ссылке - https://cloud.mail.ru/public/kue3/rYYaeFHoT')
-- ---------------------------------------------------------------

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
ole32.CoInitializeEx(nil, 2 + 4)

-- свалка переменных
mlogo, errorPic, classifiedPic, pentagonPic, accessDeniedPic, gameServer, nasosal_rang = nil, nil, nil, nil, nil, nil -- 
srv, arm = nil, nil -- 
whitelist, superID, vigcout, narcout, order = 0, 0, 0, 0, 0 -- значения по дефолту для "информация"
regDialogOpen, regAcc, UpdateNahuy, checking, getLeader, checkupd = false, false, false, false, false -- bool переменные для работы с диалогами
ScriptUse = 3 -- для цикла
offscript = 0 -- переменная для подсчета количества нажатий на кнопку "выключить скрипта"
pentcout, pentsrv, pentinv, pentuv = 0,0,0,0 -- дефолт значения /base
regStatus = false -- 
gmsg = false -- 
gosButton, AccessBe = true -- 
dostupLvl = nil -- уровень доступа
activated = nil -- 
isLocalPlayerSoldier = false --
getMOLeader = "Not Registred" -- 
getSVLeader = "Not Registred" -- 
getVVSLeader = "Not Registred" -- 
getVMFLeader = "Not Registred" -- 
pidr = false -- 
errorSearch = nil -- если не смогли найти в пентагоне
flymode = 0 -- камхак
isPlayerSoldier = false -- 
speed = 0.2 -- скорость камхака
bstatus = 0 -- 
state = false -- 
keystatus = false -- проверка на воспроизведение бинда
mouseCoord = false -- проверка на статус перемещения окна информера
token = 1 -- токен
mouseCoord2 = false -- 
mouseCoord3 = false -- 
getServerColored = '' -- переменная в которой храним все ники пользователей по серверу для покраса в чате

blackbase = {} -- 
names = {} -- 
SecNames = {}
SecNames2 = {}


-- переменные для шпоры, если не ошибаюсь, то есть лишние
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
	
-- настройки игрока
local SET = {
 	settings = {
		autologin = false,
		autopin = false,
		autopay = false,
		lock = false,
		autopass = '',
		autopasspin = '',
		timecout = false,
		gangzones = false,
		zones = false,
		assistant = false,
		tag = '',
		enable_tag = false,
		chatInfo = false,
		keyT = false,
		launcher = false,
		ndr = false,
		toch = false,
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
		idmodel = false,
		idtextdraw = false,
		skin = 1,
	},
	assistant = {
		asX = 1,
		asY = 1
	},
	informer = {
		zone = true,
		hp = true,
		armour = true,
		city = true,
		kv = true,
		time = true,
		rajon = true
	}
}


local SeleList = {"Досье", "Сведения", "Пентагон"} -- список менюшек для блока "информация"

-- это делалось если не ошибаюсь для выделения выбранного пункта
local SeleListBool = {}
for i = 1, #SeleList do
	SeleListBool[i] = imgui.ImBool(false)
end

-- массив для окон
local win_state = {}
win_state['main'] = imgui.ImBool(false)
win_state['info'] = imgui.ImBool(false)
win_state['settings'] = imgui.ImBool(false)
win_state['hotkeys'] = imgui.ImBool(false)
win_state['leaders'] = imgui.ImBool(false)
win_state['help'] = imgui.ImBool(false)
win_state['calc'] = imgui.ImBool(false)
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
local checked_test5 = imgui.ImBool(false)
local checked_test6 = imgui.ImBool(false)
local checked_test7 = imgui.ImBool(false)
local checked_test8 = imgui.ImBool(false)
local checked_test9 = imgui.ImBool(false)
local checked_test10 = imgui.ImBool(false)
local checktochilki = false
local checktochilki1 = false
local checktochilki2 = false
local checked_box = imgui.ImBool(false)
local checked_box2 = imgui.ImBool(false)
local checked_box3 = imgui.ImBool(false)
local result = '';
local inputBufferText = imgui.ImBuffer(256)

-- временные переменные, которым не требуется сохранение
pozivnoy = imgui.ImBuffer(256) -- позывной в меню взаимодействия
cmd_name = imgui.ImBuffer(256) -- название команды
cmd_text = imgui.ImBuffer(65536) -- текст бинда
searchn = imgui.ImBuffer(256) -- поиск ника в пентагоне
specOtr = imgui.ImBuffer(256) -- спец.отряд для нашивки(вроде)
weather = imgui.ImInt(-1) -- установка погоды
pay = imgui.ImInt(10000) -- сумма депозита
zadervka = imgui.ImInt(1) -- задержка
gametime = imgui.ImInt(-1) -- установка времени 
binddelay = imgui.ImInt(3) -- задержка биндера
local checked_radio = imgui.ImInt(1)

-- удаление файла клавиш, делаю только тогда, когда добавляю новые клавиши. P.S. удаляет как когда
if doesFileExist(getWorkingDirectory() .. "\\config\\Mono\\keys.bind") then 
	os.remove(getWorkingDirectory() .. "\\config\\Mono\\keys.bind")
end

-- Собственно тут ебошим клавиши для биндера и обычные, ничего необычного, а исток всего этого - PerfectBinder хомяка, ибо только там было показано, как более менее юзать imcustom/rkeys.
hk._SETTINGS.noKeysMessage = u8("Пусто")
local bfile = getWorkingDirectory() .. "\\config\\Mono\\key.bind" -- путь к файлу для хранения клавиш
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


-----------------------------------------------------------------------------------
------------------------------- ФИКСЫ----------------------------------------------
-----------------------------------------------------------------------------------

-- Фикс зеркального бага alt+tab(черный экран или же какая то хуйня в виде зеркал на экране после разворота в инте)
writeMemory(0x555854, 4, -1869574000, true)
writeMemory(0x555858, 1, 144, true)

-- функция быстрого прогруза игры, кепчик чтоль автор.. Не помню
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

-----------------------------------------------------------------------------------
-------------------------- ФУНКЦИИ СКРИПТА И ВСЕ ЧТО ПО НИМ -----------------------
-----------------------------------------------------------------------------------


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
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
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
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
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

function apply_custom_style5() -- серый стиль
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

function files_add() -- функция подгрузки медиа файлов
	if not doesFileExist(getGameDirectory()..'\\moonloader\\config\\Mono\\settings.ini') then 
		inicfg.save(SET, 'config\\Mono\\settings.ini')
	end
end

function rkeys.onHotKey(id, keys) -- эту штучку я не использую, но она помогла запретить юзание клавиш в определенных ситах
	if sampIsChatInputActive() or sampIsDialogActive() or isSampfuncsConsoleActive() or win_state['base'].v or win_state['update'].v or win_state['player'].v or droneActive or keystatus then
		return false
	end
end

function onHotKey(id, keys) -- функция обработки всех клавиш, которые ток существуют в скрипте благодаря imcustom, rkeys и хомяку
	local sKeys = tostring(table.concat(keys, " "))
	for k, v in pairs(tBindList) do
		if sKeys == tostring(table.concat(v.v, " ")) then
			if k == 7 then -- делаем реконнект
				reconnect()
				return
			elseif k == 13 then -- открываем меню
				mainmenu()
				return
			end
		end
	end

	for i, p in pairs(mass_bind) do -- тут регистрируем биндер на клавиши.
		if sKeys == tostring(table.concat(p.v, " ")) then
			rcmd(nil, p.text, p.delay)		
		end
	end
end

function calc(m) -- "калькулятор", который так и не нашел применения в скрипте, но функция все же тут есть
    local func = load('return '..tostring(m))
    local a = select(2, pcall(func))
    return type(a) == 'number' and a or nil
end

function WorkInBackground(work) -- работа в свернутом imringa'a
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

function WriteLog(text, path, file) -- функция записи текст в файл, используется для чатлога
	if not doesDirectoryExist(getWorkingDirectory()..'\\'..path..'\\') then
		createDirectory(getWorkingDirectory()..'\\'..path..'\\')
	end
	local file = io.open(getWorkingDirectory()..'\\'..path..'\\'..file..'.txt', 'a+')
	file:write(text..'\n')
	file:flush()
	file:close()
end

-- Шифровалка Base64
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/' -- You will need this for encoding/decoding
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

function tags(args) -- функция с тэгами скрипта

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

function mainmenu() -- функция открытия основного меню скрипта
	if not win_state['player'].v and not win_state['update'].v and not win_state['base'].v and not win_state['regst'].v then
		if win_state['settings'].v then
			win_state['settings'].v = not win_state['settings'].v
		elseif win_state['leaders'].v then
			win_state['leaders'].v = not win_state['leaders'].v
		elseif win_state['about'].v then
			win_state['about'].v = not win_state['about'].v
		elseif win_state['help'].v then
			win_state['help'].v = not win_state['help'].v
		elseif win_state['calc'].v then
			win_state['calc'].v = not win_state['calc'].v
		elseif win_state['info'].v then
			win_state['info'].v = not win_state['info'].v
		elseif menu_spur.v then
			menu_spur.v = not menu_spur.v
		end
		win_state['main'].v = not win_state['main'].v
		imgui.Process = win_state['main'].v

		offscript = 0
		selected = 1
		selected2 = 1
		showSet = 1
		leadSet = 1
	end
end

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	load_settings() -- загрузка настроек
	-- определяем ник и ID локального игрока 
	_, myID = sampGetPlayerIdByCharHandle(PLAYER_PED)
	userNick = sampGetPlayerNickname(myID)
	nickName = userNick:gsub('_', ' ')
	sampAddChatMessage("[Mono Tools]{FFFFFF} Скрипт успешно запущен! Версия: {00C2BB}"..thisScript().version.."{FFFFFF}. Активация {00C2BB}/mono{FFFFFF}", 0x046D63)
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
	
	local font = renderCreateFont("Arial", 8, 5) --creating font
    sampRegisterChatCommand("td_get", function(i)
        print(sampTextdrawGetString(i))
        sampAddChatMessage(sampTextdrawGetString(i), -1)
    end)

	inputHelpText = renderCreateFont("Arial", 10, FCR_BORDER + FCR_BOLD) -- шрифт для chatinfo
	lua_thread.create(showInputHelp)
	
	-- регистрация локальных команд/команды
	sampRegisterChatCommand("cc", ClearChat) -- очистка чата
	sampRegisterChatCommand("drone", drone) -- дроны
	sampRegisterChatCommand("leave", function() if not win_state['player'].v and not win_state['update'].v and not win_state['main'].v then win_state['leave'].v = not win_state['leave'].v end end) -- не вводить команду, она нужна не для этого.
	sampRegisterChatCommand("reload", rel) -- перезагрузка скрипта
	sampRegisterChatCommand("changeskin", ex_skin) -- не вводить команду, она нужна не для этого.
	sampRegisterChatCommand("mono", mainmenu) -- меню скрипта
	sampRegisterChatCommand('rul', rul) -- не вводить команду, она нужна не для этого.
	autoupdate("https://raw.githubusercontent.com/KabanBunya/Tools/main/update.json", '['..string.upper(thisScript().name)..']: ')
	while token == 0 do wait(0) end
	if enableskin.v then changeSkin(-1, localskin.v) end -- установка визуал скина, если включено
	while true do
		wait(0)
		
		-- получаем время
		unix_time = os.time(os.date('!*t'))
		moscow_time = unix_time + timefix.v * 60 * 60

		if gametime.v ~= -1 then writeMemory(0xB70153, 1, gametime.v, true) end -- установка игрового времени
		if weather.v ~= -1 then writeMemory(0xC81320, 1, weather.v, true) end -- установка игровой погоды
		
		--addGangZone(1001, -2080.2, 2200.1, -2380.9, 2540.3, 0x11011414) менее светлый цвет
		armourNew = getCharArmour(PLAYER_PED) -- получаем броню
		healNew = getCharHealth(PLAYER_PED) -- получаем ХП
		interior = getActiveInterior() -- получаем инту

		-- получение названия района на инглише(работает только при включенном английском в настройках игры, иначе иероглифы)
		local zX, zY, zZ = getCharCoordinates(playerPed)
		ZoneInGame = getGxtText(getNameOfZone(zX, zY, zZ))
			
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
		
		if files[1] then
			for i, k in pairs(files) do
				if k and not imgui.Process then imgui.Process = menu_spur.v or window_file[i].v end
			end
		else imgui.Process = menu_spur.v end
		
		imgui.Process = win_state['regst'].v or win_state['main'].v or win_state['update'].v or win_state['player'].v or win_state['base'].v or win_state['informer'].v or win_state['renew'].v or win_state['find'].v or win_state['ass'].v or win_state['leave'].v
		
		-- тут мы шаманим с блокировкой управления персонажа
		if menu_spur.v or win_state['settings'].v or win_state['leaders'].v or win_state['player'].v or win_state['base'].v or win_state['regst'].v or win_state['renew'].v or win_state['leave'].v then
			if not isCharInAnyCar(PLAYER_PED) then
				lockPlayerControl(false)
			end
		elseif droneActive then
			lockPlayerControl(true)
		elseif workpause then
			if userNick ~= "" then
				sampSetChatInputEnabled(false)
			end
			lockPlayerControl(true)
		else
			lockPlayerControl(false)
		end

		if wasKeyPressed(key.VK_R) and not win_state['main'].v and not win_state['update'].v and not win_state['base'].v and not win_state['regst'].v and isPlayerSoldier then -- меню взаимодействия на ПКМ + R
			local result, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
			if result then
				local tdd, id = sampGetPlayerIdByCharHandle(ped)
				if tdd then
					MenuName = sampGetPlayerNickname(id)
					MenuID = id
					win_state['player'].v = not win_state['player'].v
				end
			end
		end

		if keyT.v then -- чат на русскую Т
			if(isKeyDown(key.VK_T) and wasKeyPressed(key.VK_T))then
				if(not sampIsChatInputActive() and not sampIsDialogActive()) then
					sampSetChatInputEnabled(true)
				end
			end
		end
		
		if isCharOnAnyBike(playerPed) and isKeyDown(0xA0) and autobike.v then
			if bike[getCarModel(storeCarCharIsInNoSave(playerPed))] then
				setGameKeyState(16, 255)
				wait(10)
				setGameKeyState(16, 0)
			elseif moto[getCarModel(storeCarCharIsInNoSave(playerPed))] and autobike.v then
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
		
		if toggle and idtextdraw.v then --params that not declared has a nil value that same as false
            for a = 0, 2304    do --cycle trough all textdeaw id
                if sampTextdrawIsExists(a) then --if textdeaw exists then
                    x, y = sampTextdrawGetPos(a) --we get it's position. value returns in game coords
                    x1, y1 = convertGameScreenCoordsToWindowScreenCoords(x, y) --so we convert it to screen cuz render needs screen coords
                    renderFontDrawText(font, a, x1, y1, 0xFFBEBEBE) --and then we draw it's id on textdeaw position
			end
		end
	end
		
		if launcher.v then -- эмулятор лаунчера
			sampev.onSendClientJoin(Ver, mod, nick, response, authKey, clientver, unk)
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
			
	if checked_test.v and krytim then
      rul()
      wait(222)
      sampSendClickTextdraw(2089)
      sampSendClickTextdraw(2091)
      krytim = false
    end
    if checked_test2.v and krytim then
      rul()
      wait(111)
      sampSendClickTextdraw(2083)
      sampSendClickTextdraw(2085)
      wait(222)
      sampSendClickTextdraw(2089)
      sampSendClickTextdraw(2091)
      krytim = false
    end
      if checked_test3.v and krytim then
      rul()
      wait(111)
      sampSendClickTextdraw(2088)
      sampSendClickTextdraw(2090)
      wait(222)
      sampSendClickTextdraw(2089)
      sampSendClickTextdraw(2091)
      krytim = false
    end
    if checked_test4.v and krytim then
      rul()
      wait(111)
      sampSendClickTextdraw(2108)
      sampSendClickTextdraw(2110)
      wait(222)
      sampSendClickTextdraw(2089)
      sampSendClickTextdraw(2091)
      krytim = false
	end
	if checked_test5.v then
      active = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
    end
    if checked_test6.v then
      active1 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
    end
    if checked_test7.v then
      active2 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
	end
	if checked_test8.v then
      active3 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
	end
	if checked_test9.v then
      active4 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
	end
	if checked_test10.v then
      active5 = true
      sampSendChat("/invent")
      wait(zadervka.v*60000)
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

function EmulShowNameTag(id, value) -- эмуляция показа неймтэгов над бошкой
    local bs = raknetNewBitStream()
    raknetBitStreamWriteInt16(bs, id)
    raknetBitStreamWriteBool(bs, value)
    raknetEmulRpcReceiveBitStream(80, bs)
    raknetDeleteBitStream(bs)
end

function sampGetPlayerIdByNickname(nick) -- получаем id игрока по нику
    if type(nick) == "string" then
        for id = 0, 1000 do
            local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
            if sampIsPlayerConnected(id) or id == myid then
                local name = sampGetPlayerNickname(id)
                if nick == name then
                    return id
                end
            end
        end
    end
end

function onQuitGame()
	saveSettings(2) -- сохраняем игру при выходе
end

function onScriptTerminate(script, quitGame) -- действия при отключении скрипта
	if script == thisScript() then
		showCursor(false)
		saveSettings(1)
			end
		end

function saveSettings(args, key) -- функция сохранения настроек, args 1 = при отключении скрипта, 2 = при выходе из игры, 3 = сохранение клавиш + текст key, 4 = обычное сохранение.

	if doesFileExist(bindfile) then
		os.remove(bindfile)
	end
	local f2 = io.open(bindfile, "w")
	if f2 then
		f2:write(encodeJson(mass_bind))
		f2:close()
	end

	ini.informer.zone = infZone.v
	ini.informer.hp = infHP.v
	ini.informer.armour = infArmour.v
	ini.informer.city = infCity.v
	ini.informer.kv = infKv.v
	ini.informer.time = infTime.v
	ini.informer.rajon = infRajon.v
	ini.settings.assistant = assistant.v
	ini.settings.keyT = keyT.v
	ini.settings.launcher = launcher.v
	ini.settings.ndr = ndr.v
	ini.settings.toch = toch.v
	ini.settings.autobike = autobike.v
	ini.settings.styletest = styletest.v
	ini.settings.styletest1 = styletest1.v
	ini.settings.styletest2 = styletest2.v
	ini.settings.styletest3 = styletest3.v
	ini.settings.styletest4 = styletest4.v
	ini.settings.styletest5 = styletest5.v
	ini.settings.timefix = timefix.v
	ini.settings.enableskin = enableskin.v
	ini.settings.idmodel = idmodel.v
	ini.settings.idtextdraw = idtextdraw.v
	ini.settings.skin = localskin.v
	ini.settings.timecout = timecout.v
	ini.settings.gangzones = gangzones.v
	ini.settings.zones = zones.v
	ini.settings.chatInfo = chatInfo.v
	ini.settings.infoX = infoX
	ini.settings.infoY = infoY
	ini.settings.infoX2 = infoX2
	ini.settings.infoY2 = infoY2
	ini.settings.findX = findX
	ini.settings.findY = findY
	ini.settings.tag = u8:decode(rtag.v)

	ini.settings.autopass = u8:decode(autopass.v)
	ini.settings.autopasspin = u8:decode(autopasspin.v)
	ini.settings.autologin = autologin.v
	ini.settings.autopin = autopin.v
	ini.settings.autopay = autopay.v
	ini.settings.lock = lock.v

	ini.assistant.asX = asX
	ini.assistant.asY = asY

	ini.settings.enable_tag = enable_tag.v
	ini.settings.spOtr = u8:decode(spOtr.v)
	inicfg.save(SET, "/Mono/settings.ini")
	end

function sampev.onPlayerChatBubble(id, color, distance, dur, text)
	if droneActive then -- тут мы меняем дальность действия текста над бошкой и для разрабов при камхаке(дроне) расширяем
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

-- обработка диалогов
function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
	if ndr.v then
		dialogIncoming = dialogId
	end
	if title:find("Авторизация") and text:find("Добро пожаловать") and autologin.v then -- автологин
		sampSendDialogResponse(dialogId, 1, 0, u8:decode(autopass.v))
		return false
	end
	if dialogId == 991 and autopin.v then -- автологин
		sampSendDialogResponse(dialogId, 1, 0, u8:decode(autopasspin.v))
		sampCloseCurrentDialogWithButton(0)
		return false
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
  if idmodel.v then 
	sampfuncsLog(('Textdraw create | id: %d model: %d text: %s x: %.2f y: %.2f'):format(id, data.modelId, data.text, data.position.x, data.position.y))
  end
  if checked_test5.v and active then
    lua_thread.create(function()
      if data.modelId == 19918 then
        wait(111)
        sampSendClickTextdraw(id)
        use = true
      end
      if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use then
        clickID = id + 1
        sampSendClickTextdraw(clickID)
        use = false
        close = true
      end
      if close then
        wait(111)
        sampSendClickTextdraw(2112)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close = false
        active = false
      end
    end)
  end
  if checked_test6.v and active1 then
    lua_thread.create(function()
      if data.modelId == 19613 then
        wait(111)
        sampSendClickTextdraw(id)
        use1 = true
      end
      if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use1 then
        clickID = id + 1
        sampSendClickTextdraw(clickID)
        use1 = false
        close1 = true
      end
      if close1 then
        wait(111)
        sampSendClickTextdraw(2112)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close1 = false
        active1 = false
      end
    end)
  end
  if checked_test7.v and active2 then
    lua_thread.create(function()
      if data.modelId == 1353 then
        wait(111)
        sampSendClickTextdraw(id)
        use2 = true
      end
      if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use2 then
        clickID = id + 1
        sampSendClickTextdraw(clickID)
        use2 = false
        close2 = true
      end
      if close2 then
        wait(111)
        sampSendClickTextdraw(2112)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close2 = false
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
        use4 = true
      end
      if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use4 then 
        clickID = id + 1
        sampSendClickTextdraw(clickID)
		wait(1000)
		sampSendClickTextdraw(2048)
		use4 = false
		close4 = true
	  end
	  if close4 then
        wait(111)
        sampSendClickTextdraw(2112)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
		close4 = false
        active4 = false
		end
	 end)
	end
	if checked_test10.v and active5 then
    lua_thread.create(function()
      if data.modelId == 1733 then
        wait(111)
        sampSendClickTextdraw(id)
        use5 = true
      end
      if data.text == 'USE' or data.text == 'ЕCМOЗТИOЛAПТ' and use5 then
        clickID = id + 1
        sampSendClickTextdraw(clickID)
        use5 = false
        close5 = true
      end
      if close5 then
        wait(111)
        sampSendClickTextdraw(2112)
		wait(111)
		sampCloseCurrentDialogWithButton(1)
		wait(111)
		sampSendClickTextdraw(2135)
        close5 = false
        active5 = false
      end
    end)
  end
	if data.modelId == 1615 and checktochilki then
		if id ~= 2108 and checktochilki then
			sampSendClickTextdraw(id)
			sampSendClickTextdraw(2077)
			checktochilki = false
	else
			sampSendClickTextdraw(2077)
			checktochilki = false
		end
	elseif data.modelId == 16112 and checktochilki1 then
		if id ~= 2108 and checktochilki1 then
			sampSendClickTextdraw(id)
			sampSendClickTextdraw(2077)
			checktochilki1 = false
		else
			sampSendClickTextdraw(2077)
			checktochilki1 = false
		end
	elseif data.modelId == 16112 and checktochilki2 then
		if id ~= 2108 and checktochilki2 then
			sampSendClickTextdraw(id)
			sampSendClickTextdraw(2077)
			checktochilki2 = false
		else
			sampSendClickTextdraw(2077)
			checktochilki2 = false
		end
	elseif data.modelId == 1615 and checktochilki2 then
		if id ~= 2108 and checktochilki2 then
			sampSendClickTextdraw(id)
			sampSendClickTextdraw(2077)
			checktochilki2 = false
	else
			sampSendClickTextdraw(2077)
			checktochilki2 = false
		end
	end
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
	sampSendDialogResponse(33, 1 , 6, -1)
	wait(200)
	sampSendDialogResponse(4498, 1, 0, u8:decode(pay.v))
	wait(100)
	closeDialog()
	end)
end

-- подключение шрифта для работы иконок	

function imgui.ToggleButton(str_id, bool) -- функция хомяка

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

function imgui.OnDrawFrame()
	local tLastKeys = {} -- это у нас для клавиш
	local sw, sh = getScreenResolution() -- получаем разрешение экрана
	local btn_size = imgui.ImVec2(-0.1, 0) -- а это "шаблоны" размеров кнопок
	local btn_size2 = imgui.ImVec2(160, 0)
	local btn_size3 = imgui.ImVec2(140, 0)

	-- тут мы подстраиваем курсор под адекватность
	imgui.ShowCursor = not win_state['informer'].v and not win_state['ass'].v and not win_state['find'].v or win_state['main'].v or win_state['base'].v or win_state['update'].v or win_state['player'].v or win_state['regst'].v or win_state['renew'].v or win_state['leave'].v
	
	if not win_state['main'].v  then 
          imgui.Process = false
       end
	
	if win_state['main'].v then -- основное окошко
		
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(260, 140), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' Mono Tools ', win_state['main'], imgui.WindowFlags.NoResize)
		if imgui.Button(u8' Биндер и Настройки', btn_size) then win_state['settings'].v = not win_state['settings'].v end
		-- информация по скрипту, готово
		if imgui.Button(u8' Помощь', btn_size) then win_state['help'].v = not win_state['help'].v end
		if imgui.Button(u8' Калькулятор', btn_size) then win_state['calc'].v = not win_state['calc'].v end
		imgui.End()
	end
	
	if win_state['settings'].v then -- окно с настройками
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(850, 400), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' Биндер и Настройки', win_state['settings'], imgui.WindowFlags.NoResize + imgui.WindowFlags.MenuBar)
		if imgui.BeginMenuBar() then -- меню бар, используется в виде выпадающего списка, ибо горизонтальный с ума сходит и мерцает при клике по одному из пунктов
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
		end
		if showSet == 1 then -- общие настройки
			if imgui.CollapsingHeader(u8' Модификации') then
				imgui.BeginChild('##as2dasasdf', imgui.ImVec2(750, 125), false)
				imgui.Columns(2, _, false)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" ChatInfo")); imgui.SameLine(); imgui.ToggleButton(u8'ChatInfo', chatInfo)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Эмулятор лаунчера")); imgui.SameLine(); imgui.ToggleButton(u8'Эмулятор лаунчера', launcher); imgui.SameLine(); imgui.TextQuestion(u8"Если включено, то вы сможете открывать сундуки с рулетками, получать увеличенный депозит и 10.000$ в час. После включения данной функций нужно перезайти в игру.")
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Авто Байк и Мото")); imgui.SameLine(); imgui.ToggleButton(u8'Авто Байк и Мото', autobike); imgui.SameLine(); imgui.TextQuestion(u8"Если включено, то вам больше не надо будет нажимать W на велосипеде и не нужно будет нажимать стрелочку на мотоцикле. Просто зажимаете Левый Shift и едите.")
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Запоминание диалогов")); imgui.SameLine(); imgui.ToggleButton(u8'Запоминание диалогов', ndr)
				imgui.NextColumn()
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Чат на клавишу Т")); imgui.SameLine(); imgui.ToggleButton(u8'Чат на клавишу T', keyT)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Авто закрытие дверей(/lock)")); imgui.SameLine(); imgui.ToggleButton(u8'Авто закрытие дверей(/lock)', lock)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Точки в числах")); imgui.SameLine(); imgui.ToggleButton(u8'Точки в числах', toch)
				imgui.EndChild()
			end
			if userNick == 'Bunya_Monopol' then
			if imgui.CollapsingHeader(u8' Для разработки') then
				imgui.BeginChild('##as2dasasdf', imgui.ImVec2(750, 80), false)
				imgui.Columns(2, _, false)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" ID Моделей в Textdraw")); imgui.SameLine(); imgui.ToggleButton(u8'ID Моделей в Textdraw', idmodel)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" ID Textdraw")); imgui.SameLine(); imgui.ToggleButton(u8'ID Textdraw', idtextdraw)
				if idtextdraw.v then
					toggle = not toggle
				end
				imgui.EndChild()
			end
			end
			if imgui.CollapsingHeader(u8' Информер') then
				imgui.BeginChild('##25252', imgui.ImVec2(750, 130), false)
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
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Отображение брони")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение брони', infArmour)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Отображение здоровья")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение здоровья', infHP)
				imgui.NextColumn()
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Отображение города")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение города', infCity)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Отображение района")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение района', infRajon)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Отображение квадрата")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение квадрата', infKv)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Отображение времени")); imgui.SameLine(); imgui.ToggleButton(u8'Отображение времени', infTime)
				imgui.EndChild()
			end
			if imgui.CollapsingHeader(u8' Авторизация') then
				imgui.BeginChild('##asdasasddf', imgui.ImVec2(750, 60), false)
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
	   
			if imgui.CollapsingHeader(u8' Roulette Tools') then
				imgui.BeginChild('##asdasasddf', imgui.ImVec2(800, 160), false)
				imgui.Columns(2, _, false)
				imgui.Checkbox(u8'Открыть бронзовые рулетки', checked_test)
				imgui.Checkbox(u8'Открыть серебряные  рулетки', checked_test2)
				imgui.Checkbox(u8'Открыть золотые рулетки', checked_test3)
				imgui.Checkbox(u8'Открыть платиновые рулетки', checked_test4)
				imgui.NextColumn()
				imgui.Checkbox(u8'Открывать обычный сундук', checked_test5)
				imgui.Checkbox(u8'Открывать донатный сундук', checked_test6)
				imgui.Checkbox(u8'Открывать платиновый сундук', checked_test7)
				imgui.Checkbox(u8'Открывать сундук "Илона Маска"', checked_test10)
				imgui.SliderInt(u8'Задержка',zadervka,1, 30)
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
			if imgui.CollapsingHeader(u8' Bank Menu') then
				imgui.BeginChild('##asdasasddf', imgui.ImVec2(800, 60), false)
				imgui.Columns(2, _, false)
				imgui.AlignTextToFramePadding(); imgui.Text(u8(" Пополнение депозита каждый PD")); imgui.SameLine(); imgui.ToggleButton(u8("Пополнение депозита каждый PD"), autopay)
				if autopay.v then
				imgui.SliderInt(u8"Сумма пополнения", pay, 10000, 5000000)
			end
			imgui.EndChild()
			end
			if imgui.CollapsingHeader(u8' Toch Menu') then
				imgui.BeginChild('##asdasasddf', imgui.ImVec2(800, 100), false)
				imgui.Columns(2, _, false)
				imgui.Checkbox(u8'Камни', checked_box2)
				imgui.SameLine()
				imgui.TextQuestion(u8"Авто-заточка аксессуара камнями(ложить камни на вторую страницу инвентаря)")
				imgui.SameLine()
				imgui.Checkbox(u8'Амулеты', checked_box)
				imgui.SameLine()
				imgui.TextQuestion(u8"Авто-заточка аксессуара амулетами(ложить амулеты на вторую страницу инвентаря)")
				imgui.SameLine()
				imgui.Checkbox(u8'Камни и Амулеты', checked_box3)
				imgui.SameLine()
				imgui.TextQuestion(u8"Авто-заточка аксессуара камнями и амулетами(работает 50/50 и не у всех, тестируйте)")
				imgui.Text(u8'Выберите на сколько будет точиться акс:')
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
	
	if win_state['calc'].v then -- окно "калькулятор"
        imgui.SetNextWindowSize(imgui.ImVec2(340, 340), imgui.Cond.FirstUseEver);
        if not window_pos then
            ScreenX, ScreenY = getScreenResolution()
            imgui.SetNextWindowPos(imgui.ImVec2(ScreenX / 2 , ScreenY / 2), imgui.Cond.FirsUseEver, imgui.ImVec2(0.5, 0.5))
            window_pos = true
        end
		imgui.Begin(u8'Калькулятор', win_state['calc'], imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar);
		imgui.BeginChild('', imgui.ImVec2(300, 280), true);
        imgui.Text(result);
        imgui.Text("       ")
        imgui.SameLine()
        imgui.InputText(u8'', inputBufferText);
		if imgui.Button('7', imgui.ImVec2(40, 40)) then
            inputBufferText.v = string.format('%s7', inputBufferText.v);
        end
		imgui.SameLine();
		if imgui.Button('8', imgui.ImVec2(40, 40)) then
            inputBufferText.v = string.format('%s8', inputBufferText.v);
        end
		 imgui.SameLine();
        if imgui.Button('9', imgui.ImVec2(40, 40)) then
            inputBufferText.v = string.format('%s9', inputBufferText.v);
        end
		imgui.SameLine();
		if imgui.Button('/', imgui.ImVec2(40, 40)) then
			local bufferFirstNum, bufferAct = result:match('(%d+)(.+)');
			if tonumber(bufferFirstNum) then
				local numResult = tonumber(bufferFirstNum) / tonumber(inputBufferText.v);
				result = string.format('%s/', tostring(numResult));
				inputBufferText.v = '';
			else
				result = string.format('%s/', inputBufferText.v);
				inputBufferText.v = '';
			end
		end
		imgui.SameLine();
		if imgui.Button('CLR', imgui.ImVec2(40, 40)) then
            inputBufferText.v = '';
			result = '';
        end
		
		 if imgui.Button('4', imgui.ImVec2(40, 40)) then
            inputBufferText.v = string.format('%s4', inputBufferText.v);
        end
		imgui.SameLine();
		if imgui.Button('5', imgui.ImVec2(40, 40)) then
            inputBufferText.v = string.format('%s5', inputBufferText.v);
        end
		imgui.SameLine();
        if imgui.Button('6', imgui.ImVec2(40, 40)) then
            inputBufferText.v = string.format('%s6', inputBufferText.v);
        end
		imgui.SameLine();
		if imgui.Button('*', imgui.ImVec2(40, 40)) then
			local bufferFirstNum, bufferAct = result:match('(%d+)(.+)');
			if tonumber(bufferFirstNum) then
				local numResult = tonumber(bufferFirstNum) * tonumber(inputBufferText.v);
				result = string.format('%s*', tostring(numResult));
				inputBufferText.v = '';
			else
				result = string.format('%s*', inputBufferText.v);
				inputBufferText.v = '';
			end
        end
		imgui.SameLine();
		if imgui.Button('SQRT', imgui.ImVec2(40, 40)) then
			if tonumber(inputBufferText.v) then
				local bufferResult = math.sqrt(tonumber(inputBufferText.v));
				result = tostring(bufferResult);
			end
		end
		if imgui.Button('1', imgui.ImVec2(40, 40)) then
            inputBufferText.v = string.format('%s1', inputBufferText.v);
        end
		imgui.SameLine();
		if imgui.Button('2', imgui.ImVec2(40, 40)) then
            inputBufferText.v = string.format('%s2', inputBufferText.v);
        end
		imgui.SameLine();
        if imgui.Button('3', imgui.ImVec2(40, 40)) then
            inputBufferText.v = string.format('%s3', inputBufferText.v);
        end
		imgui.SameLine();
		if imgui.Button('-', imgui.ImVec2(40, 40)) then
            local bufferFirstNum, bufferAct = result:match('(%d+)(.+)');
			if tonumber(bufferFirstNum) then
				local numResult = tonumber(bufferFirstNum) - tonumber(inputBufferText.v);
				result = string.format('%s-', tostring(numResult));
				inputBufferText.v = '';
			else
				result = string.format('%s-', inputBufferText.v);
				inputBufferText.v = '';
			end
        end
		imgui.SameLine();
		if imgui.Button('^', imgui.ImVec2(40, 40)) then
			result = string.format('%s^', inputBufferText.v);
			inputBufferText.v = '';
		end
		if imgui.Button('0', imgui.ImVec2(92, 40)) then
            inputBufferText.v = string.format('%s0', inputBufferText.v);
        end
		imgui.SameLine();
		if imgui.Button('+', imgui.ImVec2(40, 40)) then
			local bufferFirstNum, bufferAct = result:match('(%d+)(.+)');
			if tonumber(bufferFirstNum) then
				local numResult = tonumber(bufferFirstNum) + tonumber(inputBufferText.v);
				result = string.format('%s+', tostring(numResult));
				inputBufferText.v = '';
			else
				result = string.format('%s+', inputBufferText.v);
				inputBufferText.v = '';
			end
        end
		imgui.SameLine();
		if imgui.Button('=', imgui.ImVec2(92, 40)) then
			local bufferFirstNum, bufferAct = result:match('(%d+)(.+)');
			if bufferAct == '+' then
				local numResult = tonumber(bufferFirstNum) + tonumber(inputBufferText.v);
				result = tostring(numResult);
			elseif bufferAct == '-' then
				local numResult = tonumber(bufferFirstNum) - tonumber(inputBufferText.v);
				result = tostring(numResult);
			elseif bufferAct == '/' then
				local numResult = tonumber(bufferFirstNum) / tonumber(inputBufferText.v);
				result = tostring(numResult);
			elseif bufferAct == '*' then
				local numResult = tonumber(bufferFirstNum) * tonumber(inputBufferText.v);
				result = tostring(numResult);
			elseif bufferAct == '^' then
				local numResult = tonumber(bufferFirstNum) ^ tonumber(inputBufferText.v);
				result = tostring(numResult);
			end
			inputBufferText.v = '';
        end
		imgui.EndChild();
        imgui.End();
    end
	
	if win_state['help'].v then -- окно "помощь"
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(970, 400), imgui.Cond.FirstUseEver)
		imgui.Begin(u8('Помощь'), win_state['help'], imgui.WindowFlags.NoResize)
		imgui.BeginGroup()
		imgui.BeginChild('left pane', imgui.ImVec2(180, 350), true)
		
		if imgui.Selectable(u8"Команды скрипта") then selected2 = 1 end
		imgui.Separator()
		if imgui.Selectable(u8"Обновления скрипта") then selected2 = 2 end		
		imgui.Separator()
		imgui.EndChild()
		imgui.SameLine()
		imgui.BeginChild('##ddddd', imgui.ImVec2(745, 350), true)
		if selected2 == 0 then
			selected2 = 1
		elseif selected2 == 2 then
		imgui.Text(u8"Обновления")
		imgui.Columns(2, _,false)
		imgui.SetColumnWidth(-1, 800)
		imgui.Separator()
		if imgui.CollapsingHeader(u8' 23.04.2021') then
				imgui.BeginChild('##as2dasasdf', imgui.ImVec2(750, 600), false)
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
				imgui.BeginChild('##as2dasasdf', imgui.ImVec2(750, 600), false)
				imgui.Columns(2, _, false)
				imgui.SetColumnWidth(-1, 800)
				imgui.Text(u8"1. Добавлен автобайк и автомото. Если на вашем сервере он запрещен, то используйте на свой страх и риск.")
				imgui.Text(u8"2. Добавлены точки в числах.")
				imgui.Text(u8"3. Добавлено запоминание диалогов(полезно тем, кто играет со сборки).")
				imgui.Text(u8"4. Вроде бы сделал фикс, что скрипт запускался не с первого раза.")
				imgui.Text(u8"Но если эта проблема осталась или нашли другую, то пишите - https://vk.com/alex_bynes")
				imgui.Text(u8"5. Добавлен калькулятор. /mono - калькулятор.")
		imgui.EndChild()
		end
		elseif selected2 == 1 then
			imgui.Text(u8"Команды скрипта")
			imgui.Separator()
			imgui.Columns(2, _,false)
			imgui.SetColumnWidth(-1, 800)
				imgui.TextColored(imgui.ImVec4(0.80, 0.73 , 0, 1.0), u8"/reload - Перезагрузка скрипта.")
				imgui.TextColored(imgui.ImVec4(0.80, 0.73 , 0, 1.0), u8"/сс - Очистка чата.")
				imgui.TextColored(imgui.ImVec4(0.80, 0.73 , 0, 1.0), u8"/drone - Получить картинку с дрона на территории.")
				imgui.Separator()
				imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Важно! Для того, чтобы все функции скрипта работали стабильно, нужно чтобы инвентарь был на английском языке!")
				imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Настройть язык инвентаря вы можете в /settings. Убедительная просьба не выключать автообновления в коде.")
				imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Иначе вы в будущем не получите улучшения или исправление ошибок. Также, если вы хотите предложить свои идеи")
				imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"по улучшению скрипта, нашли баги или скрипт у вас не работает как должен, то отпишите https://vk.com/alex_bynes.")
		end
		imgui.EndChild()
        imgui.EndGroup()
        imgui.End()
	end
	
	if win_state['informer'].v then -- окно информера

		imgui.SetNextWindowPos(imgui.ImVec2(infoX, infoY), imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(200, 200), imgui.Cond.FirstUseEver)

		imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.0, 0.0, 0.0, 0.3))
		if imgui.Begin("Mono Service", win_state['informer'], imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoSavedSettings) then
			imgui.Text("Mono Tools Services")
			imgui.Separator()
			if infZone.v then imgui.Text(u8("• Зона: "..ZoneText)) end
			if infArmour.v then imgui.Text(u8("• Броня: "..armourNew)) end
			if infHP.v then imgui.Text(u8("• Здоровье: "..healNew)) end
			if infCity.v then imgui.Text(u8("• Город: "..playerCity)) end
			if infRajon.v then imgui.Text(u8("• Район: "..ZoneInGame)) end
			
			if infKv.v then imgui.Text(u8("• Квадрат: "..tostring(locationPos()))) end
			if infTime.v then imgui.Text(u8("• Время: "..os.date("%H:%M:%S"))) end
			imgui.End()
		end
		imgui.PopStyleColor()
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
		-- тут все аналогично, как и с командами, только чуток проще.
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

function split(str, delim, plain) -- функция фипа, которая сделала биндер рабочим
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

function all_trim(s) -- удаление пробелов из строки ес не ошибаюсь
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

function clearSeleListBool(var) -- не ебу что-это ахахах ;D
	for i = 1, #SeleList do
		SeleListBool[i].v = false
	end
	SeleListBool[var].v = true
end

function cmd_color() -- функция получения цвета строки, хз зачем она мне, но когда то юзал
	local text, prefix, color, pcolor = sampGetChatString(99)
	sampAddChatMessage(string.format("Цвет последней строки чата - {934054}[%d] (скопирован в буфер обмена)",color),-1)
	setClipboardText(color)
end

function changeSkin(id, skinId) -- визуальная смена скина(imring вроде бы скидывал ее)
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
	if text:find('Увы, вам не удалось улучшить предмет') and checked_box.v then
		checktochilki = true
		sampSendClickTextdraw(2093)
	end
	if text:find('Успех! Вам удалось улучшить предмет') and checked_box.v then
		number = string.match(text, 'на ++(%d+)')+0
		if number < checked_radio.v and checked_box.v then
			checktochilki = true
			sampSendClickTextdraw(2093)
	end
end
	if text:find('Увы, вам не удалось улучшить предмет') and checked_box2.v then
		checktochilki1 = true
		sampSendClickTextdraw(2093)
	end
	if text:find('Успех! Вам удалось улучшить предмет') and checked_box2.v then
		number = string.match(text, 'на ++(%d+)')+0
		if number < checked_radio.v and checked_box2.v then
			checktochilki1 = true
			sampSendClickTextdraw(2093)
	end
end
	if text:find('Увы, вам не удалось улучшить предмет') and checked_box3.v then
		checktochilki2 = true
		sampSendClickTextdraw(2093)
	end
	if text:find('Успех! Вам удалось улучшить предмет') and checked_box3.v then
		number = string.match(text, 'на ++(%d+)')+0
		if number < checked_radio.v and checked_box3.v then
			checktochilki2 = true
			sampSendClickTextdraw(2093)
		end
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

function sampev.onTextDrawSetString(id, text)
	if toch.v then
		text = separator(text)
		return {id, text}
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
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage(('[Mono Tools]{FFFFFF} Не удалось обновить скрипт! Подробнее узнавайте у Буни. Его вк - https://vk.com/alex_bynes'), 0x046D63)
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
	-- CONFIG CREATE/LOAD
	ini = inicfg.load(SET, getGameDirectory()..'\\moonloader\\config\\Mono\\settings.ini')
	
	-- LOAD CONFIG INFO
	
	gangzones = imgui.ImBool(ini.settings.gangzones)
	zones = imgui.ImBool(ini.settings.zones)
	assistant = imgui.ImBool(ini.settings.assistant)
	
	autologin = imgui.ImBool(ini.settings.autologin)
	autopin = imgui.ImBool(ini.settings.autopin)
	autopay = imgui.ImBool(ini.settings.autopay)
	lock = imgui.ImBool(ini.settings.lock)
	autopass = imgui.ImBuffer(u8(ini.settings.autopass), 256)
	autopasspin = imgui.ImBuffer(u8(ini.settings.autopasspin), 256)
	
	timefix = imgui.ImInt(ini.settings.timefix)
	localskin = imgui.ImInt(ini.settings.skin)
	enableskin = imgui.ImBool(ini.settings.enableskin)
	idmodel = imgui.ImBool(ini.settings.idmodel)
	idtextdraw = imgui.ImBool(ini.settings.idtextdraw)

	infZone = imgui.ImBool(ini.informer.zone)
	infHP = imgui.ImBool(ini.informer.hp)
	infArmour = imgui.ImBool(ini.informer.armour)
	infCity = imgui.ImBool(ini.informer.city)
	infKv = imgui.ImBool(ini.informer.kv)
	infTime = imgui.ImBool(ini.informer.time)
	infRajon = imgui.ImBool(ini.informer.rajon)

	keyT = imgui.ImBool(ini.settings.keyT)
	launcher = imgui.ImBool(ini.settings.launcher)
	ndr = imgui.ImBool(ini.settings.ndr)
	toch = imgui.ImBool(ini.settings.toch)
	autobike = imgui.ImBool(ini.settings.autobike)
	styletest = imgui.ImBool(ini.settings.styletest)
	styletest1 = imgui.ImBool(ini.settings.styletest1)
	styletest2 = imgui.ImBool(ini.settings.styletest2)
	styletest3 = imgui.ImBool(ini.settings.styletest3)
	styletest4 = imgui.ImBool(ini.settings.styletest4)
	styletest5 = imgui.ImBool(ini.settings.styletest5)
	chatInfo = imgui.ImBool(ini.settings.chatInfo)
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

function sampev.onSendClientJoin(Ver, mod, nick, response, authKey, clientver, unk)
	clientver = 'Arizona PC'
	return {Ver, mod, nick, response, authKey, clientver, unk}
end

function showInputHelp() -- chatinfo(для меня) и showinputhelp от хомяка ес не ошибаюсь
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

function getStrByState(keyState) -- состояние клавиш для chatinfo
	if keyState == 0 then
		return "{ffeeaa}Выкл{ffffff}"
	end
	return "{9EC73D}Вкл{ffffff}"
end

function reconnect() -- реконнект игрока
	lua_thread.create(function()
		sampSetGamestate(5)
		sampDisconnectWithReason()
		wait(18000) 
		sampSetGamestate(1)
	end)
end

function drone() -- дрон/камхак, дополнение камхака санька
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

-- ФУНКЦИИ ИЗ ШПОРЫ
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
