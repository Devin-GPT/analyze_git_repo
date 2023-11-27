#!/bin/bash

# Check if git is installed
if ! command -v git &> /dev/null
then
    echo "git could not be found, please install git"
    exit
fi

# Ensure a repository path is given
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /path/to/git/repo"
    exit 1
fi

REPO_PATH=$1

# Change to the repository directory
cd "$REPO_PATH" || { echo "Repository not found"; exit 1; }

# Generating the report
echo "Git Analysis Report" > git_report.txt
echo "===================" >> git_report.txt
echo "" >> git_report.txt

# List of contributors
echo "Contributors:" >> git_report.txt
git log --format='%aN <%aE>' | sort -u >> git_report.txt
echo "" >> git_report.txt

# Commit range for each contributor
echo "Commit Range per Contributor:" >> git_report.txt
for contributor in $(git log --format='%aN' | sort -u); do
    echo "$contributor:" >> git_report.txt
    first_commit=$(git log --author="$contributor" --reverse --format="%ai" | head -1)
    last_commit=$(git log --author="$contributor" --format="%ai" | head -1)
    echo "  From: $first_commit" >> git_report.txt
    echo "  To: $last_commit" >> git_report.txt
    echo "" >> git_report.txt
done

# Number of commits per contributor
echo "Number of Commits per Contributor:" >> git_report.txt
git shortlog -sn --all >> git_report.txt
echo "" >> git_report.txt

# Amount of change over time
echo "Amount of Change Over Time (Commits per Month):" >> git_report.txt
git log --format='%ai' | cut -d '-' -f 1,2 | sort | uniq -c >> git_report.txt
echo "" >> git_report.txt

# Additional metadata
echo "Additional Metadata:" >> git_report.txt
echo "Total Number of Commits: $(git rev-list --all --count)" >> git_report.txt
echo "Total Number of Files: $(git ls-tree -r --name-only HEAD | wc -l)" >> git_report.txt
echo "Repository Size: $(du -sh)" >> git_report.txt

# End of the report
echo "Report generated on $(date)" >> git_report.txt

# Display the report
cat git_report.txt
