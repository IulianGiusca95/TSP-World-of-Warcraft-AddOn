B={}

local Edges = D.Edges;
local QUESTS = A.Quests;
local QUEST_MAPS = A.Quest_Maps;
local hbdp = LibStub("HereBeDragons-Pins-1.0")
local hbd = LibStub("HereBeDragons-1.0")

local overlay=CreateFrame("Frame","MapLicenta",WorldMapButton)
overlay:SetAllPoints(true);

function B:removeAllPoints()
	hbdp:RemoveAllWorldMapIcons(self)
end

function B:setPoint(m, f, x, y)

	worldmap=CreateFrame("Frame",nil,MapLicenta)
	worldmap:SetHeight(12)
	worldmap:SetWidth(12)
	worldmap.icon = worldmap:CreateTexture("ARTWORK")
    worldmap.icon:SetAllPoints()
    worldmap.icon:SetTexture("Interface\\AddOns\\Pathfinder\\Images\\Indicator-Red")
	worldmap:RegisterEvent("WORLD_MAP_UPDATE")
	hbdp:AddWorldMapIconMF(self, worldmap, m, f, x, y)

end


function B:setConstraintPoint(m, f, x, y)

	local worldmap=CreateFrame("Frame",nil,MapLicenta)
	worldmap:SetHeight(16)
	worldmap:SetWidth(16)
	worldmap.icon = worldmap:CreateTexture("ARTWORK")
    worldmap.icon:SetAllPoints()
    worldmap.icon:SetTexture("Interface\\AddOns\\Pathfinder\\Images\\GoldGreenDot")
	worldmap:RegisterEvent("WORLD_MAP_UPDATE")
	hbdp:AddWorldMapIconMF(self, worldmap, m, f, x, y)
    


end


function B:setPathPoints(m, f, x, y)

	local path=CreateFrame("Frame",nil,MapLicenta)
	path:SetHeight(4)
	path:SetWidth(4)
	path.icon = path:CreateTexture("ARTWORK")
    path.icon:SetAllPoints()
    path.icon:SetTexture("Interface\\AddOns\\Pathfinder\\Images\\IndigoBlueDot")
	path:RegisterEvent("WORLD_MAP_UPDATE")
	hbdp:AddWorldMapIconMF(self, path, m, f, x, y)
    


end

function B:setConstraintPathPoints(m, f, x, y)

	local path=CreateFrame("Frame",nil,MapLicenta)
	path:SetHeight(4)
	path:SetWidth(4)
	path.icon = path:CreateTexture("ARTWORK")
    path.icon:SetAllPoints()
    path.icon:SetTexture("Interface\\AddOns\\Pathfinder\\Images\\Blue-dot")
	path:RegisterEvent("WORLD_MAP_UPDATE")
	hbdp:AddWorldMapIconMF(self, path, m, f, x, y)
    


end

function B:setOddPoints(m, f, x, y)

	local path=CreateFrame("Frame",nil,MapLicenta)
	path:SetHeight(16)
	path:SetWidth(16)
	path.icon = path:CreateTexture("ARTWORK")
    path.icon:SetAllPoints()
    path.icon:SetTexture("Interface\\AddOns\\Pathfinder\\Images\\GoldGreenDot")
	path:RegisterEvent("WORLD_MAP_UPDATE")
	hbdp:AddWorldMapIconMF(self, path, m, f, x, y)
    


end

