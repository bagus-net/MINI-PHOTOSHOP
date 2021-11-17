function varargout = PhotoShop(varargin)
% PHOTOSHOP MATLAB code for PhotoShop.fig
%      PHOTOSHOP, by itself, creates a new PHOTOSHOP or raises the existing
%      singleton*.
%
%      H = PHOTOSHOP returns the handle to a new PHOTOSHOP or the handle to
%      the existing singleton*.
%
%      PHOTOSHOP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PHOTOSHOP.M with the given input arguments.
%
%      PHOTOSHOP('Property','Value',...) creates a new PHOTOSHOP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PhotoShop_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PhotoShop_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PhotoShop

% Last Modified by GUIDE v2.5 15-Nov-2021 23:57:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PhotoShop_OpeningFcn, ...
                   'gui_OutputFcn',  @PhotoShop_OutputFcn, ...
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


% --- Executes just before PhotoShop is made visible.
function PhotoShop_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PhotoShop (see VARARGIN)

% Choose default command line output for PhotoShop
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PhotoShop wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PhotoShop_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in file.
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data1;
[filename,pathname] = uigetfile({'*.*'});
 
if isequal(filename,0)
    return
else
   data1 = imread(fullfile(pathname,filename));
   guidata(hObject,handles);
   axes(handles.axes1);
   imshow(data1);
   title('Citra Asli');
end


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pilihan = questdlg('Apakah anda ingin menutup program?', ...
 'Menutup Program', ...
 'Ya','Tidak','Tidak');
% Handle response
switch pilihan
    case 'Ya'
        close();
    case 'Tidak'
        return;
end

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName, PathName] = uiputfile('.jpg', 'Save As');
if PathName==0
return; 
end
img=getframe(handles.axes2);
hasil=frame2im(img);
Name = fullfile(PathName, FileName);
imwrite(hasil, Name, 'jpg');
guidata(hObject, handles);


% --- Executes on button press in gray.
function gray_Callback(hObject, eventdata, handles)
% hObject    handle to gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data1;
gray= rgb2gray(data1);
axes(handles.axes2);
imshow(gray);
title("Citra Gray")

% --- Executes on button press in Crop.
function Crop_Callback(hObject, eventdata, handles)
% hObject    handle to Crop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data1;
axes(handles.axes1)
imshow(data1)
title('Citra Asli');

h=imrect;
position=wait(h);
hasil1=imcrop(data1,position);
handles.hasil1=hasil1;
axes(handles.axes2)
imshow(hasil1)
title('Image Crop');

% --- Executes on button press in negatif.
function negatif_Callback(hObject, eventdata, handles)
% hObject    handle to negatif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data1;
img_negt=imcomplement(data1);
axes(handles.axes2);
imshow(img_negt);
title("Citra Negatif")


% --- Executes on slider movement.
function rotasi_Callback(hObject, eventdata, handles)
% hObject    handle to rotasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global data1;
angle=get(hObject,'value');
img=imrotate(data1,angle,'bicubic','crop');
axes(handles.axes2);
imshow(img);
title('Image Rotasi')

% --- Executes during object creation, after setting all properties.
function rotasi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rotasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function cerah_Callback(hObject, eventdata, handles)
% hObject    handle to cerah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global data1;
nilai=get(hObject,'value');
brig=data1;
hasil=brig+nilai;
axes(handles.axes2)
imshow(hasil)
title('Image Brightening')

% --- Executes during object creation, after setting all properties.
function cerah_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cerah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in vertikal.
function vertikal_Callback(hObject, eventdata, handles)
% hObject    handle to vertikal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data1;
vertical=flipud(data1);
axes(handles.axes2)
imshow(vertical)
title('Image Vertical')

% --- Executes on button press in horizontal.
function horizontal_Callback(hObject, eventdata, handles)
% hObject    handle to horizontal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data1;
horizontal=fliplr(data1);
axes(handles.axes2)
imshow(horizontal)
title('Image Horizontal')


% --- Executes on button press in kurang.
function kurang_Callback(hObject, eventdata, handles)
% hObject    handle to kurang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data1;
global data2;
c1 = data1;
c2 = data2;

[m,n]=size(c1);
citra1 = double(c1);
citra2 = double(c2);

for i=1:m
	for j=1:n
		hasil (i,j) = citra1(i,j) - citra2(i,j);
	end
end
hasil = uint8 (hasil);
axes(handles.axes2);
imshow(hasil);
title('Gambar Hasil Pengurangan');

% --- Executes on button press in jumlah.
function jumlah_Callback(hObject, eventdata, handles)
% hObject    handle to jumlah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data1;
global data2;
c1 = data1;
c2 = data2;

[m,n]=size(c1);
citra1 = double(c1);
citra2 = double(c2);

for i=1:m
	for j=1:n
		hasil (i,j) = citra1(i,j) + citra2(i,j);
	end
end
hasil = uint8 (hasil);
axes(handles.axes2);
imshow(hasil);
title('Gambar Hasil Penjumlahan');

% --- Executes on button press in translasi.
function translasi_Callback(hObject, eventdata, handles)
% hObject    handle to translasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Tx=20;
Ty=50;
global data1;
[brs kol] = size(data1);
for x = 1:brs;
    for y = 1:kol;
        b(x+Tx, y+Ty) = data1(x,y);
    end
end
hasil=b(1:brs,1:kol);
axes(handles.axes2);
imshow(hasil);
title('Image Translasi');

% --- Executes on button press in zoom_off.
function zoom_off_Callback(hObject, eventdata, handles)
% hObject    handle to zoom_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data1;
axes(handles.axes2)
imshow(data1)
title('Zoom Image')
zoom on
