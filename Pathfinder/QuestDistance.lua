Distance={}

function Distance:getDistance(x1,x2,y1,y2)
       x1=x1*100;
	   x2=x2*100;
	   y1=y1*100;
	   y2=y2*100;
       dist=math.sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1));
	   return dist;
end


function Distance:totalDistance(noduri, Q)
    total=0;
    for i=1,table.getn(noduri) -1 do
	    x1=Q[noduri[i]][5];
		y1=Q[noduri[i]][6];
		x2=Q[noduri[i+1]][5];
		y2=Q[noduri[i+1]][6];
		total=total+Distance:getDistance(x1,x2,y1,y2);
	end
	return total;
end