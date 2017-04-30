-- FOOD
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
-- WATER
RegisterNetEvent('gabs:setwater')
AddEventHandler('gabs:setwater', function(water)
  local id = PlayerId()
  local playerName = GetPlayerName(id)
	SendNUIMessage({
		setwater = true,
		water = water,
    player = playerName
	})
end)

RegisterNetEvent("gabs:add_water")
AddEventHandler("gabs:add_water", function(waterdrops)
	SendNUIMessage({
		addwater = true,
		waterdrops = waterdrops
	})

end)

RegisterNetEvent("gabs:remove_water")
AddEventHandler("gabs:remove_water", function(waterdrops)
	SendNUIMessage({
		removewater = true,
		waterdrops = waterdrops
	})
end)
-- NEEDS
RegisterNetEvent('gabs:setneeds')
AddEventHandler('gabs:setneeds', function(needs)
  local id = PlayerId()
  local playerName = GetPlayerName(id)
	SendNUIMessage({
		setneeds = true,
		needs = needs,
    player = playerName
	})
end)

RegisterNetEvent("gabs:add_needs")
AddEventHandler("gabs:add_needs", function(wc)
	SendNUIMessage({
		addneeds = true,
		wc = wc
	})

end)

RegisterNetEvent("gabs:remove_needs")
AddEventHandler("gabs:remove_needs", function(wc)
	SendNUIMessage({
		removeneeds = true,
		wc = wc
	})
end)