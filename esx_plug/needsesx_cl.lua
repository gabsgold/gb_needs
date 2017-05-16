--METTRE DANS LE DOSSIER "es_extended" ET MODIFIER L'UI POUR Y AJOUTER LE BOUTON "UTILISER".
--CECI EST UN EXEMPLE (JAMAIS TESTE)

RegisterNUICallback('eat_inventory_item', function(data, cb)
	local count = tonumber(data.count)
	if count == nil then
		TriggerEvent('esx:showNotification', 'Quantité invalide')
	else
		TriggerServerEvent('gabs:eatesxitem', data.item, data.count)
	end
	SendNUIMessage({
		showRemoveInventoryItem = false
	})
	GUI.RemoveInventoryItemIsShowed = false
	SetNuiFocus(false)
	TriggerServerEvent('esx:requestPlayerDataForGUI')
	cb('ok')
end)