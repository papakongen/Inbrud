--██████╗░░█████╗░██████╗░░█████╗░██╗░░██╗░█████╗░███╗░░██╗░██████╗░███████╗███╗░░██╗
--██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║░██╔╝██╔══██╗████╗░██║██╔════╝░██╔════╝████╗░██║
--██████╔╝███████║██████╔╝███████║█████═╝░██║░░██║██╔██╗██║██║░░██╗░█████╗░░██╔██╗██║
--██╔═══╝░██╔══██║██╔═══╝░██╔══██║██╔═██╗░██║░░██║██║╚████║██║░░╚██╗██╔══╝░░██║╚████║
--██║░░░░░██║░░██║██║░░░░░██║░░██║██║░╚██╗╚█████╔╝██║░╚███║╚██████╔╝███████╗██║░╚███║
--╚═╝░░░░░╚═╝░░╚═╝╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚══╝░╚═════╝░╚══════╝╚═╝░░╚══╝

vRP = Proxy.getInterface("vRP")

local roubando = false
local cofre = false
local vault = nil
local list = {}
local homeName = ""

local houses = {
	['Farfetch'] = { 
		['enter'] = { ['x'] = -106.98, ['y'] = -8.44, ['z'] = 74.51, ['h'] = 100.0 }, 
		['exit'] = { ['x'] = -107.67, ['y'] = -8.22, ['z'] = 70.51 },
		['vault'] = { ['x'] = -110.54, ['y'] = -14.62, ['z'] = 70.51, ['h'] = 163.0 },
		['locs'] = {
			{ ['id'] = 1, ['x'] = -113.58, ['y'] = -12.35, ['z'] = 70.51 },
			{ ['id'] = 2, ['x'] = -109.10, ['y'] = -10.04, ['z'] = 70.51 },
			{ ['id'] = 3, ['x'] = -112.17, ['y'] = -7.84, ['z'] = 70.51 },
			{ ['id'] = 4, ['x'] = -110.87, ['y'] = -6.42, ['z'] = 70.51 },
			{ ['id'] = 5, ['x'] = -113.00, ['y'] = -10.22, ['z'] = 70.51 }
		}
	},
	['LS01'] = { 
		['enter'] = { ['x'] = -45.44, ['y'] = -1445.37, ['z'] = 32.42, ['h'] = 270.49 }, -- -45.440322875977,-1445.3714599609,32.429615020752,270.4921875
		['exit'] = { ['x'] = 346.467, ['y'] = -1012.889, ['z'] = -99.196 },
		['vault'] = { ['x'] = 350.089, ['y'] = -1007.515, ['z'] = -99.19, ['h'] = 80.39 },  
		['locs'] = {		
			{ ['id'] = 1,['x'] = 350.63, ['y'] = -993.59, ['z'] = -99.19 }, 
			{ ['id'] = 2, ['x'] = 351.82, ['y'] = -999.20, ['z'] = -99.19 }, 
			{ ['id'] = 3, ['x'] = 346.18, ['y'] = -1001.75, ['z'] = -99.19 }, 
			{ ['id'] = 4, ['x'] = 344.08, ['y'] = -1001.19, ['z'] = -99.19 }, 
			{ ['id'] = 5, ['x'] = 342.81, ['y'] = -1003.18, ['z'] = -99.19 }, 
			{ ['id'] = 6, ['x'] = 339.22, ['y'] = -1003.34, ['z'] = -99.19 }, 
			{ ['id'] = 7, ['x'] = 338.26, ['y'] = -998.03, ['z'] = -99.19 }, 
			{ ['id'] = 8, ['x'] = 345.25, ['y'] = -994.97, ['z'] = -99.19 }, 
			{ ['id'] = 9, ['x'] = 347.24, ['y'] = -994.14, ['z'] = -99.19 }, 
			{ ['id'] = 10, ['x'] = 338.20, ['y'] = -995.24, ['z'] = -99.19 } 
		}
	},
	['LS03'] = { 
		['enter'] = { ['x'] = 312.66, ['y'] = -218.77, ['z'] = 54.22, ['h'] = 152.39 }, -- 312.66247558594,-218.7734375,54.221778869629,152.39700317383
		['exit'] = { ['x'] = 151.39, ['y'] = -1007.91, ['z'] = -99.0 }, 
		['vault'] = { ['x'] = 152.28, ['y'] = -1000.41, ['z'] = -98.99, ['h'] = 177.62 }, 
		['locs'] = {
			{ ['id'] = 1, ['x'] = 154.80, ['y'] = -1005.86, ['z'] = -98.99 }, 
			{ ['id'] = 2, ['x'] = 154.33, ['y'] = -1003.27, ['z'] = -98.99 }, 
			{ ['id'] = 3, ['x'] = 151.32, ['y'] = -1003.24, ['z'] = -98.99 }, 
			{ ['id'] = 4, ['x'] = 151.78, ['y'] = -1001.29, ['z'] = -98.99 }, 
			{ ['id'] = 5, ['x'] = 154.29, ['y'] = -1000.89, ['z'] = 98.99 } 
		}
	},
	['Clefable'] = { 
		['enter'] = { ['x'] = -1150.83, ['y'] = -1519.34, ['z'] = 4.35, ['h'] = 305.0 },
		['exit'] = { ['x'] = -1151.01, ['y'] = -1520.27, ['z'] = 10.63 },
		['vault'] = { ['x'] = -1158.39, ['y'] = -1524.74, ['z'] = 10.64, ['h'] = 309.50 },
		['locs'] = {
			{ ['id'] = 1, ['x'] = -1152.25, ['y'] = -1519.05, ['z'] = 10.63 },
			{ ['id'] = 2, ['x'] = -1148.39, ['y'] = -1518.96, ['z'] = 10.64 },
			{ ['id'] = 3, ['x'] = -1146.83, ['y'] = -1516.09, ['z'] = 10.63 },
			{ ['id'] = 4, ['x'] = -1145.39, ['y'] = -1514.45, ['z'] = 10.63 },
			{ ['id'] = 5, ['x'] = -1150.88, ['y'] = -1513.48, ['z'] = 10.63 },
			{ ['id'] = 6, ['x'] = -1149.53, ['y'] = -1513.04, ['z'] = 10.63 },
			{ ['id'] = 7, ['x'] = -1158.23, ['y'] = -1518.16, ['z'] = 10.63 },
			{ ['id'] = 8, ['x'] = -1155.25, ['y'] = -1523.97, ['z'] = 10.63 },
			{ ['id'] = 9, ['x'] = -1161.13, ['y'] = -1520.52, ['z'] = 10.63 }
		}
	},
	['Magneton'] = { 
		['enter'] = { ['x'] = -19.49, ['y'] = -1430.52, ['z'] = 31.09, ['h'] = 270.0 },
		['exit'] = { ['x'] = -14.52, ['y'] = -1427.62, ['z'] = 31.10 },
		['vault'] = { ['x'] = -16.00, ['y'] = -1430.40, ['z'] = 31.10, ['h'] = 85.0 },
		['locs'] = {
			{ ['id'] = 1, ['x'] = -11.87, ['y'] = -1428.06, ['z'] = 31.10 },
			{ ['id'] = 2, ['x'] = -10.20, ['y'] = -1430.33, ['z'] = 31.10 },
			{ ['id'] = 3, ['x'] = -12.48, ['y'] = -1435.12, ['z'] = 31.10 },
			{ ['id'] = 4, ['x'] = -8.83, ['y'] = -1439.06, ['z'] = 31.10 },
			{ ['id'] = 5, ['x'] = -9.40, ['y'] = -1441.43, ['z'] = 31.10 },
			{ ['id'] = 6, ['x'] = -12.47, ['y'] = -1436.97, ['z'] = 31.10 },
			{ ['id'] = 7, ['x'] = -18.43, ['y'] = -1438.66, ['z'] = 31.10 },
			{ ['id'] = 8, ['x'] = -17.72, ['y'] = -1440.74, ['z'] = 31.10 },
			{ ['id'] = 9, ['x'] = -18.25, ['y'] = -1436.83, ['z'] = 31.10 },
			{ ['id'] = 10, ['x'] = -18.19, ['y'] = -1432.19, ['z'] = 31.10 },
			{ ['id'] = 11, ['x'] = -16.70, ['y'] = -1434.86, ['z'] = 31.10 }
		}
	},
	['LX01'] = { 
		['enter'] = { ['x'] = -855.76, ['y'] = -33.64, ['z'] = 44.15, ['h'] = 209.76 },
		['exit'] = { ['x'] = -849.45, ['y'] = -12.87, ['z'] = 34.01 },
		['vault'] = { ['x'] = -844.22, ['y'] = -20.2, ['z'] = 34.01, ['h'] = 92.32 },
		['locs'] = {
			{ ['id'] = 1, ['x'] = -843.29, ['y'] = -26.08, ['z'] = 32.61 },
			{ ['id'] = 2, ['x'] = -843.01, ['y'] = -39.64, ['z'] = 32.61 },
			{ ['id'] = 3, ['x'] = -859.01, ['y'] = -36.54, ['z'] = 32.61 },
			{ ['id'] = 4, ['x'] = -857.82, ['y'] = -28.32, ['z'] = 32.61 },
			{ ['id'] = 5, ['x'] = -853.99, ['y'] = -34.88, ['z'] = 27.8 },
			{ ['id'] = 6, ['x'] = -852.65, ['y'] = -32.12, ['z'] = 27.8 },
			{ ['id'] = 7, ['x'] = -849.87, ['y'] = -35.24, ['z'] = 27.8 },
			{ ['id'] = 8, ['x'] = -847.08, ['y'] = -32.01, ['z'] = 27.8 },
			{ ['id'] = 9, ['x'] = -849.96, ['y'] = -25.65, ['z'] = 27.8 },
			{ ['id'] = 10, ['x'] = -848.59, ['y'] = -21.19, ['z'] = 34.02 },
			{ ['id'] = 11, ['x'] = -844.83, ['y'] = -22.45, ['z'] = 34.02 },
			{ ['id'] = 12, ['x'] = -845.73, ['y'] = -16.69, ['z'] = 34.01 }
		}
	},
	['MS01'] = { 
		['enter'] = { ['x'] = 128.27, ['y'] = 566.00, ['z'] = 183.96, ['h'] = 233.91 },
		['exit'] = { ['x'] = 117.23, ['y'] = 559.926, ['z'] = 184.30 },
		['vault'] = { ['x'] = 117.33, ['y'] = 570.54, ['z'] = 176.69, ['h'] = 55.83 },
		['locs'] = {
			{ ['id'] = 1, ['x'] = 120.23, ['y'] = 557.34, ['z'] = 184.30 },
			{ ['id'] = 2, ['x'] = 123.01, ['y'] = 557.55, ['z'] = 184.29 }, 
			{ ['id'] = 3, ['x'] = 123.80, ['y'] = 555.59, ['z'] = 184.29 }, 
			{ ['id'] = 4, ['x'] = 117.93, ['y'] = 549.04, ['z'] = 184.09 }, 
			{ ['id'] = 5, ['x'] = 125.10, ['y'] = 547.57, ['z'] = 184.09 }, 
			{ ['id'] = 6, ['x'] = 118.29, ['y'] = 544.46, ['z'] = 183.89 }, 
			{ ['id'] = 7, ['x'] = 123.30, ['y'] = 544.17, ['z'] = 183.92 }, 
			{ ['id'] = 8, ['x'] = 126.26, ['y'] = 543.40, ['z'] = 183.89 }, 
			{ ['id'] = 9, ['x'] = 116.46, ['y'] = 561.79, ['z'] = 180.49 }, 
			{ ['id'] = 10, ['x'] = 118.43, ['y'] = 543.50, ['z'] = 180.49 }, 
			{ ['id'] = 11, ['x'] = 122.11, ['y'] = 549.14, ['z'] = 180.49 }, 
			{ ['id'] = 12, ['x'] = 126.29, ['y'] = 546.18, ['z'] = 180.53 }, 
			{ ['id'] = 13, ['x'] = 124.85, ['y'] = 556.55, ['z'] = 180.50 },
			{ ['id'] = 14, ['x'] = 113.97, ['y'] = 561.67, ['z'] = 176.69 },
			{ ['id'] = 15, ['x'] = 117.85, ['y'] = 564.20, ['z'] = 176.69 },
			{ ['id'] = 16, ['x'] = 114.27, ['y'] = 565.40, ['z'] = 176.69 },
			{ ['id'] = 17, ['x'] = 114.61, ['y'] = 569.41, ['z'] = 176.69 },
			{ ['id'] = 18, ['x'] = 119.52, ['y'] = 569.73, ['z'] = 176.69 },
			{ ['id'] = 19, ['x'] = 118.69, ['y'] = 565.94, ['z'] = 176.69 }
		}
	},
	["MS02"] = { 
		["enter"] = { ['x'] = -1294.12, ['y'] = 454.34, ['z'] = 97.56, ['h'] = 181.29 }, 
		["exit"] = { ['x'] = -1289.80, ['y'] = 449.82, ['z'] = 97.90 },
		["vault"] = { ['x'] = -1288.72, ['y'] = 460.26, ['z'] = 90.29, ['h'] = 2.28 },
		['locs'] = {
			{ ['id'] = 1, ['x'] = -1287.53, ['y'] = 446.71, ['z'] = 97.89 },
			{ ['id'] = 2, ['x'] = -1283.82, ['y'] = 444.64, ['z'] = 97.89 },
			{ ['id'] = 3, ['x'] = -1290.25, ['y'] = 438.47, ['z'] = 97.69 },
			{ ['id'] = 4, ['x'] = -1283.21, ['y'] = 436.55, ['z'] = 97.69 },
			{ ['id'] = 5, ['x'] = -1290.39, ['y'] = 433.70, ['z'] = 97.49 },
			{ ['id'] = 6, ['x'] = -1282.55, ['y'] = 432.04, ['z'] = 97.49 },
			{ ['id'] = 7, ['x'] = -1290.36, ['y'] = 451.62, ['z'] = 94.09 },
			{ ['id'] = 8, ['x'] = -1290.33, ['y'] = 432.81, ['z'] = 94.09 },
			{ ['id'] = 9, ['x'] = -1282.24, ['y'] = 431.33, ['z'] = 94.16 },
			{ ['id'] = 10, ['x'] = -1282.33, ['y'] = 434.87, ['z'] = 94.12 },
    		{ ['id'] = 11, ['x'] = -1286.42, ['y'] = 438.43, ['z'] = 94.09 },
    		{ ['id'] = 12, ['x'] = -1283.31, ['y'] = 445.48, ['z'] = 94.10 },
    		{ ['id'] = 13, ['x'] = -1292.87, ['y'] = 451.88, ['z'] = 90.29 },
    		{ ['id'] = 14, ['x'] = -1288.72, ['y'] = 453.75, ['z'] = 90.29 },
    		{ ['id'] = 15, ['x'] = -1292.18, ['y'] = 455.51, ['z'] = 90.29 },
    		{ ['id'] = 16, ['x'] = -1286.50, ['y'] = 459.27, ['z'] = 90.29 },
    		{ ['id'] = 17, ['x'] = -1288.03, ['y'] = 455.54, ['z'] = 90.29 },
		},
	}
}

