# Power Query Custom Data Connector for Power Automate REST APIs (Commercial)

This Custom Data Connector wraps a few of the "Get" endpoints in the Power Automate API, so that OAuth can be used to authenticate to the service.  This connector serves as a way to have a library of Power Query functions to build datasets based on the Power Automate APIs without the need for storing client secrets or passwords in the dataset.  

Each function returns a JSON body and not a table of data.  This decision was made to provide flexibility in converting the JSON body to tabular data when 1) the API responses are changed by Microsoft or 2) the API responses differ between commercial and sovereign clouds (e.g., GCC, DoD, etc.). 

## Table of Contents

1. [Installation](#installation)
    1. [Desktop](#desktop)
    1. [Using Functions](#using-functions)
    1. [Functions Implemented](#functions-implemented)
    1. [On-Premises Gateway](#on-premises-gateway)
1. [Building Connector](#building-connector)
    1. [Testing Connector](#testing-connector)


## Installation

### Desktop
1. Open Power BI Desktop and navigate to File -> Options and Settings -> Options.
2. Navigate to GLOBAL -> Security and under "Data Extensions" choose "Allow any extension..."

![Allow extension](./documentation/images/options-update.png)

Because this is a custom data connector you have to choose this option in order to use it in Power BI Desktop.

3. Close all Power BI Desktop instances on your local machine.  You are often prompted to do so by Power BI Desktop.
4. Copy the [.mez file](https://github.com/kerski/powerquery-connector-power-automate-rest-api-commercial/releases/download/v1.0.0-beta/powerquery-connector-power-automate-rest-api-commercial.mez) to your folder "Documents\Power BI Desktop\Custom Connectors".  If the folder does not exist, create it first.
5. Open Power BI Desktop.
6. Select Get Data option.
7. Navigate to the "Other" section and you should see the "Connect to Power Automate REST API" connector.

![Other->PA-REST-API](./documentation/images/pa-other-connect.png)

8. Select the connector and press the "Connect" button.
9. You may be prompted with the pop-up below. Choose "Continue".

![Connector Popup](./documentation/images/connector-pop-up.png)

10. If this is your first time using the custom data connector you will be prompted to sign into Office 365. Please follow the instructions to sign in and then choose the "Connect" button.

![Sign in prompt](./documentation/images/sign-in.png)

10. The Navigator prompt will appear (example below).

![Navigator prompt](./documentation/images/navigator.png)

11. Choose the "GetEnvironments" option and you should see a json response (see example below).

![GetEnvironments](./documentation/images/get-environments.png)

12. Then choose the "Transform Data" button.  This should open the Power Query Editor.

![GetEnvironments in Power Query Editor](./documentation/images/get-environments-pq.png)

13. Under "Applied Steps", remove the steps "Invoked FunctionGetEnvironments1" and "Navigation".

![Remove Steps](./documentation/images/remove-steps.png)

14. You now will see a catalog of the Power Automate REST APIs to leverage.  I suggest you rename the Query "GetEnvironments" to "Function Catalog".

![Function Catalog](./documentation/images/function-catalog.png)

15. I suggest you also uncheck "Enable Load" for the Function Catalog so it doesn't appear in the data model. When disabled the Function Catalog will appear italicized.

![Disable Function Catalog Load](./documentation/images/disable-load.png)

### Using Functions

With the Function Catalog created, please follow these steps to leverage the functions:

1. Identify the name of the function you wish to use. Right-click on the "Function" value located for the appropriate row and select "Add as New Query".

![Add as New Query](./documentation/images/add-as-new-query.png)

2. The function will be created and it can now be used to query the Power BI service.

![New Function](./documentation/images/new-function.png)

### Functions Implemented

Not all functions from the Power Automate REST API have been implemented.  Here are the endpoints available at the moment.

### Apps
| End Point                    | Description  |
|:-----------------------------|:-------------|
| Get Environments | Returns the environments available to the requestor. IsDefault parameter identifies the default environment (true value).  |
| Get Personal Flows | Returns the Personal flows (shown as Cloud Flows in the Power Automate interface) for a specific environment.  |
| Get Team Flows | Returns the Team flows (shown as Shared With Me in the Power Automate interface) for a specific environment.  |
| Get Flow Runs | Returns the flow runs for a specific Flow ID.  If no parameters are supplied it will retrieve the latest 50 runs.  |

### On-Premises Gateway

The custom data connector will need to be installed in the a Power BI Gateway in order to refresh datasets leveraging this custom connector.  For more information on installing a custom data connector with a gateway please see: https://learn.microsoft.com/en-us/power-bi/connect-data/service-gateway-custom-connectors.

## Building Connector

### Prerequisites 

1. Install Visual Studio code: https://code.visualstudio.com/download.
1. Install Power Query SDK for Visual Studio Code: https://github.com/microsoft/vscode-powerquery-sdk
1. Clone this repo to your local machine.

## Compile

In order to the compile the custom data connector to the .mez file, please follow these instructions:

1. Using your keyboard, use the shortcut Ctrl+Shift+B.  Visual Studio will prompt you within the command palette to choose a build task. Select the "build: Build connector project using MakePQX".

![Build](./documentation/images/build-mez.png)

2. If the build succeeds the .mez file will update in the folder "bin\AnyCPU\Debug".

3. If the build fails the Power Query SDK often presents a notification (see example below).

![Failed Build](./documentation/images/failed-build.png)

### Testing Connector

In order to test the custom data connector, please follow these instructions:

1. Choose the "Set Credential" option within the Power Query SDK. Select AAD and follow the prompts to log into Microsoft 365.

![Set Credential](./documentation/images/set-credential.png)

2. The .query.pq file is used to test the custom data connector, please update the section labeled "TEST VARIABLES" for your own environment.

![Test Variables](./documentation/images/test-variables.png)

3. When you are ready to test, use the "Evaluate current file" option in the Power Query SDK in the "Explorer" tab.

![Evaluate](./documentation/images/evaluate-test-file.png)

4. When the testing completes, a new tab will be present any failed results or if all the tests passed (example below).

![Test Results](./documentation/images/test-results.png)