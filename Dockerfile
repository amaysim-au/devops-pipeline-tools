FROM alpine:latest
LABEL maintainer="isaac.gittins@amaysim.com.au"

RUN apk --no-cache add python3 bash git jq gettext make

RUN pip3 install --no-cache-dir --upgrade pip
RUN pip3 install --no-cache-dir cfn-lint cfn-flip yamllint stacker awscli python-dateutil==2.8.0 jinja2 pyyaml

WORKDIR /mnt/src
ENTRYPOINT [ "/bin/bash" ]
