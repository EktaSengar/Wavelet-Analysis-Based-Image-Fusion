% I : The input image (vessel image)
%preferable class of image is double or single

C=imread('retina1.jpg');
I= rgb2gray(C);
m = size(I);
I=double(I);
%use it in case the image is rgb, read it in variable C and
%remove this comment

%  Applying Hessian2 Filter on the image with 2nd derivatives of a 
%  Gaussian with parameter Sigma.
%   I : The image
%   Sigma : The sigma of the gaussian kernel used
%   Dxx, Dxy, Dyy: The 2nd derivatives
    Sigma = 1;
% Make kernel coordinates
    [X,Y]   = ndgrid(-round(5*Sigma):round(5*Sigma));

% Build the gaussian 2nd derivatives filters
    DGaussxx = 1/(2*pi*Sigma^4) * (X.^2/Sigma^2 - 1) .* exp(-(X.^2 + Y.^2)/(2*Sigma^2));
    DGaussxy = 1/(2*pi*Sigma^6) * (X .* Y)           .* exp(-(X.^2 + Y.^2)/(2*Sigma^2));
    DGaussyy = DGaussxx';

    Dxx = imfilter(I,DGaussxx,'conv');
    Dxy = imfilter(I,DGaussxy,'conv');
    Dyy = imfilter(I,DGaussyy,'conv');

% Compute the eigen values from the hessian matrix, sorted by abs value.

tmp = sqrt((Dxx - Dyy).^2 + 4*Dxy.^2);

% Compute the eigenvalues
mu1 = 0.5*(Dxx + Dyy + tmp);
mu2 = 0.5*(Dxx + Dyy - tmp);

% Sort eigen values by absolute value abs(Lambda1)<abs(Lambda2)
check=abs(mu1)>abs(mu2);

if (check==0)
    Lambda1=mu1;
    Lambda2=mu2;
else
    Lambda1=mu2;
    Lambda2=mu1;
end

% applying frangi vesselness

% compute similarity measures
    Lambda1(Lambda1==0) = eps;
    Rb = (Lambda1./Lambda2).^2;
    S2 = (Lambda1.^2 + Lambda2.^2);
    
    beta= .5;
    beta2  = 2*beta^2;
    
    c= 10;
    c2 = 2*c^2;
    
 % Compute the output image
   Ifiltered = exp(-Rb/beta2) .*(ones(size(I))-exp(-S2/c2));
    
      
   
 % subplot(1,3,2)
 % imshow(uint8(I));

% Fusion of the filtered image and negative of original image using wavelets transform.   
negI = imcomplement(uint8(I));

%subplot (1,3,3)
 %imshow(negI);
 
%wavelet transform of negative image
load db9;
W=db9;
[Lo_D,Hi_D,Lo_R,Hi_R] = orthfilt(W);
%convolution (rows)
f_img_low = conv2(double(negI),Lo_D);
f_img_high= conv2(double(negI),Hi_D);
%downsampling
for i=1:m
    for j = 1:(m/2)
    low_dwnsample(i,j) = f_img_low(i,2*j);
    high_dwnsample(i,j) = f_img_high(i,2*j);
    end
end
Lo_D1 = Lo_D';
Hi_D1 = Hi_D';
%convolution(columns)
column_l_l = conv2(double(low_dwnsample),Lo_D1);
column_l_h = conv2(double(low_dwnsample),Hi_D1);
column_h_l = conv2(double(high_dwnsample),Lo_D1);
column_h_h = conv2(double(high_dwnsample),Hi_D1);
%downsampling
for i = 1:(m/2)
    for j = 1:(m/2)
        cA1(i,j)=column_l_l(2*i,j);
        cH1(i,j)=column_l_h(2*i,j);
        cV1(i,j)=column_h_l(2*i,j);
        cD1(i,j)=column_h_h(2*i,j);
    end
end

%wavelet transform of filtered image
%convolution(rows)
f_img_low = conv2(Ifiltered,Lo_D);
f_img_high= conv2(Ifiltered,Hi_D);
%downsampling
for i=1:m
    for j = 1:(m/2)
    low_dwnsample(i,j) = f_img_low(i,2*j);
    high_dwnsample(i,j) = f_img_high(i,2*j);
    end
end
Lo_D1 = Lo_D';
Hi_D1 = Hi_D';
%convolution(columns)
column_l_l = conv2(low_dwnsample,Lo_D1);
column_l_h = conv2(low_dwnsample,Hi_D1);
column_h_l = conv2(high_dwnsample,Lo_D1);
column_h_h = conv2(high_dwnsample,Hi_D1);
%downsampling
for i = 1:(m/2)
    for j = 1:(m/2)
        cA2(i,j)=column_l_l(2*i,j);
        cH2(i,j)=column_l_h(2*i,j);
        cV2(i,j)=column_h_l(2*i,j);
        cD2(i,j)=column_h_h(2*i,j);
    end
end
 
 %[cA1,cH1,cV1,cD1] = dwt2(negI,'db9');
 %[cA2,cH2,cV2,cD2] = dwt2(Ifiltered,'db9');
 
 %taking average of the wavelet coefficients for fusion, pixel based fusion
 %method.

 cA3= .5*(cA1 + cA2);
 cH3= .5*(cH1 + cH2);
 cV3= .5*(cV1 + cV2);
 cD3= .5*(cD1 + cD2);
 
 %inverse wavelet of fused image.
 
  Ifus1 = idwt2(cA3,cH3,cV3,cD3,'db9');
  

  
  % adjusting the filtered image pixels to true or false for detection of
  % vessels by comparing it with fused image mutiplied by suitable
  % threshold. 
  % for high threshold, prominent vessels are detected.
  % for low threshold, some false vessels are also deteced.
  % compute the final image for high threshold (gives directions) and 
  % use closing operation to complete the broken vessels.
 
  
 
for i= 1:184
    for j = 1:184
        if Ifiltered(i,j)> Ifus1(i,j)*.009
            Ifinal1(i,j) = 1;
        else Ifinal1(i,j)= 0;
        end
    end
end

for i= 1:184
    for j = 1:184
        if Ifiltered(i,j)> Ifus1(i,j)*.005
            Ifinal2(i,j) = 1;
        else Ifinal2(i,j)= 0;
            
        end
    end
end

%SE = strel('disk', 1);
%Ifinal3 = imclose(Ifinal1, SE);

SE = strel('disk', 2);
Ifinal3 = imclose(Ifinal1, SE);

SE = strel('disk', 1);
Ifinal4 = imopen(Ifinal2, SE);

Ifinal = Ifinal3 + Ifinal4;


subplot(2,3,1);
imshow(uint8(C));
xlabel('original image');
 
subplot (2,3,2)
imshow(Ifiltered);
xlabel('vesselness filtered image') 


subplot (2,3,3)
imshow(uint8(Ifus1));
xlabel('fused image');

subplot (2,3,4)
imshow(Ifinal1);
xlabel('high threshold image');

subplot (2,3,5)
imshow(Ifinal2);
xlabel('low threshold image');

subplot (2,3,6)
imshow(Ifinal);
xlabel('combined final image');


    
