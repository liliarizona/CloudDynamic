function [list]=runToLeader(row,col,num_drct,myt,s,cP,leaderP,wall)

% 4 directioins: 1=E 2=S 3=W 4=N, 2 speed level: 1=L 2=H
toLeaderBuff=zeros(1,(num_drct+1));
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
            toLeaderBuff(i)=row*col;
        else
            toLeaderBuff(i)=testShortestPath(row,col,wall,leaderP,tempcor);
        end
    else
        toLeaderBuff(i)=row*col;
    end
end
%toExitDistBuff
minDist=toLeaderBuff;
sortedMinDist=sort(minDist);
mapMarker=ones(1,num_drct+1);
list=zeros(1,(num_drct+1));

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