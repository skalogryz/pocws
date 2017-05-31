unit _lcl;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, _lclws;

type

  { TLCLControl }

  TLCLControl = class(TObject)
  protected
    ws     : TWSCommon;
    function GetCaption: String;
    procedure SetCaption(const AValue: String);
    function GetBounds: TRect;
    procedure SetBounds(AValue: TRect);
    procedure CreateHandle; virtual;
  public
    constructor Create;
    procedure Render(ACanvas: TCanvas);
    property Caption: String read GetCaption write SetCaption;
    property BoundsRect: TRect read GetBounds write SetBounds;
  end;

  { TLCLForm }

  TLCLForm = class(TLCLControl)
  protected
    procedure CreateHandle; override;
  public
    procedure Minimize;
  end;

implementation

{ TLCLForm }

procedure TLCLForm.CreateHandle;
begin
  ws:=CreateForm;
end;

procedure TLCLForm.Minimize;
begin
  TWSForm(ws).Minimize;
end;

{ TLCLControl }

function TLCLControl.GetBounds: TRect;
begin
  TWSControl(ws).GetBounds(Result);
end;

procedure TLCLControl.SetBounds(AValue: TRect);
begin
  TWSControl(ws).SetBounds(AValue);
end;

procedure TLCLControl.CreateHandle;
begin
  ws:=CreateControl;
end;

constructor TLCLControl.Create;
begin
  inherited Create;
  CreateHandle;
end;

function TLCLControl.GetCaption: String;
begin
  Result:=TWSControl(ws).GetCaption;
end;

procedure TLCLControl.SetCaption(const AValue: String);
begin
  TWSControl(ws).SetCaption(AValue);
end;

procedure TLCLControl.Render(ACanvas: TCanvas);
begin
  TWSControl(ws).Render(ACanvas);
end;

end.

