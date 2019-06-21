function setAttributeType(obj, type)
% SETATTRIBUTENAME Sets the type of an attribute
% The type should be provided as a ScalarAttributeType.

% Copyright 2019 The MathWorks, Inc.

if ~isa(type, 'aws.dynamodbv2.model.ScalarAttributeType')
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected type of type aws.dynamodbv2.model.ScalarAttributeType');
end

obj.Handle.setAttributeType(type.toJava);

end
