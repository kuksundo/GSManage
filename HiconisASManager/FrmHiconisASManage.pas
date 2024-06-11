unit FrmHiconisASManage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Winapi.ActiveX, Vcl.ExtCtrls, Vcl.Menus,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, NxColumnClasses, NxColumns,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, AdvOfficeTabSet,
  Vcl.StdCtrls, Vcl.ComCtrls, AdvGroupBox, AdvOfficeButtons, AeroButtons,
  JvExControls, JvLabel, CurvyControls, Vcl.ImgList, System.SyncObjs,
  OtlCommon, OtlComm, OtlTaskControl, OtlContainerObserver, otlTask,
  mormot.core.base, mormot.rest.client, mormot.orm.core, mormot.rest.http.server,
  mormot.rest.server, mormot.soa.server, mormot.core.datetime, mormot.rest.memserver,
  mormot.soa.core, mormot.core.interfaces, mormot.core.os, mormot.core.text,
  mormot.rest.http.client, mormot.core.json, mormot.core.unicode, mormot.core.variants,
  CommonData2, FrmHiconisASTaskEdit, UnitHiconisMasterRecord, System.Rtti,
  DragDropInternet,DropSource,DragDropFile,DragDropFormats, DragDrop, DropTarget,
  VarRecUtils,
  UnitHiconisASWSInterface, UnitOLDataType,
  thundax.lib.actions_pjh, UnitMAPSMacro2, UnitUserDataRecord2,
  UnitElecServiceData2, FrameDisplayTaskInfo2;

const
  WM_OLMSG_RESULT = WM_USER + 1;

type
  TServiceIM4WS = class(TInterfacedObject, IHiconisASService)
  private
  protected
    fConnected: array of IHiconisASCallback;
    FClientInfoList: TStringList;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Join(const pseudo: string; const callback: IHiconisASCallback);
    procedure CallbackReleased(const callback: IInvokable; const interfaceName: RawUTF8);
    function ServerExecute(const Acommand: RawUTF8): RawUTF8;
  end;

  TWorker4OLMsg = class(TThread)
  private
    FDBMsgQueue: TOmniMessageQueue;
    FIPCMQFromOL: TOmniMessageQueue;
    FStopEvent    : TEvent;
  protected
    procedure Execute; override;
  public
    constructor Create(DBMsgQueue, IPCQueue: TOmniMessageQueue);
    destructor Destroy; override;
    procedure Stop;
  end;

  TOLMailCallback = class(TInterfacedCallback, IHiconisASCallback)
  protected
    procedure ClientExecute(const command, msg: string);
  end;

  THiconisASManageF = class(TForm)
    DropEmptyTarget1: TDropEmptyTarget;
    DataFormatAdapterOutlook: TDataFormatAdapter;
    TDTF: TDisplayTaskF;
    MAPS1: TMenuItem;
    QUOTATIONINPUT1: TMenuItem;
    DropEmptySource1: TDropEmptySource;
    DataFormatAdapter2: TDataFormatAdapter;
    DataFormatAdapterTarget: TDataFormatAdapter;
    DataFormatAdapter1: TDataFormatAdapter;
    N1: TMenuItem;
    N2: TMenuItem;
    Timer1: TTimer;
    File1: TMenuItem;
    OpenDialog1: TOpenDialog;
    est2: TMenuItem;
    ViewTariff1: TMenuItem;
    EditTariff1: TMenuItem;
    CreateNewTask1: TMenuItem;
    N4: TMenuItem;
    Close1: TMenuItem;
    ariff1: TMenuItem;
    N3: TMenuItem;
    VDRAPTDocument1: TMenuItem;
    VDRAPTService1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure TDTFComboBox1DropDown(Sender: TObject);
    procedure TDTFbtn_SearchClick(Sender: TObject);
    procedure TDTFrg_periodClick(Sender: TObject);
    procedure TDTFgrid_ReqCellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure TDTFEmailButtonClick(Sender: TObject);
    procedure TDTFJvLabel7Click(Sender: TObject);
    procedure DropEmptyTarget1Drop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure TDTFShowTaskID1Click(Sender: TObject);
    procedure TDTFbtn_CloseClick(Sender: TObject);
    procedure QUOTATIONINPUT1Click(Sender: TObject);
    procedure TDTFgrid_ReqMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N2Click(Sender: TObject);
    procedure TDTFN16Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TDTFJvLabel8Click(Sender: TObject);
    procedure est2Click(Sender: TObject);
    procedure ViewTariff1Click(Sender: TObject);
    procedure EditTariff1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure CreateNewTask1Click(Sender: TObject);
    procedure TDTFDeleteTask1Click(Sender: TObject);
  private
//    FIPCServer: TIPCServer;
//    FHttpClientWebsocket: TSQLHttpClientWebsockets;
    FStopEvent    : TEvent;
    FDBMsgQueue: TOmniMessageQueue;
    FIPCMQFromOL: TOmniMessageQueue;
    FWorker4OLMsg: TWorker4OLMsg;
    FTaskJson: String;
    FFileContent: RawByteString;
//    FRegInfo: TRegistrationInfo;

    //Websocket-b
    FModel: TSQLModel;
    FHTTPServer: TRestHttpServer;
    FRestServer: TRestServer;
    FServiceFactoryServer: TServiceFactoryServer;

    FIpAddr: string;
    FURL: string; //Server���� Client�� Config Change Notify �ϱ� ���� Call Back URL
    FIsServerActive,
    FIsPJHPC,
    FIsRunRestServer: Boolean;

    FUserEmail,
    FUserName: string;
//    FCommModes: TCommModes;
    //Websocket-e

    procedure OnGetStream(Sender: TFileContentsStreamOnDemandClipboardFormat;
      Index: integer; out AStream: IStream);

    procedure DisplayOLMsg2Grid(const task: IOmniTaskControl; const msg: TOmniMessage);
