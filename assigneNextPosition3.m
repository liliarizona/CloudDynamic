function nextPosition=assigneNextPosition3(row,col,wall,prfList,prfPoint,currentPosition,eI)
[num_p,num_d]=size(prfList);
nextPosition=zeros(row,col);
assiMarker=ones(row,col);
assiNodeMarker=ones(1,num_p);
prfBuff=zeros(row*col,num_p);
nextNode=zeros(num_p,2);
prfRank=1;
for r=1:1:num_d
    %assiLevelMarker=zeros(row*col,num_p);
    prfLevelBuff=zeros(row*col,num_p);
    if(sum(assiNodeMarker)==0)
        break;
    else
        for i=1:1:num_p
            %prfList(i,:)
            %prfPoint(i,:)
            %num_p
            if(eI(i) ~= 0)
                if(assiNodeMarker(i) ~= 0)
                    if(prfPoint(i,2*r) ~= 0)
                        if(prfPoint(i,2*r+1)==0)
                            %if this is the last preference, assigne the point
                            %to this slot
                            if(nextPosition(prfPoint(i,2*r-1),prfPoint(i,2*r))==0)
                                nextPosition(prfPoint(i,2*r-1),prfPoint(i,2*r))=i;
                                assiNodeMarker(i)=0;
                                nextNode(i,:)=[prfPoint(i,2*r-1),prfPoint(i,2*r)];
                                if(prfPoint(i,2*r-1)==0 || prfPoint(i,2*r)==0)
                                    disp('mis assignement 2');
                                end
                            end
                        else 
                            temp=find(prfLevelBuff((prfPoint(i,2*r-1)-1)*row+prfPoint(i,2*r),:)~=0);
                            index=length(temp)+1;
                            prfLevelBuff((prfPoint(i,2*r-1)-1)*row+prfPoint(i,2*r),index)=i;
                            %assiNodeMarker(i)=0;
                        end
                    end
                end
            else
                assiNodeMarker(i)=0;
                %nextNode(i,:)=[99 99];
            end
        end
        for i=1:1:row*col
            temp=length(find(prfLevelBuff(i,:)~=0));
            if(temp > 0)
                tempcol=mod(i,row);
                temprow=ceil(i/row);
                if(tempcol==0)
                    tempcol=col;
                    %temprow=temprow+1;
                end
                if(nextPosition(temprow,tempcol)==0)
                    rand=randi(temp,1);
                    nextPosition(temprow,tempcol)=prfLevelBuff(i,rand);
                    assiNodeMarker(prfLevelBuff(i,rand))=0;
                    nextNode(prfLevelBuff(i,rand),:)=[temprow,tempcol];
                    if(temprow==0 || tempcol==0)
                        disp('mis assignement 1');
                    end
                end
            end
        end
    end
end

if(sum(assiNodeMarker)~=0)
     temp=find(assiNodeMarker ~=0 );
     %temp
     lent=length(temp);
     for i=1:1:lent
        myPrfpoint=prfPoint(temp(i),:);
        for ii=1:1:(num_d+1)
            if(myPrfpoint(2*ii-1)~=0 && myPrfpoint(2*ii)~=0 && nextPosition(myPrfpoint(2*ii-1),myPrfpoint(2*ii)) == 0)
                nextPosition(myPrfpoint(2*ii-1),myPrfpoint(2*ii))=temp(i);
                nextNode(temp(i),:)=[myPrfpoint(2*ii-1),myPrfpoint(2*ii)];
                assiNodeMarker(temp(i))=0;
                    if(myPrfpoint(2*ii-1)==0 || myPrfpoint(2*ii)==0)
                        disp('mis assignement 3');
                    end
                break;
            end
        end
     end
end
%currentPosition
if(sum(assiNodeMarker)~=0)
     temp=find(assiNodeMarker ~=0);
     %temp
     lent=length(temp);
     for i=1:1:lent
        %currentPosition(temp(i),:)
        if(currentPosition(temp(i),1)~=0 && currentPosition(temp(i),2) ~= 0)
            newNextPosition=assiNearestUnassignedSlot(row,col,wall,temp(i),currentPosition(temp(i),:),nextPosition);
            nextPosition=newNextPosition;
            assiNodeMarker(temp(i))=0;
        end
     end
end

if(sum(assiNodeMarker)~=0)
     temp=find(assiNodeMarker ~=0);
     %temp
     %disp('assi erro\n');
     %return ;
end
%assiNodeMarker
%nextNode