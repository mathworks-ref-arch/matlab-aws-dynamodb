function result = getString(obj, attrName)
% GETSTRING Gets an attribute of type String
% attrName should be a character vector.
% Result is returned as a character vector.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(attrName)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected attrName of type character vector');
end

result = char(obj.Handle.getString(attrName));

end
