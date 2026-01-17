function noisy_signal = add_noise(clean_signal, snr_db)
% ADD_NOISE - Adds white Gaussian noise to clean signal at specified SNR
%
% Inputs:
%   clean_signal - Clean speech signal (vector)
%   snr_db       - Desired Signal-to-Noise Ratio in dB
%
% Output:
%   noisy_signal - Signal with added noise

    % Preserve input shape
    input_was_row = false;
    if size(clean_signal, 1) == 1
        clean_signal = clean_signal(:);
        input_was_row = true;
    end

    % Calculate signal power
    signal_power = sum(clean_signal.^2) / length(clean_signal);
    
    % Calculate required noise power
    snr_linear = 10^(snr_db/10);
    noise_power = signal_power / snr_linear;
    
    % Generate white Gaussian noise
    noise = sqrt(noise_power) * randn(size(clean_signal));
    
    % Add noise to signal
    noisy_signal = clean_signal + noise;

    % Verify SNR
    actual_snr = 10 * log10(sum(clean_signal.^2) / sum(noise.^2));
    fprintf('   Actual SNR achieved: %.2f dB\n', actual_snr);

    % Convert back to row vector if input was row vector
    if input_was_row
        noisy_signal = noisy_signal';
    end
end
