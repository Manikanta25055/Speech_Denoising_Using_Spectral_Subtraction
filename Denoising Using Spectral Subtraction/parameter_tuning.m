%% Parameter Tuning and Comparison Script
% This script helps you test different parameters and compare results
% Use this to find optimal parameters for your specific audio

clear all;
close all;
clc;

addpath('functions');

%% Test Configuration
fprintf('=== Parameter Tuning and Comparison ===\n\n');

% Base configuration
config.fs = 16000;
config.duration = 3;
config.frame_length = 512;
config.overlap = 0.5;

% Generate test signal
t = 0:1/config.fs:(config.duration - 1/config.fs);
clean_speech = generate_synthetic_speech(t, config.fs);

%% Test 1: Different SNR Levels
fprintf('Test 1: Testing Different SNR Levels\n');
snr_levels = [0, 5, 10, 15, 20];
alpha = 2.0;
beta = 0.01;

results_snr = struct();

for i = 1:length(snr_levels)
    fprintf('  Testing SNR = %d dB... ', snr_levels(i));
    
    config.snr_db = snr_levels(i);
    config.alpha = alpha;
    config.beta = beta;
    
    noisy_speech = add_noise(clean_speech, config.snr_db);
    denoised_speech = spectral_subtraction(noisy_speech, config);
    metrics = calculate_metrics(clean_speech, noisy_speech, denoised_speech, config.fs);
    
    results_snr(i).snr_input = snr_levels(i);
    results_snr(i).snr_output = metrics.output_snr;
    results_snr(i).improvement = metrics.snr_improvement;
    results_snr(i).pesq = metrics.pesq_approx;
    
    fprintf('Done (Improvement: %.2f dB)\n', metrics.snr_improvement);
end

%% Test 2: Different Alpha Values (Over-subtraction Factor)
fprintf('\nTest 2: Testing Different Alpha Values\n');
alpha_values = [1.0, 1.5, 2.0, 2.5, 3.0];
snr_db = 10;
beta = 0.01;

results_alpha = struct();
noisy_speech = add_noise(clean_speech, snr_db);

for i = 1:length(alpha_values)
    fprintf('  Testing Alpha = %.1f... ', alpha_values(i));
    
    config.snr_db = snr_db;
    config.alpha = alpha_values(i);
    config.beta = beta;
    
    denoised_speech = spectral_subtraction(noisy_speech, config);
    metrics = calculate_metrics(clean_speech, noisy_speech, denoised_speech, config.fs);
    
    results_alpha(i).alpha = alpha_values(i);
    results_alpha(i).snr_output = metrics.output_snr;
    results_alpha(i).improvement = metrics.snr_improvement;
    results_alpha(i).spectral_dist = metrics.spectral_distortion;
    
    fprintf('Done (SNR: %.2f dB)\n', metrics.output_snr);
end

%% Test 3: Different Frame Lengths
fprintf('\nTest 3: Testing Different Frame Lengths\n');
frame_lengths = [128, 256, 512, 1024];
alpha = 2.0;
beta = 0.01;

results_frame = struct();

for i = 1:length(frame_lengths)
    fprintf('  Testing Frame Length = %d... ', frame_lengths(i));
    
    config.snr_db = snr_db;
    config.frame_length = frame_lengths(i);
    config.alpha = alpha;
    config.beta = beta;
    
    denoised_speech = spectral_subtraction(noisy_speech, config);
    metrics = calculate_metrics(clean_speech, noisy_speech, denoised_speech, config.fs);
    
    results_frame(i).frame_length = frame_lengths(i);
    results_frame(i).snr_output = metrics.output_snr;
    results_frame(i).improvement = metrics.snr_improvement;
    
    fprintf('Done (SNR: %.2f dB)\n', metrics.output_snr);
end

%% Visualization of Results
fprintf('\nGenerating Comparison Plots...\n');

% Plot 1: SNR Performance
figure('Position', [100, 100, 1200, 400]);

subplot(1,3,1);
plot(snr_levels, [results_snr.snr_output], 'b-o', 'LineWidth', 2, 'MarkerSize', 8);
hold on;
plot(snr_levels, snr_levels, 'r--', 'LineWidth', 1.5);
xlabel('Input SNR (dB)');
ylabel('Output SNR (dB)');
title('SNR Performance vs Input SNR');
legend('Output SNR', 'Input SNR (reference)', 'Location', 'northwest');
grid on;

