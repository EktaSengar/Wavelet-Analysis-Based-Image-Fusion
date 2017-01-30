%reading the ct and mri images
ct1=imread('ct_brain.jpg');
mri1=imread('mri_brain.jpg');

%taking wavelet transform of the two images
[LL4, LH4, HL4, HH4]=dwt2(ct1,'db1');
[LL5, LH5, HL5, HH5]=dwt2(mri1,'db1');

%fusion of approximate components
for i = 1:4:125
 for j = 1:4:125
     A1 = LL4(i:i+3,j:j+3);
     B1 = LL5(i:i+3,j:j+3);
     Z_LL=fusion_LL(A1,B1);
     final_LL(i:i+3,j:j+3)=Z_LL;
 end 
end
%fusion of horizontal detailed components
for i = 1:4:125
 for j = 1:4:125
     A1 = LH4(i:i+3,j:j+3);
     B1 = LH5(i:i+3,j:j+3);
     C1 = HL4(i:i+3,j:j+3);
     D1 = HL5(i:i+3,j:j+3);
     E1 = HH4(i:i+3,j:j+3);
     F1 = HH5(i:i+3,j:j+3);
     Z_LH=fusion_LH(A1,B1,C1,D1,E1,F1);
     final_LH(i:i+3,j:j+3)=Z_LH;
 end 
end

%fusion of vertical detailed components
for i = 1:4:125
 for j = 1:4:125
     A1 = LH4(i:i+3,j:j+3);
     B1 = LH5(i:i+3,j:j+3);
     C1 = HL4(i:i+3,j:j+3);
     D1 = HL5(i:i+3,j:j+3);
     E1 = HH4(i:i+3,j:j+3);
     F1 = HH5(i:i+3,j:j+3);
     Z_HL=fusion_HL(A1,B1,C1,D1,E1,F1);
     final_HL(i:i+3,j:j+3)=Z_HL;
 end 
end

%fusion of diagonal detailed components
for i = 1:4:125
 for j = 1:4:125
     A1 = LH4(i:i+3,j:j+3);
     B1 = LH5(i:i+3,j:j+3);
     C1 = HL4(i:i+3,j:j+3);
     D1 = HL5(i:i+3,j:j+3);
     E1 = HH4(i:i+3,j:j+3);
     F1 = HH5(i:i+3,j:j+3);
     Z_HH=fusion_HH(A1,B1,C1,D1,E1,F1);
     final_HH(i:i+3,j:j+3)=Z_HH;
 end 
end

%taking inverse wavelet transform
final=idwt2(final_LL,final_LH,final_HL,final_HH,'db1');

for i=1:256
    for j=1:256
        if final(i,j)<20;
            final1(i,j)=mri1(i,j);
        else
            final1(i,j)=final(i,j);
        end
    end
end

subplot(2,2,1)
imshow(ct1);
title('CT image of brain');
subplot(2,2,2);
imshow(mri1);
title('MRI image of brain');
subplot(2,2,3);
imshow(uint8(final1));
title('Fused image with proposed method');

%comparison
a=(LL4+LL5)/2;
b=(LH4+LH5)/2;
c=(HL4+HL5)/2;
d=(HH4+HH5)/2;
final2=idwt2(a,b,c,d,'db1');
subplot(2,2,4)
imshow(uint8(final2));
title('Fused image with other method');

entropy_of_fused_image=entropy(final1)
entropy_of_mri_image=entropy(mri1)
entropy_of_ct_image=entropy(ct1)
entropy_of_fused_image_with_other_method=entropy(uint8(final2))



