# Speech Denoising using Spectral Subtraction

## Project Information
- **Course**: Digital Signal Processing (ELE 3122)
- **Assessment**: FISAC Assessment
- **Topic**: Applications of N-point FFT - Speech Denoising
- **Group Number**: 6
- **Institution**: Manipal Institute of Technology, Manipal
- **Semester**: V Semester B.Tech (Electrical & Electronics Engineering)
- **Submission Date**: 27th October 2025

## Project Overview
This project implements speech denoising using the Spectral Subtraction method in the frequency domain. The algorithm uses N-point Fast Fourier Transform (FFT) to transform signals from time domain to frequency domain, performs noise estimation and subtraction, and reconstructs the clean signal using Inverse FFT (IFFT).

## Theory

### Spectral Subtraction Method
Spectral subtraction is a classical approach for speech enhancement that operates in the frequency domain. The main principle is to subtract an estimate of the noise spectrum from the noisy speech spectrum.

**Key Steps:**
1. **Frame Division**: Divide the signal into overlapping frames
2. **Windowing**: Apply window function (Hamming) to reduce spectral leakage
3. **FFT**: Transform each frame to frequency domain using N-point FFT
4. **Noise Estimation**: Estimate noise spectrum from initial frames (assumed to contain only noise)
5. **Spectral Subtraction**: Subtract noise spectrum from noisy spectrum
6. **Spectral Floor**: Apply minimum threshold to avoid negative values
7. **IFFT**: Transform back to time domain
8. **Overlap-Add**: Reconstruct the signal by overlapping frames

### Mathematical Formulation

For a noisy speech signal: Y(ω) = S(ω) + N(ω)

Where:
- Y(ω) = Noisy speech spectrum
- S(ω) = Clean speech spectrum
- N(ω) = Noise spectrum

The estimated clean speech spectrum:
Ŝ(ω) = |Y(ω)| - α|N̂(ω)|

Where:
- α = Over-subtraction factor (typically 1-3)
- N̂(ω) = Estimated noise spectrum

With spectral floor:
Ŝ(ω) = max(|Y(ω)| - α|N̂(ω)|, β|Y(ω)|)

Where β is the spectral floor parameter (typically 0.01-0.1)

## Project Structure

```
Denoising Using Spectral Subtraction/
│
├── main_speech_denoising.m          # Main execution script
│
├── functions/                        # Function files
│   ├── spectral_subtraction.m       # Core spectral subtraction algorithm
│   ├── add_noise.m                  # Noise addition function
│   ├── generate_synthetic_speech.m  # Synthetic speech generation
│   ├── calculate_metrics.m          # Performance metrics calculation
│   └── visualize_results.m          # Visualization generation
│
├── audio_samples/                    # Input audio files (optional)
│   └── (place your .wav files here)
│
├── results/                          # Output audio files and metrics
│   ├── clean_speech.wav
│   ├── noisy_speech.wav
│   ├── denoised_speech.wav
│   └── performance_metrics.mat
│
├── figures/                          # Generated visualizations
│   ├── time_domain_comparison.png
│   ├── frequency_domain_comparison.png
│   ├── spectrogram_comparison.png
│   ├── performance_metrics.png
│   ├── error_analysis.png
│   └── zoomed_comparison.png
│
└── README.md                         # This file
```

## Installation & Requirements

### MATLAB Version
- MATLAB R2025b or later recommended
- Signal Processing Toolbox required

### Required Toolboxes
1. Signal Processing Toolbox (for FFT, spectrogram, etc.)
2. Audio Toolbox (optional, for audio I/O)

## How to Run

### Quick Start
1. Open MATLAB
2. Navigate to the project directory
3. Run the main script:
   ```matlab
   main_speech_denoising
   ```

### Using Your Own Audio Files
1. Place your audio file (.wav format) in the `audio_samples/` folder
2. In `main_speech_denoising.m`, uncomment these lines:
   ```matlab
   [clean_speech, fs] = audioread('audio_samples/your_file.wav');
   config.fs = fs;
   ```
3. Comment out the synthetic speech generation line
4. Run the script

## Configuration Parameters

You can modify these parameters in `main_speech_denoising.m`:

