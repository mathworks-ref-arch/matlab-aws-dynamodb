classdef TableCollection < aws.Object
    % TABLECOLLECTION Object to represent a collection of tables

    % Copyright 2019 The MathWorks, Inc.

    methods
        function obj = TableCollection(varargin)

            if nargin == 1
                if ~isa(varargin{1}, 'com.amazonaws.services.dynamodbv2.document.TableCollection')
                    logObj = Logger.getLogger();
                    write(logObj,'error','argument not of type com.amazonaws.services.dynamodbv2.document.TableCollection');
                end
                obj.Handle = varargin{1};
            else
                logObj = Logger.getLogger();
                write(logObj,'error','Invalid number of arguments');
            end
        end
    end

end
