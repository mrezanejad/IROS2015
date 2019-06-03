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
    !convert temp.png -resize 30% temp_resized.png
    I = imread('temp_resized.png');

    [I,X1,X2,Y1,Y2] = CropImage( I );
    R = zeros(size(I));
    
    winSize = 1;
    
    [m,n] = size(I);

    black = 200;
  %  white = 255;
    margin = 5;
    for i = 1 : m
        for j = 1 : n
            color = 0;
         
           % if(I(i,j)>black && I(i,j) < white)
                %color = 255;
                k0 = max(i-winSize,1);
                km = min(i+winSize,m);
                isObstacle = 0;
                for k = k0:km
                   l0 = max(j-winSize,1);
                   ln = min(j+winSize,n);
                   for l = l0:ln
                       if(I(k,l)<=black)
                           isObstacle = 1;
                           break;      
                       end
                   end
                   if isObstacle == 1
                       color = 255;
                       break
                   end               
                end
            %end
            R(i,j) = color;
        end

    end
    
    IM = zeros(size(I));

    winSize = 7;
    removeThreshold = 0.90;
    for i = 1 : m
        for j = 1 : n
            IM(i,j) = R(i,j);
            if i<margin || j<margin || i> m-10 || j>n-10
                IM(i,j) = 255;
            else
                if R(i,j) == 0
                    k0 = max(i-winSize,1);
                    km = min(i+winSize,m);
                    count = 0;
                    for k = k0:km
                       l0 = max(j-winSize,1);
                       ln = min(j+winSize,n);
                       for l = l0:ln
                           if(R(k,l)== 255)
                               count = count+1;      
                           end
                       end
                    end
                    if count > (km-k0)*(ln-l0)*removeThreshold
                       IM(i,j) = 255;
                    end
                end
            end
        end
    end
    
    Ig = zeros(size(I));

    winSize = 5;
    removeThreshold = 0.85;
    for i = 1 : m
        for j = 1 : n
            Ig(i,j) = IM(i,j);
            if i<margin || j<margin || i> m-10 || j>n-10
                Ig(i,j) = 255;
            else
                if IM(i,j) == 0
                    k0 = max(i-winSize,1);
                    km = min(i+winSize,m);
                    count = 0;
                    for k = k0:km
                       l0 = max(j-winSize,1);
                       ln = min(j+winSize,n);
                       for l = l0:ln
                           if(IM(k,l)== 255)
                               count = count+1;      
                           end
                       end
                    end
                    if count > (km-k0)*(ln-l0)*removeThreshold
                       Ig(i,j) = 255;
                    end
                end
            end
        end
    end
                    
   % Ig = IM;

    path_aks_ppm = fullfile('quick_ppms',strcat(int2str(aks),'.ppm'));
    imwrite(Ig,path_aks_ppm);

   
    figure;
    imshow(Ig);
    
    %     imshow(RP);
    
%         w = waitforbuttonpress;
%     while w == 0
%         pause(5);
%         w = waitforbuttonpress;
%     end
end



end


