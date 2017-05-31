unit _lclws;

{$mode objfpc}{$H+}
{$INTERFACES CORBA}

interface

uses
  Classes, SysUtils, Graphics;

type

  { IWSControl }

  IWSCommon = interface
  end;

  IWSControl = interface(IWSCommon)
    procedure SetCaption(const ACaption: string);
    function GetCaption: string;
    procedure Render(ACanvas: TCanvas);
    procedure SetBounds(const r: TRect);
    procedure GetBounds(var r: TRect);
  end;

  IWSForm = interface(IWSControl)
    procedure Minimize;
  end;

  { TWSCommon }

  TWSCommon = class(TObject)
  public
    fintf   : IWSCommon;
    fhandle : TObject;
    constructor Create(AHandle: TObject; AIntf: IWSCommon);
  end;

  { TWSControl }

  TWSControl = class(TWSCommon)
  protected
    fctrl  : IWSControl;
  public
    constructor Create(AHandle: TObject; AIntf: IWSControl);
    procedure SetCaption(const ACaption: string);
    function GetCaption: string;
    procedure GetBounds(var r: TRect);
    procedure SetBounds(const r: TRect);
    procedure Render(ACanvas: TCanvas); virtual;
  end;

  { TWSForm }

  TWSForm = class(TWSControl)
    fform   : IWSForm;
    constructor Create(AHandle: TObject; AIntf: IWSForm);
    procedure Render(ACanvas: TCanvas); override;
    procedure Minimize;
  end;

var
  AllocControl : procedure(out hnd: TObject; out intf: IWSControl) = nil;
  AllocForm    : procedure(out hnd: TObject; out intf: IWSForm) = nil;

function CreateControl: TWSControl;
function CreateForm: TWSForm;

implementation

function CreateControl: TWSControl;
var
  i : IWScontrol;
  h : TObject;
begin
  if Assigned(AllocControl) then AllocControl(h, i)
  else begin
    i:=nil;
    h:=nil;
  end;
  Result:=TWSControl.Create(h, i);
end;

function CreateForm: TWSForm;
var
  i : IWSForm;
  h : TObject;
begin
  if Assigned(AllocForm) then
    AllocForm(h, i)
  else begin
    i:=nil;
    h:=nil;
  end;
  Result:=TWSForm.Create(h, i);
end;

{ TWSCommon }

constructor TWSCommon.Create(AHandle: TObject; AIntf: IWSCommon);
begin
  inherited Create;
  fHandle:=AHandle;
  fintf:=AIntf;
end;

{ TWSForm }

constructor TWSForm.Create(AHandle: TObject; AIntf: IWSForm);
begin
  inherited Create(ahandle, aintf);
  fform:=aintf;
end;

procedure TWSForm.Render(ACanvas: TCanvas);
begin
  inherited Render(ACanvas);
  fform.Render(ACanvas);
end;

procedure TWSForm.Minimize;
begin
  fform.Minimize;
end;

{ TWSControl }

constructor TWSControl.Create(AHandle: TObject; AIntf: IWSControl);
begin
  inherited Create(AHandle, Aintf);
  fctrl:=AIntf;
end;

procedure TWSControl.SetCaption(const ACaption: string);
begin
  if Assigned(fctrl) then fctrl.SetCaption(ACaption)
end;

function TWSControl.GetCaption: string;
begin
  if Assigned(fctrl) then Result:=fCtrl.GetCaption
  else Result:='';
end;

procedure TWSControl.GetBounds(var r: TRect);
begin
  if Assigned(fctrl) then fctrl.GetBounds(r);
end;

procedure TWSControl.SetBounds(const r: TRect);
begin
  if Assigned(fctrl) then fctrl.SetBounds(r);
end;

procedure TWSControl.Render(ACanvas: TCanvas);
begin
  if Assigned(fctrl) then fctrl.Render(ACanvas);
end;

end.

