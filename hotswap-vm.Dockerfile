FROM debian:bullseye-slim

LABEL maintainer="hotswapagent.org" description="TravaOpenJDK 8 (DCEVM) + HotswapAgent"

# Environment Variables
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH=$PATH:$JAVA_HOME/bin
ENV HOTSWAP_AGENT_VERSION=2.0.1
ENV AGENT_DIR=/opt/hotswap-agent
ENV AGENT_JAR=${AGENT_DIR}/hotswap-agent.jar

# 1. Install dependencies
# 2. Install TravaOpenJDK 8 (DCEVM)
# 3. Install Hotswap Agent 2.0.1
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    tar \
    unzip \
    && mkdir -p /opt/java \
    && curl -fL -o /tmp/java.tar.gz "https://github.com/TravaOpenJDK/trava-jdk-8-dcevm/releases/download/dcevm8u282b08/java8-openjdk-dcevm-linux.tar.gz" \
    && tar -xf /tmp/java.tar.gz -C /opt/java \
    && rm /tmp/java.tar.gz \
    # Dynamically find the extracted folder and move to predictable path
    && EXTRACTED_DIR=$(find /opt/java -maxdepth 1 -mindepth 1 -type d) \
    && mv "$EXTRACTED_DIR" ${JAVA_HOME} \
    && mkdir -p ${AGENT_DIR} \
    && curl -fL -o ${AGENT_JAR} "https://github.com/HotswapProjects/HotswapAgent/releases/download/RELEASE-${HOTSWAP_AGENT_VERSION}/hotswap-agent-${HOTSWAP_AGENT_VERSION}.jar" \
    # Cleanup to keep image slim
    && apt-get purge -y --auto-remove \
    && rm -rf /var/lib/apt/lists/*

ENV HOTSWAP_AGENT_PATH=${AGENT_JAR}