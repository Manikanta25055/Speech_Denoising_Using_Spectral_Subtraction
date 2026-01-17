%% Real Audio File Processing Script
% Use this script to process your own audio files
% Place your audio file in the audio_samples/ folder

clear all;
close all;
clc;

addpath('functions');

fprintf('=== Real Audio File Processing ===\n\n');

%% Step 1: Select and Load Audio File
fprintf('Step 1: Loading Audio File\n');

% List available audio files
audio_folder = 'audio_samples/';
audio_files = dir([audio_folder, '*.wav']);

if isempty(audio_files)
    fprintf('No audio files found in audio_samples/ folder!\n');
    fprintf('Creating a sample audio file for demonstration...\n\n');
    
    % Create sample audio
    fs = 16000;
    duration = 3;
    t = 0:1/fs:(duration - 1/fs);
    sample_audio = generate_synthetic_speech(t, fs);
    
    % Save sample
    audiowrite([audio_folder, 'sample_speech.wav'], sample_audio, fs);
    fprintf('Sample audio created: audio_samples/sample_speech.wav\n');
    
    % Use the sample
    clean_speech = sample_audio;
    audio_filename = 'sample_speech.wav';
else
    fprintf('Available audio files:\n');
    for i = 1:length(audio_files)
        fprintf('  %d. %s\n', i, audio_files(i).name);
    end
    
    % Auto-select first file (you can change this)
    file_idx = 1;
    audio_filename = audio_files(file_idx).name;
    
    fprintf('\nUsing file: %s\n', audio_filename);
    
    % Load audio
    [clean_speech, fs] = audioread([audio_folder, audio_filename]);
    
    % Convert to mono if stereo
    if size(clean_speech, 2) > 1
        clean_speech = mean(clean_speech, 2);
        fprintf('  Converted stereo to mono\n');
    end
end

fprintf('  Sample rate: %d Hz\n', fs);
fprintf('  Duration: %.2f seconds\n', length(clean_speech)/fs);
fprintf('  Samples: %d\n\n', length(clean_speech));

%% Step 2: Configuration
fprintf('Step 2: Setting Configuration\n');

config.fs = fs;
config.snr_db = 10;             % Change this to test different noise levels
config.frame_length = 512;       % FFT size
config.overlap = 0.5;            % 50% overlap
config.alpha = 2.0;              % Over-subtraction factor
config.beta = 0.01;              % Spectral floor

fprintf('  SNR: %d dB\n', config.snr_db);
fprintf('  Frame Length: %d\n', config.frame_length);
fprintf('  Alpha: %.2f\n', config.alpha);
fprintf('  Beta: %.3f\n\n', config.beta);

%% Step 3: Add Noise
fprintf('Step 3: Adding Noise\n');
noisy_speech = add_noise(clean_speech, config.snr_db);
fprintf('  Noise added successfully\n\n');

%% Step 4: Apply Spectral Subtraction
fprintf('Step 4: Applying Spectral Subtraction\n');
fprintf('  Processing... ');
tic;
denoised_speech = spectral_subtraction(noisy_speech, config);
processing_time = toc;
fprintf('Done! (%.2f seconds)\n\n', processing_time);

%% Step 5: Calculate Metrics
fprintf('Step 5: Calculating Performance Metrics\n');
metrics = calculate_metrics(clean_speech, noisy_speech, denoised_speech, config.fs);

fprintf('\n--- Performance Results ---\n');
fprintf('Input SNR:           %.2f dB\n', metrics.input_snr);
fprintf('Output SNR:          %.2f dB\n', metrics.output_snr);
fprintf('SNR Improvement:     %.2f dB\n', metrics.snr_improvement);
fprintf('Seg-SNR Improvement: %.2f dB\n', metrics.seg_snr_improvement);
fprintf('Noise Reduction:     %.2f dB\n', metrics.noise_reduction_db);
fprintf('Correlation (Clean): %.4f\n', metrics.correlation_denoised);
fprintf('PESQ (Approx):       %.2f\n', metrics.pesq_approx);
fprintf('Spectral Distortion: %.2f dB\n', metrics.spectral_distortion);
fprintf('Processing Time:     %.2f seconds\n\n', processing_time);

%% Step 6: Save Results
fprintf('Step 6: Saving Results\n');

% Create output filename
[~, name, ~] = fileparts(audio_filename);
output_folder = 'results/';

% Save audio files
audiowrite([output_folder, name, '_clean.wav'], ...
           clean_speech/max(abs(clean_speech)), fs);
audiowrite([output_folder, name, '_noisy_', num2str(config.snr_db), 'dB.wav'], ...
           noisy_speech/max(abs(noisy_speech)), fs);
audiowrite([output_folder, name, '_denoised_', num2str(config.snr_db), 'dB.wav'], ...
           denoised_speech/max(abs(denoised_speech)), fs);

fprintf('  Saved: %s_clean.wav\n', name);
fprintf('  Saved: %s_noisy_%ddB.wav\n', name, config.snr_db);
fprintf('  Saved: %s_denoised_%ddB.wav\n\n', name, config.snr_db);

