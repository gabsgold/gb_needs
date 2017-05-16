--METTRE DANS LE DOSSIER "vdk_inventory".

require "resources/essentialmode/lib/MySQL"
MySQL:open("127.0.0.1", "gta5_gamemode_essential", "root", "monpasse")

RegisterServerEvent("gabs:eatvdkitem")
AddEventHandler("gabs:eatvdkitem", function(qty, id)
    local player = getPlayerID(source)
	local executed_query = MySQL:executeQuery("SELECT * FROM items WHERE `id` = @foodid", {['@foodid'] = tonumber(id)})
	local result = MySQL:getResults(executed_query, { 'food', 'water', 'needs' }, "id")
	if (tonumber(result[1].food) + tonumber(result[1].water) + tonumber(result[1].needs) > 0) then
		MySQL:executeQuery("UPDATE user_inventory SET `quantity` = @qty WHERE `user_id` = '@username' AND `item_id` = @id", { ['@username'] = player, ['@qty'] = tonumber(qty), ['@id'] = tonumber(id) })
		TriggerEvent('gabs:addcustomneeds', source, tonumber(result[1].food),tonumber(result[1].water),tonumber(result[1].needs))
	end
end)

function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end