local output = nil
RegisterNetEvent('papa-indbrud:LixeiroCB')
AddEventHandler('papa-indbrud:LixeiroCB', function(ret)
    output = ret
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		for k,v in pairs(houses) do
			if not roubando then
				local distance = Vdist(x,y,z,v["enter"].x,v["enter"].y,v["enter"].z)
				if distance <= 5.0 then
					DrawText3Ds(v["enter"].x,v["enter"].y,v["enter"].z,"Tryk ~g~E~w~ for at lockpick døren")
					if IsControlJustPressed(0,38) and distance <= 1.2 then
						output = nil
						TriggerServerEvent('papa-indbrud:checkTimers',k)
						while output == nil do 
							Wait(10)
						end
						if output == true then
							TriggerEvent("progress",10000,"lockpicker")
							vRP.playAnim({false,{{"mini@safe_cracking","idle_base"},{"amb@prop_human_parking_meter@male@base","base"}},false})
							SetEntityHeading(ped,v["enter"].h)
							SetTimeout(10000,function()
								vRP.stopAnim({false})
								DoScreenFadeOut(1000)
								SetTimeout(2000,function()
									DoScreenFadeIn(1000)
									SetEntityCoords(ped,v['exit'].x,v['exit'].y,v['exit'].z-1)
									roubando = true
									homeName = k
									if math.random(100) >= 50 then
										cofre = true
										vault = CreateObject(GetHashKey("prop_ld_int_safe_01"),v['vault'].x,v['vault'].y,v['vault'].z,true,false,false)
										PlaceObjectOnGroundProperly(vault)
										FreezeEntityPosition(vault,true)
										SetEntityHeading(vault,v['vault'].h)
									end
								end)
							end)
						end
					end
				end
			else
				if v["exit"] then
					local _,homeZ = GetGroundZFor_3dCoord(v["exit"].x,v["exit"].y,v["exit"].z)
					local distance = Vdist(x,y,z,v["exit"].x,v["exit"].y,homeZ)
					if distance <= 5.0 then
						DrawText3Ds(v["exit"].x,v["exit"].y,v["exit"].z,"Tryk ~g~E~w~ for at gå ud")
						if IsControlJustPressed(0,38) and distance <= 1.2 then
							DoScreenFadeOut(1000)
							SetTimeout(2000,function()
								DoScreenFadeIn(1000)
								roubando = false
								list = {}
								SetEntityCoords(ped,v["enter"].x,v["enter"].y,v["enter"].z-1)
								if DoesEntityExist(vault) then
									TriggerServerEvent("trydeleteobj",ObjToNet(vault))
									cofre = false
									vault = nil
								end
							end)
						end
					end
				end
				if roubando then
					RequestAnimSet("move_ped_crouched")
					RequestAnimSet("move_ped_crouched_strafing")
					SetPedMovementClipset(ped,"move_ped_crouched",0.25)
					SetPedStrafeClipset(ped,"move_ped_crouched_strafing")
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
       	Citizen.Wait(5)
       	if roubando then
       		local ped = PlayerPedId()
       		local x,y,z = table.unpack(GetEntityCoords(ped))
       		for k,v in pairs(houses[homeName]['locs']) do
       			local distance = Vdist(x,y,z,v.x,v.y,v.z)
       			if distance <= 5.0 and list[v.id] == nil then
       				DrawText3Ds(v.x,v.y,v.z,"Tryk ~g~E~w~ for at søge")
       				if IsControlJustPressed(0,38) and distance <= 1.2 then
       					list[v.id] = true
						FreezeEntityPosition(ped,true)
       					TriggerEvent("cancel",true)
						TriggerEvent("progress",8000,"Søger")
						SetTimeout(8000,function()
							TriggerServerEvent('papa-indbrud:paymentRobbery',homeName)
       						FreezeEntityPosition(ped,false)
       						TriggerEvent("cancel",false)
   						end)
   					end
   				end
   			end
   		end
	end
end)

