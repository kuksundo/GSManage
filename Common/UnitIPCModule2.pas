unit UnitIPCModule2;

interface

uses System.Classes, Dialogs, System.Rtti,
  NxColumnClasses, NxColumns, NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid,
{$IFDEF USE_CROMIS_IPC}
  Cromis.Comm.Custom, Cromis.Comm.IPC, Cromis.Threading, Cromis.AnyValue,
{$ENDIF}
  DateUtils, System.SysUtils, Winapi.ActiveX,
  mormot.rest.http.client, mormot.core.base, mormot.soa.core, mormot.core.variants,
  mormot.core.datetime, mormot.core.json, mormot.orm.core,
  UnitIniConfigSetting2, OLMailWSCallbackInterface2,
  UnitOutlookIPCUtil2, CommonData2,
  {$IFDEF GAMANAGER}
  UnitHiconisMasterRecord,
  {$ELSE}
  UElecDataRecord2,
  {$ENDIF}
  UnitInqManageWSInterface2, UnitOLDataType;

//AMailType = 1: invoice �ۺ�, 2: ����ó����û, 3: �����Կ�û
//            4: �ؿ� ���� ���� ��� ��û, 5: ���� ��ǥ�ذ��� ���� ��û
//            6: PO ��û ����, 7: �������� ��û, 8: �ʵ弭���� ����
//            9: ��ü ���� ��û, 10: ���񽺿��� ���� ��û, 11: ��ü �⼺ Ȯ�� ��û(�������� ����)
//            12: �⼺ ó�� ��û(�⼺ ����ڿ���)
procedure SendCmd2IPC4ReplyMail(AEntryId, AStoreId: string; AMailType: integer;
  ATask: TSQLGSTask; ASettings: TConfigSettings);
procedure SendCmd2IPC4CreateMail(AGrid: TNextGrid; ARow, AMailType: integer;
  ATask: TSQLGSTask; ASettings: TConfigSettings; AToMailAddr: string);
procedure SendCmd2IPC4ForwardMail(AEntryId, AStoreId: string; AMailType: integer; ATask: TSQLGSTask;
   ASettings: TConfigSettings);
procedure SendCmd2IPC4ViewEmail(AGrid: TNextGrid; ARow: integer);
function SendCmd2IPC4MoveFolderEmail(AOriginalEntryId, AOriginalStoreId,
  AMoveStoreId, AMoveStorePath: string; ATask: TSQLGSTask; ASubFolderName: string): boolean;
function SendReqOLEmailInfo2(AGrid: TNextGrid; ATask: TSQLGSTask; var AResultList: TStringList): boolean;

//procedure SendCmd2IPC4ReplyMail_CromisIPC(AGrid: TNextGrid; ARow, AMailType: integer;
//  ATask: TSQLGSTask; ASettings: TConfigSettings);
//procedure SendCmd2IPC4CreateMail_CromisIPC(AGrid: TNextGrid; ARow, AMailType: integer;
//  ATask: TSQLGSTask; ASettings: TConfigSettings; AMailAddr: string);
//procedure SendCmd2IPC4ViewEmail_CromisIPC(AGrid: TNextGrid; ARow: integer);
//function SendCmd2IPC4MoveFolderEmail_CromisIPC(AOriginalEntryId, AOriginalStoreId,
//  AMoveStoreId, AMoveStorePath: string; ATask: TSQLGSTask): boolean;
//function SendReqOLEmailInfo2_CromisIPC(AGrid: TNextGrid; ATask: TSQLGSTask; var AResultList: TStringList): boolean;

{$IFDEF USE_MORMOT_WS}
procedure SendCmd2IPC4ReplyMail_WS(AEntryId, AStoreId: string; AMailType: integer; ATask: TSQLGSTask;
  ASettings: TConfigSettings);
procedure SendCmd2IPC4CreateMail_WS(AGrid: TNextGrid; ARow, AMailType: integer;
  ATask: TSQLGSTask; ASettings: TConfigSettings; AToMailAddr: string);
procedure SendCmd2IPC4ForwardMail_WS(AEntryId, AStoreId: string; AMailType: integer; ATask: TSQLGSTask;
  ASettings: TConfigSettings);
procedure SendCmd2IPC4ViewEmailFromGrid(AGrid: TNextGrid; ARow: integer=-1);
function SendCmd2IPC4MoveFolderEmail_WS(AOriginalEntryId, AOriginalStoreId,
  AMoveStoreId, AMoveStorePath: string; ATask: TSQLGSTask; ASubFolderName: string): boolean;
procedure SendCmd2IPC4ViewEmailFromMsgFile_WS(AFileName: string);
function SendReqOLEmailInfo2_WS(AGrid: TNextGrid; ATask: TSQLGSTask; var AResultList: TStringList): boolean;
function SendReqAddAppointment_WS(AJsonpjhTodoItem: string): boolean;
function SendReqOLEmailAccountInfo_WS: TOLAccountInfo;
function GetClientWS: TRestHttpClientWebsockets;
{$ENDIF}

function SendReqOLEmail2MagFile(ACommand: string): RawUTF8;

function SendCmd_GetTaskList2Json(ASearchCondRec: string): RawUTF8;

//function ProcessTaskJson(AJson: String): Boolean;

procedure ShowEmailListFromIDs(AGrid: TNextGrid; AIDs: TIDDynArray);
procedure ShowEmailListFromJson(AGrid: TNextGrid; AJson: RawUTF8);

implementation

uses mormot.core.mustache,
  {$IFDEF GAMANAGER}
  UnitHiconisASVarJsonUtil, UnitElecServiceData2, UnitMakeReport2,//FrmGATaskEdit,
  {$ELSE}
  TaskForm, UnitVariantJsonUtil2, UnitElecServiceData, UnitMakeReport2,
  {$ENDIF}
  UnitStringUtil;

