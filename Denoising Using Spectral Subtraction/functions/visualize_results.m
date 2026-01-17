function visualize_results(clean_signal, noisy_signal, denoised_signal, config, metrics)
% VISUALIZE_RESULTS - Generate comprehensive visualizations
%
% Inputs:
%   clean_signal    - Original clean speech signal
%   noisy_signal    - Noisy speech signal
%   denoised_signal - Denoised speech signal
%   config          - Configuration structure
%   metrics         - Performance metrics structure

    % Ensure all signals are column vectors
    clean_signal = clean_signal(:);
    noisy_signal = noisy_signal(:);
    denoised_signal = denoised_signal(:);

    % Create time vector
    t = (0:length(clean_signal)-1) / config.fs;
    
    %% Figure 1: Time Domain Comparison
    figure('Position', [100, 100, 1200, 800]);
    
    subplot(3,1,1);
    plot(t, clean_signal, 'b', 'LineWidth', 1);
    title('Clean Speech Signal', 'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
    xlim([0 max(t)]);
    
    subplot(3,1,2);
    plot(t, noisy_signal, 'r', 'LineWidth', 1);
    title(sprintf('Noisy Speech Signal (SNR = %.2f dB)', metrics.input_snr), ...
          'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
    xlim([0 max(t)]);
    
    subplot(3,1,3);
    plot(t, denoised_signal, 'g', 'LineWidth', 1);
    title(sprintf('Denoised Speech Signal (SNR = %.2f dB)', metrics.output_snr), ...
          'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
    xlim([0 max(t)]);
    
    sgtitle('Time Domain Analysis', 'FontSize', 14, 'FontWeight', 'bold');
    saveas(gcf, 'figures/time_domain_comparison.png');
    
    %% Figure 2: Frequency Domain Analysis (FFT)
    figure('Position', [150, 150, 1200, 800]);
    
    % Calculate FFT
    N = length(clean_signal);
    f = (0:N-1) * (config.fs/N);
    f = f(1:floor(N/2));  % Only positive frequencies
    
    fft_clean = abs(fft(clean_signal));
    fft_clean = fft_clean(1:floor(N/2));
    
    fft_noisy = abs(fft(noisy_signal));
    fft_noisy = fft_noisy(1:floor(N/2));
    
    fft_denoised = abs(fft(denoised_signal));
    fft_denoised = fft_denoised(1:floor(N/2));
    
    subplot(3,1,1);
    plot(f, 20*log10(fft_clean + eps), 'b', 'LineWidth', 1);
    title('Clean Speech - Frequency Spectrum', 'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    grid on;
    xlim([0 config.fs/2]);
    
    subplot(3,1,2);
    plot(f, 20*log10(fft_noisy + eps), 'r', 'LineWidth', 1);
    title('Noisy Speech - Frequency Spectrum', 'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    grid on;
    xlim([0 config.fs/2]);
    
    subplot(3,1,3);
    plot(f, 20*log10(fft_denoised + eps), 'g', 'LineWidth', 1);
    title('Denoised Speech - Frequency Spectrum', 'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    grid on;
    xlim([0 config.fs/2]);
    
    sgtitle('Frequency Domain Analysis (FFT)', 'FontSize', 14, 'FontWeight', 'bold');
    saveas(gcf, 'figures/frequency_domain_comparison.png');
    
    %% Figure 3: Spectrogram Comparison
    figure('Position', [200, 200, 1200, 800]);
    
    window_length = 256;
    noverlap = 128;
    nfft = 512;
    
    subplot(3,1,1);
    spectrogram(clean_signal, hamming(window_length), noverlap, nfft, config.fs, 'yaxis');
    title('Clean Speech - Spectrogram', 'FontSize', 12, 'FontWeight', 'bold');
    colorbar;
    
    subplot(3,1,2);
    spectrogram(noisy_signal, hamming(window_length), noverlap, nfft, config.fs, 'yaxis');
    title('Noisy Speech - Spectrogram', 'FontSize', 12, 'FontWeight', 'bold');
    colorbar;
    
    subplot(3,1,3);
    spectrogram(denoised_signal, hamming(window_length), noverlap, nfft, config.fs, 'yaxis');
    title('Denoised Speech - Spectrogram', 'FontSize', 12, 'FontWeight', 'bold');
    colorbar;
    
    sgtitle('Spectrogram Analysis', 'FontSize', 14, 'FontWeight', 'bold');
    saveas(gcf, 'figures/spectrogram_comparison.png');
    
    %% Figure 4: Performance Metrics
    figure('Position', [250, 250, 1000, 600]);
    
    % SNR Comparison
    subplot(2,2,1);
    bar([metrics.input_snr, metrics.output_snr]);
    set(gca, 'XTickLabel', {'Input SNR', 'Output SNR'});
    ylabel('SNR (dB)');
    title('SNR Comparison', 'FontSize', 12, 'FontWeight', 'bold');
    grid on;
    text(1, metrics.input_snr + 2, sprintf('%.2f dB', metrics.input_snr), ...
         'HorizontalAlignment', 'center');
    text(2, metrics.output_snr + 2, sprintf('%.2f dB', metrics.output_snr), ...
         'HorizontalAlignment', 'center');
    
    % MSE Comparison
    subplot(2,2,2);
    bar([metrics.mse_noisy, metrics.mse_denoised]);
    set(gca, 'XTickLabel', {'Noisy', 'Denoised'});
    ylabel('MSE');
    title('Mean Squared Error', 'FontSize', 12, 'FontWeight', 'bold');
    grid on;
    
    % Correlation Comparison
    subplot(2,2,3);
    bar([metrics.correlation_noisy, metrics.correlation_denoised]);
    set(gca, 'XTickLabel', {'Noisy', 'Denoised'});
    ylabel('Correlation');
    ylim([0 1]);
    title('Correlation with Clean Signal', 'FontSize', 12, 'FontWeight', 'bold');
    grid on;
    
    % Improvement Metrics
    subplot(2,2,4);
    improvement_data = [metrics.snr_improvement; metrics.seg_snr_improvement; ...
                       metrics.noise_reduction_db];
    bar(improvement_data);
    set(gca, 'XTickLabel', {'SNR Impr.', 'Seg-SNR Impr.', 'Noise Red.'});
    ylabel('Improvement (dB)');
    title('Performance Improvements', 'FontSize', 12, 'FontWeight', 'bold');
    grid on;
    
    sgtitle('Performance Metrics Analysis', 'FontSize', 14, 'FontWeight', 'bold');
    saveas(gcf, 'figures/performance_metrics.png');
    
    %% Figure 5: Error Analysis
    figure('Position', [300, 300, 1200, 600]);
    
    error_noisy = clean_signal - noisy_signal;
    error_denoised = clean_signal - denoised_signal;
    
    subplot(2,1,1);
    plot(t, error_noisy, 'r', 'LineWidth', 1);
    title('Error in Noisy Signal', 'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Time (s)');
    ylabel('Error Amplitude');
    grid on;
    xlim([0 max(t)]);
    
    subplot(2,1,2);
    plot(t, error_denoised, 'g', 'LineWidth', 1);
    title('Error in Denoised Signal', 'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Time (s)');
    ylabel('Error Amplitude');
    grid on;
    xlim([0 max(t)]);
    
    sgtitle('Error Analysis', 'FontSize', 14, 'FontWeight', 'bold');
    saveas(gcf, 'figures/error_analysis.png');
    
    %% Figure 6: Detailed Comparison (Zoomed)
    figure('Position', [350, 350, 1200, 600]);
    
    % Zoom into first 0.5 seconds
    zoom_time = 0.5;
    zoom_samples = round(zoom_time * config.fs);
    t_zoom = t(1:zoom_samples);
    
    subplot(3,1,1);
    plot(t_zoom, clean_signal(1:zoom_samples), 'b', 'LineWidth', 1.5);
    title('Clean Speech (Zoomed)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Amplitude');
    grid on;
    
    subplot(3,1,2);
    plot(t_zoom, noisy_signal(1:zoom_samples), 'r', 'LineWidth', 1.5);
    title('Noisy Speech (Zoomed)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Amplitude');
    grid on;
    
    subplot(3,1,3);
    plot(t_zoom, denoised_signal(1:zoom_samples), 'g', 'LineWidth', 1.5);
    title('Denoised Speech (Zoomed)', 'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
    
    sgtitle('Detailed Time Domain Comparison (First 0.5s)', 'FontSize', 14, 'FontWeight', 'bold');
    saveas(gcf, 'figures/zoomed_comparison.png');
    
    fprintf('   All figures generated successfully!\n');
end
