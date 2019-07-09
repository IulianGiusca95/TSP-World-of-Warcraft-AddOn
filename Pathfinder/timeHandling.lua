TimeHandling ={}

function TimeHandling:SetDeadlines(Quests,minutesPerQuest)
    local Deadlines={}
	local ImpossibleToReach={}
	
	for i=1,table.getn(Quests) do
		Deadlines[i]=-1;
	end
	maxtime=table.getn(Quests)*minutesPerQuest;
	for i = 1,table.getn(Quests) do
		--print(Quests[i][2].." "..Quests[i][4])
		if Quests[i][4] < maxtime then
			poz = math.ceil(Quests[i][4] / minutesPerQuest);
			if Deadlines[poz] == -1 then
				Deadlines[poz] = i;
			else
				local ok=0;
				while poz > 0 do 					
					poz = poz-1;
					if Deadlines[poz] == -1 then
						Deadlines[poz] = i;
						ok=1;
						break;
					end
					
				end
				if ok == 0 then
					print("The Quest "..Quests[i][2].." can't be completed in the given time. Please reconsider the choices" )
					ImpossibleToReach[table.getn(ImpossibleToReach)+1]=Quests[i];
				end
			end
		else
			Deadlines[i] = -1;
		end
	end
	
	for i=1,table.getn(Quests) do
		if not (Deadlines[i] == -1) then
			print(Quests[Deadlines[i]][2].." cu timpul "..Quests[Deadlines[i]][4]..": pozitia "..i);
		end
	end
	
	return Deadlines, ImpossibleToReach;
end