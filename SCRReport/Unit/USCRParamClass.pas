unit USCRParamClass;

interface

uses WinApi.Windows, System.SysUtils, Classes, Rtti, TypInfo,
  mormot.core.unicode, mormot.core.data, mormot.core.variants, mormot.core.json, mormot.core.base,
  IniPersist,
  UnitConfigIniClass2;

type
  TSCRRecipeInfo = class(TSynAutoCreateFields)
  public
    FTagID: integer;
    FTagName,
    FTagDesc: string;
    FSCRType: string;//2S, 4S, Common
    FParamKind: string;//App Setting...
    FSCRComponent: string;//Dosing...
    FValueBitNo: integer;
    //DEFAULT_RECIPE_INFO_FILENAME 파일에서 초기화할 때 FParamValue 값을 보고 ValuieType을 결정함
    FValueType,//BOOL,INTEGER,DOUBLE 중 하나임.
    FParamValue: string;
  end;

  TSCRRecipeInfoObjArray = array of TSCRRecipeInfo;

  TSCRAppParam = class(TINIConfigBase)
  public
  {$I SCRParamFieldList-App.txt}
  published
  {$I SCRParamPropertyList-App.txt}
  end;

  TSCRMEHPParam = class(TINIConfigBase)
  public
  {$I SCRParamFieldList-ME-HP.txt}
  published
  {$I SCRParamPropertyList-ME-HP.txt}
  end;

  TSCRMELPParam = class(TINIConfigBase)
  public
  {$I SCRParamFieldList-ME-LP.txt}
  published
  {$I SCRParamPropertyList-ME-LP.txt}
  end;

  TSCRAEParam_1 = class(TINIConfigBase)
  public
  {$I SCRParamFieldList-AE1.txt}
  published
  {$I SCRParamPropertyList-AE1.txt}
  end;

  TSCRAEParam_2 = class(TINIConfigBase)
  public
  {$I SCRParamFieldList-AE2.txt}
  published
  {$I SCRParamPropertyList-AE2.txt}
  end;

  TSCRAEParam_3 = class(TINIConfigBase)
  public
  {$I SCRParamFieldList-AE3.txt}
  published
  {$I SCRParamPropertyList-AE3.txt}
  end;

  TSCRAEParam_4 = class(TINIConfigBase)
  public
  {$I SCRParamFieldList-AE4.txt}
  published
  {$I SCRParamPropertyList-AE4.txt}
  end;

  TSCRAEParam_5 = class(TINIConfigBase)
  public
  {$I SCRParamFieldList-AE5.txt}
  published
  {$I SCRParamPropertyList-AE5.txt}
  end;

  TSCRAEParam_6 = class(TINIConfigBase)
  public
  {$I SCRParamFieldList-AE6.txt}
  published
  {$I SCRParamPropertyList-AE6.txt}
  end;

  TSCRAEParam_7 = class(TINIConfigBase)
  public
  {$I SCRParamFieldList-AE7.txt}
  published
  {$I SCRParamPropertyList-AE7.txt}
  end;

  TSCRAEParam_8 = class(TINIConfigBase)
  public
  {$I SCRParamFieldList-AE8.txt}
  published
  {$I SCRParamPropertyList-AE8.txt}
  end;

  function LoadSCRRecipeInfoObjArrayFromJsonFile(const AFileName: string; out AObjArray: TSCRRecipeInfoObjArray): Boolean;
  function LoadSCRRecipeValueFromRecipeFile(const AFileName: string;
    var AObjArray: TSCRRecipeInfoObjArray): Boolean;
  function SaveSCRRecipeValue2RecipeFile(const AFileName: string;
    const AObjArray: TSCRRecipeInfoObjArray): Boolean;

  //AScrType: 1 = TSCRAppParam, 2 = TSCRMEHPParam, 3 = TSCRMELPParam, 4 = TSCRAEParam_1 ...
  function SetSCRRecipeInfoValueFromSCRParam(const ASCRParam: TObject; var AObjArray: TSCRRecipeInfoObjArray): Boolean;//; const AScrType: integer
  function AssignSCRRecipe2SCRParamClass(const AObjArray: TSCRRecipeInfoObjArray; ASCRParam: TObject): Boolean;
  function GetValuTypeFromParamValue(AParamValue: string): string;

implementation

uses USettingsConst, UAppInfo;

