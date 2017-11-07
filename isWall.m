function label=isWall(wall,tempco)
% 1 means in the wall
[numW numWW]=size(wall);
flag=1;
label=0;
    for i=1:1:numW
        if(flag==1)
            minrow=wall(i,1);
            maxrow=wall(i,2);
            mincol=wall(i,3);
            maxcol=wall(i,4);
            %if(tempco(1)>=minrow && tempco(1)<=maxrow && tempco(2)>=mincol && tempco(2)<=maxrow)
            if(tempco(1)>=minrow & tempco(1)<=maxrow & tempco(2)>=mincol & tempco(2)<=maxcol)
                label=1;
                flag=0;
                break;
            end
        end
    end
end