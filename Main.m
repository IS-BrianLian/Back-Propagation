clc;
close all;
clear all;

global write; % 讀取 input panel 輸入

matDim    = 16; % 輸入的維度
middleNum = 26; % hidden layer neural 個數
outputNum = 10; % output layer neural 個數，同時也是 alphabet 個數

% training, get the weight
sumMSE = trainingNN(middleNum, outputNum);
weight = dlmread(['weight' int2str(middleNum) '.txt']);
weight1 = weight(1:middleNum, 1:matDim*matDim);
weight2 = weight(middleNum+1:middleNum+outputNum, 1:middleNum);

%cmd = input('Choice your test data input type:\n1. file\n2. witre panel\n:');
cmd = 1;
if cmd == 1 % 測試資料從檔案輸入
    data = dlmread('testData.txt'); 
    targetData = data(:, 1:10);
    inputData = data(:, 11:266);
    [row, col] = size(inputData);
    parfor i = 1:row
        result(i, :) = identifyNum(inputData(i, :)', weight1, weight2);
    end
    result = targetData & result;
    idenResult = find(result);
    fprintf('隱藏層個數 = %d, MSE = %E, 辨識率 = %3.2f%%\n', middleNum, sumMSE, length(idenResult)/row*100);
elseif cmd == 2 % 測試資料從手寫輸入
    while(true)
        write = zeros(matDim, matDim);
        inputPanel('start');
        cmd = input('What do you want?\n1. Start identify number\n2. Exit the program\n:');
        if cmd == 2
            fprintf('Bye Bye!\n');
            close all;
            break;
        else
            [value, idx] = max(identifyNum(write(:), weight1, weight2));
            if value == 1
                fprintf(2, 'Identification result is: %d\n', idx-1);
                
                cmd = input('Is identify correctly?\n1. correct\n2. error\n:');
                if cmd ~= 1
                    cmd = input('Input the correct number:');
                    temp = [zeros(1, cmd) 1 zeros(1, outputNum - cmd - 1) write(:)'];
                    dlmwrite('trainData.txt', temp, '-append');
                    fprintf('Add training data successfully\n');
                end
            else
                fprintf(2, 'Unrecognized...\n');
                
                cmd = input('Input the correct number:');
                temp = [zeros(1, cmd) 1 zeros(1, outputNum - cmd - 1) write(:)'];
                dlmwrite('trainData.txt', temp, '-append');
                fprintf('Add training data successfully\n');
            end
        end
    end
end