function B:drawConstraints(Constraint, QUEST_MAPS)
	for i=1,table.getn(Constraint) do
		if i==table.getn(Constraint) then
			x1=Constraint[i][1];
			y1=Constraint[i][2];
			x2=Constraint[1][1];
			y2=Constraint[1][2];
		else
			x1=Constraint[i][1];
			y1=Constraint[i][2];
			x2=Constraint[i+1][1];
			y2=Constraint[i+1][2];
		end
		distance = math.floor(Distance:getDistance(x1,x2,y1,y2)*2);
        h1=math.abs(x2-x1)/distance;
        h2=math.abs(y2-y1)/distance;
		if x1 <= x2 and y1<=y2 then
		for i=2,distance do
           B:setConstraintPathPoints(QUEST_MAPS[1],0,x1+(i-1)*h1,y1+(i-1)*h2);
		end
		end
	
		if x1 <= x2 and y1>y2 then
		for i=2,distance do
			B:setConstraintPathPoints(QUEST_MAPS[1],0,x1+(i-1)*h1,y1-(i-1)*h2);
		end
		end
	
		if x1 > x2 and y1<=y2 then
		for i=2,distance do
			B:setConstraintPathPoints(QUEST_MAPS[1],0,x1-(i-1)*h1,y1+(i-1)*h2);
		end
		end
	
		if x1 > x2 and y1>y2 then
		for i=2,distance do
			B:setConstraintPathPoints(QUEST_MAPS[1],0,x1-(i-1)*h1,y1-(i-1)*h2);
		end
		end
	end
	
end

function B:drawGraph(X, QUESTS)
   for i=1,table.getn(X) do -- afisarea grafului x
   --print(QUESTS[Edges[i][2]][2]);
   --print(QUESTS[Edges[i][3]][2]);
   --print('-----------------');
   x1 = QUESTS[X[i][2]][5];
   y1 = QUESTS[X[i][2]][6];
   x2 = QUESTS[X[i][3]][5];
   y2 = QUESTS[X[i][3]][6];
   distance=math.floor(X[i][1]*2);
   h1=math.abs(x2-x1)/distance;
   h2=math.abs(y2-y1)/distance;
   
   
   if x1 <= x2 and y1<=y2 then
   for i=2,distance do
       B:setPathPoints(QUEST_MAPS[1],0,x1+(i-1)*h1,y1+(i-1)*h2);
	end
	end
	
   if x1 <= x2 and y1>y2 then
   for i=2,distance do
       B:setPathPoints(QUEST_MAPS[1],0,x1+(i-1)*h1,y1-(i-1)*h2);
	end
	end
	
	if x1 > x2 and y1<=y2 then
   for i=2,distance do
       B:setPathPoints(QUEST_MAPS[1],0,x1-(i-1)*h1,y1+(i-1)*h2);
	end
	end
	
	if x1 > x2 and y1>y2 then
   for i=2,distance do
       B:setPathPoints(QUEST_MAPS[1],0,x1-(i-1)*h1,y1-(i-1)*h2);
	end
	end
   

end
end

function B:drawClockwise(QUEST_MAPS,intersectii,Constraints)
	print('CLOCKWISE');
	local intrare = {intersectii[1][3],intersectii[1][4]};
	local iesire = {intersectii[table.getn(intersectii)][3],intersectii[table.getn(intersectii)][4]};
	
	local indice_segment_intrare = intersectii[1][2];
	local indice_segment_iesire = intersectii[table.getn(intersectii)][2];
	
	local indice_constrangere = intersectii[1][1];
	
	local i1 = indice_segment_intrare;
	local j1 = indice_segment_iesire;
	local contor=0;
	
	while not (i1==j1) do
		if i1 == table.getn(Constraints[indice_constrangere]) then
			local x1 = Constraints[indice_constrangere][i1][1]
			local y1 = Constraints[indice_constrangere][i1][2]
			local x2 = Constraints[indice_constrangere][1][1]
			local y2 = Constraints[indice_constrangere][1][2]
			if contor==0 then
				contor = contor+1;
			else
				B:setPathPoints(QUEST_MAPS,0,x2,y2);
				contor=contor+1;
			end
			local distance = Distance:getDistance(x1,x2,y1,y2)*2;
			distance = math.floor(distance);
			local h1=math.abs(x2-x1)/distance;
			local h2=math.abs(y2-y1)/distance;
			
			if x1 <= x2 and y1<=y2 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS,0,x1+(i-1)*h1,y1+(i-1)*h2);
				end
			end
			
			if x1 <= x2 and y1>y2 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS,0,x1+(i-1)*h1,y1-(i-1)*h2);
				end
			end
			
			if x1 > x2 and y1<=y2 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS,0,x1-(i-1)*h1,y1+(i-1)*h2);
				end
			end
			
			if x1 > x2 and y1>y2 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS,0,x1-(i-1)*h1,y1-(i-1)*h2);
				end
			end
			
			
			
			i1=1;
		else
			local x1 = Constraints[indice_constrangere][i1][1]
			local y1 = Constraints[indice_constrangere][i1][2]
			local x2 = Constraints[indice_constrangere][i1+1][1]
			local y2 = Constraints[indice_constrangere][i1+1][2]
			if contor==0 then
				contor = contor+1;
			else
				B:setPathPoints(QUEST_MAPS,0,x2,y2);
				contor=contor+1;
			end
			
			local distance = Distance:getDistance(x1,x2,y1,y2)*2;
			distance = math.floor(distance);
			local h1=math.abs(x2-x1)/distance;
			local h2=math.abs(y2-y1)/distance;
			
			if x1 <= x2 and y1<=y2 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS,0,x1+(i-1)*h1,y1+(i-1)*h2);
				end
			end
			
			if x1 <= x2 and y1>y2 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS,0,x1+(i-1)*h1,y1-(i-1)*h2);
				end
			end
			
			if x1 > x2 and y1<=y2 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS,0,x1-(i-1)*h1,y1+(i-1)*h2);
				end
			end
			
			if x1 > x2 and y1>y2 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS,0,x1-(i-1)*h1,y1-(i-1)*h2);
				end
			end
			i1=i1+1;
		end
		
	end
