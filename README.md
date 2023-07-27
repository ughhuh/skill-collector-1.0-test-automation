# Skill Collector 1.0 Test Automation

## Overview

This repository contains the automated test suite for Skill Collector 1.0, developed by Team Overflow during WIMMA Lab 2023. Skill Collector is a service that facilitates the collection of up-to-date information about the workforce needs of companies. Specifically, it focuses on gathering data about the skills that companies require from their future employees, both presently and in the foreseeable future.

The application functions by allowing the user to log in using a unique hash code received via email. Once logged in, the user can complete a survey that involves selecting five future need skills, five valuable skills, five important skills, and five most important skills on the hard skill selection page, and one valuable soft skill, one important soft skill, and one very important soft skill on the soft skill selection page. Once all selections are made, users can view their chosen skills and save their answers. A thank-you message is displayed, and the user can exit the service.

The primary focus of the Skill Collector 1.0 automated tests is to validate the functionality of the frontend features and emulate a typical user workflow. The following features are verified through the automated tests:

- FEA03-Customer-Feedback-system 1.0
- FEA04-GDPR-Info 1.0
- FEA20-skill-info-view
- FEA21-skill-selection-view
- FEA29-Softskill-selection-view
- FEA30-Progress-Bar
- FEA32-navigation-bar
- FEA40-language-selection-option