subplot(1,3,2);
plot(snr_levels, [results_snr.improvement], 'g-s', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Input SNR (dB)');
ylabel('SNR Improvement (dB)');
title('SNR Improvement vs Input SNR');
grid on;

subplot(1,3,3);
plot(snr_levels, [results_snr.pesq], 'm-d', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Input SNR (dB)');
ylabel('Approximate PESQ Score');
title('PESQ Score vs Input SNR');
grid on;
ylim([0 5]);

sgtitle('Effect of Input SNR on Performance', 'FontSize', 14, 'FontWeight', 'bold');
saveas(gcf, 'figures/parameter_tuning_snr.png');

% Plot 2: Alpha Parameter
figure('Position', [150, 150, 1200, 400]);

subplot(1,3,1);
plot(alpha_values, [results_alpha.snr_output], 'b-o', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Alpha (Over-subtraction Factor)');
ylabel('Output SNR (dB)');
title('SNR vs Alpha Parameter');
grid on;

subplot(1,3,2);
plot(alpha_values, [results_alpha.improvement], 'g-s', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Alpha (Over-subtraction Factor)');
ylabel('SNR Improvement (dB)');
title('Improvement vs Alpha Parameter');
grid on;

subplot(1,3,3);
plot(alpha_values, [results_alpha.spectral_dist], 'r-d', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Alpha (Over-subtraction Factor)');
ylabel('Spectral Distortion');
title('Spectral Distortion vs Alpha');
grid on;

sgtitle('Effect of Alpha Parameter on Performance', 'FontSize', 14, 'FontWeight', 'bold');
saveas(gcf, 'figures/parameter_tuning_alpha.png');

% Plot 3: Frame Length
figure('Position', [200, 200, 800, 400]);

subplot(1,2,1);
bar(frame_lengths, [results_frame.snr_output]);
xlabel('Frame Length (samples)');
ylabel('Output SNR (dB)');
title('SNR vs Frame Length');
grid on;
set(gca, 'XTick', frame_lengths);

subplot(1,2,2);
bar(frame_lengths, [results_frame.improvement]);
xlabel('Frame Length (samples)');
ylabel('SNR Improvement (dB)');
title('Improvement vs Frame Length');
grid on;
set(gca, 'XTick', frame_lengths);

sgtitle('Effect of Frame Length on Performance', 'FontSize', 14, 'FontWeight', 'bold');
saveas(gcf, 'figures/parameter_tuning_frame.png');

%% Summary Results
fprintf('\n=== SUMMARY OF RESULTS ===\n\n');

fprintf('Test 1: Effect of Input SNR\n');
fprintf('Best Input SNR: %d dB (Output: %.2f dB, Improvement: %.2f dB)\n', ...
        results_snr(end).snr_input, results_snr(end).snr_output, results_snr(end).improvement);

fprintf('\nTest 2: Effect of Alpha Parameter\n');
[~, best_alpha_idx] = max([results_alpha.improvement]);
fprintf('Best Alpha: %.1f (Output SNR: %.2f dB, Improvement: %.2f dB)\n', ...
        results_alpha(best_alpha_idx).alpha, ...
        results_alpha(best_alpha_idx).snr_output, ...
        results_alpha(best_alpha_idx).improvement);

fprintf('\nTest 3: Effect of Frame Length\n');
[~, best_frame_idx] = max([results_frame.improvement]);
fprintf('Best Frame Length: %d samples (Output SNR: %.2f dB, Improvement: %.2f dB)\n', ...
        results_frame(best_frame_idx).frame_length, ...
        results_frame(best_frame_idx).snr_output, ...
        results_frame(best_frame_idx).improvement);

fprintf('\n=== Parameter Tuning Complete! ===\n');
fprintf('Check figures/ folder for comparison plots\n');

%% Save Results
save('results/parameter_tuning_results.mat', 'results_snr', 'results_alpha', 'results_frame');
fprintf('Results saved to results/parameter_tuning_results.mat\n');
