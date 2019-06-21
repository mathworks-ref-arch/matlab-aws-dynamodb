function item = withString(obj, attrName, val)
% WITHSTRING Sets item attribute value the given value
% attrName and val should be character vectors.
% An aws.dynamodbv2.document.Item is returned.

% Copyright 2019 The MathWorks, Inc.

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

itemJ = obj.Handle.withString(attrName, val);
item = aws.dynamodbv2.document.Item(itemJ);

end
