function updateItemSpec = withValueMap(obj, map)
% WITHVALUEMAP Specify the values for the attribute-value placeholders
% Applicable only when an expression has been specified.
% An aws.dynamodbv2.document.spec.UpdateItemSpec is returned.

% Copyright 2019 The MathWorks, Inc.

if ~isa(map, 'containers.Map')
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected map of type containers.Map');
end

keys = map.keys();
values = map.values();
hMapJ = java.util.HashMap;
for n = 1:numel(keys)
    % add an entry to the HashMap per iteration
    hMapJ.put(keys{n}, values{n});
end

updateItemSpecJ = obj.Handle.withValueMap(hMapJ);
updateItemSpec = aws.dynamodbv2.document.spec.UpdateItemSpec(updateItemSpecJ);

end
