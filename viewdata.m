close all; clear;
%% To view the image data by randomly choose 100 of them. 

load('testdata.mat','Y','X') %You could change it as load('traindata.mat','Y','X') to view the training data.
m = size(X, 1);
rand_indices = randperm(m);
sel = X(rand_indices(1:100), :);

displayData(sel);