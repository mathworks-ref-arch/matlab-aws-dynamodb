function item = withJSON(obj, attrName, val)
% WITHJSON Sets value of attribute item to the JSON document in string form
% attrName and val should be character vectors.
% An aws.dynamodbv2.document.Item is returned.

% Copyright 2020 The MathWorks, Inc.

if ~ischar(attrName)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected attrName of type character vector');
end

if ~ischar(val)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected val of type character vector');
end

itemJ = obj.Handle.withJSON(attrName, val);
item = aws.dynamodbv2.document.Item(itemJ);

end
