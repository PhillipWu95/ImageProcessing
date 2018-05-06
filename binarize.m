function I = binarize( I )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
s=size(I);
for m=1:s(1)
    for n=1:s(2)
        if I(m,n)>=128;
            I(m,n)=255;
        else I(m,n)=0;
        end
    end
end

end

