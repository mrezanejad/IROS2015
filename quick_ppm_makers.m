function quick_ppm_makers()



close all;

% FI = imread('148.pgm');
% figure;
% imshow(FI);
figure;

for aks = 1 : 1
    aks
    clf;
    path_aks = fullfile('..','final',strcat(int2str(aks),'.pgm'));
    I = imread(path_aks);
    
    imwrite(I,'temp.png');
    imshow(I);
    !convert temp.png -resize 50% temp_resized.png
    I = imread('temp_resized.png');

    [I,X1,X2,Y1,Y2] = CropImage( I );
    R = zeros(size(I));
    
    winSize = 1;
    
    [m,n] = size(I);

    black = 0;
    white = 250;
    for i = 1 : m
        for j = 1 : n
            color = 0;
            if(I(i,j)>black && I(i,j) < white)
                color = 255;
                k0 = max(i-winSize,1);
                km = min(i+winSize,m);
                for k = k0:km
                   l0 = max(j-winSize,1);
                   ln = min(j+winSize,n);
                   for l = l0:ln
                       if(I(k,l)<=black || I(k,l) >= white)
                           color = 0;
                           break;      
                       end
                   end
                
                end
            end
            R(i,j) = color;
        end

    end



    Ig = R;%imfilter(R,G,'same');


    path_aks_ppm = fullfile('quick_ppms',strcat(int2str(aks),'.ppm'));

   

    imwrite(Ig,path_aks_ppm);
    
    %     imshow(RP);
    
%         w = waitforbuttonpress;
%     while w == 0
%         pause(5);
%         w = waitforbuttonpress;
%     end
end



end


