function setUpdateExpression(obj, expression)
% SETUPDATEEXPRESSION Sets expression that defines one or more attributes to be updated

% Copyright 2019 The MathWorks, Inc.

if ~ischar(expression)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected expression of type character vector');
end

obj.Handle.setUpdateExpression(expression);

end