procedure SendCmd2IPC4ReplyMail(AEntryId, AStoreId: string; AMailType: integer; ATask: TSQLGSTask;
  ASettings: TConfigSettings);
begin
//  SendCmd2IPC4ReplyMail_CromisIPC(AGrid, ARow, AMailType,ATask);
{$IFDEF USE_MORMOT_WS}
  if g_MyEmailInfo.SmtpAddress = '' then
    g_MyEmailInfo := SendReqOLEmailAccountInfo_WS;

  SendCmd2IPC4ReplyMail_WS(AEntryId, AStoreId, AMailType, ATask,
    ASettings);
{$ENDIF}
end;

procedure SendCmd2IPC4ViewEmail(AGrid: TNextGrid; ARow: integer);
begin
//  SendCmd2IPC4ViewEmail_CromisIPC(AGrid, ARow);
{$IFDEF USE_MORMOT_WS}
  SendCmd2IPC4ViewEmailFromGrid(AGrid, ARow);
{$ENDIF}
end;

procedure SendCmd2IPC4CreateMail(AGrid: TNextGrid; ARow, AMailType: integer;
  ATask: TSQLGSTask; ASettings: TConfigSettings; AToMailAddr: string);
begin
//  SendCmd2IPC4CreateMail_CromisIPC(AGrid, ARow, AMailType, ATask);
{$IFDEF USE_MORMOT_WS}
  if g_MyEmailInfo.SmtpAddress = '' then
    g_MyEmailInfo := SendReqOLEmailAccountInfo_WS;

  SendCmd2IPC4CreateMail_WS(AGrid, ARow, AMailType, ATask,
    ASettings, AToMailAddr);
{$ENDIF}
end;

procedure SendCmd2IPC4ForwardMail(AEntryId, AStoreId: string; AMailType: integer; ATask: TSQLGSTask;
  ASettings: TConfigSettings);
begin
{$IFDEF USE_MORMOT_WS}
  if g_MyEmailInfo.SmtpAddress = '' then
    g_MyEmailInfo := SendReqOLEmailAccountInfo_WS;

  SendCmd2IPC4ForwardMail_WS(AEntryId, AStoreId, AMailType, ATask,
    ASettings);
{$ENDIF}
end;

function SendCmd2IPC4MoveFolderEmail(AOriginalEntryId, AOriginalStoreId,
  AMoveStoreId, AMoveStorePath: string; ATask: TSQLGSTask; ASubFolderName: string): boolean;
begin
//  SendCmd2IPC4MoveFolderEmail_CromisIPC(AOriginalEntryId, AOriginalStoreId,
//    AMoveStoreId, AMoveStorePath, ATask);
{$IFDEF USE_MORMOT_WS}
  Result := SendCmd2IPC4MoveFolderEmail_WS(AOriginalEntryId, AOriginalStoreId,
    AMoveStoreId, AMoveStorePath, ATask, ASubFolderName);
{$ENDIF}
end;

function SendReqOLEmailInfo2(AGrid: TNextGrid; ATask: TSQLGSTask; var AResultList: TStringList): boolean;
begin
//  SendReqOLEmailInfo2_CromisIPC(AGrid, ATask, AResultList);
{$IFDEF USE_MORMOT_WS}
  Result := SendReqOLEmailInfo2_WS(AGrid, ATask, AResultList);
{$ENDIF}
end;

