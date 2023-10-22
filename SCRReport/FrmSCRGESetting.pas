unit FrmSCRGESetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  JvExExtCtrls, JvImage, AdvGraphicCheckLabel, AdvPageControl, Vcl.ComCtrls,
  AdvOfficePager, iComponent, iVCLComponent, iCustomComponent, iEditCustom,
  iAnalogOutput, Vcl.Menus, DragDrop, DropTarget, DragDropText,
  UDragDropFormat_SCRParam, JvExControls, JvButton, JvTransparentButton;

type
  TSCRGESettingF = class(TForm)
    JvImage1: TJvImage;
    AdvPageControl1: TAdvPageControl;
    AdvTabSheet1: TAdvTabSheet;
    AdvTabSheet2: TAdvTabSheet;
    AdvTabSheet3: TAdvTabSheet;
    AdvTabSheet4: TAdvTabSheet;
    AdvTabSheet5: TAdvTabSheet;
    AdvTabSheet6: TAdvTabSheet;
    AdvOfficePager1: TAdvOfficePager;
    AdvOfficePager11: TAdvOfficePage;
    JvImage8: TJvImage;
    AdvOfficePager2: TAdvOfficePager;
    AdvOfficePage1: TAdvOfficePage;
    JvImage3: TJvImage;
    AdvOfficePager3: TAdvOfficePager;
    AdvOfficePage2: TAdvOfficePage;
    JvImage4: TJvImage;
    AdvOfficePager4: TAdvOfficePager;
    AdvOfficePage3: TAdvOfficePage;
    JvImage5: TJvImage;
    AdvOfficePager5: TAdvOfficePager;
    AdvOfficePage4: TAdvOfficePage;
    JvImage6: TJvImage;
    AdvOfficePager6: TAdvOfficePager;
    AdvOfficePage5: TAdvOfficePage;
    JvImage7: TJvImage;
    iAnalogOutput1: TiAnalogOutput;
    iAnalogOutput2: TiAnalogOutput;
    iAnalogOutput3: TiAnalogOutput;
    iAnalogOutput4: TiAnalogOutput;
    iAnalogOutput5: TiAnalogOutput;
    iAnalogOutput6: TiAnalogOutput;
    iAnalogOutput7: TiAnalogOutput;
    iAnalogOutput8: TiAnalogOutput;
    iAnalogOutput9: TiAnalogOutput;
    iAnalogOutput10: TiAnalogOutput;
    iAnalogOutput11: TiAnalogOutput;
    iAnalogOutput12: TiAnalogOutput;
    iAnalogOutput13: TiAnalogOutput;
    iAnalogOutput14: TiAnalogOutput;
    iAnalogOutput15: TiAnalogOutput;
    iAnalogOutput16: TiAnalogOutput;
    iAnalogOutput17: TiAnalogOutput;
    iAnalogOutput18: TiAnalogOutput;
    iAnalogOutput19: TiAnalogOutput;
    iAnalogOutput20: TiAnalogOutput;
    iAnalogOutput21: TiAnalogOutput;
    iAnalogOutput22: TiAnalogOutput;
    iAnalogOutput23: TiAnalogOutput;
    iAnalogOutput24: TiAnalogOutput;
    iAnalogOutput25: TiAnalogOutput;
    iAnalogOutput26: TiAnalogOutput;
    iAnalogOutput27: TiAnalogOutput;
    iAnalogOutput28: TiAnalogOutput;
    iAnalogOutput29: TiAnalogOutput;
    iAnalogOutput30: TiAnalogOutput;
    iAnalogOutput31: TiAnalogOutput;
    iAnalogOutput32: TiAnalogOutput;
    iAnalogOutput33: TiAnalogOutput;
    iAnalogOutput34: TiAnalogOutput;
    iAnalogOutput35: TiAnalogOutput;
    iAnalogOutput36: TiAnalogOutput;
    iAnalogOutput37: TiAnalogOutput;
    iAnalogOutput38: TiAnalogOutput;
    iAnalogOutput39: TiAnalogOutput;
    iAnalogOutput40: TiAnalogOutput;
    iAnalogOutput41: TiAnalogOutput;
    iAnalogOutput42: TiAnalogOutput;
    iAnalogOutput43: TiAnalogOutput;
    iAnalogOutput44: TiAnalogOutput;
    iAnalogOutput45: TiAnalogOutput;
    iAnalogOutput46: TiAnalogOutput;
    iAnalogOutput47: TiAnalogOutput;
    iAnalogOutput48: TiAnalogOutput;
    iAnalogOutput49: TiAnalogOutput;
    iAnalogOutput50: TiAnalogOutput;
    iAnalogOutput51: TiAnalogOutput;
    iAnalogOutput52: TiAnalogOutput;
    iAnalogOutput53: TiAnalogOutput;
    iAnalogOutput54: TiAnalogOutput;
    iAnalogOutput55: TiAnalogOutput;
    iAnalogOutput56: TiAnalogOutput;
    iAnalogOutput57: TiAnalogOutput;
    iAnalogOutput58: TiAnalogOutput;
    iAnalogOutput59: TiAnalogOutput;
    iAnalogOutput60: TiAnalogOutput;
    iAnalogOutput61: TiAnalogOutput;
    iAnalogOutput62: TiAnalogOutput;
    iAnalogOutput63: TiAnalogOutput;
    iAnalogOutput64: TiAnalogOutput;
    iAnalogOutput65: TiAnalogOutput;
    iAnalogOutput66: TiAnalogOutput;
    iAnalogOutput67: TiAnalogOutput;
    iAnalogOutput68: TiAnalogOutput;
    iAnalogOutput69: TiAnalogOutput;
    iAnalogOutput70: TiAnalogOutput;
    iAnalogOutput71: TiAnalogOutput;
    iAnalogOutput72: TiAnalogOutput;
    iAnalogOutput73: TiAnalogOutput;
    iAnalogOutput74: TiAnalogOutput;
    iAnalogOutput75: TiAnalogOutput;
    iAnalogOutput76: TiAnalogOutput;
    iAnalogOutput77: TiAnalogOutput;
    iAnalogOutput78: TiAnalogOutput;
    iAnalogOutput79: TiAnalogOutput;
    iAnalogOutput80: TiAnalogOutput;
    iAnalogOutput81: TiAnalogOutput;
    iAnalogOutput82: TiAnalogOutput;
    iAnalogOutput83: TiAnalogOutput;
    iAnalogOutput84: TiAnalogOutput;
    iAnalogOutput85: TiAnalogOutput;
    iAnalogOutput86: TiAnalogOutput;
    iAnalogOutput87: TiAnalogOutput;
    iAnalogOutput88: TiAnalogOutput;
    iAnalogOutput89: TiAnalogOutput;
    iAnalogOutput90: TiAnalogOutput;
    iAnalogOutput91: TiAnalogOutput;
    iAnalogOutput92: TiAnalogOutput;
    iAnalogOutput93: TiAnalogOutput;
    iAnalogOutput94: TiAnalogOutput;
    iAnalogOutput95: TiAnalogOutput;
    iAnalogOutput96: TiAnalogOutput;
    iAnalogOutput97: TiAnalogOutput;
    iAnalogOutput98: TiAnalogOutput;
    iAnalogOutput99: TiAnalogOutput;
    iAnalogOutput100: TiAnalogOutput;
    iAnalogOutput101: TiAnalogOutput;
    iAnalogOutput102: TiAnalogOutput;
    iAnalogOutput103: TiAnalogOutput;
    iAnalogOutput104: TiAnalogOutput;
    iAnalogOutput105: TiAnalogOutput;
    iAnalogOutput106: TiAnalogOutput;
    iAnalogOutput107: TiAnalogOutput;
    iAnalogOutput108: TiAnalogOutput;
    AdvOfficePage6: TAdvOfficePage;
    AdvOfficePage7: TAdvOfficePage;
    AdvOfficePage8: TAdvOfficePage;
    AdvOfficePage9: TAdvOfficePage;
    AdvOfficePage10: TAdvOfficePage;
    AdvOfficePage11: TAdvOfficePage;
    AdvOfficePage12: TAdvOfficePage;
    JvImage2: TJvImage;
    iAnalogOutput109: TiAnalogOutput;
    iAnalogOutput110: TiAnalogOutput;
    iAnalogOutput111: TiAnalogOutput;
    iAnalogOutput112: TiAnalogOutput;
    iAnalogOutput113: TiAnalogOutput;
    iAnalogOutput114: TiAnalogOutput;
    iAnalogOutput115: TiAnalogOutput;
    iAnalogOutput116: TiAnalogOutput;
    iAnalogOutput117: TiAnalogOutput;
    iAnalogOutput118: TiAnalogOutput;
    iAnalogOutput119: TiAnalogOutput;
    iAnalogOutput120: TiAnalogOutput;
    iAnalogOutput121: TiAnalogOutput;
    iAnalogOutput122: TiAnalogOutput;
    iAnalogOutput123: TiAnalogOutput;
    iAnalogOutput124: TiAnalogOutput;
    iAnalogOutput125: TiAnalogOutput;
    iAnalogOutput126: TiAnalogOutput;
    iAnalogOutput127: TiAnalogOutput;
    iAnalogOutput128: TiAnalogOutput;
    iAnalogOutput129: TiAnalogOutput;
    JvImage9: TJvImage;
    iAnalogOutput130: TiAnalogOutput;
    iAnalogOutput131: TiAnalogOutput;
    iAnalogOutput132: TiAnalogOutput;
    iAnalogOutput133: TiAnalogOutput;
    iAnalogOutput134: TiAnalogOutput;
    iAnalogOutput135: TiAnalogOutput;
    iAnalogOutput136: TiAnalogOutput;
    iAnalogOutput137: TiAnalogOutput;
    iAnalogOutput138: TiAnalogOutput;
    iAnalogOutput139: TiAnalogOutput;
    iAnalogOutput140: TiAnalogOutput;
    iAnalogOutput141: TiAnalogOutput;
    iAnalogOutput142: TiAnalogOutput;
    iAnalogOutput143: TiAnalogOutput;
    iAnalogOutput144: TiAnalogOutput;
    iAnalogOutput145: TiAnalogOutput;
    iAnalogOutput146: TiAnalogOutput;
    iAnalogOutput147: TiAnalogOutput;
    iAnalogOutput148: TiAnalogOutput;
    iAnalogOutput149: TiAnalogOutput;
    iAnalogOutput150: TiAnalogOutput;
    JvImage10: TJvImage;
    iAnalogOutput151: TiAnalogOutput;
    iAnalogOutput152: TiAnalogOutput;
    iAnalogOutput153: TiAnalogOutput;
    iAnalogOutput154: TiAnalogOutput;
    iAnalogOutput155: TiAnalogOutput;
    iAnalogOutput156: TiAnalogOutput;
    iAnalogOutput157: TiAnalogOutput;
    iAnalogOutput158: TiAnalogOutput;
    iAnalogOutput159: TiAnalogOutput;
    iAnalogOutput160: TiAnalogOutput;
    iAnalogOutput161: TiAnalogOutput;
    iAnalogOutput162: TiAnalogOutput;
    iAnalogOutput163: TiAnalogOutput;
    iAnalogOutput164: TiAnalogOutput;
    iAnalogOutput165: TiAnalogOutput;
    iAnalogOutput166: TiAnalogOutput;
    iAnalogOutput167: TiAnalogOutput;
    iAnalogOutput168: TiAnalogOutput;
    iAnalogOutput169: TiAnalogOutput;
    iAnalogOutput170: TiAnalogOutput;
    iAnalogOutput171: TiAnalogOutput;
    AdvOfficePage13: TAdvOfficePage;
    AdvOfficePage14: TAdvOfficePage;
    AdvOfficePage15: TAdvOfficePage;
    AdvOfficePage16: TAdvOfficePage;
    AdvOfficePage17: TAdvOfficePage;
    AdvOfficePage18: TAdvOfficePage;
    AdvOfficePage19: TAdvOfficePage;
    JvImage11: TJvImage;
    iAnalogOutput172: TiAnalogOutput;
    iAnalogOutput173: TiAnalogOutput;
    iAnalogOutput174: TiAnalogOutput;
    iAnalogOutput175: TiAnalogOutput;
    iAnalogOutput176: TiAnalogOutput;
    iAnalogOutput177: TiAnalogOutput;
    iAnalogOutput178: TiAnalogOutput;
    iAnalogOutput179: TiAnalogOutput;
    iAnalogOutput180: TiAnalogOutput;
    iAnalogOutput181: TiAnalogOutput;
    iAnalogOutput182: TiAnalogOutput;
    iAnalogOutput183: TiAnalogOutput;
    iAnalogOutput184: TiAnalogOutput;
    JvImage12: TJvImage;
    iAnalogOutput185: TiAnalogOutput;
    iAnalogOutput186: TiAnalogOutput;
    iAnalogOutput187: TiAnalogOutput;
    iAnalogOutput188: TiAnalogOutput;
    iAnalogOutput189: TiAnalogOutput;
    iAnalogOutput190: TiAnalogOutput;
    iAnalogOutput191: TiAnalogOutput;
    iAnalogOutput192: TiAnalogOutput;
    iAnalogOutput193: TiAnalogOutput;
    iAnalogOutput194: TiAnalogOutput;
    iAnalogOutput195: TiAnalogOutput;
    iAnalogOutput196: TiAnalogOutput;
    iAnalogOutput197: TiAnalogOutput;
    JvImage13: TJvImage;
    iAnalogOutput198: TiAnalogOutput;
    iAnalogOutput199: TiAnalogOutput;
    iAnalogOutput200: TiAnalogOutput;
    iAnalogOutput201: TiAnalogOutput;
    iAnalogOutput202: TiAnalogOutput;
    iAnalogOutput203: TiAnalogOutput;
    iAnalogOutput204: TiAnalogOutput;
    iAnalogOutput205: TiAnalogOutput;
    iAnalogOutput206: TiAnalogOutput;
    iAnalogOutput207: TiAnalogOutput;
    iAnalogOutput208: TiAnalogOutput;
    iAnalogOutput209: TiAnalogOutput;
    iAnalogOutput210: TiAnalogOutput;
    AdvOfficePage20: TAdvOfficePage;
    AdvOfficePage21: TAdvOfficePage;
    AdvOfficePage22: TAdvOfficePage;
    AdvOfficePage23: TAdvOfficePage;
    AdvOfficePage24: TAdvOfficePage;
    AdvOfficePage25: TAdvOfficePage;
    AdvOfficePage26: TAdvOfficePage;
    JvImage14: TJvImage;
    iAnalogOutput211: TiAnalogOutput;
    iAnalogOutput212: TiAnalogOutput;
    iAnalogOutput213: TiAnalogOutput;
    iAnalogOutput214: TiAnalogOutput;
    iAnalogOutput215: TiAnalogOutput;
    iAnalogOutput216: TiAnalogOutput;
    iAnalogOutput217: TiAnalogOutput;
    iAnalogOutput218: TiAnalogOutput;
    iAnalogOutput219: TiAnalogOutput;
    iAnalogOutput220: TiAnalogOutput;
    iAnalogOutput221: TiAnalogOutput;
    iAnalogOutput222: TiAnalogOutput;
    iAnalogOutput223: TiAnalogOutput;
    iAnalogOutput224: TiAnalogOutput;
    JvImage15: TJvImage;
    iAnalogOutput225: TiAnalogOutput;
    iAnalogOutput226: TiAnalogOutput;
    iAnalogOutput227: TiAnalogOutput;
    iAnalogOutput228: TiAnalogOutput;
    iAnalogOutput229: TiAnalogOutput;
    iAnalogOutput230: TiAnalogOutput;
    iAnalogOutput231: TiAnalogOutput;
    iAnalogOutput232: TiAnalogOutput;
    iAnalogOutput233: TiAnalogOutput;
    iAnalogOutput234: TiAnalogOutput;
    iAnalogOutput235: TiAnalogOutput;
    iAnalogOutput236: TiAnalogOutput;
    iAnalogOutput237: TiAnalogOutput;
    iAnalogOutput238: TiAnalogOutput;
    JvImage16: TJvImage;
    iAnalogOutput239: TiAnalogOutput;
    iAnalogOutput240: TiAnalogOutput;
    iAnalogOutput241: TiAnalogOutput;
    iAnalogOutput242: TiAnalogOutput;
    iAnalogOutput243: TiAnalogOutput;
    iAnalogOutput244: TiAnalogOutput;
    iAnalogOutput245: TiAnalogOutput;
    iAnalogOutput246: TiAnalogOutput;
    iAnalogOutput247: TiAnalogOutput;
    iAnalogOutput248: TiAnalogOutput;
    iAnalogOutput249: TiAnalogOutput;
    iAnalogOutput250: TiAnalogOutput;
    iAnalogOutput251: TiAnalogOutput;
    iAnalogOutput252: TiAnalogOutput;
    AdvOfficePage27: TAdvOfficePage;
    AdvOfficePage28: TAdvOfficePage;
    AdvOfficePage29: TAdvOfficePage;
    AdvOfficePage30: TAdvOfficePage;
    AdvOfficePage31: TAdvOfficePage;
    AdvOfficePage32: TAdvOfficePage;
    AdvOfficePage33: TAdvOfficePage;
    JvImage17: TJvImage;
    iAnalogOutput253: TiAnalogOutput;
    iAnalogOutput254: TiAnalogOutput;
    iAnalogOutput255: TiAnalogOutput;
    iAnalogOutput256: TiAnalogOutput;
    iAnalogOutput257: TiAnalogOutput;
    iAnalogOutput258: TiAnalogOutput;
    iAnalogOutput259: TiAnalogOutput;
    iAnalogOutput260: TiAnalogOutput;
    iAnalogOutput261: TiAnalogOutput;
    iAnalogOutput262: TiAnalogOutput;
    iAnalogOutput263: TiAnalogOutput;
    iAnalogOutput264: TiAnalogOutput;
    iAnalogOutput265: TiAnalogOutput;
    iAnalogOutput266: TiAnalogOutput;
    iAnalogOutput267: TiAnalogOutput;
    iAnalogOutput268: TiAnalogOutput;
    iAnalogOutput269: TiAnalogOutput;
    iAnalogOutput270: TiAnalogOutput;
    iAnalogOutput271: TiAnalogOutput;
    iAnalogOutput272: TiAnalogOutput;
    iAnalogOutput273: TiAnalogOutput;
    JvImage18: TJvImage;
    iAnalogOutput274: TiAnalogOutput;
    iAnalogOutput275: TiAnalogOutput;
    iAnalogOutput276: TiAnalogOutput;
    iAnalogOutput277: TiAnalogOutput;
    iAnalogOutput278: TiAnalogOutput;
    iAnalogOutput279: TiAnalogOutput;
    iAnalogOutput280: TiAnalogOutput;
    iAnalogOutput281: TiAnalogOutput;
    iAnalogOutput282: TiAnalogOutput;
    iAnalogOutput283: TiAnalogOutput;
    iAnalogOutput284: TiAnalogOutput;
    iAnalogOutput285: TiAnalogOutput;
    iAnalogOutput286: TiAnalogOutput;
    iAnalogOutput287: TiAnalogOutput;
    iAnalogOutput288: TiAnalogOutput;
    iAnalogOutput289: TiAnalogOutput;
    iAnalogOutput290: TiAnalogOutput;
    iAnalogOutput291: TiAnalogOutput;
    iAnalogOutput292: TiAnalogOutput;
    iAnalogOutput293: TiAnalogOutput;
    iAnalogOutput294: TiAnalogOutput;
    JvImage19: TJvImage;
    iAnalogOutput295: TiAnalogOutput;
    iAnalogOutput296: TiAnalogOutput;
    iAnalogOutput297: TiAnalogOutput;
    iAnalogOutput298: TiAnalogOutput;
    iAnalogOutput299: TiAnalogOutput;
    iAnalogOutput300: TiAnalogOutput;
    iAnalogOutput301: TiAnalogOutput;
    iAnalogOutput302: TiAnalogOutput;
    iAnalogOutput303: TiAnalogOutput;
    iAnalogOutput304: TiAnalogOutput;
    iAnalogOutput305: TiAnalogOutput;
    iAnalogOutput306: TiAnalogOutput;
    iAnalogOutput307: TiAnalogOutput;
    iAnalogOutput308: TiAnalogOutput;
    iAnalogOutput309: TiAnalogOutput;
    iAnalogOutput310: TiAnalogOutput;
    iAnalogOutput311: TiAnalogOutput;
    iAnalogOutput312: TiAnalogOutput;
    iAnalogOutput313: TiAnalogOutput;
    iAnalogOutput314: TiAnalogOutput;
    iAnalogOutput315: TiAnalogOutput;
    AdvOfficePage34: TAdvOfficePage;
    AdvOfficePage35: TAdvOfficePage;
    AdvOfficePage36: TAdvOfficePage;
    AdvOfficePage37: TAdvOfficePage;
    AdvOfficePage38: TAdvOfficePage;
    AdvOfficePage39: TAdvOfficePage;
    AdvOfficePage40: TAdvOfficePage;
    AdvOfficePage41: TAdvOfficePage;
    AdvOfficePage42: TAdvOfficePage;
    AdvOfficePage43: TAdvOfficePage;
    AdvOfficePage44: TAdvOfficePage;
    AdvOfficePage45: TAdvOfficePage;
    AdvOfficePage46: TAdvOfficePage;
    AdvOfficePage47: TAdvOfficePage;
    JvImage20: TJvImage;
    iAnalogOutput316: TiAnalogOutput;
    iAnalogOutput317: TiAnalogOutput;
    iAnalogOutput318: TiAnalogOutput;
    iAnalogOutput319: TiAnalogOutput;
    iAnalogOutput320: TiAnalogOutput;
    iAnalogOutput321: TiAnalogOutput;
    iAnalogOutput322: TiAnalogOutput;
    iAnalogOutput323: TiAnalogOutput;
    iAnalogOutput324: TiAnalogOutput;
    iAnalogOutput325: TiAnalogOutput;
    iAnalogOutput326: TiAnalogOutput;
    iAnalogOutput327: TiAnalogOutput;
    iAnalogOutput328: TiAnalogOutput;
    iAnalogOutput329: TiAnalogOutput;
    iAnalogOutput330: TiAnalogOutput;
    iAnalogOutput331: TiAnalogOutput;
    iAnalogOutput332: TiAnalogOutput;
    iAnalogOutput333: TiAnalogOutput;
    iAnalogOutput334: TiAnalogOutput;
    iAnalogOutput335: TiAnalogOutput;
    iAnalogOutput336: TiAnalogOutput;
    iAnalogOutput337: TiAnalogOutput;
    iAnalogOutput338: TiAnalogOutput;
    iAnalogOutput339: TiAnalogOutput;
    iAnalogOutput340: TiAnalogOutput;
    iAnalogOutput341: TiAnalogOutput;
    JvImage21: TJvImage;
    iAnalogOutput342: TiAnalogOutput;
    iAnalogOutput343: TiAnalogOutput;
    iAnalogOutput344: TiAnalogOutput;
    iAnalogOutput345: TiAnalogOutput;
    iAnalogOutput346: TiAnalogOutput;
    iAnalogOutput347: TiAnalogOutput;
    iAnalogOutput348: TiAnalogOutput;
    iAnalogOutput349: TiAnalogOutput;
    iAnalogOutput350: TiAnalogOutput;
    iAnalogOutput351: TiAnalogOutput;
    iAnalogOutput352: TiAnalogOutput;
    iAnalogOutput353: TiAnalogOutput;
    iAnalogOutput354: TiAnalogOutput;
    iAnalogOutput355: TiAnalogOutput;
    iAnalogOutput356: TiAnalogOutput;
    iAnalogOutput357: TiAnalogOutput;
    iAnalogOutput358: TiAnalogOutput;
    iAnalogOutput359: TiAnalogOutput;
    iAnalogOutput360: TiAnalogOutput;
    iAnalogOutput361: TiAnalogOutput;
    iAnalogOutput362: TiAnalogOutput;
    iAnalogOutput363: TiAnalogOutput;
    iAnalogOutput364: TiAnalogOutput;
    iAnalogOutput365: TiAnalogOutput;
    iAnalogOutput366: TiAnalogOutput;
    iAnalogOutput367: TiAnalogOutput;
    JvImage22: TJvImage;
    iAnalogOutput368: TiAnalogOutput;
    iAnalogOutput369: TiAnalogOutput;
    iAnalogOutput370: TiAnalogOutput;
    iAnalogOutput371: TiAnalogOutput;
    iAnalogOutput372: TiAnalogOutput;
    iAnalogOutput373: TiAnalogOutput;
    iAnalogOutput374: TiAnalogOutput;
    iAnalogOutput375: TiAnalogOutput;
    iAnalogOutput376: TiAnalogOutput;
    iAnalogOutput377: TiAnalogOutput;
    iAnalogOutput378: TiAnalogOutput;
    iAnalogOutput379: TiAnalogOutput;
    iAnalogOutput380: TiAnalogOutput;
    iAnalogOutput381: TiAnalogOutput;
    iAnalogOutput382: TiAnalogOutput;
    iAnalogOutput383: TiAnalogOutput;
    iAnalogOutput384: TiAnalogOutput;
    iAnalogOutput385: TiAnalogOutput;
    iAnalogOutput386: TiAnalogOutput;
    iAnalogOutput387: TiAnalogOutput;
    iAnalogOutput388: TiAnalogOutput;
    iAnalogOutput389: TiAnalogOutput;
    iAnalogOutput390: TiAnalogOutput;
    iAnalogOutput391: TiAnalogOutput;
    iAnalogOutput392: TiAnalogOutput;
    iAnalogOutput393: TiAnalogOutput;
    JvImage23: TJvImage;
    iAnalogOutput394: TiAnalogOutput;
    iAnalogOutput395: TiAnalogOutput;
    iAnalogOutput396: TiAnalogOutput;
    iAnalogOutput397: TiAnalogOutput;
    iAnalogOutput398: TiAnalogOutput;
    iAnalogOutput399: TiAnalogOutput;
    iAnalogOutput400: TiAnalogOutput;
    iAnalogOutput401: TiAnalogOutput;
    iAnalogOutput402: TiAnalogOutput;
    iAnalogOutput403: TiAnalogOutput;
    iAnalogOutput404: TiAnalogOutput;
    iAnalogOutput405: TiAnalogOutput;
    iAnalogOutput406: TiAnalogOutput;
    JvImage24: TJvImage;
    iAnalogOutput407: TiAnalogOutput;
    iAnalogOutput408: TiAnalogOutput;
    iAnalogOutput409: TiAnalogOutput;
    iAnalogOutput410: TiAnalogOutput;
    iAnalogOutput411: TiAnalogOutput;
    iAnalogOutput412: TiAnalogOutput;
    iAnalogOutput413: TiAnalogOutput;
    iAnalogOutput414: TiAnalogOutput;
    iAnalogOutput415: TiAnalogOutput;
    iAnalogOutput416: TiAnalogOutput;
    iAnalogOutput417: TiAnalogOutput;
    iAnalogOutput418: TiAnalogOutput;
    iAnalogOutput419: TiAnalogOutput;
    JvImage25: TJvImage;
    iAnalogOutput420: TiAnalogOutput;
    iAnalogOutput421: TiAnalogOutput;
    iAnalogOutput422: TiAnalogOutput;
    iAnalogOutput423: TiAnalogOutput;
    iAnalogOutput424: TiAnalogOutput;
    iAnalogOutput425: TiAnalogOutput;
    iAnalogOutput426: TiAnalogOutput;
    iAnalogOutput427: TiAnalogOutput;
    iAnalogOutput428: TiAnalogOutput;
    iAnalogOutput429: TiAnalogOutput;
    iAnalogOutput430: TiAnalogOutput;
    iAnalogOutput431: TiAnalogOutput;
    iAnalogOutput432: TiAnalogOutput;
    DropTextTarget1: TDropTextTarget;
    PopupMenu1: TPopupMenu;
    Save2DFM1: TMenuItem;
    JvTransparentButton4: TJvTransparentButton;
    N1: TMenuItem;
    ShowTabAll1: TMenuItem;
    HideGETabAll1: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Save2DFM1Click(Sender: TObject);
    procedure DropTextTarget1Drop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure ShowTabAll1Click(Sender: TObject);
    procedure HideGETabAll1Click(Sender: TObject);
  private
    FSCRParameterTarget: TSCRParamDataFormat;

    procedure InitVar;
    procedure DestroyVar;

    procedure ShowOrHideGETabAll(AVisible: Boolean);
  public
    { Public declarations }
  end;

  function CreateNShowSCRGESetting(AOwner: TComponent): string;
  function CreateNShowSCRGESetting2(AOwner: TComponent): TForm;

