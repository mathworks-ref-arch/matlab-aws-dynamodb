function item = withPrimaryKey(obj, varargin)
% WITHPRIMARYKEY Sets the attributes of this item from the given key attributes
% primaryKey should be of type character vector. hashKeyValue may be numeric or
% a character vector
% An aws.dynamodbv2.document.Item is returned.
%
% Example:
%    itemResult = myItem.withPrimaryKey('myKeyName');
%    or
%    itemResult = myItem.withPrimaryKey('myKeyName', 1977);


% Copyright 2019 The MathWorks, Inc.

p = inputParser;
p.CaseSensitive = false;
p.FunctionName = 'withPrimaryKey';

% The primary key name is required
addRequired(p, 'primaryKey', @ischar);
% Provide the optional hashKeyValue for now support numeric and char values
% as these are by far the most likely and will be automatically marshaled to
% Java types
validationFcn = @(x) isnumeric(x) || ischar(x);
addOptional(p, 'hashKeyValue', '', validationFcn);

% Parse and validate input
parse(p,varargin{:});

primaryKey = p.Results.primaryKey;
hashKeyValue = p.Results.hashKeyValue;


if isempty(hashKeyValue)
    itemJ = obj.Handle.withPrimaryKey(primaryKey);
else
    itemJ = obj.Handle.withPrimaryKey(primaryKey, hashKeyValue);
end

% return a wrapped item type
item = aws.dynamodbv2.document.Item(itemJ);

end
