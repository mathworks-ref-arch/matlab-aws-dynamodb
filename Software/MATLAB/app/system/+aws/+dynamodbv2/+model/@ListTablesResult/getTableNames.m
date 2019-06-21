function names = getTableNames(obj)
% GETTABLENAMES Get names of tables associated with current account & endpoint
% The maximum size of this array is 100.
% A cell array of character vectors is returned.

% Copyright 2019 The MathWorks, Inc.

% Java List of strings
namesJ = obj.Handle.getTableNames();

size = namesJ.size();
names = cell(size,1);

if size > 0
    % get the iterator
    iteratorJ = namesJ.iterator();
    ctr = 1;
    while iteratorJ.hasNext()
        names{ctr} = char(iteratorJ.next());
        ctr = ctr + 1;
    end
end

end
