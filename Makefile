MAIN_FILE := nrc_resume.tex
AUX_FILES := sweet_resume.sty
PDF_LATEX := pdflatex

OUTPUT := nicholas_clark_resume.pdf
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

define \n


endef

%.pdf: %.tex $(AUX_FILES)
	$(foreach x, 1 2 3 4 5 6,$(PDF_LATEX) $<$(\n))

.INTERMEDIATE: $(MAIN_FILE:%.tex=%.pdf)

$(OUTPUT): $(MAIN_FILE:%.tex=%.pdf)
	cp -a $< $@

preview: $(OUTPUT)
	nohup $(PDFVIEW) $(OUTPUT) 1>/dev/null 2>&1 &

clean:
	rm -rf $(MAIN_FILE:%.tex=%.pdf)
	rm -rf $(OUTPUT)
	rm -rf *.log *.aux