//    procedure DisplayTask2GridFromRemote();

    function CheckRegistration: Boolean;

    procedure ProcessCommand(ARespond: string);
    //Macro���� ExecFunction���� FunctionName�� �ָ� �Ʒ��� public�� Procedure����
    //�Լ����� ã�Ƽ� ������ ��
    procedure ExecFunc(AFuncName: string);
    procedure ExecMethod(MethodName:string; const Args: array of TValue);

    function SaveCurrentTask2File(AFileName: string = '') : string;
    procedure CreateNewTask;

    //Websocket-b
    procedure CreateHttpServer4WS(APort, ATransmissionKey: string;
      aClient: TInterfacedClass; const aInterfaces: array of TGUID);
    procedure DestroyHttpServer;
    function SessionCreate(Sender: TRestServer; Session: TAuthSession;
                  Ctxt: TRestServerURIContext): boolean;
    function SessionClosed(Sender: TRestServer; Session: TAuthSession;
                  Ctxt: TRestServerURIContext): boolean;
    procedure InitNetwork;
    function ServerExecuteFromClient(ACommand: RawUTF8): RawUTF8;
    //Websocket-e

    procedure TestRemoteTaskList;
    procedure TestRemoteTaskDetail;
  public
    //Main or �ܼ� ��ȸ: Main := 0, �ܼ� ��ȸ := 1
    FProgMode: integer;

    procedure TestRemoteTaskEmailList(ATask: TSQLGSTask);

    procedure AsynDisplayOLMsg2Grid;//(AStopEvent: TEvent; AIPCMQFromOL: TOmniMessageQueue);
    procedure SendReqOLEmailInfo;
    procedure SendReqOLEmailInfo_CromisIPC;
    procedure SendReqOLEmailInfo_WS;

    procedure KeyIn_CompanyCode;
    procedure KeyIn_RFQ;
    procedure Select_Money;
    procedure KeyIn_Content;
    procedure Select_DeliveryCondition;
    procedure Select_EstimateType;
    procedure Select_TermsOfPayment;
  end;

var
  HiconisASManageF: THiconisASManageF;

implementation

Uses System.DateUtils, OtlParallel, Clipbrd, UnitIPCModule2,
  Vcl.ogutil, UnitDragUtil, UnitHiconisASVarJsonUtil, FrmEmailListView2,
  UnitBase64Util2, UnitCmdExecService,
  FrmEditTariff2, UnitGSTariffRecord2, FrmDisplayTariff2, OLMailWSCallbackInterface2;

{$R *.dfm}

procedure THiconisASManageF.AsynDisplayOLMsg2Grid;//(AStopEvent: TEvent;
//  AIPCMQFromOL: TOmniMessageQueue);
var
  LEmailMsg,
  LEmailMsg2: TSQLEmailMsg;
  LTask,
  LTask2: TSQLGSTask;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      i: integer;
      handles: array [0..1] of THandle;
      msg    : TOmniMessage;
      rec    : TOLMsgFileRecord;
      LID: TID;
      LTaskIds: TIDDynArray;
      LIsAddTask,  //True=�ű� Task ���
      LIsProcessJson: Boolean; //Task������ Json���Ϸ� ����
      LStr: string;
    begin
      try
//        g_MyEmailInfo := SendReqOLEmailAccountInfo_WS;
      except
      end;

      handles[0] := FStopEvent.Handle;
      handles[1] := FIPCMQFromOL.GetNewMessageEvent;
      LEmailMsg := TSQLEmailMsg.Create;

      while WaitForMultipleObjects(2, @handles, false, INFINITE) = (WAIT_OBJECT_0 + 1) do
      begin
        while FIPCMQFromOL.TryDequeue(msg) do
        begin
          LTask := TSQLGSTask.Create;
          try
            rec := msg.MsgData.ToRecord<TOLMsgFileRecord>;

            if msg.MsgID = Ord(dkmqMailFromOL) then
            begin
              LIsProcessJson := False;

              if (rec.FEntryID <> '') and (rec.FStoreID <> '') then
              begin
                LEmailMsg := TSQLEmailMsg.CreateAndFillPrepare(g_ProjectDB.Orm,
                  'EntryID = ? AND StoreID = ?', [rec.FEntryID,rec.FStoreID]);

                //�����Ͱ� ������
  //              if LEmailMsg.ID = 0 then
                if not LEmailMsg.FillOne then
                begin
                  LEmailMsg.Sender := rec.FSender;
                  LEmailMsg.Receiver := rec.FReceiver;
                  LEmailMsg.CarbonCopy := rec.FCarbonCopy;
                  LEmailMsg.BlindCC := rec.FBlindCC;
                  LEmailMsg.EntryID := rec.FEntryId;
                  LEmailMsg.StoreID := rec.FStoreId;
                  LEmailMsg.Subject := rec.FSubject;
                  LEmailMsg.SavedOLFolderPath := rec.FSavedOLFolderPath;
                  LEmailMsg.RecvDate := TimeLogFromDateTime(rec.FReceiveDate);

                  LEmailMsg2 := TSQLEmailMsg.Create(g_ProjectDB.Orm,
                    'Subject = ?', [rec.FSubject]);

                  if LEmailMsg2.FillOne then //������ ������ ������ �����ϸ�
                  begin
                    LIsAddTask := False;
                    LTask.EmailMsg.SourceGet(g_ProjectDB.Orm, LEmailMsg2.ID, LTaskIds);

                    try
                      for i:= low(LTaskIds) to high(LTaskIds) do
                      begin
                        LTask2 := CreateOrGetLoadTask(LTaskIds[i]);
                        break;
                      end;
                    finally
                      if LTask2.ID <> 0 then
                      begin
                        LTask2.EmailMsg.ManyAdd(g_ProjectDB.Orm, LTask2.ID, LEMailMsg.ID, True);
                        FreeAndNil(LTask2);
                      end;
                    end;

                    LEmailMsg.ParentID := LEmailMsg2.EntryID+';'+LEmailMsg2.StoreID;
                    LID := g_ProjectDB.Add(LEmailMsg, true);
                  end
                  else
                  begin //������ �������� ������ Task�� ���� ��� �ؾ� ��
  //                  LIsAddTask := True;
                    LTask.InqRecvDate := TimeLogFromDateTime(rec.FReceiveDate);
                    LTask.ChargeInPersonId := rec.FUserEmail;
                    LIsAddTask := FrmHiconisASTaskEdit.DisplayTaskInfo2EditForm(LTask,LEmailMsg,null);
    //                g_ProjectDB.Add(LTask, true);
    //                LTask.EmailMsg.ManyAdd(g_ProjectDB.Orm, LTask.ID, LEmailMsg.ID, true);
                  end;
                end;
              end;
            end
            else
            if msg.MsgID = Ord(dkmqFolderFromOL) then
            begin
              //task.Invoke�Լ����� Grid�� Task �߰��ϴ� ���� ������
              LIsAddTask := False;
              LIsProcessJson := False;
              TDTF.AddFolderListFromOL(rec.FEntryId + '=' + rec.FStoreId);
            end
            else
            if msg.MsgID = Ord(dkmqFileFromDrag) then
            begin
              LStr := rec.FSubject;
              LIsProcessJson := True;
              LIsAddTask := False;
            end;

            task.Invoke(//Thread Synchronize�� ������
              procedure
              begin
                //������ ������ ������ �������� ������ Grid�� �߰�
                if LIsAddTask then
                begin
                  if Assigned(LTask) then
                  begin
                    TDTF.LoadTaskVar2Grid(LTask, TDTF.grid_Req);
                    FreeAndNil(LTask);
                  end;
                end;

                if LIsProcessJson then
                begin
                  ProcessTaskJson(LStr);
                end;
              end
            );
          finally
            if (not LIsAddTask) and Assigned(LTask) then
              FreeAndNil(LTask);
          end;
        end;//while
      end;//while
    end,

    Parallel.TaskConfig.OnMessage(Self).OnTerminated(
      procedure
      begin
        FreeAndNil(LEmailMsg);
      end
    )
  );
