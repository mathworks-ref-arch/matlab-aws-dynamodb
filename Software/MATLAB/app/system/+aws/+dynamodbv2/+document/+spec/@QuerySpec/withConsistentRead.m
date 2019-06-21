function querySpec = withConsistentRead(obj, consistentRead)
% WITHCONSISTENTREAD Sets query's ConsistentRead property
% consistentRead should be of type logical.

% Copyright 2019 The MathWorks, Inc.

if ~islogical(consistentRead)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected consistentRead to be a logical');
end

querySpecJ = obj.Handle.withConsistentRead(consistentRead);
querySpec = aws.dynamodbv2.document.spec.QuerySpec(querySpecJ);

end
