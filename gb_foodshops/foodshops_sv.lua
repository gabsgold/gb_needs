local wc = 100

RegisterServerEvent('gabs:menu')
AddEventHandler('gabs:menu', function(fooditem)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		for k,v in ipairs(fooditems) do
			if (v.name == fooditem) then
				if (user.money >= v.price) then
					user:removeMoney(v.price)
					TriggerEvent('gabs:addcustomneeds', source, v.food, v.water, v.needs)
					if (v.food == 0) then
						TriggerClientEvent("gabs:drink", source)
					else
						TriggerClientEvent("gabs:eat", source)
					end
				end
			end
		end
	end)
end)

AddEventHandler('chatMessage', function(source, name, message)
	if(message:sub(1,1) == "/") then
		local args = splitString(message, " ")
		local cmd = args[1]
		if (cmd == "/pipi") then
			CancelEvent()
			TriggerEvent('gabs:removeneeds', source, wc)
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