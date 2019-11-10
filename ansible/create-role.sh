#!/bin/bash

#############################################################
#
# $ /bin/bash create-role.sh <role-name>
#
#############################################################

PARENT_DIR=$1

mkdir -p roles/$PARENT_DIR
mkdir -p roles/$PARENT_DIR/defaults
mkdir -p roles/$PARENT_DIR/handlers
mkdir -p roles/$PARENT_DIR/tasks
mkdir -p roles/$PARENT_DIR/vars
mkdir -p roles/$PARENT_DIR/templates
mkdir -p roles/$PARENT_DIR/files

touch roles/$PARENT_DIR/defaults/main.yml
touch roles/$PARENT_DIR/handlers/main.yml
touch roles/$PARENT_DIR/tasks/main.yml
touch roles/$PARENT_DIR/vars/main.yml
