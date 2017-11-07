function [dense]=checkDense(point,map,range)
[row col]=size(map);

dense=0;
wPoint=[max(1,point(1)-range) point(2)];
ePoint=[min(row,point(1)+range) point(2)];
sPoint=[point(1) max(1,point(2)-range)];
nPoint=[point(1) min(col,point(2)+range)];

for i=wPoint(1):1:ePoint(1)
    for j=sPoint(2):1:nPoint(2)
        if(map(i,j)==1)
            dense=dense+1;
        end
    end
end
