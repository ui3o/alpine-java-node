#!/bin/bash
source /root/.bashrc

set -e

if [ $CONTAINER_DEBUG ]; then
    set -x
fi

if [ $BOOT_GITREPO ]; then

    ## BOOT_GITREPO path find
    cd /
    BOOT_GITREPO_PATH="${BOOT_GITREPO##*/}"
    BOOT_GITREPO_PATH="/${BOOT_GITREPO_PATH%%.git}"

    ## export BOOT_GITREPO to /etc/bashrc
    grep -qF -- "export BOOT_GITREPO=$BOOT_GITREPO" "/etc/bashrc" || echo "BOOT_GITREPO=$BOOT_GITREPO" >> "/etc/bashrc"
    grep -qF -- "export BOOT_GITREPO_PATH=$BOOT_GITREPO_PATH" "/etc/bashrc" || echo "BOOT_GITREPO_PATH=$BOOT_GITREPO_PATH" >> "/etc/bashrc"

    ## remove old repo and links
    rm -rf $BOOT_GITREPO_PATH

    ## setup boot repo
    git clone $BOOT_GITREPO
    
    ## npm init if boot repo has npm scripts
    if test -f "$BOOT_GITREPO_PATH/package.json"; then
        cd $BOOT_GITREPO_PATH
        npm i --legacy-peer-deps
        cd /
    fi
    
    ## add boot repo to path
    export PATH=${BOOT_GITREPO_PATH}:${PATH}
fi

if [ $JAVA_VERSION -a $JAVA_VERSION == 8 ]; then
    ln -nsf /usr/lib/jvm/java-1.8-openjdk/ /usr/lib/jvm/default-jvm
fi

if [ $JAVA_VERSION -a $JAVA_VERSION == 11 ]; then
    ln -nsf /usr/lib/jvm/java-11-openjdk/ /usr/lib/jvm/default-jvm
fi

if [ $JAVA_VERSION -a $JAVA_VERSION == 17 ]; then
    ln -nsf /usr/lib/jvm/java-17-openjdk/ /usr/lib/jvm/default-jvm
fi
exec "$@"
