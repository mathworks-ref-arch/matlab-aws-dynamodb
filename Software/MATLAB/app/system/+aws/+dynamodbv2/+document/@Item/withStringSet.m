function item = withStringSet(obj, attrName, val)
% WITHSTRINGSET Sets item attribute value the given value
% attrName should be character vectors and val a cell array of character vectors.
% An aws.dynamodbv2.document.Item is returned.

% Copyright 2019 The MathWorks, Inc.

if ~ischar(attrName)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected attrName of type character vector');
end

if ~iscellstr(val) %#ok<ISCLSTR>
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected val of type cell array of character vectors');
end

itemJ = obj.Handle.withStringSet(attrName, val);
item = aws.dynamodbv2.document.Item(itemJ);

end
