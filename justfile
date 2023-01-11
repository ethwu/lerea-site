

# Serve the web site.
serve: relink
    pdm run mkdocs serve

# Compile the web site.
build: relink
    pdm run mkdocs build

# Convert wikilinks to CommonMark links.
relink:
    obsidian-export lerea docs/
