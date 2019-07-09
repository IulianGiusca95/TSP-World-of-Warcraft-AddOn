Licenta={};

local QUESTS = A.Quests;
local QUEST_MAPS = A.Quest_Maps;
local Factions = A.Factions;
local FilteredQuests = {}
local Constraints = A.Constraints;

FilterPoints = {}
FilterPathPoints = {}
CheckButtons={};
DrawPoints = {};
local hbdp = LibStub("HereBeDragons-Pins-1.0")





----------------------------------------------------------------------------------------------


function checkQuest(Quests,id)
	for i=1,table.getn(Quests) do
		if Quests[i][1] == id then
			return 1;
		end
	end
	return 0;
end

function filterQuests()
	B:removeAllPoints();
	DrawPoints={};
	hideFrames(FilteredQuests);
    FilteredQuests={}
	enabled = myCheckButton1:GetChecked(); --selecting Armies of Legionfall
	if enabled then 
		for i=1,table.getn(QUESTS) do
			if (((QUESTS[i][3] == 1090 or QUESTS[i][3]==1894) and QUESTS[i][10]=="Broken Shore") or QUESTS[i][3]==2045) and checkQuest(FilteredQuests,QUESTS[i][1])==0 then
				FilteredQuests[table.getn(FilteredQuests)+1]=QUESTS[i];
			end
		end
	end
	
	enabled = myCheckButton2:GetChecked(); --selecting Court of Farondis
	if enabled then 
		for i=1,table.getn(QUESTS) do
			if (((QUESTS[i][3] == 1090 or QUESTS[i][3]==1894) and QUESTS[i][10]=="Azsuna") or QUESTS[i][3] == 1900) and checkQuest(FilteredQuests,QUESTS[i][1])==0 then
				FilteredQuests[table.getn(FilteredQuests)+1]=QUESTS[i];
			end
		end
	end
	
	enabled = myCheckButton3:GetChecked();  --selecting Dreamweavers
	if enabled then 
		for i=1,table.getn(QUESTS) do
			if (((QUESTS[i][3] == 1090 or QUESTS[i][3]==1894) and QUESTS[i][10]=="Val'Sharah") or QUESTS[i][3] == 1883) and checkQuest(FilteredQuests,QUESTS[i][1])==0 then
				FilteredQuests[table.getn(FilteredQuests)+1]=QUESTS[i];
			end
		end
	end
	
	enabled = myCheckButton4:GetChecked();  --selecting Highmountain
	if enabled then 
		for i=1,table.getn(QUESTS) do
			if (((QUESTS[i][3] == 1090 or QUESTS[i][3]==1894) and QUESTS[i][10]=="Highmountain") or QUESTS[i][3] == 1828) and checkQuest(FilteredQuests,QUESTS[i][1])==0 then
				FilteredQuests[table.getn(FilteredQuests)+1]=QUESTS[i];
			end
		end
	end
	
	enabled = myCheckButton5:GetChecked();  --selecting Kirin Tor
	if enabled then 
		for i=1,table.getn(QUESTS) do
			if (QUESTS[i][3] == 1090) and checkQuest(FilteredQuests,QUESTS[i][1])==0 then
				FilteredQuests[table.getn(FilteredQuests)+1]=QUESTS[i];
			end
		end
	end
	
	enabled = myCheckButton6:GetChecked();  --selecting Nightfallen
	if enabled then 
		for i=1,table.getn(QUESTS) do
			if (((QUESTS[i][3] == 1090 or QUESTS[i][3]==1894) and QUESTS[i][10]=="Suramar") or QUESTS[i][3] == 1859) and checkQuest(FilteredQuests,QUESTS[i][1])==0 then
				FilteredQuests[table.getn(FilteredQuests)+1]=QUESTS[i];
			end
		end
	end
	
	enabled = myCheckButton7:GetChecked();  --selecting Valarjar
	if enabled then 
		for i=1,table.getn(QUESTS) do
			if (((QUESTS[i][3] == 1090 or QUESTS[i][3]==1894) and QUESTS[i][10]=="Stormheim") or QUESTS[i][3] == 1948) and checkQuest(FilteredQuests,QUESTS[i][1])==0 then
				FilteredQuests[table.getn(FilteredQuests)+1]=QUESTS[i];
			end
		end
	end
	
	enabled = myCheckButton8:GetChecked();  --selecting Wardens
	if enabled then 
		for i=1,table.getn(QUESTS) do
			if (QUESTS[i][3] == 1894) and checkQuest(FilteredQuests,QUESTS[i][1])==0 then
			FilteredQuests[table.getn(FilteredQuests)+1]=QUESTS[i];
			end
		end
	end
	
	enabled = myCheckButton9:GetChecked();  --selecting Gold quests
	if enabled then 
		for i=1,table.getn(QUESTS) do
			local Reward = QUESTS[i][11];
			if Reward.id == 3 then
				for k=1,table.getn(Reward.index) do
					local Obj = Reward.index[k];
					if Obj.name == "gold" and checkQuest(FilteredQuests,QUESTS[i][1])==0 then
						FilteredQuests[table.getn(FilteredQuests)+1]=QUESTS[i];
					end
				end
			end
		end
	end
	
	enabled = myCheckButton10:GetChecked();  --selecting Nethershard quests
	if enabled then 
		for i=1,table.getn(QUESTS) do
			local Reward = QUESTS[i][11];
			if Reward.id == 3 then
				for k=1,table.getn(Reward.index) do
					local Obj = Reward.index[k];
					if Obj.name == "Nethershard" and checkQuest(FilteredQuests,QUESTS[i][1])==0 then
						FilteredQuests[table.getn(FilteredQuests)+1]=QUESTS[i];
					end
				end
			end
		end
	end
	
	enabled = myCheckButton11:GetChecked();  --selecting Order Resources quests
	if enabled then 
		for i=1,table.getn(QUESTS) do
			local Reward = QUESTS[i][11];
			if Reward.id == 3 then
				for k=1,table.getn(Reward.index) do
					local Obj = Reward.index[k];
					if Obj.name == 'Order Resources' and checkQuest(FilteredQuests,QUESTS[i][1])==0 then
						FilteredQuests[table.getn(FilteredQuests)+1]=QUESTS[i];
					end
				end
			end
		end
	end
	
	enabled = myCheckButton12:GetChecked();  --selecting Legionfall Resources quests
	if enabled then 
		for i=1,table.getn(QUESTS) do
			local Reward = QUESTS[i][11];
			if Reward.id == 3 then
				for k=1,table.getn(Reward.index) do
					local Obj = Reward.index[k];
					if Obj.name == 'Legionfall War Supplies' and checkQuest(FilteredQuests,QUESTS[i][1])==0 then
						FilteredQuests[table.getn(FilteredQuests)+1]=QUESTS[i];
					end
				end
			end
		end
	end
	
	enabled = myCheckButton13:GetChecked();  --selecting Equipment quests
	if enabled then 
		for i=1,table.getn(QUESTS) do
			local Reward = QUESTS[i][11];
			if Reward.id == 3 then
				if Reward.item then
					if Reward.item.type == "wearable" and checkQuest(FilteredQuests,QUESTS[i][1])==0 then
						FilteredQuests[table.getn(FilteredQuests)+1]=QUESTS[i];
					end
				end
			end
		end
	end
	
	enabled = myCheckButton14:GetChecked();  --selecting AP quests
	if enabled then 
		for i=1,table.getn(QUESTS) do
			local Reward = QUESTS[i][11];
			if Reward.id == 3 then
				if Reward.item then
					if (Reward.item.type == "artifact power1" or Reward.item.type == "artifact power2") and checkQuest(FilteredQuests,QUESTS[i][1])==0 then
						FilteredQuests[table.getn(FilteredQuests)+1]=QUESTS[i];
					end
				end
			end
		end
	end
	
	enabled = myCheckButton15:GetChecked();  --selecting Profession quests
	if enabled then 
		for i=1,table.getn(QUESTS) do
			local Reward = QUESTS[i][11];
			if Reward.id == 3 then
				if Reward.item then
					if Reward.item.type == "profession" and checkQuest(FilteredQuests,QUESTS[i][1])==0 then
						FilteredQuests[table.getn(FilteredQuests)+1]=QUESTS[i];
					end
				end
			end
		end
	end
	
	enabled = myCheckButton16:GetChecked();  --selecting Pet Battle quests
	if enabled then 
		for i=1,table.getn(QUESTS) do
			local Reward = QUESTS[i][11];
			if Reward.id == 3 then
				if Reward.item then
					if Reward.item.type == "pet battle" and checkQuest(FilteredQuests,QUESTS[i][1])==0 then
						FilteredQuests[table.getn(FilteredQuests)+1]=QUESTS[i];
					end
				end
			end
		end
	end
	
	enabled = myCheckButton17:GetChecked();  --selecting Miscellaneous quests
	if enabled then 
		for i=1,table.getn(QUESTS) do
			local Reward = QUESTS[i][11];
			if Reward.id == 3 then
				if Reward.item then
					if Reward.item.type == "other" and checkQuest(FilteredQuests,QUESTS[i][1])==0 then
						FilteredQuests[table.getn(FilteredQuests)+1]=QUESTS[i];
					end
				end
			end
		end
	end
	
	local Edges={}
	local minTree={}
	local Odd={}
	local Even={}
	local PerfectMatch={}
	local CombinedGraph={}
	local EulerPath={}
	local FinalPath={}
	local Deadlines = {}
	local SortedQuests = {}
	
	ok=1;
	while ok==1 do
		ok=0;
		Deadlines, Extra = TimeHandling:SetDeadlines(FilteredQuests,5);
		if table.getn(Extra) > 0 then
			FilteredQuests = RemoveExtra:removeUnreachableNodes(FilteredQuests, Extra);
			ok=1;
		end
	end
	Edges =  C:getEdges(FilteredQuests, Constraints);
	minTree = D:getMinCostTree(FilteredQuests,Edges);
	--B:drawGraph(minTree, FilteredQuests);
	Odd, Even = Parity:getParity(FilteredQuests,minTree);
	--PerfectMatch = MPM:getPerfectMatch(FilteredQuests, Odd);
	PerfectMatch = MPM2:getOptimalMatch(minTree, Odd, FilteredQuests)
	CombinedGraph = Combine:getCombinedGraph(minTree,PerfectMatch);
	EulerPath=Euler:getEulerPath(FilteredQuests,CombinedGraph, Deadlines);
	FinalPath=Shortcut:addShortcuts(EulerPath);
	
	
	for i=1,table.getn(FilteredQuests) do
		B:setPoint(QUEST_MAPS[1],0,FilteredQuests[i][5],FilteredQuests[i][6]);
	end
	print(table.getn(EulerPath)..' de noduri in ciclu');
	print(table.getn(FinalPath)..' de noduri in lant');
	B:drawPath(FinalPath, FilteredQuests, QUEST_MAPS, Constraints)
	
	for i=1, table.getn(FinalPath) do
		SortedQuests[i]=FilteredQuests[FinalPath[i]];
	end
	
	makeQuestsVisible(SortedQuests)
	local SelectedQuests={};
	for i=1,table.getn(helloFS) do
		local textR,textG,textB,textA=helloFS[i]:GetTextColor();
		if textR == textA and not(textG == textA) and not(textB == textA) then
			SelectedQuests[table.getn(SelectedQuests)+1]=FilteredQuests[SortedQuests[i]];
			print(FilteredQuests[SortedQuests[i]][2]);
		end
	end
	--for i=1,table.getn(Constrangeri_spatiu[1]) do
	--	B:setConstraintPoint(QUEST_MAPS[1], 0, Constrangeri_spatiu[1][i][1], Constrangeri_spatiu[1][i][2]);
	--end
	
	--B:drawConstraints(Constrangeri_spatiu[1], QUEST_MAPS)
