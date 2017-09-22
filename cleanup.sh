#!/bin/sh

#************************ATTENTION*************************
#Please step the revision number when the script is updated
#R1A01    090222017   theofanis.pispirigkos   Initial draft
#
# output logs can be found at: /var/log/syslog

PROGNAME=`basename $0`
REVISION=R1A01

LOGGER_BIN=$(which logger)

JENKINS_HOME=/var/lib/jenkins
JENKINS_WORKSPACE=$JENKINS_HOME/workspace

# log script execution
$LOGGER_BIN -si -t $PROGNAME [info] called at `date -u`

# find dangling images
DANGLING_IMAGES=$(docker image ls  | grep "<none>" | awk '{print $3}' | xargs)

# log the dangling images to delete
for IMAGE_ID in $DANGLING_IMAGES; do
    $LOGGER_BIN -si -t $PROGNAME  "[delete]       IMAGE ID <$IMAGE_ID>"
done

# delete dangling images
docker image rm --force $DANGLING_IMAGES 2>/dev/null
$LOGGER_BIN -si -t $PROGNAME [info] "All images deleted"

# clean workspace
$LOGGER_BIN -si -t $PROGNAME [info] "Cleaning workspace"

# if jenkins workspace exists
if [ -d $JENKINS_WORKSPACE ]; then

    # go to jenkins workspace
    cd $JENKINS_WORKSPACE

    # delete any folder except maven-repo
    for dir in ./*; do
        if [ -d $dir ]; then
           if [ $dir != "./maven-repo" ] && [ $dir != "./maven-repo@tmp" ]; then
              sudo rm -rf $dir
              $LOGGER_BIN -si -t $PROGNAME  "[delete]       $dir"
           fi
        fi
    done

    # return
    cd - > /dev/null
fi

$LOGGER_BIN -si -t $PROGNAME [info] "Workspace folder is cleared"

# log script completion
$LOGGER_BIN -si -t $PROGNAME [info] exiting at `date -u`

