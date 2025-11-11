FROM python:3.10

RUN apt update && apt -y install \
  python3-sphinx \
  python3-venv \
  nodejs \
  npm \
  vim \
  git \
  bash

RUN git clone https://github.com/elastx/minio-docs.git
WORKDIR /minio-docs

RUN pip install -r  requirements.txt
RUN npm install
RUN npm run build
RUN make SYNC_SDK=true mindocs

EXPOSE 8000
ENTRYPOINT [ "python", "-m", "http.server", "--directory", "build/main/mindocs/html" ]
#CMD ["/bin/bash"]
