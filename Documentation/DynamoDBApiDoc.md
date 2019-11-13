# MATLAB Interface *for AWS DynamoDB* API documentation


## AWS DynamoDB Interface Objects and Methods:
* @AmazonDynamoDBClient



------

## @AmazonDynamoDBClient

### @AmazonDynamoDBClient/AmazonDynamoDBClient.m
```notalanguage
  CLIENT Object to represent an AWS DynamoDB client
  The client is used to carry out operations with the DynamoDB service
 
  Example:
     % Create client
     ddb = aws.dynamodbv2.AmazonDynamoDBClient;
     % Initialize the client
     ddb.initialize();
     % Use the client to carry out actions on DynamoDB
     createTableRequest = aws.dynamodbv2.model.CreateTableRequest();
     createTableRequest.setTableName(tableName);
     createResult = ddb.createTable(createTableRequest);
     % Shutdown the client when no longer needed
     ddb.shutdown();
```
### @AmazonDynamoDBClient/createTable.m
```notalanguage
  CREATETABLE Creates a table
  The CreateTable operation adds a new table to an account. In an AWS account,
  Table names must be unique within each region.
  The table is created based on the configuration of a CreateTableRequest object.
  CreateTable is an asynchronous operation. Upon receiving a CreateTable request,
  DynamoDB immediately returns a response with a TableStatus of CREATING.
  After the table is created, DynamoDB sets the TableStatus to ACTIVE.
  Read and write operations can only be performed on an ACTIVE table.
  A CreateTableResult object is returned. You can use the DescribeTable method
  to check the table status.
```
### @AmazonDynamoDBClient/deleteItem.m
```notalanguage
  DELETEITEM Deletes an item from a table
  The table name is specified as a character vector and the items to be deleted
  are specified using a containers.Map
  A DeleteItemResult object is returned
```
### @AmazonDynamoDBClient/deleteTable.m
```notalanguage
  DELETETABLE Deletes a table
  The table name is specified as a character vector. A DeleteTableResult object
  is returned.
```
### @AmazonDynamoDBClient/describeTable.m
```notalanguage
  DESCRIBETABLE Describes a table
  The table name is specified as a character vector. A DescribeTableResult object
  is returned. This methods can be used to get the status of a table.
 
  Example:
     describeResult = ddb.describeTable(tableName);
     tableDescription = describeResult.getTable();
     status = tableDescription.getTableStatus();
```
### @AmazonDynamoDBClient/getItem.m
```notalanguage
  GETITEM Returns attributes for an item with a given primary key
  The GetItem operation returns a set of attributes for the item with the given
  primary key. If there is no matching item, GetItem does not return any data
  and there will be no Item element in the response. The request is specified
  using a GetItemRequest object
  GetItem provides an eventually consistent read by default. If your application
  requires a strongly consistent read, set ConsistentRead to true. Although a
  strongly consistent read might take more time than an eventually consistent
  read, it always returns the last updated value.
  A GetItemResult object is returned.
```
### @AmazonDynamoDBClient/initialize.m
```notalanguage
  INITIALIZE Configure the MATLAB session to connect to DynamoDB
  Once a client has been configured, initialize is used to validate the
  client configuration and initiate the connection to DynamoDB
 
  Example:
     ddb = aws.dynamodbv2.AmazonDynamoDBClient();
     ddb.intialize();
```
### @AmazonDynamoDBClient/listTables.m
```notalanguage
  LISTTABLES List Tables in an account
  Returns an array of table names associated with the current account and
  endpoint. The output from ListTables is paginated, with each page returning a
  maximum of 100 table names.
  A listTablesResult object is returned.
```
### @AmazonDynamoDBClient/putItem.m
```notalanguage
  PUTITEM Creates a new item, or replaces an old item with a new item
  If an item that has the same primary key as the new item already exists in
  the specified table, the new item completely replaces the existing item.
  Conditional put operations (add a new item if one with the specified primary
  key doesn't exist), or replace an existing item if it has certain
  attribute values can be performed. A PutItemResult object is returned.
```
### @AmazonDynamoDBClient/query.m
```notalanguage
  QUERY Finds items based on primary key values
  Any table or secondary index that has a composite primary key (a partition key
  and a sort key) can be queried. Use the KeyConditionExpression parameter to
  provide a specific value for the partition key.
  The Query operation will return all of the items from the table or index with
  that partition key value. You can optionally narrow the scope of the Query
  operation by specifying a sort key value and a comparison operator in
  KeyConditionExpression. To further refine the Query results, optionally
  provide a FilterExpression.
  Query results are always sorted by the sort key value. If the data type of the
  sort key is Number, the results are returned in numeric order; otherwise, the
  results are returned in order of UTF-8 bytes. By default, the sort order is
  ascending. If LastEvaluatedKey is the response, you will need to paginate the
  results. FilterExpression is applied after a Query finishes, but before the
  results are returned. A FilterExpression cannot contain partition key or sort key
  attributes. Specify those attributes in the KeyConditionExpression. A Query
  operation can return an empty result set and a LastEvaluatedKey if all the
  items read for the page of results are filtered out. You can query a table, a
  local secondary index, or a global secondary index. For a query on a table or
  on a local secondary index, you can set the ConsistentRead parameter to true
  and obtain a strongly consistent result. Global secondary indexes support
  eventually consistent reads only, so do not specify ConsistentRead when
  querying a global secondary index. A QueryResult object is returned.
```
### @AmazonDynamoDBClient/shutdown.m
```notalanguage
  SHUTDOWN Method to shutdown a client and release resources
  This method should be called to cleanup a client which is no longer
  required.
 
  Example:
     ddb = aws.dynamodbv2.Client;
     % Perform operations using the client then shutdown
     ddb.shutdown;
```
### @AmazonDynamoDBClient/updateItem.m
```notalanguage
  UPDATEITEM Edits an existing item's attributes, or adds a new item to the table
  Enables put, delete, or adding attribute values. Conditional updates on an
  existing item (insert a new attribute name-value pair if it doesn't exist,
  or replace an existing name-value pair if it has certain expected attribute
  values) can be performed.
  Return the item's attribute values in the same UpdateItem operation using the
  ReturnValues parameter. A UpdateItemResult object is returned.
```
### @AmazonDynamoDBClient/updateTable.m
```notalanguage
  UPDATETABLE Modifies Table properties
  Modifies the provisioned throughput settings, global secondary indexes, or
  DynamoDB Streams (not currently supported) settings for a given table.
  Only perform one of the following operations can be performed at once:
   * Modify the provisioned throughput settings of the table.
   * Enable or disable Streams on the table.
   * Remove a global secondary index from the table.
   * Create a new global secondary index on the table. Once the index begins
     backfilling, you can use UpdateTable to perform other operations.
 
  UpdateTable is an asynchronous operation; while it is executing, the table
  status changes from ACTIVE to UPDATING. While it is UPDATING, you cannot issue
  another UpdateTable request. When the table returns to the ACTIVE state, the
  UpdateTable operation is complete.
  A UpdateTableResult object is returned.
```

