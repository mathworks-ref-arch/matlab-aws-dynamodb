function setReturnValues(obj, returnValues)
% SETRETURNVALUES
% returnValues should be of type aws.dynamodbv2.model.ReturnValue.

% Copyright 2019 The MathWorks, Inc.

if ~isa(returnValues, 'aws.dynamodbv2.model.ReturnValue')
    logObj = Logger.getLogger();
    write(logObj,'error','returnValues argument not of type aws.dynamodbv2.model.ReturnValue');
end

obj.Handle.setReturnValues(returnValues.toJava());

end
