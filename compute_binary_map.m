function compute_binary_map()

close all;

% FI = imread('148.pgm');
% figure;
% imshow(FI);
% figure;
for t = 1:148
    t
    hold on;
    I = imread(strcat(int2str(t),'.pgm'));
    
    
    
    [m,n] = size(I);
    G = fspecial('gaussian',[5 5],4);
    
    
    R = zeros(size(I));
    RP = zeros(size(I));
    
    for i = 1 : m

        for j = 1 : n

            if(I(i,j)>250)
                R(i,j) = 255;
            end
            
            R(i,j) = 255 - R(i,j);
            RP(i,j) = 255;
        end

    end
    
    
    
    Ig = imfilter(R,G,'same');
%     
%     for i = 1 : m
% 
%         for j = 1 : n
%             if(i < 500 || i > (m-500) || j < 500 || j > (n-500))
%                 Ig(i,j) = 0;
%             end
%             
%         end
% 
%     end
    
    BW2 = bwmorph(Ig,'remove');
    imshow(BW2);
    b=bwboundaries(BW2);
  
    
    max_b_ind = 0;
    
    max_size = 0;

    for i = 1 : size(b,1)
        T = b{i};
        sizeT = size(T,1);
        if(max_size < sizeT  && sizeT < 15000)
            max_size = sizeT;
            max_b_ind = i;
        end
    end

    
     for i = 1 :size(b{max_b_ind})
         T = b{max_b_ind};
         RP(T(i,1),T(i,2)) = 0;
     end
     imwrite(RP,strcat(int2str(t),'.ppm'))
%     imshow(RP);

end


























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