------
## AWS DynamoDB Interface +model Objects and Methods:
* @AttributeAction
* @AttributeDefinition
* @AttributeValue
* @CreateTableRequest
* @CreateTableResult
* @DeleteItemResult
* @DeleteTableResult
* @DescribeTableResult
* @GetItemRequest
* @GetItemResult
* @KeySchemaElement
* @KeyType
* @ListTablesRequest
* @ListTablesResult
* @ProvisionedThroughput
* @ProvisionedThroughputDescription
* @PutItemRequest
* @PutItemResult
* @QueryRequest
* @QueryResult
* @ReturnValue
* @ScalarAttributeType
* @TableDescription
* @UpdateItemRequest
* @UpdateItemResult
* @UpdateTableRequest
* @UpdateTableResult



------

## @AttributeAction

### @AttributeAction/AttributeAction.m
```notalanguage
  ATTRIBUTEACTION Enumeration of attribute actions
  Possible values are: ADD, PUT or DELETE
  a toJava() method returns the equivalent Java enumeration.
```

------


## @AttributeDefinition

### @AttributeDefinition/AttributeDefinition.m
```notalanguage
  ATTRIBUTEDEFINITION Object to represent an attribute definition
  An AttributeDefinition is constructed based on the equivalent underlying
  Java SDK object.
```
### @AttributeDefinition/getAttributeName.m
```notalanguage
  GETATTRIBUTENAME Returns the name of a attribute as a character vector
```
### @AttributeDefinition/setAttributeName.m
```notalanguage
  SETATTRIBUTENAME Sets the name of an attribute
  The name should be provided as a character vector
```
### @AttributeDefinition/setAttributeType.m
```notalanguage
  SETATTRIBUTENAME Sets the type of an attribute
  The type should be provided as a ScalarAttributeType.
```

