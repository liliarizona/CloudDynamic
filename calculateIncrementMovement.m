function prfcoordinate=calculateIncrementMovement(row,col,t,speed,direction,currentPosition);
prfcoordinate=zeros(1,2);
slabel=floor(rand(1));
if slabel
    prfcoordinate=zeros(1,2);
    if direction==1
        prfcoordinate(1)=currentPosition(1)+1;
        prfcoordinate(2)=currentPosition(2);
    elseif direction==2
        prfcoordinate(1)=currentPosition(1);
        prfcoordinate(2)=currentPosition(2)-1;
    elseif direction==3 
        prfcoordinate(1)=currentPosition(1)-1;
        prfcoordinate(2)=currentPosition(2);
    else
        prfcoordinate(1)=currentPosition(1);
        prfcoordinate(2)=currentPosition(2)+1;
    end

    prfcoordinate(1)=min(prfcoordinate(1),1);
    prfcoordinate(1)=max(prfcoordinate(1),row);

    prfcoordinate(2)=min(prfcoordinate(2),1);
    prfcoordinate(2)=max(prfcoordinate(2),col);
else
    prfcoordinate=currentPosition;
end


    
