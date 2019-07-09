D={}

function D:getMinCostTree(QUESTS,Muchie)
	Edges={};
	Groups={};
	i=0;

	function D:hasValue(Groups, x)
		for i=1,table.getn(Groups) do
			for j=1,table.getn(Groups[i]) do
				if Groups[i][j] == x then 
					return i;
				end
			end
		end
		return 0;
	end

	for i=1,table.getn(QUESTS) do
		Groups[i]={i,}
	end

	while table.getn(Edges) < table.getn(QUESTS)-1 do --generam cu algoritmul lui Kruskal arborele de cost minim dintre quests
		i=i+1;
		if Muchie[i][2] <= Muchie [i][3] then
			v1 = Muchie[i][2];
			v2 = Muchie[i][3];
		else
			v1 = Muchie[i][3];
			v2 = Muchie[i][2];
		end
		indice1= D:hasValue(Groups, v1);
		indice2= D:hasValue(Groups, v2);
		if indice1==0 or indice2==0 then print('BAD FUNCTION HANDLING') end;
		if not (indice1 == indice2) then
			n = table.getn(Groups[indice1]);
			for k=1,table.getn(Groups[indice2]) do
		       Groups[indice1][n+k]=Groups[indice2][k];
		       Groups[indice2][k]=0;
			end
			Edges[table.getn(Edges)+1]=Muchie[i];
			
		end
	
	
	end

    return Edges;
end