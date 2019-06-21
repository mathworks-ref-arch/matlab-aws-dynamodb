function querySpec = withNameMap(obj, map)
% WITHNAMEMAP Specify the values for the attribute-name placeholders
% Value in the map can either be string for simple attribute name, or a
% JSON path expression.
% Applicable only when an expression has been specified.
% An aws.dynamodbv2.document.spec.QuerySpec is returned.

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

querySpecJ = obj.Handle.withNameMap(hMapJ);
querySpec = aws.dynamodbv2.document.spec.QuerySpec(querySpecJ);

end
