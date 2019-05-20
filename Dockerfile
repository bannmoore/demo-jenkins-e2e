FROM cypress/base:10

RUN apt-get update
RUN apt-get install --yes git-core

COPY . .

RUN bin/setup.sh