function querySpec = withKeyConditionExpression(obj, keyConditionExpression)
% WITHKEYCONDITIONEXPRESSION Sets the key condition expression for the query
% When a key condition expression is specified, the corresponding name-map and
% value-map can optionally be specified via withNameMap() and withValueMap().
% keyConditionExpression should be of character vector.
% An aws.dynamodbv2.document.spec.QuerySpec is returned.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(keyConditionExpression)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected keyConditionExpression of type character vector');
end

% return a wrapped item type
querySpecJ = obj.Handle.withKeyConditionExpression(keyConditionExpression);
querySpec = aws.dynamodbv2.document.spec.QuerySpec(querySpecJ);

end
