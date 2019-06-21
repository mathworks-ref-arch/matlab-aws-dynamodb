classdef UpdateTableResult < aws.Object
    % UPDATETABLERESULT Object to represent a updateTable result

    % Copyright 2019 The MathWorks, Inc.

    methods
        function obj = UpdateTableResult(varargin)
            if nargin == 1
                if ~isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.model.UpdateTableResult')
                    logObj = Logger.getLogger();
                    write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.model.UpdateTableResult');
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
