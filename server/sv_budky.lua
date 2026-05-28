RegisterNetEvent('dnj_robberies:budky', function(coords, token)
    local src = source

    if not vftkn(src, token) then
        return
    end

    local crdskey = string.format('%.2f,%.2f,%.2f', coords.x, coords.y, coords.z)
    
    robbed[crdskey] = os.time() + (dnj.cl / 1000)

    local reward = math.random(dnj.phx.mm, dnj.phx.mx)
    
    if reward > 0 then
        exports.ox_inventory:AddItem(src, 'money', reward)
    end
end)