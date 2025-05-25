unit FrmHiASDataModule;

interface

uses
  System.SysUtils, System.Classes, Vcl.ImgList, Vcl.Controls;

type
  TDataModule1 = class(TDataModule)
    ImageList16x16: TImageList;
    imagelist24x24: TImageList;
    ImageList32x32: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
