local prixmenu = 20

RegisterServerEvent('gabs:menu')
AddEventHandler('gabs:menu', function()
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if(user.money >= prixmenu)then
			user:removeMoney(prixmenu)
		end
	end)
end)
