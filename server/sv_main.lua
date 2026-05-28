robbed = {}
local actkns = {}

function vftkn(source, cltkn)
    if actkns[source] and actkns[source] == cltkn then
        actkns[source] = nil
        return true
    end
    return false
end

--[[RegisterNetEvent("dnj:rm",function(item,count)
    src = source
    exports.ox_inventory:RemoveItem(src,item,count)
end)]]

lib.callback.register('dnj_robberies:check', function(source, coords)
    local crdskey = string.format('%.2f,%.2f,%.2f', coords.x, coords.y, coords.z)
    
    if robbed[crdskey] then
        if os.time() < robbed[crdskey] then
            return false
        end
    end
    
    local token = tostring(math.random(100000, 999999)) .. "" .. tostring(os.time())
    actkns[source] = token
    
    return token
end)

RegisterNetEvent('dnj_robberies:break', function()
    local src = source
    exports.ox_inventory:RemoveItem(src, dnj.rq1, 1)
end)