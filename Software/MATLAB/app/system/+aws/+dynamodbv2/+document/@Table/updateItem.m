function result = updateItem(obj, varargin)
% UPDATEITEM Updates an item
% An UpdateItemOutcome object is returned.
% An itemSpec can be provided as a aws.dynamodbv2.document.UpdateItemSpec object as a
% named value.
%
% Example:
%    updateItemOutcome = ddb.updateItem('updateItemSpec', myUpdateItemSpecObj);

% Copyright 2019 The MathWorks, Inc.

p = inputParser;
p.CaseSensitive = false;
p.FunctionName = 'updateItem';

checkSpec = @(x) isa(x, 'aws.dynamodbv2.document.spec.UpdateItemSpec');
addParameter(p, 'updateItemSpec' , aws.dynamodbv2.document.spec.UpdateItemSpec(), checkSpec);

parse(p,varargin{:});
updateItemSpec = p.Results.updateItemSpec;

if ~isempty(updateItemSpec.Handle)
    resultJ = obj.Handle.updateItem(updateItemSpec.Handle);
else
    logObj = Logger.getLogger();
    write(logObj,'error','Invalid input');
end

result = aws.dynamodbv2.document.UpdateItemOutcome(resultJ);

end