var
  SCRGESettingF: TSCRGESettingF;

implementation

uses UnitMouseUtil, UCommonUtil;

{$R *.dfm}

function CreateNShowSCRGESetting(AOwner: TComponent): string;
begin
  Result := '';

  if Assigned(SCRGESettingF) then
    FreeAndNil(SCRGESettingF);

  SCRGESettingF := TSCRGESettingF.Create(AOwner);

  try
    if SCRGESettingF.ShowModal = mrOK then
    begin
      Result := '';
    end;
  finally
    FreeAndNil(SCRGESettingF);
  end;
end;

function CreateNShowSCRGESetting2(AOwner: TComponent): TForm;
begin
  if Assigned(SCRGESettingF) then
    FreeAndNil(SCRGESettingF);

  SCRGESettingF := TSCRGESettingF.Create(AOwner);
  SCRGESettingF.Show;

  Result := SCRGESettingF;
end;

procedure TSCRGESettingF.DestroyVar;
begin
  FSCRParameterTarget.Free;
end;

procedure TSCRGESettingF.DropTextTarget1Drop(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
var
  LControl: TControl;
begin
  if (FSCRParameterTarget.HasData) then
  begin
    LControl := GetComponentUnderMouseCursor();

    if Assigned(LControl) then
    begin
      if LControl.ClassType = TAdvGraphicCheckLabel then
      begin
//        TAdvGraphicCheckLabel(LControl).Checked := FSCRParameterTarget.SCRD.FSCRParam.F4S_LPSCR_Enable;
        TAdvGraphicCheckLabel(LControl).Tag := FSCRParameterTarget.SCRD.FTagID;
      end
      else
      if LControl.ClassType = TiAnalogOutput then
      begin
        TiAnalogOutput(LControl).Tag := FSCRParameterTarget.SCRD.FTagID;
      end;
    end;
  end;
end;

procedure TSCRGESettingF.FormCreate(Sender: TObject);
begin
  InitVar;
end;

procedure TSCRGESettingF.FormDestroy(Sender: TObject);
begin
  DestroyVar;
end;

procedure TSCRGESettingF.HideGETabAll1Click(Sender: TObject);
begin
  ShowOrHideGETabAll(False);
end;

procedure TSCRGESettingF.InitVar;
begin
  FSCRParameterTarget := TSCRParamDataFormat.Create(DropTextTarget1);
end;

procedure TSCRGESettingF.Save2DFM1Click(Sender: TObject);
begin
  SaveSCRForm2DFM(Self as TForm);
end;

procedure TSCRGESettingF.ShowOrHideGETabAll(AVisible: Boolean);
var
  i: integer;
begin
  for i := 0 to AdvOfficePager1.AdvPageCount - 1 do
    AdvOfficePager1.AdvPages[i].TabVisible := AVisible;

  for i := 0 to AdvOfficePager2.AdvPageCount - 1 do
    AdvOfficePager2.AdvPages[i].TabVisible := AVisible;

  for i := 0 to AdvOfficePager3.AdvPageCount - 1 do
    AdvOfficePager3.AdvPages[i].TabVisible := AVisible;

  for i := 0 to AdvOfficePager4.AdvPageCount - 1 do
    AdvOfficePager4.AdvPages[i].TabVisible := AVisible;

  for i := 0 to AdvOfficePager5.AdvPageCount - 1 do
    AdvOfficePager5.AdvPages[i].TabVisible := AVisible;

  for i := 0 to AdvOfficePager6.AdvPageCount - 1 do
    AdvOfficePager6.AdvPages[i].TabVisible := AVisible;

end;

procedure TSCRGESettingF.ShowTabAll1Click(Sender: TObject);
begin
  ShowOrHideGETabAll(True);
end;

end.
