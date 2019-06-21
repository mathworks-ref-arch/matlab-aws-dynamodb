function setConditionExpression(obj, conditionExpression)
% SETCONDITIONEXPRESSION Condition that specifies key value(s) for items
% conditionExpression should be of type character vector.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(conditionExpression)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected conditionExpression of type character vector');
end

obj.Handle.setConditionExpression(conditionExpression)

end