------


## @AttributeValue

### @AttributeValue/AttributeValue.m
```notalanguage
  ATTRIBUTEVALUE Constructs a new AttributeValue object
  An AttributeValue is constructed based on the equivalent underlying
  Java SDK object.
 
  Example:
     % Constructor calls:
     attributeValue = AttributeValue();
     attributeValue = AttributeValue(AttributeValueJavaObject);
     attributeValue = AttributeValue('myAttributeStr');
```
### @AttributeValue/getB.m
```notalanguage
  GETB Gets an attribute of type binary
  Result is returned as a uint8.
```
### @AttributeValue/getBOOL.m
```notalanguage
  GETBOOL Gets an attribute of type Boolean
  Result is returned as a logical.
```
### @AttributeValue/getN.m
```notalanguage
  GETN Gets an attribute of type Number
  Result is returned as a character vector
```
### @AttributeValue/getNS.m
```notalanguage
  GETNS Gets a set of attributes of type Number
  Result is returned as a cell array of character vectors.
```
### @AttributeValue/getNULL.m
```notalanguage
  GETNULL gets an attribute of type NULL which may be true or false
  Result is returned as a logical.
```
### @AttributeValue/getS.m
```notalanguage
  GETS gets an attribute of type String
  Result is returned as a character vector.
```
### @AttributeValue/getSS.m
```notalanguage
  GETSS gets a set of attributes of type String
  Result is returned as a cell array of character vectors.
```
### @AttributeValue/isBOOL.m
```notalanguage
  ISBOOL Returns a logical value denoting if an attribute is of type Boolean
```
### @AttributeValue/isNULL.m
```notalanguage
  ISNULL Returns a logical value denoting if an attribute is of type Null
```
### @AttributeValue/setB.m
```notalanguage
  SETB An attribute of type Binary
  B is of type uint 8
  Attribute must be greater than less than 400KB in size. If a primary key
  attribute is defined as a binary type attribute, the following additional
  constraints apply:
   *  For a simple primary key, the maximum length of the first attribute value
      (the partition key) is 2048 bytes.
   *  For a composite primary key, the maximum length of the second attribute
      value (the sort key) is 1024 bytes.
```
### @AttributeValue/setBOOL.m
```notalanguage
  SETBOOL An attribute of type Boolean
  B is of type logical.
```
### @AttributeValue/setN.m
```notalanguage
  SETN Sets an attribute of type Number
  N should be of type character vector.
```
### @AttributeValue/setNS.m
```notalanguage
  SETNS Set a cell array of attributes of type Number
  Cell array entries should be of type character vector
```
### @AttributeValue/setNULL.m
```notalanguage
  SETNULL Sets an attribute of type NULL
  N should be of type logical.
```
### @AttributeValue/setS.m
```notalanguage
  SETS An attribute of type String
  S is of type character vector
```
### @AttributeValue/setSS.m
```notalanguage
  SETSS Set a cell array of attributes of type String
  Cell array entries should be of type character vector.
```

------


## @CreateTableRequest

### @CreateTableRequest/CreateTableRequest.m
```notalanguage
  CREATETABLEREQUEST Object to represent a createTable request
```
### @CreateTableRequest/setAttributeDefinitions.m
```notalanguage
  SETATTRIUTEDEFINITIONS Set attributesDefinitions that describe the key schema
  attributesDefinitions are an array of attributesDefinitions that describe the key schema for the
  table and indexes.
```
### @CreateTableRequest/setKeySchema.m
```notalanguage
  SETKEYSCHEMA Specifies attributes of the primary key for a table or an index
```
### @CreateTableRequest/setProvisionedThroughput.m
```notalanguage
  SETPROVISIONEDTHROUGHPUT Sets the provisioned throughput of a table
  throughput should be provided as a ProvisionedThroughput object.
```
### @CreateTableRequest/setTableName.m
```notalanguage
  SETTABLENAME Sets the name of a table
  name should be of type character vector.
```

------


## @CreateTableResult

