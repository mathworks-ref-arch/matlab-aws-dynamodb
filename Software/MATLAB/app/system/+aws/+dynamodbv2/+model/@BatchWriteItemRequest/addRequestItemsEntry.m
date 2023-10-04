function result = addRequestItemsEntry(obj, key, writeRequests)
    % ADDREQUESTITEMSENTRY Add a single RequestItems entry
    % A aws.dynamodbv2.model.BatchWriteItemRequest object is returned

    % Copyright 2020-2023 The MathWorks, Inc.

    if ~isa(writeRequests, 'aws.dynamodbv2.model.WriteRequest')
        logObj = Logger.getLogger();
        write(logObj,'error','argument writeRequests not of type array of aws.dynamodbv2.model.WriteRequest');
    end

    if ~(ischar(key) || isStringScalar(key))
        logObj = Logger.getLogger();
        write(logObj,'error','argument key not of type character vector or scalar string');
    end

    if numel(writeRequests) + obj.requestCount > obj.requestLimit
        logObj = Logger.getLogger();
        write(logObj,'error',...
            ['BatchWriteItemRequests can only write ', num2str(obj.requestLimit), ' requests at once']);
    else
        obj.requestCount = obj.requestCount + numel(writeRequests);
    end

    % Convert writeRequests to a Java collection type of the Handle objects
    writeRequestsJ = java.util.ArrayList(numel(writeRequests));

    for n = 1:numel(writeRequests)
        writeRequestsJ.add(writeRequests(n).Handle);
    end

    resultJ = obj.Handle.addRequestItemsEntry(key, writeRequestsJ);
    result = aws.dynamodbv2.model.BatchWriteItemRequest(resultJ);
end