end;

procedure THiconisASManageF.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

function THiconisASManageF.CheckRegistration: Boolean;
begin

end;

procedure THiconisASManageF.Close1Click(Sender: TObject);
begin
  Close;
end;

procedure THiconisASManageF.CreateHttpServer4WS(APort, ATransmissionKey: string;
  aClient: TInterfacedClass; const aInterfaces: array of TGUID);
begin
  if not Assigned(FRestServer) then
  begin
    // initialize a TObjectList-based database engine
    FRestServer := TRestServerFullMemory.CreateWithOwnModel([]);
    // register our Interface service on the server side
    FRestServer.CreateMissingTables;
    FServiceFactoryServer := FRestServer.ServiceDefine(aClient, aInterfaces , sicShared) as TServiceFactoryServer;  //sicClientDriven
    FServiceFactoryServer.SetOptions([], [optExecLockedPerInterface]). // thread-safe fConnected[]
      ByPassAuthentication := true;
  end;

  if not Assigned(FHTTPServer) then
  begin
    // launch the HTTP server
//    FPortName := APort;
    FHTTPServer := TRestHttpServer.Create(APort, [FRestServer], '+' , useBidirSocket);
    FHTTPServer.WebSocketsEnable(FRestServer, ATransmissionKey);
    FIsServerActive := True;
  end;

//  FCommModes := FCommModes + [cmWebSocket];
end;

procedure THiconisASManageF.CreateNewTask;
var
  LTask: TSQLGSTask;
begin
  LTask := TSQLGSTask.Create;
  try
  if FrmHiconisASTaskEdit.DisplayTaskInfo2EditForm(LTask, nil, null) then
    TDTF.LoadTaskVar2Grid(LTask, TDTF.grid_Req);
  finally
    LTask.Free;
  end;
end;

procedure THiconisASManageF.CreateNewTask1Click(Sender: TObject);
begin
  CreateNewTask;
end;

procedure THiconisASManageF.DestroyHttpServer;
begin
  if Assigned(FHTTPServer) then
    FHTTPServer.Free;

  if Assigned(FRestServer) then
  begin
    FRestServer.Free;
  end;

  if Assigned(FModel) then
    FreeAndNil(FModel);
end;

procedure THiconisASManageF.DisplayOLMsg2Grid(const task: IOmniTaskControl;
  const msg: TOmniMessage);
var
  rec    : TOLMsgFileRecord;
begin
//  ShowMessage(rec.FSubject);
//  rec := msg.MsgData.ToRecord<TOLMsgFileRecord>;
end;

procedure THiconisASManageF.DropEmptyTarget1Drop(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
var
  LTargetStream: TStream;
  LStr: RawByteString;
  LProcessOK: Boolean;
  LFileName: string;
  rec    : TOLMsgFileRecord;
  LOmniValue: TOmniValue;
begin
  LFileName := '';
  // ������ Ž���⿡�� Drag ���� ��� LFileName�� Drag�� File Name�� ������
  // OutLook���� Drag�� ��쿡�� LFileName = '' ��
  if (DataFormatAdapter1.DataFormat <> nil) then
  begin
    LFileName := (DataFormatAdapter1.DataFormat as TFileDataFormat).Files.Text;

    if LFileName <> '' then
    begin
      if ExtractFileExt(LFileName) <> '.hms' then
      begin
        ShowMessage('This file is not auto created by HMS from explorer');
        exit;
      end;

      LStr := StringFromFile(LFileName);
      rec.FSubject := LStr;
      LOmniValue := TOmniValue.FromRecord<TOLMsgFileRecord>(rec);
      FIPCMQFromOL.Enqueue(TOmniMessage.Create(3, LOmniValue));
//      LProcessOK := ProcessTaskJson(LStr);
      exit;
    end;
  end;

  // OutLook���� ÷�������� Drag ���� ���
  if (TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat).FileNames.Count > 0) then
  begin
    LFileName := TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat).FileNames[0];

    if ExtractFileExt(LFileName) <> '.msg' then
    begin
      if ExtractFileExt(LFileName) <> '.hms' then
      begin
        ShowMessage('This file is not auto created by HMS');
        exit;
      end;

      LTargetStream := GetStreamFromDropDataFormat(TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat));
      try
        if not Assigned(LTargetStream) then
          ShowMessage('Not Assigned');

        LStr := StreamToRawByteString(LTargetStream);
  //      LStr := LTargetStream.DataString;

        rec.FSubject := LStr;
        LOmniValue := TOmniValue.FromRecord<TOLMsgFileRecord>(rec);
        FIPCMQFromOL.Enqueue(TOmniMessage.Create(Ord(dkmqFileFromDrag), LOmniValue));
        exit;
