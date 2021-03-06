function [list]=exitOnlyShortestPath(row,col,num_drct,myt,s,cP,wall,exit)
[num_e bla]=size(exit);

% 4 directioins: 1=E 2=S 3=W 4=N, 2 speed level: 1=L 2=H
toExitDistBuff=zeros(num_e,(num_drct+1));
listBackup=1:1:(num_drct+1);
pointsBackup=zeros(1,2*(num_drct+1));

for i=1:1:(num_drct+1)  
    if(listBackup(i)==1)
        pointsBackup(2*i-1)=cP(1)+s;
        pointsBackup(2*i)=cP(2);
    elseif (listBackup(i)==2)
        pointsBackup(2*i-1)=cP(1);
        pointsBackup(2*i)=cP(2)-s;
    elseif (listBackup(i)==3) 
        pointsBackup(2*i-1)=cP(1)-s;
        pointsBackup(2*i)=cP(2);
    elseif (listBackup(i)==4)
        pointsBackup(2*i-1)=cP(1);
        pointsBackup(2*i)=cP(2)+s;
    else
        pointsBackup(2*i-1)=cP(1);
        pointsBackup(2*i)=cP(2);
    end
    %calculate minimum distance via shortest path algorithm
    tempcor=[pointsBackup(2*i-1) pointsBackup(2*i)];
    if(tempcor(1)>0 && tempcor(2)>0 && tempcor(1)<=row && tempcor(2)<=col)
        tlabel=isWall(wall,tempcor);
        if(tlabel==1)
            toExitDistBuff(:,i)=row*col;
        else
            for j=1:1:num_e
                %toExitDistBuff(j,i)=abs(pointsBackup(2*i-1)-exit(j,1))+abs(pointsBackup(2*i)-exit(j,2));
                %toExitDistBuff(j,i)=testShortestPath(row,col,wall,exit(j,:),cP);
                toExitDistBuff(j,i)=testShortestPath(row,col,wall,exit(j,:),tempcor);
            end
        end
    else
        toExitDistBuff(:,i)=row*col;
    end
end
%toExitDistBuff
minDist=ones(1,num_drct+1);
for i=1:1:(num_drct+1)
    tempmin=row+col;
    for j=1:1:num_e
        if(toExitDistBuff(j,i)<tempmin)
            tempmin=toExitDistBuff(j,i);
        end
    end
    minDist(i)=tempmin;
end

sortedMinDist=sort(minDist);
mapMarker=ones(1,num_drct+1);
list=zeros(1,(num_drct+1));
listindex=1;
for i=1:1:(num_drct+1)
    for j=1:1:(num_drct+1)
        if(mapMarker(j) ~= 0)
        % if(mapMarker(i) ~= 0)
            if(minDist(j)==sortedMinDist(i))
                list(i)=j;
                mapMarker(j)=0;
                break;
            end
        end
    end
end
%list