MPM={}

function MPM:isInactive(Inactive, x)
    for i=1,table.getn(Inactive) do
	    if Inactive[i] == x then
		   return 1;
		end
    end
	return 0;
end

function MPM:getPerfectMatch(Quests,Active)

	local PerfectMatch = {};
	local Inactive={};
	local Muchii_noi= {};
	for i=1,table.getn(Active)-1 do
		for j=i+1, table.getn(Active) do
			local dist = Distance:getDistance(Quests[Active[i]][5],Quests[Active[j]][5],Quests[Active[i]][6],Quests[Active[j]][6]);
			Muchii_noi[table.getn(Muchii_noi)+1] = {dist, i, j};
		end
	end
	
	--sorteaza tabelul de muchii noi dupa distanta dintre misiuni
	if table.getn(Muchii_noi) > 1 then
		local aux; --ordonam muchiile dupa distanta dintre misiuni
		local swapped = true;
		local j=0;
		while swapped do
			swapped=false;
			for i=1,table.getn(Muchii_noi)-j-1 do
				if Muchii_noi[i][1]>Muchii_noi[i+1][1] then
				aux=Muchii_noi[i];
				Muchii_noi[i]=Muchii_noi[i+1];
				Muchii_noi[i+1]=aux;
				swapped=true;
				end
			end
		j=j+1;
		end
	end
	for i=1,table.getn(Muchii_noi) do
		if MPM:isInactive(Inactive,Muchii_noi[i][2])==0 and MPM:isInactive(Inactive,Muchii_noi[i][3])==0 then
			PerfectMatch[table.getn(PerfectMatch)+1]=Muchii_noi[i];
			Inactive[table.getn(Inactive)+1]=Muchii_noi[i][2];
			Inactive[table.getn(Inactive)+1]=Muchii_noi[i][3];
		end
	end

	--for i=1,table.getn(Active) do
	--	if MPM:isInactive(Inactive,i)==0 then
	--		local minim=99999;
	--		for j=1,table.getn(Active) do
	--			if MPM:isInactive(Inactive, j)==0 and not(i==j) then
	--				x = Distance:getDistance(Quests[Active[i]][5],Quests[Active[j]][5],Quests[Active[i]][6],Quests[Active[j]][6]);
	--				if x < minim then
	--					minim = x;
	--					indice1=i;
	--					indice2=j;
	--				end
	--			end
	--		end
	--		PerfectMatch[table.getn(PerfectMatch)+1]={minim,Active[indice1],Active[indice2]};
	--		Inactive[table.getn(Inactive)+1]=indice1;
	--		Inactive[table.getn(Inactive)+1]=indice2;
	--	end
	--end

	    
	return PerfectMatch;  

end  	

