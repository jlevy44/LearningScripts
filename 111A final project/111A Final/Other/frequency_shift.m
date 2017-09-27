function [ shifted_sound_array ] = frequency_shift( sound_array, f_final )
%changes frequency of sound_array without altering the tempo
    %takes sound_array and returns a shifted sound array of
    %fundamental frequency f_final
    
    sample_rate = 1e5; %default from labview program
    f_0 = find_fundamental(sound_array, sample_rate);
    
    %empirically found values to work well in stretch.m for our signals
    window_size = 2^13;
    h = 2^10;
    
    stretched_sound = stretch(sound_array', f_0 / f_final, window_size, h);
    shifted_sound_array = resample(stretched_sound, ...
        round(length(sound_array) / length(stretched_sound) * 1000), ...
        1000);
    
end

