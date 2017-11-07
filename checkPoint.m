function [label]=checkPoint(row,col,tempco,wall)
% 4 directioins: 1=E 2=S 3=W 4=N, 2 speed level: 1=L 2=H
label=1;

% check boundary
if(tempco(1)>row || tempco(1)<1 || tempco(2)>col || tempco(2)<1)
    label=0;
end



%check walls
if(label ~= 0)
[numW numWW]=size(wall);
flag=1;
    for i=1:1:numW
        if(flag==1)
            minrow=wall(i,1);
            maxrow=wall(i,2);
            mincol=wall(i,3);
            maxcol=wall(i,4);
            if(tempco(1)>=minrow & tempco(1)<=maxrow & tempco(2)>=mincol & tempco(2)<=maxcol)
                label=0;
                flag=0;
            end
        end
    end
end