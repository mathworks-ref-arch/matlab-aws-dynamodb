function item = withInt(obj, attrName, val)
% WITHINT Sets item attribute value the given value
% attrName should be a character vector and val should be a int.
% An aws.dynamodbv2.document.Item is returned.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(attrName)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected attrName of type character vector');
end

if ~isinteger(val)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected val to be a integer');
end

itemJ = obj.Handle.withInt(attrName, val);
item = aws.dynamodbv2.document.Item(itemJ);

end
