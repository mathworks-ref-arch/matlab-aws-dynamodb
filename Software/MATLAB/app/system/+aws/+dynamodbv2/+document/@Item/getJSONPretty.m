function result = getJSONPretty(obj, attrName)
% GETJSONPRETTY Returns attribute value as a JSON string with pretty indentation
% An empty character vector is returned if the attribute either doesn't exist
% or the attribute value is null.
% attrName should be a character vector.
% Result is returned as a character vector.

% Copyright 2020 The MathWorks, Inc.

if ~ischar(attrName)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected attrName of type character vector');
end

result = char(obj.Handle.getJSONPretty(attrName));

end
