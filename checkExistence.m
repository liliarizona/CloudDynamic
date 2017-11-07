function [newEI]=checkExistence(current_position,exit,eI)
%current_position
num_p=length(eI);
[num_e bla]=size(exit);
newEI=ones(1,num_p);
for i=1:1:num_p
    if(eI(i) ~= 0)
        for j=1:1:num_e
            if(current_position(i,1)==exit(j,1) & current_position(i,2)==exit(j,2))
                newEI(i)=0;
                disp('this time canceled:');
                i
                current_position(i,1)=0;
                current_position(i,2)=0;
                break;
            end
        end
    else
        newEI(i)=0;
    end
end