classdef TableDescription < aws.Object
    % TABLEDESCRIPTION Represents the properties of a table

    % Copyright 2019 The MathWorks, Inc.

    methods
        function obj = TableDescription(varargin)

            if nargin == 1
                if ~isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.model.TableDescription')
                    logObj = Logger.getLogger();
                    write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.model.TableDescription');
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
