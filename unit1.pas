unit Unit1;

{$mode objfpc}{$H+}

interface

{$define blue}

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls
  , _lcl
  {$ifdef blue}
  , _wsblue
  {$else}
  , _wsgreen
  {$endif}
  ;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    ctrls: TList;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormPaint(Sender: TObject);
var
  i : integer;
  c : TLCLControl;
begin
  for i:=0 to ctrls.Count-1 do  begin
    c := TLCLControl(ctrls[i]);
    c.Render(Canvas);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  l : TLCLControl;
begin
  l:=TLCLControl.Create;
  l.Caption:='Control '+IntToStr(ctrls.Count+1);
  l.BoundsRect := Bounds(50,50, 80,20);
  ctrls.Add(l);
  invalidate;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  l : TLCLForm;
begin
  l:=TLCLForm.Create;
  l.Caption:='Form '+IntToStr(ctrls.Count+1);
  l.BoundsRect := Bounds(100,50, 80,80);
  TLCLForm(l).Minimize;
  ctrls.Add(l);
  invalidate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ctrls:=TList.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i : integer;
begin
  for i:=0 to ctrls.Count-1 do
    TObject(ctrls[i]).Free;
  ctrls.free;
end;

end.

