function readpgmmaps()

close all;

FI = imread('148.pgm');
figure;
imshow(FI);

for i = 1:5:140
    pause(0.75);
    i
    
    I = imread(strcat(int2str(i+5),'.pgm'));
    [m,n] = size(I);
    I2 = imread(strcat(int2str(i),'.pgm'));
    %figure;
    %imshow(I);
    %figure;
    %imshow(I2);
    
    G = fspecial('gaussian',[5 5],4);

    meanx = 0;
    meany = 0;
    counter = 0;
    I3=  I - I2;
    I4 = I3;
    for i = 1 : m    
        for j = 1 : n
            I4 = 255;
        end
    end
    I3 = I4-I3;
    for i = 1 : m    
        for j = 1 : n
            if(I3(i,j) < 255 )
                I3(i,j) = 0;
            end
        end
    end
    I3 = imfilter(I3,G,'same');
    for i = 1 : m    
        for j = 1 : n
            if(I3(i,j) > 0 )
                I3(i,j) = 255;
            end
            if(I3(i,j) ==0)
                meanx = meanx + i;
                meany = meany + j;
                counter = counter + 1;
            end
        end
    end
    %figure;
    %imshow(I3);
    meanx = meanx/counter;
    meany = meany/counter;
    hold on;
    plot(meany,meanx,'r*');

% figure;
% imshow(I);
    hold on;
    plot(meany,meanx,'r*');

end

% R = zeros(size(I));
% 
% for i = 1 : m
%     
%     for j = 1 : n
%         
%         if(I(i,j)>250)
%             R(i,j) = 255;
%         end
%         
%     end
%     
% end
% 
% Ig = imfilter(R,G,'same');
% figure;
% imshow(Ig);
% 
% 
% center_x = 2050;
% center_y = 1900;

























% hold on;
% plot(center_x,center_y,'g*');
% hold on;
% circle(center_x,center_y,50);


% 
% 
% figure;
% BW = bwmorph(Ig,'remove');
% BW = BW(10:end-10,10:end-10);
% b=bwboundaries(BW);
% boundry=b{1};
% imshow(BW);
% hold on;
% plot(boundry(:,2),boundry(:,1),'g');
% [m,n] = size(BW)
% T = zeros(m,n);
% 
% for i = 10 : m - 10
%     
%     
%     first_is_found = 0;
%     last_is_found = 0;
%     first_white_ind = 0;
%     last_white_ind = 0;
%     
%     for j = 10 : n -10
%         
%         if(BW(i,j)~=0 && first_is_found == 0)
%             first_white_ind = j; 
%             first_is_found = 1;
%         elseif(BW(i,j)~=0)
%             last_white_ind = j;
%             last_is_found = 1;
%         end
%     end
%     if(first_is_found == 1)
%         
%         T(i,first_white_ind) = 255;
%     end
%     if(last_is_found == 1)       
%         T(i,last_white_ind) = 255;
%     end
% end

% imshow(T)

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