end
	

function hideFrames(QUESTS)
    if table.getn(QUESTS) > 0 then
		for i=1,table.getn(Licenta.self) do
			Licenta.self[i]:Hide();
		
		end
	end
end

function makeQuestsVisible(QUESTS)


Licenta.self={}
helloFS = {}
	for i=1,table.getn(QUESTS) do
		
		Licenta.self[i]=CreateFrame("Frame","Quest"..i,contentFrame)
		if i==1 then
			Licenta.self[i]:SetPoint("TOPLEFT",contentFrame,"TOPLEFT")
		else
		    Licenta.self[i]:SetPoint("TOPLEFT","Quest"..i-1,"BOTTOMLEFT")
		end
		Licenta.self[i]:SetFrameStrata("MEDIUM")
		Licenta.self[i]:SetSize(300,20);
		local texture = Licenta.self[i]:CreateTexture()
		texture:SetAllPoints() 
		--texture:SetColorTexture(1,0,0,1)
		helloFS[i] = Licenta.self[i]:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		--helloFS:SetPoint("LEFT",contentFrame,"RIGHT",0,-(i-1)*20-5);
		helloFS[i]:SetPoint("LEFT","Quest"..i,"LEFT",0,0);
		helloFS[i]:SetText(i..": "..QUESTS[i][2])
		if QUESTS[i][8] == 1 then
			helloFS[i]:SetTextColor(1,1,1,1); --common 
			else if QUESTS[i][8] == 2 then
				helloFS[i]:SetTextColor(0.11,0.56,1,1); --rare
				else helloFS[i]:SetTextColor(0.54,0.16,0.88,1); --epic
				end
		end
		Licenta.self[i]:EnableMouse(True);
		Licenta.self[i]:SetScript("OnMouseDown",function(self, LeftButton)
												local textR,textG,textB,textA=helloFS[i]:GetTextColor();
												--print(textR..' '..textG..' '..textB..' '..textA);
												if QUESTS[i][8] == 1 then
													if textR == textA and textG== textA and textB == textA  then
														helloFS[i]:SetTextColor(1,0,0,1);
													else
														helloFS[i]:SetTextColor(1,1,1,1);
													end
												elseif QUESTS[i][8] ==2 then
													if textB == textA and not(textR == textA) and not(textG == textA) then
														helloFS[i]:SetTextColor(1,0,0,1);
													else
														helloFS[i]:SetTextColor(0.11,0.56,1,1);
													end
												else
													if not(textR == textA) and not(textG == textA) and not (textB == textA) then
														helloFS[i]:SetTextColor(1,0,0,1);
													else
														helloFS[i]:SetTextColor(0.54,0.16,0.88,1);
													end
												end
											end)
														
														
						
		Licenta.self[i]:SetScript("OnEnter", function(self, motion)
												
												GameTooltip:SetOwner(MyFrame, "ANCHOR_RIGHT",-250,-300)
												GameTooltip:SetHyperlink("quest:"..QUESTS[i][1])
												local rep_id=QUESTS[i][3];
												for j=1,table.getn(Factions) do
												    if Factions[j][1]==rep_id then
														GameTooltip:AddLine("Reputation: ")
														if rep_id == 1894 or rep_id==1090 then
															GameTooltip:AddLine("  "..Factions[j][2],0.13, 0.54, 0.13,1)
															local zone = QUESTS[i][10];
															if zone == "Azsuna" then
																GameTooltip:AddLine("  Court of Farondis",0.13, 0.54, 0.13,1);
															end
															if zone == "Val'Sharah" then
																GameTooltip:AddLine("  Dreamweavers",0.13, 0.54, 0.13,1);
															end
															if zone == "Stormheim" then
																GameTooltip:AddLine("  Valarjar",0.13, 0.54, 0.13,1);
															end
															if zone == "Highmountain" then
																GameTooltip:AddLine("  Highmountain Tribe",0.13, 0.54, 0.13,1);
															end
															if zone == "Suramar" then
																GameTooltip:AddLine("  Nightfallen",0.13, 0.54, 0.13,1);
															end
														else
															GameTooltip:AddLine("  "..Factions[j][2],0.13, 0.54, 0.13,1)
														end
													end
												end
												GameTooltip:AddLine("Time left: ")
												local minutes = QUESTS[i][4];
												local hours = minutes / 60;
												local days = hours / 24;
												local duration = "";
												if days >= 1 then
													if math.floor(days) == 1 then
														duration = duration..'1 day';
													else
														duration = duration..math.floor(days)..' days';
													end
													hours = hours - 24 * math.floor(days);
													minutes = minutes - 24 * 60 * math.floor(days);
												end
												
												if hours >= 1 then
													if not (duration == '') then duration = duration..', ' end;
													if math.floor(hours) == 1 then
														duration = duration.. '1 hour'
													else
														duration = duration..math.floor(hours)..' hours';
													end
													minutes = minutes - 60 * math.floor(hours);
												end
												
												if minutes >= 1 then
													if not (duration == '') then duration = duration..', ' end;
													if math.floor(minutes)==1 then
														duration = duration ..'1 minute';
													else
														duration = duration..math.floor(minutes)..' minutes';
													end
												end
												
												if duration == '' then duration = 'Expired' end;
												GameTooltip:AddLine("  "..duration);
												
												GameTooltip:AddLine("Reward");
												local Reward = QUESTS[i][11];
												if Reward.index then
												for k=1,table.getn(Reward.index) do
													local Obj = Reward.index[k];
													if Obj.name == "gold" then
														local wealth = Obj.amount;
														local riches = ""
														local gold = math.floor(wealth/10000);
														riches=riches..gold..' Gold'
														while wealth > 10000 do
															wealth=wealth-math.floor(wealth/10);
														end
														local silver = math.floor(wealth/100);
														if silver > 0 then
															if not (riches == '') then
																riches=riches..', ';
															end
															riches = riches..silver..' Silver';
														end
														while wealth > 100 do
														wealth=wealth-math.floor(wealth/10);
														end
														local copper = math.floor(wealth);
														if copper > 0 then
															if not(riches == '') then
																riches = riches..', ';
															end
															riches = riches..copper..' Copper';
														end
														GameTooltip:AddLine('  '..riches);
														
													end
													if Obj.name == "Nethershard" then
														GameTooltip:AddLine("  "..Obj.amount.." Nethershards");
													end
													if Obj.name == "Order Resources" then
														GameTooltip:AddLine("  "..Obj.amount.." Order Resources");
													end
													if Obj.name == 'Legionfall War Supplies' then
														GameTooltip:AddLine("  "..Obj.amount.." Legionfall War Supplies");
													end
												end
												end
												if Reward.item then
													if Reward.item.type == "wearable" then
														GameTooltip:AddLine("  Wearable");
													end
													if Reward.item.type == "artifact power1" then
														GameTooltip:AddLine("  "..Reward.item.amount.." Artifact Power");
													end
													if Reward.item.type == "artifact power2" then
														GameTooltip:AddLine("  "..Reward.item.amount.." million Artifact Power");
													end
													if Reward.item.type == "profession" then
														GameTooltip:AddLine("  "..Reward.item.amount.." x "..Reward.item.name);
													end
													if Reward.item.type == "pet battle" then
														GameTooltip:AddLine("  "..Reward.item.amount.." x "..Reward.item.name);
													end
													if Reward.item.type == "other" then
														GameTooltip:AddLine(" " ..Reward.item.name);
													end
													
												end
												
												GameTooltip:Show()
											end)
		Licenta.self[i]:SetScript("OnLeave", function(self, motion)
												GameTooltip:Hide()
											end)
											
									
	end
	