end

function B:drawAntiClockwise(QUEST_MAPS,intersectii,Constraints)
	print('ANTICLOCKWISE!')
	local intrare = {intersectii[1][3],intersectii[1][4]};
	local iesire = {intersectii[table.getn(intersectii)][3],intersectii[table.getn(intersectii)][4]};
	
	B:setPathPoints(QUEST_MAPS,0,intrare[1],intrare[2]);
	B:setPathPoints(QUEST_MAPS,0,iesire[1],iesire[2]);
	local indice_segment_intrare = intersectii[1][2];
	local indice_segment_iesire = intersectii[table.getn(intersectii)][2];
	
	local indice_constrangere = intersectii[1][1];
	
	local i2 = indice_segment_intrare;
	local j2 = indice_segment_iesire;
	while not (i2==j2) do
		if i2 == 1 then
		    local n = table.getn(Constraints[indice_constrangere]);
			local x1 = Constraints[indice_constrangere][1][1]
			local y1 = Constraints[indice_constrangere][1][2]
			local x2 = Constraints[indice_constrangere][n][1]
			local y2 = Constraints[indice_constrangere][n][2]
			if j2==n then break; end
			B:setPathPoints(QUEST_MAPS,0,x2,y2);
			
			local distance = Distance:getDistance(x1,x2,y1,y2)*2;
			distance = math.floor(distance);
			local h1=math.abs(x2-x1)/distance;
			local h2=math.abs(y2-y1)/distance;
			
			if x1 <= x2 and y1<=y2 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS,0,x1+(i-1)*h1,y1+(i-1)*h2);
				end
			end
			
			if x1 <= x2 and y1>y2 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS,0,x1+(i-1)*h1,y1-(i-1)*h2);
				end
			end
			
			if x1 > x2 and y1<=y2 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS,0,x1-(i-1)*h1,y1+(i-1)*h2);
				end
			end
			
			if x1 > x2 and y1>y2 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS,0,x1-(i-1)*h1,y1-(i-1)*h2);
				end
			end
			i2 = n;
		else
			local x1 = Constraints[indice_constrangere][i2][1]
			local y1 = Constraints[indice_constrangere][i2][2]
			local x2 = Constraints[indice_constrangere][i2-1][1]
			local y2 = Constraints[indice_constrangere][i2-1][2]
			if j2==i2-1 then break; end
			B:setPathPoints(QUEST_MAPS,0,x2,y2);
			
			local distance = Distance:getDistance(x1,x2,y1,y2)*2;
			distance = math.floor(distance);
			local h1=math.abs(x2-x1)/distance;
			local h2=math.abs(y2-y1)/distance;
			
			if x1 <= x2 and y1<=y2 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS,0,x1+(i-1)*h1,y1+(i-1)*h2);
				end
			end
			
			if x1 <= x2 and y1>y2 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS,0,x1+(i-1)*h1,y1-(i-1)*h2);
				end
			end
			
			if x1 > x2 and y1<=y2 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS,0,x1-(i-1)*h1,y1+(i-1)*h2);
				end
			end
			
			if x1 > x2 and y1>y2 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS,0,x1-(i-1)*h1,y1-(i-1)*h2);
				end
			end
			i2=i2-1;
		end
	end
