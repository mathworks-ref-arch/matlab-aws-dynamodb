function throughputInfo = getProvisionedThroughput(obj)
% GETPROVISIONTHROUGHOUT Returns the provisioned throughput of a table
% Result is returned as a aws.dynamodbv2.model.ProvisionedThroughputDescription

% Copyright 2019 The MathWorks, Inc.

throughputInfoJ = obj.Handle.getProvisionedThroughput();
throughputInfo = aws.dynamodbv2.model.ProvisionedThroughputDescription(throughputInfoJ);

end
