function deleteItemSpec = withPrimaryKey(obj, varargin)
% WITHPRIMARYKEY Sets the Primary Key of the item for deletion
% A primary key of type aws.dynamodbvs.document.PrimaryKey can be provided or
% a combination of a character vector hashKeyName and a hashKeyValue that may be
% numeric or a character vector.
% An aws.dynamodbv2.document.spec.DeleteItemSpec is returned.
%
% Example:
%   deleteItemSpec = deleteItemSpec.withPrimaryKey(myPrimaryKey);
%   or
%   deleteItemSpec = deleteItemSpec.withPrimaryKey('myKeyName', 1977);



% Copyright 2019 The MathWorks, Inc.

p = inputParser;
p.CaseSensitive = false;
p.FunctionName = 'withPrimaryKey';

if nargin == 2
    % The primary key name is required
    validationFcn = @(x) isa(x, 'aws.dynamodbv2.document.PrimaryKey');
    addRequired(p, 'primaryKey', validationFcn);
elseif nargin == 3
    addRequired(p, 'hashKeyName', @ischar);
    % Provide the optional hashKeyValue for now support numeric and char values
    % as these are by far the most likely and will be automatically marshaled to
    % Java types
    validationFcn = @(x) isnumeric(x) || ischar(x);
    addRequired(p, 'hashKeyValue', validationFcn);
else
    logObj = Logger.getLogger();
    write(logObj,'error','Invalid number of arguments');
end

% Parse and validate input
parse(p, varargin{:});

if nargin == 2
    primaryKey = p.Results.primaryKey;
    deleteItemSpecJ = obj.Handle.withPrimaryKey(primaryKey.Handle);
else
    hashKeyName = p.Results.hashKeyName;
    hashKeyValue = p.Results.hashKeyValue;
    deleteItemSpecJ = obj.Handle.withPrimaryKey(hashKeyName, hashKeyValue);
end

deleteItemSpec = aws.dynamodbv2.document.spec.DeleteItemSpec(deleteItemSpecJ);

end
