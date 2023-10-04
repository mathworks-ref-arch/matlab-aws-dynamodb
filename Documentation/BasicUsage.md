# Basic Usage

For brevity and readability, this document includes key sections of code only, with an emphasis on clarity rather than performance or conciseness. For more complete examples refer to the included test examples or the references listed below. Concepts such as the underlying data model or expression syntax are not explained, please refer to the Amazon DynamoDB documentation for such detail.

## Creating a client
The first step is to create a client to connect to DynamoDB. The client should then be initialized in order to authenticate it. See [Authentication](Authentication.md) for details on providing authentication credentials.

```matlab
ddbClient = aws.dynamodbv2.AmazonDynamoDBClient();
% Read credentials from a JSON file rather than the AWS provider chain
ddbClient.useCredentialsProviderChain = false;
ddbClient.initialize();
```

The previous steps create a ```AmazonDynamoDBClient``` client, This can be used to create a document API client as follows:
```matlab
dynamoDB = aws.dynamodbv2.document.DynamoDB(ddbClient);
```

## Creating a table
Tables are the top-level containers in a DynamoDB database. All items are contained in tables. Before adding any data to a database a table must be create to hold it. The following properties of a table must be defined:
* A name that is unique in the account and region.
* A primary key, which is unique for all items in the table. The key may be a single partition hash key or a composite key consisting of a partition and sort key. Key types are defined as a ScalarAttributeType and may be binary (B), String (S) or Numeric (N).
* ProvisionedThroughput, which defines the read and write performance of the table. Note, pricing is related to throughput.

AWS provides naming rules and data type guidelines: [https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.NamingRulesDataTypes.html](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.NamingRulesDataTypes.html)
If a table with the name you chose already exists, an AmazonServiceException is thrown.

The client's createTable method is used create a new table. First construct table attributes and a table schema, which identify the primary key of the table. Also set provisioned throughput values and the table name.

```matlab
% set the table and attribute names
tableName = 'myTableTest';
attributeName = 'Name';

% configure a TableCreateRequest
createTableRequest = aws.dynamodbv2.model.CreateTableRequest();

% set the table name
createTableRequest.setTableName(tableName);

% set the provisioned throughput
pt = aws.dynamodbv2.model.ProvisionedThroughput(uint64(10), uint64(10));
createTableRequest.setProvisionedThroughput(pt);

% configure an attribute definition
% a simple hash single partition hash
ad = aws.dynamodbv2.model.AttributeDefinition();
ad.setAttributeName(attributeName);
% The attribute is of ScalarAttributeType type String
ad.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.S);
createTableRequest.setAttributeDefinitions([ad]);

% create a key element schema for the attribute
kse = aws.dynamodbv2.model.KeySchemaElement(attributeName, aws.dynamodbv2.model.KeyType.HASH);
createTableRequest.setKeySchema([kse]);

% create the table
createResult = ddbClient.createTable(createTableRequest);
```

Create a table with the document API as follows:
```matlab
table = dynamoDB.createTable(createTableRequest);
```


## Table state
A table can be in 4 states:
* ACTIVE
* UPDATING
* DELETING
* CREATING

In order to perform certain operations the table must be in a specific state. For example in order to delete a table it must first be in the ACTIVE state. Tables are normally in the ACTIVE state.

## Deleting a table
The following code shows how to get the current state of a table and then wait for it to transition to the ACTIVE state before attempting to delete it. Deleting a table is normally an infrequent operation so a slight delay in this case is normally not a concern.

```matlab
status = '';
while ~strcmp(status, 'ACTIVE')
    describeResult = ddbClient.describeTable(tableName);
    tableDescription = describeResult.getTable();
    status = tableDescription.getTableStatus();
    if ~strcmp(status, 'ACTIVE')
        pause(5);
    end
end
deleteResult = ddbClient.deleteTable(tableName);
```

The document API provides a more convenient blocking call on a Table object to wait on the completion of the delete.
```matlab
table.deleteTable();
table.waitForDelete();
```

## Putting items
The following code steps through the process of putting data in to a table. It builds a table of the following form:

| Cellists |            |        |
|----------|------------|--------|
| *Name*   | *Language* | *Born* |
| Pau      | ca         | 1876   |

The table name is *Cellists* and there is one entry with 3 values for Name, Language and Born.

