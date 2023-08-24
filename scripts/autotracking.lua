ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua") --load item ID mapping
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua") --load location ID mapping

-- initialize values
CUR_INDEX = -1
SLOT_DATA = nil
LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}

function onClear(slot_data) --function called when joining archipelago server
    SLOT_DATA = slot_data
    CUR_INDEX = -1
	
    --reset locations
    for _, v in pairs(LOCATION_MAPPING) do --for loop going through all locations on file
        if v then
            local obj = Tracker:FindObjectForCode(v)
            if obj then
                if v:sub(1, 1) == "@" then --if location is not an item, set to max count amount
                    obj.AvailableChestCount = obj.ChestCount
                else --if location is an item, deactive
                    obj.Active = false
                end
            end
        end
    end
	
    -- reset items
    for _, v in pairs(ITEM_MAPPING) do --for loop going through all items on file
        if v then
            if not(v == nil) then --if item is not filler, deactivate
				local obj = Tracker:FindObjectForCode(v)
				obj.Active = false
            end
        end
    end

    if SLOT_DATA == nil then --if no slot data, get outta here
        return
    end
end

function onItem(index, item_id, item_name, player_number) --function called when an item is collected on Archipelago

    local item_lookup = ITEM_MAPPING[item_id] --use item ID to find matching item in tracker
	
	if not(item_lookup == nil) then --if item is not filler, find and activate item object
		local obj = Tracker:FindObjectForCode(item_lookup)
		obj.Active = true
	end
end

function onLocation(location_id, location_name) --function called when a location is checked on Archipelago

	local loc_lookup = LOCATION_MAPPING[location_id] --use location ID to find matching item in tracker

	if loc_lookup then --find object associated with location and remove one check from that location
		local obj = Tracker:FindObjectForCode(loc_lookup)
		if obj then
			obj.AvailableChestCount = obj.AvailableChestCount - 1
		end
	else
		return
	end
end

Archipelago:AddClearHandler("clear handler", onClear) --call function when joining archipelago server
Archipelago:AddItemHandler("item handler", onItem) --call function when item is discovered
Archipelago:AddLocationHandler("location handler", onLocation) --call function when location is checked