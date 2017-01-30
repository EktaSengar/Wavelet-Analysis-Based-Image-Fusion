I = imread('fog71.jpg');
I = rgb2gray(I);
I1 = imadjust(I);

cim=double(I1);

[r,c]=size(I1);
cim=cim+1;
% add 1 to pixels to remove 0 values which would result in undefined log values

% natural log
lim=log(cim);
%2D fft
fim=fft2(lim);

lowg=.95; %(lower gamma threshold, must be lowg < 1)
highg=1.05; %(higher gamma threshold, must be highg > 1)
% make sure the the values are symmetrically differenced

% function call
him=homomorph(fim,lowg,highg);
%inverse 2D fft
ifim=real(ifft2(him)); 
%exponent of result
Ihmf = exp(ifim);


J = histeq(I1); %histogram equalization


nColors = double(intmax(class(I1)))+1;  % Number of values per color component
nLevel = 1;                             % Number of decompositions

% Taking Wavelet transform
[cA,cH,cV,cD] = dwt2(J,'db1');
 

%Non-linear Gain Function
x = -1:0.01:1;
b = 0.25; % 0<b<1
c = 40;
syms fun;
a = 1/(sigm(c*(1-b))-sigm(-c*(1+b)));
fun = a.*(sigm(c.*(x-b)) - sigm(-c.*(x+b)));
figure, plot(x,fun);
xlabel('x');
ylabel('funtion');
title('Non-linear Gain Function');

%Finding maximum value of a detail components matrix
cHvector = max(cH);              
cHmax = max(cHvector);

cVvector = max(cV);
cVmax = max(cVvector);

cDvector = max(cD);
cDmax = max(cDvector);

%Normalizing the transform coeficient values 
wH = division(cH,cHmax);
wV = division(cV,cVmax);
wD = division(cD,cDmax);

%Enhanced detail coefficients
funH = (a*cHmax).*(sigm(c.*(wH-b)) - sigm(-c.*(wH+b)));
funV = (a*cVmax).*(sigm(c.*(wV-b)) - sigm(-c.*(wV+b)));
funD = (a*cDmax).*(sigm(c.*(wD-b)) - sigm(-c.*(wD+b)));

%Calculating the threshold values using threshold function
Th = threshold(cH);
Tv = threshold(cV);  
Td = threshold(cD);  



%  
% if abs(cH)< Th
%    difH = cH - K;
% else
%    difH = cH + K;
% end
% 
% if abs(cV)< Tv
%    difV = cV- K;
% else
%    difV = cV + K;
% end
% 
% if abs(cD)< Td
%    difD = cD- K;
% else
%    difD = cD + K;
% end


%RECONSTRUCTED IMAGE
 IR = idwt2(cA,funH,funV,funD,'db1');
 
 
figure, subplot(2,2,1);
        imshow(I);
        title('a)Original image');
        subplot(2,2,2);
        imshow(uint8(Ihmf));
        title('b)Homomorphic Filtered image');
        subplot(2,2,3);
        imshow(uint8(J));
        title('c)Histogram equalized image');
        subplot(2,2,4);
        imshow(uint8(IR));
        title('d)Wavelet Fusion Method');


%Squared gradient
[FxI,FyI]= gradient(double(I));
FI = FxI.^2 + FyI.^2;
sgI = sum(sum(FI));

[FxIhmf,FyIhmf]= gradient(double(Ihmf));
FIhmf = FxIhmf.^2 + FyIhmf.^2;
sgIhmf = sum(sum(FIhmf));

[FxJ,FyJ]= gradient(double(J));
FJ = FxJ.^2 + FyJ.^2;
sgJ = sum(sum(FJ));

[FxIR,FyIR]= gradient(double(IR));
FIR = FxIR.^2 + FyIR.^2;
sgIR = sum(sum(FIR));
  


sgI

sgIhmf

sgJ

sgIR
  


   
