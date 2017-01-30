function [T] = threshold( yij )
%UNTITLED2 Summary of this function goes here
[M,N] = size(yij);
sum = 0;
for m = 1:M                              % i= detail components(High frequency components)
    for n = 1:N                          % j=decomposition level
            sum = sum + (yij(m,n)- mean2(yij)).^2;
            
     end
end
T = (1/2)*(sqrt((1/(M*N))*sum));


end

