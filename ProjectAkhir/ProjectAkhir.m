function varargout = ProjectAkhir(varargin)
% PROJECTAKHIR MATLAB code for ProjectAkhir.fig
%      PROJECTAKHIR, by itself, creates a new PROJECTAKHIR or raises the existing
%      singleton*.
%
%      H = PROJECTAKHIR returns the handle to a new PROJECTAKHIR or the handle to
%      the existing singleton*.
%
%      PROJECTAKHIR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECTAKHIR.M with the given input arguments.
%
%      PROJECTAKHIR('Property','Value',...) creates a new PROJECTAKHIR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ProjectAkhir_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ProjectAkhir_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ProjectAkhir

% Last Modified by GUIDE v2.5 19-May-2022 21:29:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProjectAkhir_OpeningFcn, ...
                   'gui_OutputFcn',  @ProjectAkhir_OutputFcn, ...
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


% --- Executes just before ProjectAkhir is made visible.
function ProjectAkhir_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ProjectAkhir (see VARARGIN)

% Choose default command line output for ProjectAkhir
handles.output = hObject;

set(handles.tablekeputusan,'Data',''); %ngeset tabel keputusan dgn nilai kosong (yg ada dalam tanda kutip)
set(handles.tabelrangking,'Data','');
set(handles.tabelnormalisasi,'Data','');

global data; %global utk mendeklarasikan data dll
global indonesia;
global inggris;
global matematika;
global fisika;
global kimia;
global biologi;
global sma;

data = ' '; %mengisi variabel dgn nilai yg ada didalam kutip
indonesia  = ' ';
matematika = ' ';
fisika = ' ';
kimia = ' ';
biologi= ' '; 
inggris = ' ';
sma = ' ';

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ProjectAkhir wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ProjectAkhir_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
%menampilkan latar belakang atau bacground
latar = axes('unit', 'normalized', 'position', [0 0 1 1]);
bg = imread('sekolah.jpg'); imagesc(bg); 
set(latar, 'handlevisibility','off','visible','off')

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data;
global sma;

data = ' ';  %mengisi variabel dgn nilai yg ada didalam kutip
sma = ' ';
set(handles.tablekeputusan,'Data',''); %mengeluarkan data var 'Data' pada tabel keputusan dgn nilai kosong


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data;
global sma;

try %Execute statements and catch resulting errors
%[menampilkan data]
opts = detectImportOptions('nilai.csv');
opts.SelectedVariableNames = [2,3,4,5,6,7,8]; %mengambil seluruh data yang ada pada kolom 2,3,4,5,6,7,8
dataKeputusan = readtable('nilai.csv', opts); %membaca data yang ada pada kolom 2-8 dr file nilai,csv
dataKeputusan = table2cell(dataKeputusan); 

%convert table2array
%mengambil seluruh data yang ada pada kolom 3,4,5,6,7,8
opts1 = detectImportOptions('nilai.csv');
opts1.SelectedVariableNames = [3,4,5,6,7,8];
data = readtable('nilai.csv', opts1);
data = table2array(data); %sytax utk menconvert tabel ke baris array

opts2 = detectImportOptions('nilai.csv');
opts2 = setvartype(opts2,'SMA','char'); 
opts2.SelectedVariableNames = 'SMA'; %mengambil kolom SMA
sma = readtable('nilai.csv', opts2);  
sma = table2array(sma); 

set(handles.tablekeputusan,'Data',dataKeputusan); %mengeluarkan data var'Data' dan memasukkan data
%'dataKeputusan' pada tabelKeputusan
catch
    errordlg('Pastikan terdapat file nilai.csv', 'File tidak ditemukan');
end

% --- Executes on button press in rangking.
function rangking_Callback(hObject, eventdata, handles)
% hObject    handle to rangking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global data;
global sma;
global indonesia;
global inggris;
global matematika;
global fisika;
global kimia;
global biologi;


if(data == ' ')
    errordlg('Pastikan file sudah di load', 'Data tidak ditemukan');
elseif(indonesia == ' ' || inggris == ' ' || matematika == ' ' || fisika == ' ' || kimia == ' '|| biologi == ' ')
    errordlg('Pastikan pembobotan nilai sudah diisi', 'Bobot tidak ditemukan');
