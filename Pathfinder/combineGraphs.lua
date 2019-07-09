Combine = {}

local MST = D.Edges;
local MPM = MPM.MinPerfectMatch;
local G = {}



function Combine:checkEdge(MST,x)
    for i=1,table.getn(MST) do
        if ((x[2]==MST[i][2] and x[3]==MST[i][3]) or (x[2]==MST[i][3] and x[3]==MST[i][2])) then
		    return 1;
	    end
	end
	return 0;
end

--for i=1,table.getn(MPM) do
--    print(MPM[i][1]);
--    print(QUESTS[MPM[i][2]][2]);
--	print(QUESTS[MPM[i][3]][2]);
--end

function Combine:getCombinedGraph(MST,MPM)
    
	local G={};
	
	for i=1,table.getn(MST) do
	    G[table.getn(G)+1]=MST[i];
	end

	for i=1,table.getn(MPM) do
	    G[table.getn(G)+1]=MPM[i];
	end

    return G;
end