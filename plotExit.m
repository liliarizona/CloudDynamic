function plotExit(exit)
exit=exit-1;
[num_e bla]=size(exit);
for i=1:1:num_e
    s1=exit(i,1);
    s2=exit(i,2);
    rectangle('Position',[s1,s2,1,1],'Curvature',[0,0],...
      'FaceColor','k')
end