//        LProcessOK := ProcessTaskJson(LStr);

  //      LTargetStream.Seek(0,soBeginning);
  //      LStr := ReadStringFromStream(LTargetStream);
  //      ShowMessage(LStr);
      finally
        if Assigned(LTargetStream) then
          LTargetStream.Free;
      end;
    end;
  end;

  // OutLook���� ������ Drag ���� ���
  if not LProcessOK and (DataFormatAdapterOutlook.DataFormat <> nil) then
  begin
    SendReqOLEmailInfo;
//    ShowMessage('Outlook Mail Dropped');
  end;
end;

procedure THiconisASManageF.EditTariff1Click(Sender: TObject);
begin
  DisplayTariffEditF;
end;

procedure THiconisASManageF.est2Click(Sender: TObject);
begin
  TestRemoteTaskDetail;
end;

procedure THiconisASManageF.ExecFunc(AFuncName: string);
begin
  if AFuncName <> '' then
    ExecMethod(AFuncName,[]);
end;

procedure THiconisASManageF.ExecMethod(MethodName: string; const Args: array of TValue);
var
  R : TRttiContext;
  T : TRttiType;
  M : TRttiMethod;
begin
  T := R.GetType(Self.ClassType);

  for M in t.GetMethods do
  begin
    if (m.Parent = t) and (m.Name = MethodName)then
    begin
      M.Invoke(Self,Args);
      break;
    end;
  end;
end;

procedure THiconisASManageF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FStopEvent) then
  begin
    FStopEvent.SetEvent;
    Sleep(100);
  end;
//  FIPCServer.Stop;
//  g_IPCClient.DisconnectClient;
end;

procedure THiconisASManageF.FormCreate(Sender: TObject);
var
  LPort: integer;
begin
//  LPort := StrToIntDef(RCS_PORT_NAME, -1);

//  if not DoIsTCPPortAllowed(LPort, RCS_DEFAULT_IP) then
//  begin
//    LStr := ExtractFileName(Application.ExeName);
//    DoAddExceptionToFirewall(LStr, Application.ExeName, LPort);
////    GetRulesFromFirewall(LStr);
//  end;

  FProgMode := 0;
  SetCurrentDir(ExtractFilePath(Application.ExeName));
//  FIPCServer := TIPCServer.Create;
//  FIPCServer.OnServerError := OnServerError;
//  FIPCServer.OnClientConnect := OnClientConnect;
//  FIPCServer.OnExecuteRequest := OnExecuteRequest;
//  FIPCServer.OnClientDisconnect := OnClientDisconnect;
//
//  FIPCServer.ServerName := IPC_SERVER_NAME_4_INQMANAGE;
//  FIPCServer.Start;

  (DataFormatAdapter2.DataFormat as TVirtualFileStreamDataFormat).OnGetStream := OnGetStream;
  FDBMsgQueue := TOmniMessageQueue.Create(1000);
  FIPCMQFromOL := TOmniMessageQueue.Create(1000);
//  FWorker4OLMsg := TWorker4OLMsg.Create(FDBMsgQueue, FIPCMQFromOL);

  Parallel.TaskConfig.OnMessage(WM_OLMSG_RESULT,DisplayOLMsg2Grid);
  FStopEvent := TEvent.Create;
  UnitHiconisMasterRecord.InitHiconisASClient(Application.ExeName);
  InitUserClient(Application.ExeName);
  InitClient4GSTariff(Application.ExeName);
  AsynDisplayOLMsg2Grid();
  TDTF.rg_periodClick(nil);
  g_ExecuteFunction := ExecFunc;

  TDTF.LoadConfigFromFile;
end;

procedure THiconisASManageF.FormDestroy(Sender: TObject);
begin
//  FWorker4OLMsg.Terminate;
//  FWorker4OLMsg.Stop;
//  if Assigned(FRegInfo) then
//    FRegInfo.Free;

//  DestroyUserClient(); UnitUserDataRecord2.finalization ���� �����
//  DestroyGSTariffClient(); UnitGSTariffRecord2.finalization ���� �����

  if FIsRunRestServer then
    DestroyHttpServer;

  if Assigned(FStopEvent) then
    FStopEvent.SetEvent;

  if Assigned(FDBMsgQueue) then
    FreeAndNil(FDBMsgQueue);

  if Assigned(FIPCMQFromOL) then
    FreeAndNil(FIPCMQFromOL);
//  FreeAndNil(FIPCServer);
  if Assigned(FStopEvent) then
    FreeAndNil(FStopEvent);
end;

procedure THiconisASManageF.InitNetwork;
begin
  CreateHttpServer4WS(TDTF.FPortName, TDTF.FTransmissionKey, TServiceIM4WS, [IHiconisASService]);
  FIsRunRestServer := True;
  TDTF.StatusBarPro1.Panels[2].Text := 'Port = ' + TDTF.FPortName;
end;

procedure THiconisASManageF.KeyIn_CompanyCode;
var
  LCode: string;
  LTask: TSQLGSTask;
begin
  LTask := TDTF.GetTask;
  try
    LCode := GetCompanyCode(LTask);
    Key_Input_CompanyCode(LCode);
  finally
    LTask.Free;
  end;
