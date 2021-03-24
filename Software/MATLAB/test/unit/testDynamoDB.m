classdef testDynamoDB < matlab.unittest.TestCase
    % TESTDYNAMODB Test for the  MATLAB Interface for Amazon DynamoDB
    %
    % The test suite exercises the basic operations on the DynamoDB Client.
    %
    % Using a local DynamoDB instance
    % ===============================
    %
    % In certain scenarios, particularly development and testing, it may be
    % preferable to use a locally hosted instance of DynamoDB.
    % To run the unit test against a local instance of DynamoDB rather than the
    % AWS hosted version get a copy of the package, see:
    % https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.DownloadingAndRunning.html
    % Extract it to a given location and start it outside MATLAB, e.g.:
    % java -D"java.library.path=./DynamoDBLocal_lib" -jar DynamoDBLocal.jar
    % Define an environment variable DDBENDPOINTURI to point to the instance
    % e.g. in Bash: export DDBENDPOINTURI="http://localhost:8000"
    % If the environment variable is not defined the standard AWS hosted version
    % will be used.

    % Copyright 2019-2021 The MathWorks, Inc.

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Please add your test cases below
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties
        %Create logger reference
        logObj = Logger.getLogger();
    end
    
    
    methods (TestMethodSetup)
        function testSetup(testCase)
            testCase.logObj = Logger.getLogger();
            testCase.logObj.DisplayLevel = 'verbose';
            
        end
    end
    
    methods (Test)
        function testConstructor(testCase)
            write(testCase.logObj,'debug','Testing testConstructor');
            % create the client required by the DynamoDB constructor
            ddbClient = aws.dynamodbv2.AmazonDynamoDBClient;
            if strcmpi(getenv('GITLAB_CI'), 'true')
                ddbClient.useCredentialsProviderChain = false;
            else
                ddbClient.useCredentialsProviderChain = true;
            end
            ddbClient.initialize();
            testCase.verifyNotEmpty(ddbClient.Handle);
            
            % Create the object
            ddb = aws.dynamodbv2.document.DynamoDB(ddbClient);
            testCase.verifyClass(ddb,'aws.dynamodbv2.document.DynamoDB');
            ddbClient.shutdown();
        end
        
        
        function testDynamoDBTableCRUD(testCase)
            % see related sample Java code here: https://github.com/aws-samples/aws-dynamodb-examples/blob/master/src/main/java/com/amazonaws/codesamples/document/DocumentAPITableExample.java
            write(testCase.logObj,'debug','Testing testDynamoDBTableCRUD');
            import java.util.UUID;
            % create a client from which to create a DynamoDB object
            ddbClient = aws.dynamodbv2.AmazonDynamoDBClient;
            if ~isempty(getenv('DDBENDPOINTURI'))
                ddbClient.endpointURI = matlab.net.URI(getenv('DDBENDPOINTURI'));
            end
            if strcmpi(getenv('GITLAB_CI'), 'true')
                ddbClient.useCredentialsProviderChain = false;
            else
                ddbClient.useCredentialsProviderChain = true;
            end
            ddbClient.initialize();
            
            % Create the document API DynamoDB object
            ddb = aws.dynamodbv2.document.DynamoDB(ddbClient);
            
            % configure names
            uuid = char(UUID.randomUUID());
            tableName = ['myTableTest-', uuid];
            attributeName = 'Id';
            
            % configure an attribute definition, provisioned throughput and key element schema
            ad = aws.dynamodbv2.model.AttributeDefinition();
            ad.setAttributeName(attributeName);
            ad.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.N);
            kse = aws.dynamodbv2.model.KeySchemaElement(attributeName, aws.dynamodbv2.model.KeyType.HASH);
            pt = aws.dynamodbv2.model.ProvisionedThroughput(uint64(5), uint64(5));
            
            % create a createTableRequest from these
            createTableRequest = aws.dynamodbv2.model.CreateTableRequest();
            createTableRequest.setTableName(tableName);
            createTableRequest.setAttributeDefinitions([ad]); %#ok<NBRAK>
            createTableRequest.setProvisionedThroughput(pt);
            createTableRequest.setKeySchema([kse]); %#ok<NBRAK>
            testCase.verifyNotEmpty(createTableRequest.Handle);
            
            % use the document API to create the table
            table = ddb.createTable(createTableRequest);
            testCase.verifyNotEmpty(table.Handle);
            
            % use the document api to wait until it is active
            table.waitForActive();
            
            % document API list of tables, returned as a cell array of table objects
            [tables, names] = ddb.listTables();
            testCase.verifyGreaterThan(numel(tables), 0);
            % names and tables should be the same size
            testCase.verifyEqual(numel(tables), numel(names));
            
            % verity the table is on the list
            found = false;
            status = '';
            for n = 1:numel(tables)
                if strcmp(tables{n}.getTableName(), tableName)
                    % verify it equals the names array name value too
                    testCase.verifyTrue(strcmp(names{n}, tableName));
                    found = true;
                    tableDescription = tables{n}.describe();
                    status =  tableDescription.getTableStatus();
                end
            end
            testCase.verifyTrue(found);
            % verify the status is active following wait
            testCase.verifyTrue(strcmp(status, 'ACTIVE'));
            
            % valid getTable() from table name approach to getting a table object
            % using the document API
            tableFromName = ddb.getTable(tableName);
            tableDescription = tableFromName.describe();
            % check it returns the name it should
            testCase.verifyTrue(strcmp(tableDescription.getTableName(), tableName));
            
            % create a new ProvisionedThroughput and update the table
            pt = aws.dynamodbv2.model.ProvisionedThroughput(uint64(6), uint64(7));
            table.updateTable(pt);
            % wait until the update is complete
            table.waitForActive();
            % check the update was applied
            tableDescription = table.describe();
            pt = tableDescription.getProvisionedThroughput();
            testCase.verifyEqual(pt.getReadCapacityUnits, 6);
            testCase.verifyEqual(pt.getWriteCapacityUnits, 7);
            
            % delete the table and wait for it to complete
            table.deleteTable();
            table.waitForDelete();
            
            % verify the table is not on the list
            tables = ddb.listTables();
            found = false;
            for n = 1:numel(tables)
                if strcmp(tables{n}.getTableName(), tableName)
                    found = true;
                end
            end
            testCase.verifyFalse(found);
            
            ddbClient.shutdown;
        end
        
        
        function testDynamoDBItemCRUD(testCase)
            % see related sample Java code here: https://github.com/aws-samples/aws-dynamodb-examples/blob/master/src/main/java/com/amazonaws/codesamples/document/DocumentAPIItemCRUDExample.java
            write(testCase.logObj,'debug','Testing testDynamoDBItemCRUD');
            import java.util.UUID;
            % create a client from which to create a DynamoDB object
            ddbClient = aws.dynamodbv2.AmazonDynamoDBClient;
            if ~isempty(getenv('DDBENDPOINTURI'))
                ddbClient.endpointURI = matlab.net.URI(getenv('DDBENDPOINTURI'));
            end
            if strcmpi(getenv('GITLAB_CI'), 'true')
                ddbClient.useCredentialsProviderChain = false;
            else
                ddbClient.useCredentialsProviderChain = true;
            end
            ddbClient.initialize();
            
            % Create the document API DynamoDB object
            dynamoDB = aws.dynamodbv2.document.DynamoDB(ddbClient);
            
            % configure names
            uuid = char(UUID.randomUUID());
            tableName = ['myTableTest-', uuid];
            attributeName = 'Id';
            
            % configure an attribute definition, provisioned throughput and key element schema
            ad = aws.dynamodbv2.model.AttributeDefinition();
            ad.setAttributeName(attributeName);
            ad.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.N);
            kse = aws.dynamodbv2.model.KeySchemaElement(attributeName, aws.dynamodbv2.model.KeyType.HASH);
            pt = aws.dynamodbv2.model.ProvisionedThroughput(uint64(5), uint64(5));
            
            % create a createTableRequest from these
            createTableRequest = aws.dynamodbv2.model.CreateTableRequest();
            createTableRequest.setTableName(tableName);
            createTableRequest.setAttributeDefinitions([ad]); %#ok<NBRAK>
            createTableRequest.setProvisionedThroughput(pt);
            createTableRequest.setKeySchema([kse]); %#ok<NBRAK>
            testCase.verifyNotEmpty(createTableRequest.Handle);
            
            % use the document API to create the table
            table = dynamoDB.createTable(createTableRequest);
            testCase.verifyNotEmpty(table.Handle);
            table.waitForActive();
            
            % create items
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
            putItemOutcome = table.putItem(item); %#ok<NASGU>
            
            item = aws.dynamodbv2.document.Item();
            item.withPrimaryKey('Id', 121);
            item.withString('Title', 'Book 121 Title');
            item.withString('ISBN', '121-1111111111');
            item.withStringSet('Authors', {'Author21', 'Author22'});
            item.withDouble('Price', 20);
            item.withString('Dimensions', '8.5x11.0x.75');
            item.withInt('PageCount', int32(500));
            item.withBoolean('InPublication', false);
            item.withString('ProductCategory', 'Book');
            putItemOutcome = table.putItem(item); %#ok<NASGU>
            
            % retrieve and item and check it
            getItemSpec = aws.dynamodbv2.document.spec.GetItemSpec();
            getItemSpecResult = getItemSpec.withConsistentRead(true); %#ok<NASGU>
            getItemSpecResult = getItemSpec.withPrimaryKey('Id', 120); %#ok<NASGU>
            getItemSpecResult = getItemSpec.withProjectionExpression('Id, ISBN, Title, Price, Authors, InPublication, PageCount'); %#ok<NASGU>
            getItemResult = table.getItem(getItemSpec);
            
            testCase.verifyNotEmpty(getItemResult);
            testCase.verifyFalse(getItemResult.getBoolean('InPublication'));
            testCase.verifyEqual(getItemResult.getDouble('Price'), 20);
            testCase.verifyEqual(getItemResult.getInt('PageCount'), int64(500));
            testCase.verifyTrue(strcmp(getItemResult.getString('ISBN'), '120-1111111111'));
            Authors = getItemResult.getStringSet('Authors');
            testCase.verifyEqual(sum(contains(Authors,'Author12')), 1);
            testCase.verifyEqual(sum(contains(Authors,'Author22')), 1);
            
            % delete an item
            deleteItemSpec = aws.dynamodbv2.document.spec.DeleteItemSpec();
            pKey = aws.dynamodbv2.document.PrimaryKey();
            pKey.addComponent('Id', 120);
            deleteItemSpec.withPrimaryKey(pKey);
            deleteItemOutcome = table.deleteItem(deleteItemSpec); %#ok<NASGU>
            
            % get the item again to check it has been removed and that
            % getItem returns an empty logical
            getItemSpec = aws.dynamodbv2.document.spec.GetItemSpec();
            getItemSpecResult = getItemSpec.withConsistentRead(true); %#ok<NASGU>
            getItemSpecResult = getItemSpec.withPrimaryKey('Id', 120); %#ok<NASGU>
            getItemSpecResult = getItemSpec.withProjectionExpression('Id, ISBN, Title, Price, Authors, InPublication, PageCount'); %#ok<NASGU>
            getItemResult = table.getItem(getItemSpec);
            testCase.verifyEmpty(getItemResult);
            testCase.verifyTrue(islogical(getItemResult));
            
            % update an item
            updateItemSpec =  aws.dynamodbv2.document.spec.UpdateItemSpec();
            updateItemSpec.withPrimaryKey('Id', 121);
            updateItemSpec.withUpdateExpression('set #na = :val1');
            updateItemSpec.withReturnValues(aws.dynamodbv2.model.ReturnValue.ALL_NEW);
            nameMap = containers.Map({'#na'}, {'NewAttribute'});
            updateItemSpec.withNameMap(nameMap);
            valueMap = containers.Map({':val1'}, {'Some Value'});
            updateItemSpec.withValueMap(valueMap);
            updateItemOutcome = table.updateItem('updateItemSpec', updateItemSpec); %#ok<NASGU>
            
            % query the result of the update just made
            % See: https://github.com/aws-samples/aws-dynamodb-examples/blob/master/src/main/java/com/amazonaws/codesamples/document/DocumentAPIQuery.java
            querySpec = aws.dynamodbv2.document.spec.QuerySpec();
            querySpec.withConsistentRead(true);
            querySpec.withKeyConditionExpression('Id = :v_id');
            valueMap = containers.Map({':v_id'}, {121});
            querySpec.withValueMap(valueMap);
            
            queryOutcomeItems = table.query('querySpec', querySpec);
            testCase.verifyEqual(numel(queryOutcomeItems), 1);
            attrVal = queryOutcomeItems{1}.getString('NewAttribute');
            testCase.verifyTrue(strcmp(attrVal, 'Some Value'));
            
            % delete the table and wait for it to complete
            table.waitForActive();
            table.deleteTable();
            table.waitForDelete();
            ddbClient.shutdown;
        end %function
        
        
        function testDynamoDBBatchItemWrite(testCase)
            % see related sample Java code here: https://github.com/aws-samples/aws-dynamodb-examples/blob/master/src/main/java/com/amazonaws/codesamples/document/DocumentAPIBatchWrite.java
            write(testCase.logObj,'debug','Testing testDynamoDBBatchItemWrite');
            import java.util.UUID;
            % create a client from which to create a DynamoDB object
            ddbClient = aws.dynamodbv2.AmazonDynamoDBClient;
            if ~isempty(getenv('DDBENDPOINTURI'))
                ddbClient.endpointURI = matlab.net.URI(getenv('DDBENDPOINTURI'));
            end
            ddbClient.useCredentialsProviderChain = false;
            ddbClient.initialize();
            
            % Create the document API DynamoDB object
            dynamoDB = aws.dynamodbv2.document.DynamoDB(ddbClient);
            
            % configure names
            uuid = char(UUID.randomUUID());
            tableName = ['myTableTest-', uuid];
            attributeName = 'rowNum';
            
            % configure an attribute definition, provisioned throughput and key element schema
            ad = aws.dynamodbv2.model.AttributeDefinition();
            ad.setAttributeName(attributeName);
            ad.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.N);
            kse = aws.dynamodbv2.model.KeySchemaElement(attributeName, aws.dynamodbv2.model.KeyType.HASH);
            pt = aws.dynamodbv2.model.ProvisionedThroughput(uint64(5), uint64(5));
            
            % create a createTableRequest from these
            createTableRequest = aws.dynamodbv2.model.CreateTableRequest();
            createTableRequest.setTableName(tableName);
            createTableRequest.setAttributeDefinitions([ad]); %#ok<NBRAK>
            createTableRequest.setProvisionedThroughput(pt);
            createTableRequest.setKeySchema([kse]); %#ok<NBRAK>
            testCase.verifyNotEmpty(createTableRequest.Handle);
            
            % use the document API to create the table
            table = dynamoDB.createTable(createTableRequest);
            testCase.verifyNotEmpty(table.Handle);
            table.waitForActive();
            
            % Create a batch of items to write
            tableWriteItems = aws.dynamodbv2.document.TableWriteItems(tableName);
            for n=1:10
                item = aws.dynamodbv2.document.Item();
                item.withPrimaryKey('rowNum', n);
                item.withString('Title', ['Title-',num2str(n)]);
                item.withInt('IntVal', int32(n));
                item.withDouble('DoubleVal', n*1.2345);
                %tableWriteItems = tableWriteItems.addItemsToPut(item);
                tableWriteItems.addItemsToPut(item);
            end
            % Write the batch
            batchWriteItemOutcome = dynamoDB.batchWriteItem(tableWriteItems);
            % Get the results
            batchWriteItemResult = batchWriteItemOutcome.getBatchWriteItemResult;
            % No simple method to return a number of unprocessed items so
            % test agains the underlying toString for empty
            testCase.verifyTrue(strcmp('{UnprocessedItems: {},}', batchWriteItemResult.Handle.toString));
            unprocessedItems = batchWriteItemOutcome.getUnprocessedItems();
            % Expect the small write to be processed so result should be empty
            testCase.verifyEmpty(unprocessedItems);
            
            % Check the write happened for sample Nth row
            N = 3;
            getItemSpec = aws.dynamodbv2.document.spec.GetItemSpec();
            getItemSpecResult = getItemSpec.withConsistentRead(true); %#ok<NASGU>
            getItemSpecResult = getItemSpec.withPrimaryKey('rowNum', N); %#ok<NASGU>
            getItemSpecResult = getItemSpec.withProjectionExpression('Title, IntVal, DoubleVal'); %#ok<NASGU>
            getItemResult = table.getItem(getItemSpec);
            
            testCase.verifyNotEmpty(getItemResult);
            testCase.verifyTrue(strcmp(getItemResult.getString('Title'), ['Title-',num2str(N)]));
            testCase.verifyEqual(getItemResult.getInt('IntVal'), int64(N));
            % Not concerned by absolute tolerence here close enough is
            % sufficent to test the type handling
            testCase.verifyEqual(getItemResult.getDouble('DoubleVal'), N*1.2345, 'AbsTol', 0.0001);
            
            % cleanup
            table.waitForActive();
            table.deleteTable();
            table.waitForDelete();
            ddbClient.shutdown;
        end
                
        
        function testItemList(testCase)
            write(testCase.logObj,'debug','Testing testItemList');
            import java.util.UUID;
            % create a client from which to create a DynamoDB object
            ddbClient = aws.dynamodbv2.AmazonDynamoDBClient;
            if ~isempty(getenv('DDBENDPOINTURI'))
                ddbClient.endpointURI = matlab.net.URI(getenv('DDBENDPOINTURI'));
            end
            ddbClient.useCredentialsProviderChain = false;
            ddbClient.initialize();
            
            % Create the document API DynamoDB object
            dynamoDB = aws.dynamodbv2.document.DynamoDB(ddbClient);
            
            % configure names
            uuid = char(UUID.randomUUID());
            tableName = ['myTableTest-', uuid];
            attributeName = 'Name';
            
            % configure an attribute definition, provisioned throughput and key element schema
            ad = aws.dynamodbv2.model.AttributeDefinition();
            ad.setAttributeName(attributeName);
            ad.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.S);
            kse = aws.dynamodbv2.model.KeySchemaElement(attributeName, aws.dynamodbv2.model.KeyType.HASH);
            pt = aws.dynamodbv2.model.ProvisionedThroughput(uint64(5), uint64(5));
            
            % create a createTableRequest from these
            createTableRequest = aws.dynamodbv2.model.CreateTableRequest();
            createTableRequest.setTableName(tableName);
            createTableRequest.setAttributeDefinitions([ad]); %#ok<NBRAK>
            createTableRequest.setProvisionedThroughput(pt);
            createTableRequest.setKeySchema([kse]); %#ok<NBRAK>
            testCase.verifyNotEmpty(createTableRequest.Handle);
            
            % use the document API to create the table
            table = dynamoDB.createTable(createTableRequest);
            testCase.verifyNotEmpty(table.Handle);
            table.waitForActive();             
            
            % configure some sample data
            %   table name: myTableTest-UUID
            %     items: Name:   arrayVal
            %            arrayA: 1.2  4.3
            %                    4.5  7.4
            %                    3.3  4.5
            n = 2;
            m = 3;
            % 2D array of random doubles
            inputArrayA2D = rand(m, n);
            item = aws.dynamodbv2.document.Item();
            item.withPrimaryKey('Name', 'arrayA');
            item.withList('arrayA', inputArrayA2D);
            putItemOutcome = table.putItem(item); %#ok<NASGU>
            
            % retrieve item and check it
            getItemSpec = aws.dynamodbv2.document.spec.GetItemSpec();
            getItemSpecResult = getItemSpec.withConsistentRead(true); %#ok<NASGU>
            getItemSpecResult = getItemSpec.withPrimaryKey('Name', 'arrayA'); %#ok<NASGU>
            getItemSpecResult = getItemSpec.withProjectionExpression('arrayA'); %#ok<NASGU>
            getItemResult = table.getItem(getItemSpec);
            
            testCase.verifyNotEmpty(getItemResult);
            result = getItemResult.getList('arrayA');
            testCase.verifyEqual(numel(inputArrayA2D), numel(result));
            for n = 1:numel(inputArrayA2D)
                testCase.verifyEqual(inputArrayA2D(n), result{n}, 'AbsTol', 0.0001);
            end
                
            % Add a non homogeneous list
            item = aws.dynamodbv2.document.Item();
            item.withPrimaryKey('Name', 'nhList');
            nhList{1} = "string1";
            nhList{2} = 1234;
            nhList{3} = 'string2';
            nhList{4} = 5.678;
            
            item.withList('nhList', nhList);
            putItemOutcome = table.putItem(item);           
            
            % retrieve item and check it
            getItemSpec = aws.dynamodbv2.document.spec.GetItemSpec();
            getItemSpecResult = getItemSpec.withConsistentRead(true); %#ok<NASGU>
            getItemSpecResult = getItemSpec.withPrimaryKey('Name', 'nhList'); %#ok<NASGU>
            getItemSpecResult = getItemSpec.withProjectionExpression('nhList'); %#ok<NASGU>
            getItemResult = table.getItem(getItemSpec);
            
            testCase.verifyNotEmpty(getItemResult);
            resultArray = getItemResult.getList('nhList');
            % List format is JSON "like" so decode to access contents
            result = jsondecode(resultArray{1});
            % Check number of elements
            testCase.verifyEqual(numel(nhList), numel(result));
            % Check numeric elements
            testCase.verifyEqual(nhList{2}, result{2}, 'AbsTol', 0.0001);
            testCase.verifyEqual(nhList{4}, result{4}, 'AbsTol', 0.0001);
            % Check string elements
            testCase.verifyTrue(strcmp(nhList{1}, result{1}));
            testCase.verifyTrue(strcmp(nhList{3}, result{3}));
            
            % cleanup
            % delete the table and wait for it to complete
            table.waitForActive();
            table.deleteTable();
            table.waitForDelete();
            ddbClient.shutdown;
        end
        
        
        function testItemJSON(testCase)
            write(testCase.logObj,'debug','Testing testItemJSON');
            import java.util.UUID;
            % create a client from which to create a DynamoDB object
            ddbClient = aws.dynamodbv2.AmazonDynamoDBClient;
            if ~isempty(getenv('DDBENDPOINTURI'))
                ddbClient.endpointURI = matlab.net.URI(getenv('DDBENDPOINTURI'));
            end
            ddbClient.useCredentialsProviderChain = false;
            ddbClient.initialize();
            
            % Create the document API DynamoDB object
            dynamoDB = aws.dynamodbv2.document.DynamoDB(ddbClient);
            
            % configure names
            uuid = char(UUID.randomUUID());
            tableName = ['myTableTest-', uuid];
            attributeName = 'Name';
            
            % configure an attribute definition, provisioned throughput and key element schema
            ad = aws.dynamodbv2.model.AttributeDefinition();
            ad.setAttributeName(attributeName);
            ad.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.S);
            kse = aws.dynamodbv2.model.KeySchemaElement(attributeName, aws.dynamodbv2.model.KeyType.HASH);
            pt = aws.dynamodbv2.model.ProvisionedThroughput(uint64(5), uint64(5));
            
            % create a createTableRequest from these
            createTableRequest = aws.dynamodbv2.model.CreateTableRequest();
            createTableRequest.setTableName(tableName);
            createTableRequest.setAttributeDefinitions([ad]); %#ok<NBRAK>
            createTableRequest.setProvisionedThroughput(pt);
            createTableRequest.setKeySchema([kse]); %#ok<NBRAK>
            testCase.verifyNotEmpty(createTableRequest.Handle);
            
            % use the document API to create the table
            table = dynamoDB.createTable(createTableRequest);
            testCase.verifyNotEmpty(table.Handle);
            table.waitForActive();             
            
            % configure some sample data
            topLevel.myString = "abcde";
            topLevel.myInt = int64(123);
            topLevel.myDouble = 4.56;
            topLevel.myArray = rand(3,2);
            topLevel.myArray = reshape(topLevel.myArray, 1, 2*3);
            topLevel.levelTwo.stringTwo = 'xzy';
            jsonData = jsonencode(topLevel);
            
            item = aws.dynamodbv2.document.Item();
            item.withPrimaryKey('Name', 'valueA');
            item.withJSON('valueA', jsonData);
            putItemOutcome = table.putItem(item); %#ok<NASGU>
            
            % retrieve item and check it
            getItemSpec = aws.dynamodbv2.document.spec.GetItemSpec();
            getItemSpecResult = getItemSpec.withConsistentRead(true); %#ok<NASGU>
            getItemSpecResult = getItemSpec.withPrimaryKey('Name', 'valueA'); %#ok<NASGU>
            getItemSpecResult = getItemSpec.withProjectionExpression('valueA'); %#ok<NASGU>
            getItemResult = table.getItem(getItemSpec);
            
            testCase.verifyNotEmpty(getItemResult);
            resultJSON = getItemResult.getJSON('valueA');
            result = jsondecode(resultJSON);
            
            testCase.verifyEqual(topLevel.myDouble, result.myDouble, 'AbsTol', 0.0001);
            testCase.verifyEqual(double(topLevel.myInt), result.myInt, 'AbsTol', 0.0001);
            testCase.verifyTrue(strcmp(result.myString, topLevel.myString));
            testCase.verifyTrue(strcmp(result.levelTwo.stringTwo, topLevel.levelTwo.stringTwo));
            testCase.verifyEqual(topLevel.myArray(1), result.myArray(1), 'AbsTol', 0.0001);
            testCase.verifyEqual(topLevel.myArray(end), result.myArray(end), 'AbsTol', 0.0001);
            
            % cleanup
            % delete the table and wait for it to complete
            table.waitForActive();
            table.deleteTable();
            table.waitForDelete();
            ddbClient.shutdown;
        end
    end %methods
end %class
