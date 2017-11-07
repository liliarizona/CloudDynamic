function [aveExitTimeAll aveExitTime1Group aveExitTime12 aveExitTime12Group]=crowdPlay(maxMove,row,col,initial,type,familiarity,wall,exit,group)
% row=number of slots in a column
% col=number of slots in a row
%the enviroment has row * col blocks
%initial is the initial position of all people
%red dot is oldman, blue dot is youngman.
% 4 directioins: 1=E 2=S 3=W 4=N, 2 speed level: 1=L 2=H
% direction 5 means stay where he was.
% familarity, 1:familiar, know where the exit is.
%             2:unfamiliar, follow the mass.
%             3.unfamiliar, random walk.
%%%% default setup %%%%%%%%
num_drct=4;
speedlevel=[1 2];
% type 1, which is old has speed 1, type 2, which is young has speed 2
typeMapToSpeed=[1 1];

outPicFolder='E:\Courses\math585\matlab\output\picture\group\';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[num_p n]=size(initial);
[num_g_p blah]=size(group);

num_group=group(num_g_p,6);
leader=group(:,3)';
type_g=group(:,4)';
familarity_g=group(:,5)';

num_p_total=num_p+num_g_p;

%existing indicator, 1 if the individual is still in the system, 0
%otherwise
eI=ones(1,num_p_total);

type_total=[type type_g];
familiarity_total=[familiarity familarity_g];
initial_total=[initial;group(:,1:1:2)]

%exiting time recorder
exitRecord=zeros(1,num_p_total);

%get speed array
inputSpeed=zeros(1,num_p_total);
for i=1:1:num_p_total
    inputSpeed(i)=typeMapToSpeed(type_total(i));
end
%end speed array

plotini=initial_total - 0.5;
%plot initial position
x=1:1:(row);
y=1:1:(col);
xx=plotini(:,1);
xx=xx';
yy=plotini(:,2);
yy=yy';

figure(1);
%plot(xx,yy,'or');
for j=1:1:num_p_total
    plotPosition(xx(j),yy(j),type_total(j));
    hold on;
end
plotWall(wall);
plotExit(exit);
GRID ON;
axis([0,row,0,col])
set(gca,'XTick',1:1:(row));
set(gca,'YTick',1:1:(col));
hold off;
outfile=[outPicFolder, '1.png'];
print(gcf,'-dpng',outfile);
current_position=initial_total;

num_movement=2;
%max_movement=20;
max_movement=maxMove;
movement=1;
% movement iteration starts
while movement,
%num_movement
    %cancel people in the exit slot(s)
    eI=checkExistence(current_position,exit,eI);
    for i=1:1:num_p_total
        if(eI(i)~=0)
           exitRecord(i)=exitRecord(i)+1;
        end
    end
    
    sum(eI)
    [prfList prfPoint]=generatePrfList(row,col,num_drct,type(1:1:num_p),familiarity(1:1:num_p),typeMapToSpeed,current_position(1:1:num_p,:),wall,exit,eI(1:1:num_p));
    %generate group prfList and prfPoint
    [prfList_g prfPoint_g]=generateGroupPrfList(row,col,num_drct,group,typeMapToSpeed,current_position,wall,exit,eI);
    prfList_total=[prfList;prfList_g];
    prfPoint_total=[prfPoint;prfPoint_g];
    
    % assign next position
    next_position=assigneNextPosition3(row,col,wall,prfList_total,prfPoint_total,current_position,eI);
    %next_position
    
    % move
    current_position=zeros(num_p_total,2);
    for i=1:1:row
        for j=1:1:col
            if(next_position(i,j)~=0)
                current_position(next_position(i,j),:)=[i j];
            end
        end
    end
    %current_position
    
    %check if all node are assigneed
    for i=1:1:num_p_total
        if(eI(i) ~= 0 && current_position(i,1)==0 && current_position(i,2)==0)
            i
            prfList(i,:)
            disp('assignement error\n');
        end
    end
    
    
    %plot movement
    figure(num_movement);
    for j=1:1:num_p_total
        if(eI(j) ~= 0)
            plotPosition(current_position(j,1)-0.5,current_position(j,2)-0.5,type_total(j));
            hold on;
        end
    end
    plotWall(wall);
    plotExit(exit);
    axis([0,row,0,col])
    set(gca,'XTick',1:1:(row));
    set(gca,'YTick',1:1:(col));
    GRID ON;
    hold on;
    hold off;
    outfile=[outPicFolder,num2str(num_movement),'.png'];
    print(gcf,'-dpng',outfile);
    
    % decision if keep moving
    num_movement=num_movement+1;
    if(num_movement>max_movement)
        movment=0;
        break ;
    end
end


totalExitTime12=0;
exitPplCount12=0;
totalExitTimeAll=0;
exitPplCountAll=0;
totalExitTime12Group=0;
exitPplCount12Group=0;
totalExitTime1Group=0;
exitPplCount1Group=0;
for i=1:1:num_p_total
    if(familiarity_total(i)==1 || familiarity_total(i)==2)
       totalExitTime12=totalExitTime12+exitRecord(i);
       exitPplCount12=exitPplCount12+1;
    end
    if(familiarity_total(i)==1 || familiarity_total(i)==2 || i>num_p)
       totalExitTime12Group=totalExitTime12Group+exitRecord(i);
       exitPplCount12Group=exitPplCount12Group+1;
    end
    if(familiarity_total(i)==1 || i>num_p)
       totalExitTime1Group=totalExitTime1Group+exitRecord(i);
       exitPplCount1Group=exitPplCount1Group+1;
    end
    totalExitTimeAll=totalExitTimeAll+exitRecord(i);
    exitPplCountAll=exitPplCountAll+1;
    
end
aveExitTimeAll=totalExitTimeAll/exitPplCountAll;
aveExitTime1Group=totalExitTime1Group/exitPplCount1Group;
aveExitTime12=totalExitTime12/exitPplCount12;
aveExitTime12Group=totalExitTime12Group/exitPplCount12Group;




%aveExitTimeAll aveExitTime1 aveExitTime12 aveExitTime12Group