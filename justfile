# Project name.
proj := 'lerea'
# Intermediate file directory.
intermediate := 'docs/'
# Directory containing production files.
dist := 'site'
# Branch to push production files to.
dist-branch := 'gh-pages'

# Serve the web site.
serve: relink
    pdm run mkdocs serve

# Compile the web site.
build: relink
    pdm run mkdocs build

# Convert wikilinks to CommonMark links.
relink:
    mkdir -p {{quote(intermediate)}}
    obsidian-export {{quote(proj)}} {{quote(intermediate)}}

# Deploy the project.
deploy: build && clean
    git add .
    git stash push
    git add --force {{quote(dist)}}
    git commit --allow-empty-message --message ''
    git subtree split --prefix {{quote(dist)}} --branch {{dist-branch}}
    git push --force origin {{dist-branch}}:{{dist-branch}}
    git reset HEAD~
    git branch -D {{dist-branch}}
    git stash pop

# Clean up.
clean:
    rm -rf {{quote(intermediate)}} {{quote(dist)}}