### @CreateTableResult/CreateTableResult.m
```notalanguage
  CREATETABLERESULT Object to represent a createTable result
```
### @CreateTableResult/getTableDescription.m
```notalanguage
  GETTABLEDESCRIPTION Gets the properties of the table
```

------


## @DeleteItemResult

### @DeleteItemResult/DeleteItemResult.m
```notalanguage
  DELETEITEMRESULT Object to represent a deleteItem result
```

------


## @DeleteTableResult

### @DeleteTableResult/DeleteTableResult.m
```notalanguage
  DELETETABLERESULT Object to represent a deleteTable result
```
### @DeleteTableResult/getTableDescription.m
```notalanguage
  GETTABLEDESCRIPTION Gets the properties of the table
```

------


## @DescribeTableResult

### @DescribeTableResult/DescribeTableResult.m
```notalanguage
  DESCRIBETABLERESULT Object to represent a describeTable result
```
### @DescribeTableResult/getTable.m
```notalanguage
  GETTABLE Get the properties of the table
  Returns a TableDescription object.
```

------


## @GetItemRequest

### @GetItemRequest/GetItemRequest.m
```notalanguage
  GETITEMREQUEST Object to represent a GetItem request
  If calling with table name and key arguments then the table name should be of
  type character vector and the key should be a containers.Map of keys and values
  of type AttributeValue.
 
  Example:
     % Constructors
     getItemRequest = GetItemRequest();
     getItemRequest = GetItemRequest(GetItemRequestJavaObject);
     getItemRequest = GetItemRequest(tableName, key);
```
### @GetItemRequest/getConsistentRead.m
```notalanguage
  GETCONSISTENTREAD Determines the read consistency model
  If set to true, then the operation uses strongly consistent reads.
  Otherwise, the operation uses eventually consistent reads. A logical is
  returned.
```
### @GetItemRequest/setConsistentRead.m
```notalanguage
  SETCONSISTENTREAD Sets the read consistency model
  If set to true, then the operation uses strongly consistent reads; otherwise,
  the operation uses eventually consistent reads.
```
### @GetItemRequest/setProjectionExpression.m
```notalanguage
  SETPROJECTIONEXPRESSSION Sets string that identifies attributes to retrieve
  The expression should be of type character vector.
```

------


## @GetItemResult

### @GetItemResult/GetItemResult.m
```notalanguage
  GETITEMRESULT Object to represent result of a GetItem
```
### @GetItemResult/getItem.m
```notalanguage
  GETITEM Returns a map of attribute names to AttributeValue objects
  The returned values are specified by ProjectionExpression.
  item is returned as a containers.Map
```

------


## @KeySchemaElement

### @KeySchemaElement/KeySchemaElement.m
```notalanguage
  KEYSCHEMAELEMENT Represents a single element of a key schema
  The attributeName should be provided as a character vector and the keyType
  should be provided as KeyType enum.
 
  Example:
     keySchemaElement = KeySchemaElement('myAttribName', aws.dynamodbv2.model.KeyType.HASH);
```

------


## @KeyType

### @KeyType/KeyType.m
```notalanguage
  KEYTYPE Enumeration of key types
  Possible values are HASH or RANGE. A to toJava method returns the Java
  equivalent.
```

------


## @ListTablesRequest

### @ListTablesRequest/ListTablesRequest.m
```notalanguage
  LISTTABLESREQUEST Object to represent a listTables request
```
### @ListTablesRequest/setExclusiveStartTableName.m
```notalanguage
  SETEXCLUSIVESTARTTABLENAME The first table name the operation will evaluate
  exclusiveStartTableName should be of type character vector.
```
### @ListTablesRequest/setLimit.m
```notalanguage
  SETLIMIT A maximum number of table names to return
  A minimum value of 1 and a maximum value of 100 are accepted.
```

------


## @ListTablesResult

### @ListTablesResult/ListTablesResult.m
```notalanguage
  LISTTABLESRESULT Object to represent result of a ListTables
```
### @ListTablesResult/getLastEvaluatedTableName.m
```notalanguage
  GETTABLENAME Returns name of the last table in the current page of results
  Result is returned as a character vector.
```
### @ListTablesResult/getTableNames.m
```notalanguage
  GETTABLENAMES Get names of tables associated with current account & endpoint
  The maximum size of this array is 100.
  A cell array of character vectors is returned.
```

------


## @ProvisionedThroughput

