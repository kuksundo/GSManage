unit UDragDropFormat_SCRParam;

interface

uses
  System.Types,
  DragDrop,
  DragDropFormats,
  DropTarget,
  DropSource,
  Classes, ActiveX,
  USCRParamClass;

type
  TSCRParam_DragDrop = record
    FSCRParam: TSCRParameterRecord;
    FIsMultipleRec: Boolean; //DragDrop시에 record 가 복수개인지 여부
    //Drag시 누른 키 값은 HiMECS_Watch2(다른 Propcess이므로)에 전달되지 않기 때문에 따로 전해줌
    //Ctrl + MouseDrag 이벤트가 안 잡혀서 실패함
    FShiftState: TShiftState; //DragDrop시에 Ctrl/Shift/Alt 키 상태 여부
    FSourceHandle: integer; //Drag Source Window Handle
    FTagID: integer;
  end;

  TSCRParamDataClipboardFormat = class(TCustomSimpleClipboardFormat)
  private
    FSCRD: TSCRParam_DragDrop;
    FGotData: boolean;
  protected
    function ReadData(Value: pointer; Size: integer): boolean; override;
    function WriteData(Value: pointer; Size: integer): boolean; override;
    function GetSize: integer; override;
    procedure SetSCRD(const Value: TSCRParam_DragDrop);
  public
    function GetClipboardFormat: TClipFormat; override;
    procedure Clear; override;
    function HasData: boolean; override;
    property SCRD: TSCRParam_DragDrop read FSCRD write SetSCRD;
  end;

  TSCRParamDataFormat = class(TCustomDataFormat)
  private
    FSCRD: TSCRParam_DragDrop;
    FGotData: boolean;
  protected
    class procedure RegisterCompatibleFormats; override;
    procedure SetSCRD(const Value: TSCRParam_DragDrop);
  public
    function Assign(Source: TClipboardFormat): boolean; override;
    function AssignTo(Dest: TClipboardFormat): boolean; override;
    procedure Clear; override;
    function HasData: boolean; override;
    function NeedsData: boolean; override;
    property SCRD: TSCRParam_DragDrop read FSCRD write SetSCRD;
  end;

const
  sSCRParameter_DragDrop = 'TSCRParameterItemRecord';

implementation

uses
  Windows,
  SysUtils;

{ TSCRParamDataFormat }

function TSCRParamDataFormat.Assign(Source: TClipboardFormat): boolean;
begin
  Result := True;

  if (Source is TSCRParamDataClipboardFormat) then
    SCRD := TSCRParamDataClipboardFormat(Source).SCRD
  else
    Result := inherited Assign(Source);

  FGotData := Result;
end;

function TSCRParamDataFormat.AssignTo(Dest: TClipboardFormat): boolean;
begin
  Result := True;

  if (Dest is TSCRParamDataClipboardFormat) then
    TSCRParamDataClipboardFormat(Dest).SCRD := FSCRD
  else
    Result := inherited AssignTo(Dest);
end;

procedure TSCRParamDataFormat.Clear;
begin
  Changing;
  FillChar(FSCRD, SizeOf(FSCRD), 0);
  FGotData := False;
end;

function TSCRParamDataFormat.HasData: boolean;
begin
  Result := FGotData;
end;

function TSCRParamDataFormat.NeedsData: boolean;
begin
  Result := not FGotData;
end;

class procedure TSCRParamDataFormat.RegisterCompatibleFormats;
begin
  inherited RegisterCompatibleFormats;

  RegisterDataConversion(TSCRParamDataClipboardFormat);
end;

procedure TSCRParamDataFormat.SetSCRD(const Value: TSCRParam_DragDrop);
begin
  Changing;
  FSCRD := Value;
  FGotData := True;
end;

{ TSCRParamDataClipboardFormat }

procedure TSCRParamDataClipboardFormat.Clear;
begin
  FillChar(FSCRD, SizeOf(FSCRD), 0);
  FGotData := False;
end;

var
  CF_TOD: TClipFormat = 0;

function TSCRParamDataClipboardFormat.GetClipboardFormat: TClipFormat;
begin
  if (CF_TOD = 0) then
    CF_TOD := RegisterClipboardFormat(sSCRParameter_DragDrop);
  Result := CF_TOD;
end;

function TSCRParamDataClipboardFormat.GetSize: integer;
begin
  Result := SizeOf(TSCRParam_DragDrop);
end;

function TSCRParamDataClipboardFormat.HasData: boolean;
begin
  Result := FGotData;
end;

function TSCRParamDataClipboardFormat.ReadData(Value: pointer;
  Size: integer): boolean;
begin
  // Copy data from buffer into our structure.
  Move(Value^, FSCRD, Size);

  FGotData := True;
  Result := True;
end;

procedure TSCRParamDataClipboardFormat.SetSCRD(const Value: TSCRParam_DragDrop);
begin
  FSCRD := Value;
  FGotData := True;
end;

function TSCRParamDataClipboardFormat.WriteData(Value: pointer;
  Size: integer): boolean;
begin
  Result := (Size = SizeOf(TSCRParam_DragDrop));
  if (Result) then
    // Copy data from our structure into buffer.
    Move(FSCRD, Value^, Size);
end;

initialization
  // Data format registration
  TSCRParamDataFormat.RegisterDataFormat;
  // Clipboard format registration
  TSCRParamDataClipboardFormat.RegisterFormat;

end.
