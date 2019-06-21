function result = getItem(obj, getItemSpec)
% GETITEM Gets an item from a table
% Item should be of type aws.dynamodbv2.document.spec.GetItemSpec.
% An aws.dynamodbv2.document.Item object is returned if the item exists if
% not an empty logical array is returned.

% Copyright 2019 The MathWorks, Inc.

if ~isa(getItemSpec, 'aws.dynamodbv2.document.spec.GetItemSpec')
    logObj = Logger.getLogger();
    write(logObj,'error','Expected getItemSpec of type aws.dynamodbv2.document.spec.GetItemSpec');
end

resultJ = obj.Handle.getItem(getItemSpec.Handle);
if isempty(resultJ)
    result = logical.empty;
else
    result = aws.dynamodbv2.document.Item(resultJ);
end

end