function LoadSCRRecipeInfoObjArrayFromJsonFile(const AFileName: string; out AObjArray: TSCRRecipeInfoObjArray): Boolean;
var
  LStrList: TStringList;
  LStr: string;
  LUtf8: RawUTF8;
  LSCRRecipeInfo: TSCRRecipeInfo;
  LDynUtf8: TRawUTF8DynArray;
  LDynArr, LObjDynAry: TDynArray;
  LDoc: variant;
  Li: integer;
  i: integer;
  LFieldName, LValue: RawUTF8;
begin
  LStrList := TStringList.Create;
  try
    LStrList.LoadFromFile(AFileName, TEncoding.UTF8);

    LStr := LStrList.Text;
    LUtf8 := StringToUtf8(LStr);

    LDynArr.Init(TypeInfo(TRawUTF8DynArray), LDynUtf8);
    LDynArr.LoadFromJSON(PUTF8Char(LUtf8));

    LObjDynAry.Init(TypeInfo(TSCRRecipeInfoObjArray), AObjArray);
//    SetLength(AObjArray, LDynArr.Count);

    for i := 0 to LDynArr.Count - 1 do
    begin
      LSCRRecipeInfo := TSCRRecipeInfo.Create;

      LDoc := _JSON(LDynUtf8[i]);

      for Li := 0 to TDocVariantData(LDoc).Count - 1 do
      begin
        LFieldName := UpperCase(TDocVariantData(LDoc).Names[Li]);
        LValue := TDocVariantData(LDoc).Values[Li];

        if LFieldName = 'TAGID' then
          LSCRRecipeInfo.FTagID := StrToIntDef(LValue, -1)
        else
        if LFieldName = 'TAGNAME' then
          LSCRRecipeInfo.FTagName := Utf8ToString(LValue)
        else
        if LFieldName = 'TAGDESC' then
          LSCRRecipeInfo.FTagDesc := LValue
        else
        if LFieldName = 'SCRTYPE' then
          LSCRRecipeInfo.FSCRType := LValue
        else
        if LFieldName = 'PARAMKIND' then
          LSCRRecipeInfo.FParamKind := LValue
        else
        if LFieldName = 'SCRCOMPONENT' then
          LSCRRecipeInfo.FSCRComponent := LValue
        else
        if LFieldName = 'VALUEBITNO' then
          LSCRRecipeInfo.FValueBitNo := StrToIntDef(LValue, -1)
        else
        if LFieldName = 'PARAMVALUE' then
          LSCRRecipeInfo.FParamValue := LValue;
      end;

      LObjDynAry.Add(LSCRRecipeInfo);
    end;

  finally
    LStrList.Free;
  end;
end;

function LoadSCRRecipeValueFromRecipeFile(const AFileName: string;
  var AObjArray: TSCRRecipeInfoObjArray): Boolean;
var
  LValueList, LDivisionList: TStringList;
  i, j, LDivIdx, LValueIdx: integer;
  LCount: integer;
  LSkipValue: Boolean;
begin
  LCount := High(AObjArray);

  LValueList := TStringList.Create;
  LDivisionList := TStringList.Create;
  try
    LDivisionList.LoadFromFile(TAppInfo.AppExeDir + DEFAULT_RECIPE_DIV_FILENAME);
    LValueList.LoadFromFile(AFileName);

    LSkipValue := False;
    LValueIdx := 0;

    for i := 0 to LValueList.Count - 1 do
    begin
      for j := 0 to LDivisionList.Count - 1 do
      begin
        LDivIdx := StrToIntDef(LDivisionList.ValueFromIndex[j], -1);

        if LDivIdx = i then
        begin
          LSkipValue := True;
          Break;
        end;
      end;//for j

      if LSkipValue then
      begin
        LSkipValue := False;
        Continue;
      end;

      AObjArray[LValueIdx].FParamValue := LValueList.Strings[i];
      Inc(LValueIdx);
    end;//for i
  finally
    LDivisionList.Free;
    LValueList.Free;
  end;
end;

function SaveSCRRecipeValue2RecipeFile(const AFileName: string;
  const AObjArray: TSCRRecipeInfoObjArray): Boolean;
var
  LValueList, LDivisionList: TStringList;
  i, j, LDivIdx, LValueIdx: integer;
  LCount: integer;
  LSkipValue: Boolean;
  LSCRRecipeInfo: TSCRRecipeInfo;
