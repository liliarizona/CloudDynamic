function [prfList_g prfPoint_g]=generateGroupPrfList(row,col,num_drct,group,typeMapToSpeed,current_position,wall,exit,eI)

[num_g_p blah]=size(group);
num_group=group(num_g_p,6);
[num_p_total blah]=size(current_position);
leaderMarker=zeros(1,num_group);
leaderMarkerBuff=zeros(1,num_group);
for i=1:1:num_g_p
    leaderMarkerBuff(group(i,6))=i;
end

leaderMarker(1)=1;
if num_group>=2
    for i=2:1:num_group
        leaderMarker(i)=leaderMarkerBuff(i-1)+1;
    end
end
%leaderMarker
num_p=num_p_total-num_g_p;



prfList_g=zeros(num_g_p,num_drct+1);
prfPoint_g=zeros(num_g_p,(num_drct+1)*2+1);
%num_p_total
%num_p
%current_position
for i=1:1:num_group
    leaderEI=eI(num_p+leaderMarker(i));
    for j=1:1:num_g_p
        if(eI(num_p+j) ~= 0 && group(j,6 )==i)
            index=1;
            if leaderEI==1
                if(group(j,3)==1)
                    %templist=exitOnlyShortestPath(row,col,num_drct,group(j,4),typeMapToSpeed(group(j,4)),current_position(num_p+j,:),wall,exit);
                    templist=famiTest(row,col,num_drct,group(j,4),group(j,5),typeMapToSpeed(group(j,4)),current_position,current_position(num_p+j,:),wall,exit)
                else
                    templist=runToLeader(row,col,num_drct,group(j,4),typeMapToSpeed(group(j,4)),current_position(num_p+j,:),current_position(num_p+leaderMarker(i),:),wall);
                end
            else
                templist=exitOnlyShortestPath(row,col,num_drct,group(j,4),typeMapToSpeed(group(j,4)),current_position(num_p+j,:),wall,exit);
            end
            for jj=1:1:(num_drct+1)
                [templabel temppoint]=testPrfPoint(row,col,templist(jj),typeMapToSpeed(group(j,4)),current_position(num_p+j,:),wall,exit);
                if(templabel)
                    prfList_g(j,index)=templist(jj);
                    prfPoint_g(j,2*index - 1)=temppoint(1);
                    prfPoint_g(j,2*index)=temppoint(2);
                    index=index+1;
                end
            end
        end
    end
end