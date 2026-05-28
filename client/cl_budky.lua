exports.ox_target:removeModel(dnj.phx.mdls, 'phonebox')

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
            sprite = 431, 
            scale = 0.9, 
            colour = 3,
            text = '911 - Vytřnictví',
            time = 300 
        }
    })]]
end

exports.ox_target:addModel(dnj.phx.mdls, {
    {
        name = 'phonebox',
        icon = 'fa-solid fa-phone',
        label = 'Vykrást',
        items = dnj.rq1,
        distance = 2.0,
        onSelect = function(data)
            local entitycoords = GetEntityCoords(data.entity)
            local token = lib.callback.await('dnj_robberies:check', false, entitycoords)
            
            if not token then
                lib.notify({  description = 'Tady nic nebude.', type = 'error' })
                return
            end

            local chance = math.random(1,100)
            if chance < 100 then
                dispatch()
            end

            if lib.progressBar({
                duration = math.random(5000,7000),
                label = "Vykrádáš...",
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = { move = true, car = true, combat = true },
                anim = { dict = 'missheistfbisetup1', clip = 'hassle_intro_loop_f' },
            }) then
                local success = lib.skillCheck(dnj.phx.skl, {'w', 'a', 's', 'd'})
                
                if success then
                    TriggerServerEvent('dnj_robberies:budky', entitycoords, token)
                    lib.notify({  description = 'Něco jsi našel.', type = 'success' })
                else
                    if math.random(1, 100) <= dnj.br1 then
                        TriggerServerEvent('dnj_robberies:break')
                        lib.notify({  description = 'Zlomil jsi šperhák!', type = 'error' })
                    else
                        lib.notify({  description = 'Pokazil jsi to.', type = 'error' })
                    end
                end
            else
                lib.notify({ description = 'Něco se pokazilo', type = 'error' })
            end
        end
    }
})
