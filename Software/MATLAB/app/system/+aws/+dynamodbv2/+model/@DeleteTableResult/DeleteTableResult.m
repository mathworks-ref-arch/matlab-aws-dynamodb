classdef DeleteTableResult < aws.Object
    % DELETETABLERESULT Object to represent a deleteTable result

    % Copyright 2019 The MathWorks, Inc.

    methods
        function obj = DeleteTableResult(varargin)
            if nargin == 1
                if ~isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.model.DeleteTableResult')
                    logObj = Logger.getLogger();
                    write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.model.DeleteTableResult');
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
