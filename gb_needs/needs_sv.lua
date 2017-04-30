require "resources/essentialmode/lib/MySQL"
MySQL:open("127.0.0.1", "gta5_gamemode_essential", "root", "gabstheboss")
-- PARAMS
local malusfood = 1
local bonusfood = 99
local maluswater = 2
local bonuswater = 99
local malusneeds = 99
local bonusneeds = 1
local timingsave = 10000
-- CHECK NEEDS
function checkneeds(player)
  local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@name'", {['@name'] = player})
  local result = MySQL:getResults(executed_query, {'food', 'water', 'needs'}, "identifier")
  return tonumber(result[1].food),tonumber(result[1].water),tonumber(result[1].needs)
end
-- UPDATE NEEDS
function updateneeds(player, calories, waterdrops, wc)
  local food, water, needs = table.unpack{checkneeds(player)}
  local new_food = food - calories
  local new_water = water - waterdrops
  local new_needs = needs + wc
  MySQL:executeQuery("UPDATE users SET `food`='@foodvalue', `water`='@watervalue', `needs`='@needsvalue' WHERE identifier = '@identifier'", {['@foodvalue'] = new_food, ['@watervalue'] = new_water, ['@needsvalue'] = new_needs, ['@identifier'] = player})
end
-- SET NEEDS
function setneeds(player, food, water, needs)
  MySQL:executeQuery("UPDATE users SET `food`='@foodvalue', `water`='@watervalue', `needs`='@needsvalue' WHERE identifier = '@identifier'", {['@foodvalue'] = food, ['@watervalue'] = water, ['@needsvalue'] = needs, ['@identifier'] = player})
end
-- FOOD
function addcalories(player, calories)
  local food, water, needs = table.unpack{checkneeds(player)}
  local new_food = food + calories
  MySQL:executeQuery("UPDATE users SET `food`='@value' WHERE identifier = '@identifier'", {['@value'] = new_food, ['@identifier'] = player})
end

function removecalories(player, calories)
  local food, water, needs = table.unpack{checkneeds(player)}
  local new_food = food - calories
  MySQL:executeQuery("UPDATE users SET `food`='@value' WHERE identifier = '@identifier'", {['@value'] = new_food, ['@identifier'] = player})
end

RegisterServerEvent('gabs:removecalories')
AddEventHandler('gabs:removecalories', function(calories)
  TriggerEvent('es:getPlayerFromId', source, function(user)
      local player = user.identifier
      local food, water, needs = table.unpack{checkneeds(player)}
      if(tonumber(malusfood) <= tonumber(food)) then
        removecalories(player, calories)
        local new_food, new_water, new_needs = table.unpack{checkneeds(player)}
        TriggerClientEvent("gabs:setfood", source, new_food)
        TriggerClientEvent("gabs:remove_calories", source, calories)
        CancelEvent()
      else
        TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "Mort de faim")
        CancelEvent()
      end
  end)
end)

RegisterServerEvent('gabs:addcalories')
AddEventHandler('gabs:addcalories', function(calories)
  TriggerEvent('es:getPlayerFromId', source, function(user)
      local player = user.identifier
      local food, water, needs = table.unpack{checkneeds(player)}
      if(tonumber(food) <= tonumber(bonusfood)) then
        addcalories(player, calories)
        local new_food, new_water, new_needs = table.unpack{checkneeds(player)}
        TriggerClientEvent("gabs:setfood", source, new_food)
        TriggerClientEvent("gabs:add_calories", source, calories)
		TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "Miam")
        CancelEvent()
      else
        TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "Pas faim")
        CancelEvent()
      end
  end)
end)
-- WATER
function addwater(player, waterdrops)
  local food, water, needs = table.unpack{checkneeds(player)}
  local new_water = water + waterdrops
  MySQL:executeQuery("UPDATE users SET `water`='@value' WHERE identifier = '@identifier'", {['@value'] = new_water, ['@identifier'] = player})
end

function removewater(player, waterdrops)
  local food, water, needs = table.unpack{checkneeds(player)}
  local new_water = water - waterdrops
  MySQL:executeQuery("UPDATE users SET `water`='@value' WHERE identifier = '@identifier'", {['@value'] = new_water, ['@identifier'] = player})
end

RegisterServerEvent('gabs:removewater')
AddEventHandler('gabs:removewater', function(waterdrops)
  TriggerEvent('es:getPlayerFromId', source, function(user)
      local player = user.identifier
      local food, water, needs = table.unpack{checkneeds(player)}
      if(tonumber(maluswater) <= tonumber(water)) then
        removewater(player, waterdrops)
        local new_food, new_water, new_needs = table.unpack{checkneeds(player)}
        TriggerClientEvent("gabs:setwater", source, new_water)
        TriggerClientEvent("gabs:remove_water", source, waterdrops)
        CancelEvent()
      else
        TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "Mort de soif")
        CancelEvent()
      end
  end)
