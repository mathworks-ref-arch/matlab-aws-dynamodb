function result = getDouble(obj, attrName)
% GETDOUBLE Gets an attribute of type double
% attrName should be a character vector.
% Result is returned as a double.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(attrName)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected attrName of type character vector');
end

result = obj.Handle.getDouble(attrName);

end
