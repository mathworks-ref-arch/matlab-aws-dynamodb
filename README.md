# MATLAB Interface *for Amazon DynamoDB*

MATLAB® interface for the Amazon Web Services DynamoDB™ service. DynamoDB is a managed NoSQL database service that provides high performance and scalability. This package provides a basic interface to a subset of DynamoDB features from within MATLAB. Both the low-level interface and the higher-level *document* interfaces are supported. Calls to both interfaces can be used together.

The complete DynamoDB is API very large. This package implements common CRUD related objects and operations such as listing, querying, updating and deleting of items and tables and does not cover the complete API. If additional features and methods would be helpful to you please submit an enhancement request as detailed below.

## Requirements
### MathWorks products
* Requires MATLAB release R2017a or later.
* AWS Common utilities found at https://github.com/mathworks-ref-arch/matlab-aws-common

### 3rd party products
* Amazon Web Services account   

To build a required JAR file:   
* [Maven](https://maven.apache.org/)
* JDK 7
* [AWS SDK for Java](https://aws.amazon.com/sdk-for-java/) (version 1.11.367 or later)

## Getting Started
Please refer to the [Documentation](Documentation/README.md) to get started.
The [Installation Instructions](Documentation/Installation.md) and [Getting Started](Documentation/GettingStarted.md) documents provide detailed instructions on setting up and using the interface. The easiest way to
fetch this repository and all required dependencies is to clone the top-level repository using:

```bash
git clone --recursive https://github.com/mathworks-ref-arch/mathworks-aws-support.git
```

### Build the AWS SDK for Java components
The MATLAB code uses the AWS SDK for Java and can be built using:
```bash
cd Software/Java
mvn clean package
```

Once built, use the ```/Software/MATLAB/startup.m``` function to initialize the interface which will use the AWS Credentials Provider Chain to authenticate. Please see the [relevant documentation](Documentation/Authentication.md) on how to specify the credentials.

### Create a table
This example uses the lower-level ```AmazonDynamoDBClient``` interface.

```matlab
%% Create the client, authenticate using the AWS provider chain
ddb = aws.dynamodbv2.AmazonDynamoDBClient;
ddb.initialize();

%% Build a CreateTableRequest
% Create the request and set the name
tableName = 'myTableName';
createTableRequest = aws.dynamodbv2.model.CreateTableRequest();
createTableRequest.setTableName(tableName);

% Set the read and write throughput
pt = aws.dynamodbv2.model.ProvisionedThroughput(uint64(10), uint64(10));
createTableRequest.setProvisionedThroughput(pt);

% Set a table attribute
attributeName = 'myAttributeName';
ad = aws.dynamodbv2.model.AttributeDefinition();
ad.setAttributeName(attributeName);
ad.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.S);
createTableRequest.setAttributeDefinitions([ad]);

% Set a key schema
kse = aws.dynamodbv2.model.KeySchemaElement(attributeName, aws.dynamodbv2.model.KeyType.HASH);
createTableRequest.setKeySchema([kse]);

%% Create the table
createTableResult = ddb.createTable(createTableRequest);

%% Wait for the Table to enter an ACTIVE state
status = '';
while ~strcmp(status, 'ACTIVE')
    describeResult = ddb.describeTable(tableName);
    tableDescription = describeResult.getTable();
    status = tableDescription.getTableStatus();
    if ~strcmp(status, 'ACTIVE')
        pause(5);
    end
end

%% Describe the table
tableDescription = createTableResult.getTableDescription();
name = tableDescription.getTableName();
arn = tableDescription.getTableArn();
status = tableDescription.getTableStatus();
count = tableDescription.getItemCount();
size = tableDescription.getTableSizeBytes();

% Check the throughput
throughputInfo = tableDescription.getProvisionedThroughput();
readCapacity = throughputInfo.getReadCapacityUnits;
writeCapacity = throughputInfo.getWriteCapacityUnits;

% Check the attributes
attributes = tableDescription.getAttributeDefinitions();

%% Cleanup
% Delete the table and the client
ddb.deleteTable(tableName);
ddb.shutdown();
```

## Create a table, using the document interface
The document interface is a higher-level interface.
 ```matlab
 %% Create a client from which to create a DynamoDB object
 ddbClient = aws.dynamodbv2.AmazonDynamoDBClient;
 ddbClient.initialize();

 %% Create the document API DynamoDB object
 ddb = aws.dynamodbv2.document.DynamoDB(ddbClient);

 %% Configure names
 tableName = 'myTableName';
 attributeName = 'Id';

 %% Configure an attribute definition, provisioned throughput and key element schema
 ad = aws.dynamodbv2.model.AttributeDefinition();
 ad.setAttributeName(attributeName);
 ad.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.N);
 kse = aws.dynamodbv2.model.KeySchemaElement(attributeName, aws.dynamodbv2.model.KeyType.HASH);
 pt = aws.dynamodbv2.model.ProvisionedThroughput(uint64(5), uint64(5));

 %% Create a createTableRequest from these
 createTableRequest = aws.dynamodbv2.model.CreateTableRequest();
 createTableRequest.setTableName(tableName);
 createTableRequest.setAttributeDefinitions([ad]);
 createTableRequest.setProvisionedThroughput(pt);
 createTableRequest.setKeySchema([kse]);

 %% Use the document API to create the table
 table = ddb.createTable(createTableRequest);

 %% Wait until the table is active to use it
 table.waitForActive();

 ```

## Supported Products:
1. [MATLAB](https://www.mathworks.com/products/matlab.html) (R2017a or later)
2. [MATLAB Compiler™](https://www.mathworks.com/products/compiler.html) and [MATLAB Compiler SDK™](https://www.mathworks.com/products/matlab-compiler-sdk.html) (R2017a or later)
3. [MATLAB Production Server™](https://www.mathworks.com/products/matlab-production-server.html) (R2017a or later)
4. [MATLAB Parallel Server™](https://www.mathworks.com/products/distriben.html) (R2017a or later)

## License
The license for the MATLAB Interface *for Amazon DynamoDB* is available in the [LICENSE.md](LICENSE.md) file in this GitHub repository. This package uses certain third-party content which is licensed under separate license agreements. See the [pom.xml](Software/Java/pom.xml) file for third-party software downloaded at build time.

## Enhancement Request
Provide suggestions for additional features or capabilities using the following link:   
https://www.mathworks.com/products/reference-architectures/request-new-reference-architectures.html

## Support
Email: `mwlab@mathworks.com` or please log an issue.

[//]: #  (Copyright 2019-2021 The MathWorks, Inc.)
