function yamlCheckDLC() --function to check if player turned off DLC checks
  
  local dlc = Tracker:FindObjectForCode("no_dlc")  --get no_dlc item object
  
  return not dlc.Active --return bool opposite of item's activate state, because an activated state means player has turned checks off
  
end

function yamlCheckStory() --function to check if player turned off main story checks
  
  local story = Tracker:FindObjectForCode("no_story") --get no_story item object
  
  return not story.Active --return bool opposite of item's activate state, because an activated state means player has turned checks off
  
end
