unit Unit1;

{$mode delphi}{$H+} { !!! }

interface

uses
Windows{ !!! }, Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
StdCtrls;
{-------}
var result: Integer;
LibHandle: Hmodule;
CR95HFDLL_USBhandlecheck: function(): Integer; stdcall;
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
begin

end;
procedure TForm1.ToggleBox1Click(Sender: TObject);
{---USBconnect---}
begin

end;
procedure TForm1.Button1Click(Sender: TObject);
{---USBhandlecheck---}
begin
LibHandle := LoadLibrary('CR95HF.dll'); // загружаем DLL
if LibHandle <> 0 then
begin//ShowMessage('библиотека подгружена');
CR95HFDLL_USBhandlecheck := nil;
@CR95HFDLL_USBhandlecheck := GetProcAddress(LibHandle, 'CR95HFDLL_USBhandlecheck'); // запоминаем адрес необходимой функции
if @CR95HFDLL_USBhandlecheck <> nil then
begin//ShowMessage('функция найдена');
ShowMessage(inttostr(CR95HFDLL_USBhandlecheck()));
end;
end;
FreeLibrary(LibHandle); // выгружаем DL
end;



procedure TForm1.Button4Click(Sender: TObject);
begin
{---Select_ISO15693---}
end;

procedure TForm1.Button5Click(Sender: TObject);
{---Send_ISO15693_Inventory---}
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;



end.
