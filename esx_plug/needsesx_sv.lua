--METTRE DANS LE DOSSIER "es_extended".
--CECI EST UN EXEMPLE (JAMAIS TESTE)

require "resources/essentialmode/lib/MySQL"
MySQL:open("127.0.0.1", "gta5_gamemode_essential", "root", "monpasse")

RegisterServerEvent('gabs:eatesxitem')
AddEventHandler('gabs:eatesxitem', function(item, count)
	local executed_query = MySQL:executeQuery("SELECT * FROM items WHERE `name` = @foodname", {['@foodname'] = tonumber(item)})
	local result = MySQL:getResults(executed_query, { 'food', 'water', 'needs' }, "name")
	if (tonumber(result[1].food) + tonumber(result[1].water) + tonumber(result[1].needs) > 0) then
		local _source = source
		if count == nil or count <= 0 then
			TriggerClientEvent('esx:showNotification', _source, 'Quantité invalide')
		else
			TriggerEvent('esx:getPlayerFromId', source, function(xPlayer)
				local foundItem = nil
				for i=1, #xPlayer.inventory, 1 do
					if xPlayer.inventory[i].item == item then
						foundItem = xPlayer.inventory[i]
					end
				end
				if count > foundItem.count then
					TriggerClientEvent('esx:showNotification', _source, 'Quantité invalide')
				else
					local remainingCount = xPlayer:getInventoryItem(item).count
					local total = count
					if remainingCount < count then
						total = remainingCount
					end
					if total > 0 then
						xPlayer:removeInventoryItem(item, total)
						TriggerEvent('gabs:addcustomneeds', source, tonumber(result[1].food),tonumber(result[1].water),tonumber(result[1].needs))
						TriggerClientEvent('esx:showNotification', _source, 'Vous avez avalé ' .. foundItem.label .. ' x' .. total)
					end
				end
			end)
		end
	end
end)
