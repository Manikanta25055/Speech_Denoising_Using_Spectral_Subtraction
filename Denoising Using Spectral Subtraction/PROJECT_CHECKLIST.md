# FISAC Project Checklist - Speech Denoising

## 📋 Project Requirements Checklist

### ✅ Basic Requirements
- [x] Group formed (Group 6)
- [x] Topic selected: Applications of N-point FFT (Speech Denoising)
- [ ] Literature review of 15+ papers
- [ ] Simulation completed in MATLAB
- [ ] Report in IEEE format
- [ ] Submission by: 27th October 2025, 05:00 PM

### ✅ Simulation Requirements
- [x] MATLAB scripts created
- [x] Main algorithm implemented (Spectral Subtraction)
- [x] FFT/IFFT operations included
- [x] Performance metrics calculated
- [x] Visualizations generated
- [ ] Test with different parameters
- [ ] Test with real audio files (optional)

### ✅ Files Created

#### Main Scripts (3)
- [x] `main_speech_denoising.m` - Primary demonstration
- [x] `parameter_tuning.m` - Parameter optimization
- [x] `process_real_audio.m` - Real audio processing

#### Function Files (5)
- [x] `spectral_subtraction.m` - Core algorithm
- [x] `add_noise.m` - Noise addition
- [x] `generate_synthetic_speech.m` - Test signal generation
- [x] `calculate_metrics.m` - Performance evaluation
- [x] `visualize_results.m` - Result visualization

#### Documentation (3)
- [x] `README.md` - Comprehensive documentation
- [x] `QUICK_START.md` - Quick start guide
- [x] `PROJECT_CHECKLIST.md` - This file

### 📊 Simulation Outputs to Generate

#### Audio Files (3)
- [ ] Clean speech audio (.wav)
- [ ] Noisy speech audio (.wav)
- [ ] Denoised speech audio (.wav)

#### Figures (6-9)
- [ ] Time domain comparison
- [ ] Frequency domain (FFT) comparison
- [ ] Spectrogram comparison
- [ ] Performance metrics charts
- [ ] Error analysis
- [ ] Zoomed waveform view
- [ ] Parameter tuning plots (optional)

#### Data Files
- [ ] Performance metrics (.mat file)
- [ ] Parameter tuning results (.mat file)

## 📝 Literature Review Checklist

### Papers to Find (Minimum 15)
Target: IEEE Conference papers or SCOPUS indexed journals

#### Core Topics
- [ ] 3-4 papers on Spectral Subtraction method
- [ ] 2-3 papers on FFT in speech processing
- [ ] 2-3 papers on Noise estimation techniques
- [ ] 2-3 papers on Speech enhancement evaluation metrics
- [ ] 2-3 papers on Applications (hearing aids, telephony, etc.)
- [ ] 2-3 papers on Recent advances/modifications

### For Each Paper Document:
- [ ] Title
- [ ] Authors
- [ ] Publication venue (Journal/Conference)
- [ ] Year
- [ ] Research objective (brief)
- [ ] Methodology (brief)
- [ ] Results (brief)
- [ ] Key findings

### Literature Review Tips:
1. Search databases: IEEE Xplore, Google Scholar, Scopus
2. Keywords: "spectral subtraction", "speech denoising", "FFT speech enhancement"
3. Filter: Recent papers (2015-2025) preferred
4. Focus on: Practical applications and results

## 📄 IEEE Report Checklist

### Report Structure (IEEE Format)
- [ ] Title (with proper formatting)
- [ ] Author names and affiliations (Group 6 members)
- [ ] Abstract (150-200 words)
  - [ ] Problem statement
  - [ ] Methodology (Spectral Subtraction + FFT)
  - [ ] Key results
- [ ] Keywords (4-6 keywords)
- [ ] Introduction
  - [ ] Background on speech denoising
  - [ ] Importance of FFT
  - [ ] Paper organization
- [ ] Literature Review
  - [ ] Summary of 15+ papers
  - [ ] Research gaps identified
- [ ] Methodology
  - [ ] Spectral subtraction algorithm explanation
  - [ ] FFT application
  - [ ] Parameter selection
  - [ ] Block diagram/flowchart
- [ ] Implementation
  - [ ] MATLAB implementation details
  - [ ] System specifications
  - [ ] Parameters used
- [ ] Results and Discussion
  - [ ] Time domain results (figures)
  - [ ] Frequency domain results (figures)
  - [ ] Spectrograms
  - [ ] Performance metrics tables
  - [ ] Comparison with literature
- [ ] Applications
  - [ ] Real-world applications
  - [ ] Future scope
- [ ] Conclusion
  - [ ] Summary of findings
  - [ ] Achievements
  - [ ] Limitations
  - [ ] Future work
- [ ] References (IEEE citation style)
  - [ ] Minimum 15 references
  - [ ] Properly formatted