### @ProvisionedThroughput/ProvisionedThroughput.m
```notalanguage
  PROVISIONEDTHROUGHPUT Represents settings for a specified table or index
  The settings can be modified using the UpdateTable operation.
  For current minimum and maximum provisioned throughput values, see limits
  in the Amazon DynamoDB Developer Guide.
```

------


## @ProvisionedThroughputDescription

### @ProvisionedThroughputDescription/ProvisionedThroughputDescription.m
```notalanguage
  PROVISIONEDTHROUGHPUTDESCRIPTION Provisioned throughput table settings
  Consists of read and write capacity units.
```
### @ProvisionedThroughputDescription/getReadCapacityUnits.m
```notalanguage
  GETREADCAPACITYUNITS Returns the ReadCapacityUnits
  ReadCapacityUnits is the maximum number of strongly consistent reads consumed
  per second before DynamoDB returns a ThrottlingException.
  units is returned as a double.
```
### @ProvisionedThroughputDescription/getWriteCapacityUnits.m
```notalanguage
  GETWRITECAPACITYUNITS Returns WriteCapacityUnits
  WriteCapacityUnits is the maximum number of writes consumed per second before
  DynamoDB returns a ThrottlingException.
  units is returned as a double.
```

------


## @PutItemRequest

### @PutItemRequest/PutItemRequest.m
```notalanguage
  PUTITEMREQUEST Object to represent a PutItem request
 
  Example:
     putItemRequest = aws.dynamodbv2.model.PutItemRequest(tableName, attributeValues);
     putItemResult = ddb.putItem(putItemRequest);
```

------


## @PutItemResult

### @PutItemResult/PutItemResult.m
```notalanguage
  PUTITEMRESULT Object to represent result of a PutItem
```

------


## @QueryRequest

### @QueryRequest/QueryRequest.m
```notalanguage
  QUERYREQUEST Object to represent a query request
```
### @QueryRequest/setConsistentRead.m
```notalanguage
  SETCONSISTENTREAD Sets the read consistency model
  If set to true, then the operation uses strongly consistent reads; otherwise,
  the operation uses eventually consistent reads.
```
### @QueryRequest/setExpressionAttributeNames.m
```notalanguage
  SETEXPRESSIONATTRIBUTENAMES One or more substitution tokens for attribute names
```
### @QueryRequest/setExpressionAttributeValues.m
```notalanguage
  SETEXPRESSIONATTRIBUTEVALUES One or more values that can be substituted in an expression
```
### @QueryRequest/setKeyConditionExpression.m
```notalanguage
  SETKEYCONDITIONEXPRESSION Condition that specifies key value(s) for items
```
### @QueryRequest/setTableName.m
```notalanguage
  SETTABLENAME Sets the name of a table
```

------


## @QueryResult

### @QueryResult/QueryResult.m
```notalanguage
  QUERYRESULT Object to represent a query result
```
### @QueryResult/getCount.m
```notalanguage
  GETCOUNT The number of items in the response
  Result is returned as a double.
```
### @QueryResult/getItems.m
```notalanguage
  GETITEMS Returns a cell array of maps of attribute names to AttributeValues
  The returned values match the query criteria. Elements in the maps consist
  of attribute names and the values for that attribute.
  Items are returned as a cell array of containers.Maps.
```

------


## @ReturnValue

### @ReturnValue/ReturnValue.m
```notalanguage
  RETURNVALUE Enumeration of return values
  Possible values are: ALL_NEW, ALL_OLD, NONE, UPDATED_NEW or UPDATED_OLD
  A toJava()method is provided to return the Java equivalent enum.
```

------


## @ScalarAttributeType

### @ScalarAttributeType/ScalarAttributeType.m
```notalanguage
  SCALARATTRIBUTETYPE Enumeration of attribute types
  Possible values are B, N, or S. A toJava() method is provided to return
  the Java equivalent.
```

------


## @TableDescription

