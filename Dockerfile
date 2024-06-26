FROM amazonlinux:2023
LABEL maintainer="isaac.gittins@amaysim.com.au"

COPY ./files/bin/* /usr/local/bin/

RUN dnf -y upgrade && \
    dnf -y --allowerasing install diffutils python3-pip python3-setuptools python3-wheel git jq gettext make nodejs npm curl groff openssl wget tar gzip findutils awscli-2 && \
    dnf clean all

RUN pip3 install --no-cache-dir --upgrade cfn-lint==0.87.6 cfn-flip yamllint stacker jinja2 pyyaml shellcheck-py pylint

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
