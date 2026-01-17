function speech_signal = generate_synthetic_speech(t, fs)
% GENERATE_SYNTHETIC_SPEECH - Generates synthetic speech-like signal
%
% Inputs:
%   t  - Time vector
%   fs - Sampling frequency
%
% Output:
%   speech_signal - Synthetic speech signal (column vector)
%
% This function creates a speech-like signal by combining multiple
% frequency components and applying amplitude modulation to simulate
% speech characteristics

    % Ensure t is a row vector for computations
    t = t(:)';

    % Speech typically has formant frequencies
    % Create multiple formants (resonant frequencies)
    
    % First formant (F1) - around 500-700 Hz
    f1 = 600 + 50*sin(2*pi*2*t);
    formant1 = sin(2*pi*f1.*t);
    
    % Second formant (F2) - around 1000-1500 Hz
    f2 = 1200 + 100*sin(2*pi*1.5*t);
    formant2 = 0.8*sin(2*pi*f2.*t);
    
    % Third formant (F3) - around 2000-3000 Hz
    f3 = 2500 + 150*sin(2*pi*1*t);
    formant3 = 0.6*sin(2*pi*f3.*t);
    
    % Fourth formant (F4) - around 3000-4000 Hz
    f4 = 3500 + 100*sin(2*pi*0.8*t);
    formant4 = 0.4*sin(2*pi*f4.*t);
    
    % Combine formants
    speech_signal = formant1 + formant2 + formant3 + formant4;
    
    % Add amplitude modulation to simulate speech envelope
    % Speech has pauses and varying amplitude
    envelope = abs(sin(2*pi*3*t)) + 0.5*abs(sin(2*pi*5*t));
    envelope = envelope / max(envelope);
    
    % Create silence periods (simulate pauses in speech)
    num_segments = 5;
    segment_length = floor(length(t) / num_segments);
    for i = 1:num_segments
        if mod(i, 2) == 0  % Every second segment has reduced amplitude
            start_idx = (i-1)*segment_length + 1;
            end_idx = min(i*segment_length, length(envelope));
            envelope(start_idx:end_idx) = envelope(start_idx:end_idx) * 0.2;
        end
    end
    
    % Apply envelope
    speech_signal = speech_signal .* envelope;
    
    % Normalize
    speech_signal = speech_signal / max(abs(speech_signal)) * 0.9;

    % Add slight random variation to make it more realistic
    speech_signal = speech_signal + 0.01*randn(size(speech_signal));

    % Convert to column vector for consistency with other functions
    speech_signal = speech_signal(:);
end
