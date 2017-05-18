Menu = {}
Menu.GUI = {}
Menu.TitleGUI = {}
Menu.buttonCount = 0
Menu.titleCount = 0
Menu.selection = 0
Menu.hidden = true
MenuTitle = "Menu"
-------------------
posXMenu = 0.1
posYMenu = 0.05
width = 0.15
height = 0.05
posXMenuTitle = 0.1
posYMenuTitle = 0.05
widthMenuTitle = 0.1
heightMenuTitle = 0.05
-------------------
function Menu.addTitle(name)
	local yoffset = 0.3
	local xoffset = 0
	local xmin = posXMenuTitle
	local ymin = posYMenuTitle
	local xmax = widthMenuTitle
	local ymax = heightMenuTitle
	Menu.TitleGUI[Menu.titleCount +1] = {}
	Menu.TitleGUI[Menu.titleCount +1]["name"] = name
	Menu.TitleGUI[Menu.titleCount+1]["xmin"] = xmin + xoffset
	Menu.TitleGUI[Menu.titleCount+1]["ymin"] = ymin * (Menu.titleCount + 0.01) +yoffset
	Menu.TitleGUI[Menu.titleCount+1]["xmax"] = xmax 
	Menu.TitleGUI[Menu.titleCount+1]["ymax"] = ymax 
	Menu.titleCount = Menu.titleCount+1
end

function Menu.addButton(name, func,args)
	local yoffset = 0.3
	local xoffset = 0
	local xmin = posXMenu
	local ymin = posYMenu
	local xmax = width
	local ymax = height
	Menu.GUI[Menu.buttonCount +1] = {}
	Menu.GUI[Menu.buttonCount +1]["name"] = name
	Menu.GUI[Menu.buttonCount+1]["func"] = func
	Menu.GUI[Menu.buttonCount+1]["args"] = args
	Menu.GUI[Menu.buttonCount+1]["active"] = false
	Menu.GUI[Menu.buttonCount+1]["xmin"] = xmin + xoffset
	Menu.GUI[Menu.buttonCount+1]["ymin"] = ymin * (Menu.buttonCount + 0.01) +yoffset
	Menu.GUI[Menu.buttonCount+1]["xmax"] = xmax 
	Menu.GUI[Menu.buttonCount+1]["ymax"] = ymax 
	Menu.buttonCount = Menu.buttonCount+1
end

function Menu.updateSelection() 
	if IsControlJustPressed(1, 8) then --RECULER
		if(Menu.selection < Menu.buttonCount -1  )then
			Menu.selection = Menu.selection +1
		else
			Menu.selection = 0
		end
	elseif IsControlJustPressed(1, 32) then --AVANCER
		if(Menu.selection > 0)then
			Menu.selection = Menu.selection -1
		else
			Menu.selection = Menu.buttonCount-1
		end
	elseif IsControlJustPressed(1, 201)  then --ENTREE
			MenuCallFunction(Menu.GUI[Menu.selection +1]["func"], Menu.GUI[Menu.selection +1]["args"])
	end
	local iterator = 0
	for id, settings in ipairs(Menu.GUI) do
		Menu.GUI[id]["active"] = false
		if(iterator == Menu.selection ) then
			Menu.GUI[iterator +1]["active"] = true
		end
		iterator = iterator +1
	end
end

function Menu.renderGUI()
	if not Menu.hidden then
		Menu.renderTitle()
		Menu.renderButtons()
		Menu.updateSelection()
	end
end

function Menu.renderBox(xMin,xMax,yMin,yMax,color1,color2,color3,color4)
	DrawRect(xMin, yMin,xMax, yMax, color1, color2, color3, color4);
end

function Menu.renderTitle()
	local yoffset = 0.3
	local xoffset = 0
	local xmin = posXMenuTitle
	local ymin = posYMenuTitle
	local xmax = widthMenuTitle
	local ymax = heightMenuTitle
	for id, settings in pairs(Menu.TitleGUI) do
		local screen_w = 0
		local screen_h = 0
		screen_w, screen_h =  GetScreenResolution(0, 0)
		boxColor = {0,0,0,128}
		SetTextFont(0)
		SetTextScale(0.0,0.35)
		SetTextColour(255, 255, 255, 255)
		SetTextCentre(true)
		SetTextDropShadow(0, 0, 0, 0, 0)
		SetTextEdge(0, 0, 0, 0, 0)
		SetTextEntry("STRING") 
		AddTextComponentString(string.upper(settings["name"]))
		DrawText(settings["xmin"], (settings["ymin"] - heightMenuTitle - 0.0125))
		Menu.renderBox(settings["xmin"] ,settings["xmax"], settings["ymin"] - heightMenuTitle, settings["ymax"],boxColor[1],boxColor[2],boxColor[3],boxColor[4])
	end	
end

function Menu.renderButtons()
	for id, settings in pairs(Menu.GUI) do
		local screen_w = 0
		local screen_h = 0
		screen_w, screen_h =  GetScreenResolution(0, 0)
		boxColor = {128,128,128,128}
		if(settings["active"]) then
			boxColor = {38,38,38,255}
		end
		SetTextFont(0)
		SetTextScale(0.0,0.35)
		SetTextColour(255, 255, 255, 255)
		SetTextCentre(true)
		SetTextDropShadow(0, 0, 0, 0, 0)
		SetTextEdge(0, 0, 0, 0, 0)
		SetTextEntry("STRING") 
		AddTextComponentString(settings["name"])
		DrawText(settings["xmin"], (settings["ymin"] - 0.0125 )) 
		Menu.renderBox(settings["xmin"] ,settings["xmax"], settings["ymin"], settings["ymax"],boxColor[1],boxColor[2],boxColor[3],boxColor[4])
	 end     
end
--------------------------------------------------------------------------------------------------------------------
function ClearMenu()
	--Menu = {}
	Menu.GUI = {}
	Menu.buttonCount = 0
	Menu.titleCount = 0
	Menu.selection = 0
end

function MenuCallFunction(fnc, arg)
	_G[fnc](arg)
end
--------------------------------------------------------------------------------------------------------------------
function Texte(_texte, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(_texte)
	DrawSubtitleTimed(showtime, 1)
end
--------------------------------------------------------------------------------------------------------------------
local vdkinventory = false
function ShopMenu()
	ClearMenu()
	if (vdkinventory == false) then
		Menu.addTitle("MENU")
		Menu.addButton("Burger","buymenu",'Burger')
		Menu.addButton("Cola","buymenu",'Cola')
		Menu.addButton("Water","buymenu",'Water')
		Menu.addButton("Snack","buymenu",'Snack')
		Menu.addButton("Fries","buymenu",'Fries')
		Menu.addButton("Apple","buymenu",'Apple')
		Menu.addButton("Orange","buymenu",'Orange')
	else
		Menu.addTitle("MENU")
		Menu.addButton("Sandwich","buymenu",{ 30, 1, 200 })
		Menu.addButton("Cola","buymenu",{ 31, 1, 123 })
--		Menu.addButton("FoodName","buymenu",{ itemId, qty, price }) -- itemId = id de l'item vdk (Table : items), qty = quantité et price = prix
	end
end

function buymenu(fooditem)
	if (vdkinventory == false) then
		Texte("Vous avez mangé un(e) ~g~".. fooditem, 5000)
		TriggerServerEvent('gabs:menu', fooditem, vdkinventory)
	else
		local itemId = fooditem[1]
		local qty = fooditem[2]
		local price = fooditem[3]
		TriggerServerEvent('gabs:menu', {fooditem[1], fooditem[2], fooditem[3]}, vdkinventory)
	end
end