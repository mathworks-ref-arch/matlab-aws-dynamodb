function getItemSpec = withConsistentRead(obj, consistentRead)
% WITHCONSISTENTREAD Sets get's ConsistentRead property
% consistentRead should be of type logical.

% Copyright 2019 The MathWorks, Inc.

if ~islogical(consistentRead)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected consistentRead to be a logical');
end

getItemSpecJ = obj.Handle.withConsistentRead(consistentRead);
getItemSpec = aws.dynamodbv2.document.spec.GetItemSpec(getItemSpecJ);

end
