function result = getNS(obj)
% GETNS Gets a set of attributes of type Number
% Result is returned as a cell array of character vectors.
% If no results are available the cell array may be empty.

% Copyright 2019 The MathWorks, Inc.

resultJ = obj.Handle.getNS();

if ~isempty(resultJ)
    size = resultJ.size();
    result = cell(size,1);

    if size > 0
        % get the iterator
        iteratorJ = resultJ.iterator();
        ctr = 1;
        while iteratorJ.hasNext()
            result{ctr} = char(iteratorJ.next());
            ctr = ctr + 1;
        end
    end
else
    result = {};
end
