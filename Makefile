all: ms_word pdf

ms_word: manuscript.docx
pdf: manuscript.pdf


manuscript.docx: md/front_matter.md md/abstract.md md/introduction.md md/methods.md md/results.md md/discussion.md md/end_matter.md md/ref_loc.md ref/ASW.bib ref/insects_doi.csl ref/ref.docx
	pandoc \
		--from=markdown \
		--to=docx \
		--reference-doc=ref/ref.docx \
		--bibliography=ref/ASW.bib \
		--csl=ref/insects_doi.csl \
		-o manuscript.docx \
		md/front_matter.md \
		md/abstract.md \
		md/introduction.md \
		md/methods.md \
		md/results.md \
		md/discussion.md \
		md/end_matter.md \
		md/ref_loc.md 

manuscript.pdf: md/front_matter.md md/abstract.md md/introduction.md md/methods.md md/results.md md/discussion.md md/end_matter.md md/ref_loc.md ref/ASW.bib ref/insects_doi.csl ref/header.tex
	pandoc \
		--from=markdown \
		--to=latex \
		--pdf-engine=xelatex \
		--include-in-header=ref/header.tex \
		--bibliography=ref/ASW.bib \
		--csl=ref/insects_doi.csl \
		-o manuscript.pdf \
		md/front_matter.md \
		md/abstract.md \
		md/introduction.md \
		md/methods.md \
		md/results.md \
		md/discussion.md \
		md/end_matter.md \
		md/ref_loc.md 

