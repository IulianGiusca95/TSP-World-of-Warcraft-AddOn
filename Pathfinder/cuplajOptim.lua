MPM2 = {}

function MPM2:check(nod,v)
	for j=1,table.getn(v) do
		if v[j]==nod then
			return 1;
		end
	end
	return 0;
end

function MPM2:determineLongestBranch(Edges,start,v,distance,Quests)
	local nr_succesori = 0;
	local parcurgere = {};
	local distante = {};
	local D_return= 0;
	local V_return={};
	local V = {};
	local ok=0;
	for i = 1, table.getn(Edges) do
		if Edges[i][2]==start or Edges[i][3]==start then
			local succesor = -1;
			if Edges[i][2]==start then
				succesor = Edges[i][3]
			else
				succesor = Edges[i][2]
			end
			if MPM2:check(succesor,v) == 0 then
				nr_succesori = nr_succesori +1;
				V[nr_succesori]={};
				parcurgere[nr_succesori]=succesor;
				distante[nr_succesori]= distance + Edges[i][1];
				for k=1,table.getn(v) do
					V[nr_succesori][k]=v[k];
				end
				V[nr_succesori][table.getn(v)+1]=start;
				--print (Quests[start][2]..'->'..Quests[parcurgere[nr_succesori]][2]..table.getn(V[nr_succesori]));
			end
		end
	end
	for i=1,nr_succesori do
		local d2,v2 = MPM2:determineLongestBranch(Edges,parcurgere[i],V[i],distante[i],Quests);
		if d2 > D_return then
			D_return = d2;
			V_return = v2;
		end
		ok=1;
	end
	if ok==0 then
		local v_aux={};
		for k=1,table.getn(v) do
					v_aux[k]=v[k];
		end
		v_aux[table.getn(v_aux)+1]=start;
		return distance,v_aux;
	else
		return D_return, V_return;
	end
end

function MPM2:parcurgeSubarbore(poz, branch, Edges, grad, vizitat)
	local v2= {}
	for i=1,table.getn(vizitat) do
		v2[i]=vizitat[i];
	end
	local retval ={};
	local indice_retval = 0;
	for i=1, table.getn(Edges) do
		local succ = 0;
		if Edges[i][2] == poz or Edges[i][3]==poz then
			if Edges[i][2] == poz then
				succ = Edges[i][3];
			else
				succ = Edges[i][2];
			end
			if MPM2:check(succ, v2) == 0 then
				v2[table.getn(v2)+1]=poz;
				return_odd = MPM2:parcurgeSubarbore(succ, branch, Edges, grad, v2);
				for k=1,table.getn(return_odd) do
					indice_retval = indice_retval+1;
					retval[indice_retval]=return_odd[k];
				end
			end
		end
	end
	if grad[poz] % 2 == 1 then
		indice_retval = indice_retval + 1;
		retval[indice_retval]=poz;
	end
	return retval;
end

function MPM2:parcurgere(poz_curenta,branch, Edges, grad, Quests)
	--print(Quests[branch[poz_curenta]][2]..' '..poz_curenta)
	if poz_curenta == table.getn(branch)+1 then
		--print (poz_curenta);
		return {};
	end
	local V = {};
	local indice_V = 0;
	for i=1,table.getn(Edges) do
		local succesor = -1;
		if Edges[i][2] == branch[poz_curenta] or Edges[i][3] == branch[poz_curenta] then
			if Edges[i][2] == branch[poz_curenta] then
				succesor = Edges[i][3];
			else
				succesor = Edges[i][2];
			end
			local odd_points={}
			if poz_curenta==1 then
				if not	(succesor == branch[poz_curenta+1]) then
					--print(Quests[branch[poz_curenta]][2]..'->'..Quests[succesor][2]);
					odd_points=MPM2:parcurgeSubarbore(succesor, branch, Edges, grad, {branch[poz_curenta]})
				end
			else
				if not	(succesor == branch[poz_curenta+1] or succesor == branch[poz_curenta-1]) then
					--print(Quests[branch[poz_curenta]][2]..'->'..Quests[succesor][2]);
					odd_points=MPM2:parcurgeSubarbore(succesor, branch, Edges, grad, {branch[poz_curenta]})
				end
			end
			for k=1,table.getn(odd_points) do
				indice_V = indice_V + 1;
				V[indice_V] = odd_points[k];
			end
				
		end
	end
	if grad[branch[poz_curenta]] % 2 == 1 then
		indice_V = indice_V + 1;
		V[indice_V] = branch[poz_curenta]
		--print(poz_curenta);
	end
	local V_returned = MPM2:parcurgere(poz_curenta+1, branch, Edges, grad, Quests);
	for k=1,table.getn(V_returned) do
		indice_V = indice_V + 1;
		V[indice_V] = V_returned[k];
	end
	return V;
