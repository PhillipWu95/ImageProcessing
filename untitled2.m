function varargout = untitled2(varargin)
% UNTITLED2 MATLAB code for untitled2.fig
%      UNTITLED2, by itself, creates a new UNTITLED2 or raises the existing
%      singleton*.
%
%      H = UNTITLED2 returns the handle to a new UNTITLED2 or the handle to
%      the existing singleton*.
%
%      UNTITLED2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED2.M with the given input arguments.
%
%      UNTITLED2('Property','Value',...) creates a new UNTITLED2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled2

% Last Modified by GUIDE v2.5 15-Jun-2016 15:54:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled2_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled2_OutputFcn, ...
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


% --- Executes just before untitled2 is made visible.
function untitled2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled2 (see VARARGIN)

% Choose default command line output for untitled2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load('traindata.mat');
[Xx,~]=size(X);
cm=Y;
cm(1,2)=0;
cm(1,3)=0;
cm_s=size(cm);
one_n=0;
six_n=0;
eight_n=0;
one_d=0;
six_d=0;
eight_d=0;

for k=1:Xx
    img=uint8(zeros(28));
    for i=1:28                  %image reconstruction
        img(1:28,i)=X(k,1+28*(i-1):28+28*(i-1));
    end
    s=28*28-sum(sum(binarize(img)/255));%s for surface area
    [Iedge,th]=edge(img,'sobel');%th for threshold
    l=sum(sum(Iedge)); %l for perimeter
    e=l; %e for eigenvalue
    %e=l*th; %weighted
    cm(k,2)=e;
    cm(k,3)=th;
end


for k2=1:cm_s(1)
    if cm(k2,1)==1
        one_n=one_n+cm(k2,2);%*cm(k2,3);
        one_d=one_d+1;%cm(k2,3);
        
    elseif cm(k2,1)==6      
        six_n=six_n+cm(k2,2);%*cm(k2,3);
        six_d=six_d+1;%cm(k2,3);
        
    else
        eight_n=eight_n+cm(k2,2);%*cm(k2,3);
        eight_d=eight_d+1;%cm(k2,3);
    end
end
one_e=one_n/one_d;
six_e=six_n/six_d;
eight_e=eight_n/eight_d;

load('testdata.mat');
[Xx,~]=size(X);
cm1=Y;
%one_e =41.6642;
%six_e =68.0351;
%eight_e =74.4755;
ch=[one_e,six_e,eight_e]-5;
cp=[1,6,8];
crt=0;

for k=1:Xx
    img=uint8(zeros(28));
    for i=1:28                  %重构图像(一维无法确定欧拉数)
        img(1:28,i)=X(k,1+28*(i-1):28+28*(i-1));
    end
    s=28*28-sum(sum(binarize(img)/255));%s for surface area
    [Iedge,th]=edge(img);%th for threshold
    l=sum(sum(Iedge)); %l for perimeter
    e=l;
    ch1=abs(e-ch);
    [m,n]=find(ch1==min(ch1));
    if n==1
        w=1;
    elseif n==2
        w=6;
    else
        w=8;
    end;
    cm1(k,2)=w;
    if cp(1,n)==cm1(k,1)
        crt=crt+1;
    end
end

per=crt/3067;
sprintf('%2.2f%%',per*100);
m = size(X, 1);
rand_indices = randperm(m);
sel = X(rand_indices(1:100), :);
newmat=cm1(rand_indices,2);
newmat1=zeros(10);
for k=1:100
    for i=1:10
        newmat1(ceil(k/10),i)=newmat(floor(k/10)*10+i,1);
        i=i+1;
    end
    k=k+1;
end

set(handles.uitable1,'data',newmat1);
figure
displayData(sel);
set(handles.edit1,'string',per);


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)



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
