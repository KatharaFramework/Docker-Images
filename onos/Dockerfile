FROM kathara/core:latest

# Set non-interactive to avoid apt prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Update repositories and install dependencies
# Refinement: Replaced python2 with python3 as python2 is deprecated in modern Ubuntu/Debian bases used by Kathará.
# Note: Installing Temurin Java 11 from Eclipse Adoptium because Debian 12 (Bookworm), because kathara latest image is on debian 12
# dropped openjdk-11-jdk, and older ONOS versions strictly require Java 11 to build.
# We temporarily add the Debian 11 (Bullseye) repository to install Python 2 
# because Bazel's rules_python explicitly checks for a real Python 2 interpreter.
RUN echo "deb http://deb.debian.org/debian bullseye main" > /etc/apt/sources.list.d/bullseye.list \
    && apt-get update && apt-get install -y \
    python3 python3-networkx python2 build-essential perl curl wget zip bzip2 \
    screen xterm git apt-transport-https gnupg \
    && rm /etc/apt/sources.list.d/bullseye.list \
    && wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null \
    && echo "deb https://packages.adoptium.net/artifactory/deb bookworm main" > /etc/apt/sources.list.d/adoptium.list \
    && apt-get update && apt-get install -y temurin-11-jdk \
    && rm -rf /var/lib/apt/lists/*

# Download and setup Bazel
RUN wget https://releases.bazel.build/6.0.0/rolling/6.0.0-pre.20220421.3/bazel-6.0.0-pre.20220421.3-linux-x86_64 -O /usr/bin/bazel \
    && chmod +x /usr/bin/bazel

# Define environment variables
ENV ONOS_ROOT=/root/onos-classic
ENV ONOS_USER=onos

# Add ONOS profile to bashrc so new interactive terminals have the 'onos' and 'ok' commands
RUN echo "source \$ONOS_ROOT/tools/dev/bash_profile" >> /root/.bashrc

# Fix: The 'onos' CLI script (tools/test/bin/onos) runs:
#   ssh -p 8101 $OCI "$@"
# without specifying a user, so SSH defaults to 'root'. This SSH config
# ensures port-8101 connections automatically use the 'onos' user.
RUN mkdir -p /root/.ssh && echo "Host *\n  Port 8101\n  User onos" > /root/.ssh/config && chmod 600 /root/.ssh/config

# Clone the custom ONOS repository (dev branch)
RUN git clone https://github.com/bhuiyan-chafi/onos-classic $ONOS_ROOT

# Set the working directory
WORKDIR $ONOS_ROOT

# Compile ONOS during image build
# Note: This will take a while and result in a larger image, but ensures ONOS is ready to run immediately.
RUN bazel build onos && bazel build //:onos-local

# Create a helper script to easily start ONOS
# Refinement: DO NOT override CMD or ENTRYPOINT. Kathará relies on its own internal init process 
# to boot the virtual node and configure its network interfaces. 
# Instead, we create a script that users can call from their Kathará `<node>.startup` files.
RUN echo '#!/bin/bash\nshopt -s expand_aliases\nsource $ONOS_ROOT/tools/dev/bash_profile\ncd $ONOS_ROOT\nok clean' > /usr/local/bin/start-onos \
    && chmod +x /usr/local/bin/start-onos