% Save metrics
save([output_folder, name, '_metrics.mat'], 'metrics', 'config', 'processing_time');
fprintf('  Saved: %s_metrics.mat\n\n', name);

%% Step 7: Generate Visualizations
fprintf('Step 7: Generating Visualizations\n');

% Create time vector
t = (0:length(clean_speech)-1) / fs;

% Figure 1: Waveform Comparison
figure('Position', [100, 100, 1400, 800]);

subplot(3,1,1);
plot(t, clean_speech, 'b', 'LineWidth', 1);
title(sprintf('Original Clean Speech - %s', audio_filename), ...
      'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'none');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
xlim([0 max(t)]);

subplot(3,1,2);
plot(t, noisy_speech, 'r', 'LineWidth', 1);
title(sprintf('Noisy Speech (SNR = %.2f dB)', metrics.input_snr), ...
      'FontSize', 12, 'FontWeight', 'bold');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
xlim([0 max(t)]);

subplot(3,1,3);
plot(t, denoised_speech, 'g', 'LineWidth', 1);
title(sprintf('Denoised Speech (SNR = %.2f dB, Improvement = %.2f dB)', ...
      metrics.output_snr, metrics.snr_improvement), ...
      'FontSize', 12, 'FontWeight', 'bold');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
xlim([0 max(t)]);

saveas(gcf, [output_folder, name, '_waveforms.png']);

% Figure 2: Spectrograms
figure('Position', [150, 150, 1400, 800]);

subplot(3,1,1);
spectrogram(clean_speech, hamming(256), 128, 512, fs, 'yaxis');
title('Clean Speech Spectrogram', 'FontSize', 12, 'FontWeight', 'bold');
colorbar;

subplot(3,1,2);
spectrogram(noisy_speech, hamming(256), 128, 512, fs, 'yaxis');
title('Noisy Speech Spectrogram', 'FontSize', 12, 'FontWeight', 'bold');
colorbar;

subplot(3,1,3);
spectrogram(denoised_speech, hamming(256), 128, 512, fs, 'yaxis');
title('Denoised Speech Spectrogram', 'FontSize', 12, 'FontWeight', 'bold');
colorbar;

saveas(gcf, [output_folder, name, '_spectrograms.png']);

% Figure 3: Performance Metrics
figure('Position', [200, 200, 1000, 600]);

subplot(2,2,1);
bar([metrics.input_snr, metrics.output_snr, metrics.snr_improvement]);
set(gca, 'XTickLabel', {'Input SNR', 'Output SNR', 'Improvement'});
ylabel('dB');
title('SNR Analysis', 'FontWeight', 'bold');
grid on;

subplot(2,2,2);
bar([metrics.correlation_noisy, metrics.correlation_denoised]);
set(gca, 'XTickLabel', {'Noisy', 'Denoised'});
ylabel('Correlation');
ylim([0 1]);
title('Correlation with Clean Signal', 'FontWeight', 'bold');
grid on;

subplot(2,2,3);
bar([metrics.seg_snr_input, metrics.seg_snr_output]);
set(gca, 'XTickLabel', {'Input', 'Output'});
ylabel('Segmental SNR (dB)');
title('Segmental SNR', 'FontWeight', 'bold');
grid on;

subplot(2,2,4);
metrics_data = [metrics.input_snr; metrics.output_snr; ...
                metrics.seg_snr_input; metrics.seg_snr_output];
bar(metrics_data);
set(gca, 'XTickLabel', {'Input SNR', 'Output SNR', 'Seg-SNR In', 'Seg-SNR Out'});
ylabel('dB');
title('All SNR Metrics', 'FontWeight', 'bold');
grid on;

sgtitle(sprintf('Performance Analysis - %s', name), ...
        'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'none');
saveas(gcf, [output_folder, name, '_metrics.png']);

fprintf('  All figures saved to results/ folder\n\n');

%% Step 8: Audio Playback (Optional)
fprintf('Step 8: Audio Playback\n');
fprintf('  To play audio, uncomment the lines below in the script:\n');
fprintf('  - Clean speech\n');
fprintf('  - Noisy speech\n');
fprintf('  - Denoised speech\n\n');

% Uncomment to play audio:
% fprintf('Playing clean speech...\n');
% sound(clean_speech, fs);
% pause(length(clean_speech)/fs + 1);
% 
% fprintf('Playing noisy speech...\n');
% sound(noisy_speech, fs);
% pause(length(noisy_speech)/fs + 1);
% 
% fprintf('Playing denoised speech...\n');
% sound(denoised_speech, fs);

fprintf('=== Processing Complete! ===\n');
fprintf('\nOutput files location: results/\n');
fprintf('  - Audio files: %s_clean.wav, %s_noisy_%ddB.wav, %s_denoised_%ddB.wav\n', ...
        name, name, config.snr_db, name, config.snr_db);
fprintf('  - Metrics: %s_metrics.mat\n', name);
fprintf('  - Figures: %s_waveforms.png, %s_spectrograms.png, %s_metrics.png\n', ...
        name, name, name);
