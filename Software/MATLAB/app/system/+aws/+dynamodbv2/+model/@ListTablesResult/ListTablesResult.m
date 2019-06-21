classdef ListTablesResult < aws.Object
    % LISTTABLESRESULT Object to represent result of a ListTables

    % Copyright 2019 The MathWorks, Inc.

    methods
        function obj = ListTablesResult(varargin)

            if nargin == 1
                if ~isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.model.ListTablesResult')
                    logObj = Logger.getLogger();
                    write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.model.ListTablesResult');
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
