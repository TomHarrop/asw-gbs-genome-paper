today:=$(shell date +%F)

all: ms_word pdf

cover_letter: cover_letter.pdf
response: response.docx
ms_word: compiled/asw-gbs_$(today).docx
pdf: compiled/asw-gbs_$(today).pdf


compiled/asw-gbs_$(today).docx: md/front_matter.md md/abstract.md md/introduction.md md/methods.md md/results.md md/discussion.md md/end_matter.md md/ref_loc.md ref/ASW.yaml ref/insects_doi.csl ref/ref.docx md/si.md
	pandoc \
		--from=markdown \
		--to=docx \
		--reference-doc=ref/ref.docx \
		--bibliography=ref/ASW.yaml \
		--csl=ref/insects_doi.csl \
		-o compiled/asw-gbs_$(today).docx \
		md/front_matter.md \
		md/abstract.md \
		md/introduction.md \
		md/methods.md \
		md/results.md \
		md/discussion.md \
		md/end_matter.md \
		md/ref_loc.md \
		md/si.md

compiled/asw-gbs_$(today).pdf: md/front_matter.md md/abstract.md md/introduction.md md/methods.md md/results.md md/discussion.md md/end_matter.md md/ref_loc.md ref/ASW.yaml ref/insects_doi.csl ref/header.tex md/si.md
	pandoc \
		--from=markdown \
		--to=latex \
		--pdf-engine=xelatex \
		--include-in-header=ref/header.tex \
		--bibliography=ref/ASW.yaml \
		--csl=ref/insects_doi.csl \
		-o compiled/asw-gbs_$(today).pdf \
		md/front_matter.md \
		md/abstract.md \
		md/introduction.md \
		md/methods.md \
		md/results.md \
		md/discussion.md \
		md/end_matter.md \
		md/ref_loc.md \
		md/si.md


cover_letter.pdf: md/cover_letter.md
	pandoc \
		--from=markdown \
		--to=latex \
		--pdf-engine=xelatex \
		--include-in-header=ref/header.tex \
		-o cover_letter.pdf \
		md/cover_letter.md
		
response.docx: md/response.md
	pandoc \
		--from=markdown \
		--to=docx \
		--reference-doc=ref/ref.docx \
		-o response.docx \
		md/response.md
