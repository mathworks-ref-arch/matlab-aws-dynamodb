function item = withDouble(obj, attrName, val)
% WITHDOUBLE Sets item attribute value the given value
% attrName should be a character vector and val should be a double.
% An aws.dynamodbv2.document.Item is returned.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(attrName)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected attrName of type character vector');
end

if ~isa(val,'double')
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected val to be a double');
end

itemJ = obj.Handle.withDouble(attrName, val);
item = aws.dynamodbv2.document.Item(itemJ);

end
