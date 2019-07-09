MatriceAdiacenta = {};

function MatriceAdiacenta:getMatrice(G,Q)
	local aparitii={};
	local M={};
	for i=1,table.getn(Q) do
		M[i]={};

	end
 
	for i=1,table.getn(Q) do
		aparitii[i]=0; 
	end

	for i=1,table.getn(Q) do
		for j=1,table.getn(Q) do
			M[i][j]=0;
		end
	end

	for z=1,table.getn(G) do
		i = G[z][2];
		j = G[z][3];
		aparitii[i]=aparitii[i]+1;
		aparitii[j]=aparitii[j]+1;
		M[i][j]=M[i][j]+1;
		M[j][i]=M[j][i]+1;
	end

	return M,aparitii;

end