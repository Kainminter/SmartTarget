
_addon.name    = 'SmartTarget'
_addon.author  = 'Kainminter'
_addon.version = '1.0.0'
_addon.commands = {'smarttarget', 'target', 'ta', 't'}

local packets = require('packets')


windower.register_event('addon command', function(...)
    local args = {...}
    if #args == 0 then
        windower.add_to_chat(123, 'Usage: //smarttarget [name] | direct <id> | id <hex index>')
        return
    end

    local player = windower.ffxi.get_player()
    if not player then
        return
    end

    --local target = nil
    -- local command = args[1]:lower()

    -- if command == 'direct' then
        -- if #args < 2 then
            -- windower.add_to_chat(123, 'Usage: //smarttarget direct <id>')
            -- return
        -- end
        -- local direct_id = tonumber(args[2])
        -- if not direct_id then
            -- windower.add_to_chat(123, 'Invalid direct id.')
            -- return
        -- end
        -- target = windower.ffxi.get_mob_by_id(direct_id)

    local target = nil
    local command = args[1]:lower()

    -- If the first argument is a number, assume it's a direct ID
    local direct_id = tonumber(args[1])
    if direct_id then
        target = windower.ffxi.get_mob_by_id(direct_id)

    elseif command == 'id' or command == 'index' then
        -- Target by hex id (using the mob's index).
        if #args < 2 then
            windower.add_to_chat(123, 'Usage: //smarttarget id <hex id>')
            return
        end
        local hex_id = args[2]
        local index = tonumber(hex_id, 16)
        if not index then
            windower.add_to_chat(123, 'Invalid hex id.')
            return
        end
        target = windower.ffxi.get_mob_by_index(index)

    else
        -- Target by (partial) name.
        local name_search = table.concat(args, ' ')
        local mobs = windower.ffxi.get_mob_array()
        local best_distance = math.huge
        for _, mob in pairs(mobs) do
            if mob.name and mob.name ~= '' then

                if string.find(string.lower(mob.name), string.lower(name_search), 1, true) then
                    if mob.distance and mob.distance <= 49*49 and mob.distance < best_distance then
                        best_distance = mob.distance
                        target = mob
                    end
                end
            end
        end
    end

    local entity_found = false
    if target then
        local mobs = windower.ffxi.get_mob_array()
        for _, mob in pairs(mobs) do
            if mob.id == target.id and mob.distance and mob.distance <= 49*49 then
                entity_found = true
                break
            end
        end
    end

   if not target or not entity_found then
        windower.add_to_chat(123, 'Target not found or out of range.')
        return
    end

    -- Inject the targeting packet.
    packets.inject(packets.new('incoming', 0x058, {
        ['Player'] = player.id,
        ['Target'] = target.id,
        ['Player Index'] = player.index,
    }))
end)
