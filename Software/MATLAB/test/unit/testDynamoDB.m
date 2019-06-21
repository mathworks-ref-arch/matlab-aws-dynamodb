classdef testDynamoDB < matlab.unittest.TestCase
    % TESTDYNAMODB Test for the  MATLAB Interface for AWS DynamoDB
    %
    % The test suite exercises the basic operations on the DynamoDB Client.

    % Copyright 2019 The MathWorks, Inc.

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
            ddbClient.useCredentialsProviderChain = false;
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
            ddbClient.useCredentialsProviderChain = false;
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
            ddbClient.useCredentialsProviderChain = false;
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
    end %methods
end %class
