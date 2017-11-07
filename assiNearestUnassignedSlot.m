%function nextPosition=assiNearestUnassignedSlot(row,col,wall,node,mycP,nextPosition)
function newNextPosition=assiNearestUnassignedSlot(row,col,wall,node,mycP,nextPosition)
    %disp('i came here\n');
    flag=1;
    newNextPosition=zeros(row,col);
    newNextPosition=nextPosition;
    mycP
    for j=1:1:(max(row,col)-1)
        %j
        if(flag==1)
            %disp('3');
            for i=(mycP(1)-j):1:(mycP(1)+j)
                %i
                if(flag==1)
                    %disp('2');
                    for ii=(mycP(2)-j):1:(mycP(2)+j)
                        %ii
                        tempco=[i ii];
                        ltem=checkPoint(row,col,tempco,wall);
                        if(ltem == 1 && newNextPosition(i,ii)==0)
                            newNextPosition(i,ii)=node;
                            flag=0;
                            disp('got a placement');
                            %tempco
                            %return ;
                            break;
                        end
                        %disp('1');
                    end
                end
            end
        end  
    end