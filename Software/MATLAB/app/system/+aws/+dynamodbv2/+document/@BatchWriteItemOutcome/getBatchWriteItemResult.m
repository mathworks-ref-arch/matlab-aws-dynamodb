function result = getBatchWriteItemResult(obj)
% GETBATCHWRITEITEMRESULT Returns a non-null low-level result
% A BatchWriteItemResult object is returned.
    
% Copyright 2020 The MathWorks, Inc.
       
resultJ = obj.Handle.getBatchWriteItemResult();
result = aws.dynamodbv2.model.BatchWriteItemResult(resultJ);

end

