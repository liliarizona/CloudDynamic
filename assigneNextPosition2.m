function nextPosition=assigneNextPosition2(row,col,prfList,prfPoint,eI)
[num_p,num_d]=size(prfList);
nextPosition=zeros(row,col);
assiMarker=ones(row,col);
assiNodeMarker=ones(1,num_p);

prfBuff=zeros(row*col,num_p);

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
                if(prfPoint(i,2*r) ~= 0)
                    if(prfPoint(i,2*r+1)==0)
                        nextPosition(prfPoint(i,2*r-1),prfPoint(i,2*r))=i;
                        assiNodeMarker(i)=0;
                    else 
                        temp=find(prfLevelBuff((prfPoint(i,2*r-1)-1)*row+prfPoint(i,2*r),:)~=0);
                        index=length(temp)+1;
                        prfLevelBuff((prfPoint(i,2*r-1)-1)*row+prfPoint(i,2*r),index)=i;
                    end
                end
            else
                assiNodeMarker(i)=0;
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
                if( nextPosition(temprow,tempcol)==0)
                    rand=randi(temp,1);
                    nextPosition(temprow,tempcol)=prfLevelBuff(i,rand);
                    assiNodeMarker(prfLevelBuff(i,rand))=0;
                end
            end
        end
    end
end