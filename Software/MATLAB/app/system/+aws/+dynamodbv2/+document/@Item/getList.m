function result = getList(obj, attrName)
% GETLIST Returns specified attribute in the item as a cell array 
% An empty cell array is returned if the attribute either doesn't exist or the
% attribute value is null.
% The cell array may contain values of different types
    
% Copyright 2020 The MathWorks, Inc.
    
if ~ischar(attrName)
    % Create logger reference
    logObj = Logger.getLogger();
    write(logObj,'error','Expected attrName of type character vector');
end
    
resultJ = obj.Handle.getList(attrName);
    
% A list need not return elements that are all the same type hence a fast
% approach like result = double(resultJ.toArray) cannot be used based on
% checking the type of element 0 e.g. elementType = resultJ.get(0).getClass()
% instead return a cell array 

if resultJ.size == 0
    result = {};
else
    result = cell(1, resultJ.size);
    for n = 1:resultJ.size
        % Automatic datatype conversion should handle the types used by
        % dynamoDB in some cases
        % BigDecimal is likely to be returned cast this to a double, there
        % is potential loss of precision
        if isa(resultJ.get(n-1), 'java.math.BigDecimal')
            result{n} = double(resultJ.get(n-1));
        elseif ischar(resultJ.get(n-1)) || isnumeric(resultJ.get(n-1)) || isStringScalar(resultJ.get(n-1))
            % for conventional types assume automatic conversion
            result{n} = resultJ.get(n-1);
        else
            % May need some more exception handling
            logObj = Logger.getLogger();
            write(logObj,'error',['Returned datatype not currently supported: ', class(resultJ.get(n-1))]);
        end
    end
end

end
    