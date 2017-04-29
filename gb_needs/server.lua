require "resources/essentialmode/lib/MySQL"
MySQL:open("127.0.0.1", "gta5_gamemode_essential", "root", "gabstheboss")

local malus = 1
local bonus = 100

function checkfood(player)
  local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@name'", {['@name'] = player})
  local result = MySQL:getResults(executed_query, {'food'}, "identifier")
  return tonumber(result[1].food)
end

function addcalories(player, calories)
  local food = checkfood(player)
  local new_food = food + calories
  MySQL:executeQuery("UPDATE users SET `food`='@value' WHERE identifier = '@identifier'", {['@value'] = new_food, ['@identifier'] = player})
end

function removecalories(player, calories)
  local food = checkfood(player)
  local new_food = food - calories
  MySQL:executeQuery("UPDATE users SET `food`='@value' WHERE identifier = '@identifier'", {['@value'] = new_food, ['@identifier'] = player})
end

RegisterServerEvent('gabs:removecalories')
AddEventHandler('gabs:removecalories', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
      local player = user.identifier
      local food = checkfood(player)
      if(tonumber(malus) <= tonumber(food)) then
        removecalories(player, malus)
        local new_food = checkfood(player)
        TriggerClientEvent("gabs:setfood", source, new_food)
        TriggerClientEvent("gabs:remove_calories", source, malus)
        CancelEvent()
      else
        TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Not enough money in account!^0")
        CancelEvent()
      end
  end)
end)

RegisterServerEvent('gabs:addcalories')
AddEventHandler('gabs:addcalories', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
      local player = user.identifier
      local food = checkfood(player)
      if(tonumber(food) <= tonumber(bonus)) then
        addcalories(player, bonus)
        local new_food = checkfood(player)
        TriggerClientEvent("gabs:setfood", source, new_food)
        TriggerClientEvent("gabs:add_calories", source, bonus)
        CancelEvent()
      else
        TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "OK")
        CancelEvent()
      end
  end)
end)

AddEventHandler('es:playerLoaded', function(source)
  TriggerEvent('es:getPlayerFromId', source, function(user)
      local player = user.identifier
      local food = checkfood(player)
      TriggerClientEvent("gabs:setfood", source, food)
    end)
end)

local function savefood()
	SetTimeout(10000, function()
		TriggerEvent("es:getPlayers", function(users)
			for k,v in pairs(users)do
				local player = v.identifier
				local food = checkfood(player)
				if(tonumber(malus) <= tonumber(food)) then
					removecalories(player, malus)
					local new_food = checkfood(player)
					TriggerClientEvent("gabs:setfood", source, new_food)
					TriggerClientEvent("gabs:remove_calories", source, malus)
					CancelEvent()
				else
					TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Not enough money in account!^0")
					CancelEvent()
				end
			end
		end)

		savefood()
	end)
end

savefood()