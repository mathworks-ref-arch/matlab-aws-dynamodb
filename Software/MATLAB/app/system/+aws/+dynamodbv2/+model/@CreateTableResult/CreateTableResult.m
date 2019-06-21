classdef CreateTableResult < aws.Object
    % CREATETABLERESULT Object to represent a createTable result

    % Copyright 2019 The MathWorks, Inc.

    methods
        function obj = CreateTableResult(varargin)
            if nargin == 1
                if ~isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.model.CreateTableResult')
                    logObj = Logger.getLogger();
                    write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.model.CreateTableResult');
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
