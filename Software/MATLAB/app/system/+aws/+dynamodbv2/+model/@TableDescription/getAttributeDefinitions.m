function attributes = getAttributeDefinitions(obj)
% GETATTRIBUTESDEFINITIONS Returns an array of AttributeDefinition objects

% Copyright 2019 The MathWorks, Inc.

attributes = aws.dynamodbv2.model.AttributeDefinition.empty();

attributesJ = obj.Handle.getAttributeDefinitions();

jIter = attributesJ.iterator;
while jIter.hasNext()
    attributes(end+1) = aws.dynamodbv2.model.AttributeDefinition(jIter.next); %#ok<AGROW>
end

end
