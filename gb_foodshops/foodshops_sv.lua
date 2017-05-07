local prixmenu = 20
local wc = 100

RegisterServerEvent('gabs:menu')
AddEventHandler('gabs:menu', function()
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if(user.money >= prixmenu)then
			user:removeMoney(prixmenu)
		end
	end)
end)

AddEventHandler('chatMessage', function(source, name, message)
	if(message:sub(1,1) == "/") then
		local args = splitString(message, " ")
		local cmd = args[1]
		if (cmd == "/pipi") then
			CancelEvent()
			TriggerClientEvent("gabs:remneeds", source, wc)
		end
	end
end)

function splitString(self, delimiter)
	local words = self:Split(delimiter)
	local output = {}
	for i = 0, #words - 1 do
		table.insert(output, words[i])
	end

	return output
end