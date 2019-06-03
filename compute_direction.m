 function [ax,bx,ay,by,direction] = compute_direction(x0,x1,y0,y1,windowsize)
    direction = 9;

    % direction can be either north (1) northeast (2) east(3) southeast(4)
    % south(5) southwest(6) west(7) northwest(8) 
    
    ax = 0;
    bx = 0;
    ay = 0;
    by = 0;
    halfWsize = windowsize/2;
    
    if(x1-x0 > 0 && y1-y0 > 0)
        direction = 4;
        ax = 0;
        bx = windowsize;
        ay = 0;
        by = windowsize;
    elseif(x1-x0 == 0 && y1-y0 > 0)
        direction = 3;
        ax = -halfWsize;
        bx = halfWsize;
        ay = 0;
        by = windowsize;
    elseif(x1-x0 < 0 && y1-y0 > 0)
        direction = 2;
        ax = -windowsize;
        bx = 0;
        ay = 0;
        by = windowsize;
    elseif(x1-x0 > 0 && y1-y0 == 0)
        direction = 5;
        ax = 0;
        bx = windowsize;
        ay = -halfWsize;
        by = halfWsize;
    elseif(x1-x0 < 0 && y1-y0 == 0)
        direction = 7;
        ax = -windowsize;
        bx = 0;
        ay = -halfWsize;
        by = halfWsize;
    elseif(x1-x0 > 0 && y1-y0 < 0)
        direction = 8;
        ax = 0;
        bx = windowsize;
        ay = -windowsize;
        by = 0;
    elseif(x1-x0 == 0 && y1-y0 < 0)
        direction = 1;
        ax = -halfWsize;
        bx = halfWsize;
        ay = -windowsize;
        by = 0;
    elseif(x1-x0 < 0 && y1-y0 < 0)
        direction = 8;
        ax = -windowsize;
        bx = 0;
        ay = -windowsize;
        by = 0;
    elseif(x1-x0 == 0 && y1-y0 == 0)
        direction = 9;
        ax = -halfWsize;
        bx = halfWsize;
        ay = -halfWsize;
        by = halfWsize;
    end
end