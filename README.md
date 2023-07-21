# Skill Collector 1.0 Test Automation

## Commands

### Build the Docker Image

To build the Docker image for running the Skill Collector 1.0 Test Automation, use the following command:

```bash
docker build -t my-robotframework-dockerimage .
```

This command will build the Docker image with the tag "my-robotframework-dockerimage" based on the Dockerfile in the current directory.

### Run the Tests

To run the Skill Collector 1.0 Test Automation, execute the following command:

```bash
docker run -it --rm -v "$(pwd):/skill-collector-1.0-test-automation" -w /skill_collector my-robotframework-dockerimage bash -c "robot --outputdir /skill-collector-1.0-test-automation/reports /skill-collector-1.0-test-automation/tests"
```

This command runs the Robot Framework tests inside the Docker container. The tests are located in the "/skill-collector-1.0-test-automation/tests" directory. The results of the test execution will be stored in the "/skill-collector-1.0-test-automation/reports" directory.

### Customizing Test Execution

You can customize the test execution using the `--variable` option to pass `browser` and `url` variables. These variables define the browser name and the link to the deployed Skill Collector frontend, respectively. If you don't provide these variables, the default values `chromium` and `http://86.50.230.87/` will be used.

Example:

```bash
docker run -it --rm -v "$(pwd):/skill-collector-1.0-test-automation" -w /skill_collector my-robotframework-dockerimage bash -c "robot --variable browser:firefox --variable url:http://link-to-sc.com --outputdir /skill-collector-1.0-test-automation/reports /skill-collector-1.0-test-automation/tests"
```

In this example, the tests will be executed using Firefox as the browser and the specified custom URL for the Skill Collector frontend. Replace http://link-to-sc.com with the actual URL you want to use for testing.

Make sure to adjust the paths and file locations based on your specific project structure and setup.
