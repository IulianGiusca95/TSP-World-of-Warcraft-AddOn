A={}
ZONES={}
QUESTS={}

local ILVL_REGEX = "Item Level (%d+)";
local ARTIFACT_REGEX1 = "(%d+) Artifact Power";
local ARTIFACT_REGEX2 = "(%d+) million Artifact Power";

QUEST_MAPS={
   1007, -- Broken Isles
   1014, -- Dalaran
   1015, -- Azsuna
   1017, -- Stormheim
   1018, -- Val'Sharah
   1021, -- Broken Shore
   1024, -- Highmountain
   1033, -- Suramar
   1098, -- Eye of Azshara
}

WORLD_QUESTS_BY_ZONES={
   C_TaskQuest.GetQuestsForPlayerByMapID(QUEST_MAPS[2],QUEST_MAPS[1]), -- quests din Dalaran
   C_TaskQuest.GetQuestsForPlayerByMapID(QUEST_MAPS[3],QUEST_MAPS[1]), -- quests din Azsuna
   C_TaskQuest.GetQuestsForPlayerByMapID(QUEST_MAPS[4],QUEST_MAPS[1]), -- quests din Stormheim
   C_TaskQuest.GetQuestsForPlayerByMapID(QUEST_MAPS[5],QUEST_MAPS[1]), -- quests din Val'Sharah
   C_TaskQuest.GetQuestsForPlayerByMapID(QUEST_MAPS[6],QUEST_MAPS[1]), -- quests din Broken Shore
   C_TaskQuest.GetQuestsForPlayerByMapID(QUEST_MAPS[7],QUEST_MAPS[1]), -- quests din Highmountain
   C_TaskQuest.GetQuestsForPlayerByMapID(QUEST_MAPS[8],QUEST_MAPS[1]), -- quests din Suramar
   C_TaskQuest.GetQuestsForPlayerByMapID(QUEST_MAPS[9],QUEST_MAPS[1]), -- quests din Eye of Azshara
}

WORLD_QUESTS_TOTAL={
   getn(WORLD_QUESTS_BY_ZONES[1]), -- nr de quests din Dalaran
   getn(WORLD_QUESTS_BY_ZONES[2]), -- nr de quests din Azsuna
   getn(WORLD_QUESTS_BY_ZONES[3]), -- nr de quests din Stormheim
   getn(WORLD_QUESTS_BY_ZONES[4]), -- nr de quests din Val'Sharah
   getn(WORLD_QUESTS_BY_ZONES[5]), -- nr de quests din Broken Shore
   getn(WORLD_QUESTS_BY_ZONES[6]), -- nr de quests din Highmountain
   getn(WORLD_QUESTS_BY_ZONES[7]), -- nr de quests din Suramar
   getn(WORLD_QUESTS_BY_ZONES[8]), -- nr de quests din Eye of Azshara
}

ZONE_NAMES={
   "Dalaran",
   "Azsuna",
   "Stormheim",
   "Val'Sharah",
   "Broken Shore",
   "Highmountain",
   "Suramar",
   "Eye of Azshara",
}


FACTIONS={
   {2045,"Armies of Legionfall",},
   {1900,"Court of Farondis",},
   {1883,"Dreamweavers",},
   {1828,"Highmountain Tribe",},
   {1090,"Kirin Tor",},
   {1859,"Nightfallen",},
   {1948,"Valarjar",},
   {1894,"Wardens",},
}

local TT = CreateFrame('GameTooltip'); -- Scanning tooltip, used in UpdateTask to get real item info.
TT:SetOwner(UIParent);
TT:AddFontStrings(TT:CreateFontString(),TT:CreateFontString());


for i=1,getn(WORLD_QUESTS_TOTAL) do
    ZONES[i]={ZONE_NAMES[i],WORLD_QUESTS_BY_ZONES[i],WORLD_QUESTS_TOTAL[i]};
end

