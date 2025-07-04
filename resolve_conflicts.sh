#!/bin/bash

echo "🔄 Fetching all remote branches..."
git fetch --all --prune

echo "🔍 Checking for local branches that track origin..."
tracked_branches=$(git for-each-ref --format='%(refname:short) %(upstream:short)' refs/heads | awk '$2 ~ /^origin\// {print $1}')

if [ -z "$tracked_branches" ]; then
    echo "❌ No local branches tracking origin found."
    exit 1
fi

echo
echo "📋 Found the following local branches tracking remote:"
echo

for branch in $tracked_branches; do
    # Get timestamp of first commit (branch creation)
    creation_date=$(git log --reverse --format="%ad" --date=local "$branch" | head -n 1)

    echo "🔹 $branch (created on $creation_date)"

    # Check for differences vs main
    diff_files=$(git diff --name-only "$branch" origin/main)
    if [ -n "$diff_files" ]; then
        echo "    🧾 Files different from origin/main:"
        echo "$diff_files" | sed 's/^/      - /'
    else
        echo "    ✅ No difference from origin/main."
    fi

    echo
done

echo "🧭 Choose a branch to merge origin/main into:"
read -p "Enter branch name exactly as shown above: " selected_branch

if ! git rev-parse --verify "$selected_branch" >/dev/null 2>&1; then
    echo "❌ Branch '$selected_branch' not found."
    exit 1
fi

echo "📍 Switching to $selected_branch"
git checkout "$selected_branch"

echo "🔄 Merging origin/main into $selected_branch..."
git merge origin/main

if [ $? -ne 0 ]; then
    echo "🧨 Merge conflict detected!"

    echo
    echo "Choose conflict resolution strategy:"
    echo "1) Accept ALL changes from your branch ($selected_branch) [ours]"
    echo "2) Accept ALL changes from origin/main [theirs]"
    read -p "Enter 1 or 2: " resolution

    if [ "$resolution" == "1" ]; then
        echo "✅ Resolving using YOUR branch changes (ours)..."
        git checkout --ours .
    elif [ "$resolution" == "2" ]; then
        echo "✅ Resolving using MAIN branch changes (theirs)..."
        git checkout --theirs .
    else
        echo "❌ Invalid choice. Exiting."
        exit 1
    fi

    git add .
    git commit -m "Merged origin/main into $selected_branch with '${resolution}' conflict resolution"
else
    echo "✅ Merge completed with no conflicts."
fi

echo
read -p "🚀 Do you want to push '$selected_branch' to GitHub? (y/n): " push_confirm
if [[ "$push_confirm" == "y" ]]; then
    git push
    echo "📤 Pushed to origin/$selected_branch"
else
    echo "🛑 Push skipped."
fi
