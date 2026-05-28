RegisterNetEvent('dnj_robberies:znacky', function(coords, token)
    local src = source

    if not vftkn(src, token) then
        return
    end

    local crdskey = string.format('%.2f,%.2f,%.2f', coords.x, coords.y, coords.z)
    
    robbed[crdskey] = os.time() + (dnj.cl / 1000)

    for _, reward in pairs(dnj.sgnscrp.rwrw) do
        local amount = math.random(reward.min, reward.max)
        if amount > 0 then
            exports.ox_inventory:AddItem(src, reward.item, amount)
        end
    end
end)

RegisterNetEvent('dnj_baseillegal:br2', function()
    local src = source
    exports.ox_inventory:RemoveItem(src, dnj.sg1, 1)
end)