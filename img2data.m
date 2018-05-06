close all; clear;
% Pick out the image data(labeled by 1, 6 and 8), and save them in the form of X(data) and Y(labels). 

minest_dir='C:\Users\sqc\Desktop\MNIST_Database\test_image\';% Please repalce the training path, when extract the training data.
file=dir([minest_dir '*.bmp']);
load('C:\Users\sqc\Desktop\MNIST_Database\test_labels.mat','labels')

l=length(labels);

count=0;
for i=1:l
	if labels(i)==1||labels(i)==6||labels(i)==8
	   count=count+1;
	   Y(count,1)=labels(i);
		filename=['TestImage_' num2str(i) '.bmp'];
	    temp=imread([minest_dir filename]);
		X(count,:)=temp(:)';
	end
	i
end

save('testdata.mat','Y','X')