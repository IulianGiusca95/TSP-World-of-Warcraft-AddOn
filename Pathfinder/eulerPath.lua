Euler = {};

function Euler:verificaExistenta(Deadlines,pas,noduri)
	if pas > table.getn(Deadlines) then
		return -1;
	end
	for i=1,table.getn(noduri) do
		if noduri[i]==Deadlines[pas] then
			return 1;
		end
	end
	return 0;
end

function Euler:checkVisited(visited)
    for i=1,table.getn(visited) do
		if not(visited[i]==1) then
		   return 0;
		end
    end
	return 1;
end

function Euler:getIndici(i,j,g) --verificam daca o pereche de 2 noduri i si j formeaza o muchie in g si returnam indicele muchiei
    indici={}
	for k=1,table.getn(g) do
        if (g[k][2]==i and g[k][3]==j) or (g[k][3]==i and g[k][2]==j) then
		    indici[table.getn(indici)+1]=k;
		end
	end
	return indici;
end




function Euler:DFS(start,visited,m,g,noduri,pas, Deadlines, Quests, contor)
   

   noduri[table.getn(noduri)+1]=start;
   if Euler:checkVisited(visited) == 1 then
       return noduri;
   end
   pas = pas+1;
   for i=1,table.getn(m[start]) do --cautam toate nodurile adiacente cu "Start"
        if m[start][i]>0 then 
		    ok=0;
			visited2=visited; --vom altera muchiile vizitate pe parcurs, asa ce ne formam o alta instanta a lui visited, ce va fi folosita doar pentru un singur nod
		    indici=Euler:getIndici(start,i,g); --cautam toate muchiile(pot fi mai multe) cu capetele in nodurile "start" si "i"
			g2=g;
			m2=m;
			i2=i;
			contor2=contor;
			for k=1,table.getn(indici) do --pentru fiecare astfel de muchie, o marcam pe prima gasita nevizitata
                if	visited2[indici[k]]==0 then
					if pas <= table.getn(Deadlines) and Deadlines[pas]>0 and not(Deadlines[pas]==i) and Euler:verificaExistenta(Deadlines,pas,noduri)==0 then --nu marcam muchia, dar o modificam, legand nodul i de nodul de deadline
						contor2=contor2+1;
	                    m2[i][Deadlines[pas]]=m2[i][Deadlines[pas]]+1; --modificam matricea de adiacenta, adaugand o noua muchie intre i si cea de la deadline-ul curent
						m2[Deadlines[pas]][i]=m2[Deadlines[pas]][i]+1;
						m2[start][i]=m2[start][i]-1; --stergem muchia care ar fi legat start de nodul i fiindca facem salt la nodul de deadline
						m2[i][start]=m2[i][start]-1;
						g2[indici[k]][2]=i;  --modificam si matricea de muchii
						g2[indici[k]][3]=Deadlines[pas];
						i2=Deadlines[pas]; --marcam nodul succesor ca fiind nodul de la Deadline
					else
						visited2[indici[k]]=1; -- Daca nu e cazul sa facem salt catre un nod care expira, atunci continuam in mod normal
					end
					ok=1; --in cazul in care o muchie nevizitata exista, vom retine acest aspect cu o variabila ok
					break;
                end	
			end
			
			if ok==1 then --daca a fost gasita o muchie nevizitata, atunci continuam parcurgerea, avand muchia marcata, noul nod de start fiind celalalt capat al muchiei
				n = Euler:DFS(i2,visited2,m2,g2,noduri, pas, Deadlines, Quests, contor2);	
				if table.getn(n)==table.getn(g)+1+contor2 then 
					return n;
				end
			end
			
			
		end
   end
   return {};
   
end


----

function Euler:EulerMinim(start,visited,m,g,noduri, Quests)

	minim=99999;
	n={};
	ok = 0;
	old_n=n;
	for i=1,10 do
         n = Euler:DFS2(start,visited,m,g,noduri, Quests, minim);
         if table.getn(n)==0 then 
            break;
         end
         minim=math.floor(Distance:totalDistance(n, Quests));	
         old_n=n;		 
	end
	
	return old_n;
end


function Euler:DFS2(start,visited,m,g,noduri, Quests, minim)
   
   noduri[table.getn(noduri)+1]=start;
   if Euler:checkVisited(visited) == 1 and minim > Distance:totalDistance(noduri, Quests) then
       return noduri;
   end
   
   for i=1,table.getn(m[start]) do
        if m[start][i]>0 then
		    ok=0;
			visited2=visited;
		    indici=Euler:getIndici(start,i,g);
			for k=1,table.getn(indici) do
                if	visited2[indici[k]]==0 then
                    visited2[indici[k]]=1;
					ok=1;
					break;
                end	
			end
			
			if ok==1 then
			   n = Euler:DFS2(i,visited2,m,g,noduri, Quests, minim);
			   if table.getn(n)==table.getn(g)+1 then 
					return n;
				end
			end
			
			
		end
   end
   
   return {};
   
end

---

function Euler:getEulerPath(Quests,G, Deadlines)

	M, aparitii = MatriceAdiacenta:getMatrice(G,Quests)
	-- set current player position
	SetMapZoom(8);
	posX, posY = GetPlayerMapPosition("player");
	--print('Pozitie curenta '..posX..' '..posY);
	-- find closest quest(starting point)
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

	if indice == -1 then
		print("Error - no quests found!");
	--else
	--  print(Quests[indice][2]);
	end
	
	if not (Deadlines[1] == -1) then --daca avem quest cu deadline pe pozitia 1 => acel quest expira deci trebuie facut primul
		indice = Deadlines[1];
	end

	-- genereaza un lant eulerian
	visited = {};
	for i=1,table.getn(G) do
		visited[i]=0;
	end

	local pas_curent = 1;
	

	noduri={};
	contor=0;
	n = Euler:DFS(indice,visited,M,G,noduri, pas_curent, Deadlines, Quests, contor);
	return n;

end





