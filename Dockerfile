#FROM image-registry.openshift-image-registry.svc:5000/openshift/jenkins@sha256:81dc3755056f60a34693121d0da1e93deaaf00d86a72a6a2e5e259a7a09c881c as jenkins
#FROM image-registry.openshift-image-registry.svc:5000/openshift/jenkins@sha256:e0a054d0a2e3088eb9ac6c65149fec386fefcf2aacc7181fa806cf2fad190a4c as jenkins
#FROM quay.io/openshift/origin-jenkins@sha256:ed8605f19d17ce84e78aaaac932a347b24ffcd1827d73258ff5628d6366d16df as jenkins
FROM registry.redhat.io/openshift4/ose-jenkins-agent-base as base

USER root
#RUN yum install -y jenkins-plugin-openshift openshift-origin-cartridge-jenkins
COPY run_ucb.sh /usr/local/bin/run.sh
#RUN cp -p /usr/libexec/s2i/run /usr/libexec/s2i/run.orig
#RUN rm -f /usr/libexec/s2i/run
#COPY run_ucb.sh /usr/libexec/s2i/run
#RUN chmod 755 /usr/libexec/s2i/run
RUN chmod 755 /usr/local/bin/run.sh
# install RVM, Ruby, and Bundler
RUN yum update
RUN yum install ruby
#RUN gpg2 --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
#RUN curl -sSL https://get.rvm.io | bash -s
#RUN /bin/bash -l -c ". /etc/profile.d/rvm.sh && rvm install 2.3.3"

WORKDIR /usr/lib/jenkins/
RUN rm -f jenkins.war && \
    wget --quiet --no-check-certificate https://updates.jenkins.io/download/war/2.303.3/jenkins.war


VOLUME ["/var/lib/jenkins"]

USER 1001
CMD /usr/local/bin/run.sh
