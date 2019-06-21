classdef UpdateItemResult < aws.Object
    % UPDATEITEMRESULT Object to represent a updateItem result

    % Copyright 2019 The MathWorks, Inc.

    methods
        function obj = UpdateItemResult(varargin)
            if nargin == 1
                if ~isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.model.UpdateItemResult')
                    logObj = Logger.getLogger();
                    write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.model.UpdateItemResult');
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
