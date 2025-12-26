FROM jaov/hotswap-trava-8

LABEL maintainer="hotswapagent.org"

ENV TOMCAT_MAJOR=9
ENV TOMCAT_VERSION=9.0.113
ENV INSTALL_DIR=/opt
ENV CATALINA_HOME=${INSTALL_DIR}/apache-tomcat-${TOMCAT_VERSION}
ENV PATH=${CATALINA_HOME}/bin:${PATH}

# Download Tomcat 9.0.113 Zip, Unzip, and fix permissions
RUN curl -fL -o /tmp/tomcat.zip "https://downloads.apache.org/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.zip" \
    && unzip /tmp/tomcat.zip -d ${INSTALL_DIR} \
    && rm /tmp/tomcat.zip \
    && chmod +x ${CATALINA_HOME}/bin/*.sh

# HotswapAgent Configuration for TravaOpenJDK
# (Native Glibc means we don't need to disable any Tomcat listeners)
ENV CATALINA_OPTS="-javaagent:${HOTSWAP_AGENT_PATH}=autoHotswap=true"

WORKDIR ${CATALINA_HOME}
EXPOSE 8080

CMD ["catalina.sh", "run"]