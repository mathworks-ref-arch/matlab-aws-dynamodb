function items = getItems(obj)
% GETITEMS Returns a cell array of the returned items, can be empty

% Copyright 2019 The MathWorks, Inc.

itemsJ = obj.Handle.getItems();
size = itemsJ.size();

items = cell(size,1);
if size > 0
    % get the iterator
    iteratorJ = itemsJ.iterator();
    ctr = 1;
    while iteratorJ.hasNext()
        items(ctr) = aws.dynamodbv2.document.Item(iteratorJ.next());
        ctr = ctr + 1;
    end
end

end
