function primaryKey = addComponent(obj, keyAttributeName, keyAttributeValue)
% ADDCOMPONEENT Add a key component to this primary key
% keyAttributeName shouls be to type character vector.
% keyAttributeValue may be a character vector or numeric.
% An aws.dynamodbv2.document.PrimaryKey object is returned.

% Copyright 2019 The MathWorks, Inc.


if ~ischar(keyAttributeName)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected keyAttributeName of type character vector');
end

% initially handle primary keys of types that MATLAB to java marshaling handles
if ~(ischar(keyAttributeValue) || isnumeric(keyAttributeValue))
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected keyAttributeValue of type character vector or numeric');
end

primaryKeyJ = obj.Handle.addComponent(keyAttributeName, keyAttributeValue);
primaryKey = aws.dynamodbv2.document.PrimaryKey(primaryKeyJ);


end
