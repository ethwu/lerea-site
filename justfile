# Project name.
proj := 'lerea'
# Directory containing production files.
dist := 'site'
# Branch to push production files to.
dist-branch := 'gh-pages'

# Serve the web site.
serve:
    pdm run mkdocs serve

# Compile the web site.
build:
    pdm run mkdocs build


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
    rm -rf {{quote(dist)}}
