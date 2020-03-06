local coords = {
  {-470.57, 6290.65, 13.61-0.95,"Quest",146.62,0x5CDEF405,"mp_m_fibsec_01"}
}


Citizen.CreateThread(function()

  for _,v in pairs(coords) do
    RequestModel(GetHashKey(v[7]))
    while not HasModelLoaded(GetHashKey(v[7])) do
      Wait(1)
    end

    RequestAnimDict("mini@strip_club@idles@bouncer@base")
    while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
      Wait(1)
    end
    ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
    SetEntityHeading(ped, v[5])
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
  end
end)