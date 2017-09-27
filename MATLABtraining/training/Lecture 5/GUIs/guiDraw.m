function varargout = guiDraw(varargin)
% GUIDRAW MATLAB code for guiDraw.fig
%      GUIDRAW, by itself, creates a new GUIDRAW or raises the existing
%      singleton*.
%
%      H = GUIDRAW returns the handle to a new GUIDRAW or the handle to
%      the existing singleton*.
%
%      GUIDRAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDRAW.M with the given input arguments.
%
%      GUIDRAW('Property','Value',...) creates a new GUIDRAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiDraw_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiDraw_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiDraw

% Last Modified by GUIDE v2.5 07-Jun-2015 22:12:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiDraw_OpeningFcn, ...
                   'gui_OutputFcn',  @guiDraw_OutputFcn, ...
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


% --- Executes just before guiDraw is made visible.
function guiDraw_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiDraw (see VARARGIN)

%create data to plot
handles.peaks=peaks(35);
handles.membrane= membrane;
[x,y]=meshgrid(-8:0.5:8);
r=sqrt(x.^2 + y.^2) + eps;
sinc=sin(r)./r;
handles.sinc = sinc;
handles.current_data = handles.peaks;
surf(handles.current_data);

% Choose default command line output for guiDraw
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guiDraw wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guiDraw_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Contour.
function drawimage_Callback(hObject, eventdata, handles)
% hObject    handle to Contour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
get hObject;
imagescr(rand(200));
colormap(jet);



% --- Executes on button press in Mesh.
function changeColormap_Callback(hObject, eventdata, handles)
% hObject    handle to Mesh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
colormap(round(300*rand(256,3)));


% --- Executes on button press in Surf.
function Surf_Callback(hObject, eventdata, handles)
% hObject    handle to Surf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%display surf plot of current data
surf(handles.current_data);


% --- Executes on button press in Contour.
function Contour_Callback(hObject, eventdata, handles)
% hObject    handle to Contour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%display contour plot of current data
contour(handles.current_data);

% --- Executes on button press in Mesh.
function Mesh_Callback(hObject, eventdata, handles)
% hObject    handle to Mesh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%display mesh plot of current data
mesh(handles.current_data);


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

val=get(hObject, 'Value');
str=get(hObject, 'String');
switch str{val}
    case 'Peaks' %user select peaks
        handles.current_data=handles.peaks;
        disp('peaks');
    case 'Membrane'
        handles.current_data=handles.membrane;
        disp('membrane');
    case 'Sinc'
        handles.current_data=handles.sinc;
        disp('sinc');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
