[Version = "1.0.1"]
section POWERAUTOMATERESTAPIComm;

[DataSource.Kind="POWERAUTOMATERESTAPIComm", Publish="POWERAUTOMATERESTAPIComm.Publish"]
shared POWERAUTOMATERESTAPIComm.FunctionCatalog = () =>
let
    objects = #table(
        {"Name","Key","Data","ItemKind","ItemName","IsLeaf"},
        {
            {"GetEnvironments","GetEnvironments",POWERAUTOMATERESTAPIComm.GetEnvironments,"Function","GetEnvironments",true},
            {"GetPersonalFlows","GetPersonalFlows",POWERAUTOMATERESTAPIComm.GetPersonalFlows,"Function","GetPersonalFlows",true},
            {"GetTeamFlows","GetTeamFlows",POWERAUTOMATERESTAPIComm.GetTeamFlows,"Function","GetTeamFlows",true},
            {"GetFlow","GetFlow",POWERAUTOMATERESTAPIComm.GetFlow,"Function","GetFlow",true},
            {"GetFlowRuns","GetFlowRuns",POWERAUTOMATERESTAPIComm.GetFlowRuns,"Function","GetFlowRuns",true}
        }),
    navTable = Table.ForceToNavigationTable(objects,{"Key"},"Name","Data","ItemKind","ItemName","IsLeaf")
in
    navTable;

/* GLOBAL VARIABLES */
API_VERSION = "2016-11-01";

/*****************
GetEnvironments

URL: {API EndPoint}/providers/Microsoft.ProcessSimple/environments

Inputs:
none
*****************/
POWERAUTOMATERESTAPIComm.GetEnvironments = Value.ReplaceType(
    GetEnvironments,
    GetEnvironmentsType
);

GetEnvironmentsType = type function () 
    as table meta [
        Documentation. Name = "POWERAUTOMATERESTAPIComm.GetEnvironments",
        Documentation. LongDescription = "Returns the environments available to the requestor.",
        Documentation. Examples = { 
            [
                Code= "=POWERAUTOMATERESTAPIComm.GetEnvironments(""xxx-xxxx-yyxa ... "")",
                Result = "API call to Power Automate to return the environment available to the requestor, returned as JSON"
            ]
        }
    ];

GetEnvironments = () => 
    let
        result = GetJSON("/providers/Microsoft.ProcessSimple/environments") 
    in
        result;

/*****************
GetPersonalFlows

URL: {API EndPoint}/providers/Microsoft.ProcessSimple/environments/{EvironmentId}/flows?$filter=search(%27personal%27)&$top=50&include=includeSolutionCloudFlows&api-version=2016-11-01

Inputs:
    EnvironmentId
*****************/
shared POWERAUTOMATERESTAPIComm.GetPersonalFlows = Value.ReplaceType(
    GetPersonalFlows,
    GetPersonalFlowsType
);

GetPersonalFlowsType = type function ( 
    optional EnvId as ( 
        type text meta [
            Documentation.FieldCaption = "Environment ID",
            Documentation.FieldDescription = "The Environment ID for the Flow",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa ... "
            }
        ]
    ),
    optional Parameters as (
        type text meta [
            Documentation.FieldCaption = "URL Arguments",
            Documentation.FieldDescription = "Text arguments for the URL, when left blank all flows are targeted.", 
            Documentation.SampleValues = {
                "$filter=search(%27personal%27)&$top=50&include=includeSolutionCloudFlows"
            }
        ]
    )
) as table meta [
    Documentation.Name = "POWERAUTOMATERESTAPIComm.GetPersonalFlows",
    Documentation.LongDescription = "Returns the Personal flows (shown as Cloud Flows in the Power Automate interface) for a specific environment.", 
    Documentation.Examples = {
        [
            Code = "=POWERAUTOMATERESTAPIComm.GetPersonalFlows(""xxx-xxxx-yyxa ... "")",
            Result = "API Call to Power Automate returns a JSON representation of all the Personal flows."
        ]
    }
];

GetPersonalFlows = (optional EnvId as text, optional Parameters as text) =>
    let 
        result = 
                if(Parameters <> null)
                then                
                    GetJSON("/providers/Microsoft.ProcessSimple/environments/" & EnvId & "/flows?$filter=search(%27personal%27)&" & Parameters & "&api-version=" & API_VERSION)
                else
                    GetJSON("/providers/Microsoft.ProcessSimple/environments/" & EnvId & "/flows?$filter=search(%27personal%27)$top=50&include=includeSolutionCloudFlows&api-version=" & API_VERSION)
    in
        result;    

