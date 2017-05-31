unit _wsblue;

interface

{$mode objfpc}{$H+}
{$INTERFACES CORBA}

uses
  Classes, Graphics, _lclws;

type

  { TBlueControl }

  TBlueControl = class(TObject, IWSControl)
  public
    fcaption: string;
    fbnd: TRect;
    procedure SetCaption(const ACaption: string);
    function GetCaption: string;
    procedure Render(ACanvas: TCanvas);
    procedure SetBounds(const r: TRect);
    procedure GetBounds(var r: TRect);
  end;

  { TBlueForm }

  TBlueForm = class(TObject, IWSControl, IWSForm)
    fcaption: string;
    fbnd: TRect;
    procedure SetCaption(const ACaption: string);
    function GetCaption: string;
    procedure Render(ACanvas: TCanvas);
    procedure SetBounds(const r: TRect);
    procedure GetBounds(var r: TRect);

    procedure Minimize;
  end;

implementation

procedure BlueAllocControl(out hnd: TObject; out intf: IWSControl);
begin
  hnd:=TBlueControl.Create;
  intf:=TBlueControl(hnd);
end;

procedure BlueAllocForm(out hnd: TObject; out intf: IWSForm);
begin
  hnd:=TBlueForm.Create;
  intf:=TBlueForm(hnd);
end;

{ TBlueForm }

procedure TBlueForm.SetCaption(const ACaption: string);
begin
  fcaption:=Acaption;
end;

function TBlueForm.GetCaption: string;
begin
  Result:=fCaption;
end;

procedure TBlueForm.Render(ACanvas: TCanvas);
begin
  ACanvas.Brush.Color:=clSkyBlue;
  ACanvas.FillRect(fbnd);

  ACanvas.TextOut(fbnd.Left+
    ((fbnd.Right-fbnd.Left) -ACanvas.TextWidth(fCaption) ) div 2
    ,fbnd.Top, fCaption);
end;

procedure TBlueForm.SetBounds(const r: TRect);
begin
  fbnd:=r;
end;

procedure TBlueForm.GetBounds(var r: TRect);
begin
  r:=fbnd;
end;

procedure TBlueForm.Minimize;
begin

end;

{ TBlueControl }

procedure TBlueControl.SetCaption(const ACaption: string);
begin
  fcaption:=Acaption;
end;

function TBlueControl.GetCaption: string;
begin
  Result:=fcaption;
end;

procedure TBlueControl.Render(ACanvas: TCanvas);
begin
  ACanvas.Brush.Color:=clSkyBlue;
  ACanvas.FillRect(fbnd);

  ACanvas.TextOut(fbnd.Left,fbnd.Top, fCaption);
end;

procedure TBlueControl.SetBounds(const r: TRect);
begin
  fbnd:=r;
end;

procedure TBlueControl.GetBounds(var r: TRect);
begin
  r:=fbnd;
end;

initialization
  AllocControl:=@BlueAllocControl;
  AllocForm:=@BlueAllocForm;

end.
