classdef ProvisionedThroughput < aws.Object
    % PROVISIONEDTHROUGHPUT Represents settings for a specified table or index
    % The settings can be modified using the UpdateTable operation.
    % For current minimum and maximum provisioned throughput values, see limits
    % in the Amazon DynamoDB Developer Guide.

    % Copyright 2018 The MathWorks, Inc.

    methods
        function obj = ProvisionedThroughput(readCapacityUnits, writeCapacityUnits)

            if ~isa(readCapacityUnits, 'uint64') || ~isa(writeCapacityUnits, 'uint64')
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type uint64');
            end

            obj.Handle = com.amazonaws.services.dynamodbv2.model.ProvisionedThroughput(java.lang.Long(readCapacityUnits), java.lang.Long(writeCapacityUnits));
        end
    end
end