/*****************
GetTeamFlows

URL: {API EndPoint}/providers/Microsoft.ProcessSimple/environments/{EvironmentId}/flows?$filter=search(%27team%27)&$top=50&include=includeSolutionCloudFlows&api-version=2016-11-01

Inputs:
    EnvironmentId
*****************/
shared POWERAUTOMATERESTAPIComm.GetTeamFlows = Value.ReplaceType(
    GetTeamFlows,
    GetTeamFlowsType
);

GetTeamFlowsType = type function ( 
    optional EnvId as ( 
        type text meta [
            Documentation.FieldCaption = "Environment ID",
            Documentation.FieldDescription = "The Environment ID for the Flow",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa ... "
            }
        ]
    ),
    optional Parameters as (
        type text meta [
            Documentation.FieldCaption = "URL Arguments",
            Documentation.FieldDescription = "Text arguments for the URL, when left blank all flows are targeted.", 
            Documentation.SampleValues = {
                "$filter=search(%27team%27)&$top=50&include=includeSolutionCloudFlows"
            }
        ]
    )
) as table meta [
    Documentation.Name = "POWERAUTOMATERESTAPIComm.GetTeamFlows",
    Documentation.LongDescription = "Returns the Team flows (shown as Shared With Me in the Power Automate interface) for a specific environment.", 
    Documentation.Examples = {
        [
            Code = "=POWERAUTOMATERESTAPIComm.GetTeamFlows(""xxx-xxxx-yyxa ... "")",
            Result = "API Call to Power Automate returns a JSON representation of all the Team flows."
        ]
    }
];

GetTeamFlows = (optional EnvId as text, optional Parameters as text) =>
    let 
        result = 
                if(Parameters <> null)
                then                
                    GetJSON("/providers/Microsoft.ProcessSimple/environments/" & EnvId & "/flows?$filter=search(%27team%27)&" & Parameters & "&api-version=" & API_VERSION)
                else
                    GetJSON("/providers/Microsoft.ProcessSimple/environments/" & EnvId & "/flows?$filter=search(%27team%27)$top=50&include=includeSolutionCloudFlows&api-version=" & API_VERSION)
    in
        result; 

/***************** 
GetFlow

URL: {API ENDPOINT}/providers/Microsoft.ProcessSimple/environments/{EnvironmentId}/flows/{FlowId}?api-version=2016-11-01

Input:
    EnvironmentId
    FlowId
*****************/
shared POWERAUTOMATERESTAPIComm.GetFlow = Value.ReplaceType(
    GetFlow,
    GetFlowType
);

