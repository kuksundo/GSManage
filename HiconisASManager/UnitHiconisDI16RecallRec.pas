unit UnitHiconisDI16RecallRec;

interface

uses SysUtils, Classes, Generics.Collections, Forms,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os,
  mormot.core.data, mormot.core.variants, mormot.core.collections,
  mormot.core.datetime, mormot.core.json;

type
  THiASDI16RecallRec = packed record
    HullNo,
    VesselDeliveryDate,
    PIC,
    OrderQuantity,
    NumOfInstalled,
    NumOfSpare,
    NumOfTotalSupplied, //NumOfInstalled + NumOfSpare
    NumOfDefective,
    NumOfRecall,
    NumOfWarehoused,//입고여부: 예상일자 또는 Y
    PartDeliveryDate2Customer,//송품일
    OnBoardDate,//방선조치일
    Notes:
    RawUTF8;
  end;

  THiASDI16RecallDict = IKeyValue<string, THiASDI16RecallRec>;

implementation

end.
