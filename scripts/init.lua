Tracker:AddItems("items/items.json") --add items to tracker logic

Tracker:AddMaps("maps/maps.json") --add maps to tracker logic

Tracker:AddLayouts("layouts/items.json") --add item layout key for use in tracker
Tracker:AddLayouts("layouts/tracker.json") --add tracker layout

ScriptHost:LoadScript("scripts/loadlocations.lua") --load script holding item locations
ScriptHost:LoadScript("scripts/autotracking.lua") --load script with logic to automatically track when connected to Archipelago 
ScriptHost:LoadScript("scripts/logic.lua") --load script that defines extra functions for use in tracker logic