function QuickAbandonQuest(questID)
	if (CheckKeybind() and QuestChecks(questID)) then
		C_QuestLog.SetSelectedQuest(questID); 
		C_QuestLog.SetAbandonQuest(); 
		C_QuestLog.AbandonQuest();

		WorldMapFrameCloseButton:Click();
		
		SendSystemMessage("Quest abandoned: ".. GetQuestLink(questID) .."")
	end
end

hooksecurefunc("QuestMapLogTitleButton_OnClick", function(self)
	QuickAbandonQuest(self.questID);
end)

hooksecurefunc(CampaignQuestObjectiveTracker, "OnBlockHeaderClick", function(_, block)
	QuickAbandonQuest(block.id);
end)

hooksecurefunc(QuestObjectiveTracker, "OnBlockHeaderClick", function(_, block)
	QuickAbandonQuest(block.id);
end)

function CheckKeybind()
	local result = IsAltKeyDown();
	return result;
end

function QuestChecks(questID)
	local result = C_QuestLog.CanAbandonQuest(questID) and C_QuestLog.IsOnQuest(questID)
	return result;
end