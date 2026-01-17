function denoised_signal = spectral_subtraction(noisy_signal, config)
% SPECTRAL_SUBTRACTION - Performs spectral subtraction for noise reduction
%
% Inputs:
%   noisy_signal - Noisy speech signal (vector)
%   config       - Configuration structure with parameters
%
% Output:
%   denoised_signal - Denoised speech signal (vector)
%
% Algorithm:
%   1. Divide signal into overlapping frames
%   2. Apply window function
%   3. Compute FFT of each frame
%   4. Estimate noise spectrum from initial frames
%   5. Subtract noise spectrum from noisy spectrum
%   6. Apply spectral floor to avoid negative values
%   7. Reconstruct time-domain signal using IFFT and overlap-add

    % Extract parameters
    frame_length = config.frame_length;
    overlap = config.overlap;
    alpha = config.alpha;           % Over-subtraction factor
    beta = config.beta;             % Spectral floor parameter

    % Ensure noisy_signal is a column vector
    input_was_row = false;
    if size(noisy_signal, 1) == 1
        noisy_signal = noisy_signal(:);
        input_was_row = true;
    end

    % Calculate frame parameters
    frame_shift = round(frame_length * (1 - overlap));
    num_frames = floor((length(noisy_signal) - frame_length) / frame_shift) + 1;

    % Create window function (Hamming window)
    window = hamming(frame_length);

    % Initialize output signal
    denoised_signal = zeros(size(noisy_signal));
    window_sum = zeros(size(noisy_signal));
    
    % Estimate noise spectrum from first few frames (assuming first 0.3s is noise)
    noise_frames = min(10, num_frames);
    noise_spectrum = zeros(frame_length, 1);
    
    for i = 1:noise_frames
        start_idx = (i-1) * frame_shift + 1;
        end_idx = start_idx + frame_length - 1;
        
        if end_idx <= length(noisy_signal)
            frame = noisy_signal(start_idx:end_idx) .* window;
            frame_fft = fft(frame, frame_length);
            noise_spectrum = noise_spectrum + abs(frame_fft).^2;
        end
    end
    
    % Average noise spectrum
    noise_spectrum = sqrt(noise_spectrum / noise_frames);
    
    % Process each frame
    for i = 1:num_frames
        start_idx = (i-1) * frame_shift + 1;
        end_idx = start_idx + frame_length - 1;
        
        if end_idx <= length(noisy_signal)
            % Extract and window the frame
            frame = noisy_signal(start_idx:end_idx) .* window;
            
            % Compute FFT
            frame_fft = fft(frame, frame_length);
            magnitude = abs(frame_fft);
            phase = angle(frame_fft);
            
            % Spectral Subtraction
            % Subtract noise spectrum with over-subtraction factor
            clean_magnitude = magnitude - alpha * noise_spectrum;
            
            % Apply spectral floor (prevent negative values)
            spectral_floor = beta * magnitude;
            clean_magnitude = max(clean_magnitude, spectral_floor);
            
            % Reconstruct complex spectrum
            clean_fft = clean_magnitude .* exp(1j * phase);
            
            % Inverse FFT
            clean_frame = real(ifft(clean_fft, frame_length));
            
            % Overlap-add
            denoised_signal(start_idx:end_idx) = denoised_signal(start_idx:end_idx) + clean_frame;
            window_sum(start_idx:end_idx) = window_sum(start_idx:end_idx) + window;
        end
    end
    
    % Normalize by window sum
    window_sum(window_sum < 1e-10) = 1;  % Avoid division by zero
    denoised_signal = denoised_signal ./ window_sum;

    % Ensure same length as input
    denoised_signal = denoised_signal(1:length(noisy_signal));

    % Convert back to row vector if input was row vector
    if input_was_row
        denoised_signal = denoised_signal';
    end
end
