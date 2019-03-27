# Jenkins Automation for E2E Tests

This repo provides an example of a configurable end-to-end test automation setup using Jenkins.

## Prerequisites

- Install [Docker](https://www.docker.com/get-started)
- Install [docker-compose](https://docs.docker.com/compose/install/)

## Getting Started

Start the Jenkins container:

```sh
bin/start.sh
```

The container will be available locally at `localhost:8080`. Follow the browser prompts to set up the local Jenkins instance. The `start.sh` script will print out the initial admin password that you'll need to provide.

A volume will be created in `docker/jenkins` to store your local Jenkins data. As long as you don't delete this volume, you won't have to repeat the initial setup and installation. 

Stop the Jenkins container:

```sh
bin/stop.sh
```

## Running Tests Locally

Tests can be run through the `bin/test.sh` script, which is configured to set up different tests for different environments. The script accepts an `[ENV]` parameter that specifies which environment the tests are running in.

```sh
bin/test.sh DEV
bin/test.sh QA
bin/test.sh STAGING
```

Note: How the `bin/test.sh` script works is entirely up to you. It could be used to run completely different tests on an environment, or to run multiple suites that bail if a prerequisite fails.
