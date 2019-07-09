RemoveExtra={}

function RemoveExtra:removeUnreachableNodes(Quests, UnreachableQuests)
	Q = {}
	
	for i=1,table.getn(Quests) do
		local isUnreachable=0;
		
		for j=1,table.getn(UnreachableQuests) do
			if UnreachableQuests[j][1] == Quests[i][1] then
				isUnreachable = 1;
				break;
			end
		end
		
		if isUnreachable == 0 then
			Q[table.getn(Q)+1]=Quests[i];
		end
	end
	
	return Q;
end