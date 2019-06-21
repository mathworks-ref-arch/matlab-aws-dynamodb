function result = getBOOL(obj, attrName)
% GETBOOL Gets an attribute of type Boolean
% attrName should be a character vector.
% Result is returned as a logical.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(attrName)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected attrName of type character vector');
end

resultJ = obj.Handle.getBOOL(attrName);
result = resultJ.booleanValue();

end
