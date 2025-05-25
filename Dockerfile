FROM python:3.10-slim

# Εγκατάσταση βασικών εργαλείων και εξαρτήσεων του SageMath
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    ca-certificates \
    gnupg \
    lsb-release \
    dpkg-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Προσθήκη του SageMath PPA (10.6)
RUN echo "deb http://ppa.launchpad.net/aims/sagemath/ubuntu jammy main" > /etc/apt/sources.list.d/sagemath.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 9F0FE587374EBBE8 && \
    apt-get update && apt-get install -y sagemath && \
    rm -rf /var/lib/apt/lists/*

# Δημιουργία φακέλου app και αντιγραφή των αρχείων
WORKDIR /app
COPY . /app

# Εγκατάσταση Voilà, ipywidgets, κλπ, μέσω του SageMath pip
RUN sage -pip install --upgrade pip && \
    sage -pip install voila ipywidgets jupyterlab

# Πόρτα Voilà
EXPOSE 8888

# Εκκίνηση της εφαρμογής με Voilà (για SageMath notebook)
CMD ["sage", "-python", "-m", "voila", "--port=8888", "--no-browser", "--Voila.ip=0.0.0.0", "find-roots.ipynb"]