### @TableDescription/TableDescription.m
```notalanguage
  TABLEDESCRIPTION Represents the properties of a table
```
### @TableDescription/getAttributeDefinitions.m
```notalanguage
  GETATTRIBUTESDEFINITIONS Returns an array of AttributeDefinition objects
```
### @TableDescription/getItemCount.m
```notalanguage
  GETITEMCOUNT Returns the number of items in a table as a double
```
### @TableDescription/getProvisionedThroughput.m
```notalanguage
  GETPROVISIONTHROUGHOUT Returns the provisioned throughput of a table
  Result is returned as a aws.dynamodbv2.model.ProvisionedThroughputDescription
```
### @TableDescription/getTableArn.m
```notalanguage
  GETTABLEARN Returns the ARN of a table as a character vector
```
### @TableDescription/getTableName.m
```notalanguage
  GETTABLENAME Returns the name of a table as a character vector
```
### @TableDescription/getTableSizeBytes.m
```notalanguage
  GETTABLESIZEBYTES Returns the size of a table in bytes as a double
```
### @TableDescription/getTableStatus.m
```notalanguage
  GETTABLESTATUS Returns the status of a table as a character vector
```

------


## @UpdateItemRequest

### @UpdateItemRequest/UpdateItemRequest.m
```notalanguage
  UPDATEITEMREQUEST Object to represent a updateItem request
```
### @UpdateItemRequest/setConditionExpression.m
```notalanguage
  SETCONDITIONEXPRESSION Condition that specifies key value(s) for items
  conditionExpression should be of type character vector.
```
### @UpdateItemRequest/setExpressionAttributeNames.m
```notalanguage
  SETEXPRESSIONATTRIBUTENAMES One or more substitution tokens for attribute names
```
### @UpdateItemRequest/setExpressionAttributeValues.m
```notalanguage
  SETEXPRESSIONATTRIBUTEVALUES One or more values that can be substituted in an expression
```
### @UpdateItemRequest/setKey.m
```notalanguage
  SETKEY Sets primary key of the item to be updated
```
### @UpdateItemRequest/setReturnValues.m
```notalanguage
  SETRETURNVALUES
  returnValues should be of type aws.dynamodbv2.model.ReturnValue.
```
### @UpdateItemRequest/setTableName.m
```notalanguage
  SETTABLENAME Sets the name of a table
```
### @UpdateItemRequest/setUpdateExpression.m
```notalanguage
  SETUPDATEEXPRESSION Sets expression that defines one or more attributes to be updated
```

------


## @UpdateItemResult

### @UpdateItemResult/UpdateItemResult.m
```notalanguage
  UPDATEITEMRESULT Object to represent a updateItem result
```

------


## @UpdateTableRequest

### @UpdateTableRequest/UpdateTableRequest.m
```notalanguage
  UPDATETABLEREQUEST Object to represent a updateTable request
```
### @UpdateTableRequest/setProvisionedThroughput.m
```notalanguage
  SETPROVISIONEDTHROUGHPUT Updates a table's provisioned throughput
  A aws.dynamodbv2.model.ProvisionedThroughput object is expected as input.
```
### @UpdateTableRequest/setTableName.m
```notalanguage
  SETTABLENAME Sets the name of a table
  name should be of type character vector.
```

------


## @UpdateTableResult

### @UpdateTableResult/UpdateTableResult.m
```notalanguage
  UPDATETABLERESULT Object to represent a updateTable result
```
### @UpdateTableResult/getTableDescription.m
```notalanguage
  GETTABLEDESCRIPTION Gets the properties of the table
```

------
## AWS Common Objects and Methods:
* @ClientConfiguration
* @Object



------

## @ClientConfiguration

