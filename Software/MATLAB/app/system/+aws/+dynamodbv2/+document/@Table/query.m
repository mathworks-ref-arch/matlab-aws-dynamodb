function result = query(obj, varargin)
% QUERY Returns the result of a query on a table
% A cell array of aws.dynamodbv2.document.Item objects is returned.
% A query can be provided as a aws.dynamodbv2.document.spec.QuerySpec
% object as named value.
%
% Example:
%    queryOutcome = ddb.query('querySpec', myQuerySpecObj);


% Copyright 2019 The MathWorks, Inc.

p = inputParser;
p.CaseSensitive = false;
p.FunctionName = 'query';

checkSpec = @(x) isa(x, 'aws.dynamodbv2.document.spec.QuerySpec');
addParameter(p, 'querySpec', aws.dynamodbv2.document.spec.QuerySpec(), checkSpec);

parse(p,varargin{:});
querySpec = p.Results.querySpec;

% For now handle only QuerySpec
if ~isempty(querySpec.Handle)
    % returns a QueryOutcome collection
    resultJ = obj.Handle.query(querySpec.Handle);
else
    logObj = Logger.getLogger();
    write(logObj,'error','Invalid input argument');
end

result = {};
pagesJ = resultJ.pages();
pagesIteratorJ = pagesJ.iterator();
while pagesIteratorJ.hasNext()
   pageJ =  pagesIteratorJ.next();
   pageIteratorJ = pageJ.iterator();
   while pageIteratorJ.hasNext()
      itemJ = pageIteratorJ.next();
      result{end+1} = aws.dynamodbv2.document.Item(itemJ); %#ok<AGROW>
   end
end
    
end
