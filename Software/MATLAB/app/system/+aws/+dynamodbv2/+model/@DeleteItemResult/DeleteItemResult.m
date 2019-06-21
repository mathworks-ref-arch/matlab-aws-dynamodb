classdef DeleteItemResult < aws.Object
    % DELETEITEMRESULT Object to represent a deleteItem result

    % Copyright 2019 The MathWorks, Inc.

    methods
        function obj = DeleteItemResult(varargin)
            if nargin == 1
                if ~isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.model.DeleteItemResult')
                    logObj = Logger.getLogger();
                    write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.model.DeleteItemResult');
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
