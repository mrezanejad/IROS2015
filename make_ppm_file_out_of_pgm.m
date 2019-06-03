function make_ppm_file_out_of_pgm(pgm_file_name,ppm_file_name)

    I = imread(pgm_file_name);
    [m,n] = size(I);
    G = fspecial('gaussian',[2 2],1);


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

%           figure;
%    imshow(Ig);
%     %     
% pause;

        for i = 1 : m
    
            for j = 1 : n
                if(i < 500 || i > (m-500) || j < 500 || j > (n-500))
                    Ig(i,j) = 0;
                end
                
            end
    
        end

    BW2 = bwmorph(Ig,'remove');

    b=bwboundaries(BW2);

    
    szToIdx = zeros(size(b,1),2);
    for tt=1:size(b,1)
        szToIdx(tt,:) = [tt,size(b{tt},1)];
    end
    
  
            
            

    for i = 1 : size(b,1)
        T1 = szToIdx(i,:);
        for j = i+1 : size(b,1)
            T2 = szToIdx(j,:);
            if T1(1,2) < T2(1,2)
                szToIdx(i,:) = T2;
                szToIdx(j,:) = T1;
                T1 = szToIdx(i,:);
            end
        end
    end
    boundsImg = zeros(size(RP,1),size(RP,2),min(size(b,1),20));

    T = b{szToIdx(3,1)};
    F = poly2mask(T(:,1),T(:,2),size(RP,1),size(RP,2));
    szToIdx(2,1)

    size(T,1)


    extra_cnts = 0;
     for k = 4 : size(b,1)
         T = b{szToIdx(k,1)};
         sz = size(T,1);
         if sz > 100 && extra_cnts <20
             extra_cnts = extra_cnts+1;
             boundsImg(:,:,extra_cnts) = poly2mask(T(:,1),T(:,2),size(RP,1),size(RP,2));
         else
             break;
         end

     end

     

    extra_cnts
     
     for i = 1 : size(F,1)
         for j = 1 : size(F,2)
             if(F(i,j)==0)
                 F(i,j) = 255;
             else
                 clr = 0;
                 for cnt=2:extra_cnts
                     if(boundsImg(i,j,cnt) > 0 )
                         clr = 255;
                         break;
                     end         
                 end
                 F(i,j) = clr;
             end
         end
     end
     F = F';
     FCopy(:,:) = F(:,:);
    for i = 2 : size(F,1)-1 
        for j = 2 : size(F,2)-1
            if(F(i,j) > 0 )
                if(F(i-1,j-1)==0 ||F(i-1,j)==0 ||F(i-1,j+1)==0 ||F(i,j-1)==0 ||F(i,j+1)==0 ||F(i+1,j-1)==0 ||F(i+1,j)==0 ||F(i+1,j+1)==0) 
                    FCopy(i,j) = 0;

                end
            end
        end
    end

    imwrite(FCopy,'temp.png');
    !convert temp.png -resize 50% temp_resized.png
    new_I = imread('temp_resized.png');
%     [mf, nf] = size(new_I);
   % new_I = FCopy(100:mf-100,100:nf-100);
    %figure;
    %imshow(new_I);
  %  new_I
    %new_I = new_I(:,:,1);
%     imwrite(new_I,'temp.png');
%     !convert temp.png -resize 50% temp_resized.png
%     new_I = imread('temp_resized.png');
    for i = 1 :size(new_I,1)
        for j = 1 : size(new_I,2)
            if(new_I(i,j) > 0.5)
                new_I(i,j) = 255;
            else
                new_I(i,j) = 0;
            end
        end
    end
    %figure;
   % imshow(new_I);
% X1 = 99999999;
% X2 = 0;
% Y1 = 99999999;
% Y2 = 0;
% for i=1:size(new_I,1)
%     for j=1:size(new_I,2)
%         if new_I(i,j)<0.5
%             if i<X1
%                 X1 = i;
%             end
%             if i>X2
%                 X2 = i;
%             end            
%             if j<Y1
%                 Y1 = j;
%             end
%             if j>Y2
%                 Y2 = j;
%             end 
%         end
%     end
% end
% 
% F = new_I(max(X1-100,1):min(X2+100,size(new_I,1)),max(Y1-100,1):min(Y2+100,size(new_I,2)));

    imwrite(new_I,ppm_file_name);


end
