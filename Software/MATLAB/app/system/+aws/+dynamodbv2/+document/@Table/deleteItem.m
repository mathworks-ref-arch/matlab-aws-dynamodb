function result = deleteItem(obj, spec)
% DELTEITEM Adds an item to a table
% spec should be of type aws.dynamodbv2.document.spec.DeleteItemSpec.
% A DeleteItemOutcome object is returned.

% Copyright 2019 The MathWorks, Inc.

if ~isa(spec, 'aws.dynamodbv2.document.spec.DeleteItemSpec')
    logObj = Logger.getLogger();
    write(logObj,'error','Expected spec of type aws.dynamodbv2.document.spec.DeleteItemSpec');
end

resultJ = obj.Handle.deleteItem(spec.Handle);
result = aws.dynamodbv2.document.DeleteItemOutcome(resultJ);

end
