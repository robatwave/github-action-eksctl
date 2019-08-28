FROM python:3.7-alpine

LABEL "com.github.actions.name"="eksctl"
LABEL "com.github.actions.description"="eksctl is a simple CLI tool for creating clusters on EKS"
LABEL "com.github.actions.icon"="server"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/robatwave/github-actions"
LABEL "homepage"="https://github.com/robatwave/github-actions/tree/master/eksctl"
LABEL "maintainer"="Rob van Oostrum <rvanoostrum@waveapps.com>"

RUN apk add --update --no-cache --virtual .build-deps curl openssl \
    && curl -s -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator \
    && chmod +x /usr/local/bin/aws-iam-authenticator \
    && curl -s -o /tmp/aws-iam-authenticator.sha256 https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator.sha256 \
    && openssl sha1 -sha256 /usr/local/bin/aws-iam-authenticator \
    && curl -s --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp \
    && mv /tmp/eksctl /usr/local/bin \
    && apk del .build-deps

RUN pip3 install --upgrade --user awscli

ENTRYPOINT ["/usr/local/bin/eksctl"]
