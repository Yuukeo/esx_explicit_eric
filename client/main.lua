ESX = nil
local hasdonemisson   = false
local doingmission = false
local doneforday = false
local hasMC = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

local locations = {
	{ x = -471.26, y = 6289.04, z = 13.61},
  }

  local donelocations = {
	{ x = -471.26, y = 6289.04, z = 13.61},
  }

  local dokumentlocations = {
	{ x = 432.68, y = -981.89, z = 26.67},
  }

  local MClocation = {
	{ x = -479.02, y = 6295.98, z = 13.53},
  }


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		if hasdonemisson == false then
		    if doneforday == false then
		     if doingmission == false then	
			    for k, v in pairs(locations) do
				if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance) then
				DrawMarker(6, v.x, v.y, v.z-0.95, 0, 0, 0.1, 0, 0, 0, 1.5, 1.5, 1.5, 0, 205, 100, 200, 0, 0, 0, 0)
				Draw3dtext(v.x, v.y, v.z+0.17, 'Tryck ~g~E~w~ för att snacka med ~b~Eric')

				if IsControlJustReleased(0, 38) then
					playAnim('oddjobs@assassinate@construction@', 'unarmed_fold_arms', 17500)
					TriggerEvent('malte-cinema:activate')
					TriggerServerEvent("InteractSound_SV:PlayOnSource", "ericstart", 1.0)
					Citizen.Wait(16000)
					TriggerEvent('malte-cinema:activate')
					OpenMenu()
				end
			 end
		  end
		end
	  end
    end
  end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		
		if hasdonemisson == true then
			drawTxt(0.92, 1.404, 1.0, 1.0, 0.4, "Ta dig tillbaka till ~b~Eric!", 255, 255, 255, 255)
			if doneforday == false then
				for k, v in pairs(donelocations) do
				if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance) then
				DrawMarker(6, v.x, v.y, v.z-0.95, 0, 0, 0.1, 0, 0, 0, 1.5, 1.5, 1.5, 0, 205, 100, 200, 0, 0, 0, 0)
				Draw3dtext(v.x, v.y, v.z+0.17, 'Tryck ~g~E~w~ för att ta emot din ~b~belöning')

				if IsControlJustReleased(0, 38) then
					playAnim('oddjobs@assassinate@construction@', 'unarmed_fold_arms', 2500)
					TriggerEvent('malte-cinema:activate')
					TriggerServerEvent("InteractSound_SV:PlayOnSource", "ericslut", 1.0)
					Citizen.Wait(9000)
					TriggerEvent('malte-cinema:activate')
					TriggerServerEvent('esx_explicit_quest:GiveMoney', 5000)
					sendNotification("Du fick 5000 SEK:", "error", 6000)
					ClearPedTasks(ped)
					TriggerServerEvent("esx_explicit_quest:removeitem")
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
						TriggerEvent('skinchanger:loadSkin', skin)
					end)
					hasdonemisson = false
					doneforday = true
			end
		  end
		end
	  end
	end
  end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		
		if doingmission == true then
			drawTxt(0.85, 1.404, 1.0, 1.0, 0.4, "Ta dig till ~b~Polisstationen~w~ och bryt dig in!", 255, 255, 255, 255)
				for k, v in pairs(dokumentlocations) do
				if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 10) then
				DrawMarker(6, v.x, v.y, v.z-0.95, 0, 0, 0.1, 0, 0, 0, 1.5, 1.5, 1.5, 0, 205, 100, 200, 0, 0, 0, 0)
				Draw3dtext(v.x, v.y, v.z+0.17, 'Tryck ~g~E~w~ för att rota efter ~b~dokumentet')

				if IsControlJustReleased(0, 38) then
				TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
				Citizen.Wait(15000)
				ClearPedTasks(ped)
				TriggerServerEvent("esx_explicit_quest:giveitem")
				sendNotification("Du hittade dokumentet ta dig nu tillbaka till Eric och ge han dokumentet för att sedan få din belöning", "error", 4000)
				TriggerEvent('waypoint')
				hasdonemisson = true
				doingmission = false
			end
		end
	  end
	end
  end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		
		if hasMC == true then
		if doneforday == false then	
				for k, v in pairs(MClocation) do
				if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 10) then
				DrawMarker(Config.Type, v.x, v.y, v.z-0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
				Draw3dtext(v.x, v.y, v.z+0.17, 'Tryck ~g~E~w~ för att lämna in Motorcykeln')
				if IsControlJustReleased(0, 38) then
				TriggerEvent('esx:deleteVehicle')
				hasMC = false
			end
		  end
		end
	  end
	end
  end
end)


function OpenMenu()

	ESX.UI.Menu.CloseAll()
  
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'eric',
	  {
		title    = 'Erics Uppdrag',
		align    = 'center',
		elements = {
	  {label = 'Tacka ja till uppdraget', value = 'yes'},
	  {label = 'Tacka nej til uppdraget', value = 'no'},
		},
	  },
	  function(data, menu)
	  
		if data.current.value == 'no' then
  
		  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
			TriggerEvent('skinchanger:loadSkin', skin)
			menu.close()
			sendNotification('Vafan är du feg eller detta ska jag säga till folk eller du kanske vill ändra dig?', 'error', 10000)
			doneforday = true
		  end)
		end
		
		if data.current.value == 'yes' then
			menu.close()
			TriggerEvent('skinchanger:getSkin', function(skin)
			  if skin.sex == 0 then
				playAnim('oddjobs@basejump@ig_15', 'puton_parachute', 2500)
				Citizen.Wait(3000)
				TriggerEvent('skinchanger:loadClothes', skin, Config.uppdragsWear.male)
				Citizen.Wait(1000)
				OpenVehicleMenu()
			  else
				playAnim('oddjobs@basejump@ig_15', 'puton_parachute', 2500)
				Citizen.Wait(3000)
				TriggerEvent('skinchanger:loadClothes', skin, Config.uppdragsWear.female)
				Citizen.Wait(1000)
				OpenVehicleMenu()
			  end
			end)
		  end
	  end,
	  function(data, menu)
		menu.close()
	  end
	)
  end


  function OpenVehicleMenu()

	ESX.UI.Menu.CloseAll()
  
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'fordo',
	  {
		title    = 'Behöver du låna ett fordon?',
		align    = 'center',
		elements = {
	  {label = 'Jag behöver låna ett fordon tack', value = 'yes'},
	  {label = 'Nej jag har en egen bil', value = 'no'},
		},
	  },
	  function(data, menu)
	  
		if data.current.value == 'no' then
			menu.close()
			doingmission = true
		end
		
		if data.current.value == 'yes' then
			menu.close()
			SpawnVehicle('akuma')
			hasMC = true
			doingmission = true
		  end
	  end,
	  function(data, menu)
		menu.close()
	  end
	)
  end

RegisterNetEvent('waypoint')
AddEventHandler('waypoint', function()
    SetNewWaypoint(-470.49, 6290.74)
end)

Citizen.CreateThread(function()
	if Config.EnableBlips then
		for k, v in pairs(locations) do
			local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite(blip, 456)
			SetBlipScale(blip, 0.8)
			SetBlipColour(blip, 38)
			SetBlipDisplay(blip, 4)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("")
			EndTextCommandSetBlipName(blip)
		end
	end
end)