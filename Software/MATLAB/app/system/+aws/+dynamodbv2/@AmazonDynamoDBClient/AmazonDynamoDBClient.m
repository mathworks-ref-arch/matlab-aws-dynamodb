classdef AmazonDynamoDBClient < aws.Object
    % CLIENT Object to represent an Amazon DynamoDB client
    % The client is used to carry out operations with the DynamoDB service
    %
    % Example:
    %    % Create client
    %    ddb = aws.dynamodbv2.AmazonDynamoDBClient;
    %    % Initialize the client
    %    ddb.initialize();
    %    % Use the client to carry out actions on DynamoDB
    %    createTableRequest = aws.dynamodbv2.model.CreateTableRequest();
    %    createTableRequest.setTableName(tableName);
    %    createResult = ddb.createTable(createTableRequest);
    %    % Shutdown the client when no longer needed
    %    ddb.shutdown();

    % Copyright 2018-2021 The MathWorks, Inc.

    properties
        % default to using the AWS provider chain
        credentialsFilePath = 'credentials.json';
        useCredentialsProviderChain = true;
        clientConfiguration = aws.ClientConfiguration();
        endpointURI = matlab.net.URI();
    end

    methods
        % Constructor
        function obj = AmazonDynamoDBClient(~, varargin)
            %Create logger reference and message prefix
            logObj = Logger.getLogger();
            logObj.MsgPrefix = 'AWS:DDB';
            % default is debug
            % logObj.DisplayLevel = 'debug';

            write(logObj,'verbose','Creating Client');
            % error if JVM is not enabled or MATLAB is too old
            if ~usejava('jvm')
                write(logObj,'error','MATLAB must be used with the JVM enabled to access Amazon DynamoDB');
            end
            if verLessThan('matlab','9.2') % R2017a
                write(logObj,'error','MATLAB Release 2017a or newer is required');
            end

            obj.credentialsFilePath = 'credentials.json';
            obj.useCredentialsProviderChain = true;
            obj.clientConfiguration = aws.ClientConfiguration();
            obj.endpointURI = matlab.net.URI();
        end

        %% Setter functions
        function set.useCredentialsProviderChain(obj, tf)
            if islogical(tf)
                obj.useCredentialsProviderChain = tf;
            else
                write(logObj,'error','Expected useCredentialsProviderChain of type logical');
            end
        end

        % set a custom path to a json credentials file
        function set.credentialsFilePath(obj, credFile)
            % Create a logger object
            logObj = Logger.getLogger();

            if ischar(credFile)
                obj.credentialsFilePath = credFile;
            else
                write(logObj,'error','Expected credentialsFilePath of type character vector');
            end
        end

        % set clientConfiguration used for proxy settings
        function set.clientConfiguration(obj, config)
            % Create a logger object
            logObj = Logger.getLogger();

            if isa(config,'aws.ClientConfiguration')
                obj.clientConfiguration = config;
            else
                write(logObj,'error','Expected clientConfiguration of type aws.ClientConfiguration');
            end
        end

        function set.endpointURI(obj, endpointStr)
            % Create a logger object
            logObj = Logger.getLogger();

            epURI = matlab.net.URI(endpointStr);
            if isa(epURI,'matlab.net.URI')
                obj.endpointURI = epURI;
            else
                write(logObj,'error','Expected endpointURI of type matlab.net.URI');
            end
        end

    end %methods
end %class
