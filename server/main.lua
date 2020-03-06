ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("esx_explicit_quest:giveitem")
AddEventHandler("esx_explicit_quest:giveitem", function(caution)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local limit = xPlayer.getInventoryItem('dokument').limit
  local qtty = xPlayer.getInventoryItem('dokument').count
  local limit = 1
  if qtty < limit then
    xPlayer.addInventoryItem('dokument', 1)     
  end
end)

RegisterServerEvent("esx_explicit_quest:removeitem")
AddEventHandler("esx_explicit_quest:removeitem", function(caution)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem('dokument').count
  
	if item > 0 then
	  xPlayer.removeInventoryItem('dokument', item)
	 end
  end)


  function getIdentity(source, callback)
    local identifier = GetPlayerIdentifiers(source)[1]
    MySQL.Async.fetchAll("SELECT identifier, name, firstname, lastname, dateofbirth, sex, height, lastdigits FROM `users` WHERE `identifier` = @identifier",
    {
      ['@identifier'] = identifier
    },
    function(result)
      if result[1].firstname ~= nil then
        local data = {
          identifier  = result[1].identifier,
          name = result[1].name,
          firstname  = result[1].firstname,
          lastname  = result[1].lastname,
          dateofbirth  = result[1].dateofbirth,
          sex      = result[1].sex,
          height    = result[1].height,
          lastdigits = result[1].lastdigits
        }
        callback(data)
      else
        local data = {
          identifier   = '',
          name = '',
          firstname   = '',
          lastname   = '',
          dateofbirth = '',
          sex     = '',
          height     = ''
        }
        callback(data)
      end
    end)
  end

RegisterServerEvent('esx_explicit_quest:GiveMoney')
AddEventHandler('esx_explicit_quest:GiveMoney', function(money)
  local xPlayer = ESX.GetPlayerFromId(source)
  getIdentity(source, function( data )
  	print(data.firstname .. ' ' .. data.lastname .. ' [' .. data.name .. '] gjorde klart Erics uppdrag. Fick en belöning på '.. money .. 'kr')
  end)
    
  xPlayer.addMoney(money)
end)