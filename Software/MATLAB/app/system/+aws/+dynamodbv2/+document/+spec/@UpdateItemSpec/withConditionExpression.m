function updateItemSpec = withConditionExpression(obj, conditionExpression)
% WITHCONDITIONEXPRESSION Sets the Condition Expression for the update
% conditionExpression should be of character vector.
% An aws.dynamodbv2.document.spec.UpdateItemSpec is returned.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(conditionExpression)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected conditionExpression of type character vector');
end

% return a wrapped item type
updateItemSpecJ = obj.Handle.withConditionExpression(conditionExpression);
updateItemSpec = aws.dynamodbv2.document.spec.UpdateItemSpec(updateItemSpecJ);

end
