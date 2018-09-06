#!/bin/bash
set -x

apt-get update
apt-get -y install docker.io ansible unzip golang-go vim

usermod -G docker ubuntu

pip install -U pip 
# https://stackoverflow.com/questions/1763156/127-return-code-from
if [[ $? == 127 ]]; then
    wget -q https://bootstrap.pypa.io/get-pip.py
    python get-pip.py
fi

pip install -U awscli
pip install -U awsebcli

TERRAFORM_VERSION="0.11.8"
PACKER_VERSION="1.2.5"

terraform_version=$(terraform -v | head -1 | cut -d ' ' -f 2 | tail -c +2)
# https://www.linuxnix.com/pipestatus-internal-variable/
t_retval=${PIPESTATUS[0]}

[[ $terraform_version != $TERRAFORM_VERSION ]] || [[ $t_retval != 0 ]] \
&& wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
&& unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin \
&& rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

packer_version=$(packer -v)
p_retval=$?

[[ $packer_version != $PACKER_VERSION ]] || [[ $p_retval != 1 ]] \
&& wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
&& unzip -o packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin \
&& rm packer_${PACKER_VERSION}_linux_amd64.zip
