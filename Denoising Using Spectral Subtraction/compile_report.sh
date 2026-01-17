#!/bin/bash

# FISAC Report Compilation Script
# Group 6 - Speech Denoising Using Spectral Subtraction

echo "=========================================="
echo "  FISAC Report Compilation Script"
echo "  Group 6 - DSP Project"
echo "=========================================="
echo ""

# Set the filename
TEXFILE="FISAC_Report_Group6"

# Check if pdflatex is installed
if ! command -v pdflatex &> /dev/null; then
    echo "ERROR: pdflatex not found!"
    echo "Please install MacTeX: brew install --cask mactex"
    echo ""
    echo "Alternative: Use Overleaf (https://www.overleaf.com)"
    echo "  1. Upload $TEXFILE.tex to Overleaf"
    echo "  2. Click 'Recompile'"
    echo "  3. Download PDF"
    exit 1
fi

# Navigate to script directory
cd "$(dirname "$0")"

echo "Step 1: Cleaning old compilation files..."
rm -f *.aux *.log *.bbl *.blg *.out *.toc *.lof *.lot 2>/dev/null
echo "  Cleanup complete."
echo ""

echo "Step 2: First pdflatex compilation..."
pdflatex -interaction=nonstopmode $TEXFILE.tex > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "  First pass successful."
else
    echo "  Warning: First pass had errors (this is sometimes normal)."
fi
echo ""

echo "Step 3: Processing bibliography..."
# Note: This project uses embedded bibliography, so bibtex is optional
if command -v bibtex &> /dev/null; then
    bibtex $TEXFILE > /dev/null 2>&1
    echo "  Bibliography processed."
else
    echo "  Skipping bibtex (using embedded references)."
fi
echo ""

echo "Step 4: Second pdflatex compilation..."
pdflatex -interaction=nonstopmode $TEXFILE.tex > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "  Second pass successful."
else
    echo "  Warning: Second pass had errors."
fi
echo ""

echo "Step 5: Final pdflatex compilation..."
pdflatex -interaction=nonstopmode $TEXFILE.tex > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "  Final pass successful."
else
    echo "  Error: Final pass failed. Check $TEXFILE.log for details."
    exit 1
fi
echo ""

# Check if PDF was generated
if [ -f "$TEXFILE.pdf" ]; then
    echo "=========================================="
    echo "  SUCCESS!"
    echo "=========================================="
    echo ""
    echo "PDF generated: $TEXFILE.pdf"

    # Get file size
    FILESIZE=$(du -h "$TEXFILE.pdf" | cut -f1)
    echo "File size: $FILESIZE"

    # Get page count (requires pdfinfo, part of poppler)
    if command -v pdfinfo &> /dev/null; then
        PAGES=$(pdfinfo "$TEXFILE.pdf" 2>/dev/null | grep "Pages:" | awk '{print $2}')
        echo "Number of pages: $PAGES"
    fi

    echo ""
    echo "Opening PDF..."
    open "$TEXFILE.pdf"

    echo ""
    echo "Next steps:"
    echo "  1. Review the PDF for any formatting issues"
    echo "  2. Ensure all figures are included"
    echo "  3. Convert to .doc format if required"
    echo "  4. Rename as: Section_RollNumber1,2.doc"
    echo "  5. Submit before deadline: Oct 27, 2025, 05:00 PM"
    echo ""
else
    echo "=========================================="
    echo "  COMPILATION FAILED!"
    echo "=========================================="
    echo ""
    echo "PDF was not generated. Please check:"
    echo "  1. $TEXFILE.log for error details"
    echo "  2. Make sure all required packages are installed"
    echo ""
    echo "Alternative: Try Overleaf instead"
    echo "  https://www.overleaf.com"
    exit 1
fi

echo "Cleaning up auxiliary files..."
rm -f *.aux *.log *.bbl *.blg *.out *.toc *.lof *.lot 2>/dev/null
echo "  Cleanup complete."
echo ""
echo "=========================================="
echo "  Compilation script finished!"
echo "=========================================="
