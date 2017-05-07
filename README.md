# gb_needs
Dependencies = ESSENTIALMODE

#How to :
Créer les colonnes "food" (valeur par défaut DOUBLE 100), "water" (valeur par défaut DOUBLE 100) et "needs" (valeur par défaut DOUBLE 0) dans la table "users"

#Ajoute un certain nombre de "calories" :

TriggerEvent('gabs:addcalories', source, calories)

#Ajoute un certain nombre de "waterdrops" :

TriggerEvent('gabs:addwater', source, waterdrops)

#Enlève un certain nombre de "wc" :

TriggerEvent('gabs:removeneeds', source, wc)

#Ajoute un certain nombre à toutes les variables (sans animation) :

TriggerEvent('gabs:addcustomneeds', source, calories, waterdrops, wc)

#Toutes les valeurs par défaut (appel client):

TriggerServerEvent('gabs:setdefaultneeds')

#Build 01.05.2017
