classdef ScalarAttributeType < aws.Object
    % SCALARATTRIBUTETYPE Enumeration of attribute types
    % Possible values are B, N, or S. A toJava() method is provided to return
    % the Java equivalent.

    % Copyright 2019 The MathWorks, Inc.

    enumeration
        B
        N
        S
    end

    methods
        function typeJ = toJava(obj)
            switch obj
                case aws.dynamodbv2.model.ScalarAttributeType.B
                    typeJ = com.amazonaws.services.dynamodbv2.model.ScalarAttributeType.B;
                case aws.dynamodbv2.model.ScalarAttributeType.N
                    typeJ = com.amazonaws.services.dynamodbv2.model.ScalarAttributeType.N;
                case aws.dynamodbv2.model.ScalarAttributeType.S
                    typeJ = com.amazonaws.services.dynamodbv2.model.ScalarAttributeType.S;
                otherwise
                    logObj = Logger.getLogger();
                    write(logObj,'error','Invalid aws.dynamodbv2.model.ScalarAttributeType');
            end
        end
    end
end %class
