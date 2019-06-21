function [tableResults, names] = listTables(obj)
% LISTTABLES Lists tables
% A cell array of table objects and a cell array of table names is returned.

% Copyright 2019 The MathWorks, Inc.

tableCollectionJ = obj.Handle.listTables();

pageIterableJ = tableCollectionJ.pages();

pageIteratorJ = pageIterableJ.iterator();

ctr = 1;
names = {};
while pageIteratorJ.hasNext()
    listTablesPageJ = pageIteratorJ.next();
    listTablesResultJ = listTablesPageJ.getLowLevelResult();
    namesJ = listTablesResultJ.getTableNames();
    namesIteratorJ = namesJ.iterator();
    while namesIteratorJ.hasNext()
        names{ctr} =  char(namesIteratorJ.next()); %#ok<AGROW>
        ctr = ctr + 1;
    end
end

% build a cell array of table objects and return that
tableResults = cell(numel(names),1);
for n = 1:numel(names)
    tableResults{n} = obj.getTable(names{n});
end

end
