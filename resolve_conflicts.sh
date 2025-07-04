#!/bin/bash

echo "⚠️  Merge conflict detected."
echo "Do you want to accept:"
echo "1) All changes from YOUR branch (ours)"
echo "2) All changes from MAIN branch (theirs)"
read -p "Enter 1 or 2: " choice

if [ "$choice" == "1" ]; then
    echo "✅ Resolving conflicts using OUR changes (your branch)..."
    git checkout --ours .
elif [ "$choice" == "2" ]; then
    echo "✅ Resolving conflicts using THEIRS changes (main branch)..."
    git checkout --theirs .
else
    echo "❌ Invalid choice. Exiting."
    exit 1
fi

# Add all resolved files
git add .

# Commit the result
git commit -m "Resolved merge conflicts using $( [ "$choice" == "1" ] && echo "OURS (feature branch)" || echo "THEIRS (main branch)" )"

# Push to remote
git push

echo "🚀 Done. Conflicts resolved and pushed to remote branch."
