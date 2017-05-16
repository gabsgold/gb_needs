--METTRE DANS LE DOSSIER "vdk_inventory".

function eatvdk(arg)
    local itemId = tonumber(arg[1])
    local qty = arg[2]
    local item = ITEMS[itemId]
    item.quantity = item.quantity - qty
    TriggerServerEvent("gabs:eatvdkitem", item.quantity, itemId)
    InventoryMenu()
end

--REMPLACER LA FONCTION "ItemMenu(itemId)" DANS LE FICHIER "vdkinv.lua" PAR CELLE-CI OU AJOUTER LE BOUTON "Utiliser" :
-- function ItemMenu(itemId)
    -- MenuTitle = "Details:"
    -- ClearMenu()
    -- Menu.addButton("Supprimer", "delete", { itemId, 1 })
    -- Menu.addButton("Donner", "give", itemId)
	-- Menu.addButton("Utiliser", "eatvdk", { itemId, 1 }) -- <-- BOUTON "Utiliser"
-- end

--AJOUTER "server_script 'needsvdk_sv.lua'" ET "client_script 'needsvdk_cl.lua'" DANS LE FICHIER "__resource.lua" DE "vdk_inventory".
--EXEMPLE :
-- server_scripts {
	-- 'config.lua',
	-- 'server.lua',
	-- 'needsvdk_sv.lua'
-- }
-- client_script {
	-- 'vdkinv.lua',
	-- 'GUI.lua',
	-- 'needsvdk_cl.lua'
-- }

-- export 'getQuantity'
-- export 'notFull'

-------------------------------------------------------------
--DEV TEST A SUPPRIMER
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 11) then --PAGEDOWN
			TriggerEvent('player:receiveItem',30, 1)
			TriggerEvent('player:receiveItem',31, 1)
        end
    end
end)
------------------------------------------------------------