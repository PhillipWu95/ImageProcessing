function optimum = Otsu ( I )
% function as to calculate the optimum threshold for Otsu's method
% input a matrix of graylevel image ranging from 0 to 255
% output the optimum threshold as an integer
[I_m,I_n]=size(I);
s=I_m*I_n;
N=zeros(256,1);
T=zeros(256,1);
for k=0:255
    [num,num2]=size(find(I==k));  % find whatever element in I that equals K; store in num
    N(k+1,1)=num;                 % arrange the element quantity of each graylevel ascendingly
end
for t=1:256
    a0=0;  a1=0; b0=0; b1=0;
    for m=1:t
        a0=a0+N(m,1);
        b0=b0+(m-1)*N(m,1);
    end
    for m=t+1:256
        a1=a1+N(m,1);
        b1=b1+(m-1)*N(m,1);
    end
    w0=a0/s; w1=a1/s;
    u0=b0/a0; u1=b1/a1;
    T(t,1)=w0*w1*(u0-u1)*(u0-u1); % only sigma B is needed since sigma T is irrelevant to t
end
optimum=find(T==max(max(T)))-1;   

end

