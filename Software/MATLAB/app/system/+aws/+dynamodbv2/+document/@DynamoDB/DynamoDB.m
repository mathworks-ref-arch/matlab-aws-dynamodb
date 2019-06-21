classdef DynamoDB < aws.Object
% DYNAMODB Constructs a new DynamoDB object
% A DynamoDB is constructed based on the equivalent underlying Java SDK object
% or more commonly a aws.dynamodbv2.AmazonDynamoDBClient client.
%
% Example:
%    % create a client from which to create a DynamoDB object
%    ddbClient = aws.dynamodbv2.AmazonDynamoDBClient;
%    ddbClient.useCredentialsProviderChain = false;
%    ddbClient.initialize();
%    % Create the document API DynamoDB object
%    ddb = aws.dynamodbv2.document.DynamoDB(ddbClient);

% Copyright 2019 The MathWorks, Inc.

methods
    function obj = DynamoDB(varargin)

        if nargin == 1
            % constructing based on a region enum is not currently supported
            if isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.document.DynamoDB')
                obj.Handle = varargin{1};
            elseif isa(varargin{1}, 'aws.dynamodbv2.AmazonDynamoDBClient')
                obj.Handle = com.amazonaws.services.dynamodbv2.document.DynamoDB(varargin{1}.Handle);
            else
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.document.DynamoDB');
            end
        else
            logObj = Logger.getLogger();
            write(logObj,'error','Invalid number of arguments');
        end
    end
end

end