else
    k=[1,1,1,1,1,1]; %kriteria, yaitu 1=atribut benefit, dan  0= atribut cost
    w=[indonesia, inggris, matematika, fisika, kimia , biologi];% bobot untuk masing-masing kriteria

    %tahapan 1. normalisasi matriks
    %matriks m x n dengan ukuran sebanyak variabel data (input)
    [m,n]=size (data); 
    R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
    V = [m n];
    for j=1:n %untuk menormalisasi dr data data tadi berdasarkan kriteria atau atribut keuntungan
        if k(j)==1 %statement untuk kriteria dengan atribut keuntungan
            R(:,j)=data(:,j)./max(data(:,j));
        else
            R(:,j)=min(data(:,j))./data(:,j);
        end
    end

    %tahapan kedua, proses perangkingan
    for i=1:m
        V(i)= sum(w.*R(i,:)); %untuk menghitung nilai yg akan dilakukan proses perangkingan
    end

    rerata = sort(V, 'descend');%mengurutkan data berdasarkan nilai terbesar
    temp = strings(1,m);
    for i=1:m 
      for j=1:m
        if(rerata(i) == V(j)) % jika nilai i yg ada pada var rata2 = nilai j yg ada pada var V
            temp(i) = sma(j); %menampilkan nama sma pada kolom1
            break
        end
      end
    end

    hasil = strings(m,2);
    normalisasi = strings(m,5);
    for i=1:m
        normalisasi(i,1) = sma(i);
        for j=1:n
            normalisasi(i,(j+1)) = R(i,j);
        end
        hasil(i,1) = temp(i); %masukin ke tabel rank (nama sma)
        hasil(i,2) = rerata(i); %hasil rerata
    end
    hasil = cellstr(hasil);
    normalisasi = cellstr(normalisasi);
    
    hasilakhir = "Perangkingan SMA Negeri di Jawa Timur terbaik adalah " + temp(1) + " berdasarkan perangkingan nilai UNBK.";
    
    set(handles.tabelnormalisasi,'Data', normalisasi);
    set(handles.tabelrangking,'Data', hasil);
    set(handles.hasilakhir,'String',hasilakhir);
    
    msgbox(hasilakhir,'Berhasil','help');
end


function hasilakhir_Callback(hObject, eventdata, handles)
% hObject    handle to hasilakhir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hasilakhir as text
%        str2double(get(hObject,'String')) returns contents of hasilakhir as a double


% --- Executes during object creation, after setting all properties.
function hasilakhir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hasilakhir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function indonesia_Callback(hObject, eventdata, handles)
% hObject    handle to indonesia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of indonesia as text
%        str2double(get(hObject,'String')) returns contents of indonesia as a double


% --- Executes during object creation, after setting all properties.
function indonesia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to indonesia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inggris_Callback(hObject, eventdata, handles)
% hObject    handle to inggris (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inggris as text
%        str2double(get(hObject,'String')) returns contents of inggris as a double


% --- Executes during object creation, after setting all properties.
function inggris_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inggris (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function matematika_Callback(hObject, eventdata, handles)
% hObject    handle to matematika (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of matematika as text
%        str2double(get(hObject,'String')) returns contents of matematika as a double


% --- Executes during object creation, after setting all properties.
function matematika_CreateFcn(hObject, eventdata, handles)
% hObject    handle to matematika (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fisika_Callback(hObject, eventdata, handles)
% hObject    handle to fisika (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fisika as text
%        str2double(get(hObject,'String')) returns contents of fisika as a double


% --- Executes during object creation, after setting all properties.
function fisika_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fisika (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kimia_Callback(hObject, eventdata, handles)
% hObject    handle to kimia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kimia as text
%        str2double(get(hObject,'String')) returns contents of kimia as a double


% --- Executes during object creation, after setting all properties.
function kimia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kimia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function biologi_Callback(hObject, eventdata, handles)
% hObject    handle to biologi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of biologi as text
%        str2double(get(hObject,'String')) returns contents of biologi as a double


% --- Executes during object creation, after setting all properties.
function biologi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to biologi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in simpan.
function simpan_Callback(hObject, eventdata, handles)
% hObject    handle to simpan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global indonesia;
global inggris;
global matematika;
global fisika;
global kimia;
global biologi;

inputindonesia = get(handles.indonesia,'String'); %var inputindo yg mana var ini mengambil data indonesia dr yg diinputkan
inputinggris = get(handles.inggris,'String');
inputmatematika = get(handles.matematika,'String');
inputfisika = get(handles.fisika,'String');
inputkimia = get(handles.kimia,'String');
inputbiologi = get(handles.biologi,'String');

if(isempty(inputindonesia) || isempty(inputinggris) || isempty(inputmatematika) || isempty(inputfisika) || isempty(inputkimia) || isempty(inputbiologi))
    msgbox('Lengkapi Seluruh Pembobotan!','Gagal','error');
else
    indonesia = str2double(inputindonesia); %sytax utk mengubah string ke double agar data bisa dihitung
    inggris = str2double(inputinggris);
    matematika = str2double(inputmatematika);
    fisika = str2double(inputfisika);
    kimia = str2double(inputkimia);
    biologi = str2double(inputbiologi);
    msgbox('Pembobotan Berhasil tersimpan!','Berhasil','help');
end


% --- Executes when selected cell(s) is changed in tablekeputusan.
function tablekeputusan_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tablekeputusan (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in tablekeputusan.
function tablekeputusan_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to tablekeputusan (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in tabelnormalisasi.
function tabelnormalisasi_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to tabelnormalisasi (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in tabelrangking.
function tabelrangking_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to tabelrangking (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