end


function loadFrame()

local backdrop = {
  -- path to the background texture
  bgFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Background",  
  -- path to the border texture
  edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border",
  -- true to repeat the background texture to fill the frame, false to scale it
  tile = true,
  -- size (width or height) of the square repeating background tiles (in pixels)
  tileSize = 32,
  -- thickness of edge segments and square size of edge corners (in pixels)
  edgeSize = 32,
  -- distance from the edges of the frame to those of the background texture (in pixels)
  insets = {
    left = 11,
    right = 12,
    top = 12,
    bottom = 11
  }
}
 
-- replaces the game menu's backdrop with the gold backdrop 
-- used in Bind-On-Pickup loot roll frames
--mainPanel:SetBackdrop(backdrop)

	local frame = CreateFrame("Frame", "MyFrame", mainPanel) 
	frame:SetSize(768, 512) 
	frame:SetPoint("LEFT",25,0) 
	frame:SetClampedToScreen(true)
	frame:SetHitRectInsets(0,0,0,0)
	local texture1 = frame:CreateTexture() 
	texture1:SetAllPoints() 
	texture1:SetColorTexture(0,0,0,0.1) 
	frame.background = texture1
    frame:SetScale(0.75)	

    scrollframe = CreateFrame("ScrollFrame", nil, frame) 
	scrollframe:SetPoint("TOPLEFT", 10, -10) 
	scrollframe:SetPoint("BOTTOMRIGHT", -10, 10) 
	local texture2 = scrollframe:CreateTexture() 
	texture2:SetAllPoints() 
	texture2:SetColorTexture(0,0,0,0.75) 
	frame.scrollframe = scrollframe
	
	scrollbar = CreateFrame("Slider", nil, scrollframe, "UIPanelScrollBarTemplate") 
	scrollbar:SetPoint("TOPLEFT", frame, "TOPRIGHT", 4, -16) 
	scrollbar:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 4, 16) 
	scrollbar:SetMinMaxValues(1, table.getn(QUESTS)*15); 
	scrollbar:SetValueStep(1) 
	scrollbar.scrollStep = 1
	scrollbar:SetValue(0) 
	scrollbar:SetWidth(16) 
	scrollbar:SetScript("OnValueChanged", 
	function (self, value) 
	self:GetParent():SetVerticalScroll(value) 
	end) 
	local scrollbg = scrollbar:CreateTexture(nil, "BORDER") 
	scrollbg:SetAllPoints(scrollbar) 
	scrollbg:SetColorTexture(0, 0, 0,0.4) 
	frame.scrollbar = scrollbar
	
	local content = CreateFrame("Frame", "contentFrame", scrollframe) 
	content:SetSize(1024, 512) 
	local texture = content:CreateTexture() 
	texture:SetAllPoints() 
	--texture:SetTexture("Interface\\Destiny\\EndscreenBG") 
	content.texture = texture 
	scrollframe.content = content
    content:SetScale(1.5)	
 
	scrollframe:SetScrollChild(content)
	



	
