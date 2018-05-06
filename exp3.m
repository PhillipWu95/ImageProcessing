function varargout = exp3(varargin)
% EXP3 MATLAB code for exp3.fig
%      EXP3, by itself, creates a new EXP3 or raises the existing
%      singleton*.
%
%      H = EXP3 returns the handle to a new EXP3 or the handle to
%      the existing singleton*.
%
%      EXP3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXP3.M with the given input arguments.
%
%      EXP3('Property','Value',...) creates a new EXP3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before exp3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to exp3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help exp3

% Last Modified by GUIDE v2.5 20-May-2016 00:37:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @exp3_OpeningFcn, ...
                   'gui_OutputFcn',  @exp3_OutputFcn, ...
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


% --- Executes just before exp3 is made visible.
function exp3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to exp3 (see VARARGIN)

% Choose default command line output for exp3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes exp3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = exp3_OutputFcn(hObject, eventdata, handles) 
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
I0=imread('ship.bmp');
I0=rgb2gray(I0);
subplot(2,3,4);
imshow(I0);
title('原图像');
IM=medfilt2(I0);  % median filter
subplot(2,3,5);
imshow(IM);
title('中值滤波后图像');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Otsu             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T=Otsu(IM);        % visit Otsu.m
s=size(IM);
for m=1:s(1)
    for n=1:s(2)
        if IM(m,n)>=T
            IM(m,n)=255;
        else
            IM(m,n)=0;
        end
    end
end
subplot(2,3,6);
imshow(IM);
title('类间方差阈值算法');
imwrite(IM,'ship1.png','png');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            Erosion           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I = imread('ship.bmp');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              r=1             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
se1 = strel('disk',1);
I1 = imerode(I,se1);
subplot(2,3,4);
imshow(I1);
title('r=1的腐蚀运算');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              r=2             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
se2 = strel('disk',2);
I2 = imerode(I,se2);
subplot(2,3,5);
imshow(I2);
title('r=2的腐蚀运算');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              r=3             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
se3 = strel('disk',3);
I3 = imerode(I,se3);
subplot(2,3,6);
imshow(I3);
title('r=3的腐蚀运算');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Dialation          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I = imread('ship.bmp');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              r=1             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
se1 = strel('disk',1);
I1 = imdilate(I,se1);
subplot(2,3,4);
imshow(I1);
title('r=1的膨胀运算');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              r=2             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
se2 = strel('disk',2);
I2 = imdilate(I,se2);
subplot(2,3,5);
imshow(I2);
title('r=2的膨胀运算');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              r=3             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
se3 = strel('disk',3);
I3 = imdilate(I,se3);
subplot(2,3,6);
imshow(I3);
title('r=3的膨胀运算');

% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
