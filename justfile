# Project name.
proj := 'lerea'
# Intermediate directory containing relinked files.
intermediate := 'docs'
# Directory to inject into the intermediate directory.
inject := 'inject'
# Directory containing production files.
dist := 'site'
# Branch to push production files to.
dist-branch := 'gh-pages'

# Serve the web site.
serve: _relink
    pdm run mkdocs serve

# Compile the web site.
build: _relink
    pdm run mkdocs build

# Relink files.
_relink: clean
    mkdir -p {{quote(intermediate)}}
    rsync -av --exclude='.*' {{quote(proj)}}/* {{quote(intermediate)}}
    rsync -av {{quote(inject)}}/* {{quote(intermediate)}}

# Update the sources.
update:
    git submodule update --recursive --remote {{quote(proj)}}

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
