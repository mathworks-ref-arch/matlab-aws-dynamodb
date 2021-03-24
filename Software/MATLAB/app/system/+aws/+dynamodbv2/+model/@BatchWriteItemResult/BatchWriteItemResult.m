classdef BatchWriteItemResult < aws.Object
    % BATCHWRITEITEMRESULT Represents the output of a BatchWriteItem operation

    % Copyright 2020 The MathWorks, Inc.

    methods
        function obj = BatchWriteItemResult(varargin)
            if nargin == 1
                if ~isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.model.BatchWriteItemResult')
                    logObj = Logger.getLogger();
                    write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.model.BatchWriteItemResult');
                else
                    obj.Handle = varargin{1};
                end
            else
                logObj = Logger.getLogger();
                write(logObj,'error','Invalid number of arguments');
            end
        end
    end

end
