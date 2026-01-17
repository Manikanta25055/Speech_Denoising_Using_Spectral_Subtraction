function metrics = calculate_metrics(clean_signal, noisy_signal, denoised_signal, fs)
% CALCULATE_METRICS - Calculate performance metrics for speech denoising
%
% Inputs:
%   clean_signal    - Original clean speech signal
%   noisy_signal    - Noisy speech signal
%   denoised_signal - Denoised speech signal
%   fs              - Sampling frequency
%
% Output:
%   metrics - Structure containing performance metrics

    % Ensure all signals are column vectors
    clean_signal = clean_signal(:);
    noisy_signal = noisy_signal(:);
    denoised_signal = denoised_signal(:);

    % Ensure all signals have same length
    min_length = min([length(clean_signal), length(noisy_signal), length(denoised_signal)]);
    clean_signal = clean_signal(1:min_length);
    noisy_signal = noisy_signal(1:min_length);
    denoised_signal = denoised_signal(1:min_length);
    
    %% 1. Signal-to-Noise Ratio (SNR)
    % Input SNR
    noise_input = noisy_signal - clean_signal;
    metrics.input_snr = 10 * log10(sum(clean_signal.^2) / sum(noise_input.^2));
    
    % Output SNR
    noise_output = denoised_signal - clean_signal;
    metrics.output_snr = 10 * log10(sum(clean_signal.^2) / sum(noise_output.^2));
    
    % SNR Improvement
    metrics.snr_improvement = metrics.output_snr - metrics.input_snr;
    
    %% 2. Mean Squared Error (MSE)
    metrics.mse_noisy = mean((clean_signal - noisy_signal).^2);
    metrics.mse_denoised = mean((clean_signal - denoised_signal).^2);
    
    %% 3. Normalized Mean Squared Error (NMSE)
    metrics.nmse_noisy = sum((clean_signal - noisy_signal).^2) / sum(clean_signal.^2);
    metrics.nmse_denoised = sum((clean_signal - denoised_signal).^2) / sum(clean_signal.^2);
    
    %% 4. Segmental SNR
    frame_length = 256;
    frame_shift = 128;
    num_frames = floor((min_length - frame_length) / frame_shift) + 1;
    
    seg_snr_input = zeros(num_frames, 1);
    seg_snr_output = zeros(num_frames, 1);
    
    for i = 1:num_frames
        start_idx = (i-1) * frame_shift + 1;
        end_idx = start_idx + frame_length - 1;
        
        if end_idx <= min_length
            clean_frame = clean_signal(start_idx:end_idx);
            noisy_frame = noisy_signal(start_idx:end_idx);
            denoised_frame = denoised_signal(start_idx:end_idx);
            
            % Calculate segmental SNR
            noise_in = noisy_frame - clean_frame;
            noise_out = denoised_frame - clean_frame;
            
            % Add small epsilon to avoid log(0)
            epsilon = 1e-10;
            seg_snr_input(i) = 10 * log10((sum(clean_frame.^2) + epsilon) / ...
                                          (sum(noise_in.^2) + epsilon));
            seg_snr_output(i) = 10 * log10((sum(clean_frame.^2) + epsilon) / ...
                                           (sum(noise_out.^2) + epsilon));
        end
    end
    
    % Average segmental SNR (limit to reasonable range)
    seg_snr_input = max(min(seg_snr_input, 35), -10);
    seg_snr_output = max(min(seg_snr_output, 35), -10);
    
    metrics.seg_snr_input = mean(seg_snr_input);
    metrics.seg_snr_output = mean(seg_snr_output);
    metrics.seg_snr_improvement = metrics.seg_snr_output - metrics.seg_snr_input;
    
    %% 5. Spectral Distortion
    % Calculate spectral distance between clean and denoised signals
    fft_clean = abs(fft(clean_signal));
    fft_denoised = abs(fft(denoised_signal));
    
    % Log spectral distance
    epsilon = 1e-10;
    metrics.spectral_distortion = sqrt(mean((10*log10(fft_clean + epsilon) - ...
                                             10*log10(fft_denoised + epsilon)).^2));
    
    %% 6. Correlation Coefficient
    metrics.correlation_noisy = corr(clean_signal, noisy_signal);
    metrics.correlation_denoised = corr(clean_signal, denoised_signal);
    
    %% 7. Approximate PESQ (Perceptual Evaluation of Speech Quality)
    % This is a simplified approximation (real PESQ requires ITU-T P.862)
    % PESQ typically ranges from -0.5 to 4.5
    % We approximate based on SNR and correlation
    pesq_base = 1.0;
    snr_factor = min(metrics.output_snr / 30, 1) * 2.5;  % Scale SNR contribution
    corr_factor = metrics.correlation_denoised * 1.0;     % Scale correlation contribution
    
    metrics.pesq_approx = pesq_base + snr_factor + corr_factor;
    metrics.pesq_approx = max(min(metrics.pesq_approx, 4.5), -0.5);  % Clip to valid range
    
    %% 8. Noise Reduction Factor
    metrics.noise_reduction_db = 10 * log10(sum(noise_input.^2) / sum(noise_output.^2));
end
