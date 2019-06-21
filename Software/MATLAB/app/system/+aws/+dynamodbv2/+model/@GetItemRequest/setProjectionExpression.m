function setProjectionExpression(obj, expression)
% SETPROJECTIONEXPRESSSION Sets string that identifies attributes to retrieve
% The expression should be of type character vector.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(expression)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected expression of type character vector');
end

obj.Handle.setProjectionExpression(expression);

end
