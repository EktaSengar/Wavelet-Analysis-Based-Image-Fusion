function[F]= feature_vector(img)
[LL LH HL HH]=dwt2(img,'db2');
M=mean2(LL);
S=std2(LL);
glcm = graycomatrix(LL,'offset',[0 1],'Symmetric', true);
C = graycoprops(glcm,'contrast');
E = graycoprops(glcm,'energy');
H = graycoprops(glcm,'homogeneity');
En=entropy(LL);
C=struct2cell(C);
E=struct2cell(E);
H=struct2cell(H);

M1=mean2(LH);
S1=std2(LH);
glcm1 = graycomatrix(LH,'offset',[0 1],'Symmetric', true);
C1 = graycoprops(glcm1,'contrast');
E1 = graycoprops(glcm1,'energy');
H1 = graycoprops(glcm1,'homogeneity');
CO1 = graycoprops(glcm1,'Correlation');
En1=entropy(LH);
C1=struct2cell(C1);
E1=struct2cell(E1);
H1=struct2cell(H1);
CO1=struct2cell(CO1);


M2=mean2(HL);
S2=std2(HL);
glcm2 = graycomatrix(HL,'offset',[0 1],'Symmetric', true);
C2 = graycoprops(glcm2,'contrast');
E2 = graycoprops(glcm2,'energy');
H2 = graycoprops(glcm2,'homogeneity');
CO2 = graycoprops(glcm2,'Correlation');
En2=entropy(HL);
C2=struct2cell(C2);
E2=struct2cell(E2);
H2=struct2cell(H2);
CO2=struct2cell(CO2);



M3=mean2(HH);
S3=std2(HH);
glcm3 = graycomatrix(HH,'offset',[0 1],'Symmetric', true);
C3 = graycoprops(glcm3,'contrast');
E3 = graycoprops(glcm3,'energy');
H3 = graycoprops(glcm3,'homogeneity');
CO3 = graycoprops(glcm3,'Correlation');
En3=entropy(HH);
C3=struct2cell(C3);
E3=struct2cell(E3);
H3=struct2cell(H3);
CO3=struct2cell(CO3);



glcmI = graycomatrix(img,'offset',[0 1],'Symmetric', true);
C4 = graycoprops(glcmI,'contrast');
E4 = graycoprops(glcmI,'energy');
H4 = graycoprops(glcmI,'homogeneity');
CO4 = graycoprops(glcmI,'Correlation');
En4=entropy(img);
C4=struct2cell(C4);
E4=struct2cell(E4);
H4=struct2cell(H4);
CO4=struct2cell(CO4);

C=cell2mat(C);
E=cell2mat(E);
H=cell2mat(H);

C1=cell2mat(C1);
E1=cell2mat(E1);
H1=cell2mat(H1);
CO1=cell2mat(CO1);

C2=cell2mat(C2);
E2=cell2mat(E2);
H2=cell2mat(H2);
CO2=cell2mat(CO2);

C3=cell2mat(C3);
E3=cell2mat(E3);
H3=cell2mat(H3);
CO3=cell2mat(CO3);

C4=cell2mat(C4);
E4=cell2mat(E4);
H4=cell2mat(H4);
CO4=cell2mat(CO4);


F=[M S C E H 0 En; M1 S1 C1 E1 H1 CO1 En1; M2 S2 C2 E2 H2 CO2 En2; M3 S3 C3 E3 H3 CO3 En3;0 0 C4 E4 H4 CO4 En4];
end