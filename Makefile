ms_word: manuscript.docx

manuscript.docx: md/front_matter.md md/results.md md/methods.md ref/ASW.bib ref/journal-of-applied-ecology.csl ref/temp_ref.docx
	pandoc --reference-doc=ref/temp_ref.docx \
		--from=markdown \
		--to=docx \
		--bibliography=ref/ASW.bib \
		--csl=ref/journal-of-applied-ecology.csl \
		-o manuscript.docx \
		md/front_matter.md \
		md/results.md \
		md/methods.md

