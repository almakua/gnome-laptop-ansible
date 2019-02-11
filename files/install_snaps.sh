#!/bin/bash

#############
# script to be used as a workaround until Ansible 2.9 where the snap module is supported
#############

for SNAP in $@
do
    classic_check="$(snap info ${SNAP} | grep stable | grep classic > /dev/null 2>&1; echo $?)"
    beta_check="$(snap info ${SNAP} | grep tracking | grep beta > /dev/null 2>&1; echo $?)"
    install_check="$(snap info ${SNAP} | grep installed > /dev/null 2>&1; echo $?)"
    if [[ "${install_check}" == 1 ]]
    then
        if [[ "${classic_check}" == "0" ]]
        then
            snap install ${SNAP} --classic
        elif [[ "${beta_check}" == "0" ]]
        then
            snap install ${SNAP} --channel beta
        else
            snap install ${SNAP}
        fi
    fi
done