end;

procedure THiconisASManageF.KeyIn_Content;
var
  LContent: string;
  LTask: TSQLGSTask;
begin
  LTask := TDTF.GetTask;
  try
    LContent := GetQTNContent(LTask);
    QTN_Key_Input_Content(LContent);
  finally
    LTask.Free;
  end;
end;

procedure THiconisASManageF.KeyIn_RFQ;
var
  LPONo: string;
  LTask: TSQLGSTask;
begin
  LTask := TDTF.GetTask;
  try
    LPONo := UTF8ToString(LTask.PO_No);
    Key_Input_RFQ(LPONo);
  finally
    LTask.Free;
  end;
end;

procedure THiconisASManageF.N2Click(Sender: TObject);
begin
  TDTF.SetConfig;
end;

//procedure TInquiryF.OnExecuteRequest(const Context: ICommContext; const Request,
//  Response: IMessageData);
//begin
//  Parallel.Async(
//    procedure (const task: IOmniTask)
//    var
//      Command: AnsiString;
//      LocalCount: Integer;
//      LFileName: string;
//      LFileStream: TMemoryStream;
//      LStrList: TStringList;
//      rec    : TOLMsgFileRecord;
//      LOmniValue: TOmniValue;
//    begin
//      LStrList := TStringList.Create;
//      try
//        LStrList.Text := Request.Data.ReadUTF8String(CMD_LIST);
//        Command := LStrList.Values['Command'];
//
//        if Command = CMD_SEND_MAIL_ENTRYID then
//        begin
//          rec.FEntryId := LStrList.Values['EntryId'];
//          rec.FStoreId := LStrList.Values['StoreId'];
//          rec.FSender := LStrList.Values['Sender'];
//          rec.FReceiver := LStrList.Values['Receiver'];
//          rec.FReceiveDate := StrToDateTime(LStrList.Values['RecvDate']);
//          rec.FCarbonCopy := LStrList.Values['CC'];
//          rec.FBlindCC := LStrList.Values['BCC'];
//          rec.FSubject := LStrList.Values['Subject'];
//          LOmniValue := TOmniValue.FromRecord<TOLMsgFileRecord>(rec);
//          FIPCMQFromOL.Enqueue(TOmniMessage.Create(1, LOmniValue));
//
//          Response.ID := Format('Response nr. %d', [LocalCount]);
//          Response.Data.WriteDateTime('TDateTime', Now);
//        end
//        else
//        if Command = CMD_SEND_FOLDER_STOREID then
//        begin
//          rec.FEntryId := LStrList.Values['FolderPath'];
//          rec.FSender := LStrList.Values['FolderName'];
//          rec.FStoreId := LStrList.Values['StoreId'];
//          LOmniValue := TOmniValue.FromRecord<TOLMsgFileRecord>(rec);
//          FIPCMQFromOL.Enqueue(TOmniMessage.Create(2, LOmniValue));
//        end
//        else
//        if Command = 'SaveFile' then
//        begin
//          LFileName := Request.Data.ReadUnicodeString('FileName');
//          LFileStream := TMemoryStream.Create;
//          try
//            Request.Data.ReadStream('File', LFileStream);
//            LFileStream.SaveToFile('c:\private\'+LFileName);
//          finally
//            LFileStream.Free;
//          end;
//        end;
//      finally
//        LStrList.Free;
//      end;
//    end,
//
//    Parallel.TaskConfig.OnMessage(Self).OnTerminated(
//      procedure
//      begin
//      end
//    )
//  );
//end;

procedure THiconisASManageF.OnGetStream(
  Sender: TFileContentsStreamOnDemandClipboardFormat; Index: integer;
  out AStream: IStream);
var
//  Data: AnsiString;
//  i: integer;
//  SelIndex: integer;
//  Found: boolean;
  LStream: TStringStream;
//  LStr: string;
begin
  LStream := TStringStream.Create;
  try
//    LStr := Utf8ToString(AnsiToUTF8(FTaskJson));
    LStream.WriteString(FTaskJson);
    AStream := nil;
    AStream := TFixedStreamAdapter.Create(LStream, soOwned);
  except
    raise;
  end;
end;

procedure THiconisASManageF.ProcessCommand(ARespond: string);
var
  Command: String;
  LocalCount: Integer;
  LFileName: string;
  LFileStream: TMemoryStream;
  LStrList: TStringList;
  rec    : TOLMsgFileRecord;
  LOmniValue: TOmniValue;
begin
  LStrList := TStringList.Create;
  try
    LStrList.Text := ARespond;
    Command := LStrList.Values['Command'];

    if Command = CMD_SEND_MAIL_ENTRYID then
    begin
      rec.FEntryId := LStrList.Values['EntryId'];
      rec.FStoreId := LStrList.Values['StoreId'];
      rec.FSender := LStrList.Values['Sender'];
      rec.FReceiver := LStrList.Values['Receiver'];
      rec.FReceiveDate := StrToDateTime(LStrList.Values['RecvDate']);
      rec.FCarbonCopy := LStrList.Values['CC'];
      rec.FBlindCC := LStrList.Values['BCC'];
      rec.FSubject := LStrList.Values['Subject'];
      rec.FSavedOLFolderPath := LStrList.Values['FolderPath'];
      rec.FUserEMail := LStrList.Values['UserEmail'];
      rec.FUserName := LStrList.Values['UserName'];
      LOmniValue := TOmniValue.FromRecord<TOLMsgFileRecord>(rec);
      FIPCMQFromOL.Enqueue(TOmniMessage.Create(Ord(dkmqMailFromOL), LOmniValue));
    end
    else
    if Command = CMD_SEND_FOLDER_STOREID then
    begin
      rec.FEntryId := LStrList.Values['FolderPath'];
      rec.FSender := LStrList.Values['FolderName'];
      rec.FStoreId := LStrList.Values['StoreId'];
      LOmniValue := TOmniValue.FromRecord<TOLMsgFileRecord>(rec);
      FIPCMQFromOL.Enqueue(TOmniMessage.Create(Ord(dkmqFolderFromOL), LOmniValue));
    end
    else
    if Command = 'SaveFile' then
    begin
