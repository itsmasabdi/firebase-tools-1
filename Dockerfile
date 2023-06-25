FROM node:16

# install python 3.11.4 - required for firebase python functions support
RUN apt-get install libssl-dev openssl && \
  wget https://www.python.org/ftp/python/3.11.4/Python-3.11.4.tgz && \
  tar -xvf Python-3.11.4.tgz && cd Python-3.11.4 && \
  ./configure && make && make install 

ENV NODE_PATH=/usr/local/lib/node_modules

LABEL com.github.actions.name="GitHub Action for Firebase"
LABEL com.github.actions.description="Wraps the firebase-tools CLI to enable common commands."
LABEL com.github.actions.icon="package"
LABEL com.github.actions.color="gray-dark"

ARG FIREBASE_VERSION=12.4.0
RUN npm i -g firebase-tools@${FIREBASE_VERSION}

COPY LICENSE README.md /
COPY "entrypoint.sh" "/entrypoint.sh"

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]