myCheckButton1 = CreateFrame("CheckButton", "Check_rep_1", mainPanel, "ChatConfigCheckButtonTemplate");
myCheckButton1:SetPoint("TOPRIGHT", -350, -60);
myCheckButton1:SetSize(30,30)
getglobal(myCheckButton1:GetName() .. 'Text'):SetText("Armies of Legionfall");
CheckButtons[1]=myCheckButton1;

local figure1 = CreateFrame("Frame", "figure1", mainPanel)
figure1:SetSize(20,20)
figure1:SetPoint("TOPRIGHT",-355,-65)
local texture1 = figure1:CreateTexture(nil, "BORDER")
texture1:SetAllPoints()
texture1:SetTexture("Interface\\Icons\\Achievement_Faction_Legionfall")
figure1.texture = texture1; 
	
myCheckButton2 = CreateFrame("CheckButton", "Check_rep_2", mainPanel, "ChatConfigCheckButtonTemplate");
myCheckButton2:SetPoint("TOPLEFT", Check_rep_1, "TOPLEFT",0,-30);
myCheckButton2:SetSize(30,30)
getglobal(myCheckButton2:GetName() .. 'Text'):SetText("Court of Farondis");
CheckButtons[2]=myCheckButton2;

local figure2 = CreateFrame("Frame", "figure2", mainPanel)
figure2:SetSize(20,20)
figure2:SetPoint("TOPLEFT",figure1,"TOPLEFT",0,-30)
local texture2 = figure2:CreateTexture(nil, "BORDER")
texture2:SetAllPoints()
texture2:SetTexture("Interface\\Icons\\INV_Legion_Faction_CourtofFarnodis")
figure2.texture = texture2; 


