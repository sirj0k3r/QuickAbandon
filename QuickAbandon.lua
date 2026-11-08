local QUESTING_ADDON_NAME = "QuickQuesting";

local function AbandonQuest(questID)
    if (not questID or not IsAltKeyDown()) then
        return;
    end
    if (not (C_QuestLog.CanAbandonQuest(questID) and C_QuestLog.IsOnQuest(questID))) then
        return;
    end

    C_QuestLog.SetSelectedQuest(questID);
    C_QuestLog.SetAbandonQuest();
    C_QuestLog.AbandonQuest();

    if (WorldMapFrame and WorldMapFrame:IsShown()) then
        WorldMapFrameCloseButton:Click();
    end

    SendSystemMessage("Quest abandoned: " .. GetQuestLink(questID));
end

local function InstallHooks()
    hooksecurefunc("QuestMapLogTitleButton_OnClick", function(self)
        AbandonQuest(self.questID);
    end);

    hooksecurefunc(CampaignQuestObjectiveTracker, "OnBlockHeaderClick", function(_, block)
        AbandonQuest(block.id);
    end);

    hooksecurefunc(QuestObjectiveTracker, "OnBlockHeaderClick", function(_, block)
        AbandonQuest(block.id);
    end);
end

local frame = CreateFrame("Frame");
frame:RegisterEvent("PLAYER_LOGIN");
frame:SetScript("OnEvent", function(self)
    self:UnregisterEvent("PLAYER_LOGIN");

    -- All addons are loaded by now, so this works whichever loaded first.
    -- Quick Questing has abandon built in and handles it.
    if (C_AddOns.IsAddOnLoaded(QUESTING_ADDON_NAME)) then
        return;
    end

    InstallHooks();
    print("Quick Abandon has been merged into Quick Questing and won't receive further updates.");
end);
