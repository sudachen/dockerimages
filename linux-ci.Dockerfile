FROM  sudachen/linux:latest
LABEL maintainer="Alexey Sudachen <alexey@sudachen.name>"

USER root
RUN curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > /usr/local/bin/cc-test-reporter && \
    chmod +x /usr/local/bin/cc-test-reporter

USER $USER
CMD ["/bin/bash"]
