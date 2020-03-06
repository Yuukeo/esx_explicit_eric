Draw3dtext = function(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
  
	local scale = (1/dist)*1
	local fov = (1/GetGameplayCamFov())*100
	local scale = 1.9
	local factor = (string.len(text)) / 350
   
	if onScreen then
		SetTextScale(0.0*scale, 0.18*scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	    DrawRect(_x,_y+0.0115, 0.01+ factor, 0.025, 25, 25, 25, 185)
	
	end
  end

  drawTxt = function(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - width/2, y - height/2 + 0.005)
end

  sendNotification = function(message, messageType, messageTimeout)
	TriggerEvent("pNotify:SendNotification", {
		text = message,
		type = messageType,
		queue = "kok",
		timeout = messageTimeout,
		layout = "bottomCenter"
	})
end

playAnim = function(animDict, animName, duration)
	RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
    TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 8.0, -8.0, duration, 0, 0, false, false, false)
	RemoveAnimDict(animDict)
end

local fordon = nil

SpawnVehicle = function(vehicle)
	if DoesEntityExist(fordon) then
		DeleteEntity(fordon)
	end
    if not DoesEntityExist(fordon) then
        local model = GetHashKey(vehicle)
        RequestModel(model)

        while not HasModelLoaded(model) do
            Citizen.Wait(1)
        end

        fordon = CreateVehicle(model, Config.VehicleSpawnpoint.x, Config.VehicleSpawnpoint.y, Config.VehicleSpawnpoint.z, Config.VehicleSpawnpoint.h, true, true)

        local props = ESX.Game.GetVehicleProperties(fordon)

        ESX.Game.SetVehicleProperties(fordon, props)
		SetVehicleFuelLevel(fordon, 100.0)
		SetVehicleOilLevel(fordon, 100.0)
		FreezeEntityPosition(fordon, false)
		SetVehicleEngineOn(fordon, true, true, true)
    end
end