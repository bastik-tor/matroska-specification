$(info RFC rendering has been tested with mmark version 1.3.4 and xml2rfc 2.5.1, please ensure these are installed and recent enough.)

all: draft-lhomme-cellar-matroska-00.html draft-lhomme-cellar-matroska-00.txt

draft-lhomme-cellar-matroska-00.html: index.md
	xsltproc transforms/ebml_schema2markdown4rfc.xsl ebml_matroska.xml > ebml_matroska_elements4rfc.md
	cat rfc_frontmatter.md "$<" matroska_schema_section_header.md ebml_matroska_elements4rfc.md notes.md order_guidelines.md codec_specs.md chapters.md subtitles.md tagging.md cover_art.md streaming.md menu.md overhead.md | grep -v '^layout:\|^---\b' > merged.md
	mmark -xml2 -page merged.md > draft-lhomme-cellar-matroska-00.xml
	xml2rfc --html draft-lhomme-cellar-matroska-00.xml -o "$@"

draft-lhomme-cellar-matroska-00.txt: index.md
	xsltproc transforms/ebml_schema2markdown4rfc.xsl ebml_matroska.xml > ebml_matroska_elements4rfc.md
	cat rfc_frontmatter.md "$<" matroska_schema_section_header.md ebml_matroska_elements4rfc.md notes.md order_guidelines.md codec_specs.md chapters.md subtitles.md tagging.md cover_art.md streaming.md menu.md overhead.md | grep -v '^layout:\|^---\b' > merged.md
	mmark -xml2 -page merged.md > draft-lhomme-cellar-matroska-00.xml
	xml2rfc draft-lhomme-cellar-matroska-00.xml -o "$@"

ebml_matroska_elements.md: ebml_matroska.xml
	xsltproc transforms/ebml_schema2markdown.xsl "$<" > ebml_matroska_elements.md

clean:
	rm -f draft-lhomme-cellar-matroska-00.txt draft-lhomme-cellar-matroska-00.html merged.md draft-lhomme-cellar-matroska-00.xml ebml_matroska_elements.md ebml_matroska_elements4rfc.md
