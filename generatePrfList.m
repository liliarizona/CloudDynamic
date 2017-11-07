function [prflist prfPoint]=generatePrfList(row,col,num_drct,t,familiarity,speed,currentPosition,wall,exit,eI)
[num_p numm]=size(currentPosition);
prflist=zeros(num_p,num_drct+1);
prfPoint=zeros(num_p,(num_drct+1)*2+1);
for i=1:1:num_p
    index=1;
    if(eI(i) ~= 0)
        %templist=randperm(5);
        %templist=exitOnly(row,col,num_drct,t(i),speed(t(i)),currentPosition(i,:),exit);
        %i
        %eI(i)
        %currentPosition(i,:)
        templist=famiTest(row,col,num_drct,t(i),familiarity(i),speed(t(i)),currentPosition,currentPosition(i,:),wall,exit);
        %templist=exitOnlyShortestPath(row,col,num_drct,t(i),speed(t(i)),currentPosition(i,:),wall,exit);
        for j=1:1:(num_drct+1)
            [templabel temppoint]=testPrfPoint(row,col,templist(j),speed(t(i)),currentPosition(i,:),wall,exit);
            if(templabel)
                prflist(i,index)=templist(j);
                prfPoint(i,2*index - 1)=temppoint(1);
                prfPoint(i,2*index)=temppoint(2);
                index=index+1;
            end
        end
    end
end
%prflist