MAIN_FILE := nrc_resume.tex
AUX_FILES := sweet_resume.sty
PDF_LATEX := pdflatex

OUTPUT := $(basename $(MAIN_FILE)).pdf
OS := $(shell uname)

$(OUTPUT): $(MAIN_FILE) $(AUX_FILES)
	$(PDF_LATEX) $(MAIN_FILE)
	$(PDF_LATEX) $(MAIN_FILE)

preview: $(OUTPUT)
	open -a preview $(OUTPUT)

clean:
	rm -rf $(OUTPUT)
	rm -rf *.log *.aux


	
