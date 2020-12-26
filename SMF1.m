function SMF1(block)
setup(block);

function setup(block)
block.NumDialogPrms = 3;
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
g_L1 = block.DialogPrm(1).Data;
g_B2_sm1 = block.DialogPrm(2).Data;
g_Gm_sm1=block.DialogPrm(3).Data;
T = 80;            % Span in time domain unit: ps   定义了自变量范围（时域谱）
N = 2^10;          % Number of sample points       omega采样点的数目
omega = (2*pi/T.*(-N/2:1:(N/2-1)))'; 
w=fftshift(omega);
[~,awz]=ode45('fiber11',[0 g_L1],block.InputPort(1).Data,[],w,g_B2_sm1,g_Gm_sm1);
block.OutputPort(1).Data=awz(end);  