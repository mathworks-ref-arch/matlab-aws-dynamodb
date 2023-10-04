# Getting Started

Once this package is installed and authentication is in place one can begin working with DynamoDB™ and looking at simple workflows. The [Basic Usage](BasicUsage.md) and [API Reference](DynamoDBApiDoc.md) documents provide greater detail on the classes and methods being used along with information on error checking.

Configure and create a DynamoDB table, using the lower-level API:
```matlab
% create and initialize a client
ddb = aws.dynamodbv2.AmazonDynamoDBClient;
% use local credentials rather than the Provider Chain
ddb.useCredentialsProviderChain = false;
ddb.initialize();

tableName = 'myTableTest';
attributeName = 'Name';

% configure a TableCreateRequest
createTableRequest = aws.dynamodbv2.model.CreateTableRequest();
testCase.verifyNotEmpty(createTableRequest.Handle);
createTableRequest.setTableName(tableName);
pt = aws.dynamodbv2.model.ProvisionedThroughput(uint64(10), uint64(10));
createTableRequest.setProvisionedThroughput(pt);

% configure an attribute definition and key element schema
ad = aws.dynamodbv2.model.AttributeDefinition();
ad.setAttributeName(attributeName);
ad.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.S);
createTableRequest.setAttributeDefinitions([ad]);
kse = aws.dynamodbv2.model.KeySchemaElement(attributeName, aws.dynamodbv2.model.KeyType.HASH);
createTableRequest.setKeySchema([kse]); %#ok<NBRAK>

% create the table
createResult = ddb.createTable(createTableRequest);

% check the table was created
tableDescription = createResult.getTableDescription();
name = tableDescription.getTableName();
testCase.verifyEqual(name, tableName);

% cleanup
status = tableDescription.getTableStatus();
while ~strcmp(status, 'ACTIVE')
    pause(1);
    describeResult = ddb.describeTable(tableName);
    tableDescription = describeResult.getTable();
    status = tableDescription.getTableStatus();
end
deleteResult = ddb.deleteTable(tableName);

ddb.shutdown();
```

## Configure a local DynamoDB instance
The following page describes how to configure a local DynamoDB instance, this can be particularly useful for test and development as transactions are not carried out with an AWS hosted DynamoDB instance:
[https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.DownloadingAndRunning.html](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.DownloadingAndRunning.html)

To use a local DynamoDB as described configure the client as shown, setting the endpoint host and port as required:
```matlab
%% Create the client, authenticate using the AWS provider chain
ddb = aws.dynamodbv2.AmazonDynamoDBClient;
endpoint = 'http://localhost:8000';
endpointURI = matlab.net.URI(endpoint);
ddb.endpointURI = endpointURI;
ddb.initialize();
```

The results can then be queried as using the AWS CLI, if the AWS CLI is installed this command can be issued either from within MATLAB or a shell:
```bash
aws dynamodb list-tables --endpoint-url http://localhost:8000
```


## Included tests
Some sample scripts that can be used to test this package can be found in the ```Software/MATLAB/test/unit``` directory. They also provide a guide to some of the package features.

## Network proxy configuration

Many corporate networks require Internet access to take place via a proxy server. This includes the traffic between a MATLAB® session and Amazon.

Within the MATLAB environment it is possible to specify the proxy settings using the web section of the preferences panel as shown:

![Preferences_Panel](Images/prefspanel.png)   


Often a username and password are not required.
In Windows it is also possible to specify the proxy settings in Control Panel / Internet Options / Connections tab.

Other operating systems have similar network preference controls. Depending on the network environment the proxy settings may also be configured automatically. However, by default the Client will only use a proxy server once configured to do so. Furthermore a complex proxy environment may use different proxies for different traffic types and destinations.

A proxy is configured using the a ClientConfiguration object which is a property of the client. When the client is create if a proxy is configured in the MATLAB proxy configuration preferences then these values will be used and applied when the client is initialized. On Windows, were these not provided in the MATLAB preferences the Windows proxy settings would be used instead. Thus no intervention is required. However it is possible to override the preferences and set proxy related values or reload values based on updated preferences to use a specific proxy and port as follows. Note, this does not alter the settings in the MATLAB preferences panel.
```
client.clientConfiguration.setProxyHost('proxyHost','myproxy.example.com');
client.clientConfiguration.setProxyPort(8080);
```
The client is now configured to use the proxy settings given rather than those in the MATLAB preferences panel. In this case a username and password are not provided. They are normally not required for proxy access.

Specify an automatic configuration URL as follows:
```
client.clientConfiguration.setProxyHost('autoURL','https://myexampleurl.amazonaws.com');
client.clientConfiguration.setProxyPort('https://myexampleurl.amazonaws.com');
```
This instructs the client to request a proxy port and host based on traffic to
https://myexampleurl.amazonaws.com. Note, this is not the URL of the proxy itself. Different proxies may be in place to cover traffic to different addresses, so it should be a valid Amazon URL and may need to correspond to the service being used. By default https://s3.amazonaws.com is used.

To use the username and password from the MATLAB preferences call:
```
client.clientConfiguration.setProxyUsername();
client.clientConfiguration.setProxyPassword();
```
Or to specify a username and password directly call:
```
client.clientConfiguration.setProxyUsername('myProxyUsername');
client.clientConfiguration.setProxyPassword('myProxyPassword');
```

If a proxy server is being used, then the proxy values need to be configured as shown, this should be done before the client is initialized.


[//]: #  (Copyright 2019 The MathWorks, Inc.)
