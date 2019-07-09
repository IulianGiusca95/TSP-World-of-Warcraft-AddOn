-- impartim nodurile in noduri cu grad par si noduri cu grad impar
Parity={}



function Parity:getParity(QUESTS,Edges)

	Odd = {}
	Even = {}
	Grad ={}

	for i=1,table.getn(QUESTS) do
		Grad[i]=0;
	end
	for i=1,table.getn(Edges) do
		nod1 = Edges[i][2];
		nod2 = Edges[i][3];
		Grad[nod1] = Grad[nod1] + 1;
		Grad[nod2] = Grad[nod2] + 1;
	end

	for i=1,table.getn(QUESTS) do
		if Grad[i]%2 ==0 then
			m=table.getn(Even)+1;
			Even[m]=i;
		else
			n=table.getn(Odd)+1;
			Odd[n]=i;
		end
	end

--for i=1,table.getn(Odd) do
--   print(QUESTS[Odd[i]][2]);
    
--end
	
	return Odd, Even;

end