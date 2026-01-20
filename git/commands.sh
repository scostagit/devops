#!/bin/bash
# ============================================
# Git Commands Cheat Sheet with Explanations
# ============================================

# --- Git Configuration ---
git config --list                              # Show all current Git configurations
git config --global user.name "sergio"         # Set global username
git config --global user.email "sergio@test.com" # Set global email
git config --global core.editor vim            # Set default editor to vim
git config --global init.defaultBranch main    # Set default branch name to main

# Levels of configuration:
# --global  : Applies to the current user (most common)
# --system  : Applies to all users on the system
# (project) : Applies only to the current repository

# --- Git Log ---
git log -p file.txt   # Show commit history and patch for file.txt

# --- Rollback Commits ---
git log                      # Get commit history (to find commit id)
git checkout [commit-id]     # Check out a specific commit
git reset --soft HEAD~1      # Reset last commit but keep changes staged
git reset --hard             # Reset to last commit and discard all changes

# --- Branch Management ---
git branch feature/new_files # Create a new branch
git checkout -b feature/new_file # Create AND switch to a new branch

# Rename branch
git branch -m [new_name]     # Rename current branch

# Delete branch
git checkout main            # Switch to main branch before deleting
git branch -d [branch_name]  # Delete branch (only if merged)
git branch -D [branch_name]  # Force delete branch (even if not merged)

# --- Merge ---
# Merge new_branch into master (pull request flow)
git checkout master
git merge [new_branch]

# Merge latest master into your branch
git merge origin/master

# --- Rebase ---
# Rebase applies commits from your branch on top of another branch
#  WARNING: Do NOT rebase master branch
git rebase master

# --- Cherry-pick ---
# Apply a specific commit from another branch without merging
git checkout -b hotfix        # Create a hotfix branch
echo "fix" > fix.txt          # Example change
# (Assume commit hash is 4567467676)
git checkout feature
git cherry-pick 4567467676    # Apply that specific commit into feature branch

# --- Git Tags ---
git tag                      # List all tags
git checkout master
git tag -a v2.0 -m "version 2"   # Create annotated tag v2.0 on current commit
git tag -a v1.0 -m "version 1" [commit-id]  # Create tag for a past commit
git tag -d v2.0              # Delete tag v2.0

# --- Git Remote (GitHub) ---
ssh-keygen -t rsa -b 2048    # Generate SSH key pair (needed for GitHub authentication)

# --- Git Fetch & Diff ---
git fetch origin             # Fetch changes from remote without merging
git diff main origin/main    # Show difference between local main and remote main

# --- Git Log Variations ---
git log                      # Full commit history
git log main.txt             # Commit history for a specific file
git log --oneline            # Short commit history (1 line per commit)
git log --stat               # Show which files were added/removed/modified
git log -p                   # Show changes in each commit (patch format)
git log -n 2                 # Show last 2 commits
git log -n 5                 # Show last 5 commits
git log --graph              # Show branch/merge history as ASCII graph
git log --graph --oneline    # Graph + one-line summary per commit
git log --author="username"  # Show commits by specific author
git log --after="1 week ago" # Show commits after a specific date
