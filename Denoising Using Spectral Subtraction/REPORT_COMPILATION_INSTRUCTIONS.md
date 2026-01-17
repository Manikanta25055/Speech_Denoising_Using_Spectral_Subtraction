# FISAC Report Compilation Instructions

## Report Details

- **File:** FISAC_Report_Group6.tex
- **Format:** IEEE Conference Format (Two-Column)
- **Group:** Group 6
- **Members:** Aditya Pratap Singh, Akshit Kiran, Sreekar T Gopal, Gonugondla Veera Manikanta, Sparsh Raghav
- **Topic:** Speech Denoising Using Spectral Subtraction - Application of N-Point FFT

---

## Prerequisites

You need a LaTeX distribution installed on your system:

### macOS
```bash
brew install --cask mactex
```
Or download from: https://www.tug.org/mactex/

### Alternative: Overleaf (Online - RECOMMENDED for ease)
1. Go to https://www.overleaf.com
2. Create a free account
3. Click "New Project" > "Upload Project"
4. Upload the FISAC_Report_Group6.tex file
5. Compile automatically (click "Recompile")
6. Download PDF

---

## Method 1: Compile Using Terminal (macOS/Linux)

### Step 1: Navigate to Project Directory
```bash
cd "/Users/manikantagonugondla/Desktop/MIT/MIT/3rd Year/DSP/FISAC/Denoising Using Spectral Subtraction"
```

### Step 2: Compile the LaTeX Document
```bash
pdflatex FISAC_Report_Group6.tex
bibtex FISAC_Report_Group6
pdflatex FISAC_Report_Group6.tex
pdflatex FISAC_Report_Group6.tex
```

**Note:** The compilation is done 3 times to ensure all references and citations are properly resolved.

### Step 3: View the Generated PDF
```bash
open FISAC_Report_Group6.pdf
```

---

## Method 2: Using the Compilation Script

I've created a helper script for you:

```bash
chmod +x compile_report.sh
./compile_report.sh
```

This will automatically compile the report and open the PDF.

---

## Method 3: Using TeXShop (macOS GUI)

1. Install MacTeX (includes TeXShop)
2. Open FISAC_Report_Group6.tex in TeXShop
3. Click "Typeset" button
4. PDF will be generated automatically

---

## Method 4: Using Overleaf (Easiest - RECOMMENDED)

### Why Overleaf?
- No installation required
- Automatic compilation
- Collaboration features
- Version control
- Professional templates
- Cloud-based

### Steps:
1. Visit https://www.overleaf.com/edu/manipal (might have institutional account)
2. Or use free account at https://www.overleaf.com
3. Create New Project > Upload Project
4. Upload FISAC_Report_Group6.tex
5. Click "Recompile" to generate PDF
6. Download PDF when ready

---

## Adding Figures to the Report

The report references figures from your simulation results. To include them:

### Option 1: LaTeX with Local Files

Add these lines after the respective sections in the .tex file:

```latex
\begin{figure}[h]
\centering
\includegraphics[width=0.48\textwidth]{figures/time_domain_comparison.png}
\caption{Time domain comparison of clean, noisy, and denoised speech signals.}
\label{fig:time_domain}
\end{figure}
```

Repeat for all 6 figures:
- time_domain_comparison.png
- frequency_domain_comparison.png
- spectrogram_comparison.png
- performance_metrics.png
- error_analysis.png
- zoomed_comparison.png

### Option 2: Overleaf

1. Upload all PNG files from the `figures/` folder to Overleaf
2. Add the figure code above at appropriate locations
3. Recompile

---

## Converting to Word Format (If Required)

If you need a .doc file instead of PDF:

### Method 1: Using Pandoc
```bash
brew install pandoc
pandoc FISAC_Report_Group6.tex -o FISAC_Report_Group6.docx
```

### Method 2: Online Converters
1. Compile to PDF first
2. Use Adobe Acrobat or online tools:
   - https://www.adobe.com/acrobat/online/pdf-to-word.html
   - https://www.ilovepdf.com/pdf_to_word

