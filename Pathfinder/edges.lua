C={}




function C:getEdges(QUESTS, Constraints)
	local M = {}
	local Muchie={}
	local DetaliiPtrDesenat={}

         -- create the matrix
	for i=1,table.getn(QUESTS) do
		M[i] = {}     -- create a new row
		for j=1,table.getn(QUESTS) do
			M[i][j] = 0
		end
	end


	local nr_muchii=0;
	for i=1,table.getn(QUESTS)-1 do
		local x1 = QUESTS[i][5]*100;
		local y1 = QUESTS[i][6]*100;
		for j=i+1,table.getn(QUESTS) do
			if i==j then 
				M[i][j]=0
			else 
				local x2 = QUESTS[j][5]*100;
				local y2 = QUESTS[j][6]*100;
				param=0;
				
				--if QUESTS[i][2]=='Sharptalon Swarm!' or QUESTS[j][2]=='Sharptalon Swarm!' then 
				--	print(QUESTS[i][2]..' '..QUESTS[j][2]);
				--end
				
				-- verificam daca muchia se intersecteaza cu o constrangere
				local intersectii = Const:checkConstraints(x1,y1,x2,y2,Constraints);
				
				--if table.getn(intersectii)>0 then 
				--	print(QUESTS[i][2]..' '..QUESTS[j][2]..' '..table.getn(intersectii));
				--end
				
				local dist = 0;
				local dist_de_eliminat=0;
				local indice_path=0;
				if table.getn(intersectii)>=2 then
					intersectii = Const:sorteazaIntersectii(x1,y1,x2,y2,intersectii); --sortam punctele in intersectii dupa ordinea intrarilor si iesirilor din zona constrangerilor
					dist, dist_de_eliminat, indice_path = Const:distantaOcoliriiObstacolului(intersectii, Constraints)
				end
				
				M[i][j]=math.sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1)) - dist_de_eliminat + dist; -- distanta dintre 2 quests e distanta dintre 2 puncte in plan, cu coordonatele date
				nr_muchii=nr_muchii+1;
				Muchie[nr_muchii]={M[i][j],i,j,indice_path, intersectii, Constraints};
		 
			end
		end
	end

	if table.getn(Muchie) > 1 then
		local aux; --ordonam muchiile dupa distanta dintre misiuni
		local swapped = true;
		local j=0;
		while swapped do
			swapped=false;
			for i=1,table.getn(Muchie)-j-1 do
				if Muchie[i][1]>Muchie[i+1][1] then
				aux=Muchie[i];
				Muchie[i]=Muchie[i+1];
				Muchie[i+1]=aux;
				swapped=true;
				end
			end
		j=j+1;
		end
	end
	--for i=1,table.getn(Muchie) do
	--	print(Muchie[i][1]);
	--end
	return Muchie, DetaliiPtrDesenat;

end

