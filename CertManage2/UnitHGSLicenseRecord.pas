unit UnitHGSLicenseRecord;

interface

uses
  Classes,
  mormot.core.base, mormot.core.variants, mormot.core.datetime, mormot.orm.core,
  mormot.orm.base, mormot.rest.sqlite3,
  UnitCertManager2, UnitVesselData2, UnitHGSCertData, UnitHGSCurriculumData,
  UnitHGSVDRData, UnitJHPFileData, UnitHGSBaseRecord;

type
  TOrmHGSTrainLicense = class(TSQLHGSCertBasic)
  private
    //Education
    fTraineeName,
    fTraineeNation,
    fTrainedSubject,
    fTrainedCourse
    : RawUTF8;
    fCourseLevel: TAcademyCourseLevel;
    fTrainedBeginDate,
    fTrainedEndDate
    :TTimeLog;

    fMailCount: integer;
    FImageData: RawBlob;//±³À°»ý »çÁø
  published
    property TraineeName: RawUTF8 read fTraineeName write fTraineeName;
    property TraineeNation: RawUTF8 read fTraineeNation write fTraineeNation;
    property TrainedSubject: RawUTF8 read fTrainedSubject write fTrainedSubject;
    property TrainedCourse: RawUTF8 read fTrainedCourse write fTrainedCourse;
    property CourseLevel: TAcademyCourseLevel read fCourseLevel write fCourseLevel;
    property TrainedBeginDate: TTimeLog read fTrainedBeginDate write fTrainedBeginDate;
    property TrainedEndDate: TTimeLog read fTrainedEndDate write fTrainedEndDate;
  end;

procedure InitHGSLicenseClient(ADBName: string = '');
function CreateHGSLicenseModel: TSQLModel;
procedure DestroyHGSLicenseClient;

var
  g_HGSLicenseDB: TRestClientDB;
  HGSLicenseModel: TSQLModel;

implementation

procedure InitHGSLicenseClient(ADBName: string = '');
var
  LStr: string;
begin
  if Assigned(g_HGSLicenseDB) then
    exit;

  if AHGSLicenseDBName = '' then
    AHGSLicenseDBName := ChangeFileExt(ExtractFilePath(Application.ExeName),'.sqlite');

  LStr := GetDefaultDBPath;
  LStr := LStr + AHGSLicenseDBName;
  HGSLicenseModel:= CreateHGSLicenseModel;
  g_HGSLicenseDB:= TSQLRestClientDB.Create(HGSLicenseModel, CreateHGSLicenseModel,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(g_HGSLicenseDB).Server.CreateMissingTables;
end;

function CreateHGSLicenseModel: TSQLModel;
begin
  result := TSQLModel.Create([TSQLHGSLicenseRecord, TSQLHGSLicenseFiles]);
end;

procedure DestroyHGSLicenseClient;
begin
  if Assigned(HGSLicenseModel) then
    FreeAndNil(HGSLicenseModel);

  if Assigned(g_HGSLicenseDB) then
    FreeAndNil(g_HGSLicenseDB);
end;

end.