//      LFileName := Request.Data.ReadUnicodeString('FileName');
//      LFileStream := TMemoryStream.Create;
//      try
//        Request.Data.ReadStream('File', LFileStream);
//        LFileStream.SaveToFile('c:\private\'+LFileName);
//      finally
//        LFileStream.Free;
//      end;
    end;
  finally
    LStrList.Free;
  end;
end;

procedure THiconisASManageF.QUOTATIONINPUT1Click(Sender: TObject);
begin
  QTN_Input;
end;

function THiconisASManageF.SaveCurrentTask2File(AFileName: string): string;
var
  LTask: TSQLGSTask;
//  LUtf8: RawUTF8;
//  LDynArr: TDynArray;
//  LCount: integer;
//  LCustomer: TSQLCustomer;
//  LSubCon: TSQLSubCon;
//  LMat4Proj: TSQLMaterial4Project;
//  LV,LV2,LV3: variant;
  LFileName, LStr: string;
//    LTaskJson: RawByteString;
//  LGuid: TGuid;
begin
//  if AFileName = '' then
//  begin
//    CreateGUID(LGuid);
//    AFileName := '.\' + GUIDToString(LGuid);
//  end;
  Result := '';
//  TDocVariant.New(LV);

  LTask := TDTF.GetTask;
  try
    if LTask.IsUpdate then
    begin
      FTaskJson := MakeTaskInfoEmailAttached(LTask, LFileName);

//      FTaskJson := UTF8ToAnsi(StringToUTF8(FTaskJson));
//      FTaskJson := SynLZDecompress(FTaskJson);
//      ShowMessage(FTaskJson);
      if AFileName = '' then
      begin
        AFileName := LFileName;
      end;

      Result := AFileName;
    end;
//    TDocVariant.New(LV3);
//    LV3 := _JSON(LUtf8);
//
//    TDocVariant.New(LV2);
//    LV2 := _JSON(LV3.Task);
//    ShowMessage(LV2.ShipName);
//    Memo1.Text := Utf8ToString(LV3.Task);
  finally
    LTask.Free;
  end;
end;

procedure THiconisASManageF.Select_DeliveryCondition;
var
  LDeliveryCondition: integer;
  LTask: TSQLGSTask;
begin
  LTask := TDTF.GetTask;
  try
    LDeliveryCondition := LTask.DeliveryCondition;
    Sel_DeliveryCondition(LDeliveryCondition);
  finally
    LTask.Free;
  end;
end;

procedure THiconisASManageF.Select_EstimateType;
var
  LEstimateType: integer;
  LTask: TSQLGSTask;
begin
  LTask := TDTF.GetTask;
  try
    LEstimateType := LTask.EstimateType;
    Sel_EstimateType(LEstimateType);
  finally
    LTask.Free;
  end;
end;

procedure THiconisASManageF.Select_Money;
var
  LCurrencyKind: integer;
  LTask: TSQLGSTask;
begin
  LTask := TDTF.GetTask;
  try
    LCurrencyKind := LTask.CurrencyKind;
    Sel_CurrencyKind(LCurrencyKind);
  finally
    LTask.Free;
  end;
end;

procedure THiconisASManageF.Select_TermsOfPayment;
var
  LTermsOfPayment: integer;
  LTask: TSQLGSTask;
begin
  LTask := TDTF.GetTask;
  try
    LTermsOfPayment := LTask.TermsOfPayment;
    Sel_TermsOfPayment(LTermsOfPayment);
  finally
    LTask.Free;
  end;
end;

procedure THiconisASManageF.SendReqOLEmailInfo;
begin
//  SendReqOLEmailInfo_CromisIPC;
  SendReqOLEmailInfo_WS;
end;

procedure THiconisASManageF.SendReqOLEmailInfo_CromisIPC;
var
  LStrList: TStringList;
//  Request: IIPCData;
//  Result: IIPCData;
begin
//  if g_IPCClient.IsConnected then
//  begin
//    LStrList := TStringList.Create;
//    try
//      LStrList.Add('ServerName='+IPC_SERVER_NAME_4_OUTLOOK);
//      LStrList.Add('Command='+CMD_REQ_MAILINFO_SEND);
//
//      Request := AcquireIPCData;
//      Request.ID := DateTimeToStr(Now);
//      Request.Data.WriteUTF8String(CMD_LIST,LStrList.Text);
////      Result := g_IPCClient.ExecuteRequest(Request);
//      Result := g_IPCClient.ExecuteConnectedRequest(Request);
//
//      if g_IPCClient.AnswerValid then
//      begin
//      end;
//    finally
//      LStrList.Free;
//    end;
//  end
//  else
//  begin
//    ShowMessage('IPC is not connected : ' + IPC_SERVER_NAME_4_INQMANAGE);
////    ShowMessage('Try Again');
//  end;
end;

procedure THiconisASManageF.SendReqOLEmailInfo_WS;
var
  Client: TRestHttpClientWebsockets;
  LCommand, LRespond: string;
  Service: IOLMailService;
  callback: IOLMailCallback;
  LStrList: TStringList;
begin
  Client := GetClientWS;
  try
    if not Client.Services.Resolve(IOLMailService,Service) then
      raise EServiceException.Create('Service IOLMailService unavailable');

    callback := TOLMailCallback.Create(Client,IOLMailCallback) as IOLMailCallback;
    try
//      Service.Join(workName,callback);
      LStrList := TStringList.Create;
      try
        LStrList.Add('ServerName='+IPC_SERVER_NAME_4_OUTLOOK);
        LStrList.Add('Command='+CMD_REQ_MAILINFO_SEND);
        LCommand := LStrList.Text;
        LRespond := Service.GetOLEmailInfo(LCommand);
        ProcessCommand(LRespond);
      finally
        LStrList.Free;
      end;
    finally
      callback := nil;
      Service := nil; // release the service local instance BEFORE Client.Free
    end;
  finally
    Client.Free;
  end;
