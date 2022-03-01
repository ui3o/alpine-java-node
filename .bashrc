# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# normal alias can not call from scripts!

# gitlab-release-note-generator alias
gitlab-release-note-generator()
{
    GITLAB_API_ENDPOINT=$GITLAB_API_ENDPOINT GITLAB_PERSONAL_TOKEN=$GITLAB_PERSONAL_TOKEN GITLAB_PROJECT_ID=$GITLAB_PROJECT_ID TARGET_BRANCH=$TARGET_BRANCH TARGET_TAG_REGEX=$TARGET_TAG_REGEX TZ=$TZ ISSUE_CLOSED_SECONDS=$ISSUE_CLOSED_SECONDS node /opt/gitlab-release-note-generator/app/index.js
}

# script run alias
run()
{
    if [ $CONTAINER_DEBUG ]; then
        set -x
    fi
    CWD_PATH=$(readlink -f $(pwd))
    source $@
    cd $CWD_PATH
    if [ $CONTAINER_DEBUG ]; then
        set +x
    fi
}

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
