function compute_binary_map_segs()

close all;
figure;
FI = imread('148.pgm');
imshow(FI);
figure;
path = importdata('paths.txt');
plot(path(:,1),path(:,2));

for pos_ind = 2 :5: max(size(path))
    
    clf;
    
    %hold on;
    x0 = path(pos_ind-1,1);
    y0 = path(pos_ind-1,2);
    
    x1 = path(pos_ind,1);
    y1 = path(pos_ind,2);
 
    hold on;
    %circle(x1,y1,150);
    imshow(maskI(FI,x1,y1,500));
    pause(0.15);
end



end

function result = maskI(I,x,y,r)
    T = zeros(size(I));
    for i = x-r : x+r
        for j = y-r : y+r
            T(i,j) = I(i,j);
            if(isInsideCircle(i,j,x,y,r) == 0)
                T(i,j) = 255; % make it white
            end
        end
    end
    
    result = T(x-r:x+r,y-r:y+r);
    
end

function circle(x,y,r)
%x and y are the coordinates of the center of the circle
%r is the radius of the circle
%0.01 is the angle step, bigger values will draw the circle faster but
%you might notice imperfections (not very smooth)
ang=0:0.01:2*pi; 
xp=r*cos(ang);
yp=r*sin(ang);
plot(x+xp,y+yp,'r-');
end
function result = isInsideCircle(a,b,x,y,r)
%returns 1 if a,b is inside a circle with radius r located at x,y
%returns 0 if it is not 

result = 0;

if(((a-x)*(a-x) + (b-y)*(b-y)) <= r*r)
    result = 1;
end

end



