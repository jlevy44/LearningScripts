function [autotuned_song] = twinkle(chunk)

    sample_rate = 100e3;
    %song = [523.25, 493.88, 392, 440, 493.88, 523.25, 261.63, 440, 392];
    song = [261.63 261.63 392 392 440 440 392];
    autotuned_song = [];
%     for i = 2:length(chunks)-2
%         i
%         tuned_chunk = frequency_shift(chunks{i},song(i-1));
%         autotuned_song = [autotuned_song, tuned_chunk];
%         %sound(autotuned_song, sample_rate)
%     end
    for i = 1:length(song)
        tuned_chunk = frequency_shift(chunk,song(i));
        autotuned_song = [autotuned_song, tuned_chunk];
    end

    sample_rate = 100e3;
    sound(autotuned_song, sample_rate)

end