```matlab
% create a  containers.Map for the item names and values
% where the values are of type AttributeValue
keys = {'Name', 'Language', 'Born'};
av1 = aws.dynamodbv2.model.AttributeValue();
av1.setS('Pau');
av2 = aws.dynamodbv2.model.AttributeValue();
av2.setS('ca');
av3 = aws.dynamodbv2.model.AttributeValue();
% DynamoDB stores numbers as strings
av3.setN(num2str(1876));
values = {av1, av2, av3};
attributeValues = containers.Map(keys, values);

% configure an attribute definition and key element schema for
% the primary key only, it is of ScalarAttributeType String.
ad1 = aws.dynamodbv2.model.AttributeDefinition();
ad1.setAttributeName(keys{1});
ad1.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.S);
createTableRequest.setAttributeDefinitions([ad1]);

% check that the table is in the ACTIVE state, before putting

% build a put request using the table name the containers.Map previously created
putItemRequest = aws.dynamodbv2.model.PutItemRequest(tableName, attributeValues);
% put the values using the request object
putItemResult = ddbClient.putItem(putItemRequest);
```
You can find roughly equivalent Java code here: [https://github.com/awsdocs/aws-doc-sdk-examples/blob/master/java/example_code/dynamodb/src/main/java/aws/example/dynamodb/PutItem.java](https://github.com/awsdocs/aws-doc-sdk-examples/blob/master/java/example_code/dynamodb/src/main/java/aws/example/dynamodb/PutItem.java)


In the following sample code the document API is used to *put* an item into a table:
```matlab
% use the document API to create the table
table = dynamoDB.createTable(createTableRequest);
% check the table is ACTIVE
table.waitForActive();

% create an item with various properties
item = aws.dynamodbv2.document.Item();
item.withPrimaryKey('Id', 120);
item.withString('Title', 'Book 120 Title');
item.withString('ISBN', '120-1111111111');
item.withStringSet('Authors', {'Author12', 'Author22'});
item.withDouble('Price', 20);
item.withString('Dimensions', '8.5x11.0x.75');
item.withInt('PageCount', int32(500));
item.withBoolean('InPublication', false);
item.withString('ProductCategory', 'Book');

% add the item to the table
putItemOutcome = table.putItem(item);
```


You can find roughly equivalent Java code here: [https://github.com/aws-samples/aws-dynamodb-examples/blob/master/src/main/java/com/amazonaws/codesamples/lowlevel/LowLevelItemCRUDExample.java](https://github.com/aws-samples/aws-dynamodb-examples/blob/master/src/main/java/com/amazonaws/codesamples/lowlevel/LowLevelItemCRUDExample.java)

## Getting items
Having put data into a table the next step is to retrieve that data. This is done using the ```getItem``` client method, having first built a ```GetItemRequest``` object to specify the item.

```matlab
% configure a GetItemRequest
% build a containers.Map object that is made up of the primary key value
% and attribute value, following from the previous put example:
primaryKey = 'Name';
attributeValue = aws.dynamodbv2.model.AttributeValue();
attributeValue.setS('Pau');
itemToGet = containers.Map(primaryKey, {attributeValue});

% create the request also providing the table name
getItemRequest = aws.dynamodbv2.model.GetItemRequest(tableName, itemToGet);

% at this point a ProjectionExpression or ConsistentRead model could also be set

% get the item result and get the item from that
getItemResult = ddbClient.getItem(getItemRequest);
itemResult = getItemResult.getItem();

% examine the item which is returned as a containers.Map of keys and AttributeValues
% the results are unordered
resultKeys = itemResult.keys;
resultValues = itemResult.values;

resultKeys{1}
ans =
    'Born'

% note DynamoDB returns numbers as strings, which are converted to a character vector
resultValues{1}.getN()
ans =
    '1876'
```

The following sample code uses the document API to get item properties from a table. Getting an item that does not exist will return an empty logical array.
```matlab
% build a GetItemSpec object to describe what should be returned
getItemSpec = aws.dynamodbv2.document.spec.GetItemSpec();
% get a consistent read
getItemSpecResult = getItemSpec.withConsistentRead(true);
getItemSpecResult = getItemSpec.withPrimaryKey('Id', 120);
getItemSpecResult = getItemSpec.withProjectionExpression('Id, ISBN, Title, Price, Authors, InPublication, PageCount');
getItemResult = table.getItem(getItemSpec);

tf = getItemResult.getBoolean('InPublication');
price = getItemResult.getDouble('Price');
pageCount = getItemResult.getInt('PageCount');
ISBN = getItemResult.getString('ISBN');
Authors = getItemResult.getStringSet('Authors');
```

## List tables
Having created tables it is useful to be able to list the tables in an account. Note the AWS console interface can be used to examine tables interactively. This is accomplished using the client's ```listTables``` method. This method accepts a ```ListTablesRequest``` which has methods to allow the Limit and ExclusiveStartTableName to be set. ```setLimit``` sets the A maximum number of table names to return. ```setExclusiveStartTableName``` sets the first table name that this operation will evaluate. This is used when handling paginated results.

```matlab
% a simple request with setting the limit or start table name
listRequest = aws.dynamodbv2.model.ListTablesRequest();
listResult = ddbClient.listTables(listRequest);

% check if a LastEvaluatedTableName is set
last = listResult.getLastEvaluatedTableName()
last =
  0×0 empty char array

% list the tables
list = listResult.getTableNames()
list =
  2×1 cell array
    {'table1'}
    {'table2'}
```
The output from ```listTables``` is paginated, with each page returning a maximum of 100 table names, assuming a lower limit has not been set. Thus to return the next page the ```LastEvaluatedTableName``` (if set) should be used as the ```ExclusiveStartTableName``` for the subsequent call.

Using the document API a list of tables can be returned as a cell array of Table objects:
```
tables = dynamoDB.listTables();
```

## Query items

The following sample code uses the low-level API to query a table. It assumes a table has been created of the following form, with *Language* set to be the partition key.

  | tableName  |            |
  |------------|------------|
  | *Language* | *Greeting* |
  | eng        | hello      |
  | fr         | bonjour    |

In this example just one value is queried, *eng*, however multiple values can be queried by setting more *ExpressionAttributeValues*

```matlab
% create & configure  the query request object
queryRequest = aws.dynamodbv2.model.QueryRequest();
queryRequest.setTableName(tableName);
% check that the key is equal to 'Language'
queryRequest.setKeyConditionExpression(['#a = :', 'Language']);

% set the attribute name to the partition key, i.e. 'Language'
attrName = containers.Map({'#a'}, {'Language'});
queryRequest.setExpressionAttributeNames(attrName);

% set an attribute value and build a containers.Map
attrValue = aws.dynamodbv2.model.AttributeValue();
% set the value to be queried to a DynamoDB string value for 'eng'
attrValue.setS('eng');
attrValues = containers.Map({[':','Language']}, {attrValue});
queryRequest.setExpressionAttributeValues(attrValues);

% run the query
queryResult = ddbClient.query(queryRequest);
```
Calling the ```getCount()``` method on *queryResult* in this case will return 1.


To query a table using the document API first build a QuerySpec object and then run the query. The results are returned as a cell array of items.
```matlab
querySpec = aws.dynamodbv2.document.spec.QuerySpec();
querySpec.withConsistentRead(true);
querySpec.withKeyConditionExpression('Id = :v_id');
valueMap = containers.Map({':v_id'}, {121});
querySpec.withValueMap(valueMap);

% run the query, queryOutcomeItems is a cell array of items
queryOutcomeItems = table.query('querySpec', querySpec);

% return the string corresponding to the attribute name 'NewAttribute'
attrVal = queryOutcomeItems{1}.getString('NewAttribute');
```

A related example can be found here: [https://github.com/aws-samples/aws-dynamodb-examples/blob/master/src/main/java/com/amazonaws/codesamples/document/DocumentAPIQuery.java](https://github.com/aws-samples/aws-dynamodb-examples/blob/master/src/main/java/com/amazonaws/codesamples/document/DocumentAPIQuery.java)


## Update items
Again it is assumed the following table exists with *Language* set to be the partition key.

  | Language | Greeting |
  |----------|----------|
  | eng      | hello    |
  | fr       | bonjour  |

The following sample code will update the *bonjour* value to *ca va*.

```matlab
% build an item key for the *fr Language* entry
frAV = aws.dynamodbv2.model.AttributeValue();
frAV.setS('fr');
frItemKey = containers.Map({'Language'}, {frAV});

% create and attribute value for the new greeting value
cavaAV = aws.dynamodbv2.model.AttributeValue();
cavaAV.setS('ca va');
expressionAttributeValues = containers.Map({':val1'}, {cavaAV});

% create a  *UpdateItemRequest*
updateItemRequest = aws.dynamodbv2.model.UpdateItemRequest();
updateItemRequest.setTableName(tableName);
updateItemRequest.setKey(frItemKey);
% set the new value to the expressionAttributeValue corresponding to val1
updateItemRequest.setUpdateExpression('set Greeting = :val1');
updateItemRequest.setExpressionAttributeValues(expressionAttributeValues);
returnValues = aws.dynamodbv2.model.ReturnValue.ALL_NEW;
updateItemRequest.setReturnValues(returnValues);

% do the update
updateItemResult = ddbClient.updateItem(updateItemRequest);
```

A condition expression can also be specified in which case the update will only happen if the condition is matched, in this case if the greeting matches the values specified in an additional expressionAttributeValue entry, val2.
```matlab
updateItemRequest.setConditionExpression('Greeting = :val2')
```

Updating an item, in this case by adding an attribute, using the document API can be accomplished as follows:
```matlab
% build an UpdatItemSpec object
updateItemSpec =  aws.dynamodbv2.document.spec.UpdateItemSpec();
% specify the primary key
updateItemSpec.withPrimaryKey('Id', 121);
% in this case add a new attribute to the item
updateItemSpec.withUpdateExpression('set #na = :val1');
updateItemSpec.withReturnValues(aws.dynamodbv2.model.ReturnValue.ALL_NEW);
% call the new attribute NewAttribute
nameMap = containers.Map({'#na'}, {'NewAttribute'});
updateItemSpec.withNameMap(nameMap);
% set the attribute value to 'Some Value'
valueMap = containers.Map({':val1'}, {'Some Value'});
updateItemSpec.withValueMap(valueMap);
% trigger the update
updateItemOutcome = table.updateItem('updateItemSpec', updateItemSpec);
```

## Update a table

Some properties of an existing table can be updated after they have been created. The following example changes the Provisioned Throughput for a table. This may be necessary due to seasonal changes in demand for example. This example primarily uses the low-level API.

```matlab
% create a request object that is used to configure the changes
updateTableRequest = aws.dynamodbv2.model.UpdateTableRequest();

% set the table to which the update will be applied
updateTableRequest.setTableName(tableName);

% create a ProvisionedThroughput object with the desired new values
pt = aws.dynamodbv2.model.ProvisionedThroughput(uint64(6), uint64(7));
updateTableRequest.setProvisionedThroughput(pt);

% apply the update
updateTableResult = ddb.updateTable(updateTableRequest);

% updateTable is an asynchronous call
% at this point the table will go into the UPDATING state, wait until it
% goes back to ACTIVE before continuing to us it.
% here the document API waitForActive call is used to poll the status change
table.waitForActive();
```

Using the document API the same change can be applied as follows:
```matlab
pt = aws.dynamodbv2.model.ProvisionedThroughput(uint64(6), uint64(7));
updateTableResult = table.updateTable(pt);
table.waitForActive();
```

## Delete an item

Delete an item using the document API by building a DeleteItemSpec object that specifies the primary key:
```matlab
deleteItemSpec = aws.dynamodbv2.document.spec.DeleteItemSpec();
pKey = aws.dynamodbv2.document.PrimaryKey();
pKey.addComponent('Id', 120);
deleteItemSpec.withPrimaryKey(pKey);
deleteItemOutcome = table.deleteItem(deleteItemSpec);
```


## References
Full details of the supported API can be found in the [API Documentation](DynamoDBApiDoc.md). The following documents are also helpful and provide more information about the underlying service and SDK:

* [https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html)

* [https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/examples-dynamodb-tables.html](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/examples-dynamodb-tables.html)
* [https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/)
* [https://github.com/awsdocs/aws-doc-sdk-examples/tree/master/java/example_code/dynamodb/src/main/java/aws/example/dynamodb](https://github.com/awsdocs/aws-doc-sdk-examples/tree/master/java/example_code/dynamodb/src/main/java/aws/example/dynamodb)


[//]: #  (Copyright 2019-2021 The MathWorks, Inc.)