You can access further project documentation [here](https://wimma-lab-2023.pages.labranet.jamk.fi/overflow/core-skill-collector-1.0/). The automated tests for Skill Collector 1.0 were created by Alena Galysheva, a junior test automation engineer at Team Overflow.

Technologies and frameworks used include Robot Framework, Browser library, DataDriver library for data-driven tests, Python, requests and pandas libraries for Python scripts, and Docker for containerization.

## Table of Contents

- [Getting Started](#getting-started)
  - [Build the Docker Image](#build-the-docker-image)
  - [Run the Tests](#run-the-tests)
  - [Customizing Test Execution](#customizing-test-execution)
  - [Run Python Scripts](#run-python-scripts)
- [Project Structure](#project-structure)
  - [Root Folder](#root-folder)
  - [Test Suites](#test-suites)
  - [Resources](#resources)
  - [Data](#data)
  - [Scripts](#scripts)
  - [Reports](#reports)
- [Test Cases](#test-cases)
- [Test Execution and Reporting](#test-execution-and-reporting)
- [Test Coverage and Limitations](#test-coverage-and-limitations)
  - [Covered Areas](#covered-areas)
  - [Areas Not Covered](#areas-not-covered)
  - [Enhancements](#enhancements)
- [Acknowledgements](#acknowledgements)
- [Contact Information](#contact-information)
- [Conclusion](#conclusion)

## Getting Started

### Build the Docker Image

To build the Docker image for running the Skill Collector 1.0 Test Automation, use the following command:

```bash
docker build -t skill-collector-1-0-docker-tests .
```

This command will build the Docker image with the tag `skill-collector-1-0-docker-tests` based on the Dockerfile in the current directory.

### Run the Tests

To run the Skill Collector 1.0 Test Automation, execute the following command:

```bash
docker run -it --rm -v "$(pwd):/skill-collector-1.0-test-automation" -w /skill_collector skill-collector-1-0-docker-tests bash -c "robot --outputdir /skill-collector-1.0-test-automation/reports /skill-collector-1.0-test-automation/tests"
```

This command runs the Robot Framework tests inside the Docker container. The tests are located in the "/skill-collector-1.0-test-automation/tests" directory. The results of the test execution will be stored in the "/skill-collector-1.0-test-automation/reports" directory.

### Customizing Test Execution

You can customize the name of the top level suite using the `--name` option. The default name is `Tests`.

You can customize the test execution using the `--variable` option to pass `browser` and `url` variables. These variables define the browser name and the link to the deployed Skill Collector frontend, respectively. If you don't provide these variables, the default values `chromium` and `http://86.50.230.87/` will be used.

Example:

```bash
docker run -it --rm -v "$(pwd):/skill-collector-1.0-test-automation" -w /skill_collector skill-collector-1-0-docker-tests bash -c "robot --name 'Skill Collector Tests' --variable browser:firefox --variable url:http://link-to-sc.com --outputdir /skill-collector-1.0-test-automation/reports /skill-collector-1.0-test-automation/tests"
```

In this example, the test suite is named `Skill Collector Tests`. The tests will be executed using Firefox as the browser and the specified custom URL for the Skill Collector frontend. Replace <http://link-to-sc.com> with the actual URL you want to use for testing.

Make sure to adjust the paths and file locations based on your specific project structure and setup.

### Run Python Scripts

#### Data Generation for End-to-End and Related Test Suites

The `generate_e2e_alert_deny_data.py` script generates data for the `End-To-End`, `Not Enough Skills`, and `Too Many Skills` test suites. It creates datasets with random skills to be selected during testing. It is recommended to run this script when you need new data to test or when the Skills DB is updated.

To run the `generate_e2e_alert_deny_data.py` script, use the following command:

```bash
docker run -it --rm -v "$(pwd):/skill-collector-1.0-test-automation" skill-collector-1-0-docker-tests python3 scripts/generate_e2e_alert_deny_data.py
```

### Data Generation for Regression Test Suites

The `generate_cycle_hover_data.py` script generates data for the `Cycle Skills` and `Hover Skills` test suites. It ensures that the skill names and descriptions are up-to-date by parsing the Skills DB API.

To run the `generate_cycle_hover_data.py` script, use the following command:

```bash
docker run -it --rm -v "$(pwd):/skill-collector-1.0-test-automation" skill-collector-1-0-docker-tests python3 scripts/generate_cycle_hover_data.py
```

These scripts are used to maintain the test data integrity and ensure accurate and up-to-date test results. Run them when needed and when Skills DB is updated.

## Project Structure

### Root folder

- `requirements.txt` - Contains Robot Framework dependencies.
- `README.md` - Describes the project and its purpose.
- `Dockerfile` - Contains the Docker setup for the project.

### Test Suites

Test Suites are located in the `tests` folder. The names of the test suites are descriptive of their contents, and each suite contains related test. The tests are designed to be independent of each other. Initialization is handled using a common setup and teardown, and sometimes custom setups like `Access Hard Skills` and `Access Soft Skills` in data-driven tests are used as the tests need to be performed on different pages.

- `tests/` - Test Suites folder

- `tests/` - Test Suites folder
  - `backtracking.robot` - Test Suite to verify skill selection persistence.
  - `cycle_skills.robot` - Test Suite to verify skill selection/deselection functionality and progress bar update.
  - `e2e.robot` - Test Suite to verify basic user workflow in different languages.
  - `feedback.robot` - Test Suite to verify the Feedback functionality.
  - `GDPR.robot` - Test Suite to verify GDPR can be accessed in different languages.
  - `hover_skills.robot` - Test Suite to verify tooltip is displayed on hover with correct information.
  - `navigation_menu.robot` - Test Suite to verify that the user can navigate between hard skill categories.
  - `not_enough_skills.robot` - Test Suite to verify the answer isn't submitted when not enough skills are selected.
  - `too_many_skills.robot` - Test Suite to verify that the user can't select too many skills.

### Resources

Reusable keywords are stored in `.resource` files in the `resources` folder.

- `resources/` - Resources folder
  - `common.resource` - Contains general keywords.
  - `alert.resource` - Contains keywords for `Too Many Skills` test suite.
  - `backtrack.resource` - Contains keywords for data persistence test suite.
  - `e2e.resource` - Contains keywords for `End-To-End` test suite.
  - `feedback.resource` - Contains keywords for `Feedback` test suite.
  - `not_enough.resource` - Contains keywords for `Not Enough Skills` test suite.

### Data

Data sets for data-driven tests are stored in `.csv` files in the `data` folder.

- `data/` - Data folder
  - `alertdata.csv` - Data set for `too_many_skills.robot` Test Suite.
  - `cycledata.csv` - Data set for `cycle_skills.robot` Test Suite.
  - `denydata.csv` - Data set for `not_enough_skills.robot` Test Suite.
  - `e2edata.csv`- Data set for `e2e.robot` Test Suite.
  - `hoverdata.csv` - Data set for `hover_skills.robot` Test Suite.

### Scripts

Python scripts to update data sets are stored in the `scripts` folder.

- `scripts/` - Scripts folder
  - `generate_cycle_hover_data.py` - Script for generating data sets `cycledata.csv` and `hoverdata.csv`.
  - `generate_e2e_alert_deny_data.py` - Script for generating data sets `alertdata.csv`, `denydata.csv`, and `e2edata.csv`.

### Reports

Test results and logs generated by Robot Framework are stored in the `reports` folder. Only the results of the latest test iteration are stored.

- `reports/` - Reports folder
  - `browser/` - Browser library artifacts.
    - `screenshot/` - Screenshots taken when a test fails.
  - `log.html` - Log file.
  - `output.xml` - Output in `.xml` format.
  - `playwright-log.txt` - Log generated by Playwright.
  - `report.html` - Test report.

## Test Cases

Each test case focuses on a specific aspect, which can range from small components of a single feature to comprehensive end-to-end scenarios. Consistency is maintained within each test suite, ensuring that all test cases share the same level of abstraction.

Workflow tests consist of several essential elements, including an optional precondition, an action that involves interactions with the system, a verification step to validate the results, and a cleanup process as part of the test case teardown.

Data-driven tests leverage the test template functionality, allowing for the creation of various tests with different arguments. This flexibility enables the execution of multiple variations of the same test case based on the provided data.

Below is a list of the main test cases included in this project.

- `backtracking.robot` - Backtracking Test Suite.
  - `E2E ENG` - Test case to verify the user selections are preserved when they return to the main page and log in with the same hash.

- `cycle_skills.robot` - Cycle Skills Test Suite.
  - `Check Hard Skills` - Test case to verify all hard skills can be selected and deselected and validate the progress bar update for each selection event.
  - `Check Soft Skills` - Test case to verify all soft skills can be selected and deselected and validate the progress bar update for each selection event.

- `e2e.robot` - End-to-End Test Suite.
  - `E2E ENG` - Test case to verify how the user would use the app in English language.
  - `E2E FI` - Test case to verify how the user would use the app in Finnish language.
  - `E2E SWE` - Test case to verify how the user would use the app in Swedish language.

- `feedback.robot` - Feedback Test Suite.
  - `Check Feedback Home Page` - Test case to verify the Feedback form works on the home page.
  - `Check Feedback Intro Page` - Test case to verify the Feedback form works on the Instructions page.
  - `Check Feedback Skill Selection 1` - Test case to verify the Feedback form works on the hard skill selection page.
  - `Check Feedback Skill Selection 2` - Test case to verify the Feedback form works on the soft skill selection page.

- `gdpr.robot` - GDPR Statement Test Suite.
  - `Check GDPR Home Page` - Test case to verify the GDPR statement is accessible on the home page.

- `hover_skills.robot` - Hover Skills Test Suite.
  - `Hover Hard Skills` - Test case to verify skill names and tooltip descriptions match on the hard skill selection page.
  - `Hover Soft Skills` - Test case to verify skill names and tooltip descriptions match on the soft skill selection page.

- `navigation_menu.robot` - Navigation Menu Test Suite.
  - `Click Navigation Headers` - Test case to verify the page can be navigated using navigation menu items.
  - `Scroll The Page` - Test case to verify the currently viewed page section is highlighted.

- `not_enough_skills.robot` - Not Enough Skills Test Suite.
  - `Not Enough Hard Skills` - Test case to verify the survey result isn't submitted if not enough hard skills were selected.
  - `Not Enough Soft Skills` - Test case to verify the survey result isn't submitted if not enough soft skills were selected.
  - `Not Enough Both Skills` - Test case to verify the survey result isn't submitted if not enough skills of both types were selected.

- `too_many_skills.robot` - Too Many Skills Test Suite.
  - `Too Many Hard Skills` - Test case to verify alert triggers for hard skill categories.
  - `Too Many Soft Skills` - Test case to verify alert triggers for soft skill categories.

### Test Execution and Reporting

To execute the tests, [build the Docker container](#build-the-docker-image) and [run the tests](#run-the-tests). The Docker setup ensures that all necessary dependencies are installed within the container. The required CSV files already contain the essential test data. Once the tests are executed, the test reports are generated and can be found in the `reports/` folder.

`report.html`contain an overview of the test execution results in HTML format. It has a list of all executed test cases. Each test case has tags (test type tags and tags to identify what feature it's related to), and the log provides statistics based on these tags and test suites.

`log.html` file contains details about the executed test cases in HTML format. It has a hierarchical structure showing test suite, test case and keyword details.

When reviewing the test reports, pay attention to the following key details:

- **Test Status**: Each test case in a test suite is assigned a status, indicating whether it has passed, failed, or been skipped during execution. To access detailed execution information, click on the test name to view the corresponding log file.

- **Statistics By Tag**: Test report and log include statistics categorized by tags, which group test cases based on their types and functionalities. This provides a convenient way to get an overview of the test coverage and the specific purposes of each test.

- **Statistics By Suite**: Test report and log also offer statistics for each test suite, giving an overall summary of the suite-level execution. This provides valuable insights into the overall performance of the test suite.

- **Logs and Errors**: The log file provides comprehensive information on the execution of each test suite, test case, and keyword. Any encountered errors or exceptions are logged with relevant screenshots attached.

## Test Coverage and Limitations

### Covered Areas

The current test automation suites cover the following functionalities and scenarios of the Skill Collector 1.0 application:

- **FEA03-Customer-Feedback-system 1.0**: Verification of the integration of the customer feedback system, which allows users to send feedback to the service provider.
- **FEA04-GDPR-Info 1.0**: Validation of the integration of the GDPR statement in every service language on the home page of Skill Collector 1.0.
- **FEA20-skill-info-view**: Verification of the skill information view, which allows users to see hard and soft skills and their descriptions as a tooltip when a question mark icon is hovered.
- **FEA21-skill-selection-view**: Validation of the hard skill selection view, where users can select future need skills, valuable skills, important skills, and most important skills on the hard skill selection page. Verification of hard skill selection preservation when the user logs out and logs back in shortly after with the same hash. Verification of the hard skill selection limits, where the user isn't able to select less than or more than 5 skills in each category.
- **FEA29-Softskill-selection-view**: Validation of the hard skill selection view, where users can choose valuable soft skills, important soft skills, and very important soft skills on the soft skill selection page. Verification of soft skill selection preservation when the user logs out and logs back in shortly after with the same hash. Verification of the soft skill selection limits, where the user isn't able to select less than or more than 1 skills in each category.
- **FEA30-Progress-Bar**: Validation of the progress bar, which updates accordingly with each skill selection and deselection event on the hard skill selection page and soft skill selection page.
- **FEA32-navigation-bar**: Verification of the navigation bar functionality on the hard skill selection page, enabling users to navigate between different skill categories.
- **FEA40-language-selection-option**: Testing the language selection option to ensure that users can choose their preferred language for the application.
- **End-To-End**: Validating the typical user workflow outlined in the [Overview](#overview) section of this document.

### Areas Not Covered

The current test automation suites do not cover the following functionalities and scenarios:

- **Backend Testing**: The current test suite focuses on frontend functionalities and does not include testing of backend systems or APIs. Manual API tests have been written previously (see: [TC-47-003](https://wimma-lab-2023.pages.labranet.jamk.fi/overflow/core-skill-collector-1.0/50-Test-management/Test%20Cases/FEA-47/TC-47-003/)) and can serve as a starting point for future automation of API testing.
- **Accessibility Testing**: Accessibility tests are performed using the [RAMP](https://accessibleweb.com/) tool.
- **Localization**: Although language selection is tested, the full localization testing of all application elements has not been implemented.

### Enhancements

Test coverage of the Skill Collector 1.0 application can be improved by including the following aspects:

- **Backend Integration Testing**: Incorporate test cases to verify the integration of the frontend with backend services and APIs.
- **Smoke Testing**: Develop test cases to verify the basic functionality of the application before proceeding with the rest of the test suites.
- **Localization Testing**: Expand the test suite to verify the localization of all application elements in different languages.
- **Edge Cases**: Add test scenarios to cover edge cases and unusual user inputs to enhance the application's robustness.
- **Handling Test Failures**: At times, when running all tests simultaneously, the website might encounter issues such returning a `429 Too Many Requests` status code when attempting to enter the hash. As a solution, a mechanism can be implemented to catch and handle such errors gracefully, enabling the skipping of the affected tests and preventing their inevitable failure from impacting the entire test suite.

## Acknowledgements

I would like to give credit to the following tools, frameworks, and resources that I found helpful while working on this project:

- [Robot Framework](https://robotframework.org/)
- [Browser Library](https://robotframework-browser.org/)
- [DataDriver Library](https://github.com/Snooz82/robotframework-datadriver)
- [Docker Images for Robot Framework Guide](https://docs.robotframework.org/docs/using_rf_in_ci_systems/docker)
- [HowToWriteGoodTestCases Guide by Pekka Klärck](https://github.com/robotframework/HowToWriteGoodTestCases/tree/master)

## Contact Information

Alena Galysheva - [LinkedIn](https://www.linkedin.com/in/alena-galysheva/) - <alena.galysheva@gmail.com>

Skill Collector Documentation: <https://wimma-lab-2023.pages.labranet.jamk.fi/overflow/core-skill-collector-1.0/>

Skill Collector Source Code: <>

WIMMA Lab: <https://www.wimmalab.org/>

## Conclusion

Thank you for taking the time to explore this test automation suite for Skill Collector 1.0! It was my first project as a test automation engineer, and it has been a valuable learning experience for me. I welcome any feedback or suggestions you may have to improve the quality and robustness of these tests.

If you have any questions or ideas for improvement, please reach out to me. I value your feedback and greatly appreciate your input as a junior test automation engineer. Your suggestions will help me further enhance my skills and write better tests in the future.
