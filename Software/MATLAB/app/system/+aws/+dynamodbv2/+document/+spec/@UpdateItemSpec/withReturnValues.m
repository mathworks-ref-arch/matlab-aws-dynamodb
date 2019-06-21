function updateItemSpec = withReturnValues(obj, returnValues)
% WITHRETURNVALUES
% returnValues should be of type aws.dynamodbv2.model.ReturnValue.
% An aws.dynamodbv2.document.spec.UpdateItemSpec is returned.

% Copyright 2019 The MathWorks, Inc.

if ~isa(returnValues, 'aws.dynamodbv2.model.ReturnValue')
    logObj = Logger.getLogger();
    write(logObj,'error','returnValues argument not of type aws.dynamodbv2.model.ReturnValue');
end

updateItemSpecJ = obj.Handle.withReturnValues(returnValues.toJava());
updateItemSpec = aws.dynamodbv2.document.spec.UpdateItemSpec(updateItemSpecJ);

end