### @ClientConfiguration/ClientConfiguration.m
```notalanguage
  CLIENTCONFIGURATION creates a client network configuration object
  This class can be used to control client behavior such as:
   * Connect to the Internet through proxy
   * Change HTTP transport settings, such as connection timeout and request retries
   * Specify TCP socket buffer size hints
  (Only limited proxy related methods are currently available)
 
  Example, in this case using an s3 client:
    s3 = aws.s3.Client();
    s3.clientConfiguration.setProxyHost('proxyHost','myproxy.example.com');
    s3.clientConfiguration.setProxyPort(8080);
    s3.initialize();

    Reference page in Doc Center
       doc aws.ClientConfiguration

```
### @ClientConfiguration/setProxyHost.m
```notalanguage
  SETPROXYHOST Sets the optional proxy host the client will connect through
  This is based on the setting in the MATLAB preferences panel. If the host
  is not set there on Windows then the Windows system preferences will be
  used. Though it is not normally the case proxy settings may vary based on the
  destination URL, if this is the case a URL should be provided for a specific
  service. If a URL is not provided then https://s3.amazonaws.com is used as
  a default and is likely to match the relevant proxy selection rules for AWS
  traffic.
 
  Examples:
 
    To have the proxy host automatically set based on the MATLAB preferences
    panel using the default URL of 'https://s3.amazonaws.com:'
        clientConfig.setProxyHost();
 
    To have the proxy host automatically set based on the given URL:
        clientConfig.setProxyHost('autoURL','https://examplebucket.amazonaws.com');
 
    To force the value of the proxy host to a given value, e.g. myproxy.example.com:
        clientConfig.setProxyHost('proxyHost','myproxy.example.com');
    Note this does not overwrite the value set in the preferences panel.
 
  The client initialization call will invoke setProxyHost() to set a value based
  on the MATLAB preference if the proxyHost value is not to an empty value.
```
### @ClientConfiguration/setProxyPassword.m
```notalanguage
  SETPROXYPASSWORD Sets the optional proxy password
  This is based on the setting in the MATLAB preferences panel. If the password
  is not set there on Windows then the Windows system preferences will be
  used.
 
  Examples:
 
    To set the password to a given value:
        clientConfig.setProxyPassword('myProxyPassword');
    Note this does not overwrite the value set in the preferences panel.
 
    To set the password automatically based on provided preferences:
        clientConfig.setProxyPassword();
 
  The client initialization call will invoke setProxyPassword() to set
  a value based on the MATLAB preference if the proxy password value is set.
 
  Note, it is bad practice to store credentials in code, ideally this value
  should be read from a permission controlled file or other secure source
  as required.
```
### @ClientConfiguration/setProxyPort.m
```notalanguage
  SETPROXYPORT Sets the optional proxy port the client will connect through
  This is normally based on the setting in the MATLAB preferences panel. If the
  port is not set there on Windows then the Windows system preferences will be
  used. Though it is not normally the case proxy settings may vary based on the
  destination URL, if this is the case a URL should be provided for a specific
  service. If a URL is not provided then https://s3.amazonaws.com is used as
  a default and is likely to match the relevant proxy selection rules for AWS
  traffic.
 
  Examples:
 
    To have the port automatically set based on the default URL of
    https://s3.amazonaws.com:
        clientConfig.setProxyPort();
 
    To have the port automatically set based on the given URL:
        clientConfig.setProxyPort('https://examplebucket.amazonaws.com');
 
    To force the value of the port to a given value, e.g. 8080:
        clientConfig.setProxyPort(8080);
    Note this does not alter the value held set in the preferences panel.
 
  The client initialization call will invoke setProxyPort() to set a value based
  on the MATLAB preference if the proxy port value is not an empty value.
```
### @ClientConfiguration/setProxyUsername.m
```notalanguage
  SETPROXYUSERNAME Sets the optional proxy username
  This is based on the setting in the MATLAB preferences panel. If the username
  is not set there on Windows then the Windows system preferences will be
  used.
 
  Examples:
 
     To set the username to a given value:
         clientConfig.setProxyUsername('myProxyUsername');
     Note this does not overwrite the value set in the preferences panel.
 
     To set the password automatically based on provided preferences:
         clientConfig.setProxyUsername();
 
  The client initialization call will invoke setProxyUsername();
  to set preference based on the MATLAB preference if the proxyUsername value is
  not an empty value.
 
  Note it is bad practice to store credentials in code, ideally this value
  should be read from a permission controlled file or other secure source
  as required.
```

------


## @Object

### @Object/Object.m
```notalanguage
  OBJECT Root object for all the AWS SDK objects

    Reference page in Doc Center
       doc aws.Object

```

------

