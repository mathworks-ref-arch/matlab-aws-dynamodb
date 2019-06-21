function setAttributeDefinitions(obj, attributesDefinitions)
% SETATTRIUTEDEFINITIONS Set attributesDefinitions that describe the key schema
% attributesDefinitions are an array of attributesDefinitions that describe the key schema for the
% table and indexes.

% Copyright 2019 The MathWorks, Inc.

if ~isa(attributesDefinitions, 'aws.dynamodbv2.model.AttributeDefinition')
    logObj = Logger.getLogger();
    write(logObj,'error','argument not of type array of aws.dynamodbv2.model.AttributeDefinition');
end

% Convert attributes to a Java collection type of the Handle objects
attributesDefinitionsJ = java.util.ArrayList(numel(attributesDefinitions));

for n = 1:numel(attributesDefinitions)
    attributesDefinitionsJ.add(attributesDefinitions(n).Handle);
end

obj.Handle.setAttributeDefinitions(attributesDefinitionsJ);

end
