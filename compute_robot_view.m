 function [tx1,ty1,tx2,ty2,tx3,ty3,tx4,ty4,direction] = compute_robot_view(x0,x1,y0,y1,windowsize)
    direction = 9;

    % direction can be either north (1) northeast (2) east(3) southeast(4)
    % south(5) southwest(6) west(7) northwest(8) 
    

    halfWsize = windowsize/2;
    sqhSize = halfWsize*sqrt(2)/2;
    tx1=0;ty1=0;tx2=0;ty2=0;tx3=0;ty3=0;tx4=0;ty4=0;
    
    
    
    if(x1-x0 > 0 && y1-y0 > 0)
        direction = 4;
        tx1=x1+sqhSize; ty1 = y1-3*sqhSize;
        tx2=x1-sqhSize; ty2 = y1-sqhSize;
        tx3=x1+sqhSize; ty3 = y1+sqhSize;
        tx4=x1+3*sqhSize; ty4 = y1-sqhSize;
    elseif(x1-x0 == 0 && y1-y0 > 0)
        direction = 3;
        tx1=x1; ty1 = y1-halfWsize;
        tx2=x1; ty2 = y1+halfWsize;
        tx3=x1+windowsize; ty3 = y1-halfWsize;
        tx4=x1+windowsize; ty4 = y1+halfWsize;
        
    elseif(x1-x0 < 0 && y1-y0 > 0)
        direction = 2;        
        tx1=x1+sqhSize; ty1 = y1-sqhSize;
        tx2=x1-sqhSize; ty2 = y1+sqhSize;
        tx3=x1+sqhSize; ty3 = y1+3*sqhSize;
        tx4=x1+3*sqhSize; ty4 = y1+sqhSize;
    elseif(x1-x0 > 0 && y1-y0 == 0)
        direction = 5;
        tx4=x1-halfWsize; ty4 = y1;
        tx3=x1+halfWsize; ty3 = y1;
        tx1=x1-halfWsize; ty1 = y1-windowsize;
        tx2=x1+halfWsize; ty2 = y1-windowsize;  
        
    elseif(x1-x0 < 0 && y1-y0 == 0)
        direction = 7;
        
   
        tx1=x1-windowsize; ty1 = y1-halfWsize;
        tx2=x1-windowsize; ty2 = y1+halfWsize;
        tx3=x1; ty3 = y1+halfWsize;
        tx4=x1; ty4 = y1-halfWsize;
        
    elseif(x1-x0 > 0 && y1-y0 < 0)
        direction = 6;        
        tx4=x1+sqhSize; ty4 = y1-sqhSize;
        tx3=x1-sqhSize; ty3 = y1+sqhSize;
        tx1=x1-sqhSize; ty1 = y1-3*sqhSize;
        tx2=x1-3*sqhSize; ty2 = y1-sqhSize;
    elseif(x1-x0 == 0 && y1-y0 < 0)
        direction = 1;
        tx1=x1-halfWsize; ty1 = y1;
        tx2=x1+halfWsize; ty2 = y1;
        tx3=x1+halfWsize; ty3 = y1+windowsize;
        tx4=x1-halfWsize; ty4 = y1+windowsize;
        
    elseif(x1-x0 < 0 && y1-y0 < 0)
        direction = 8;
        tx3=x1-sqhSize; ty3 = y1+3*sqhSize;
        tx1=x1-sqhSize; ty1 = y1-sqhSize;
        tx4=x1+sqhSize; ty4 = y1+sqhSize;
        tx2=x1-3*sqhSize; ty2 = y1+sqhSize;
    elseif(x1-x0 == 0 && y1-y0 == 0)
        direction = 9;
        tx1=x1-halfWsize; ty1 = y1-halfWsize;
        tx2=x1-halfWsize; ty2 = y1+halfWsize;
        tx3=x1+halfWsize; ty3 = y1+halfWsize;
        tx4=x1+halfWsize; ty4 = y1-halfWsize;
    end
end