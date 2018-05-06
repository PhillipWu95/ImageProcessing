function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 13-May-2016 01:18:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%-----------读取原图像--------------
p1=imread('lena.png');
subplot(3,2,1);
imshow(p1);
title('原图像');
%----------对图像进行降质-----------
T=1;a=0.05;b=0.05;
[m,n]=size(p1);
H1=zeros(m,n);
for u=1:m
    for v=1:n
        H1(u,v)=T/(pi*(a*u+b*v))*sin(pi*(a*u+b*v))*exp(-i*pi*(a*u+b*v));%构建滤波器
    end
end
P1=fft2(p1);
Q1=P1.*H1;%进行滤波
q1=real(ifft2(Q1));
subplot(3,2,2);
imshow(uint8(q1));
title('降质后图像');
%------------r=1 反向滤波---------
P11=Q1./H1;
p11=real(ifft2(P11));
subplot(3,2,3);
imshow(uint8(p11));
title('r=1反向滤波法复原');
snr11=calpsnr(p1,p11);
set(handles.edit1,'String',snr11);
%----------r=0.8 反向滤波-----------
m08=round(m*0.8);
n08=round(n*0.8);
H08=ones(m,n);
H08(1:m08,1:n08)=H1(1:m08,1:n08);
P108=Q1./H08;
p108=real(ifft2(P108));
subplot(3,2,4);
imshow(uint8(p108));
title('r=0.8反向滤波法复原');
snr108=calpsnr(p1,p108);
set(handles.edit2,'String',snr108);
%----------r=0.5 反向滤波-----------
m05=round(m*0.5);
n05=round(n*0.5);
H05=ones(m,n);
H05(1:m05,1:n05)=H1(1:m05,1:n05);
P105=Q1./H05;
p105=real(ifft2(P105));
subplot(3,2,5);
imshow(uint8(p105));
title('r=0.5反向滤波法复原');
snr105=calpsnr(p1,p105);
set(handles.edit3,'String',snr105);
%----------r=0.3 反向滤波-----------
m03=round(m*0.3);
n03=round(n*0.3);
H03=ones(m,n);
H03(1:m03,1:n03)=H1(1:m03,1:n03);
P103=Q1./H03;
p103=real(ifft2(P103));
subplot(3,2,6);
imshow(uint8(p103));
title('r=0.3反向滤波法复原');
snr103=calpsnr(p1,p103);
set(handles.edit4,'String',snr103);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p2=imread('lena.png');
subplot(3,2,1);
imshow(p2);
title('原图像');
%----------对图像进行降质-----------
T=1;a=0.05;b=0.05;
[m,n]=size(p2);
H2=zeros(m,n);
for u=1:m
    for v=1:n
        H2(u,v)=T/(pi*(a*u+b*v))*sin(pi*(a*u+b*v))*exp(-i*pi*(a*u+b*v));%构建滤波器
    end
end
P2=fft2(p2);
Q2=P2.*H2;%进行滤波
q2=real(ifft2(Q2));
subplot(3,2,2);
imshow(uint8(q2));
title('降质后图像');


H2M=abs(H2).*abs(H2);
%-----------K=0的维纳滤波-----------
W20=1./H2.*(H2M./(H2M+0));
P20=Q2.*W20;
p20=real(ifft2(P20));
subplot(3,2,3);
imshow(uint8(p20));
title('K=0的维纳滤波');
snr20=calpsnr(p2,p20);
set(handles.edit1,'String',snr20);
%-----------K=0.00001的维纳滤波-----------
W21=1./H2.*(H2M./(H2M+0.00001));
P21=Q2.*W21;
p21=real(ifft2(P21));
subplot(3,2,4);
imshow(uint8(p21));
title('K=0.00001的维纳滤波');
snr21=calpsnr(p2,p21);
set(handles.edit2,'String',snr21);
%-----------K=0.0001的维纳滤波-----------
W22=1./H2.*(H2M./(H2M+0.0001));
P22=Q2.*W22;
p22=real(ifft2(P22));
subplot(3,2,5);
imshow(uint8(p22));
title('K=0.0001的维纳滤波');
snr22=psnr(double(p2),p22);
set(handles.edit3,'String',snr22);
%-----------K=0.001的维纳滤波-----------
W23=1./H2.*(H2M./(H2M+0.001));
P23=Q2.*W23;
p23=real(ifft2(P23));
subplot(3,2,6);
imshow(uint8(p23));
title('K=0.001的维纳滤波');
snr23=calpsnr(p2,p23);
set(handles.edit4,'String',snr23);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
