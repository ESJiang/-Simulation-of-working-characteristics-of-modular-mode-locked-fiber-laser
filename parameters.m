%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %%%% Programing parameters %%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Cycles = 100;      % Number of cycles 循环的圈数（也象征着时间延迟或光纤的传输距离）
T = 80;            % Span in time domain unit: ps   定义了自变量范围（时域谱）
N = 2^10;          % Number of sample points       omega采样点的数目
t_temp = linspace(-T/2,T/2,N+1)';     % Time vector   1025个点
t = t_temp(1:N);   % Time series      1024个点（步数）
Dt = T/N;          % Time domain sampling period    步长（单位脉宽） 
omega = (2*pi/T.*(-N/2:1:(N/2-1)))';  % Circular frequency sequence unit：rad/ps  任意位置处的圆频率（频率的步长）
w = fftshift(omega);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C_vacuum = 2.998e-4;%  unit: m/ps   真空速度
Lambda0 = 1030e-9;%  unit: m  中心波长
lambda = 2*pi*C_vacuum./(omega+2*pi*C_vacuum/Lambda0);% unit m 任意位置的波长
lmda=lambda*1e9-Lambda0*1e9;%任意位置的波长和中心波长的差值（可正可负与omega的正负值相关）
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Initial signal  输入脉冲
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Wide_seed = 5; % Seed pulse duration (full width half maximum) unit:ps 半高全宽
%E_seed = 1e-5; % Seed pulse energy unit:pJ   脉冲能量=半高宽*峰值功率 
%at_in = initinal(t,Wide_seed,2,E_seed);   %调用sech波和gaussian波方程
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  gain fiber  
B2_g = 1e-4;    % ps^2/m   单位长度的色散量
Gm_g = 0.0031;   % 1/(W*m)   单位长度的非线性量
L_g=1;           %增益光纤的长度
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% gain g = G0./(1+trapz(t,abs(at).^2)/Es_g) parameter %%%%%
G0 = 3.6;                % unit:1/m 小信号增益系数
w = fftshift(omega);   %将-N/2和+N/2交换位置，即改变图形形状，但不改变数值结果（突出最值）
Es_g = 80;             % pJ 有效饱和能量
Dx_g = 50e-9;          % m 增益带宽
Dw_g = 2*pi*2.998e-4*Dx_g/Lambda0^2;  % unit:rad/ps,THz  频域的增益带宽（值越小滤波越明显）
%%%%%%%%% Filter parameter %%%%%%%%%%%%%%%%%%%%
Dx_f=4.506e-9;     %滤波带宽
Dw_f = 2*pi*2.998e-4*Dx_f/Lambda0.^2; % unit:rad/ps,THz 频域的滤波带宽
Loss_f = 0.01;         % Loss             能量损耗
%%%%%%%%% single mode fiber %%%%%%%%%%%%%%%%%%% 
B2_sm1 = 1e-4;        % Beta2_s1, ps^2/m，即23e-3 单模光纤的色散量
Gm_sm1 = 3.1e-3;       % 1/(W*m)    单模光纤的非线性量
L1=0.5;%光纤长度/m
L2=0.5;%光纤长度/m
L3=1;%光纤长度/m
L4=0.5;%光纤长度/m
%%%%%%%%% saturation absorber parameter %%%%%%%%%%%%%%%
Md=0.448;           %调制深度       最大透过率-最低透过率 单位：% 脉冲注入到可饱和吸收体时反射率的最大变化量（吸收体可饱和吸收所消耗的光的总量，即SESAM被漂白的能力）
A_ns = 0.4;       % nonsaturation loss 非饱和损耗 100%透过率—调制深度（最大透过率）（脉冲通量远大于饱和吸收通量时，仍然存在的损耗）
Ps = 20;          % saturation power  饱和功率 调制深度对应的功率（即最大透过率对应的功率）
%%%%%%%%%%%%%% output coupler %%%%%%%%%%%%%%%%%%%%%%%%%%%
cc=0.8;  %输出百分比 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%