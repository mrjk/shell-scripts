#!/bin/bash


# Command line args
# os exec debian:8|centos:7


# os create <debian>-<prj> <os> <save root dir>
# os start <debian>-<prj> (survive reboot)
# os connect <debian>-<prj> (does not survive reboot)
# os stop <debian>-<prj> (survive reboot)
# os destroy <debian>-<prj>


### -v /host/directory:/container/directory

#if true; then
#  OPTS="${HOME}:"

# This spawn a simple docker without persistance

OS=${1:-debian}
exec docker run --rm -i -t  ${OS} /bin/bash


# This spwan a permanent VM

#docker run -i -t  debian /bin/bash

