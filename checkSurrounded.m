function [sur]=checkSurrounded(mycP,mymap)
[row col]=size(mymap);

flag=0;
wPoint=[mycP(1)-1 mycP(2)];
ePoint=[mycP(1)+1 mycP(2)];
sPoint=[mycP(1) mycP(2)-1];
nPoint=[mycP(1) mycP(2)+1];

if(wPoint(1)<1)
    flag=flag+1;
else
    if(mymap(wPoint(1),wPoint(2))==1)
        flag=flag+1;
    end
end

if(ePoint(1)>row)
    flag=flag+1;
else
    if(mymap(ePoint(1),ePoint(2))==1)
        flag=flag+1;
    end
end

if(sPoint(2)<1)
    flag=flag+1;
else
    if(mymap(sPoint(1),sPoint(2))==1)
        flag=flag+1;
    end
end

if(nPoint(2)>col)
    flag=flag+1;
else
    if(mymap(nPoint(1),nPoint(2))==1)
        flag=flag+1;
    end
end

if(flag==4)
    sur=1;
else
    sur=0;
end