begin
  if AFileName = '' then
  begin
    Result := False;
    exit;
  end;

  LCount := High(AObjArray);

  LValueList := TStringList.Create;
  LDivisionList := TStringList.Create;
  try
    LDivisionList.LoadFromFile(TAppInfo.AppExeDir + DEFAULT_RECIPE_DIV_FILENAME);

    LSkipValue := False;
    LValueIdx := 0;

    for i := 0 to LCount do
    begin
      for j := 0 to LDivisionList.Count - 1 do
      begin
        LDivIdx := StrToIntDef(LDivisionList.ValueFromIndex[j], -1);

        if LDivIdx = i then
        begin
          LValueList.Add(LDivisionList.Names[j]);
          LSkipValue := True;
          Break;
        end;
      end;//for j

      if LSkipValue then
      begin
        LSkipValue := False;
        Continue;
      end;

      LValueList.Add(AObjArray[LValueIdx].FParamValue);
      Inc(LValueIdx);
    end;//for i

    LValueList.SaveToFile(AFileName);
  finally
    LDivisionList.Free;
    LValueList.Free;
    Result := True;
  end;
end;

function SetSCRRecipeInfoValueFromSCRParam(const ASCRParam: TObject;
  var AObjArray: TSCRRecipeInfoObjArray): Boolean;//; const AScrType: integer
var
  ctx : TRttiContext;
  objType : TRttiType;
  Prop  : TRttiProperty;
  LValue : TValue;
  IniValue : IniValueAttribute;
  Data : String;
  LSCRRecipeInfo: TSCRRecipeInfo;
  i, LObjDynAryCount, LTagNo: integer;
begin
  LObjDynAryCount := High(AObjArray);

  ctx := TRttiContext.Create;
  try
    objType := ctx.GetType(ASCRParam.ClassInfo);

    for Prop in objType.GetProperties do
    begin
      IniValue := TIniPersist.GetIniAttribute(Prop);

      if Assigned(IniValue) then
      begin
        LTagNo := IniValue.TagNo;

        if (LTagNo > 0) and (LTagNo <= LObjDynAryCount) then
        begin
          LSCRRecipeInfo := AObjArray[LTagNo-1];
          LValue := Prop.GetValue(ASCRParam);
          LSCRRecipeInfo.FParamValue := LValue.ToString;
        end;
      end;//if Assigned(IniValue)
    end;//for
  finally
    ctx.Free;
  end;
end;

function AssignSCRRecipe2SCRParamClass(const AObjArray: TSCRRecipeInfoObjArray;
  ASCRParam: TObject): Boolean;
var
  ctx : TRttiContext;
  objType : TRttiType;
  Prop  : TRttiProperty;
  LValue : TValue;
  IniValue : IniValueAttribute;
  Data : String;
  LSCRRecipeInfo: TSCRRecipeInfo;
  i, LObjDynAryCount, LTagNo: integer;

  function GetValue(AStrValue: string): TValue;
  begin
    if GetValuTypeFromParamValue(AStrValue) = 'BOOL' then
      Result := StrToBool(AStrValue)
    else
    if GetValuTypeFromParamValue(AStrValue) = 'DOUBLE' then
      Result := StrToFloat(AStrValue)
    else
    if GetValuTypeFromParamValue(AStrValue) = 'INTEGER' then
      Result := StrToIntDef(AStrValue, -1)
    else
      Result := TValue.Empty;
  end;
begin
  LObjDynAryCount := High(AObjArray);

  ctx := TRttiContext.Create;
  try
    objType := ctx.GetType(ASCRParam.ClassInfo);

    for Prop in objType.GetProperties do
    begin
      IniValue := TIniPersist.GetIniAttribute(Prop);

      if Assigned(IniValue) then
      begin
        LTagNo := IniValue.TagNo;

        if (LTagNo > 0) and (LTagNo <= LObjDynAryCount) then
        begin
          LSCRRecipeInfo := AObjArray[LTagNo-1];
//          LValue := Prop.GetValue(ASCRParam);
          LValue := GetValue(LSCRRecipeInfo.FParamValue);

          if not LValue.IsEmpty then
            Prop.SetValue(ASCRParam, LValue);
        end;
      end;//if Assigned(IniValue)
    end;//for
  finally
    ctx.Free;
  end;
end;

function GetValuTypeFromParamValue(AParamValue: string): string;
begin
  if (UpperCase(AParamValue) = 'FALSE') or (UpperCase(AParamValue) = 'TRUE') then
    Result := 'BOOL'
//  else
//  if Pos('.', AParamValue) > 0 then
//    Result := 'DOUBLE'
  else
  if AParamValue <> '' then
    Result := 'DOUBLE'//'INTEGER'
  else
    Result := 'String';
end;

end.
