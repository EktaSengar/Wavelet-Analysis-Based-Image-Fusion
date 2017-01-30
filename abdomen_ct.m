ct1=imread('ct_abdomen.jpg');
mri1=imread('mri_abdomen.jpg');
[LL4, LH4, HL4, HH4]=dwt2(ct1,'db1');
[LL5, LH5, HL5, HH5]=dwt2(mri1,'db1');
for i = 1:4:65
 for j = 1:4:65
     A1 = LL4(i:i+3,j:j+3);
     B1 = LL5(i:i+3,j:j+3);
     Z_LL=fusion_LL(A1,B1);
     final_LL(i:i+3,j:j+3)=Z_LL;
 end 
end
for i = 1:4:65
 for j = 1:4:65
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
for i = 1:4:65
 for j = 1:4:65
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
for i = 1:4:65
 for j = 1:4:65
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

final=idwt2(final_LL,final_LH,final_HL,final_HH,'db1');
for i=1:128
    for j=1:128
        if final(i,j)<15;
            final1(i,j)=mri1(i,j);
        else
            final1(i,j)=final(i,j);
        end
    end
end
subplot(2,2,1)
imshow(uint8(final1));
subplot(2,2,2)
imshow(ct1);
subplot(2,2,3)
imshow(mri1);