myCheckButton3 = CreateFrame("CheckButton", "Check_rep_3", mainPanel, "ChatConfigCheckButtonTemplate");
myCheckButton3:SetPoint("TOPLEFT", Check_rep_2, "TOPLEFT",0,-30);
myCheckButton3:SetSize(30,30)
getglobal(myCheckButton3:GetName() .. 'Text'):SetText("Dreamweavers");
CheckButtons[3]=myCheckButton3;

local figure3 = CreateFrame("Frame", "figure3", mainPanel)
figure3:SetSize(20,20)
figure3:SetPoint("TOPLEFT",figure2,"TOPLEFT",0,-30)
local texture3 = figure3:CreateTexture(nil, "BORDER")
texture3:SetAllPoints()
texture3:SetTexture("Interface\\Icons\\INV_Legion_Faction_DreamWeavers")
figure3.texture = texture3; 


myCheckButton4 = CreateFrame("CheckButton", "Check_rep_4", mainPanel, "ChatConfigCheckButtonTemplate");
myCheckButton4:SetPoint("TOPLEFT", Check_rep_3, "TOPLEFT",0,-30);
myCheckButton4:SetSize(30,30)
getglobal(myCheckButton4:GetName() .. 'Text'):SetText("Highmountain Tribe");
CheckButtons[4]=myCheckButton4;