//procedure SendCmd2IPC4ReplyMail_CromisIPC(AGrid: TNextGrid; ARow, AMailType: integer;
//  ATask: TSQLGSTask; ASettings: TConfigSettings);
//var
//  Request: IIPCData;
//  Result: IIPCData;
//  LStrList: TStringList;
//  LEntryId, LStoreId: string;
//begin
//  LStrList := TStringList.Create;
//  try
//    LStrList.Add('ServerName='+IPC_SERVER_NAME_4_OUTLOOK);
//    LStrList.Add('Command='+CMD_REQ_REPLY_MAIL);
//    LEntryId := AGrid.CellByName['EntryId', ARow].AsString;
//    LStoreId := AGrid.CellByName['StoreId', ARow].AsString;
//    LStrList.Add('EntryId='+LEntryId);
//    LStrList.Add('StoreId='+LStoreId);
//    LStrList.Add('HTMLBody='+MakeEmailHTMLBody(
//      ATask, AMailType, ASettings.SalesPICSig, ASettings.ShippingPICSig,
//      ASettings.FieldServicePICSig, ASettings.ElecHullRegPICSig, ASettings.MyNameSig));
//
//    Request := AcquireIPCData;
//    Request.ID := DateTimeToStr(Now);
//    Request.Data.WriteUTF8String(CMD_LIST,LStrList.Text);
//
//    Result := g_IPCClient.ExecuteConnectedRequest(Request);
//
//    if g_IPCClient.AnswerValid then
//    begin
////      ShowMessage(LEntryId + '=' + LStoreId);
////      ShowMessage('IPCClient.AnswerValid');
//    end;
//  finally
//    LStrList.Free;
//  end;
//end;
//
//procedure SendCmd2IPC4CreateMail_CromisIPC(AGrid: TNextGrid; ARow, AMailType: integer;
//  ATask: TSQLGSTask; ASettings: TConfigSettings; AMailAddr: string);
//var
//  Request: IIPCData;
//  Result: IIPCData;
//  LStrList: TStringList;
//  LEntryId, LStoreId: string;
//begin
//  LStrList := TStringList.Create;
//  try
//    LStrList.Add('ServerName='+IPC_SERVER_NAME_4_OUTLOOK2);
//    LStrList.Add('Command='+CMD_REQ_CREATE_MAIL);
//    LEntryId := AGrid.CellByName['EntryId', ARow].AsString;
//    LStoreId := AGrid.CellByName['StoreId', ARow].AsString;
//    LStrList.Add('EntryId='+LEntryId);
//    LStrList.Add('StoreId='+LStoreId);
//    LStrList.Add('Subject='+MakeMailSubject(ATask, AMailType));
//    LStrList.Add('To='+ AMailAddr);//GetRecvEmailAddress(AMailType));
//    LStrList.Add('HTMLBody='+MakeEmailHTMLBody(ATask,AMailType, ASettings.SalesPICSig,
//      ASettings.ShippingPICSig, ASettings.FieldServicePICSig, ASettings.ElecHullRegPICSig, ASettings.MyNameSig));
//
//    Request := AcquireIPCData;
//    Request.ID := DateTimeToStr(Now);
//    Request.Data.WriteUTF8String(CMD_LIST,LStrList.Text);
//
//    Result := g_IPCClient.ExecuteConnectedRequest(Request);
//
//    if g_IPCClient.AnswerValid then
//    begin
////      ShowMessage(LEntryId + '=' + LStoreId);
////      ShowMessage('IPCClient.AnswerValid');
//    end;
//  finally
//    LStrList.Free;
//  end;
//end;
//
//procedure SendCmd2IPC4ViewEmail_CromisIPC(AGrid: TNextGrid; ARow: integer);
//var
//  Request: IIPCData;
//  Result: IIPCData;
//  LStrList: TStringList;
//  LEntryId, LStoreId: string;
//begin
//  LStrList := TStringList.Create;
//  try
//    LStrList.Add('ServerName='+IPC_SERVER_NAME_4_OUTLOOK);
//    LStrList.Add('Command='+CMD_REQ_MAIL_VIEW);
//    LEntryId := AGrid.CellByName['EntryId', ARow].AsString;
//    LStoreId := AGrid.CellByName['StoreId', ARow].AsString;
//    LStrList.Add('EntryId='+LEntryId);
//    LStrList.Add('StoreId='+LStoreId);
//
//    Request := AcquireIPCData;
//    Request.ID := DateTimeToStr(Now);
//    Request.Data.WriteUTF8String(CMD_LIST,LStrList.Text);
//
//    Result := g_IPCClient.ExecuteConnectedRequest(Request);
//
//    if g_IPCClient.AnswerValid then
//    begin
////      ShowMessage(LEntryId + '=' + LStoreId);
////      ShowMessage('IPCClient.AnswerValid');
//    end;
//  finally
//    LStrList.Free;
//  end;
//end;
//
//function SendCmd2IPC4MoveFolderEmail_CromisIPC(AOriginalEntryId, AOriginalStoreId,
//  AMoveStoreId, AMoveStorePath: string; ATask: TSQLGSTask): boolean;
//var
//  IPCClient: TIPCClient;
//  Request: IIPCData;
//  LIPCResult: IIPCData;
//  LStrList: TStringList;
//  LEntryId, LStoreId: string;
//  Command: AnsiString;
//  LEmailMsg: TSQLEmailMsg;
//  LIds: TIDDynArray;
//begin
//  LStrList := TStringList.Create;
//  IPCClient := TIPCClient.Create;
//  try
//    IPCClient.ServerName := IPC_SERVER_NAME_4_OUTLOOK2;
//    LStrList.Add('ServerName='+IPC_SERVER_NAME_4_OUTLOOK2);
//    LStrList.Add('Command='+CMD_REQ_MOVE_FOLDER_MAIL);
////    LEntryId := AGrid.CellByName['EntryId', ARow].AsString;
////    LStoreId := AGrid.CellByName['StoreId', ARow].AsString;
//    LEntryId := AOriginalEntryId;
//    LStoreId := AOriginalStoreId;
//    LStrList.Add('EntryId='+LEntryId);
//    LStrList.Add('StoreId='+LStoreId);
//    LStrList.Add('MoveStoreId='+AMoveStoreId);//AFolderList.ValueFromIndex[AFolderIndex]);
//    LStrList.Add('MoveStorePath='+AMoveStorePath);//AFolderList.Names[AFolderIndex]);
//
//    if Assigned(ATask) then
//      LStrList.Add('HullNo='+ATask.HullNo);
//
//    LStrList.Add('IsCreateHullNoFolder='+'True');
//
//    Request := AcquireIPCData;
//    Request.ID := DateTimeToStr(Now);
//    Request.Data.WriteUTF8String(CMD_LIST,LStrList.Text);
//    LIPCResult := IPCClient.ExecuteRequest(Request);
//
//    if IPCClient.AnswerValid then
//    begin
//      LStrList.Clear;
//      LStrList.Text := LIPCResult.Data.ReadUTF8String(CMD_LIST);
//      Command := LStrList.Values['Command'];
//
//      if Command = CMD_RESPONDE_MOVE_FOLDER_MAIL then
//      begin
//        LEmailMsg := TSQLEmailMsg.CreateAndFillPrepare(g_ProjectDB,
//            'EntryID = ? AND StoreID = ?', [LEntryId,LStoreId]);
//
//        try
//          if LEmailMsg.FillOne then
//          begin
//            LEmailMsg.EntryID := LStrList.Values['NewEntryId'];
//            LEmailMsg.StoreID := LStrList.Values['MovedStoreId'];
//            g_ProjectDB.Update(LEmailMsg);
//            Result := True;
////            if not AIsMultiDrop then
////              ShowMessage('Email move to folder( ' + AMoveStorePath + ' ) completed!');
////            ATask.EmailMsg.DestGet(g_ProjectDB, ATask.ID, LIds);
////            ShowEmailListFromIDs(AGrid, LIds, ATask, AMoveStoreId, AMoveStorePath);
//          end;
//        finally
//          FreeAndNil(LEmailMsg);
//        end;
//      end;
//    end;
//  finally
//    IPCClient.Free;
//    LStrList.Free;
//  end;
//end;
//
//function SendReqOLEmailInfo2_CromisIPC(AGrid: TNextGrid; ATask: TSQLGSTask; var AResultList: TStringList): boolean;
//var
//  IPCClient: TIPCClient;
//  LStrList: TStringList;
//  Request: IIPCData;
//  IPCResult: IIPCData;
//  Command: AnsiString;
//  LEmailMsg,
//  LEmailMsg2: TSQLEmailMsg;
//  LTask: TSQLGSTask;
//  LJson: string;
//  LVarArr: TVariantDynArray;
//  i: integer;
//begin
//  IPCClient := TIPCClient.Create;
//  LStrList := TStringList.Create;
//  LEmailMsg := TSQLEmailMsg.Create;
//  try
//    IPCClient.ServerName := IPC_SERVER_NAME_4_OUTLOOK2;
//    LStrList.Add('ServerName='+IPC_SERVER_NAME_4_OUTLOOK2);
//    LStrList.Add('Command='+CMD_REQ_MAILINFO_SEND2);
//
//    Request := AcquireIPCData;
//    Request.ID := DateTimeToStr(Now);
//    Request.Data.WriteUTF8String(CMD_LIST,LStrList.Text);
////    IPCResult := IPCClient.ExecuteConnectedRequest(Request);
//    IPCResult := IPCClient.ExecuteRequest(Request);
//
//    if IPCClient.AnswerValid then
//    begin
//      LStrList.Clear;
//      LStrList.Text := IPCResult.Data.ReadUTF8String(CMD_LIST);
//      Command := LStrList.Values['Command'];
//
//      if Command = CMD_SEND_MAIL_ENTRYID2 then
//      begin
//        LJson := LStrList.Values['MailInfos'];
////        ShowMessage(LJson);
//        LVarArr := JSONToVariantDynArray(LJson);
//
//        for i := 0 to High(LVarArr) do
//        begin
////          ShowMessage(LVarArr[i].EntryId);
//          LEmailMsg.EntryID := LVarArr[i].EntryId;
//          LEmailMsg.StoreID := LVarArr[i].StoreId;
//
//          if (LEmailMsg.EntryID <> '') and (LEmailMsg.StoreID <> '') then
//          begin
//            LEmailMsg2 := TSQLEmailMsg.Create(g_ProjectDB,
//              'EntryID = ? AND StoreID = ?', [LEmailMsg.EntryID,LEmailMsg.StoreID]);
//
//            try
//              //�����Ͱ� ������
//  //            if LEmailMsg.ID = 0 then
//              if not LEmailMsg2.FillOne then
//              begin
//                LEmailMsg2.EntryID := LVarArr[i].EntryId;
//                LEmailMsg2.StoreID := LVarArr[i].StoreId;
//                LEmailMsg2.Sender := LVarArr[i].Sender;
//                LEmailMsg2.Receiver := LVarArr[i].Receiver;
//                LEmailMsg2.CarbonCopy := LVarArr[i].CC;
//                LEmailMsg2.BlindCC := LVarArr[i].BCC;
//                LEmailMsg2.Subject := LVarArr[i].Subject;
//                LEmailMsg2.RecvDate := TimeLogFromDateTime(StrToDateTime(LVarArr[i].RecvDate));
//
//                g_ProjectDB.Add(LEmailMsg2, true);
//                ATask.EmailMsg.ManyAdd(g_ProjectDB, ATask.ID, LEMailMsg2.ID, True);
//                AResultList.Add(LEmailMsg2.EntryID + '=' + LEmailMsg2.StoreID);
//                Result := True;
//              end;
//            finally
//              FreeAndNil(LEmailMsg2);
//            end;
//          end;
//        end;//for
//      end;
//    end;
//  finally
//    FreeAndNil(LEmailMsg);
//    LStrList.Free;
//    IPCClient.DisconnectClient;
//    IPCClient.Free;
//  end;
//end;

