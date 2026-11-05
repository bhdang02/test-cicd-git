FROM debian:10

LABEL purpose="scanner-test-image" \
      warning="INTENTIONALLY VULNERABLE - test fixture only, do not deploy"

RUN echo "deb http://archive.debian.org/debian buster main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security buster/updates main contrib non-free" >> /etc/apt/sources.list && \
    apt-get -o Acquire::Check-Valid-Until=false update && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-dev \
	python3-setuptools \
        gcc \
        libjpeg-dev \
        zlib1g-dev \
        libyaml-dev \
        nodejs \
        npm \
        curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

COPY package.json .
RUN npm install --no-audit --no-fund || true

CMD ["sleep", "infinity"]
