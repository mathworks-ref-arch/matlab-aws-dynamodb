function item = withBoolean(obj, attrName, val)
% WITHBOOLEAN Sets item attribute value the given value
% attrName should be a character vector and val should be a logical.
% An aws.dynamodbv2.document.Item is returned.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(attrName)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected attrName of type character vector');
end

if ~islogical(val)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected val to be a logical');
end

itemJ = obj.Handle.withBoolean(attrName, val);
item = aws.dynamodbv2.document.Item(itemJ);

end
