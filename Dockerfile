FROM python:3.9-alpine
LABEL maintainer="isaac.gittins@amaysim.com.au"

RUN apk update && apk upgrade && apk --no-cache add bash git jq gettext make nodejs npm curl groff openssl

RUN pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir wheel && \
    pip3 install --no-cache-dir cfn-lint==0.62.0 cfn-flip yamllint stacker awscli python-dateutil==2.8.0 jinja2 pyyaml shellcheck-py

# Disable until CFN Defs Spec >= 86 resolves AWS::RDS::DBCluster Attributes spec issue
# RUN cfn-lint -u

RUN mkdir -p /tmp/yarn && \
  mkdir -p /opt/yarn/dist && \
  cd /tmp/yarn && \
  wget -q https://yarnpkg.com/latest.tar.gz && \
  tar zvxf latest.tar.gz && \
  find /tmp/yarn -maxdepth 2 -mindepth 2 -exec mv {} /opt/yarn/dist/ \; && \
  cd /tmp && \
  rm -rf /tmp/yarn && \
  ln -sf /opt/yarn/dist/bin/yarn /usr/local/bin/yarn && \
  ln -sf /opt/yarn/dist/bin/yarn /usr/local/bin/yarnpkg && \
  yarn --version && \
  yarn global add aws-cdk typescript ts-node

WORKDIR /mnt/src
ENTRYPOINT [ "/bin/bash" ]
