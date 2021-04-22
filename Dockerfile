#ARG BASE_REGISTRY=nexus-docker-secure.levelup-nexus.svc.cluster.local:18082
#ARG BASE_IMAGE=opensource/maven/maven-openjdk-11
#ARG BASE_TAG=3.8.1
#FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}
FROM registry1.dso.mil/ironbank/redhat/openjdk/openjdk11:latest
USER root

ENV JENKINS_UC https://updates.jenkins.io
ENV CASC_JENKINS_CONFIG /usr/share/jenkins/ref/casc
ENV JENKINS_PM_VERSION 2.5.0
ENV JENKINS_PM_URL https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/${JENKINS_PM_VERSION}/jenkins-plugin-manager-${JENKINS_PM_VERSION}.jar

RUN mkdir -p /usr/share/jenkins/ /app/
COPY ./prebuild/app /app
COPY ./prebuild/usr /usr/share/jenkins

VOLUME /build
VOLUME /usr/share/jenkins/ref/casc

ENTRYPOINT ["/app/bin/jenkinsfile-runner-launcher"]
