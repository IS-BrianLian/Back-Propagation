clc;
close all;
clear all;

global write;

matDim      = 16;
alphabetDim = 10;

while(true)
    num = input('輸入要訓練的字元，結束輸入-1:');
    if num ~= -1
        write = zeros(matDim, matDim);
        inputPanel('start');
        cmd = input('輸入完畢，請按Enter鍵: ');
        temp = [zeros(1, num) 1 zeros(1, alphabetDim - num - 1) write(:)'];
        dlmwrite('trainData.txt', temp, '-append');
    else
        clc;
        close all;
        clear all;
        break;
    end
end