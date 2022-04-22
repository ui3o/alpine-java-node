FROM alpine:3.15.1
LABEL authors="ui3o.com"

RUN apk add coreutils bash wget curl git nodejs npm util-linux maven openjdk17 openjdk8 openjdk11

# set jdk11 as default java
ENV JAVA_HOME=/usr/lib/jvm/default-jvm
RUN ln -nsf /usr/lib/jvm/java-11-openjdk/ /usr/lib/jvm/default-jvm

# maven-3.8.3 setup
ENV M2_HOME=/usr/share/java/maven-3
ENV MAVEN_HOME=/usr/share/java/maven-3
ENV PATH=${M2_HOME}/bin:${PATH}

# install gitlab-release-note-generator
RUN git clone https://github.com/ui3o/gitlab-release-note-generator.git /opt/gitlab-release-note-generator && cd /opt/gitlab-release-note-generator &&  npm i

COPY boot /bin
COPY .bashrc /root/

ENTRYPOINT ["/bin/boot"]
 
