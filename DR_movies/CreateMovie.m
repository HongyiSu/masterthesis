%This script is used to visualize the paraview screenshots of SeisSol output
close all;
clear all;
clc;

list = dir('700km_r6/model-r6.*');
list={list.name}';
%%

movieid=VideoWriter('model_r6');
movieid.FrameRate=2;
movieid.Quality=100;
open(movieid)

for ilist=1:length(list)
    A = imread(['700km_r6/',list{ilist}]);
    writeVideo(movieid,A);
end

close(movieid)




