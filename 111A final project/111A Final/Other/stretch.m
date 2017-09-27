function [ result ] = stretch( sound_array, f, window_size, h )
%stretch sound_array by a factor f using the phase vocoder method
    %divides sound array into (overlapping) windows (subarrays) and
    %readjusts the overlap to stretch/shrink the array length without
    %changing frequency content
    
    phase  = zeros(1,window_size);
    hanning_window = hanning(window_size);
    result = zeros(1, round( length(sound_array) /f ) + window_size);

    for i = 1: round(h*f) : ( length(sound_array)-(window_size+h) )

        %two potentially overlapping subarrays
        a1 = sound_array(i: i + window_size - 1);
        a2 = sound_array(i + h: i + window_size + h - 1);

        %resynchronize the second array on the first
        s1 =  fft(hanning_window' .* a1);
        s2 =  fft(hanning_window' .* a2);
        phase = (phase + angle(s2./s1)); % 2*np.pi
        a2_rephased = ifft(abs(s2) .* exp(1i*phase));

        %add to result
        i2 = int64(i/f);
        if i2 < 1
            i2 = 1;
        end
        result( i2 : (i2 + window_size - 1) ) = hanning_window' .* a2_rephased + result(i2 : (i2 + window_size - 1));
        
    end
    
    result = result(1:i2 + window_size - 1);
    result = [real(result)];
end

