#!/usr/bin/env bash

# QUICK_HACK_SCRIPT to set labels and milestones for a given repo

PROGNAME="setlabels-and-milestones.sh"
NOP=${NOP-}
MILESTONESFILE="milestones.json"
LABELSFILE="labels.json"
REPO=${1-}
GITHUB_ACCESSTOKEN=${GITHUB_ACCESSTOKEN-}
GITHUB_LABEL_SYNC=github-label-sync
GITHUB_SYNC_LABELS_MILESTONES=github-sync-labels-milestones
# default TERM to xterm-256color to
TERM=${TERM-"xterm-256color"}
export TERM
# log_info the given message at the given level. All logs are written to stderr with a timestamp.
function log_base {
    local -r level="$1"
    local -r message="$2"
    local -r timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "${timestamp} ${PROGNAME} [${level}] $(tput bold)$(tput setaf 255)${message}$(tput sgr 0)"
}

# log_info the given message at INFO level. All logs are written to stderr with a timestamp.
function log_info {
  local -r message="$*"
  log_base "$(tput bold)$(tput setaf 190)INFO$(tput sgr 0)" "$message"
}

# log_info the given message at WARN level. All logs are written to stderr with a timestamp.
function log_warn {
  local -r message="$*"
  log_base "$(tput bold)$(tput setaf 220)WARN$(tput sgr 0)" "$message"
}

# log_info the given message at ERROR level. All logs are written to stderr with a timestamp.
function log_error {
  local -r message="$*"
  log_base $(tput bold)$(tput setaf 196)ERROR$(tput sgr 0) "$message"
}

function log_debug {
        if [ ! -z "$DEBUG" ] ; then
                local -r message="$*"
                log_base $(tput bold)$(tput setaf 196)DEBUG$(tput sgr 0) "$message"
        fi
}

log_warn "QUICK_HACK_SCRIPT to set labels and milestones for a given repo"
log_warn "NOTE very limited error checking.  use only if you understand the script"
log_warn "This script will DELETE existing labels and milestones"

$($GITHUB_SYNC_LABELS_MILESTONES -V >/dev/null) 
if [[ $? -ne 0 ]] ;then
    log_error "external prog $GITHUB_SYNC_LABELS_MILESTONES is missing"
    log_info "install via npm install -g github-sync-labels-milestones"
    exit 3
fi 
$($GITHUB_LABEL_SYNC -V &>2) 
if [[ $? -ne 0 ]] ;then
    log_error "external prog $GITHUB_LABEL_SYNC is missing"
    log_info "install via npm install -g github-label-sync"
    exit 3
fi 

if [[ -z "$GITHUB_ACCESSTOKEN" ]] ; then
    log_error "GITHUB_ACCESSTOKEN is missing from env, bailing"
    exit 1    
fi

if [[ -z "$REPO" ]] ; then 
    log_error "usage $PROGNAME (username|org)/github_repo "
    exit 2
fi 

if [[ ! -r "${MILESTONESFILE}" || ! -r "${LABELSFILE}" ]] ; then 
    log_error "Can't read $MILESTONESFILE or $LABELSFILE in $PWD" 
    exit 3
fi
#set -x
TMPDIR=$(mktemp -d /tmp/${PROGNAME}.XXXXXX)
TMPFILE="${TMPDIR}/milestones.json"
jq -c ".[0].repositories[0] = \"$REPO\"" $MILESTONESFILE >$TMPFILE
# this little call stack is to make sure that tmpfile is deleted. (could have been done a lot smarter (tm))
#cat $TMPFILE
#set +x
if [[ $? -eq 0 ]] ; then
    log_info "setting milestones for $REPO"
    $NOP github-sync-labels-milestones -t $GITHUB_ACCESSTOKEN -c $TMPFILE 
    
    if [[ $? -eq 0 ]] ; then 
        log_info "successfully finished setting milestones"
        log_info "setting labels for $REPO"    
        $NOP github-label-sync -a $GITHUB_ACCESSTOKEN -l ./labels.json $REPO
        if [[ $? -eq 0 ]] ; then 
            log_info "successfully finished setting milestones"
        else 
            log_error "failed setting labels"
        fi
    else
        log_error "failed setting milestones"
    fi
else
    log_error "update of temp milestones file $TMPFILE failed"
fi 
#rm "$TMPFILE"
#rmdir "$TMPDIR"
