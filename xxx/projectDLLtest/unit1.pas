unit Unit1;

{$mode objfpc}{$H+}

interface

uses
 Windows{ !!! }, Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
 StdCtrls;
{-------}
var result: Integer;
     LibHandle: Hmodule;
     Name1: Pointer;//function(): Integer; stdcall;
{-------}
type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);

begin
  LibHandle := LoadLibrary('CR95HF.dll'); // загружаем DLL
  if LibHandle <> 0 then
  begin
      ShowMessage('библиотека подгружена');
      Name1 := nil;
      Name1 := GetProcAddress(LibHandle, 'Get_Dll_rev'); // запоминаем адрес необходимой функции
       if Name1 <> nil then
       begin
         ShowMessage('функция найдена');
       end;
  end;
  FreeLibrary(LibHandle); // выгружаем DL
end;

end.