end)

RegisterServerEvent('gabs:addwater')
AddEventHandler('gabs:addwater', function(waterdrops)
  TriggerEvent('es:getPlayerFromId', source, function(user)
      local player = user.identifier
      local food, water, needs = table.unpack{checkneeds(player)}
      if(tonumber(water) <= tonumber(bonuswater)) then
        addwater(player, waterdrops)
        local new_food, new_water, new_needs = table.unpack{checkneeds(player)}
        TriggerClientEvent("gabs:setwater", source, new_water)
        TriggerClientEvent("gabs:add_water", source, waterdrops)
		TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "Vous avez bu")
        CancelEvent()
      else
        TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "Vous n'avez pas soif")
        CancelEvent()
      end
  end)
end)
-- NEEDS
function addneeds(player, wc)
  local food, water, needs = table.unpack{checkneeds(player)}
  local new_needs = needs + wc
  MySQL:executeQuery("UPDATE users SET `needs`='@value' WHERE identifier = '@identifier'", {['@value'] = new_needs, ['@identifier'] = player})
end

function removeneeds(player, wc)
  local food, water, needs = table.unpack{checkneeds(player)}
  local new_needs = needs - wc
  MySQL:executeQuery("UPDATE users SET `needs`='@value' WHERE identifier = '@identifier'", {['@value'] = new_needs, ['@identifier'] = player})
end

RegisterServerEvent('gabs:removeneeds')
AddEventHandler('gabs:removeneeds', function(wc)
  TriggerEvent('es:getPlayerFromId', source, function(user)
      local player = user.identifier
      local food, water, needs = table.unpack{checkneeds(player)}
      if(tonumber(needs) >= 1) then
        removeneeds(player, wc)
        local new_food, new_water, new_needs = table.unpack{checkneeds(player)}
        TriggerClientEvent("gabs:setneeds", source, new_needs)
        TriggerClientEvent("gabs:remove_needs", source, wc)
		TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "Pipi caca")
        CancelEvent()
      else
        TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "Vous n'avez aucun besoin")
        CancelEvent()
      end
  end)
end)

RegisterServerEvent('gabs:addneeds')
AddEventHandler('gabs:addneeds', function(wc)
  TriggerEvent('es:getPlayerFromId', source, function(user)
      local player = user.identifier
      local food, water, needs = table.unpack{checkneeds(player)}
      if(tonumber(needs) <= tonumber(malusneeds)) then
        addneeds(player, wc)
        local new_food, new_water, new_needs = table.unpack{checkneeds(player)}
        TriggerClientEvent("gabs:setneeds", source, new_needs)
        TriggerClientEvent("gabs:add_needs", source, wc)
        CancelEvent()
      else
        TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "Mort")
        CancelEvent()
      end
  end)
end)

AddEventHandler('es:playerLoaded', function(source)
  TriggerEvent('es:getPlayerFromId', source, function(user)
      local player = user.identifier
      local food, water, needs = table.unpack{checkneeds(player)}
      TriggerClientEvent("gabs:setfood", source, food)
	  TriggerClientEvent("gabs:setwater", source, water)
	  TriggerClientEvent("gabs:setneeds", source, needs)
    end)
end)

local function saveneeds()
	SetTimeout(timingsave, function()
		TriggerEvent("es:getPlayers", function(users)
			for k,v in pairs(users)do
				local player = v.identifier
				local food, water, needs = table.unpack{checkneeds(player)}
				if(tonumber(food) > 1) and (tonumber(water) > 1) and (tonumber(needs) < 99) then
					updateneeds(player, malusfood, maluswater, bonusneeds)
					local new_food, new_water, new_needs = table.unpack{checkneeds(player)}
					TriggerClientEvent("gabs:setfood", source, new_food)
--					TriggerClientEvent("gabs:remove_calories", source, malusfood)
					TriggerClientEvent("gabs:setwater", source, new_water)
--					TriggerClientEvent("gabs:remove_water", source, maluswater)
					TriggerClientEvent("gabs:setneeds", source, new_needs)
--					TriggerClientEvent("gabs:add_needs", source, bonusneeds)
					CancelEvent()
				else
					TriggerClientEvent('es_admin:kill', source)
					setneeds(player, 100, 100, 0)
					TriggerClientEvent("gabs:setfood", source, 100)
					TriggerClientEvent("gabs:setwater", source, 100)
					TriggerClientEvent("gabs:setneeds", source, 0)
--					TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "Mort")
					CancelEvent()
				end
			end
		end)

		saveneeds()
	end)
end

saveneeds()