function result = getBoolean(obj, attrName)
% GETBOOLEAN Gets an attribute of type boolean
% attrName should be a character vector.
% Result is returned as a logical.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(attrName)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected attrName of type character vector');
end

result = obj.Handle.getBoolean(attrName);

end