local figure4 = CreateFrame("Frame", "figure4", mainPanel)
figure4:SetSize(20,20)
figure4:SetPoint("TOPLEFT",figure3,"TOPLEFT",0,-30)
local texture4 = figure4:CreateTexture(nil, "BORDER")
texture4:SetAllPoints()
texture4:SetTexture("Interface\\Icons\\INV_Legion_Faction_HightmountainTribes")
figure4.texture = texture4;

	
myCheckButton5 = CreateFrame("CheckButton", "Check_rep_5", mainPanel, "ChatConfigCheckButtonTemplate");
myCheckButton5:SetPoint("TOPLEFT", Check_rep_4, "TOPLEFT",0,-30);
myCheckButton5:SetSize(30,30)
getglobal(myCheckButton5:GetName() .. 'Text'):SetText("Kirin Tor");
CheckButtons[5]=myCheckButton5;

local figure5 = CreateFrame("Frame", "figure5", mainPanel)
figure5:SetSize(20,20)
figure5:SetPoint("TOPLEFT",figure4,"TOPLEFT",0,-30)
local texture5 = figure5:CreateTexture(nil, "BORDER")
texture5:SetAllPoints()
texture5:SetTexture("Interface\\Icons\\INV_Legion_Faction_KirinTor")
figure5.texture = texture5;



myCheckButton6 = CreateFrame("CheckButton", "Check_rep_6", mainPanel, "ChatConfigCheckButtonTemplate");
myCheckButton6:SetPoint("TOPLEFT", Check_rep_5, "TOPLEFT",0,-30);
myCheckButton6:SetSize(30,30)
getglobal(myCheckButton6:GetName() .. 'Text'):SetText("Nightfallen");
CheckButtons[6]=myCheckButton6;

local figure6 = CreateFrame("Frame", "figure6", mainPanel)
figure6:SetSize(20,20)
figure6:SetPoint("TOPLEFT",figure5,"TOPLEFT",0,-30)
local texture6 = figure6:CreateTexture(nil, "BORDER")
texture6:SetAllPoints()
texture6:SetTexture("Interface\\Icons\\INV_Legion_Faction_NightFallen")
figure6.texture = texture6;


myCheckButton7 = CreateFrame("CheckButton", "Check_rep_7", mainPanel, "ChatConfigCheckButtonTemplate");
myCheckButton7:SetPoint("TOPLEFT", Check_rep_6, "TOPLEFT",0,-30);
myCheckButton7:SetSize(30,30)
getglobal(myCheckButton7:GetName() .. 'Text'):SetText("Valarjar");
CheckButtons[7]=myCheckButton7;

local figure7 = CreateFrame("Frame", "figure7", mainPanel)
figure7:SetSize(20,20)
figure7:SetPoint("TOPLEFT",figure6,"TOPLEFT",0,-30)
local texture7 = figure7:CreateTexture(nil, "BORDER")
texture7:SetAllPoints()
texture7:SetTexture("Interface\\Icons\\INV_Legion_Faction_Valarjar")
figure7.texture = texture7;

