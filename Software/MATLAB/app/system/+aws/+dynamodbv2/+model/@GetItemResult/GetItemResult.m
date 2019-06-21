classdef GetItemResult < aws.Object
    % GETITEMRESULT Object to represent result of a GetItem

    % Copyright 2019 The MathWorks, Inc.

    methods
        function obj = GetItemResult(varargin)

            if nargin == 1
                if ~isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.model.GetItemResult')
                    logObj = Logger.getLogger();
                    write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.model.GetItemResult');
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
