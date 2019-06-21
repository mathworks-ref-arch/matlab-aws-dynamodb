classdef ReturnValue < aws.Object
    % RETURNVALUE Enumeration of return values
    % Possible values are: ALL_NEW, ALL_OLD, NONE, UPDATED_NEW or UPDATED_OLD
    % A toJava()method is provided to return the Java equivalent enum.

    % Copyright 2019 The MathWorks, Inc.

    enumeration
        ALL_NEW
        ALL_OLD
        NONE
        UPDATED_NEW
        UPDATED_OLD
    end

    methods
        function typeJ = toJava(obj)
            switch obj
                case aws.dynamodbv2.model.ReturnValue.ALL_NEW
                    typeJ = com.amazonaws.services.dynamodbv2.model.ReturnValue.ALL_NEW;
                case aws.dynamodbv2.model.ReturnValue.ALL_OLD
                    typeJ = com.amazonaws.services.dynamodbv2.model.ReturnValue.ALL_OLD;
                case aws.dynamodbv2.model.ReturnValue.NONE
                    typeJ = com.amazonaws.services.dynamodbv2.model.ReturnValue.NONE;
                case aws.dynamodbv2.model.ReturnValue.UPDATED_NEW
                    typeJ = com.amazonaws.services.dynamodbv2.model.ReturnValue.UPDATED_NEW;
                case aws.dynamodbv2.model.ReturnValue.UPDATED_OLD
                    typeJ = com.amazonaws.services.dynamodbv2.model.ReturnValue.UPDATED_OLD;
                otherwise
                    logObj = Logger.getLogger();
                    write(logObj,'error','Invalid aws.dynamodbv2.model.ReturnValue');
            end
        end
    end

end %class
