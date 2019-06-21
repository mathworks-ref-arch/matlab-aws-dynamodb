classdef KeySchemaElement < aws.Object
    % KEYSCHEMAELEMENT Represents a single element of a key schema
    % The attributeName should be provided as a character vector and the keyType
    % should be provided as KeyType enum.
    %
    % Example:
    %    keySchemaElement = KeySchemaElement('myAttribName', aws.dynamodbv2.model.KeyType.HASH);

    % Copyright 2019 The MathWorks, Inc.

    methods
        function obj = KeySchemaElement(attributeName, keyType)

            if ~ischar(attributeName)
                logObj = Logger.getLogger();
                write(logObj,'error','attributeName not of type character vector');
            end

            if ~isa(keyType, 'aws.dynamodbv2.model.KeyType')
                logObj = Logger.getLogger();
                write(logObj,'error','keyType not of type aws.dynamodbv2.model.KeyType');
            end

            obj.Handle = com.amazonaws.services.dynamodbv2.model.KeySchemaElement(attributeName, keyType.toJava);
        end
    end
end
