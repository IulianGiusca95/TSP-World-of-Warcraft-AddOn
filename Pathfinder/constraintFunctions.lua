Const = {}

function Const:checkConstraints(x1,y1,x2,y2,Constraints)
	local Intersectii = {};
	local c1_x=0;
	local c1_y=0;
	local c2_x=0;
	local c2_y=0;
	for i=1,table.getn(Constraints) do
		for j=1,table.getn(Constraints[i]) do
			if j == table.getn(Constraints[i]) then
				 c1_x = Constraints[i][j][1]*100;
				 c1_y = Constraints[i][j][2]*100;
				 c2_x = Constraints[i][1][1]*100;
				 c2_y = Constraints[i][1][2]*100;
			else
				 c1_x = Constraints[i][j][1]*100;
				 c1_y = Constraints[i][j][2]*100;
				 c2_x = Constraints[i][j+1][1]*100;
				 c2_y = Constraints[i][j+1][2]*100;
			end
			
			-- ecuatia dreptei care trece prin primul segment
			local a1 = y2-y1;
			local b1 = x1-x2;
			local c1 = y1*(x2-x1) - x1*(y2-y1);
			
			--ecuatia dreptei care trece prin al doilea segment
			local a2=c2_y-c1_y;
			local b2=c1_x-c2_x;
			local c2=c1_y*(c2_x-c1_x) - c1_x*(c2_y-c1_y);

			a1 = a1 * b2;
			b1 = b1 * b2;
			c1 = c1 * b2;
			
			a2 = a2 * b1;
			b2 = b2 * b1;
			c2 = c2 * b1;
			
			local x = (c2*b1 - c1*b2)/(a1*b2 - a2*b1);
			local y = (-c1 -a1*x)/b1;
			
			-- determinam daca punctul de intersectie al dreptelor apartine primului segment
			local ok1=0;
			if (x1 <= x and x <= x2) or (x1 >=x and x >= x2) then
				if (y1 <= y and y <= y2) or (y1 >=y and y >=y2) then
					ok1=1;
				end
			end
			
			-- determinam daca punctul de intersectie al dreptelor apartine segmentului 2
			local ok2=0;
			if(c1_x <=x and x <= c2_x ) or (c1_x >=x and x>= c2_x) then
				if(c1_y <= y and y <=c2_y) or (c1_y>=y and y>=c2_y) then
					ok2=1;
				end
			end
			
			if ok1==ok2 and ok1==1 then -- cele 2 segmente se intersecteaza
			--	print('Segmentul ('..x1..' '..y1..')( '..x2..' '..y2..')');
			--	print('se intersecteaza cu ')
			--	print('Segmentul ('..c1_x..' '..c1_y..')( '..c2_x..' '..c2_y..')');
			
			Intersectii[table.getn(Intersectii)+1]= {i,j,x,y}; --constrangerea i, segmentul j, punctul (x,y);
			end
			
			--if param==1 then
			--	print('---');
			--	print(x..' '..y..' || '..x1..' '..y1..' '..x2..' '..y2..' || '..ok1);
			--	print(x..' '..y..' || '..c1_x..' '..c1_y..' '..c2_x..' '..c2_y..' || '..ok2);
				
			--end
		
		end
	end
	
	return Intersectii;
end



function Const:sorteazaIntersectii(x1,y1,x2,y2,intersectii)
	local indice=0;
	if x1 < x2 then
		indice = 1;
	else if x1 > x2 then
		indice = -1;
		else if y1 < y2 then
				indice = 1;
			else
				indice = -1;
			end
		end
	end
	
	local swapped = 1;
	local k=0;
	local aux={};
	while swapped == 1 do
		swapped = 0;
		k=k+1;
		for i=1,table.getn(intersectii)-k do
			if intersectii[i][3]==intersectii[i+1][3] then
				if intersectii[i][4]*indice > intersectii[i+1][4]*indice then
					aux=intersectii[i];
					intersectii[i]=intersectii[i+1];
					intersectii[i+1]=aux;
					swapped=1;
				end
			else
				if intersectii[i][3]*indice > intersectii[i+1][3]*indice then
					aux=intersectii[i];
					intersectii[i]=intersectii[i+1];
					intersectii[i+1]=aux;
					swapped=1;
				end
			end
			
		end
	end	
	
	
	return intersectii;
	
	
end



function Const:distantaOcoliriiObstacolului(intersectii, Constraints)
	local intrare = {intersectii[1][3],intersectii[1][4]};
	local iesire = {intersectii[table.getn(intersectii)][3],intersectii[table.getn(intersectii)][4]};
	
	local indice_segment_intrare = intersectii[1][2];
	local indice_segment_iesire = intersectii[table.getn(intersectii)][2];
	
	local indice_constrangere = intersectii[1][1];
	
	local distanta_de_eliminat = math.sqrt((iesire[1]-intrare[1])*(iesire[1]-intrare[1]) + (iesire[2]-intrare[2])*(iesire[2]-intrare[2]));
	
	--in constrangerea identificata, va trebui sa gasim cel mai scurt drum de la segmentul de intrare si pana la segmentul de iesire, avand ca plecare punctele de pe segmente.
	
	
	local path1 = 0;
	
	local i1 = indice_segment_intrare;
	local j1 = indice_segment_iesire;
	
	while not (i1==j1) do
		if i1 == table.getn(Constraints[indice_constrangere]) then
			local x1 = Constraints[indice_constrangere][i1][1]*100;
			local y1 = Constraints[indice_constrangere][i1][2]*100;
			local x2 = Constraints[indice_constrangere][1][1]*100;
			local y2 = Constraints[indice_constrangere][1][2]*100;
			path1 = path1 + math.sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1));
			i1=1;
		else
			local x1 = Constraints[indice_constrangere][i1][1]*100;
			local y1 = Constraints[indice_constrangere][i1][2]*100;
			local x2 = Constraints[indice_constrangere][i1+1][1]*100;
			local y2 = Constraints[indice_constrangere][i1+1][2]*100;
			path1 = path1 + math.sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1));
			i1=i1+1;
		end
		
	end
	
	local path2 = 0;
	local i2 = indice_segment_intrare;
	local j2 = indice_segment_iesire;
	
	while not (i2==j2) do
		if i2 == 1 then
		    local n = table.getn(Constraints[indice_constrangere]);
			local x1 = Constraints[indice_constrangere][1][1]*100;
			local y1 = Constraints[indice_constrangere][1][2]*100;
			local x2 = Constraints[indice_constrangere][n][1]*100;
			local y2 = Constraints[indice_constrangere][n][2]*100;
			path2 = path2 + math.sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1));
			i2 = n;
		else
			local x1 = Constraints[indice_constrangere][i2][1]*100;
			local y1 = Constraints[indice_constrangere][i2][2]*100;
			local x2 = Constraints[indice_constrangere][i2-1][1]*100;
			local y2 = Constraints[indice_constrangere][i2-1][2]*100;
			path2 = path2 + math.sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1));
			i2=i2-1;
		end
	end
	if path1 < path2 then
		--print('path 1 e mai rapid');
		return path1, distanta_de_eliminat,1;
		
	else
		--print('path 2 e mai rapid');
		return path2, distanta_de_eliminat,2;
	end
end