function updateItemSpec = withUpdateExpression(obj, updateExpression)
% WITHUPDATEEXPRESSION Sets the Update Expression for the update
% updateExpression should be of character vector.
% An aws.dynamodbv2.document.spec.UpdateItemSpec is returned.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(updateExpression)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected updateExpression of type character vector');
end

% return a wrapped item type
updateItemSpecJ = obj.Handle.withUpdateExpression(updateExpression);
updateItemSpec = aws.dynamodbv2.document.spec.UpdateItemSpec(updateItemSpecJ);

end
