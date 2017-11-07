function plotWall(wall)
%wall=wall-1;
%plot walls
[num_w bla]=size(wall);
for i=1:1:num_w
    s1=wall(i,1)-1;
    s2=wall(i,3)-1;
    wide=wall(i,2)-wall(i,1)+1;
    hight=wall(i,4)-wall(i,3)+1;
    rectangle('Position',[s1,s2,wide,hight],'Curvature',[0,0],...
      'FaceColor','g')
end