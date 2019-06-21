function deleteItemSpec = withConditionExpression(obj, conditionExpression)
% WITHCONDITIONEXPRESSION Sets the Condition Expression for the delete
% conditionExpression should be of character vector.
% An aws.dynamodbv2.document.spec.DeleteItemSpec is returned.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(conditionExpression)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected conditionExpression of type character vector');
end

% return a wrapped item type
deleteItemSpecJ = obj.Handle.withConditionExpression(conditionExpression);
deleteItemSpec = aws.dynamodbv2.document.spec.DeleteItemSpec(deleteItemSpecJ);

end
