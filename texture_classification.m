I1=imread ('21-scale_2_im_3_grey.png');%sponge
I2=imread ('06-scale_2_im_3_grey.png');%sandpaper
I3=imread ('55-scale_2_im_3_grey.png');%orange peel
I4=imread ('44-scale_2_im_3_grey.png');%linen
I5=imread ('60-scale_3_im_9_grey.png');%cracker
I6=imread ('46-scale_1_im_1_grey.png');%cotton
I7=imread ('20-scale_1_im_1_grey.png');%foam
I8=imread ('48-scale_1_im_1_grey.png'); %brown bread
I9=imread ('15-scale_2_im_3_grey.png'); %aluminium
subplot(3,3,1);
imshow(I1);
title('Sponge(type 1)');
subplot(3,3,2);
imshow(I2);
title('Sandpaper(type 2)');
subplot(3,3,3);
imshow(I3);
title('Orange peel(type 3)');
subplot(3,3,4);
imshow(I4);
title('Linen(type 4)');
subplot(3,3,5);
imshow(I5);
title('Cracker(type 5)');
subplot(3,3,6);
imshow(I6);
title('Cotton(type 6)');
subplot(3,3,7);
imshow(I7);
title('Foam(type 7)');
subplot(3,3,8);
imshow(I8);
title('Brown bread(type 8)');
subplot(3,3,9);
imshow(I9);
title('Aluminium foil(type 9)');










% I1=rgb2gray(I1);
% I2=rgb2gray(I2);
% I3=rgb2gray(I3);
% I4=rgb2gray(I4);
% I5=rgb2gray(I5);
% I6=rgb2gray(I6);
% I7=rgb2gray(I7);
% I8=rgb2gray(I8);
%I9=rgb2gray(I9);


F1=feature_vector(I1);
F2=feature_vector(I2);
F3=feature_vector(I3);
F4=feature_vector(I4);
F5=feature_vector(I5);
F6=feature_vector(I6);
F7=feature_vector(I7);
F8=feature_vector(I8);
F9=feature_vector(I9);

Test=imread('C:\Users\bhuvi\Documents\MATLAB\New folder\New folder\bb.png');


[rows columns numberOfColorChannels] = size(Test);
if numberOfColorChannels > 1
 Test = rgb2gray(Test);
else
 Test = Test; % It's already gray.
end

FT=feature_vector(Test);

 
D1=sum(sum(abs(FT-F1)));
D2=sum(sum(abs(FT-F2)));
D3=sum(sum(abs(FT-F3)));
D4=sum(sum(abs(FT-F4)));
D5=sum(sum(abs(FT-F5)));
D6=sum(sum(abs(FT-F6)));
D7=sum(sum(abs(FT-F7)));
D8=sum(sum(abs(FT-F8)));
D9=sum(sum(abs(FT-F9)));

D=zeros(1,9);
D=[D1,D2,D3,D4,D5,D6,D7,D8,D9];
ans=min(D);
index=0;
index = find(D == min(D(:)));

index=num2str(index);

switch(index)
    case '1' 
              figure, imshow(Test);
              title(['Test Image is of Sponge(type1)']);
    case '2' 
             figure, imshow(Test);
              title(['Test Image is of Sandpaper(type2)']);
    case '3' 
          figure, imshow(Test);
              title(['Test Image is of Orangepeel(type3)']);
    case '4' 
          figure, imshow(Test);
              title(['Test Image is of linen(type4)']);
    case '5' 
              figure, imshow(Test);
              title(['Test Image is of Cracker(type5)']);
    case '6' 
              figure, imshow(Test);
              title(['Test Image is of Cotton(type6)']);
    case '7' 
              figure, imshow(Test);
              title(['Test Image is of Foam(type7)']);
    case '8' 
              figure, imshow(Test);
              title(['Test Image is of Brown bread(type8)']);
     case '9' 
              figure, imshow(Test);
              title(['Test Image is of Aluminium foil(type9)']);
                      
end       
                        
                        
                        
              
                        
                        
              


J=imnoise(I9,'salt & pepper');


FJ=feature_vector(J);

A1=sum(sum(abs(FJ-F1)));
A2=sum(sum(abs(FJ-F2)));
A3=sum(sum(abs(FJ-F3)));
A4=sum(sum(abs(FJ-F4)));
A5=sum(sum(abs(FJ-F5)));
A6=sum(sum(abs(FJ-F6)));
A7=sum(sum(abs(FJ-F7)));
A8=sum(sum(abs(FJ-F8)));
A9=sum(sum(abs(FJ-F9)));

A=zeros(1,9);
A=[A1,A2,A3,A4,A5,A6,A7,A8,A9];
ans=min(A);
index1=0;
index1 = find(A == min(A(:)));

index1=num2str(index1);

switch(index1)
    case '1' 
              figure, imshow(J);
              title(['Salt and pepper noise present in image.Image identified as Sponge(type1)']);
    case '2' 
             figure, imshow(J);
              title(['Salt and pepper noise present in image.Image identified as Sandpaper(type2)']);
    case '3' 
          figure, imshow(J);
              title(['Salt and pepper noise present in image.Image identified as Orangepeel(type3)']);
    case '4' 
          figure, imshow(J);
              title(['Salt and pepper noise present in image.Image identified as linen(type4)']);
    case '5' 
              figure, imshow(J);
              title(['Salt and pepper noise present in image.Image identified as Cracker(type5)']);
    case '6' 
              figure, imshow(J);
              title(['Salt and pepper noise present in image.Image identified as Cotton(type6)']);
    case '7' 
              figure, imshow(J);
              title(['Salt and pepper noise present in image.Image identified as Foam(type7)']);
    case '8' 
              figure, imshow(J);
              title(['Salt and pepper noise present in image.Image identified as Brown bread(type8)']);
     case '9' 
              figure, imshow(J);
              title(['Salt and pepper noise present in image.Image identified as Aluminium foil(type9)']);
                      
end       







