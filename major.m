I1=imread('img1.jpg');

I2=imread('batman.jpg');

R1=I1(:,:,1);
G1=I1(:,:,2);
B1=I1(:,:,3);

R2=I2(:,:,1);
G2=I2(:,:,2);
B2=I2(:,:,3);

% embedding
% 1 level wavelet transform of cover image
[cA1,cH1,cV1,cD1] = dwt2(R1,'db1');
[cA2,cH2,cV2,cD2] = dwt2(G1,'db1');
[cA3,cH3,cV3,cD3] = dwt2(B1,'db1');

% 1 level wavelet transform of payload image
[cA41,cH41,cV41,cD41] = dwt2(R2,'db1');
[cA51,cH51,cV51,cD51] = dwt2(B2,'db1');
[cA61,cH61,cV61,cD61] = dwt2(G2,'db1');

% 2nd level wavelet transform of payload image LL
[cA4,cH4,cV4,cD4] = dwt2(cA41,'db1');
[cA5,cH5,cV5,cD5] = dwt2(cA51,'db1');
[cA6,cH6,cV6,cD6] = dwt2(cA61,'db1');

alpha = input('enter value of alpha  ');


% embedding 2nd level coefficients into cover image for red component
cA7 = cA1 + alpha*cA4 ;
cH7 = cH1 + alpha*cH4;
cV7 = cV1 + alpha*cV4;
cD7 = cD1 + alpha*cD4;

% embedding 2nd level coefficients into cover image for green component
cA8 = cA2 + alpha*cA5;
cH8 = cH2 + alpha*cH5;
cV8 = cV2 + alpha*cV5;
cD8 = cD2 + alpha*cD5;

% embedding 2nd level coefficients into cover image for blue component
cA9 = cA3 + alpha*cA6;
cH9 = cH3 + alpha*cH6;
cV9 = cV3 + alpha*cV6;
cD9 = cD3 + alpha*cD6;

% inverse wavelet transform leads to formation of stego image
R = (idwt2(cA7,cH7,cV7,cD7,'db1'));
G = (idwt2(cA8,cH8,cV8,cD8,'db1'));
B = (idwt2(cA9,cH9,cV9,cD9,'db1'));

I(:,:,1)= R;
I(:,:,2)= G;
I(:,:,3)= B;


subplot(2,2,1);
imshow(uint8(I1));
xlabel('cover image');

subplot(2,2,2);
imshow(uint8(I2));
xlabel('payload image');

subplot(2,2,3);
imshow(uint8(I));
xlabel('stego image');

% Extraction

R3=I(:,:,1);
G3=I(:,:,2);
B3=I(:,:,3);

% wavelet transform of stego image
[cA10,cH10,cV10,cD10] = dwt2(R3,'db1');
[cA11,cH11,cV11,cD11] = dwt2(G3,'db1');
[cA12,cH12,cV12,cD12] = dwt2(B3,'db1');

% subtracting cover image from stego image and dividing by alpha. This will
% return the 2nd level wavelet coefficients 1st level LL, LH, HL and HH merged together
% using orthogonal codes.

% for Red component
cAr = (cA10 - cA1)/alpha;
cHr = (cH10 - cH1)/alpha;
cVr = (cV10 - cV1)/alpha;
cDr = (cD10 - cD1)/alpha;

% for Green component
cAg = (cA11 - cA2)/alpha;
cHg = (cH11 - cH2)/alpha;
cVg = (cV11 - cV2)/alpha;
cDg = (cD11 - cD2)/alpha;


% for Blue component
cAb = (cA12 - cA3)/alpha;
cHb = (cH12 - cH3)/alpha;
cVb = (cV12 - cV3)/alpha;
cDb = (cD12 - cD3)/alpha;

Rex = idwt2(cAr,cHr,cVr,cDr,'db1');
Gex = idwt2(cAg,cHg,cVg,cDg,'db1');
Bex = idwt2(cAb,cHb,cVb,cDb,'db1');

Iex(:,:,1)= Rex;
Iex(:,:,2)= Gex;
Iex(:,:,3)= Bex;

subplot(2,2,4);
imshow(uint8(Iex));
xlabel('extracted image');

% analysis


snr_red = 10*log10(sum(sum(R.^2)) ./ sum(sum(R1.^2)));

snr_green = 10*log10(sum(sum(G.^2)) ./ sum(sum(G1.^2)));

snr_blue = 10*log10(sum(sum(B.^2)) ./ sum(sum(B1.^2)));

n=size(R1);
 M=n;
 N=n;
x = sum((double(R1)-R).^2);
 MSE = sum(x);
 
PSNR = 10*log10(256*256/MSE);


snr_red

snr_green

snr_blue

MSE

PSNR