### Method 3: Copy-Paste to Word
1. Open the generated PDF
2. Copy content section by section
3. Paste into Microsoft Word
4. Apply IEEE format template manually

---

## Final Submission Filename

According to FISAC instructions, the filename should be:
```
Section_RollNumber1,2.doc
```

**For your group, this might be:**
```
[YourSection]_230906248,230906176.doc
```

**Example:** If your section is A:
```
A_230906248,230906176.doc
```

**To create this:**
1. Compile the LaTeX to PDF
2. Convert PDF to Word (.docx) using one of the methods above
3. Save as .doc format with the correct filename
4. Upload to the specified location before deadline: **27th October 2025, 05:00 PM**

---

## Troubleshooting

### Error: "File not found: IEEEtran.cls"
**Solution:** Install IEEEtran package
```bash
sudo tlmgr install IEEEtran
```

### Error: "Package graphicx not found"
**Solution:** Install required packages
```bash
sudo tlmgr install graphics graphicx
```

### Error: Multiple compilation needed
**Solution:** This is normal. Always compile 2-3 times for references to resolve.

### Compilation takes too long
**Solution:** Remove intermediate files and recompile
```bash
rm *.aux *.log *.bbl *.blg *.out
pdflatex FISAC_Report_Group6.tex
```

---

## Report Content Summary

The report includes:

1. **Title Page** - Group members and affiliations
2. **Abstract** - 200-word summary
3. **Keywords** - FFT, Spectral Subtraction, Speech Enhancement
4. **Introduction** - Background and motivation (1.5 pages)
5. **Literature Review** - 18 papers reviewed (4 pages)
   - Foundation: Boll 1979
   - Musical noise reduction
   - Wiener filtering
   - Deep learning approaches
   - Quality metrics (PESQ, STOI)
   - Real-time methods
   - Applications
6. **Methodology** - Mathematical formulation (2 pages)
   - Spectral subtraction algorithm
   - FFT implementation
   - Parameter selection
7. **Implementation** - MATLAB details (1.5 pages)
   - System architecture
   - Function descriptions
   - Computational complexity
8. **Results and Discussion** - Performance analysis (2.5 pages)
   - Metrics comparison table
   - Parameter tuning results
   - Visualization analysis
9. **Applications** - Real-world uses (1 page)
   - Telecommunications
   - Hearing aids
   - Speech recognition
   - Medical applications
10. **Limitations and Future Work** - (0.5 page)
11. **Conclusion** - Summary and key findings (0.5 page)
12. **References** - 18 IEEE/SCOPUS papers in IEEE format

**Total Length:** Approximately 14-16 pages (IEEE two-column format)

---

## Checklist Before Submission

- [ ] Report compiled successfully to PDF
- [ ] All 18 references are properly cited
- [ ] Figures included (or placeholders added)
- [ ] Group member names and roll numbers verified
- [ ] Abstract is concise and complete
- [ ] Mathematical equations are properly formatted
- [ ] Table formatting is correct
- [ ] References follow IEEE style [1], [2], etc.
- [ ] Converted to .doc format
- [ ] Filename follows format: Section_RollNumber1,2.doc
- [ ] File size is reasonable (< 10 MB)
- [ ] Checked for spelling and grammar errors
- [ ] All sections are complete

---

## Getting Help

If you encounter issues:

1. **LaTeX Errors:** Check error messages carefully, usually indicates missing package or syntax error
2. **Formatting Issues:** Refer to IEEE conference template guidelines
3. **Compilation Issues:** Try Overleaf instead of local compilation
4. **Content Questions:** Review the FISAC guidelines PDF

---

## Additional Resources

- **IEEE Author Center:** https://journals.ieeeauthorcenter.ieee.org/
- **LaTeX Documentation:** https://www.overleaf.com/learn
- **IEEEtran Class:** https://www.ctan.org/pkg/ieeetran
- **Overleaf Templates:** https://www.overleaf.com/gallery/tagged/ieee-official

---

**Report created on:** October 24, 2025
**Deadline:** October 27, 2025, 05:00 PM
**Status:** Ready for compilation and submission

Good luck with your submission!
