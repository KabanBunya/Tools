script_author("Vespan")

name = nil

function main()
    if not isSampLoaded() and not isSampfuncsLoaded() then return end 
    while not isSampAvailable() do wait(0) end

	--sampRegisterChatCommand('1', function() script.load('moonloader/' .. name) end)

	while true do wait(0)

	end
end

function EXPORTS.crash()

	script.load('moonloader/' .. name)

end

function EXPORTS.getfilename() 

	for i, s in pairs(script.list()) do
		if s.name == 'Mono Tools' then 
			name = s.filename -- получаем название скрипта.lua,даже если название будет изменено
		end
	end

end