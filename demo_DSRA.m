%% Demo code for the TMM paper
% Person Re-identification via Ranking Aggregation of Similarity Pulling and Dissimilarity Pushing, 
% Mang Ye, Chao Liang, Yi Yu, Zheng Wang, Qingming Leng, Chunxia Xiao, Jun Chen, Ruimin Hu. 
% Contact:
% yemang@whu.edu.cn

% This is an illustration of our performance, while the theory is simple
% but results are impressive.

clear all;
close all;
clc; warning off;

%% init
dataset  = 'viper'; %'viper','cuhk'
trial    = 1;  % The number of trial to achieve stable statistics (trial<=10)
num_knn  = 80;  % The number of top k results
num_dis  = 120; % The number of end k results
alpha    = 0.8; % combine weight
beta     = 0.08;% penalize factor 
method   = '1 2'; % "1" kissme, "2"sdc, "3"sdalf, "4"ldfv
%[1 2] for cuhk, and [1 2] and [3 4] for viper

%viper 3 4  knn= 40, num_dis =60
% Input orginal rank
input_rank;

% Similarity and Dissimilarity Ranking Aggregation 
DSRA;
   
% Plot the result
Plot_result;