{$IFDEF USE_MORMOT_WS}
procedure SendCmd2IPC4ReplyMail_WS(AEntryId, AStoreId: string; AMailType: integer;
  ATask: TSQLGSTask; ASettings: TConfigSettings);
var
  Client: TRestHttpClientWebsockets;
  Service: IOLMailService;
  LStrList: TStringList;
  LCommand, LRespond, LFileName: string;
begin
  LStrList := TStringList.Create;
  try
    LStrList.Add('ServerName='+IPC_SERVER_NAME_4_OUTLOOK);
    LStrList.Add('Command='+CMD_REQ_REPLY_MAIL);
    LStrList.Add('EntryId='+AEntryId);
    LStrList.Add('StoreId='+AStoreId);
    LStrList.Add('HTMLBody='+MakeEmailHTMLBody(ATask, AMailType, ASettings.SalesPICSig,
      ASettings.ShippingPICSig, ASettings.FieldServicePICSig,
      ASettings.ElecHullRegPICSig, ASettings.MyNameSig));


    if AMailType = 8 then
    begin
      LStrList.Add('TaskInfoAttached='+MakeTaskInfoEmailAttached(ATask, LFileName));
      LStrList.Add('AttachedFileName='+'.\'+LFileName);
    end;

    LCommand := LStrList.Text;
    Client := GetClientWS;
    try
      if not Client.Services.Resolve(IOLMailService,Service) then
        raise EServiceException.Create('Service IOLMailService unavailable');

      LRespond := Service.GetOLEmailInfo(LCommand);
    finally
      Service := nil;
      Client.Free;
    end;
  finally
    LStrList.Free;
  end;
end;

procedure SendCmd2IPC4CreateMail_WS(AGrid: TNextGrid; ARow, AMailType: integer;
  ATask: TSQLGSTask; ASettings: TConfigSettings; AToMailAddr: string);
var
  Client: TRestHttpClientWebsockets;
  Service: IOLMailService;
  LStrList: TStringList;
  LEntryId, LStoreId: string;
  LCommand, LRespond, LFileName: string;
begin
  LStrList := TStringList.Create;
  try
    LStrList.Add('ServerName='+IPC_SERVER_NAME_4_OUTLOOK2);
    LStrList.Add('Command='+CMD_REQ_CREATE_MAIL);

    if Assigned(AGrid) then
    begin
      LEntryId := AGrid.CellByName['EntryId', ARow].AsString;
      LStoreId := AGrid.CellByName['StoreId', ARow].AsString;
      LStrList.Add('EntryId='+LEntryId);
      LStrList.Add('StoreId='+LStoreId);
    end;

    LStrList.Add('Subject='+MakeMailSubject(ATask, AMailType));
    LStrList.Add('To='+AToMailAddr);//GetRecvEmailAddress(AMailType));
    LStrList.Add('HTMLBody='+MakeEmailHTMLBody(ATask,AMailType, ASettings.SalesPICSig,
      ASettings.ShippingPICSig, ASettings.FieldServicePICSig, ASettings.ElecHullRegPICSig,
      ASettings.MyNameSig));

    if AMailType = 8 then
    begin
      LStrList.Add('TaskInfoAttached='+MakeTaskInfoEmailAttached(ATask, LFileName));
      LStrList.Add('AttachedFileName='+'.\'+LFileName);
    end;

    LCommand := LStrList.Text;

    Client := GetClientWS;
    try
      if not Client.Services.Resolve(IOLMailService,Service) then
        raise EServiceException.Create('Service IOLMailService unavailable');

      LRespond := Service.GetOLEmailInfo(LCommand);
    finally
      Service := nil;
      Client.Free;
    end;
  finally
    LStrList.Free;
  end;
end;

procedure SendCmd2IPC4ForwardMail_WS(AEntryId, AStoreId: string; AMailType: integer; ATask: TSQLGSTask;
  ASettings: TConfigSettings);
var
  Client: TRestHttpClientWebsockets;
  Service: IOLMailService;
  LStrList: TStringList;
  LCommand, LRespond, LFileName: string;
begin
  LStrList := TStringList.Create;
  try
    LStrList.Add('ServerName='+IPC_SERVER_NAME_4_OUTLOOK);
    LStrList.Add('Command='+CMD_REQ_FORWARD_MAIL);
    LStrList.Add('EntryId='+AEntryId);
    LStrList.Add('StoreId='+AStoreId);
    LStrList.Add('HTMLBody='+MakeEmailHTMLBody(ATask, AMailType, ASettings.SalesPICSig,
      ASettings.ShippingPICSig, ASettings.FieldServicePICSig,
      ASettings.ElecHullRegPICSig, ASettings.MyNameSig));


    if AMailType = 8 then
    begin
      LStrList.Add('TaskInfoAttached='+MakeTaskInfoEmailAttached(ATask, LFileName));
      LStrList.Add('AttachedFileName='+'.\'+LFileName);
    end;

    LCommand := LStrList.Text;
    Client := GetClientWS;
    try
      if not Client.Services.Resolve(IOLMailService,Service) then
        raise EServiceException.Create('Service IOLMailService unavailable');

      LRespond := Service.GetOLEmailInfo(LCommand);
    finally
      Service := nil;
      Client.Free;
    end;
  finally
    LStrList.Free;
  end;
end;

function SendCmd2IPC4MoveFolderEmail_WS(AOriginalEntryId, AOriginalStoreId,
  AMoveStoreId, AMoveStorePath: string; ATask: TSQLGSTask; ASubFolderName: string): boolean;
var
  Client: TRestHttpClientWebsockets;
  Service: IOLMailService;
  LStrList: TStringList;
  LEntryId, LStoreId: string;
  LEmailMsg: TSQLEmailMsg;
  LCommand, LRespond: string;
  LIds: TIDDynArray;
begin
  LStrList := TStringList.Create;
  try
    LStrList.Add('ServerName='+IPC_SERVER_NAME_4_OUTLOOK2);
    LStrList.Add('Command='+CMD_REQ_MOVE_FOLDER_MAIL);
    LEntryId := AOriginalEntryId;
    LStoreId := AOriginalStoreId;
    LStrList.Add('EntryId='+LEntryId);
    LStrList.Add('StoreId='+LStoreId);
    LStrList.Add('MoveStoreId='+AMoveStoreId);//AFolderList.ValueFromIndex[AFolderIndex]);
    LStrList.Add('MoveStorePath='+AMoveStorePath);//AFolderList.Names[AFolderIndex]);

    if Assigned(ATask) then
      LStrList.Add('HullNo='+ATask.HullNo);

    LStrList.Add('IsCreateHullNoFolder='+'True');
    LStrList.Add('SubFolderName=' + ASubFolderName);
    LCommand := LStrList.Text;

    Client := GetClientWS;
    try
      if not Client.Services.Resolve(IOLMailService,Service) then
        raise EServiceException.Create('Service IOLMailService unavailable');

      LRespond := Service.ServerExecute(LCommand);
    finally
      Service := nil;
      Client.Free;
    end;

    if LRespond <> '' then
    begin
      LStrList.Clear;
      LStrList.Text := LRespond;
      LCommand := LStrList.Values['Command'];

      if LCommand = CMD_RESPONDE_MOVE_FOLDER_MAIL then
      begin
        LEmailMsg := TSQLEmailMsg.CreateAndFillPrepare(g_ProjectDB.Orm,
            'EntryID = ? AND StoreID = ?', [LEntryId,LStoreId]);

        try
          if LEmailMsg.FillOne then
          begin
            LEmailMsg.EntryID := LStrList.Values['NewEntryId'];
            LEmailMsg.StoreID := LStrList.Values['MovedStoreId'];
            LEmailMsg.SavedOLFolderPath := LStrList.Values['MovedFolderPath'];
            g_ProjectDB.Update(LEmailMsg);
            Result := True;
          end;
        finally
          FreeAndNil(LEmailMsg);
        end;
      end;
    end;
  finally
    LStrList.Free;
  end;
end;

procedure SendCmd2IPC4ViewEmailFromMsgFile_WS(AFileName: string);
var
  Client: TRestHttpClientWebsockets;
  Service: IOLMailService;
  LStrList: TStringList;
  LEntryId, LStoreId: string;
  LCommand, LRespond: string;
begin
  LStrList := TStringList.Create;
  try
    LStrList.Add('ServerName='+IPC_SERVER_NAME_4_OUTLOOK);
    LStrList.Add('Command='+CMD_REQ_MAIL_VIEW_FROM_MSGFILE);
    LStrList.Add('FileName='+AFileName);
    LCommand := LStrList.Text;

    Client := GetClientWS;
    try
      if not Client.Services.Resolve(IOLMailService,Service) then
        raise EServiceException.Create('Service IOLMailService unavailable');

      LRespond := Service.GetOLEmailInfo(LCommand);
    finally
      Service := nil;
      FreeAndNil(Client);
    end;
  finally
    LStrList.Free;
  end;
end;

function SendReqOLEmailInfo2_WS(AGrid: TNextGrid; ATask: TSQLGSTask; var AResultList: TStringList): boolean;
var
  Client: TRestHttpClientWebsockets;
  Service: IOLMailService;
  LStrList: TStringList;
  LCommand, LRespond: String;
  LEmailMsg,
  LEmailMsg2: TSQLEmailMsg;
  LTask: TSQLGSTask;
  LJson: string;
  LVarArr: TVariantDynArray;
  i: integer;
begin
  LStrList := TStringList.Create;
  LEmailMsg := TSQLEmailMsg.Create;
  try
    LStrList.Add('ServerName='+IPC_SERVER_NAME_4_OUTLOOK2);
    LStrList.Add('Command='+CMD_REQ_MAILINFO_SEND2);
    LCommand := LStrList.Text;

    Client := GetClientWS;
    try
      if not Client.Services.Resolve(IOLMailService,Service) then
        raise EServiceException.Create('Service IOLMailService unavailable');

      LRespond := Service.ServerExecute(LCommand);
    finally
      Service := nil;
      Client.Free;
    end;


    if LRespond <> '' then
    begin
      LStrList.Clear;
      LStrList.Text := LRespond;
      LCommand := LStrList.Values['Command'];

      if LCommand = CMD_SEND_MAIL_ENTRYID2 then
      begin
        LJson := LStrList.Values['MailInfos'];
        LVarArr := JSONToVariantDynArray(LJson);

        for i := 0 to High(LVarArr) do
        begin
          LEmailMsg.EntryID := LVarArr[i].EntryId;
          LEmailMsg.StoreID := LVarArr[i].StoreId;

          if (LEmailMsg.EntryID <> '') and (LEmailMsg.StoreID <> '') then
          begin
            LEmailMsg2 := TSQLEmailMsg.Create(g_ProjectDB.Orm,
              'EntryID = ? AND StoreID = ?', [LEmailMsg.EntryID,LEmailMsg.StoreID]);

            try
              //�����Ͱ� ������
  //            if LEmailMsg.ID = 0 then
              if not LEmailMsg2.FillOne then
              begin
                LEmailMsg2.EntryID := LVarArr[i].EntryId;
                LEmailMsg2.StoreID := LVarArr[i].StoreId;
                LEmailMsg2.Sender := LVarArr[i].Sender;
                LEmailMsg2.Receiver := LVarArr[i].Receiver;
                LEmailMsg2.CarbonCopy := LVarArr[i].CC;
                LEmailMsg2.BlindCC := LVarArr[i].BCC;
                LEmailMsg2.Subject := LVarArr[i].Subject;
                LEmailMsg2.SavedOLFolderPath := LVarArr[i].FolderPath;
                LEmailMsg2.RecvDate := TimeLogFromDateTime(StrToDateTime(LVarArr[i].RecvDate));

                g_ProjectDB.Add(LEmailMsg2, true);
                ATask.EmailMsg.ManyAdd(g_ProjectDB.Orm, ATask.ID, LEMailMsg2.ID, True);
                AResultList.Add(LEmailMsg2.EntryID + '=' + LEmailMsg2.StoreID);
                Result := True;
              end;
            finally
              FreeAndNil(LEmailMsg2);
            end;
          end;
        end;//for
      end;
    end;
  finally
    FreeAndNil(LEmailMsg);
    LStrList.Free;
  end;
end;

function SendReqAddAppointment_WS(AJsonpjhTodoItem: string): boolean;
var
  Client: TRestHttpClientWebsockets;
  Service: IOLMailService;
  LCommand, LRespond: String;
  LStrList: TStringList;
begin
  LStrList := TStringList.Create;
  try
    LStrList.Add('ServerName='+IPC_SERVER_NAME_4_OUTLOOK2);
    LStrList.Add('Command='+CMD_REQ_ADD_APPOINTMENT);
    LStrList.Add('TodoItemsJson='+AJsonpjhTodoItem);
    LCommand := LStrList.Text;

    Client := GetClientWS;
    try
      if not Client.Services.Resolve(IOLMailService,Service) then
        raise EServiceException.Create('Service IOLMailService unavailable');

      LRespond := Service.ServerExecute(LCommand);
    finally
      Service := nil;
      Client.Free;
    end;
  finally
    LStrList.Free;
  end;
end;

function SendReqOLEmailAccountInfo_WS: TOLAccountInfo;
var
  Client: TRestHttpClientWebsockets;
  Service: IOLMailService;
  LRespond: String;
begin
  Client := GetClientWS;
  try
    if not Client.Services.Resolve(IOLMailService,Service) then
      raise EServiceException.Create('Service IOLMailService unavailable');

    LRespond := Service.GetOLEmailAccountInfo;
    RecordLoadJson(Result, Lrespond, TypeInfo(TOLAccountInfo));
  finally
    Service := nil;
    Client.Free;
  end;
end;

function GetClientWS: TRestHttpClientWebsockets;
begin
  Result := TRestHttpClientWebsockets.Create('127.0.0.1',OL_PORT_NAME_4_WS, TSQLModel.Create([]));
  Result.Model.Owner := Result;
  Result.WebSocketsUpgrade(OL4WS_TRANSMISSION_KEY);

  if not Result.ServerTimeStampSynchronize then
    raise EServiceException.Create(
      'Error connecting to the server: please run InqManage.exe');
  Result.ServiceDefine([IOLMailService], sicShared);//sicClientDriven
end;
{$ENDIF}

procedure SendCmd2IPC4ViewEmailFromGrid(AGrid: TNextGrid; ARow: integer);
var
  LEntryId, LStoreId: string;
  LWSInfoRec: TWSInfoRec;
begin
  if ARow = -1 then
    ARow := AGrid.SelectedRow;

  LEntryId := AGrid.CellByName['EntryId', ARow].AsString;
  LStoreId := AGrid.CellByName['StoreId', ARow].AsString;

{$IFDEF USE_MORMOT_WS}
  SendCmd2OL4ViewEmail_WS(LEntryId, LStoreId, LWSInfoRec);
{$ENDIF}
end;


//GUID�� �� Temp ������ ����� *.msg ���� �̸��� ��ȯ��
//ACommand: {"EntryID":xxx, "StoreID":xxxx} �������� �����
function SendReqOLEmail2MagFile(ACommand: string): RawUTF8;
var
{$IFDEF USE_MORMOT_WS}
  Client: TRestHttpClientWebsockets;
  Service: IOLMailService;
{$ENDIF}
  LCommand, LEntryId, LStoreId: String;
  LStrList: TStringList;
  LDoc: variant;
begin
  LStrList := TStringList.Create;
  try
    LDoc := _JSON(ACommand);
    LEntryId := LDoc.EntryId;
    LStoreId := LDoc.StoreId;
    LStrList.Add('ServerName='+IPC_SERVER_NAME_4_OUTLOOK2);
    LStrList.Add('Command='+CMD_SEND_MAIL_2_MSGFILE);
    LStrList.Add('EntryId='+LEntryId);
    LStrList.Add('StoreId='+LStoreId);
    LCommand := LStrList.Text;

{$IFDEF USE_MORMOT_WS}
    Client := GetClientWS;
    try
      if not Client.Services.Resolve(IOLMailService,Service) then
        raise EServiceException.Create('Service IInqManageService unavailable');

      Result := Service.ServerExecute(LCommand);
    finally
      Service := nil;
      Client.Free;
    end;
{$ENDIF}
  finally
    LStrList.Free;
  end;
end;

function SendCmd_GetTaskList2Json(ASearchCondRec: string): RawUTF8;
var
{$IFDEF USE_MORMOT_WS}
  Client: TRestHttpClientWebsockets;
  Service: IInqManageService;
{$ENDIF}
  LCommand: String;
  LStrList: TStringList;
begin
  LStrList := TStringList.Create;
  try
    LStrList.Add('ServerName='+IPC_SERVER_NAME_4_OUTLOOK2);
    LStrList.Add('Command='+CMD_REQ_TASK_LIST);
    LStrList.Add('SearchConditionJson='+ASearchCondRec);
    LCommand := LStrList.Text;

{$IFDEF USE_MORMOT_WS}
    Client := GetClientWS;
    try
      if not Client.Services.Resolve(IInqManageService,Service) then
        raise EServiceException.Create('Service IInqManageService unavailable');

      Result := Service.ServerExecute(LCommand);
//      Syncommons.RecordLoadJson(Result, Lrespond, TypeInfo(TOLAccountInfo));
    finally
      Service := nil;
      Client.Free;
    end;
{$ENDIF}
  finally
    LStrList.Free;
  end;
end;


//function ProcessTaskJson(AJson: String): Boolean;
//var
//  LDoc: variant;
//  LTask: TSQLGSTask;
//  LUTF8: RawUTF8;
//  LRaw: RawByteString;
//  LHullNo, LPONO, LOrderNo: string;
//  LIsFromInvoiceManage: Boolean;
//begin
//  TDocVariant.New(LDoc);
//  LRaw := Base64ToBin(StringToUTF8(AJson));
//  LRaw := SynLZDecompress(LRaw);
//  LUTF8 := LRaw;
//  LDoc := _JSON(LUTF8);
//
//  try
//    Result := LDoc.TaskJsonDragSign = TASK_JSON_DRAG_SIGNATURE;
//  except
//  end;
//
//  if not Result then
//  begin
//    //InvoiceManage.exe���� ������� *.hgs ������ ���
//    try
//      Result := LDoc.InvoiceTaskJsonDragSign = INVOICETASK_JSON_DRAG_SIGNATURE;
//    except
//    end;
//  end;
//
//  if Result then
//  begin
//    LIsFromInvoiceManage := LDoc.InvoiceTaskJsonDragSign = INVOICETASK_JSON_DRAG_SIGNATURE;
//
//    LHullNo := LDoc.Task.HullNo;
//
//    try
//      LOrderNo := LDoc.Task.Order_No;
//    except
//      LOrderNo := '';
//    end;
//
//    if LOrderNo = '' then
//    begin
//      try
//        LPONO := LDoc.Task.PO_No;
//      except
//        LPONO := '';
//      end;
//
//      LTask := GetTaskFromHullNoNPONo(LHullNo, LPONO);
//    end
//    else
//    begin
//     LTask :=  GetTaskFromHullNoNOrderNo(LHullNo, LOrderNo);
//    end;
//
//    try
//    {$IFDEF GAMANAGER}
//      FrmGATaskEdit.DisplayTaskInfo2EditForm(LTask, nil, LDoc, LIsFromInvoiceManage);
//    {$ELSE}
//      TaskForm.DisplayTaskInfo2EditForm(LTask, nil, LDoc, LIsFromInvoiceManage);
//    {$ENDIF}
//    finally
//      FreeAndNil(LTask);
//    end;
//  end
//  else
//    ShowMessage('Signature is not correct');
//end;

procedure ShowEmailListFromIDs(AGrid: TNextGrid; AIDs: TIDDynArray);
var
  LSQLEmailMsg: TSQLEmailMsg;
  LRow: integer;
  LStr: string;
begin
  LSQLEmailMsg:= TSQLEmailMsg.CreateAndFillPrepare(g_ProjectDB.Orm, AIDs);
  AGrid.BeginUpdate;
  try
    with AGrid do
    begin
      ClearRows;

      while LSQLEmailMsg.FillOne do
      begin
        LRow := AddRow;
        CellByName['Subject', LRow].AsString := LSQLEmailMsg.Subject;
        CellByName['RecvDate', LRow].AsDateTime := TimeLogToDateTime(LSQLEmailMsg.RecvDate);
        CellByName['Sender', LRow].AsString := LSQLEmailMsg.Sender;
        CellByName['Receiver', LRow].AsString := LSQLEmailMsg.Receiver;
        CellByName['CC', LRow].AsString := LSQLEmailMsg.CarbonCopy;
        CellByName['BCC', LRow].AsString := LSQLEmailMsg.BlindCC;
        CellByName['EMailId', LRow].AsString := IntToStr(LSQLEmailMsg.ID);
        CellByName['EntryId', LRow].AsString := LSQLEmailMsg.EntryID;
        CellByName['StoreId', LRow].AsString := LSQLEmailMsg.StoreID;
        CellByName['FolderPath', LRow].AsString := LSQLEmailMsg.SavedOLFolderPath;

        if LSQLEmailMsg.ContainData <> cdmNone then
        begin
          LStr := TRttiEnumerationType.GetName<TContainData4Mail>(LSQLEmailMsg.ContainData);
          CellByName['ContainData', LRow].AsString := LStr;
        end;

        if LSQLEmailMsg.ParentID = '' then
        begin
          MoveRow(LRow, 0);
          LRow := 0;
        end;
      end;
    end;
  finally
    AGrid.EndUpdate;
    FreeAndNil(LSQLEmailMsg);

//    if (AutoMoveCB.Checked) and (MoveFolderCB.ItemIndex > -1) then
//      SendCmd2IPC4MoveFolderEmail(LRow, MoveFolderCB.ItemIndex);
  end;
end;

procedure ShowEmailListFromJson(AGrid: TNextGrid; AJson: RawUTF8);
var
  LDocData: TDocVariantData;
  LVar: variant;
  LStr: string;
  i, LRow: integer;
begin
  //AJson = [] ������ Email List��
  LDocData.InitJSON(AJson);
  AGrid.BeginUpdate;
  try
    with AGrid do
    begin
      ClearRows;

      for i := 0 to LDocData.Count - 1 do
      begin
        LVar := _JSON(LDocData.Value[i]);
        LRow := AddRow;

        CellByName['Subject', LRow].AsString := LVar.Subject;
        CellByName['RecvDate', LRow].AsDateTime := TimeLogToDateTime(LVar.RecvDate);
        CellByName['Sender', LRow].AsString := LVar.Sender;
        CellByName['Receiver', LRow].AsString := LVar.Receiver;
        CellByName['CC', LRow].AsString := LVar.CarbonCopy;
        CellByName['BCC', LRow].AsString := LVar.BlindCC;
        CellByName['EMailId', LRow].AsString := IntToStr(LVar.RowID);
        CellByName['EntryId', LRow].AsString := LVar.EntryID;
        CellByName['StoreId', LRow].AsString := LVar.StoreID;
        CellByName['FolderPath', LRow].AsString := LVar.SavedOLFolderPath;

        if LVar.ContainData <> Ord(cdmNone) then
        begin
          LStr := TRttiEnumerationType.GetName<TContainData4Mail>(LVar.ContainData);
          CellByName['ContainData', LRow].AsString := LStr;
        end;

        if LVar.ParentID = '' then
        begin
          MoveRow(LRow, 0);
          LRow := 0;
        end;
      end;
    end;
  finally
    AGrid.EndUpdate;
  end;
end;

end.