myCheckButton8 = CreateFrame("CheckButton", "Check_rep_8", mainPanel, "ChatConfigCheckButtonTemplate");
myCheckButton8:SetPoint("TOPLEFT", Check_rep_7, "TOPLEFT",0,-30);
myCheckButton8:SetSize(30,30)
getglobal(myCheckButton8:GetName() .. 'Text'):SetText("Wardens");
CheckButtons[8]=myCheckButton8;

local figure8 = CreateFrame("Frame", "figure8", mainPanel)
figure8:SetSize(20,20)
figure8:SetPoint("TOPLEFT",figure7,"TOPLEFT",0,-30)
local texture8 = figure8:CreateTexture(nil, "BORDER")
texture8:SetAllPoints()
texture8:SetTexture("Interface\\Icons\\INV_Legion_Faction_Warden")
figure8.texture = texture8;

myCheckButton9 = CreateFrame("CheckButton", "Check_rep_9", mainPanel, "ChatConfigCheckButtonTemplate");
myCheckButton9:SetPoint("TOPRIGHT",-175,-50);
myCheckButton9:SetSize(30,30)
getglobal(myCheckButton9:GetName() .. 'Text'):SetText("Gold");
CheckButtons[9]=myCheckButton9;

local figure9 = CreateFrame("Frame", "figure9", mainPanel)
figure9:SetSize(20,20)
figure9:SetPoint("TOPRIGHT",-180,-55)
local texture9 = figure9:CreateTexture(nil, "BORDER")
texture9:SetAllPoints()
texture9:SetTexture("Interface\\Icons\\INV_Misc_Coin_01")
figure9.texture = texture9;

myCheckButton10 = CreateFrame("CheckButton", "Check_rep_10", mainPanel, "ChatConfigCheckButtonTemplate");
myCheckButton10:SetPoint("TOPLEFT", Check_rep_9, "TOPLEFT",0,-30);
myCheckButton10:SetSize(30,30)
getglobal(myCheckButton10:GetName() .. 'Text'):SetText("Nethershards");
CheckButtons[10]=myCheckButton10;

local figure10 = CreateFrame("Frame", "figure10", mainPanel)
figure10:SetSize(20,20)
figure10:SetPoint("TOPLEFT",figure9,"TOPLEFT",0,-30)
local texture10 = figure10:CreateTexture(nil, "BORDER")
texture10:SetAllPoints()
texture10:SetTexture("Interface\\Icons\\INV_DataCrystal01")
figure10.texture = texture10;

myCheckButton11 = CreateFrame("CheckButton", "Check_rep_11", mainPanel, "ChatConfigCheckButtonTemplate");
myCheckButton11:SetPoint("TOPLEFT", Check_rep_10, "TOPLEFT",0,-30);
myCheckButton11:SetSize(30,30)
getglobal(myCheckButton11:GetName() .. 'Text'):SetText("Order Resources");
CheckButtons[11]=myCheckButton11;

local figure11 = CreateFrame("Frame", "figure11", mainPanel)
figure11:SetSize(20,20)
figure11:SetPoint("TOPLEFT",figure10,"TOPLEFT",0,-30)
local texture11 = figure11:CreateTexture(nil, "BORDER")
texture11:SetAllPoints()
texture11:SetTexture("Interface\\Icons\\INV_OrderHall_OrderResources")
figure11.texture = texture11;

myCheckButton12 = CreateFrame("CheckButton", "Check_rep_12", mainPanel, "ChatConfigCheckButtonTemplate");
myCheckButton12:SetPoint("TOPLEFT", Check_rep_11, "TOPLEFT",0,-30);
myCheckButton12:SetSize(30,30)
getglobal(myCheckButton12:GetName() .. 'Text'):SetText("Legionfall Supplies");
CheckButtons[12]=myCheckButton12;

local figure12 = CreateFrame("Frame", "figure12", mainPanel)
figure12:SetSize(20,20)
figure12:SetPoint("TOPLEFT",figure11,"TOPLEFT",0,-30)
local texture12 = figure12:CreateTexture(nil, "BORDER")
texture12:SetAllPoints()
texture12:SetTexture("Interface\\Icons\\INV_Misc_Summonable_Boss_Token")
figure12.texture = texture12;

myCheckButton13 = CreateFrame("CheckButton", "Check_rep_13", mainPanel, "ChatConfigCheckButtonTemplate");
myCheckButton13:SetPoint("TOPLEFT", Check_rep_12, "TOPLEFT",0,-30);
myCheckButton13:SetSize(30,30)
getglobal(myCheckButton13:GetName() .. 'Text'):SetText("Equipment");
CheckButtons[13]=myCheckButton13;

