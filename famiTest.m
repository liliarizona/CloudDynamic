function [list]=famiTest(row,col,num_drct,myt,f,s,cP,mycP,wall,exit)
% familarity, 1:familiar, know where the exit is.
%             2:unfamiliar, follow the mass.
%             3.unfamiliar, random walk.

if(f==1)
    %list=exitOnly(row,col,num_drct,myt,s,mycP,exit);
    list=exitOnlyShortestPath(row,col,num_drct,myt,s,mycP,wall,exit);
elseif(f==3)
    list=randperm(5);
else
    list=zeros(1,num_drct+1);
    mymap=zeros(row,col);
    [num_p m]=size(cP);
    for i=1:1:num_p
        if(cP(i,1)>0 && cP(i,2)>0)
            mymap(cP(i,1),cP(i,2))=1;
        end
    end
    %if surrounded by people, prefer stay in the same slot
    if(mycP(1)==0 || mycP(2)==0)
        list=randperm(5);
    else
        surrounded=checkSurrounded(mycP,mymap);
        if(surrounded==1)
            list=[5 randperm(4)];
        else
            maxSight=5;
            index=1;
            for i=1:1:maxSight
                dense=zeros(1,4);
                wPoint=[mycP(1)-i mycP(2)];
                ePoint=[mycP(1)+i mycP(2)];
                sPoint=[mycP(1) mycP(2)-i];
                nPoint=[mycP(1) mycP(2)+i]; 
                dense(1)=checkDense(ePoint,mymap,i);
                dense(2)=checkDense(sPoint,mymap,i);
                dense(3)=checkDense(wPoint,mymap,i);
                dense(4)=checkDense(nPoint,mymap,i);
                ldirt=0;
                lbuff=0;
                for j=1:1:4
                    if(dense(j)>lbuff)
                        ldirt=j;
                        lbuff=dense(j);
                    end
                end
                if(ldirt~=0)
                    tempdrct=ldirt;
                    if(index==1)
                        list(index)=tempdrct;
                        index=index+1;
                    else
                        flag=1;
                        for j=1:1:(index)
                            if(list(j)==tempdrct)
                                flag=0;
                            end
                        end
                        if(flag)
                            list(index)=tempdrct;
                            index=index+1;
                        end
                    end
                end
            end
            if(sum(list)==0)
                 list=randperm(5);
            else
                zC=0;
                for j=1:1:5
                    if(list(i)==0)
                        zC=zC+1;
                    end
                end
                tempL=randperm(5);
                tempAdd=zeros(1,zC);
                indextemp=1;
                for j=1:1:5
                    flagg=1;
                    for jj=1:1:(5-zC)
                       if(tempL(j)==list(jj))
                            flagg=0;
                       end
                    end
                    if(flagg==1)
                        tempAdd(indextemp)=tempL(j);
                        indextemp=indextemp+1;
                    end
                end
                list=[list(1:(5-zC)) tempAdd];
            end
        end
    end
end