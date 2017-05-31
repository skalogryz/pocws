unit _wsgreen;

interface

{$INTERFACES CORBA}
{$mode objfpc}{$H+}

uses
  Classes, Graphics, _lclws;

type

  { TGreenControl }

  TGreenControl = class(TObject, IWSControl)
  protected
    bnds : TRect;
    fCaption: string;
    procedure SetCaption(const ACaption: string);
    function GetCaption: string;
    procedure Render(ACanvas: TCanvas);
    procedure SetBounds(const r: TRect);
    procedure GetBounds(var r: TRect);
  end;

  { TGreenForm }

  TGreenForm = class(TGreenControl, IWSControl, IWSForm)
  public
    procedure Render(ACanvas: TCanvas); // doesn't require override, since it's interfaced method
    procedure Minimize;
  end;

implementation

{ TGreenForm }

procedure TGreenForm.Render(ACanvas: TCanvas);
var
  sz : integer;
begin
  sz:=ACanvas.Font.Size;
  ACanvas.Brush.Color:=clMoneyGreen;
  ACanvas.FillRect(bnds);

  ACanvas.Font.Size:=6;
  ACanvas.TextOut(bnds.Right-Acanvas.TextWidth(fCaption) ,bnds.Top, fCaption);

  ACanvas.Font.Size:=sz;
end;

procedure TGreenForm.Minimize;
begin
end;

{ TGreenControl }

procedure TGreenControl.SetCaption(const ACaption: string);
begin
  fCaption:=ACaption;
end;

function TGreenControl.GetCaption: string;
begin
  Result:=fCaption;
end;

procedure TGreenControl.Render(ACanvas: TCanvas);
begin
  ACanvas.Brush.Color:=clMoneyGreen;
  ACanvas.FillRect(bnds);

  ACanvas.TextOut(bnds.Left,bnds.Top, fCaption);
end;

procedure TGreenControl.SetBounds(const r: TRect);
begin
  bnds:=r;
end;

procedure TGreenControl.GetBounds(var r: TRect);
begin
  r:=bnds;
end;


procedure GreenAllocControl(out hnd: TObject; out intf: IWSControl);
begin
  hnd:=TGreenControl.Create;
  intf:=TGreenControl(hnd);
end;

procedure GreenAllocForm(out hnd: TObject; out intf: IWSForm);
begin
  hnd:=TGreenForm.Create;
  intf:=TGreenForm(hnd);
end;

initialization
  AllocControl:=@GreenAllocControl;
  AllocForm:=@GreenAllocForm;

end.