local cancel = false
RegisterNetEvent('cancel')
AddEventHandler('cancel',function(status)
    cancel = status
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if cancel then
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,29,true)
			DisableControlAction(0,38,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,56,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,137,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,169,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,243,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)			
		end
	end
end)

RegisterNetEvent('Notify')
AddEventHandler('Notify',function(a,msg,b)
    SetNotificationTextEntry('STRING')
	AddTextComponentSubstringWebsite(msg)
	DrawNotification(false, true)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if cofre then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = Vdist(x,y,z,houses[homeName]['vault'].x,houses[homeName]['vault'].y,houses[homeName]['vault'].z)
			if distance <= 5.0 then
				DrawText3Ds(houses[homeName]['vault'].x,houses[homeName]['vault'].y,houses[homeName]['vault'].z,"Tryk ~g~E~w~ for at åbne pengeskabet")
				if IsControlJustPressed(0,38) and distance <= 0.8 then
					TriggerEvent("mhacking:show")
					TriggerEvent("mhacking:start",4,30,mycb)
				end
			end
		else
			if DoesEntityExist(vault) then
				TriggerServerEvent("trydeleteobj",ObjToNet(vault))
				vault = nil
			end
		end
	end
end)

function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)

	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end

function mycb(success,timeremaining)
	TriggerEvent('mhacking:hide')
	cofre = false
	if success then
		TriggerServerEvent('papa-indbrud:paymentVault',homeName)
	end
end

RegisterNetEvent("syncdeleteobj")
AddEventHandler("syncdeleteobj",function(index)
    if NetworkDoesNetworkIdExist(index) then
        local v = NetToPed(index)
        if DoesEntityExist(v) and IsEntityAnObject(v) then
            Citizen.InvokeNative(0xAD738C3085FE7E11,v,true,true)
            SetEntityAsMissionEntity(v,true,true)
            NetworkRequestControlOfEntity(v)
            Citizen.InvokeNative(0x539E0AE3E6634B9F,Citizen.PointerValueIntInitialized(v))
            DeleteEntity(v)
            DeleteObject(v)
            SetObjectAsNoLongerNeeded(v)
        end
    end
end)