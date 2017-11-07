function [dist]=testShortestPath(row,col,wall,exit,myPosition)
[num_e blah]=size(exit);
dist=zeros(1,num_e);


num_node=row*col;
%distMatrix=row*col*10*ones(num_node,num_node);
distMatrix=zeros(num_node,num_node);

wallLabel=ones(1,num_node);
positionArr=zeros(num_node,2);


for i=1:1:num_node
    tempcol=mod(i,row);
    temprow=ceil(i/row);
    %temprow=round(i/row);
    if(tempcol==0)
        tempcol=col;
    end
    positionArr(i,:)=[temprow tempcol];
    wallLabel(i)=isWall(wall,positionArr(i,:));
end

for i=1:1:num_node
    for j=1:1:num_node
        if(wallLabel(i)==0 && wallLabel(j)==0)
            %if i==j
            %    distMatrix(i,j)=0;
            %end
            if (positionArr(i,1)==positionArr(j,1) && abs(positionArr(i,2)-positionArr(j,2))==1)
                distMatrix(i,j)=abs(positionArr(i,2)-positionArr(j,2));
            end
            if (positionArr(i,2)==positionArr(j,2) && abs(positionArr(i,1)-positionArr(j,1))==1)
                distMatrix(i,j)=abs(positionArr(i,1)-positionArr(j,1));
            end
        end
    end
end

distMatrixSparse=sparse(distMatrix);

my_node=row*(myPosition(1)-1)+myPosition(2);
node_e=zeros(1,num_e);
for i=1:1:num_e
   node_e(i)=(exit(i,1)-1)*row+exit(i,2);
end

for i=1:1:num_e
    [dist(i),path,pred]=graphshortestpath(distMatrixSparse,my_node,node_e(i));
end
lenp=length(path);
%path
for i=1:1:(lenp)
    positionArr(path(i),:);
end
