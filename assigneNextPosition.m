function nextPosition=assigneNextPosition(row,col,prfList,prfPoint,currentPosition)
[num_p,num_d]=size(prfList);
nextPosition=zeros(row,col);
assiMarker=zeros(row,col);
assiNodeMarker=ones(1,num_p);

prfBuff=zeros(row*col,num_p);

for k=1:1:num_p
    for kk=1:1:num_d
        if(prfList(k,kk)>0)
            prfBuff((prfPoint(k,2*kk-1)-1)*row+prfPoint(k,2*kk),sum( prfBuff((prfPoint(k,2*kk-1)-1)*row+prfPoint(k,2*kk),:))+1)=k;
        end
    end
end

for k=1:1:row*col
    numFellow=length(find(prfBuff(k,:)~=0));
    if numFellow>0
        tempcol=mod(k,row);
        temprow=floor(k/row)+1;
        assiMarker(temprow,tempcol)=1;
    end
    if numFellow==1
        tempcol=mod(k,row);
        temprow=floor(k/row)+1;
        nextPosition(temprow,tempcol)=prfBuff(k,1);
        assiNodeMarker(prfBuff(k,1))=0;
    end
end
nextPosition

iterCount=1;
while sum(sum(assiMarker))>0
    for i=1:1:row
        for j=1:1:col
            if(assiMarker)
                competitors=find(prfBuff((i-1)*row+j,:)~=0);
                num_c=length(competitors);
                competitorsInfo=zeros(num_c,3);
                flag=1;
                for k=1:1:num_c
                    competitorsInfo(k,1)=competitors(k);
                    competitorsInfo(k,3)=find(prfList(competitorsInfo(k,1))~=0);
                    for kk=1:1:num_d
                        if prfPoint(competitors(k),2*kk-1)==i && prfPoint(competitors(k),2*kk)==j
                            competitorsInfo(k,2)=kk;
                        end
                    end
                    if(competitorsInfo(k,3)==competitorsInfo(k,2))
                        nextPosition(i,j)=competitorsInfo(k,1);
                        assiMarker(i,j)=0;
                        assiNodeMarker(competitorsInfo(k,1))=0;
                        flag=0;
                    end
                end
                if(flag)
                    mostprf=min(competitorsInfo(:,2));
                    tobeAssiNode=competitorsInfo(find(competitorsInfo(:,2)==mostprf),1);
                    nextPosition(i,j)=tobeAssiNode;
                    assiMarker(i,j)=0;
                    assiNodeMarker(tobeAssiNode)=0;
                end
            end
        end
    end
    iterCount=iterCount+1;
    if(iterCount>num_d)
        notAssiNode=find(assiNodeMarker~=0);
        for ii=1:1:length(notAssiNode)
            [assiMarker assiNodeMarker nextPosition]=assiNearestUnassignedSlot(row,col,notAssiNode(ii),assiMarker,assiNodeMarker,currentPosition(notAssiNode(ii),:),nextPosition);
        end
    end
end