FROM mcr.microsoft.com/playwright:focal
USER root
RUN apt-get update
RUN apt-get install -y python3-pip
USER pwuser
RUN pip3 install --user robotframework
RUN pip3 install --user robotframework-browser
RUN ~/.local/bin/rfbrowser init
ENV NODE_PATH=/usr/lib/node_modules
ENV PATH="/home/pwuser/.local/bin:${PATH}"
COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt
COPY data /skill-collector-1.0-test-automation/data
COPY scripts /skill-collector-1.0-test-automation/scripts
WORKDIR /skill-collector-1.0-test-automation