FROM alpine:3.12.0
LABEL maintainer="isaac.gittins@amaysim.com.au"

RUN apk --no-cache add python3 bash git jq gettext make nodejs npm py3-pip curl groff shellcheck

RUN pip3 install --no-cache-dir --upgrade pip
RUN pip3 install --no-cache-dir cfn-lint cfn-flip yamllint stacker awscli python-dateutil==2.8.0 jinja2 pyyaml

RUN cfn-lint -u

RUN mkdir -p /tmp/yarn && \
  mkdir -p /opt/yarn/dist && \
  cd /tmp/yarn && \
  wget -q https://yarnpkg.com/latest.tar.gz && \
  tar zvxf latest.tar.gz && \
  find /tmp/yarn -maxdepth 2 -mindepth 2 -exec mv {} /opt/yarn/dist/ \; && \
  rm -rf /tmp/yarn

RUN ln -sf /opt/yarn/dist/bin/yarn /usr/local/bin/yarn && \
  ln -sf /opt/yarn/dist/bin/yarn /usr/local/bin/yarnpkg && \
  yarn --version
RUN yarn global add aws-cdk typescript ts-node

WORKDIR /mnt/src
ENTRYPOINT [ "/bin/bash" ]
