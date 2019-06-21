function setKeyConditionExpression(obj, keyConditionExpression)
% SETKEYCONDITIONEXPRESSION Condition that specifies key value(s) for items

% Copyright 2019 The MathWorks, Inc.

if ~ischar(keyConditionExpression)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected keyConditionExpression of type character vector');
end

obj.Handle.setKeyConditionExpression(keyConditionExpression)

end
