FROM swift:3.1

# Install a few needed packages that aren't in swiftdocker/swift
RUN apt-get -q update && \
    apt-get -q install -y libz-dev unzip

# Install protoc
RUN curl -O -L https://github.com/google/protobuf/releases/download/v3.2.0/protoc-3.2.0-linux-x86_64.zip && \
    unzip protoc-3.2.0-linux-x86_64.zip -d /usr

# Build and install the swiftgrpc plugin
WORKDIR /tmp/grpc-build
RUN git clone https://github.com/grpc/grpc-swift && \
    cd grpc-swift/Plugin && \
    git checkout 0c73d72 && \
    make && \
    cp protoc-gen-swift /usr/bin && \
    cp protoc-gen-swiftgrpc /usr/bin

WORKDIR /
RUN rm -r /tmp/grpc-build
