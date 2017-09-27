function [peak_frequency] = find_fundamental(sound_array, sample_rate)

    fft_sound = fft(sound_array);
    df = sample_rate / length(sound_array);
    [~, idx] = max(fft_sound(1:round(end/2)));
    peak_frequency = df * idx;

end