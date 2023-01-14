
dvisvgm_flags := --font-format=WOFF2 --optimize

%.svgz: %.dvi
	dvisvgm $(dvisvgm_flags) --zip=9 $^

%.svg: %.dvi
	dvisvgm $(dvisvgm_flags) $^
	svgo $@ --multipass

%.dvi: %.tex
	latex $^

clean:
	rm -f *.aux *.log *.dvi *.svg *.svgz
