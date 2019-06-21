function setProvisionedThroughput(obj, throughput)
% SETPROVISIONEDTHROUGHPUT Sets the provisioned throughput of a table
% throughput should be provided as a ProvisionedThroughput object.

% Copyright 2019 The MathWorks, Inc.

if ~isa(throughput, 'aws.dynamodbv2.model.ProvisionedThroughput')
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected throughput of type aws.dynamodbv2.model.ProvisionedThroughput');
end

obj.Handle.setProvisionedThroughput(throughput.Handle);

end
