unit Unit1;

{$mode delphi}{$H+} { !!! }

interface

uses
Windows{ !!! }, Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
StdCtrls;
{---FOR CR95HFDLL----}
var LibHandle: Hmodule;
CR95HFDLL_USBconnect: function(): Integer; stdcall;
CR95HFDLL_USBhandlecheck: function(): Integer; stdcall;
CR95HFDll_GetDLLrev: function(strAnswer: PChar): Integer; stdcall;
CR95HFDLL_getMCUrev: function(strAnswer: PChar): Integer; stdcall;
CR95HFDll_Select: function(strRequest, strAnswer: PChar): Integer; stdcall;
CR95HFDll_SendReceive: function(strRequest, strAnswer: PChar): Integer; stdcall;
{-------}

type

{ TForm1 }

TForm1 = class(TForm)
Button1: TButton;
Button2: TButton;
Button3: TButton;
Button4: TButton;
Button5: TButton;
ToggleBox1: TToggleBox;
procedure Button1Click(Sender: TObject);
procedure Button2Click(Sender: TObject);
procedure Button3Click(Sender: TObject);
procedure Button4Click(Sender: TObject);
procedure Button5Click(Sender: TObject);
procedure FormCreate(Sender: TObject);
procedure ToggleBox1Click(Sender: TObject);
private

public

end;

var
Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
procedure TForm1.Button2Click(Sender: TObject);
{---GetDLLrev---}
var
  iresult: Integer;
  strAnswer: PChar;
  Buffer: array[0..49] of Char;
begin
LibHandle := LoadLibrary('CR95HF.dll');
if LibHandle <> 0 then
begin
CR95HFDll_GetDLLrev := nil;
@CR95HFDll_GetDLLrev := GetProcAddress(LibHandle, 'CR95HFDll_GetDLLrev'); // запоминаем адрес необходимой функции
if @CR95HFDll_GetDLLrev <> nil then
begin
strAnswer := Buffer;
iresult := CR95HFDll_GetDLLrev(strAnswer);
if iresult = 0 then
   ShowMessage(strAnswer)
else
   ShowMessage('CR95HF.DLL  не найдена');
end;
end;
FreeLibrary(LibHandle);
end;

procedure TForm1.Button3Click(Sender: TObject);
{---GetMCUrev---}
var
  iresult: Integer;
  strAnswer: PChar;
  Buffer: array[0..49] of Char;
begin
LibHandle := LoadLibrary('CR95HF.dll');
if LibHandle <> 0 then
begin
CR95HFDLL_getMCUrev := nil;
@CR95HFDLL_getMCUrev := GetProcAddress(LibHandle, 'CR95HFDLL_getMCUrev'); // запоминаем адрес необходимой функции
if @CR95HFDLL_getMCUrev <> nil then
begin
strAnswer := Buffer;
iresult := CR95HFDLL_getMCUrev(strAnswer);
if iresult = 0 then
   ShowMessage(strAnswer)
else
   ShowMessage('Плата не найдена');
end;
end;
FreeLibrary(LibHandle);
end;

procedure TForm1.ToggleBox1Click(Sender: TObject);
{---USBconnect---}
var iresult: Integer;
begin
LibHandle := LoadLibrary('CR95HF.dll');
if LibHandle <> 0 then
begin
CR95HFDLL_USBconnect := nil;
@CR95HFDLL_USBconnect := GetProcAddress(LibHandle, 'CR95HFDLL_USBconnect'); // запоминаем адрес необходимой функции
if @CR95HFDLL_USBconnect <> nil then
begin
iresult := CR95HFDLL_USBconnect();
if iresult = 0 then
   ShowMessage('Устройство подключено')
else
    ShowMessage('Устройство не подключено');
end;
end;
FreeLibrary(LibHandle);
end;
procedure TForm1.Button1Click(Sender: TObject);
{---USBhandlecheck---}
var iresult: Integer;
begin
LibHandle := LoadLibrary('CR95HF.dll'); // загружаем DLL
if LibHandle <> 0 then
begin
CR95HFDLL_USBhandlecheck := nil;
@CR95HFDLL_USBhandlecheck := GetProcAddress(LibHandle, 'CR95HFDLL_USBhandlecheck'); // запоминаем адрес необходимой функции
if @CR95HFDLL_USBhandlecheck <> nil then
begin
iresult := CR95HFDLL_USBhandlecheck();
if iresult = 0 then
   ShowMessage('Карта обнаружена')
else
    ShowMessage('Карта не обнаружена');
end;
end;
FreeLibrary(LibHandle);
end;



procedure TForm1.Button4Click(Sender: TObject);
var
  iresult: Integer;
  strAnswer: PChar;
  strRequest: PChar;
  Buffer1: array[0..49] of Char;
  Buffer2: array[0..49] of Char;
begin
{---Select_ISO15693---}{ *** КОСЯЧТ *** }
LibHandle := LoadLibrary('CR95HF.dll');
if LibHandle <> 0 then
begin
CR95HFDll_Select := nil;
@CR95HFDll_Select := GetProcAddress(LibHandle, 'CR95HFDll_Select'); // запоминаем адрес необходимой функции
if @CR95HFDll_Select <> nil then
begin
strAnswer := Buffer1;
strRequest := Buffer2;
StrCopy(strRequest,'010D');
iresult := CR95HFDll_Select(strRequest,strAnswer);
if iresult = 0 then
   ShowMessage(strAnswer)
else
    ShowMessage('протокол не выбран');
end;
end;
FreeLibrary(LibHandle);
end;

procedure TForm1.Button5Click(Sender: TObject);
{---Send_ISO15693_Inventory---}
var
  iresult: Integer;
  strAnswer: PChar;
  strRequest: PChar;
  Buffer1: array[0..49] of Char;
  Buffer2: array[0..49] of Char;
begin
CR95HFDll_SendReceive := nil;
@CR95HFDll_SendReceive := GetProcAddress(LibHandle, 'CR95HFDll_SendReceive'); // запоминаем адрес необходимой функции
if @CR95HFDll_SendReceive <> nil then
begin
strAnswer := Buffer1;
strRequest := Buffer2;
StrCopy(strRequest,'260100');
iresult := CR95HFDll_SendReceive(strRequest,strAnswer);
//if iresult = 0 then
   ShowMessage(strAnswer) ;
//else
//    ShowMessage('протокол не выбран');
end;
FreeLibrary(LibHandle);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;



end.
