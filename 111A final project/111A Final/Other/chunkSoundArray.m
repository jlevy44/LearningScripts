function [soundArrayChunks] = chunkSoundArray( sound_array)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


     %sound_array = arrayfun(@str2num, table2Array(readtable(inputFile)));
%      [peaks,loc] = findpeaks(sound_array);
     
%      readSeg = 0;
%      finalIntervals = [];
%      for i=1:length(peaks)
%          if peaks(i) > threshold && readSeg == 0
%              readSeg = 1;
%              finalIntervals(end+1) = loc(i);
%          end
%          if peaks(i) < threshold && readSeg == 1
%              readSeg = 0;
%          end
%      end
%      finalIntervals(end+1) = length(sound_array);
%      
%      finalIntervals(1) = 1;
%      
%      idx = finalIntervals;
    a=0;
    chunkIndices = [1];
    plot(sound_array);
    while(a==0)
       chunkpoint = ginput(1);
       chunkIndex = chunkpoint(1);
       chunkIndices = [chunkIndices, round(chunkIndex)]; %#ok<AGROW>
       if chunkpoint(1) < chunkIndices(end-1)
           a = 1;
           chunkIndices = chunkIndices(1:end-1);
       end
    end
    chunkIndices(end+1) = length(sound_array);
    
    soundArrayChunks = cell(length(chunkIndices));
    
    for i=1:length(chunkIndices) - 1
        soundArrayChunks{i} = sound_array(chunkIndices(i):chunkIndices(i+1));
    end
    
    
end

