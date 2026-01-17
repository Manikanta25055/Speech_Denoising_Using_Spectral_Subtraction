%% Speech Denoising using Spectral Subtraction with FFT
% Project: FISAC Assessment - Digital Signal Processing
% Topic: Applications of N-point FFT
% Group Number: 6
% Date: October 2025
%
% This script demonstrates speech denoising using spectral subtraction
% method in the frequency domain using FFT.

clear all;
close all;
clc;

%% Add function path
addpath('functions');

%% Configuration Parameters
config.fs = 16000;              % Sampling frequency (Hz)
config.duration = 3;            % Duration of signal (seconds)
config.snr_db = 10;            % Signal-to-Noise Ratio (dB)
config.frame_length = 512;      % FFT frame length (N-point FFT)
config.overlap = 0.5;           % Frame overlap (50%)
config.alpha = 2.0;             % Over-subtraction factor
config.beta = 0.01;             % Spectral floor parameter

%% Step 1: Load or Generate Clean Speech Signal
fprintf('Step 1: Loading/Generating Speech Signal...\n');

% Option A: Load from file (if you have audio file)
% [clean_speech, fs] = audioread('audio_samples/clean_speech.wav');
% config.fs = fs;

% Option B: Generate synthetic speech signal (for demonstration)
t = 0:1/config.fs:(config.duration - 1/config.fs);
clean_speech = generate_synthetic_speech(t, config.fs);

fprintf('   Clean speech signal generated: %.2f seconds, fs = %d Hz\n', ...
        config.duration, config.fs);

%% Step 2: Add Noise to Clean Speech
fprintf('\nStep 2: Adding Noise...\n');
noisy_speech = add_noise(clean_speech, config.snr_db);
fprintf('   Noise added with SNR = %d dB\n', config.snr_db);

%% Step 3: Apply Spectral Subtraction
fprintf('\nStep 3: Applying Spectral Subtraction...\n');
denoised_speech = spectral_subtraction(noisy_speech, config);
fprintf('   Spectral subtraction completed\n');

%% Step 4: Calculate Performance Metrics
fprintf('\nStep 4: Calculating Performance Metrics...\n');
metrics = calculate_metrics(clean_speech, noisy_speech, denoised_speech, config.fs);

fprintf('\n--- Performance Metrics ---\n');
fprintf('Input SNR:       %.2f dB\n', metrics.input_snr);
fprintf('Output SNR:      %.2f dB\n', metrics.output_snr);
fprintf('SNR Improvement: %.2f dB\n', metrics.snr_improvement);
fprintf('PESQ Score:      %.2f\n', metrics.pesq_approx);

%% Step 5: Visualizations
fprintf('\nStep 5: Generating Visualizations...\n');
visualize_results(clean_speech, noisy_speech, denoised_speech, config, metrics);
fprintf('   Figures saved to figures/ folder\n');

%% Step 6: Save Results
fprintf('\nStep 6: Saving Results...\n');

% Save audio files
audiowrite('results/clean_speech.wav', clean_speech/max(abs(clean_speech)), config.fs);
audiowrite('results/noisy_speech.wav', noisy_speech/max(abs(noisy_speech)), config.fs);
audiowrite('results/denoised_speech.wav', denoised_speech/max(abs(denoised_speech)), config.fs);

% Save metrics
save('results/performance_metrics.mat', 'metrics', 'config');

fprintf('   Audio files and metrics saved to results/ folder\n');

%% Step 7: Play Audio (Optional - Uncomment to hear)
fprintf('\nStep 7: Audio Playback Available\n');
fprintf('   Uncomment lines below to play audio\n');

% sound(clean_speech, config.fs); pause(config.duration + 1);
% sound(noisy_speech, config.fs); pause(config.duration + 1);
% sound(denoised_speech, config.fs);

fprintf('\n=== Processing Complete! ===\n');
fprintf('Check results/ and figures/ folders for outputs\n');