end;

function THiconisASManageF.ServerExecuteFromClient(ACommand: RawUTF8): RawUTF8;
var
  LOmniValue: TOmniValue;
  Command, LJson: String;
  LStrList: TStringList;
  LVarArr: TVariantDynArray;
  LSearchCondRec: TSearchCondRec;
  LTask: TSQLGSTask;
  LVar: Variant;
  i, LTaskId: integer;
  LRaw: RawByteString;
  LUtf8: RawUTF8;
  LFileName: string;
begin
  LJson := MakeBase64ToString(ACommand);
  LStrList := TStringList.Create;
  try
    LStrList.Text := LJson;
    Command := LStrList.Values['Command'];

    if Command = CMD_REQ_TASK_LIST then
    begin
      LJson := LStrList.Values['Parameter'];
      RecordLoadJson(LSearchCondRec, LJson, TypeInfo(TSearchCondRec));
      TDTF.DisplayTaskInfo2Grid(LSearchCondRec, True);
      LJson := TDTF.FTempJsonList.Text;
      System.Delete(LJson, Length(LJson)-1,2);
      Result := StringToUTF8(LJson);
      Result := MakeRawUTF8ToBin64(Result);
    end
    else
    if Command = CMD_REQ_TASK_DETAIL then
    begin
      LJson := LStrList.Values['Parameter'];
      LVar := _JSON(LJson);
      LTask:= CreateOrGetLoadTask(LVar.TaskId);
      Result := MakeTaskDetail2JSON(LTask);
      Result := MakeRawUTF8ToBin64(Result);
    end
    else
    if Command = CMD_REQ_TASK_EAMIL_LIST then
    begin
      LJson := LStrList.Values['Parameter'];
      LTaskId := StrToIntDef(LJson, 0);
      Result := MakeTaskEmailList2JSON(LTaskId);
      Result := MakeRawUTF8ToBin64(Result);
    end
    else
    if Command = CMD_REQ_TASK_EAMIL_CONTENT then
    begin
      LJson := LStrList.Values['Parameter'];
      Result := SendReqOLEmail2MagFile(LJson);  //file path + name�� ��ȯ��
      LFileName := Utf8ToString(Result);

      if FileExists(LFileName) then
      begin
        LRaw := StringFromFile(LFileName);
        Result := MakeRawUTF8ToBin64(LRaw);
        System.SysUtils.DeleteFile(LFileName);
      end;
    end
    else
    if Command = CMD_EXECUTE_SAVE_TASK_DETAIL then
    begin
      LJson := LStrList.Values['Parameter'];
      LVar := _JSON(LJson);
      if SaveTaskInfo2DBFromJson(LVar) then
        Result := 'TRUE'
      else
        Result := 'FALSE';
    end;
  finally
    LStrList.Free;
  end;
end;

function THiconisASManageF.SessionClosed(Sender: TRestServer; Session: TAuthSession;
  Ctxt: TRestServerURIContext): boolean;
begin

end;

function THiconisASManageF.SessionCreate(Sender: TRestServer; Session: TAuthSession;
  Ctxt: TRestServerURIContext): boolean;
begin

end;

procedure THiconisASManageF.TDTFbtn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure THiconisASManageF.TDTFbtn_SearchClick(Sender: TObject);
begin
  TDTF.btn_SearchClick(Sender);
end;

procedure THiconisASManageF.TDTFComboBox1DropDown(Sender: TObject);
begin
  TDTF.ComboBox1DropDown(Sender);
end;

procedure THiconisASManageF.TDTFDeleteTask1Click(Sender: TObject);
begin
  TDTF.DeleteTask1Click(Sender);

end;

procedure THiconisASManageF.TDTFEmailButtonClick(Sender: TObject);
begin
  TDTF.EmailButtonClick(Sender);
end;

procedure THiconisASManageF.TDTFgrid_ReqCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  TDTF.grid_ReqCellDblClick(Sender, ACol,ARow);
end;

procedure THiconisASManageF.TDTFgrid_ReqMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i: integer;
  LFileName: string;
begin
  if not PtInRect(TDTF.grid_Req.GetRowRect(TDTF.grid_Req.SelectedRow), Point(X,Y)) then
    exit;

  if (DragDetectPlus(TDTF.grid_Req.Handle, Point(X,Y))) then
  begin
    if TDTF.grid_Req.SelectedRow = -1 then
      exit;

    TVirtualFileStreamDataFormat(DataFormatAdapter2.DataFormat).FileNames.Clear;
    LFileName := SaveCurrentTask2File;

    if LFileName <> '' then
      //���� �̸��� ������ ���� OnGetStream �Լ��� �� Ž
      TVirtualFileStreamDataFormat(DataFormatAdapter2.DataFormat).
            FileNames.Add(LFileName);

    DropEmptySource1.Execute;
  end;
end;

procedure THiconisASManageF.TDTFJvLabel7Click(Sender: TObject);
//var
//  rec    : TOLMsgFileRecord;
//  LOmniValue: TOmniValue;
begin
//  rec.FEntryId := '999999999999';
//  rec.FStoreId := '444444444444';
//  rec.FSender := 'pjh@Sender.com';
//  rec.FReceiveDate := now-1;
//  rec.FReceiver := 'pjh@Receiver.com';
//  rec.FCarbonCopy := 'pjh@cc.com';
//  rec.FBlindCC := 'pjh@bcc.com';
//  rec.FSubject := 'subject ttttttttttttt';
//
//  LOmniValue := TOmniValue.FromRecord<TOLMsgFileRecord>(rec);
//  FIPCMQFromOL.Enqueue(TOmniMessage.Create(1, LOmniValue));
end;

procedure THiconisASManageF.TDTFJvLabel8Click(Sender: TObject);
begin
  TestRemoteTaskList
