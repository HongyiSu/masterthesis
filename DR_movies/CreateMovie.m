%This script is used to visualize the paraview screenshots of SeisSol output
close all;
clear all;
clc;

list = dir('case_6a1/case_6a1.*.png');
list={list.name}';
%%



movieid=VideoWriter('case_6a1_front');
movieid.FrameRate=2;
movieid.Quality=100;
open(movieid)

for ilist=1:length(list)
    A = imread(['case_6a1/',list{ilist}]);
    writeVideo(movieid,A);
end

close(movieid)




