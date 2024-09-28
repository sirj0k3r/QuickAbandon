questID = nil;

function QuickAbandonQuest()
	if (CheckKeybind() and QuestChecks()) then
		C_QuestLog.SetSelectedQuest(questID); 
		C_QuestLog.SetAbandonQuest(); 
		C_QuestLog.AbandonQuest();

		WorldMapFrameCloseButton:Click();
		
		SendSystemMessage("Quest abandoned: ".. GetQuestLink(questID) .."")
	end
end

hooksecurefunc("QuestMapLogTitleButton_OnClick", function(self, button)
	SetQuestID(self.questID);
	QuickAbandonQuest();
end)

hooksecurefunc(CampaignQuestObjectiveTracker, "OnBlockHeaderClick", function(self, block, button)
	SetQuestID(block.id);
	QuickAbandonQuest();
end)

hooksecurefunc(QuestObjectiveTracker, "OnBlockHeaderClick", function(self, block, button)
	SetQuestID(block.id);
	QuickAbandonQuest();
end)

-- Checks if the keybind is present
function CheckKeybind()
	result = IsAltKeyDown();
	return result;
end

-- Checks if a quest can be abandoned
function QuestChecks()
	result = C_QuestLog.CanAbandonQuest(questID) and C_QuestLog.IsOnQuest(questID)
	return result;
end

function SetQuestID(id)
	questID = id;
end