end;

procedure THiconisASManageF.TDTFN16Click(Sender: TObject);
begin
  TDTF.N16Click(Sender);

end;

procedure THiconisASManageF.TDTFrg_periodClick(Sender: TObject);
begin
  TDTF.rg_periodClick(Sender);
end;

procedure THiconisASManageF.TDTFShowTaskID1Click(Sender: TObject);
begin
  TDTF.ShowTaskID1Click(Sender);

end;

procedure THiconisASManageF.TestRemoteTaskDetail;
var
  LUtf8, LResult: RawUTF8;
  LIdList: TIDList;
begin
  LIdList := TIDList(TDTF.grid_Req.Row[TDTF.grid_Req.SelectedRow].Data);
  LUtf8 := ObjectToJson(LIdList);
  LUtf8 := MakeCommand4Server(CMD_REQ_TASK_DETAIL, LUtf8);
  LUtf8 := ServerExecuteFromClient(LUtf8);
  LUtf8 := MakeBase64ToUTF8(LUtf8);
  TDTF.ShowTaskFormFromJson(LUtf8);
end;

procedure THiconisASManageF.TestRemoteTaskEmailList(ATask: TSQLGSTask);
var
  LViewMailListF: TEmailListViewF;
  LUtf8: RawUTF8;
begin
  LViewMailListF := TEmailListViewF.Create(nil);
  try
    begin
//      LViewMailListF.FTask := ATask;
      LUtf8 := IntToStr(ATask.TaskID);
      LUtf8 := MakeCommand4Server(CMD_REQ_TASK_EAMIL_LIST, LUtf8);
      LUtf8 := ServerExecuteFromClient(LUtf8);
      LUtf8 := MakeBase64ToUTF8(LUtf8);
      ShowEmailListFromJson(LViewMailListF.FrameOLMailList.grid_Mail, LUtf8);

      if LViewMailListF.ShowModal = mrOK then
      begin
      end;
    end;
  finally
    LViewMailListF.Free;
  end;
end;

procedure THiconisASManageF.TestRemoteTaskList;
var
  LSearchCondRec: TSearchCondRec;
  LUtf8, LResult: RawUTF8;
begin
  TDTF.GetSearchCondRec(LSearchCondRec);
  LUtf8 := RecordSaveJson(LSearchCondRec, TypeInfo(TSearchCondRec));
  LResult := MakeCommand4Server(CMD_REQ_TASK_LIST, LUtf8);
  LResult := ServerExecuteFromClient(LResult);
  LResult := MakeBase64ToUTF8(LResult);
  TDTF.DisplayTaskInfo2GridFromJson(LResult);
end;

procedure THiconisASManageF.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;

//  if TDTF.FSettings.WSEnabled then
//    InitNetwork;

  TDTF.FUserList.Add(TDTF.GetMyName(g_MyEmailInfo.SmtpAddress)+'='+g_MyEmailInfo.SmtpAddress);
  TDTF.FillInUserList;
  TDTF.PICCB.Items.Assign(TDTF.FUserList);
  TDTF.PICCB.ItemIndex := -1;
end;

procedure THiconisASManageF.ViewTariff1Click(Sender: TObject);
var
  LDoc: variant;
begin
  LDoc := LoadGSTariff2VariantFromCompanyCodeNYear('0001056374', YearOf(now));
  //LDoc: [] �迭 ������
  DisplayTariff(LDoc);
end;

{ TWorker4OLMsg }

constructor TWorker4OLMsg.Create(DBMsgQueue, IPCQueue: TOmniMessageQueue);
begin
  inherited Create;

  FreeOnTerminate := True;
  FDBMsgQueue := DBMsgQueue;
  FIPCMQFromOL:= IPCQueue;
end;

destructor TWorker4OLMsg.Destroy;
begin
  FreeAndNil(FStopEvent);

  inherited;
end;

procedure TWorker4OLMsg.Execute;
var
  handles: array [0..1] of THandle;
  msg    : TOmniMessage;
  rec    : TOLMsgFileRecord;
//  LOmniValue: TOmniValue;
begin
//  handles[0] := FStopEvent.Handle;
//  handles[1] := FIPCMQFromOL.GetNewMessageEvent;
//
//  while WaitForMultipleObjects(2, @handles, false, INFINITE) = (WAIT_OBJECT_0 + 1) do
//  begin
//    if terminated then
//      break;
//
//    while FIPCMQFromOL.TryDequeue(msg) do
//    begin
//      rec := msg.MsgData.ToRecord<TOLMsgFileRecord>;
////      LOmniValue := TOmniValue.FromRecord<TOLMsgFileRecord>(rec);
//      Parallel.Async(
//        procedure (const task: IOmniTask)
//        begin
//          ShowMessage(rec.FSubject);
////          task.Comm.Send(WM_OLMSG_RESULT, msg.MsgData);
//        end);
//    end;
//  end;
end;

procedure TWorker4OLMsg.Stop;
begin
  FStopEvent.SetEvent;
end;

{ TOLMailCallback }

procedure TOLMailCallback.ClientExecute(const command, msg: string);
begin

end;

{ TServiceIM4WS }

procedure TServiceIM4WS.CallbackReleased(const callback: IInvokable;
  const interfaceName: RawUTF8);
begin

end;

constructor TServiceIM4WS.Create;
begin
  FClientInfoList :=  TStringList.Create;
end;

destructor TServiceIM4WS.Destroy;
var
  i: integer;
begin
//  for i := 0 to FClientInfoList.Count - 1 do
//    TClientInfo(FClientInfoList.Objects[i]).Free;

  FClientInfoList.Free;

  inherited;
end;

procedure TServiceIM4WS.Join(const pseudo: string;
  const callback: IHiconisASCallback);
begin

end;

function TServiceIM4WS.ServerExecute(const Acommand: RawUTF8): RawUTF8;
begin
  Result := HiconisASManageF.ServerExecuteFromClient(ACommand);
end;

end.
