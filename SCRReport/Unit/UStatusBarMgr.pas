unit UStatusBarMgr;

interface

uses Windows, Graphics, ComCtrls,
  UStatusBarMgrBase;

type
  TStatusBarMgr = class(TStatusBarMgrBase)
  private
    fSearchGlyph: TBitmap;
    fModifiedGlyph: TBitmap;

    const
      cSearchPanelIndex = 1;         // index of search info panel

    procedure DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure ShowSearchInfo;
    procedure HideSearchInfo;

  public
    constructor Create(const SB: TStatusBar);
    destructor Destroy; override;

    procedure Update;
  end;

implementation

{ TStatusBarMgr }

constructor TStatusBarMgr.Create(const SB: TStatusBar);
begin
  inherited Create(SB);
end;

destructor TStatusBarMgr.Destroy;
begin

  inherited;
end;

procedure TStatusBarMgr.DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
begin

end;

procedure TStatusBarMgr.HideSearchInfo;
begin

end;

procedure TStatusBarMgr.ShowSearchInfo;
begin

end;

procedure TStatusBarMgr.Update;
begin

end;

end.