end

function MPM2:getOptimalMatch(Edges, Odd, Quests)
	
	--determinam pozitia curenta a jucatorului, si gasim cea mai apropiata misiune din arbore; aceea va fi "radacina" arborelui de cost minim
	SetMapZoom(8);
	local posX, posY = GetPlayerMapPosition("player");
	
	local minim=99999;
	local indice = -1;
	for i=1,table.getn(Quests) do
		local x = Quests[i][5];
		local y = Quests[i][6];
		dist = Distance:getDistance(posX,x,posY,y);
		if dist < minim then
			minim=dist;
			indice=i;
		end
	end

	-- determinam cea mai lunga ramura a arborelui de cost minim
	-- folosim o metoda DFS
	local visited={};
	local distance = 0;
	local distMax = -1;
	local longestBranch = {};
	if not(indice == -1) then
		distMax, longestBranch= MPM2:determineLongestBranch(Edges,indice, visited,distance, Quests)
	else print('Cuplaj Optim - bad indice')
	end
	
	-- determinam gradele tuturor nodurilor din arbore
	local grad={};
	for i=1,table.getn(Quests) do
		grad[i]=0;
	end
	for i=1,table.getn(Edges) do
		grad[Edges[i][2]]=grad[Edges[i][2]]+1;
		grad[Edges[i][3]]=grad[Edges[i][3]]+1;
	end
	
	--incepem parcurgere de la nodul de start pe lungimea bratului cel mai lung, si cautam ramificatii ce nu tin de drumul marcat;
	
	ceva = MPM2:parcurgere(1,longestBranch, Edges, grad, Quests);
	--for i=1,table.getn(ceva) do
	--	print(Quests[ceva[i]][2]);
	--end
	
	--for i=1,table.getn(Quests) do
	--	print(Quests[i][2]..' '..grad[i]);
	--end

	--for i=1,table.getn(longestBranch) do
	--	print(Quests[longestBranch[i]][2]);
	--end
	
	--print(table.getn(longestBranch)..' '..table.getn(Edges)..' '..table.getn(Quests));
	--for i=1,table.getn(longestBranch) do
	--	print(Quests[longestBranch[i]][2]);
	--end
	PerfectMatch={};
	if table.getn(ceva) % 2 == 1 then 
		print('Error - cuplaj imperfect');
	else
		for i=1,table.getn(ceva)/2 do
			local Muchie = {};
			local Quest1 = Quests[ceva[2*i-1]];
			local Quest2 = Quests[ceva[2*i]];
			local dist = Distance:getDistance(Quest1[5],Quest2[5],Quest2[6],Quest2[6]);
			Muchie = {dist, ceva[2*i-1],ceva[2*i]};
			PerfectMatch[i]=Muchie;
		end
	end
	
	--for i=1,table.getn(Quests) do
	--	B:setPoint(QUEST_MAPS[1],0,Quests[i][5],Quests[i][6]);
	--end
	
	--B:drawGraph(Edges, Quests);
	return PerfectMatch;
end