local figure13 = CreateFrame("Frame", "figure13", mainPanel)
figure13:SetSize(20,20)
figure13:SetPoint("TOPLEFT",figure12,"TOPLEFT",0,-30)
local texture13 = figure13:CreateTexture(nil, "BORDER")
texture13:SetAllPoints()
texture13:SetTexture("Interface\\Icons\\Garrison_PurpleArmor")
figure13.texture = texture13;

myCheckButton14 = CreateFrame("CheckButton", "Check_rep_14", mainPanel, "ChatConfigCheckButtonTemplate");
myCheckButton14:SetPoint("TOPLEFT", Check_rep_13, "TOPLEFT",0,-30);
myCheckButton14:SetSize(30,30)
getglobal(myCheckButton14:GetName() .. 'Text'):SetText("Artifact Power");
CheckButtons[14]=myCheckButton14;

local figure14 = CreateFrame("Frame", "figure14", mainPanel)
figure14:SetSize(20,20)
figure14:SetPoint("TOPLEFT",figure13,"TOPLEFT",0,-30)
local texture14 = figure14:CreateTexture(nil, "BORDER")
texture14:SetAllPoints()
texture14:SetTexture("Interface\\Icons\\INV_Artifact_tome01")
figure14.texture = texture14;

myCheckButton15 = CreateFrame("CheckButton", "Check_rep_15", mainPanel, "ChatConfigCheckButtonTemplate");
myCheckButton15:SetPoint("TOPLEFT", Check_rep_14, "TOPLEFT",0,-30);
myCheckButton15:SetSize(30,30)
getglobal(myCheckButton15:GetName() .. 'Text'):SetText("Profession");
CheckButtons[15]=myCheckButton15;

local figure15 = CreateFrame("Frame", "figure15", mainPanel)
figure15:SetSize(20,20)
figure15:SetPoint("TOPLEFT",figure14,"TOPLEFT",0,-30)
local texture15 = figure15:CreateTexture(nil, "BORDER")
texture15:SetAllPoints()
texture15:SetTexture("Interface\\Icons\\Achievement_Faction_Craftsman")
figure15.texture = texture15;

myCheckButton16 = CreateFrame("CheckButton", "Check_rep_16", mainPanel, "ChatConfigCheckButtonTemplate");
myCheckButton16:SetPoint("TOPLEFT", Check_rep_15, "TOPLEFT",0,-30);
myCheckButton16:SetSize(30,30)
getglobal(myCheckButton16:GetName() .. 'Text'):SetText("Pet Battles");
CheckButtons[16]=myCheckButton16;

local figure16 = CreateFrame("Frame", "figure16", mainPanel)
figure16:SetSize(20,20)
figure16:SetPoint("TOPLEFT",figure15,"TOPLEFT",0,-30)
local texture16 = figure16:CreateTexture(nil, "BORDER")
texture16:SetAllPoints()
texture16:SetTexture("Interface\\Icons\\Icon_UpgradeStone_Beast_Legendary")
figure16.texture = texture16;

myCheckButton17 = CreateFrame("CheckButton", "Check_rep_17", mainPanel, "ChatConfigCheckButtonTemplate");
myCheckButton17:SetPoint("TOPLEFT", Check_rep_16, "TOPLEFT",0,-30);
myCheckButton17:SetSize(30,30)
getglobal(myCheckButton17:GetName() .. 'Text'):SetText("Miscellaneous");
CheckButtons[17]=myCheckButton17;

local figure17 = CreateFrame("Frame", "figure17", mainPanel)
figure17:SetSize(20,20)
figure17:SetPoint("TOPLEFT",figure16,"TOPLEFT",0,-30)
local texture17 = figure17:CreateTexture(nil, "BORDER")
texture17:SetAllPoints()
texture17:SetTexture("Interface\\Icons\\Ability_Rogue_RolltheBones")
figure17.texture = texture17;



end
---------------------------------------------------------------------------------------------


function selectAll()
	for i=1,table.getn(CheckButtons) do
		CheckButtons[i]:SetChecked(true);
	end
	
end

function deselectAll()
	for i=1,table.getn(CheckButtons) do
		CheckButtons[i]:SetChecked(false);
	end
	
end




--B:drawGraph(G);
--B:drawPath(shortcut);

--for i=1,table.getn(Parity) do
--    B:setOddPoints(QUEST_MAPS[1],0,QUESTS[Parity[i]][5],QUESTS[Parity[i]][6]);
--end


SLASH_PATHFINDER1 = "/pathf"
SLASH_PATHFINDER2 = "/pathfinder"
SlashCmdList["PATHFINDER"] = function(self, txt)
	if mainPanel:IsVisible() then
		mainPanel:Hide();
	else
		mainPanel:Show();
	end
end









