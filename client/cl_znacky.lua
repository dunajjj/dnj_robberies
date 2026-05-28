exports.ox_target:removeModel(dnj.sgnscrp.mdls, 'sign')

function dispatch()

    --[[local data = exports.dnj_dispatch:GetPlayerInfo(source)

    TriggerServerEvent('dnj_dispatch:server:AddNotification', {
        jobs = {'police', 'sheriff', 'sahp'}, 
        coords = data.coords,
        code = '10-68',
        title = 'Nelegálni aktivita',
        info = 'Někdo nahlásil vytřnictví na ulici '.. data.street .. '.',
        priority = 1, 
        isPanic = false,
        blip = {
            sprite = 402, 
            scale = 0.9, 
            colour = 3,
            text = '911 - Vytřnictví',
            time = 300 
        }
    })]]
end
    
exports.ox_target:addModel(dnj.sgnscrp.mdls, {
    {
        name = 'sign',
        icon = 'fa-solid fa-wrench',
        label = 'Odmontovat',
        items = dnj.sg1,
        distance = 3.0,
        onSelect = function(data)
            local entitycoords = GetEntityCoords(data.entity)
            local token = lib.callback.await('dnj_robberies:check', false, entitycoords)
            
            if not token then
                lib.notify({ description = 'Značka je príliš poškodená.', type = 'error' })
                return
            end

            local chance = math.random(1,100)
            if chance < 100 then
                dispatch()
            end

            if lib.progressBar({
                duration = 4500,
                position = 'bottom',
                useWhileDead = false,
                label = "Odmontovávaš značku...",
                canCancel = true,
                disable = { move = true, car = true, combat = true },
                anim = { dict = 'missheistfbisetup1', clip = 'hassle_intro_loop_f' },
            }) then
                local success = lib.skillCheck(dnj.sgnscrp.skl, {'w', 'a', 's', 'd'})
                
                if success then
                    TriggerServerEvent('dnj_robberies:znacky', entitycoords, token)
                    lib.notify({ description = 'Získal si nejakej šrot.', type = 'success' })
                    
                    SetEntityAsMissionEntity(data.entity, true, true)
                else
                    if math.random(1, 100) <= dnj.sg2 then
                        TriggerServerEvent('dnj_robberies:break')
                        lib.notify({ description = 'Zlomil se ti zkrutkovač!', type = 'error' })
                    else
                        lib.notify({ description = 'Nepodařilo se ti to.', type = 'error' })
                    end
                end
            else
                lib.notify({ description = 'Zrušené', type = 'error' })
            end
        end
    }
})
