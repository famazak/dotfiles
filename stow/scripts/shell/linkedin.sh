#!/bin/bash

# Usage: linkedin.sh ${name of recruiter} | pbcopy
# automates getting back to recruiters when I'm not looking for a job.

if [ $# -eq 0 ]; then
    echo "Usage: $0 \"Recruiter Name\""
    echo "Example: $0 \"Sarah Johnson\" | pbcopy"
    exit 1
fi

RECRUITER_NAME="$1"

cat << EOF
Hi ${RECRUITER_NAME},

Thank you for reaching out.

I'm not actively looking for new opportunities at the moment, but I'd be happy to connect and keep you in mind for future possibilities that might be a better fit.

Best of luck with your search.

Best regards,
Zak Fama
EOF