end

function B:drawPath(X,QUESTS,QUEST_MAPS, Constraints)
    for i=1,table.getn(X)-1 do
	    x1=QUESTS[X[i]][5];
		y1=QUESTS[X[i]][6];
		x2=QUESTS[X[i+1]][5];
		y2=QUESTS[X[i+1]][6];
		
		local dist = 0;
		local dist_de_eliminat=0;
		local indice_path=0;
		
		
		local intersectii = Const:checkConstraints(x1*100,y1*100,x2*100,y2*100,Constraints);
		
		
		if table.getn(intersectii)>=2 then
			intersectii = Const:sorteazaIntersectii(x1*100,y1*100,x2*100,y2*100,intersectii);
			dist, dist_de_eliminat, indice_path = Const:distantaOcoliriiObstacolului(intersectii, Constraints)
			print('yes!');
		end
		
		
		
		distance = Distance:getDistance(x1,x2,y1,y2);
		distance = distance + dist - dist_de_eliminat
		distance = math.floor(distance);
        h1=math.abs(x2-x1)/distance;
        h2=math.abs(y2-y1)/distance;

   
		if x1 <= x2 and y1<=y2 then
			if table.getn(intersectii)==0 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS[1],0,x1+(i-1)*h1,y1+(i-1)*h2);
				end
			else
				print ('1');
				local distance1=0
				local distance2=0
				local rest=0;
				
				local x3 = intersectii[1][3]/100;
				local y3 = intersectii[1][4]/100;
				local x4 = intersectii[table.getn(intersectii)][3]/100;
				local y4 = intersectii[table.getn(intersectii)][4]/100;
				
				distance1 = math.sqrt((x3-x1)*(x3-x1) + (y3-y1)*(y3-y1))*100;
				distance2 = math.sqrt((x4-x2)*(x4-x2) + (y4-y2)*(y4-y2))*100;
				rest = dist;
				
				distance1 = math.floor(distance1);
				distance2 = math.floor(distance2);
				rest = math.floor(rest);
				
				for i=1,distance1 do
					B:setPathPoints(QUEST_MAPS[1],0,x1+(i-1)*h1,y1+(i-1)*h2);
				end
				
				if indice_path == 1 then
					B:drawClockwise(QUEST_MAPS[1], intersectii, Constraints)
				else if indice_path == 2 then
						B:drawAntiClockwise(QUEST_MAPS[1],intersectii, Constraints)
					else
						print('Error - cannot draw!');
					end
				end
				
				for i = distance1 + rest,distance do
					B:setPathPoints(QUEST_MAPS[1],0,x1+(i-1)*h1,y1+(i-1)*h2);
				end
			end
		end
	
		if x1 <= x2 and y1>y2 then
			if table.getn(intersectii)==0 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS[1],0,x1+(i-1)*h1,y1-(i-1)*h2);
				end
			else
				print('2');
				local distance1=0
				local distance2=0
				local rest=0;
				
				local x3 = intersectii[1][3]/100;
				local y3 = intersectii[1][4]/100;
				local x4 = intersectii[table.getn(intersectii)][3]/100;
				local y4 = intersectii[table.getn(intersectii)][4]/100;
				
				distance1 = math.sqrt((x3-x1)*(x3-x1) + (y3-y1)*(y3-y1))*100;
				distance2 = math.sqrt((x4-x2)*(x4-x2) + (y4-y2)*(y4-y2))*100;
				rest = dist;
				
				distance1 = math.floor(distance1);
				distance2 = math.floor(distance2);
				rest = math.floor(rest);
				
				for i=1,distance1 do
					B:setPathPoints(QUEST_MAPS[1],0,x1+(i-1)*h1,y1-(i-1)*h2);
				end
				
				if indice_path == 1 then
					B:drawClockwise(QUEST_MAPS[1], intersectii, Constraints)
				else if indice_path == 2 then
						B:drawAntiClockwise(QUEST_MAPS[1],intersectii, Constraints)
					else
						print('Error - cannot draw!');
					end
				end
				
				for i = distance1 + rest,distance do
					B:setPathPoints(QUEST_MAPS[1],0,x1+(i-1)*h1,y1-(i-1)*h2);
				end
			end
		end
	
		if x1 > x2 and y1<=y2 then
			if table.getn(intersectii)==0 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS[1],0,x1-(i-1)*h1,y1+(i-1)*h2);
				end
			else
				print('3');
				local distance1=0
				local distance2=0
				local rest=0;
				
				local x3 = intersectii[1][3]/100;
				local y3 = intersectii[1][4]/100;
				local x4 = intersectii[table.getn(intersectii)][3]/100;
				local y4 = intersectii[table.getn(intersectii)][4]/100;
				
				distance1 = math.sqrt((x3-x1)*(x3-x1) + (y3-y1)*(y3-y1))*100;
				distance2 = math.sqrt((x4-x2)*(x4-x2) + (y4-y2)*(y4-y2))*100;
				rest = dist;
				
				distance1 = math.floor(distance1);
				distance2 = math.floor(distance2);
				rest = math.floor(rest);
				
				
				for i=1, distance1 do
					B:setPathPoints(QUEST_MAPS[1],0,x1-(i-1)*h1,y1+(i-1)*h2);
				end
				
				if indice_path == 1 then
					B:drawClockwise(QUEST_MAPS[1],intersectii, Constraints)
					
				else if indice_path == 2 then
						
						B:drawAntiClockwise(QUEST_MAPS[1], intersectii, Constraints)
					else
						print('Error - cannot draw!');
					end
				end
				
				for i = distance1 + rest,distance do
					B:setPathPoints(QUEST_MAPS[1],0,x1-(i-1)*h1,y1+(i-1)*h2);
				end
			end
		end
	
		if x1 > x2 and y1>y2 then
			if table.getn(intersectii)==0 then
				for i=2,distance do
					B:setPathPoints(QUEST_MAPS[1],0,x1-(i-1)*h1,y1-(i-1)*h2);
				end
			else
				print('4');
				local distance1=0
				local distance2=0
				local rest=0;
				
				local x3 = intersectii[1][3]/100;
				local y3 = intersectii[1][4]/100;
				local x4 = intersectii[table.getn(intersectii)][3]/100;
				local y4 = intersectii[table.getn(intersectii)][4]/100;
				
				distance1 = math.sqrt((x3-x1)*(x3-x1) + (y3-y1)*(y3-y1))*100;
				distance2 = math.sqrt((x4-x2)*(x4-x2) + (y4-y2)*(y4-y2))*100;
				rest = dist;
				
				distance1 = math.floor(distance1);
				distance2 = math.floor(distance2);
				rest = math.floor(rest);
				
				for i=1,distance1 do
					B:setPathPoints(QUEST_MAPS[1],0,x1-(i-1)*h1,y1-(i-1)*h2);
				end
				
				if indice_path == 1 then
					B:drawClockwise(QUEST_MAPS[1], intersectii, Constraints)
				else if indice_path == 2 then
						B:drawAntiClockwise(QUEST_MAPS[1],intersectii, Constraints)
					else
						print('Error - cannot draw!');
					end
				end
				
				for i = distance1 + rest,distance do
					B:setPathPoints(QUEST_MAPS[1],0,x1-(i-1)*h1,y1-(i-1)*h2);
				end
			end
		
		end
	end
end