GetFlowType = type function ( 
    optional EnvId as ( 
        type text meta [
            Documentation. FieldCaption = "Environment ID",
            Documentation. FieldDescription = "The Environment ID for the Flow", 
            Documentation. SampleValues = { "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional FlowId as ( 
        type text meta [
            Documentation.FieldCaption = "Flow ID",
            Documentation.FieldDescription = "The Flow's ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa ... "
            }
        ]
    )
) as table meta [
    Documentation.Name = "POWERAUTOMATERESTAPIComm.GetFlow",
    Documentation. LongDescription = "Returns the flow's specific details including triggers, steps, and connections.",
    Documentation.Examples = { 
        [
            Code = "=POWERAUTOMATERESTAPIComm.GetFlow(""xxx-xxxx-yyxa ... "")",
            Result = "API call to Power Automate which returns a JSON result for the flow specified by Flow ID and Environment ID."
        ]
    }
];

GetFlow = (optional EnvId as text, optional FlowId as text) => 
    let
        result = GetJSON("/providers/Microsoft.ProcessSimple/environments/" & EnvId & "/flows/" & FlowId & "?api-version=" & API_VERSION & "&$expand=swagger,properties.connectionreferences.apidefinition,properties.definitionSummary.operations.apiOperation,operationDefinition,plan,properties.throttleData,properties.estimatedsuspensiondata")
    in
        result;  

/***************** 
GetFlowRuns

URL: {API ENDPOINT}/providers/Microsoft.ProcessSimple/environments/{EnvironmentId}/flows/{FlowId}/runs?api-version=2016-11-01

Input:
    EnvironmentId
    FlowId
*****************/
shared POWERAUTOMATERESTAPIComm.GetFlowRuns = Value.ReplaceType(
    GetFlowRuns,
    GetFlowRunsType
);

GetFlowRunsType = type function ( 
    optional EnvId as ( 
        type text meta [
            Documentation. FieldCaption = "Environment ID",
            Documentation. FieldDescription = "The Environment ID for the Flow", 
            Documentation. SampleValues = { "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional FlowId as ( 
        type text meta [
            Documentation.FieldCaption = "Flow ID",
            Documentation.FieldDescription = "The Flow's ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa ... "
            }
        ]
    )
) as table meta [
    Documentation.Name = "POWERAUTOMATERESTAPIComm.GetFlowRuns",
    Documentation. LongDescription = "Returns the flow runs for a specific Flow ID.  If no parameters are supplied it will retrieve the latest 50 runs.",
    Documentation.Examples = { 
        [
            Code = "=POWERAUTOMATERESTAPIComm.GetFlowRuns(""xxx-xxxx-yyxa ... "")",
            Result = "API call to Power Automate which returns a JSON result for the flow specified by Flow ID and Environment ID."
        ]
    }
];

GetFlowRuns = (optional EnvId as text, optional FlowId as text) => 
    let
        result = GetJSON("/providers/Microsoft.ProcessSimple/environments/" & EnvId & "/flows/" & FlowId & "/runs?api-version=" & API_VERSION)
    in
        result;        

/*****************
    HELPER FUNCTIONS
*****************/

// Get JSON from API Call
GetJSON = (optional relPath as text) =>
    let
        params = [Headers = [#"Content-Type" = "application/json"], RelativePath = relPath],
        //Get Pages
        //Hard-coded Base URL because Power BI Service won't recognize parameter despite numerous attempts
        webSource = Web.Contents(
            "https://api.flow.microsoft.com",
            params
        ),
        //Convert to Json
        result = Text.FromBinary(webSource)
    in
        result;

// Get Flows data based on environment id and the odata parameters
GetFlows = (optional EnvId as text, optional Parameters as text) =>
    let 
        result = GetJSON("/providers/Microsoft.ProcessSimple/environments/" & EnvId & "/flows?" & Parameters & "&api-version=2016-11-01")
    in
        result;        

// Data Source Kind description
POWERAUTOMATERESTAPIComm = [
    TestConnection = (dataSourcePath) => { "POWERAUTOMATERESTAPIComm.FunctionCatalog"},
    Authentication = [
        Aad = [
            AuthorizationUri = "https://login.windows.net/common/oauth2/authorize",
            Resource = "https://service.flow.microsoft.com"
        ]
    ]
];

// Data Source UI publishing description
POWERAUTOMATERESTAPIComm.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://github.com/kerski/powerquery-connector-power-automate-rest-api-commercial#readme",
    SourceImage = POWERAUTOMATERESTAPIComm.Icons,
    SourceTypeImage = POWERAUTOMATERESTAPIComm.Icons
];

POWERAUTOMATERESTAPIComm.Icons = [
    Icon16 = { Extension.Contents("POWERAUTOMATERESTAPIComm16.png"), Extension.Contents("POWERAUTOMATERESTAPIComm20.png"), Extension.Contents("POWERAUTOMATERESTAPIComm24.png"), Extension.Contents("POWERAUTOMATERESTAPIComm32.png") },
    Icon32 = { Extension.Contents("POWERAUTOMATERESTAPIComm32.png"), Extension.Contents("POWERAUTOMATERESTAPIComm40.png"), Extension.Contents("POWERAUTOMATERESTAPIComm48.png"), Extension.Contents("POWERAUTOMATERESTAPIComm64.png") }
];

//To Navigation Table
Table.ToNavigationTable = (
    table as table,
    keyColumns as list,
    nameColumn as text,
    dataColumn as text,
    itemKindColumn as text,
    itemNameColumn as text,
    isLeafColumn as text
) as table =>
    let
        tableType = Value.Type(
            table
        ),
        newTableType = Type.AddTableKey(
            tableType,
            keyColumns,
            true
        ) meta [
            NavigationTable.NameColumn = nameColumn,
            NavigationTable.DataColumn = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn,
            Preview.DelayColumn = itemNameColumn,
            NavigationTable.IsLeafColumn = isLeafColumn
        ],
        navigationTable = Value.ReplaceType(
            table,
            newTableType
        )
    in
        navigationTable;

// Force Navigation Table
Table.ForceToNavigationTable = (
    table as table,
    keyColumns as list,
    nameColumn as text,
    dataColumn as text,
    itemKindColumn as text,
    itemNameColumn as text,
    isLeafColumn as text
) as table =>
    let
        tableType = Value.Type(
            table
        ),
        newTableType = Type.AddTableKey(
            tableType,
            keyColumns,
            true
        ) meta [
            NavigationTable.NameColumn = nameColumn,
            NavigationTable.DataColumn = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn,
            NavigationTable.IsLeafColumn = isLeafColumn
        ],
        navigationTable = Value.ReplaceType(
            table,
            newTableType
        )
    in
        navigationTable;