function [ autotuned_song ] = playSong( chunks )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    sample_rate = 100e3;
%     notes = table2cell(readtable('scales.csv'))
    %songfreq = [523.25, 493.88, 392, 440, 493.88, 523.25, 261.63, 440, 392];
    fileID = fopen('scales.csv');
    notesIn = textscan(fileID,'%s %s',...
        'Delimiter',',','EmptyValue',-Inf);
    fclose(fileID);
    notes = [notesIn{1},notesIn{2}]
    fileID = fopen('song.csv');
    songIn = textscan(fileID,'%s',...
        'Delimiter',',','EmptyValue',-Inf);
    fclose(fileID);
    song = songIn{1}
    %[song] = CSVIMPORT('song.csv'),'columns',[1]); %table2cell(readtable('song.csv'))
    songfreq = cellfun(@(y) notes{cellfun(@(x) strcmp(x,y),notes(:,1)),2},song)
    chunks{1,1} = [];
    chunks = chunks(cellfun(@(x) ~isempty(x),chunks))
    while length(chunks) < songfreq
        chunks = [chunks;chunks];
    end
    autotuned_song = [];
    for i = 1:length(songfreq)-1
        i;
        tuned_chunk = frequency_shift(chunks{i},songfreq(i));
        autotuned_song = [autotuned_song, tuned_chunk];
        %sound(autotuned_song, sample_rate)
    end
%     for i = 1:length(song)
%          tuned_chunk = frequency_shift(chunk,songfreq(i));
%         autotuned_song = [autotuned_song, tuned_chunk];
%     end

    sample_rate = 100e3;
    sound(autotuned_song, sample_rate);

end

