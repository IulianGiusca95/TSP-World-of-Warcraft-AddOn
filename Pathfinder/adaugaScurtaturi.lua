Shortcut={}


function Shortcut:checkVisited(visited,x)
		for i=1,table.getn(visited) do
			if visited[i]==x then return 1;
			end
		end
		return 0;
end

function Shortcut:addShortcuts(path)
	local finalPath={};

	

	for i=1,table.getn(path) do
		if Shortcut:checkVisited(finalPath,path[i])==0 then
			finalPath[table.getn(finalPath)+1]=path[i];
		end
	end

--for i=1,table.getn(finalPath) do
--    print(path[i].." "..finalPath[i]);
--end

--if(table.getn(finalPath)==table.getn(Quests)) then print('Perfect') else print('Nu e perfect') end
--print(table.getn(path).." "..table.getn(Quests).." "..table.getn(finalPath).." "..table.getn(Combine.G));

	return finalPath;
end