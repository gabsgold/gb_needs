# gb_needs
Dependencies = ESSENTIALMODE

#How to :
Créer les colonnes "food" (valeur par défaut DOUBLE 100), "water" (valeur par défaut DOUBLE 100) et "needs" (valeur par défaut DOUBLE 0) dans la table "users"

#Ajoute un certain nombre de "calories" :

TriggerEvent('gabs:addcalories', source, calories)

TriggerServerEvent('gabs:addcalories', source, calories)

#Ajoute un certain nombre de "waterdrops" :

TriggerEvent('gabs:addwater', source, waterdrops)

TriggerServerEvent('gabs:addwater', source, waterdrops)

#Enlève un certain nombre de "wc" :

TriggerEvent('gabs:removeneeds', source, wc)

TriggerServerEvent('gabs:removeneeds', source, wc)

#Commands = /boire /manger /pipi

Build 30.04.2017