```matlab
config.fs = 16000;              % Sampling frequency (Hz)
config.duration = 3;            % Duration of signal (seconds)
config.snr_db = 10;            % Signal-to-Noise Ratio (dB)
config.frame_length = 512;      % FFT frame length (N-point FFT)
config.overlap = 0.5;           % Frame overlap (50%)
config.alpha = 2.0;             % Over-subtraction factor
config.beta = 0.01;             % Spectral floor parameter
```

### Parameter Guidelines
- **frame_length**: Should be power of 2 (128, 256, 512, 1024, etc.)
- **overlap**: Typically 0.5 (50%) for good quality
- **alpha**: 1.5-3.0 (higher values = more aggressive noise removal)
- **beta**: 0.01-0.1 (prevents over-subtraction artifacts)

## Performance Metrics

The project calculates various metrics to evaluate performance:

1. **SNR (Signal-to-Noise Ratio)**: Measures signal quality in dB
2. **SNR Improvement**: Difference between output and input SNR
3. **MSE (Mean Squared Error)**: Average squared difference
4. **Segmental SNR**: Frame-by-frame SNR analysis
5. **Spectral Distortion**: Frequency domain difference
6. **Correlation Coefficient**: Similarity with clean signal
7. **PESQ (Approximate)**: Perceptual quality estimate
8. **Noise Reduction**: Amount of noise removed in dB

## Visualizations Generated

1. **Time Domain Comparison**: Clean, noisy, and denoised signals
2. **Frequency Domain (FFT)**: Magnitude spectra comparison
3. **Spectrograms**: Time-frequency analysis
4. **Performance Metrics**: Bar charts of various metrics
5. **Error Analysis**: Residual noise analysis
6. **Zoomed View**: Detailed comparison of signal segments

## Expected Results

Typical performance for SNR = 10 dB input:
- Output SNR: 15-20 dB
- SNR Improvement: 5-10 dB
- Correlation: > 0.85
- PESQ Score: 2.5-3.5

## Applications of FFT in This Project

1. **Signal Analysis**: FFT converts time-domain signals to frequency domain
2. **Noise Estimation**: FFT helps identify noise characteristics in frequency domain
3. **Filtering**: Spectral subtraction is essentially frequency-domain filtering
4. **Signal Reconstruction**: IFFT reconstructs enhanced signal
5. **Visualization**: FFT enables frequency spectrum and spectrogram analysis

## Advantages of Spectral Subtraction

✅ Computationally efficient
✅ Simple to implement
✅ No training required
✅ Works well for stationary noise
✅ Real-time processing possible

## Limitations

❌ Musical noise artifacts (residual tones)
❌ Assumes stationary noise
❌ May distort speech if parameters not tuned properly
❌ Less effective for non-stationary noise

## Future Enhancements

1. Implement advanced noise estimation techniques
2. Add Wiener filtering for comparison
3. Include real-world noise scenarios
4. Implement adaptive parameter selection
5. Add more sophisticated musical noise suppression

## Troubleshooting

### Common Issues

**1. "Undefined function or variable"**
- Solution: Make sure you're in the project directory
- Run: `addpath('functions')`

**2. "Out of memory"**
- Solution: Reduce `config.duration` or use shorter audio files

**3. "Audio file not found"**
- Solution: Check file path and name in `audioread()` function

**4. Poor denoising quality**
- Solution: Adjust `alpha` (over-subtraction factor)
- Try different `frame_length` values
- Check if SNR is too low (< 0 dB)

## References for Literature Review

This implementation is based on principles from:

1. S.F. Boll, "Suppression of acoustic noise in speech using spectral subtraction," IEEE Transactions on Acoustics, Speech, and Signal Processing, 1979.

2. M. Berouti, R. Schwartz, and J. Makhoul, "Enhancement of speech corrupted by acoustic noise," IEEE ICASSP, 1979.

3. P. Lockwood and J. Boudy, "Experiments with a nonlinear spectral subtractor (NSS), hidden Markov models and the projection, for robust speech recognition in cars," Speech Communication, 1992.

## Group Members
[Add your group member names and roll numbers here]
- Member 1: [Name] - [Roll Number]
- Member 2: [Name] - [Roll Number]
- Member 3: [Name] - [Roll Number]
- Member 4: [Name] - [Roll Number]
- Member 5: [Name] - [Roll Number]

## License
This project is for educational purposes as part of FISAC Assessment.

## Contact
For questions regarding this project, contact group members or course instructor.

---
*Last Updated: October 2025*