## AWS Common Related Functions:
### functions/Logger.m
```notalanguage
  Logger - Object definition for Logger
  ---------------------------------------------------------------------
  Abstract: A logger object to encapsulate logging and debugging
            messages for a MATLAB application.
 
  Syntax:
            logObj = Logger.getLogger();
 
  Logger Properties:
 
      LogFileLevel - The level of log messages that will be saved to the
      log file
 
      DisplayLevel - The level of log messages that will be displayed
      in the command window
 
      LogFile - The file name or path to the log file. If empty,
      nothing will be logged to file.
 
      Messages - Structure array containing log messages
 
  Logger Methods:
 
      clearMessages(obj) - Clears the log messages currently stored in
      the Logger object
 
      clearLogFile(obj) - Clears the log messages currently stored in
      the log file
 
      write(obj,Level,MessageText) - Writes a message to the log
 
  Examples:
      logObj = Logger.getLogger();
      write(logObj,'warning','My warning message')
 



```
### functions/aws.m
```notalanguage
  AWS, a wrapper to the AWS CLI utility
 
  The function assumes AWS CLI is installed and configured with authentication
  details. This wrapper allows use of the AWS CLI within the
  MATLAB environment.
 
  Examples:
     aws('s3api list-buckets')
 
  Alternatively:
     aws s3api list-buckets
 
  If no output is specified, the command will echo this to the MATLAB
  command window. If the output variable is provided it will convert the
  output to a MATLAB object.
 
    [status, output] = aws('s3api','list-buckets');
 
      output =
 
        struct with fields:
 
            Owner: [1x1 struct]
          Buckets: [15x1 struct]
 
  By default a struct is produced from the JSON format output.
  If the --output [text|table] flag is set a char vector is produced.
 



```
### functions/homedir.m
```notalanguage
  HOMEDIR Function to return the home directory
  This function will return the users home directory.



```
### functions/isEC2.m
```notalanguage
  ISEC2 returns true if running on AWS EC2 otherwise returns false



```
### functions/loadKeyPair.m
```notalanguage
  LOADKEYPAIR2CERT Reads public and private key files and returns a key pair
  The key pair returned is of type java.security.KeyPair
  Algorithms supported by the underlying java.security.KeyFactory library
  are: DiffieHellman, DSA & RSA.
  However S3 only supports RSA at this point.
  If only the public key is a available e.g. the private key belongs to
  somebody else then we can still create a keypair to encrypt data only
  they can decrypt. To do this we replace the private key file argument
  with 'null'.
 
  Example:
   myKeyPair = loadKeyPair('c:\Temp\mypublickey.key', 'c:\Temp\myprivatekey.key')
 
   encryptOnlyPair = loadKeyPair('c:\Temp\mypublickey.key')
 
 



```
### functions/saveKeyPair.m
```notalanguage
  SAVEKEYPAIR Writes a key pair to two files for the public and private keys
  The key pair should be of type java.security.KeyPair
 
  Example:
    saveKeyPair(myKeyPair, 'c:\Temp\mypublickey.key', 'c:\Temp\myprivatekey.key')
 



```
### functions/unlimitedCryptography.m
```notalanguage
  UNLIMITEDCRYPTOGRAPHY Returns true if unlimited cryptography is installed
  Otherwise false is returned.
  Tests using the AES algorithm for greater than 128 bits if true then this
  indicates that the policy files have been changed to enabled unlimited
  strength cryptography.



```
### functions/writeSTSCredentialsFile.m
```notalanguage
  WRITESTSCREDENTIALSFILE write an STS based credentials file
 
  Write an STS based credential file
 
    tokenCode is the 2 factor authentication code of choice e.g. from Google
    authenticator. Note the command must be issued quickly as this value will
    expire in a number of seconds
 
    serialNumber is the AWS 'arn value' e.g. arn:aws:iam::741<REDACTED>02:mfa/joe.blog
    this can be obtained from the AWS IAM portal interface
 
    region is the AWS region of choice e.g. us-west-1
 
  The following AWS command line interface (CLI) command will return STS
  credentials in json format as follows, Note the required multi-factor (mfa)
  auth version of the arn:
 
  aws sts get-session-token --token-code 631446 --serial-number arn:aws:iam::741<REDACTED>02:mfa/joe.blog
 
  {
      "Credentials": {
          "SecretAccessKey": "J9Y<REDACTED>BaJXEv",
          "SessionToken": "FQoDYX<REDACTED>KL7kw88F",
          "Expiration": "2017-10-26T08:21:18Z",
          "AccessKeyId": "AS<REDACTED>UYA"
      }
  }
 
  This needs to be rewritten differently to match the expected format
  below:
 
  {
      "aws_access_key_id": "AS<REDACTED>UYA",
      "secret_access_key" : "J9Y<REDACTED>BaJXEv",
      "region" : "us-west-1",
      "session_token" : "FQoDYX<REDACTED>KL7kw88F"
  }



```



------------    

[//]: # (Copyright 2019 The MathWorks, Inc.)
