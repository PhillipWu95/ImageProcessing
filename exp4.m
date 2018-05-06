function varargout = exp4(varargin)
% EXP4 MATLAB code for exp4.fig
%      EXP4, by itself, creates a new EXP4 or raises the existing
%      singleton*.
%
%      H = EXP4 returns the handle to a new EXP4 or the handle to
%      the existing singleton*.
%
%      EXP4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXP4.M with the given input arguments.
%
%      EXP4('Property','Value',...) creates a new EXP4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before exp4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to exp4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help exp4

% Last Modified by GUIDE v2.5 26-May-2016 21:55:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @exp4_OpeningFcn, ...
                   'gui_OutputFcn',  @exp4_OutputFcn, ...
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


% --- Executes just before exp4 is made visible.
function exp4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to exp4 (see VARARGIN)

% Choose default command line output for exp4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes exp4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = exp4_OutputFcn(hObject, eventdata, handles) 
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  operate on original image  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
iorg=rgb2gray(imread('houghorg.bmp'));
iorg=binarize(iorg);           %visit binarize.m
iorg_edge=edge(iorg,'log');
subplot(2,3,1);
set(gca,'Position',[0,0.55,0.40,0.40]);
imshow(iorg_edge);
title('origin');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  operate on image with gauss noise  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
igau=imread('houghgau.bmp');
igau=medfilt2(igau);
igau=binarize(igau);
igau_edge=edge(igau,'log');
subplot(2,3,2);
set(gca,'Position',[0.291,0.55,0.4,0.4]);
imshow(igau_edge);
title('gauss');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  operate on image with salt noise  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
isalt=imread('houghsalt.bmp');
isalt=medfilt2(isalt);
isalt=binarize(isalt);
isalt_edge=edge(isalt,'log');
subplot(2,3,3);
set(gca,'Position',[0.583,0.55,0.4,0.4]);
imshow(isalt_edge);
title('salt');


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  draw circle on images  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
[co,ro]=imfindcircles(iorg_edge,[80,110]);
[cg,rg]=imfindcircles(igau_edge,[80,110]);
[cs,rs]=imfindcircles(isalt_edge,[80,110]);
subplot(2,3,4);
set(gca,'Position',[0,0.105,0.4,0.4]);
imshow('houghorg.bmp');
viscircles(co,ro,'EdgeColor','r');

subplot(2,3,5);
set(gca,'Position',[0.291,0.105,0.4,0.4]);
imshow('houghgau.bmp');
viscircles(co,ro,'EdgeColor','g');

subplot(2,3,6);
set(gca,'Position',[0.583,0.105,0.4,0.4]);
imshow('houghsalt.bmp');
viscircles(co,ro,'EdgeColor','b');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  operate on original image  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
iorg=rgb2gray(imread('houghorg.bmp'));
iorg=binarize(iorg);           %visit binarize.m
iorg_edge=edge(iorg,'sobel');
subplot(2,3,1);
set(gca,'Position',[0,0.55,0.40,0.40]);
imshow(iorg_edge);
title('origin');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  operate on image with gauss noise  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
igau=imread('houghgau.bmp');
igau=medfilt2(igau);
igau=binarize(igau);
igau_edge=edge(igau,'sobel');
subplot(2,3,2);
set(gca,'Position',[0.291,0.55,0.4,0.4]);
imshow(igau_edge);
title('gauss');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  operate on image with salt noise  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
isalt=imread('houghsalt.bmp');
isalt=medfilt2(isalt);
isalt=binarize(isalt);
isalt_edge=edge(isalt,'sobel');
subplot(2,3,3);
set(gca,'Position',[0.583,0.55,0.4,0.4]);
imshow(isalt_edge);
title('salt');

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  draw circle on images  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
[co,ro]=imfindcircles(iorg_edge,[80,110]);
[cg,rg]=imfindcircles(igau_edge,[80,110]);
[cs,rs]=imfindcircles(isalt_edge,[80,110]);
subplot(2,3,4);
set(gca,'Position',[0,0.105,0.4,0.4]);
imshow('houghorg.bmp');
viscircles(co,ro,'EdgeColor','r');

subplot(2,3,5);
set(gca,'Position',[0.291,0.105,0.4,0.4]);
imshow('houghgau.bmp');
viscircles(co,ro,'EdgeColor','g');

subplot(2,3,6);
set(gca,'Position',[0.583,0.105,0.4,0.4]);
imshow('houghsalt.bmp');
viscircles(co,ro,'EdgeColor','b');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  operate on original image  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
iorg=rgb2gray(imread('houghorg.bmp'));
iorg=binarize(iorg);           %visit binarize.m
iorg_edge=edge(iorg,'roberts');
subplot(2,3,1);
set(gca,'Position',[0,0.55,0.40,0.40]);
imshow(iorg_edge);
title('origin');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  operate on image with gauss noise %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
igau=imread('houghgau.bmp');
igau=medfilt2(igau);
igau=binarize(igau);
igau_edge=edge(igau,'roberts');
subplot(2,3,2);
set(gca,'Position',[0.291,0.55,0.4,0.4]);
imshow(igau_edge);
title('gauss');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  operate on image with salt noise %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
isalt=imread('houghsalt.bmp');
isalt=medfilt2(isalt);
isalt=binarize(isalt);
isalt_edge=edge(isalt,'roberts');
subplot(2,3,3);
set(gca,'Position',[0.583,0.55,0.4,0.4]);
imshow(isalt_edge);
title('salt');

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  draw circle on images  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
[co,ro]=imfindcircles(iorg_edge,[80,110]);
[cg,rg]=imfindcircles(igau_edge,[80,110]);
[cs,rs]=imfindcircles(isalt_edge,[80,110]);
subplot(2,3,4);
set(gca,'Position',[0,0.105,0.4,0.4]);
imshow('houghorg.bmp');
viscircles(co,ro,'EdgeColor','r');
 
subplot(2,3,5);
set(gca,'Position',[0.291,0.105,0.4,0.4]);
imshow('houghgau.bmp');
viscircles(co,ro,'EdgeColor','g');
 
subplot(2,3,6);
set(gca,'Position',[0.583,0.105,0.4,0.4]);
imshow('houghsalt.bmp');
viscircles(co,ro,'EdgeColor','b');