### Report Formatting
- [ ] IEEE template used (Report.docx provided)
- [ ] Two-column format
- [ ] Times New Roman font
- [ ] Proper heading styles (Heading 1, 2, 3...)
- [ ] Figures numbered (Fig. 1, Fig. 2, ...)
- [ ] Tables numbered (Table I, Table II, ...)
- [ ] Equations numbered
- [ ] References in IEEE format [1], [2], ...

### Figures to Include
- [ ] Figure 1: Block diagram of spectral subtraction
- [ ] Figure 2: Time domain waveforms (clean, noisy, denoised)
- [ ] Figure 3: Frequency spectra (FFT)
- [ ] Figure 4: Spectrograms comparison
- [ ] Figure 5: SNR performance chart
- [ ] Figure 6: Performance metrics comparison
- [ ] Figure 7: Parameter effect analysis (optional)

### Tables to Include
- [ ] Table I: Simulation parameters
- [ ] Table II: Performance metrics (SNR, PESQ, etc.)
- [ ] Table III: Comparison with literature (optional)
- [ ] Table IV: Literature review summary

## 🎯 Testing Checklist

### Run These Tests:
- [ ] Test 1: Default parameters (SNR = 10 dB)
- [ ] Test 2: Low SNR (5 dB)
- [ ] Test 3: High SNR (15 dB)
- [ ] Test 4: Different alpha values (1.5, 2.0, 2.5)
- [ ] Test 5: Different frame lengths (256, 512, 1024)
- [ ] Test 6: Real audio file (if available)

### Verify Outputs:
- [ ] Audio files play correctly
- [ ] Denoised audio sounds better than noisy
- [ ] SNR improvement > 5 dB
- [ ] All figures generated without errors
- [ ] Metrics saved correctly

## 🚀 Action Items

### Week 1 (This Week)
- [ ] ✅ Setup MATLAB project structure
- [ ] ✅ Implement spectral subtraction algorithm
- [ ] Run initial simulations
- [ ] Generate all figures
- [ ] Start literature search

### Week 2
- [ ] Complete literature review (15+ papers)
- [ ] Test with different parameters
- [ ] Organize all results
- [ ] Start writing report draft
- [ ] Create result tables

### Week 3
- [ ] Complete report writing
- [ ] Format report in IEEE style
- [ ] Proofread and edit
- [ ] Final simulation runs
- [ ] Prepare for submission

## ⚠️ Important Reminders

### Before Submission:
- [ ] Report filename: `Section_RollNumber1,2.doc`
- [ ] All group member names included
- [ ] Roll numbers mentioned
- [ ] Group number (6) mentioned
- [ ] Date mentioned
- [ ] Checked for plagiarism
- [ ] Removed template text from IEEE format
- [ ] All figures properly labeled
- [ ] All references properly cited

### Quality Checks:
- [ ] No grammar/spelling errors
- [ ] All equations formatted correctly
- [ ] Figure quality is high (300 dpi minimum)
- [ ] Consistent formatting throughout
- [ ] Abstract is concise and complete
- [ ] Conclusion matches objectives

## 📊 Performance Targets

### Expected Results:
- SNR Improvement: > 5 dB ✓
- Output SNR: > Input SNR + 5 dB ✓
- Correlation: > 0.85 ✓
- PESQ Score: > 2.5 ✓
- Processing Time: < 30 seconds ✓

## 👥 Group Coordination

### Suggested Task Division:
- Member 1: Literature review (papers 1-5)
- Member 2: Literature review (papers 6-10)
- Member 3: Literature review (papers 11-15)
- Member 4: MATLAB simulation & testing
- Member 5: Report writing & formatting

### Regular Meetings:
- [ ] Meeting 1: Divide tasks
- [ ] Meeting 2: Literature review progress
- [ ] Meeting 3: Simulation results review
- [ ] Meeting 4: Report draft review
- [ ] Meeting 5: Final review before submission

## ✅ Final Submission Checklist

- [ ] Report in IEEE format completed
- [ ] All 15+ papers reviewed
- [ ] All simulations completed
- [ ] All figures included in report
- [ ] All tables included in report
- [ ] References properly formatted
- [ ] Filename correct: `Section_RollNumber1,2.doc`
- [ ] Submitted before deadline: 27th Oct 2025, 5:00 PM
- [ ] Uploaded to correct location

---

## 🎓 Success Criteria

Your project will be successful if:
- ✅ Complete IEEE format report
- ✅ Minimum 15 SCOPUS/IEEE papers reviewed
- ✅ Working MATLAB simulation
- ✅ Clear results and visualizations
- ✅ Proper analysis and discussion
- ✅ Submitted on time

---

**Current Status**: 
- Project setup: ✅ COMPLETE
- MATLAB code: ✅ COMPLETE
- Simulation: ⏳ TO RUN
- Literature review: ⏳ TO DO
- Report: ⏳ TO WRITE

**Next Step**: Run `main_speech_denoising.m` to generate initial results!

---
*Last Updated: October 2025*
