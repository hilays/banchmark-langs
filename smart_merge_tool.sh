#!/bin/bash

clear
echo "🔄 Fetching latest remote updates..."
git fetch --all --prune

echo
echo "📋 Listing local branches tracking a remote (sorted by creation time):"
tmpfile=$(mktemp)

# שלב 1: בניית טבלת נתונים
while IFS= read -r line; do
    branch=$(echo "$line" | awk '{print $1}')
    upstream=$(echo "$line" | awk '{print $2}')

    # Get first commit hash and timestamp
    first_commit_hash=$(git rev-list --reverse "$branch" | head -n 1)
    timestamp=$(git show -s --format="%ad" --date=iso "$first_commit_hash")
    epoch=$(git show -s --format=%ct "$first_commit_hash")
    diff_files=$(git diff --name-only "$branch" origin/main)
    changes_count=$(echo "$diff_files" | grep -c .)

    printf "%s|%s|%s|%s|%s\n" "$epoch" "$branch" "$first_commit_hash" "$timestamp" "$changes_count" >> "$tmpfile"
done < <(git for-each-ref --format='%(refname:short) %(upstream:short)' refs/heads | awk '$2 ~ /^origin\//')

if [ ! -s "$tmpfile" ]; then
    echo "❌ No branches tracking origin found."
    rm "$tmpfile"
    exit 1
fi

# שלב 2: מיון לפי זמן והצגה
branches=()
i=1
echo
sort -r -n "$tmpfile" | while IFS="|" read -r epoch branch hash timestamp changes_count; do
    printf "%2d. %-45s ⏱ %s  🆔 %s  📁 %2s files changed\n" $i "$branch" "$timestamp" "${hash:0:8}" "$changes_count"
    branches+=("$branch")
    echo "$branch" >> "${tmpfile}_branches"
    ((i++))
done

echo
read -p "📌 Enter branch numbers to merge (e.g., 1 3 4): " -a selected

mapfile -t sorted_branches < "${tmpfile}_branches"

for index in "${selected[@]}"; do
    branch=${sorted_branches[$((index-1))]}
    if [ -z "$branch" ]; then
        echo "⚠️  Invalid selection: $index. Skipping."
        continue
    fi

    echo
    echo "➡️  Checking out branch: $branch"
    git checkout "$branch" || continue

    echo "🔄 Merging origin/main into $branch..."
    git merge origin/main

    if [ $? -ne 0 ]; then
        echo "⚠️  Merge conflict detected in $branch."

        echo
        echo "Choose conflict resolution strategy:"
        echo "1) Keep ALL your changes (ours)"
        echo "2) Keep ALL from main (theirs)"
        read -p "Choose [1/2]: " resolution

        if [ "$resolution" == "1" ]; then
            git checkout --ours .
            msg="Resolved conflicts using OURS"
        elif [ "$resolution" == "2" ]; then
            git checkout --theirs .
            msg="Resolved conflicts using THEIRS"
        else
            echo "❌ Invalid input. Skipping branch $branch."
            continue
        fi

        git add .
        git commit -m "Merged origin/main into $branch – $msg"
    else
        echo "✅ Merge completed with no conflicts."
    fi

    echo
    read -p "🚀 Push updated branch '$branch' to GitHub? (y/n): " do_push
    if [[ "$do_push" == "y" ]]; then
        git push
        echo "📤 Branch '$branch' pushed successfully."
    else
        echo "⏭️  Skipped pushing branch '$branch'."
    fi

    echo "------------------------------------------------------------"
done

rm "$tmpfile" "${tmpfile}_branches"
echo
echo "🎉 Done processing selected branches."
