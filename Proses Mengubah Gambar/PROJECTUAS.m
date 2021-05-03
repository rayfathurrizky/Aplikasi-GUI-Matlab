function varargout = PROJECTUAS(varargin)
% PROJECTUAS MATLAB code for PROJECTUAS.fig
%      PROJECTUAS, by itself, creates a new PROJECTUAS or raises the existing
%      singleton*.
%
%      H = PROJECTUAS returns the handle to a new PROJECTUAS or the handle to
%      the existing singleton*.
%
%      PROJECTUAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECTUAS.M with the given input arguments.
%
%      PROJECTUAS('Property','Value',...) creates a new PROJECTUAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PROJECTUAS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PROJECTUAS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PROJECTUAS

% Last Modified by GUIDE v2.5 03-May-2021 22:05:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PROJECTUAS_OpeningFcn, ...
                   'gui_OutputFcn',  @PROJECTUAS_OutputFcn, ...
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


% --- Executes just before PROJECTUAS is made visible.
function PROJECTUAS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PROJECTUAS (see VARARGIN)

% Choose default command line output for PROJECTUAS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PROJECTUAS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PROJECTUAS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnopen.
function btnopen_Callback(hObject, eventdata, handles)

appcitra = guidata(gcbo);
[namafile, formatfile]=uigetfile({'*.jpg';'*.png';'*.bmp'},'tampil gambar');

image=imread(namafile);
guidata(hObject, handles);
axes(handles.citra_asli);
imshow (image), title('Citra Asli');

set(appcitra.figure1, 'userdata', image);
set(appcitra.citra_asli, 'userdata', image);

% --- Executes on button press in btnproses.
function btnproses_Callback(hObject, eventdata, handles)
appcitra=guidata(gcbo);
I = get(appcitra.citra_asli, 'userdata');
if isequal(I,[])
    msgbox('Masukkan Gambar !','Peringatan','Warm');
else
    %TrueColor%
    negative = 255-1 -I;
    set(appcitra.figure1, 'CurrentAxes',appcitra.axes2_hasil);
    set(imshow(negative));
    imshow(negative),title('Citra True Color');
    
    %Histogram Negative%
    axes(handles.axes2_histo)
    x=1:256;
    plot(x,imhist(negative(:,:,1)), 'r-');
    hold on;
    plot(x, imhist(negative(:,:,2)), 'g-');
    plot(x, imhist(negative(:,:,3)), 'b-');
    title('Histrogram Negative')
    
    %Citra Biner%
    binary=im2bw(I);
    set(appcitra.figure1, 'CurrentAxes', appcitra.axes1_hasil);
    set(imshow(binary));
    imshow(binary), title('Citra Binary');
    
    %Histo Biner%
    axes(handles.axes1_histo);
    imhist(binary),title('Histogram Biner');
    
    %Citra Grayscale%
    grayscale=rgb2gray(I);
    set(appcitra.figure1, 'CurrentAxes', appcitra.axes3_hasil);
    set(imshow(grayscale));
    imshow(grayscale), title('Citra Grayscale');
    
    %Histo Grayscale%
    axes(handles.axes3_histo);
    imhist(grayscale),title('Histogram Grayscale');
    
    set(appcitra.axes2_hasil, 'userdata', negative);
    set(appcitra.axes1_hasil, 'userdata', binary);
    set(appcitra.axes3_hasil, 'userdata', grayscale);
    
end
    

% --- Executes on button press in btnexit.
function btnexit_Callback(hObject, eventdata, handles)
button = questdlg('Anda Akan Menutup Aplikasi ?','Tutup','Ya','Tidak','cancel');
switch button
    case 'Ya', clc;
        close;
    case 'Tidak', quit cancel;
end


% --- Executes on button press in btnsimpanbin.
function btnsimpanbin_Callback(hObject, eventdata, handles)
[namafile, direktori]=uiputfile({'*.jpg';'*.png'}, 'Save Image As');
sG = getimage(handles.axes1_hasil);
save = [direktori namafile];
imwrite(sG, save, 'jpg');
msgbox('foto berhasil disimpan ! ','sukses');

% --- Executes on button press in btnsimpangray.
function btnsimpangray_Callback(hObject, eventdata, handles)

[namafile, direktori]=uiputfile({'*.jpg';'*.png'}, 'Save Image As');
gB = getimage(handles.axes3_hasil);
save = [direktori namafile];
imwrite(gB, save, 'jpg');
msgbox('foto berhasil disimpan ! ','sukses');


% --- Executes on button press in btnsimpantrue.
function btnsimpantrue_Callback(hObject, eventdata, handles)

[namafile, direktori]=uiputfile({'*.jpg';'*.png'}, 'Save Image As');
aN = getimage(handles.axes2_hasil);
save = [direktori namafile];
imwrite(aN, save, 'jpg');
msgbox('foto berhasil disimpan ! ','sukses');
