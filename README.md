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

### Running Tests Locally

Tests can be run through the `bin/test.sh` script, which is configured to set up different tests for different environments. The script accepts an `[ENV]` parameter that specifies which environment the tests are running in.

```sh
bin/test.sh DEV
bin/test.sh QA
bin/test.sh STAGING
bin/test.sh FAIL # extra option to demonstrate failing tests
```

Note: How the `bin/test.sh` script works is entirely up to you. It could be used to run completely different tests on an environment, or to run multiple suites that bail if a prerequisite fails.

## Jenkins Setup

## Connect GitHub to Jenkins

Once you have Jenkins running, we can set up the CI process. In this section, we'll connect Jenkins to our GitHub repository.

### Verify Plugins

In the Jenkins web UI, click "Manage Jenkins", then "Manage Pulgins", and ensure that the following plugins are installed:

- NodeJS plugin

### Create GitHub Credentials

Next, we'll need to store the GitHub credentials in Jenkins.

- In Jenkins, click "Credentials".
- Under "Stores scoped to Jenkins", click "Jenkins".
- Under "System", click "Global credentials (unrestricted)".
- Click "Add Credentials" to create new credentials.

You'll need to add one set of credentials:

- Kind: Username with password => the GitHub username / password of the account that created the Personal access token

### Set Up Node 
 
In order to use `npm install` inside a Jenkins job, we'll need to configure Jenkins with a version of Node:

- Go to `localhost:8080/configureTools`.
- Under "NodeJs", click "Add NodeJS".
- Give it any name and select a version.
- Restart Jenkins (`http://localhost:8080/restart`)

Resource: https://wiki.jenkins.io/display/JENKINS/NodeJS+Plugin

### Create New Job

Next, we'll create a job that pulls the latest code from GitHub and executes the tests.

- On the Jenkins web page, click "New Item".
- Provide any name and select "Freestyle project", then Click "OK".
- On the configuration page:
  - Check "This project is parameterized" and create a "Choice Parameter"
    - The name should be `ENVIRONMENT`.
    - The choices should be `DEV`, `QA`, `STAGING`, and `FAIL`, each on its own line.
  - Under "Source Code Management": select "Git".
    - Paste in the repository URL and select the username/password credentials created earlier.
  - Under "Build Environment", select "Provide Node & npm bin/folder to PATH"* and choose the NodeJS installation created earlier.
  - Under "Build", select "Add build step" => "Execute shell" and paste in the script below.
  - Click "Save"

```sh
./bin/setup.sh
./bin/test.sh $ENVIRONMENT
```

This repository pipes test output into `.tap` files in the `results` directory. This means that you can optionally use the [Jenkins TAP Plugin](https://wiki.jenkins.io/display/JENKINS/TAP+Plugin) to publish results as a post-build step. Otherwise results will end up in the Jenkins console output as usual.

Rather than using a parameterized build, you could also create several different builds that provide a hard-coded environment, which lets you use the same codebase to drive tests on different environments.