nr_quests=1;
for i=1,getn(WORLD_QUESTS_TOTAL) do
    for j=1,WORLD_QUESTS_TOTAL[i] do
	    local id = WORLD_QUESTS_BY_ZONES[i][j].questId;
		local x = WORLD_QUESTS_BY_ZONES[i][j].x;
		local y = WORLD_QUESTS_BY_ZONES[i][j].y;
		local nume_quest,faction_id = C_TaskQuest.GetQuestInfoByQuestID(id);
		local duration = C_TaskQuest.GetQuestTimeLeftMinutes(id);
		local distance = C_TaskQuest.GetDistanceSqToQuest(id);
		local zone_name = ZONE_NAMES[i];
		local Reward = {}
		
		--if  GetQuestLogRewardMoney(id) > 0 then		-- gold
		--	val = GetQuestLogRewardMoney(id);
			--print('gold');
		--	Reward.id = 1;
		--	Reward.name = "gold";
		--	Reward.amount = val;
		--else
		--if GetNumQuestLogRewardCurrencies(id) >0 or GetQuestLogRewardMoney(id) > 0 then  -- order resources, nethershards or legionfall resources (can be multiple)
		--	Reward.id = 2;
		--	Reward.index = {};
		--	local ok = 0;
		--	local k=0;
		--	while ok ==0 do
		--		k=k+1;
		--		ok=1;
		--		if not (GetQuestLogRewardCurrencyInfo(k, id) == nil) then 
		--			local Obj = {}
		--			ok = 0;
		--			local name, icon, amount = GetQuestLogRewardCurrencyInfo(k, id);
		--			Obj.name = name;
		--			print(name);
		--			Obj.amount = amount;
		--			Reward.index[table.getn(Reward.index)+1]=Obj;
		--		end;
		--	end
			
		--	if GetQuestLogRewardMoney(id) > 0 then
		--		local Obj = {}
		--		Obj.name = "gold";
		--		Obj.amount = GetQuestLogRewardMoney(id);
		--		Reward.index[table.getn(Reward.index)+1]=Obj;
		--	end
			--print('currencies');
		if GetNumQuestLogRewards(id) > 0 or GetNumQuestLogRewardCurrencies(id) >0 or GetQuestLogRewardMoney(id) > 0 then
				Reward.id = 3;
				Reward.index = {};
				Reward.item = {}
				local ok = 0;
				local k=0;
				while ok ==0 do
					k=k+1;
					ok=1;
					if not (GetQuestLogRewardCurrencyInfo(k, id) == nil) then 
						local Obj = {}
						ok = 0;
						local name, icon, amount = GetQuestLogRewardCurrencyInfo(k, id);
						Obj.name = name;
						--print(name);
						Obj.amount = amount;
						Reward.index[table.getn(Reward.index)+1]=Obj;
					end;
				end
			
				if GetQuestLogRewardMoney(id) > 0 then
					local Obj = {}
					Obj.name = "gold";
					Obj.amount = GetQuestLogRewardMoney(id);
					Reward.index[table.getn(Reward.index)+1]=Obj;
				end
			
			if GetNumQuestLogRewards(id) > 0 then
				Reward.id = 3;
				local itemName, itemTexture, quantity, quality, isUsable, itemID = GetQuestLogRewardInfo(1, id);
			
				TT:ClearLines();
				TT:SetQuestLogItem("reward",1,id);
				local rewardname, link = TT:GetItem(); --returneaza numele obiectului si link catre el
				if not link then
					Reward.item.link = nil;
				end
				Reward.item.name = rewardname;
					
				--print(link);--foarte tare
				Reward.item.type = "other";
				for k=3, TT:GetNumRegions() do
					local str = select(k, TT:GetRegions()):GetText() or '';
					local ilvl = str:match(ILVL_REGEX);
					local ap1 = str:match(ARTIFACT_REGEX1);
					local ap2 = str:match(ARTIFACT_REGEX2);
					if ilvl then
						Reward.item.type = "wearable";
						Reward.item.ilvl =tonumber(ilvl);
					end
					if ap1 then
						local isartifact = true;
						Reward.item.type = "artifact power1";
						Reward.item.amount = tonumber(ap1);
						--print(tonumber(ap1));
					end
					if ap2 then
						local isartifact = true;
						Reward.item.type = "artifact power2";
						Reward.item.amount = tonumber(ap2);
						--print(tonumber(ap2));
					end
				end
			
				if Reward.item.type == "other" then
					if not (rewardname == "Pet Charm" or rewardname == "Battle Pet Bandage" or rewardname == "Wyrmtongue's Cache Key" or rewardname =="Access to the Ruins of Falanaar") then
						Reward.item.type = "profession"
						Reward.item.amount = quantity;
					else
						if rewardname == "Pet Charm" or rewardname == "Battle Pet Bandage" then
							Reward.item.type = "pet battle"
							Reward.item.amount = quantity;
						end
					end
				end
			end
		else
			Reward.id=4;
		end
		
		
		
		tagID, tagName, worldQuestType, rarity, isElite, tradeskillLineIndex = GetQuestTagInfo(id)
		QUESTS[nr_quests]={id,nume_quest,faction_id,duration,x,y,distance,rarity,isElite,zone_name, Reward, };
		nr_quests=nr_quests+1;
	
	end
end
nr_quests=nr_quests-1;

Constrangeri_spatiu={
	{
		{0.35,0.27},{0.34,0.29},{0.32,0.28},{0.300820,0.279913},{0.289230,0.268269},{0.284958,0.238828},{0.297618,0.215691},{0.320185,0.227269},{0.364823,0.224282},{0.378094,0.247548},{0.375537,0.264119}
	}
}



A.Quests = QUESTS;
A.Quest_Maps = QUEST_MAPS;
A.Factions = FACTIONS;
A.Constraints = Constrangeri_spatiu;

