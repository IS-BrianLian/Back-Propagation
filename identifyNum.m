function [result] = identifyNum(data, weight1, weight2)
    idenErr = 0.2; % Allowable error
    
    netMiddle = weight1 * data(: , 1);
    netMiddle = 1 ./ (1 + exp(-netMiddle));
    netOutput = weight2 * netMiddle;
    netOutput = 1 ./ (1 + exp(-netOutput));
    result = fix(netOutput + idenErr);
end

