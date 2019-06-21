function setKeySchema(obj, keySchemas)
% SETKEYSCHEMA Specifies attributes of the primary key for a table or an index

% Copyright 2019 The MathWorks, Inc.

if ~isa(keySchemas, 'aws.dynamodbv2.model.KeySchemaElement')
    logObj = Logger.getLogger();
    write(logObj,'error','argument not of type array of aws.dynamodbv2.model.KeySchemaElement');
end

% Convert keySchemas to a Java collection type of the Handle objects
keySchemasJ = java.util.ArrayList(numel(keySchemas));

for n = 1:numel(keySchemas)
    keySchemasJ.add(keySchemas(n).Handle);
end

obj.Handle.setKeySchema(keySchemasJ);

end
