function result = getInt(obj, attrName)
% GETINT Gets an attribute of type Int
% attrName should be a character vector.
% Result is returned as an int64.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(attrName)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected attrName of type character vector');
end

result = int64(obj.Handle.getInt(attrName));

end
