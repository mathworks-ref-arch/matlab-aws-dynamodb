function setProvisionedThroughput(obj, value)
% SETPROVISIONEDTHROUGHPUT Updates a table's provisioned throughput
% A aws.dynamodbv2.model.ProvisionedThroughput object is expected as input.

% Copyright 2019 The MathWorks, Inc.

if isa(value, 'aws.dynamodbv2.model.ProvisionedThroughput')
    obj.Handle.setProvisionedThroughput(value.Handle);
else
    logObj = Logger.getLogger();
    write(logObj,'error','Expected value of type aws.dynamodbv2.model.ProvisionedThroughput');
end

end
