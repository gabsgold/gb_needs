# gb_needs
Dependencies = ESSENTIALMODE

#How to :
Créer les colonnes "food" (valeur par défaut DOUBLE 100), "water" (valeur par défaut DOUBLE 100) et "needs" (valeur par défaut DOUBLE 0) dans la table "users"

#Ajoute un certain nombre de "calories" :

TriggerServerEvent('gabs:addcalories', calories)

#Ajoute un certain nombre de "waterdrops" :

TriggerServerEvent('gabs:addwater', waterdrops)

#Enlève un certain nombre de "wc" :

TriggerServerEvent('gabs:removeneeds', wc)

#Ajoute un certain nombre à toutes les variables (sans animation) :

TriggerServerEvent('gabs:addcustomneeds', calories, waterdrops, wc)

#Toutes les valeurs par défaut :

TriggerServerEvent('gabs:setdefaultneeds')

#Build 01.05.2017
