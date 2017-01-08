function inputPanel(action)
    global write;
    matDim = 16;

    if nargin == 0
        action = 'start';
    end

    switch(action)
    case 'start',
        clf;
        figure(1);
        axis([0 matDim 0 matDim]);  % 設定圖軸範圍
        box on;                     % 將圖軸加上圖框
        set(gcf, 'WindowButtonDownFcn', 'inputPanel down');      % 設定滑鼠按鈕被按下時的反應指令為「tmouse down」
    case 'down',
        set(gcf, 'WindowButtonMotionFcn', 'inputPanel move');    % 設定滑鼠移動時的反應指令為「tmouse move」
        set(gcf, 'WindowButtonUpFcn', 'inputPanel up');          % 設定滑鼠按鈕被釋放時的反應指令為「tmouse up」
    case 'move',
        currPt = get(gca, 'CurrentPoint');
        x = fix(currPt(1,1));
        y = fix(currPt(1,2));
        write(x+1, y+1) = 1;
        plot(x, y, 'o', 'MarkerSize', 15, 'LineWidth', 15, 'EraseMode', 'normal');
        axis([0 matDim 0 matDim]);
        hold on;
    case 'up',
        set(gcf, 'WindowButtonMotionFcn', '');  % 清除滑鼠移動時的反應指令
        set(gcf, 'WindowButtonUpFcn', '');      % 清除滑鼠按鈕被釋放時的反應指令
    end