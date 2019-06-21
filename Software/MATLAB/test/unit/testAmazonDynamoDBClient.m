classdef testAmazonDynamoDBClient < matlab.unittest.TestCase
    % TESTAMAZONDYNAMODBCLIENT Test for the  MATLAB Interface for AWS DynamoDB
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
            % Create the object
            ddb = aws.dynamodbv2.AmazonDynamoDBClient();
            testCase.verifyClass(ddb,'aws.dynamodbv2.AmazonDynamoDBClient');
        end


        function testInitialization(testCase)
            write(testCase.logObj,'debug','Testing testInitialization');
            % Create the client and initialize
            ddb = aws.dynamodbv2.AmazonDynamoDBClient();
            ddb.useCredentialsProviderChain = false;
            ddb.initialize();

            testCase.verifyNotEmpty(ddb.Handle);
            ddb.shutdown();
        end


        function testInitializationOtherCredentials(testCase)
            write(testCase.logObj,'debug','Testing testInitializationOtherCredentials');
            % Create the client and initialize using a temp copy of the
            % credentials file in the same directory
            currentCreds = which('credentials.json');
            [pathstr,~,~] = fileparts(currentCreds);

            newCreds = fullfile(pathstr, 'testInitializationOtherCredentials.json');
            copyfile(currentCreds,newCreds);

            ddb = aws.dynamodbv2.AmazonDynamoDBClient();
            ddb.useCredentialsProviderChain = false;
            ddb.credentialsFilePath = newCreds;
            ddb.initialize();

            testCase.verifyNotEmpty(ddb.Handle);
            delete(newCreds);
            ddb.shutdown();
        end


        function testCreateTable(testCase)
            write(testCase.logObj,'debug','Testing testCreateTable');
            import java.util.UUID;

            ddb = aws.dynamodbv2.AmazonDynamoDBClient;
            ddb.useCredentialsProviderChain = false;
            ddb.initialize();

            uuid = char(UUID.randomUUID());
            tableName = ['myTableTest-', uuid];
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
            createTableRequest.setAttributeDefinitions([ad]); %#ok<NBRAK>
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
                pause(5);
                describeResult = ddb.describeTable(tableName);
                tableDescription = describeResult.getTable();
                status = tableDescription.getTableStatus();
            end
            deleteResult = ddb.deleteTable(tableName); %#ok<NASGU>

            ddb.shutdown();
        end


        function testCompositeCreateTable(testCase)
            write(testCase.logObj,'debug','Testing testCompositeCreateTable');
            import java.util.UUID;
            ddb = aws.dynamodbv2.AmazonDynamoDBClient;
            ddb.useCredentialsProviderChain = false;
            ddb.initialize();

            % configure a TableCreateRequest
            uuid = char(UUID.randomUUID());
            tableName = ['myTableTest-', uuid];
            createTableRequest = aws.dynamodbv2.model.CreateTableRequest();
            testCase.verifyNotEmpty(createTableRequest.Handle);
            createTableRequest.setTableName(tableName);
            pt = aws.dynamodbv2.model.ProvisionedThroughput(uint64(10), uint64(10));
            createTableRequest.setProvisionedThroughput(pt);

            % configure two attribute definitions
            ad1 = aws.dynamodbv2.model.AttributeDefinition();
            ad1.setAttributeName('Language');
            ad1.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.S);
            ad2 = aws.dynamodbv2.model.AttributeDefinition();
            ad2.setAttributeName('Greeting');
            ad2.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.S);
            createTableRequest.setAttributeDefinitions([ad1, ad2]);

            % configure schema elements
            kse1 = aws.dynamodbv2.model.KeySchemaElement('Language', aws.dynamodbv2.model.KeyType.HASH);
            kse2 = aws.dynamodbv2.model.KeySchemaElement('Greeting', aws.dynamodbv2.model.KeyType.RANGE);
            createTableRequest.setKeySchema([kse1, kse2]);

            % create the table
            result = ddb.createTable(createTableRequest);

            % check the table was created
            tableDescription = result.getTableDescription();
            name = tableDescription.getTableName();
            testCase.verifyEqual(name, tableName);

            % cleanup
            status = tableDescription.getTableStatus();
            while ~strcmp(status, 'ACTIVE')
                pause(5);
                describeResult = ddb.describeTable(tableName);
                tableDescription = describeResult.getTable();
                status = tableDescription.getTableStatus();
            end
            deleteResult = ddb.deleteTable(tableName); %#ok<NASGU>

            ddb.shutdown();
        end


        function testDescribeTable(testCase)
            write(testCase.logObj,'debug','Testing testDescribeTable');
            import java.util.UUID;
            ddb = aws.dynamodbv2.AmazonDynamoDBClient;
            ddb.useCredentialsProviderChain = false;
            ddb.initialize();

            % configure a TableCreateRequest
            uuid = char(UUID.randomUUID());
            tableName = ['myTableTest-', uuid];
            attributeName = 'myAttributeName';

            % configure a TableCreateRequest
            createTableRequest = aws.dynamodbv2.model.CreateTableRequest();
            createTableRequest.setTableName(tableName);
            pt = aws.dynamodbv2.model.ProvisionedThroughput(uint64(10), uint64(10));
            createTableRequest.setProvisionedThroughput(pt);
            ad = aws.dynamodbv2.model.AttributeDefinition();
            ad.setAttributeName(attributeName);
            ad.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.S);
            createTableRequest.setAttributeDefinitions([ad]); %#ok<NBRAK>
            kse = aws.dynamodbv2.model.KeySchemaElement(attributeName, aws.dynamodbv2.model.KeyType.HASH);
            createTableRequest.setKeySchema([kse]); %#ok<NBRAK>

            % create the table
            result = ddb.createTable(createTableRequest);

            % get the table description & verify properties
            tableDescription = result.getTableDescription();
            name = tableDescription.getTableName();
            testCase.verifyEqual(name, tableName);

            % check the ARN, status count and size
            tableArn = tableDescription.getTableArn();
            splitTableArn = strsplit(tableArn, ':');
            tableArnName = splitTableArn{end};
            testCase.verifyEqual(tableArnName, ['table/',tableName]);

            status = tableDescription.getTableStatus();
            testCase.verifyTrue(strcmp(status,'ACTIVE') || strcmp(status,'UPDATING') || strcmp(status,'DELETING') || strcmp(status,'CREATING'))

            count = tableDescription.getItemCount();
            testCase.verifyEqual(count, 0);

            size = tableDescription.getTableSizeBytes();
            testCase.verifyEqual(size, 0);

            % check throughput
            throughputInfo = tableDescription.getProvisionedThroughput();
            readCapacity = throughputInfo.getReadCapacityUnits;
            testCase.verifyEqual(readCapacity, 10);
            writeCapacity = throughputInfo.getWriteCapacityUnits;
            testCase.verifyEqual(writeCapacity, 10);

            %check the attributes
            attributes = tableDescription.getAttributeDefinitions();
            testCase.verifyEqual(numel(attributes), 1);
            attrib1 = attributes(1);
            testCase.verifyEqual(attrib1.getAttributeName(), attributeName);

            % cleanup
            status = tableDescription.getTableStatus();
            while ~strcmp(status, 'ACTIVE')
                pause(5);
                describeResult = ddb.describeTable(tableName);
                tableDescription = describeResult.getTable();
                status = tableDescription.getTableStatus();
            end
            deleteResult = ddb.deleteTable(tableName); %#ok<NASGU>

            ddb.shutdown();
        end


        function testPutGetDeleteItem(testCase)
            write(testCase.logObj,'debug','Testing testPutGetDeleteItem');
            import java.util.UUID;
            ddb = aws.dynamodbv2.AmazonDynamoDBClient;
            ddb.useCredentialsProviderChain = false;
            ddb.initialize();

            % set table name
            uuid = char(UUID.randomUUID());
            tableName = ['Cellists-', uuid];

            % configure some sample data
            %   table name: Cellists
            %     items: Name:     Pau
            %            Language: ca
            %            Born:     1876
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

            % configure a TableCreateRequest
            createTableRequest = aws.dynamodbv2.model.CreateTableRequest();
            testCase.verifyNotEmpty(createTableRequest.Handle);
            createTableRequest.setTableName(tableName);
            pt = aws.dynamodbv2.model.ProvisionedThroughput(uint64(10), uint64(10));
            createTableRequest.setProvisionedThroughput(pt);

            % configure an attribute definition and key element schema for
            % the primary key only
            ad1 = aws.dynamodbv2.model.AttributeDefinition();
            ad1.setAttributeName(keys{1});
            ad1.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.S);
            createTableRequest.setAttributeDefinitions([ad1]); %#ok<NBRAK>

            % set the attribute that is the primary key, i.e. Name
            kse = aws.dynamodbv2.model.KeySchemaElement(keys{1}, aws.dynamodbv2.model.KeyType.HASH);
            createTableRequest.setKeySchema([kse]); %#ok<NBRAK>

            % create the table
            createResult = ddb.createTable(createTableRequest); %#ok<NASGU>

            describeResult = ddb.describeTable(tableName);
            tableDescription = describeResult.getTable();
            status = tableDescription.getTableStatus();
            while ~strcmp(status, 'ACTIVE')
                pause(5);
                describeResult = ddb.describeTable(tableName);
                tableDescription = describeResult.getTable();
                status = tableDescription.getTableStatus();
            end

            % put items before getting
            putItemRequest = aws.dynamodbv2.model.PutItemRequest(tableName, attributeValues);
            putItemResult = ddb.putItem(putItemRequest); %#ok<NASGU>

            % configure get item request
            itemToGet = containers.Map(keys(1), {av1});
            getItemRequest = aws.dynamodbv2.model.GetItemRequest(tableName, itemToGet);
            projectionExpression = '';
            if ~isempty(projectionExpression)
                getItemRequest.setProjectionExpression(projectionExpression);
            end
            getItemRequest.setConsistentRead(true);

            % get the item
            getItemResult = ddb.getItem(getItemRequest);
            itemResult = getItemResult.getItem();

            % check the item
            resultKeys = itemResult.keys;
            resultValues = itemResult.values;

            BornChecked = false;
            NameChecked = false;
            LanguageChecked = false;
            for n = 1:numel(resultKeys)
                if strcmp(resultKeys{n}, 'Born')
                    testCase.verifyEqual(resultValues{n}.getN, num2str(1876));
                    BornChecked = true;
                end
                if strcmp(resultKeys{n}, 'Language')
                    testCase.verifyEqual(resultValues{n}.getS, 'ca');
                    LanguageChecked = true;
                end
                if strcmp(resultKeys{n}, 'Name')
                    testCase.verifyEqual(resultValues{n}.getS, 'Pau');
                    NameChecked = true;
                end
            end
            testCase.verifyTrue(all([BornChecked, NameChecked, LanguageChecked]));

            % delete the item
            itemToDelete = containers.Map({'Name'}, {aws.dynamodbv2.model.AttributeValue('Pau')});
            deleteItemResult = ddb.deleteItem(tableName, itemToDelete); %#ok<NASGU>

            % get the item again
            getItemResult = ddb.getItem(getItemRequest);
            itemResult = getItemResult.getItem();
            testCase.verifyEmpty(itemResult);

            % cleanup
            describeResult = ddb.describeTable(tableName);
            tableDescription = describeResult.getTable();
            status = tableDescription.getTableStatus();
            while ~strcmp(status, 'ACTIVE')
                pause(5);
                describeResult = ddb.describeTable(tableName);
                tableDescription = describeResult.getTable();
                status = tableDescription.getTableStatus();
            end
            deleteResult = ddb.deleteTable(tableName); %#ok<NASGU>

            ddb.shutdown();
        end


        function testListTables(testCase)
            write(testCase.logObj,'debug','Testing testListTables');
            import java.util.UUID;
            ddb = aws.dynamodbv2.AmazonDynamoDBClient;
            ddb.useCredentialsProviderChain = false;
            ddb.initialize();

            % configure a TableCreateRequest
            uuid1 = char(UUID.randomUUID());
            uuid2 = char(UUID.randomUUID());
            tableName1 = ['myTableTest-', uuid1];
            tableName2 = ['myTableTest-', uuid2];
            attributeName = 'myAttributeName';

            % configure a TableCreateRequest
            createTableRequest1 = aws.dynamodbv2.model.CreateTableRequest();
            createTableRequest2 = aws.dynamodbv2.model.CreateTableRequest();
            createTableRequest1.setTableName(tableName1);
            createTableRequest2.setTableName(tableName2);
            pt = aws.dynamodbv2.model.ProvisionedThroughput(uint64(10), uint64(10));
            createTableRequest1.setProvisionedThroughput(pt);
            createTableRequest2.setProvisionedThroughput(pt);
            ad = aws.dynamodbv2.model.AttributeDefinition();
            ad.setAttributeName(attributeName);
            ad.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.S);
            createTableRequest1.setAttributeDefinitions([ad]); %#ok<NBRAK>
            createTableRequest2.setAttributeDefinitions([ad]); %#ok<NBRAK>
            kse = aws.dynamodbv2.model.KeySchemaElement(attributeName, aws.dynamodbv2.model.KeyType.HASH);
            createTableRequest1.setKeySchema([kse]); %#ok<NBRAK>
            createTableRequest2.setKeySchema([kse]); %#ok<NBRAK>

            % create the tables and block until they are active
            result1 = ddb.createTable(createTableRequest1); %#ok<NASGU>
            % tableDescription = result1.getTableDescription(); %#ok<NASGU>
            dynamoDB = aws.dynamodbv2.document.DynamoDB(ddb);
            table1 = dynamoDB.getTable(tableName1);
            table1.waitForActive();

            result2 = ddb.createTable(createTableRequest2); %#ok<NASGU>
            %tableDescription = result2.getTableDescription(); %#ok<NASGU>

            table2 = dynamoDB.getTable(tableName2);
            table2.waitForActive();

            % list the tables
            listRequest = aws.dynamodbv2.model.ListTablesRequest();
            listResult = ddb.listTables(listRequest);
            lastName = listResult.getLastEvaluatedTableName();
            tableNames = listResult.getTableNames();
            % expecting 2 tables, may be more but <= 100
            testCase.verifyGreaterThan(numel(tableNames), 1);
            testCase.verifyLessThanOrEqual(numel(tableNames), 100);
            % number of tables <= 100 then lastName should not be set
            testCase.verifyEmpty(lastName);
            % all table names should be character vectors
            testCase.verifyTrue(iscellstr(tableNames)); %#ok<ISCLSTR>
            % check tableNames 1 & 2 appear once only
            testCase.verifyEqual(sum(contains(tableNames, tableName1)), 1);
            testCase.verifyEqual(sum(contains(tableNames, tableName2)), 1);

            deleteResult = ddb.deleteTable(tableName1); %#ok<NASGU>
            % table deletion can take longer than one waitForDelete call
            % if fails with an exception so catch that and try again
            try
                table1.waitForDelete();
            catch e
                e.message
                if (isa(e,'matlab.exception.JavaException'))
                    ex = e.ExceptionObject;
                    assert(isjava(ex));
                    ex.printStackTrace;
                end
                % try again, don't catch this one, two failures in a row is likely to be a problem
                table1.waitForDelete();
            end

            % list the tables again to verify tableName1 has gone
            listRequest = aws.dynamodbv2.model.ListTablesRequest();
            listResult = ddb.listTables(listRequest);
            lastName = listResult.getLastEvaluatedTableName();
            tableNames = listResult.getTableNames();
            % expecting 1 table, may be more but <= 100
            testCase.verifyGreaterThan(numel(tableNames), 0);
            testCase.verifyLessThanOrEqual(numel(tableNames), 100);
            % number of tables <= 100 then lastName should not be set
            testCase.verifyEmpty(lastName);
            % all table names should be character vectors
            testCase.verifyTrue(iscellstr(tableNames)); %#ok<ISCLSTR>
            % check tableNames 1 & 2 appear once only
            testCase.verifyEqual(sum(contains(tableNames, tableName1)), 0);
            testCase.verifyEqual(sum(contains(tableNames, tableName2)), 1);

            deleteResult = ddb.deleteTable(tableName2); %#ok<NASGU>
            try
                table2.waitForDelete();
            catch e
                e.message
                if (isa(e,'matlab.exception.JavaException'))
                    ex = e.ExceptionObject;
                    assert(isjava(ex));
                    ex.printStackTrace;
                end
                % try again, don't catch this one, two failures in a row is likely to be a problem
                table2.waitForDelete();
            end

            % list the tables again to verify tableName1 and tableName2 have gone
            listRequest = aws.dynamodbv2.model.ListTablesRequest();
            listResult = ddb.listTables(listRequest);
            lastName = listResult.getLastEvaluatedTableName();
            tableNames = listResult.getTableNames();
            % expecting 0 tables, may be more but <= 100
            testCase.verifyGreaterThanOrEqual(numel(tableNames), 0);
            testCase.verifyLessThanOrEqual(numel(tableNames), 100);
            % number of tables <= 100 then lastName should not be set
            testCase.verifyEmpty(lastName);
            % all table names should be character vectors
            testCase.verifyTrue(iscellstr(tableNames)); %#ok<ISCLSTR>
            % check tableNames 1 & 2 appear once only
            testCase.verifyEqual(sum(contains(tableNames, tableName1)), 0);
            testCase.verifyEqual(sum(contains(tableNames, tableName2)), 0);

            ddb.shutdown();
        end


        function testQueryItem(testCase)
            write(testCase.logObj,'debug','Testing testQueryItem');
            import java.util.UUID;
            ddb = aws.dynamodbv2.AmazonDynamoDBClient;
            ddb.useCredentialsProviderChain = false;
            ddb.initialize();

            % configure a TableCreateRequest
            uuid = char(UUID.randomUUID());
            tableName = ['myTableTest-', uuid];
            createTableRequest = aws.dynamodbv2.model.CreateTableRequest();
            testCase.verifyNotEmpty(createTableRequest.Handle);
            createTableRequest.setTableName(tableName);
            pt = aws.dynamodbv2.model.ProvisionedThroughput(uint64(10), uint64(10));
            createTableRequest.setProvisionedThroughput(pt);

            % configure two attribute definitions
            ad1 = aws.dynamodbv2.model.AttributeDefinition();
            ad1.setAttributeName('Language');
            ad1.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.S);
            ad2 = aws.dynamodbv2.model.AttributeDefinition();
            ad2.setAttributeName('Greeting');
            ad2.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.S);
            createTableRequest.setAttributeDefinitions([ad1, ad2]);

            % configure schema elements
            kse1 = aws.dynamodbv2.model.KeySchemaElement('Language', aws.dynamodbv2.model.KeyType.HASH);
            kse2 = aws.dynamodbv2.model.KeySchemaElement('Greeting', aws.dynamodbv2.model.KeyType.RANGE);
            createTableRequest.setKeySchema([kse1,kse2]);

            % create the table
            result = ddb.createTable(createTableRequest); %#ok<NASGU>
            dynamoDB = aws.dynamodbv2.document.DynamoDB(ddb);
            table1 = dynamoDB.getTable(tableName);
            table1.waitForActive();

            % populate some sample data
            av1 = aws.dynamodbv2.model.AttributeValue();
            av1.setS('eng');
            av2 = aws.dynamodbv2.model.AttributeValue();
            av2.setS('hello');
            attributeValues = containers.Map({'Language', 'Greeting'}, {av1, av2});
            putItemRequest = aws.dynamodbv2.model.PutItemRequest(tableName, attributeValues);
            putItemResult = ddb.putItem(putItemRequest); %#ok<NASGU>

            av1 = aws.dynamodbv2.model.AttributeValue();
            av1.setS('fr');
            av2 = aws.dynamodbv2.model.AttributeValue();
            av2.setS('bonjour');
            attributeValues = containers.Map({'Language', 'Greeting'}, {av1, av2});
            putItemRequest = aws.dynamodbv2.model.PutItemRequest(tableName, attributeValues);
            putItemResult = ddb.putItem(putItemRequest); %#ok<NASGU>

            % the table should now look as follows:
            %
            %  -----------------------
            %  | Language | Greeting |
            %  |==========|==========|
            %  | eng      | hello    |
            %  | fr       | bonjour  |
            %  -----------------------
            %

            % create the query
            queryRequest = aws.dynamodbv2.model.QueryRequest();
            queryRequest.setTableName(tableName);
            queryRequest.setConsistentRead(true);
            queryRequest.setKeyConditionExpression(['#a = :', 'Language']);
            % set the attribute name to the partition key name, Language
            attrName = containers.Map({'#a'}, {'Language'});
            queryRequest.setExpressionAttributeNames(attrName);
            % set an attribute value and build a containers.Map
            attrValue = aws.dynamodbv2.model.AttributeValue();
            attrValue.setS('eng');
            attrValues = containers.Map({[':','Language']}, {attrValue});
            queryRequest.setExpressionAttributeValues(attrValues);

            % run the query
            queryResult = ddb.query(queryRequest);
            testCase.verifyEqual(queryResult.getCount(), 1);

            % Tests the query result
            queryItems = queryResult.getItems();
            testCase.verifyEqual(numel(queryItems), 1);
            resultCM = queryItems{1};
            resultKeys = resultCM.keys;
            testCase.verifyTrue(strcmp(resultKeys{1}, 'Greeting'));
            testCase.verifyTrue(strcmp(resultKeys{2}, 'Language'));
            resultValues = resultCM.values;
            testCase.verifyTrue(strcmp(resultValues{1}.getS(), 'hello'));
            testCase.verifyTrue(strcmp(resultValues{2}.getS(), 'eng'));

            % cleanup
            deleteResult = ddb.deleteTable(tableName); %#ok<NASGU>
            table1.waitForDelete();

            ddb.shutdown();
        end


        function testUpdateItem(testCase)
            % see related sample Java code here: https://github.com/awsdocs/aws-doc-sdk-examples/blob/master/java/example_code/dynamodb/src/main/java/aws/example/dynamodb/UpdateItem.java
            % &
            % https://github.com/aws-samples/aws-dynamodb-examples/blob/master/src/main/java/com/amazonaws/codesamples/lowlevel/LowLevelItemCRUDExample.java
            write(testCase.logObj,'debug','Testing testUpdateItem');
            import java.util.UUID;
            ddb = aws.dynamodbv2.AmazonDynamoDBClient;
            ddb.useCredentialsProviderChain = false;
            ddb.initialize();

            % configure a TableCreateRequest
            uuid = char(UUID.randomUUID());
            tableName = ['myTableTest-', uuid];
            createTableRequest = aws.dynamodbv2.model.CreateTableRequest();
            testCase.verifyNotEmpty(createTableRequest.Handle);
            createTableRequest.setTableName(tableName);
            pt = aws.dynamodbv2.model.ProvisionedThroughput(uint64(5), uint64(5));
            createTableRequest.setProvisionedThroughput(pt);

            % configure two attribute definitions
            ad1 = aws.dynamodbv2.model.AttributeDefinition();
            ad1.setAttributeName('Language');
            ad1.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.S);
            createTableRequest.setAttributeDefinitions([ad1]); %#ok<NBRAK>

            % configure schema elements
            kse1 = aws.dynamodbv2.model.KeySchemaElement('Language', aws.dynamodbv2.model.KeyType.HASH);
            createTableRequest.setKeySchema([kse1]); %#ok<NBRAK>

            % create the table
            result = ddb.createTable(createTableRequest); %#ok<NASGU>
            dynamoDB = aws.dynamodbv2.document.DynamoDB(ddb);
            table1 = dynamoDB.getTable(tableName);
            table1.waitForActive();

            % populate some sample data
            engAV = aws.dynamodbv2.model.AttributeValue();
            engAV.setS('eng');
            helloAV = aws.dynamodbv2.model.AttributeValue();
            helloAV.setS('hello');
            attributeValues = containers.Map({'Language', 'Greeting'}, {engAV, helloAV});
            putItemRequest = aws.dynamodbv2.model.PutItemRequest(tableName, attributeValues);
            putItemResult = ddb.putItem(putItemRequest); %#ok<NASGU>

            frAV = aws.dynamodbv2.model.AttributeValue();
            frAV.setS('fr');
            bonjourAV = aws.dynamodbv2.model.AttributeValue();
            bonjourAV.setS('bonjour');
            attributeValues = containers.Map({'Language', 'Greeting'}, {frAV, bonjourAV});
            putItemRequest = aws.dynamodbv2.model.PutItemRequest(tableName, attributeValues);
            putItemResult = ddb.putItem(putItemRequest); %#ok<NASGU>

            % the table should now look as follows:
            %
            %  -----------------------
            %  | Language | Greeting |
            %  |==========|==========|
            %  | eng      | hello    |
            %  | fr       | bonjour  |
            %  -----------------------
            %

            % build request and update the table to change the bonjour
            % value to "ca va"
            frItemKey = containers.Map({'Language'}, {frAV});

            % change the bonjour greeting entry to ca va
            cavaAV = aws.dynamodbv2.model.AttributeValue();
            cavaAV.setS('ca va');
            expressionAttributeValues = containers.Map({':val1'}, {cavaAV});

            returnValues = aws.dynamodbv2.model.ReturnValue.ALL_NEW;
            updateItemRequest = aws.dynamodbv2.model.UpdateItemRequest();
            updateItemRequest.setTableName(tableName);
            updateItemRequest.setKey(frItemKey);
            updateItemRequest.setUpdateExpression('set Greeting = :val1');
            updateItemRequest.setExpressionAttributeValues(expressionAttributeValues);
            updateItemRequest.setReturnValues(returnValues);

            % do the update
            updateItemResult = ddb.updateItem(updateItemRequest); %#ok<NASGU>


            % retrieve the value we've just set
            getItemRequest = aws.dynamodbv2.model.GetItemRequest(tableName, frItemKey);
            % always return the most recent value to give deterministic test results
            getItemRequest.setConsistentRead(true);
            % get the item and the result
            getItemResult = ddb.getItem(getItemRequest);
            itemResult = getItemResult.getItem();

            % check the size of the result, there should be two values the
            % language and greeting
            resultKeys = itemResult.keys;
            testCase.verifyEqual(numel(resultKeys), 2);
            greetingValueAV = itemResult('Greeting');
            % get the string value fo the greeting attribute value
            greetingValue = greetingValueAV.getS();
            testCase.verifyTrue(strcmp(greetingValue, 'ca va'));

            % change the greeting entry back to bonjour but with a
            % condition expression so that it is only changed if the
            % current value is 'ca va'
            expressionAttributeValues = containers.Map({':val1', ':val2'}, {bonjourAV, cavaAV});

            returnValues = aws.dynamodbv2.model.ReturnValue.ALL_NEW;
            updateItemRequest = aws.dynamodbv2.model.UpdateItemRequest();
            updateItemRequest.setTableName(tableName);
            updateItemRequest.setKey(frItemKey);
            updateItemRequest.setConditionExpression('Greeting = :val2')
            updateItemRequest.setUpdateExpression('set Greeting = :val1');
            updateItemRequest.setExpressionAttributeValues(expressionAttributeValues);
            updateItemRequest.setReturnValues(returnValues);

            % do the update
            updateItemResult = ddb.updateItem(updateItemRequest); %#ok<NASGU>

            % Retrieve the value we've just set again
            getItemRequest = aws.dynamodbv2.model.GetItemRequest(tableName, frItemKey);
            getItemRequest.setConsistentRead(true);
            getItemResult = ddb.getItem(getItemRequest);
            itemResult = getItemResult.getItem();
            greetingValueAV = itemResult('Greeting');
            testCase.verifyTrue(strcmp(greetingValueAV.getS(), 'bonjour'));

            % cleanup
            deleteResult = ddb.deleteTable(tableName); %#ok<NASGU>
            table1.waitForDelete();
            ddb.shutdown();
        end


        function testUpdateTable(testCase)
            write(testCase.logObj,'debug','Testing testUpdateTable');
            import java.util.UUID;
            ddb = aws.dynamodbv2.AmazonDynamoDBClient;
            ddb.useCredentialsProviderChain = false;
            ddb.initialize();

            % configure a TableCreateRequest
            uuid = char(UUID.randomUUID());
            tableName = ['myTableTest-', uuid];
            createTableRequest = aws.dynamodbv2.model.CreateTableRequest();
            testCase.verifyNotEmpty(createTableRequest.Handle);
            createTableRequest.setTableName(tableName);
            pt1 = aws.dynamodbv2.model.ProvisionedThroughput(uint64(4), uint64(5));
            createTableRequest.setProvisionedThroughput(pt1);

            % configure two attribute definitions
            ad1 = aws.dynamodbv2.model.AttributeDefinition();
            ad1.setAttributeName('Language');
            ad1.setAttributeType(aws.dynamodbv2.model.ScalarAttributeType.S);
            createTableRequest.setAttributeDefinitions([ad1]); %#ok<NBRAK>

            % configure schema elements
            kse1 = aws.dynamodbv2.model.KeySchemaElement('Language', aws.dynamodbv2.model.KeyType.HASH);
            createTableRequest.setKeySchema([kse1]); %#ok<NBRAK>

            % create the table
            result = ddb.createTable(createTableRequest); %#ok<NASGU>
            dynamoDB = aws.dynamodbv2.document.DynamoDB(ddb);
            table = dynamoDB.getTable(tableName);
            table.waitForActive();

            % check the throughput values before the update
            tableDescription1 = table.describe();
            pt1Verify = tableDescription1.getProvisionedThroughput();
            testCase.verifyEqual(pt1Verify.getReadCapacityUnits, 4);
            testCase.verifyEqual(pt1Verify.getWriteCapacityUnits, 5);

            % updated the table
            updateTableRequest = aws.dynamodbv2.model.UpdateTableRequest();
            updateTableRequest.setTableName(tableName);
            pt2 = aws.dynamodbv2.model.ProvisionedThroughput(uint64(6), uint64(7));
            updateTableRequest.setProvisionedThroughput(pt2);
            updateTableResult = ddb.updateTable(updateTableRequest);  %#ok<NASGU>
            % not result can hold old values as set before the status
            % returns to active, updateTable is an asynchronous call
            table.waitForActive();

            % check the throughput values before after update
            tableDescription2 = table.describe();
            pt2Verify = tableDescription2.getProvisionedThroughput();
            testCase.verifyEqual(pt2Verify.getReadCapacityUnits, 6);
            testCase.verifyEqual(pt2Verify.getWriteCapacityUnits, 7);

            % cleanup
            deleteResult = ddb.deleteTable(tableName); %#ok<NASGU>
            % table deletion can take longer than one waitForDelete call
            % if fails with an exception so catch that and try again
            try
                table.waitForDelete();
            catch e
                e.message
                if (isa(e,'matlab.exception.JavaException'))
                    ex = e.ExceptionObject;
                    assert(isjava(ex));
                    ex.printStackTrace;
                end
                % try again, don't catch this one, two failures in a row is likely to be a problem
                table.waitForDelete();
            end
            ddb.shutdown();
        end

    end %methods
end %class
