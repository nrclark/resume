MAIN_FILE := nrc_resume.tex
AUX_FILES := sweet_resume.sty
PDF_LATEX := pdflatex

OUTPUT := $(basename $(MAIN_FILE)).pdf
OS := $(strip $(shell uname | tr A-Z a-z))
OS := $(findstring cygwin,$(OS))$(findstring darwin,$(OS))
OS := $(if $(OS),$(OS),linux)

ifeq ($(OS),cygwin)
	PDFVIEW := $(if $(strip $(shell which evince 2>/dev/null)),evince,cygstart)
else ifeq ($(OS),darwin) 
	PDFVIEW := open -a preview
else
	PDFVIEW := evince
endif

$(OUTPUT): $(MAIN_FILE) $(AUX_FILES)
	$(PDF_LATEX) $(MAIN_FILE)
	$(PDF_LATEX) $(MAIN_FILE)

preview: $(OUTPUT)
	nohup $(PDFVIEW) $(OUTPUT) 1>/dev/null 2>&1 &

clean:
	rm -rf $(OUTPUT)
	rm -rf *.log *.aux
