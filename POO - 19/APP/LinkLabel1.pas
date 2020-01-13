unit LinkLabel1;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Graphics, Messages, System.UITypes;

type
  TLinkLabel2 = class(TLabel)
  private
    FLinkVisitedColor: TColor;
    FLinkColor: TColor;
    FURL: string;
    FOldColor : TColor;
    FVisitado: Boolean;
    FLinkHoverColor: TColor;

    procedure SetLinkColor(const Value: TColor);
    procedure SetLinkVisitedColor(const Value: TColor);
    procedure SetURL(const Value: string);
    procedure SetLinkHoverColor(const Value: TColor);
    { Private declarations }
  protected
    { Protected declarations }
    procedure CMMouseEnter(var Msg : TMessage); message CM_MouseEnter;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MouseLeave;
  	procedure Click; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property URL : string read FURL write SetURL;
    property LinkColor : TColor read FLinkColor write SetLinkColor;
    property LinkVisitedColor : TColor read FLinkVisitedColor write SetLinkVisitedColor;
    property LinkHoverColor : TColor read FLinkHoverColor write SetLinkHoverColor;
  end;

procedure Register;

implementation

uses
	Winapi.ShellAPI, Forms, Winapi.Windows;

procedure Register;
begin
  RegisterComponents('Samples', [TLinkLabel2]);
end;

{ TLinkLabel }

procedure TLinkLabel2.Click;
begin
  inherited;
	if FURL <> EmptyStr then
  begin
  	ShellExecute(Application.Handle, nil, PChar(FUrl), nil, nil, SW_Shownormal);
  end;
  FVisitado := True;
end;

procedure TLinkLabel2.CMMouseEnter(var Msg: TMessage);
begin
	if URL <> EmptyStr then
  begin
    Font.Style := Font.Style + [fsUnderLine];
    Font.Color := LinkHoverColor;
  end;
end;

procedure TLinkLabel2.CMMouseLeave(var Msg: TMessage);
begin
	if URL <> EmptyStr then
  begin
    Font.Style := Font.Style - [fsUnderLine];
    if FVisitado then
      Font.Color := LinkVisitedColor
    else
      Font.Color := LinkColor;
  end;
end;

constructor TLinkLabel2.Create(AOwner: TComponent);
begin
  inherited;
  Cursor := crHandPoint;
	if FURL <> EmptyStr then
  begin
    FOldColor := Font.Color;
	  Font.Color := LinkColor;
  end;
end;

procedure TLinkLabel2.SetLinkColor(const Value: TColor);
begin
  FLinkColor := Value;
end;

procedure TLinkLabel2.SetLinkHoverColor(const Value: TColor);
begin
  FLinkHoverColor := Value;
end;

procedure TLinkLabel2.SetLinkVisitedColor(const Value: TColor);
begin
  FLinkVisitedColor := Value;
end;

procedure TLinkLabel2.SetURL(const Value: string);
begin
  FURL := Value;
end;

end.
