classdef ProvisionedThroughputDescription < aws.Object
    % PROVISIONEDTHROUGHPUTDESCRIPTION Provisioned throughput table settings
    % Consists of read and write capacity units.

    % Copyright 2019 The MathWorks, Inc.

    methods
        function obj = ProvisionedThroughputDescription(varargin)
            import com.amazonaws.services.dynamodbv2.model.ProvisionedThroughputDescription

            if nargin == 0
                obj.Handle = com.amazonaws.services.dynamodbv2.model.ProvisionedThroughputDescription();
            elseif nargin == 1
                if ~isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.model.ProvisionedThroughputDescription')
                    write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.model.ProvisionedThroughputDescription');
                end
                obj.Handle = varargin{1};
            else
                write(logObj,'error','Invalid number of arguments');
            end
        end
    end
end
