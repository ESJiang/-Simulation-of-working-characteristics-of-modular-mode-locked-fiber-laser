function filter12(block)
setup(block);

function setup(block)
block.NumDialogPrms = 2;
block.NumInputPorts=1;
block.NumOutputPorts=1;
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;
block.InputPort(1).DirectFeedthrough=true;
block.SampleTimes=[-1 0];
block.SimStateCompliance='DefaultSimState';
block.SetAccelRunOnTLC(true);
block.RegBlockMethod('Outputs',@Output);

function Output(block) 
T = 80;            % Span in time domain unit: ps   定义了自变量范围（时域谱）
N = 2^10;          % Number of sample points       omega采样点的数目
omega = (2*pi/T.*(-N/2:1:(N/2-1)))';  % Circular frequency sequence unit：rad/ps  任意位置处的圆频率（频率的步长）     
Lambda0 = 1030e-9;%  unit: m  中心波长
g_Dx_f = block.DialogPrm(1).Data;
g_Loss_f = block.DialogPrm(2).Data;
Dw_f = 2*pi*2.998e-4*g_Dx_f/Lambda0.^2;
c=block.InputPort(1).Data.*filter1(omega,Dw_f,g_Loss_f);
block.OutputPort(1).Data=c(end);
