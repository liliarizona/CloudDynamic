function plotPosition(x,y,t)
    alpha=0:pi/20:2*pi;%angle
    R=0.2; % radius
    cx=R*cos(alpha)+x; 
    cy=R*sin(alpha)+y; 
    plot(cx,cy,'-');
    hold on;
    if(t==1)
        fill(cx,cy,'r');
    else
        fill(cx,cy,'b');
    end