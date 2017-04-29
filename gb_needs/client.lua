Citizen.CreateThread(function ()
	while true do
	Citizen.Wait(15000)
		TriggerServerEvent('gabs:addcalories')
	end
end)

RegisterNetEvent('gabs:setfood')
AddEventHandler('gabs:setfood', function(food)
  local id = PlayerId()
  local playerName = GetPlayerName(id)
	SendNUIMessage({
		setfood = true,
		food = food,
    player = playerName
	})
end)

RegisterNetEvent("gabs:add_calories")
AddEventHandler("gabs:add_calories", function(calories)
	SendNUIMessage({
		addcalories = true,
		calories = calories
	})

end)

RegisterNetEvent("gabs:remove_calories")
AddEventHandler("gabs:remove_calories", function(calories)
	SendNUIMessage({
		removecalories = true,
		calories = calories
	})
end)