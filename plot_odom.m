close all;
I = importdata('all_centers.txt');

figure;

R1(:,:) = I(:,1:2);
for i=1:size(I,1)
    R1(i,1) = R1(i,1);
    R1(i,2) = R1(i,2)-i*0.0007;
end   
plot(R1(:,1), R1(:,2))
figure;
plot(I(:,1), I(:,2))
% for i=1:size(I,1)
%    % clf;
%     pause(0.01);
%     plot(I(1:i,1), I(1:i,2));
% end