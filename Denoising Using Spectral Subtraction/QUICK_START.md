# Quick Start Guide - Speech Denoising Project

## 🚀 Getting Started in 5 Minutes

### Step 1: Open MATLAB
Open MATLAB R2025b (or later version)

### Step 2: Navigate to Project Folder
```matlab
cd('/Users/manikantagonugondla/Desktop/MIT/MIT/3rd Year/DSP/FISAC/Denoising Using Spectral Subtraction')
```

### Step 3: Run the Main Script
```matlab
main_speech_denoising
```

That's it! The script will:
- ✅ Generate a synthetic speech signal
- ✅ Add noise to it
- ✅ Apply spectral subtraction denoising
- ✅ Calculate performance metrics
- ✅ Generate 6 visualization figures
- ✅ Save audio files and results

## 📁 What Gets Created?

### In `results/` folder:
- `clean_speech.wav` - Original clean audio
- `noisy_speech.wav` - Audio with added noise
- `denoised_speech.wav` - Enhanced audio after denoising
- `performance_metrics.mat` - All calculated metrics

### In `figures/` folder:
- `time_domain_comparison.png` - Waveform comparison
- `frequency_domain_comparison.png` - FFT spectra
- `spectrogram_comparison.png` - Time-frequency analysis
- `performance_metrics.png` - Performance bar charts
- `error_analysis.png` - Error signals
- `zoomed_comparison.png` - Detailed view

## 🎯 Available Scripts

### 1. **main_speech_denoising.m** (Primary)
Complete demonstration with synthetic speech
```matlab
main_speech_denoising
```

### 2. **process_real_audio.m** (For Real Audio Files)
Process your own audio files
```matlab
process_real_audio
```
*Note: Place your .wav files in `audio_samples/` folder first*

### 3. **parameter_tuning.m** (Optimization)
Test different parameters to find best settings
```matlab
parameter_tuning
```

## ⚙️ Customizing Parameters

Open `main_speech_denoising.m` and modify:

```matlab
config.snr_db = 10;        % Try: 0, 5, 10, 15, 20
config.frame_length = 512;  % Try: 256, 512, 1024
config.alpha = 2.0;         % Try: 1.5, 2.0, 2.5, 3.0
config.beta = 0.01;         % Try: 0.01, 0.05, 0.1
```

## 🔊 Using Your Own Audio

### Method 1: Using process_real_audio.m
1. Put your .wav file in `audio_samples/` folder
2. Run: `process_real_audio`

### Method 2: Modify main script
In `main_speech_denoising.m`, replace lines 24-26:
```matlab
% Replace this:
clean_speech = generate_synthetic_speech(t, config.fs);

% With this:
[clean_speech, fs] = audioread('audio_samples/your_file.wav');
config.fs = fs;
```

## 📊 Understanding the Results

### Good Performance Indicators:
- ✅ SNR Improvement > 5 dB
- ✅ Output SNR > Input SNR + 5 dB
- ✅ Correlation > 0.85
- ✅ PESQ Score > 2.5

### Typical Results (SNR = 10 dB input):
- Output SNR: 15-20 dB
- Improvement: 5-10 dB
- PESQ: 2.5-3.5

## 🎵 Playing Audio Files

Uncomment these lines in the main script:
```matlab
sound(clean_speech, config.fs); pause(config.duration + 1);
sound(noisy_speech, config.fs); pause(config.duration + 1);
sound(denoised_speech, config.fs);
```

## 🐛 Troubleshooting

### "Undefined function or variable"
```matlab
addpath('functions')
```

### "Cannot open file"
Check that you're in the correct directory:
```matlab
pwd  % Shows current directory
```

### Out of Memory
Reduce duration:
```matlab
config.duration = 2;  % Instead of 3
```

## 📝 For Your Report

### Key Points to Include:
1. **Algorithm**: Spectral Subtraction using FFT
2. **Parameters Used**: Frame length, overlap, alpha, beta
3. **Results**: SNR improvement, PESQ scores
4. **Visualizations**: Include all 6 figures
5. **Applications**: Noise reduction in telephony, hearing aids, etc.

### Figures to Include in Report:
- Time domain comparison (shows noise reduction visually)
- Frequency spectra (shows FFT application)
- Spectrograms (shows time-frequency analysis)
- Performance metrics (quantitative results)

## ⏱️ Expected Runtime

- Synthetic speech (3 seconds): ~5-10 seconds
- Real audio (3 seconds): ~10-15 seconds
- Parameter tuning: ~1-2 minutes

## 🎓 Next Steps for Your Project

1. ✅ Run `main_speech_denoising.m` - Get basic results
2. ✅ Run `parameter_tuning.m` - Find optimal parameters
3. ✅ Test with real audio using `process_real_audio.m`
4. ✅ Collect all figures for report
5. ✅ Start literature review (need 15 papers)
6. ✅ Write IEEE format report

## 💡 Tips for Best Results

1. **For noisy environments** (low SNR): Use higher alpha (2.5-3.0)
2. **For cleaner audio** (high SNR): Use lower alpha (1.5-2.0)
3. **For musical noise artifacts**: Decrease alpha or increase beta
4. **For better frequency resolution**: Increase frame_length
5. **For better time resolution**: Decrease frame_length

## 📧 Need Help?

Check the main README.md for detailed documentation.

---
**Ready to start?** Just run:
```matlab
main_speech_denoising
```

Good luck with your FISAC assessment! 🎉
