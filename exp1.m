function varargout = exp1(varargin)
% EXP1 MATLAB code for exp1.fig
%      EXP1, by itself, creates a new EXP1 or raises the existing
%      singleton*.
%
%      H = EXP1 returns the handle to a new EXP1 or the handle to
%      the existing singleton*.
%
%      EXP1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXP1.M with the given input arguments.
%
%      EXP1('Property','Value',...) creates a new EXP1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before exp1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to exp1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help exp1

% Last Modified by GUIDE v2.5 15-Jun-2016 15:29:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @exp1_OpeningFcn, ...
                   'gui_OutputFcn',  @exp1_OutputFcn, ...
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


% --- Executes just before exp1 is made visible.
function exp1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to exp1 (see VARARGIN)

% Choose default command line output for exp1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes exp1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = exp1_OutputFcn(hObject, eventdata, handles) 
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
I1=imread('lena.png');   %����ԭͼ���ļ�
subplot(3,1,1);
imshow(I1);
title('ԭͼ��');
%----------------------------------
%-------------����Ҷ�任Ƶ��----------
fftI=fft2(I1);         % ��ά��ɢ����Ҷ�任
sfftI=fftshift(fftI);    % ֱ�������Ƶ�Ƶ������
RR=real(sfftI);      % ȡ����Ҷ�任��ʵ��
II=imag(sfftI);      % ȡ����Ҷ�任���鲿
A=sqrt(RR.^2+II.^2); % ����Ƶ�׷�ֵ
A=(A-min(min(A)))/(max(max(A))-min(min(A)))*255;    %��һ��
subplot(3,1,2);
imshow(A);        % ��ʾԭͼ���Ƶ��
title('����Ҷ�任��Ƶ��')
%----------------------------------
%--------------����Ҷ��任------------
fftI1=fft2(I1);                       %��ά��ɢ����Ҷ�任
sfftI1=fftshift(fftI1);              %ֱ�������Ƶ�Ƶ������
RR1=real(sfftI1);                    %ȡ����Ҷ�任��ʵ��
II1=imag(sfftI1);                    %ȡ����Ҷ�任���鲿
A1=sqrt(RR1.^2+II1.^2);             %����Ƶ�׷�ֵ
AA1=max(max(A1));
Size=size(I1);
width=Size(2);
height=Size(1);
for p=1:height
     for j=1:width
         if A1(p,j)<AA1*0.001
             RR1(p,j)=0;
             II1(p,j)=0;
         end
     end
end
sfftI2=RR1+i*II1;
fftI2=ifftshift(sfftI2);
image=ifft2(fftI2)/256;
subplot(3,1,3);
imshow(image);
title('�������޺󷴱任ͼ��');

imgn=imresize(I1,[floor(height/2) floor(width/2)]);
imgn=imresize(imgn,[height width]);
img=double(I1);
imgn=double(imgn);
B=8;                %����һ�������ö��ٶ�����λ
MAX=2^B-1;          %ͼ���ж��ٻҶȼ�
MES=sum(sum((img-imgn).^2))/(width*height);     %������
PSNR=20*log10(MAX/sqrt(MES));           %��ֵ�����
set(handles.edit1,'string',PSNR);

imgn=imresize(image,[floor(height/2) floor(width/2)]);
imgn=imresize(imgn,[height width]);
img=double(image);
imgn=double(imgn);

B=8;                %����һ�������ö��ٶ�����λ
MAX=2^B-1;          %ͼ���ж��ٻҶȼ�
MES=sum(sum((img-imgn).^2))/(height*width);     %������
PSNR=20*log10(MAX/sqrt(MES));           %��ֵ�����
set(handles.edit2,'string',PSNR);
%----------------------------------



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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I1=imread('lena.png');   %����ԭͼ���ļ�
subplot(3,1,1);
imshow(I1);
title('ԭͼ��');
%----------------------------------
%-------------���ұ任Ƶ��----------
DCT=dct2(I1); %���ұ仯
subplot(3,1,2);
imshow(log(abs(DCT)));
title('���ұ任��Ƶ��')
%----------------------------------
%-------------���ҷ��任----------
DCT(abs(DCT)<(max(max(DCT))*0.005))=0;
IDCT=idct2(DCT);
subplot(3,1,3);
imshow(IDCT,[0 255]);
title('�������޺󷴱任ͼ��');

Size=size(I1);
width=Size(2);
height=Size(1);

imgn=imresize(I1,[floor(height/2) floor(width/2)]);
imgn=imresize(imgn,[height width]);
img=double(I1);
imgn=double(imgn);
        
B=8;                %����һ�������ö��ٶ�����λ
MAX=2^B-1;          %ͼ���ж��ٻҶȼ�
MES=sum(sum((img-imgn).^2))/(height*width);     %������
PSNR=20*log10(MAX/sqrt(MES));           %��ֵ�����
set(handles.edit1,'string',PSNR);

imgn=imresize(IDCT,[floor(height/2) floor(width/2)]);
imgn=imresize(imgn,[height width]);
img=double(IDCT);
imgn=double(imgn);
        
B=8;                %����һ�������ö��ٶ�����λ
MAX=2^B-1;          %ͼ���ж��ٻҶȼ�
MES=sum(sum((img-imgn).^2))/(height*width);     %������
PSNR=20*log10(MAX/sqrt(MES));           %��ֵ�����
set(handles.edit2,'string',PSNR);
%----------------------------------


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I1=imread('lena.png');   %����ԭͼ���ļ�
subplot(3,1,1);
imshow(I1);
title('ԭͼ��');

Size=size(I1);
width=Size(2);
height=Size(1);
        
imgn=imresize(I1,[floor(height/2) floor(width/2)]);
imgn=imresize(imgn,[height width]);
img=double(I1);
imgn=double(imgn);

B=8;                %����һ�������ö��ٶ�����λ
MAX=2^B-1;          %ͼ���ж��ٻҶȼ�
MES=sum(sum((img-imgn).^2))/(height*width);     %������
PSNR=20*log10(MAX/sqrt(MES));           %��ֵ�����
set(handles.edit1,'string',PSNR);

%----------------------------------
%-------------������任Ƶ��----------
H=hadamard(512);
I1=double(I1)/255;
ha=H*I1*H;
ha=ha/256;
subplot(3,1,2);
imshow(ha);
title('������任��Ƶ��')
%----------------------------------
%-------------�����귴�任----------
ha(abs(ha)<(max(max(ha))*0.003))=0;
hh=ha*256;
hh=H^-1*hh*H^-1;
subplot(3,1,3);
imshow(hh);
title('�������޺󷴱任ͼ��');

imgn=imresize(hh,[floor(height/2) floor(width/2)]);
imgn=imresize(imgn,[height width]);
img=double(hh);
imgn=double(imgn);
 
B=8;                %����һ�������ö��ٶ�����λ
MAX=2^B-1;          %ͼ���ж��ٻҶȼ�
MES=sum(sum((img-imgn).^2))/(height*width);     %������
PSNR=20*log10(MAX/sqrt(MES));           %��ֵ�����
set(handles.edit2,'string',PSNR);
