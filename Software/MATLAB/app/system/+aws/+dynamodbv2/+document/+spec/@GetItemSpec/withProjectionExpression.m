function getItemSpec = withProjectionExpression(obj, projectionExpression)
% WITHPROJECTIONEXPRESSION Sets a Projection Expression for the spec
% projectionExpression should be a character vector.
% An aws.dynamodbv2.document.spec.GetItemSpec is returned.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(projectionExpression)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected projectionExpression of type character vector');
end

getItemSpecJ = obj.Handle.withProjectionExpression(projectionExpression);
getItemSpec = aws.dynamodbv2.document.spec.GetItemSpec(getItemSpecJ);

end
