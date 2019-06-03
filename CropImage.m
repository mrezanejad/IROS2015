function [F,X1,X2,Y1,Y2] = CropImage( I )

X1 = 99999999;
X2 = 0;
Y1 = 99999999;
Y2 = 0;

for i=1:size(I,1)
    for j=1:size(I,2)
        if I(i,j)<200
            if i<X1
                X1 = i;
            end
            if i>X2
                X2 = i;
            end            
            if j<Y1
                Y1 = j;
            end
            if j>Y2
                Y2 = j;
            end 
        end
    end
end

F = I(max(X1-40,1):min(X2+40,size(I,1)),max(Y1-40,1):min(Y2+40,size(I,2)));

end