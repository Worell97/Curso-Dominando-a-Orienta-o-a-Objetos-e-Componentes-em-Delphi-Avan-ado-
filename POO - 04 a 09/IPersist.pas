unit IPersist;

interface

uses
	System.Variants, System.Classes, db, System.SysUtils, DBTables, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.Dapt;

type
	TTableEvent = procedure(Sender : TObject; var CanExecute : Boolean) of Object;

	TMyFieldType = (ftString, ftMemo, ftFloat, ftData, ftInteger, ftUnknow);

  TPK = array of string;

	IField = interface
  ['{B9C38549-2E2D-46BA-8CA8-EFEFAA563AC3}']
    function GetName : string;
    function GetValue : Variant;
    function GetFieldType : TMyFieldType;
    function GetIsPk : Boolean;


    function GetString : string;
    function GetFloat : Double;
    function GetDate : TDateTime;
    function GetInteger : Integer;
    function GetAsValue : Variant;
    function GetIsModified: Boolean;

    procedure SetName(AName : string);
    procedure SetValue(AValue : Variant);
    procedure SetFieldType(AFieldType : TMyFieldType);
    procedure SetIsPk(AIsPk : Boolean);

    procedure SetString(AString : string);
    procedure SetFloat(AFloat : Double);
    procedure SetDate(ADate : TDateTime);
    procedure SetInteger(AInteger : Integer);
    procedure SetAsValue(AValue : Variant);

    property Name: String read GetName write SetName;
    property FieldType: TMyFieldType read GetFieldType write SetFieldType;
    property IsPk: Boolean read GetIsPK write SetIsPk;
    property IsModified: Boolean read GetIsModified;

    property asString : string read GetString write SetString;
    property asFloat : Double read GetFloat write SetFloat;
    property asDate : TDateTime read GetDate write SetDate;
    property asInteger : Integer read GetInteger write SetInteger;
    property asValue : Variant read GetAsValue write SetAsValue;
  end;

  ITable = interface
  ['{F28A59FB-4649-4BD5-8C15-8D1542ECE948}']
  	function GetTableName: String;
    function GetIFields(index : Integer): IFIeld;
    function FieldCount: Integer;
    function FieldByName(AName : string): IField;
    function GetLog: Boolean;
    function GetFileLog: string;
    function Insert(): Integer;
    function Update(): Integer;
    function Delete(): Integer;
    function Select(AFields : string): Boolean;
    function GetOnBeforeInsert: TTableEvent;
    function GetOnBeforeUpdate: TTableEvent;
    function GetOnBeforeDelete: TTableEvent;

    procedure SetTableName(ATableName : string);
    procedure SetLog(AValue : Boolean);
    procedure SetFileLog(AFileLog : string);
    procedure SetOnBeforeInsert(AValue : TTableEvent);
    procedure SetOnBeforeUpdate(AValue : TTableEvent);
    procedure SetOnBeforeDelete(AValue : TTableEvent);


    property TableName : string read GetTableName write SetTableName;
    property Fields[index : Integer] : IField read GetIFIelds;
    property UseLog	: Boolean read GetLog write SetLog;
    property FileLog : string read GetFileLog write SetFileLog;
    property OnBeforeInsert : TTableEvent read GetOnBeforeInsert write SetOnBeforeInsert;
    property OnBeforeUpdate : TTableEvent read GetOnBeforeUpdate write SetOnBeforeUpdate;
    property OnBeforeDelete : TTableEvent read GetOnBeforeDelete write SetOnBeforeDelete;
  end;

	//****************************Classes********************************************************
  TUtil = class
   class function VarToDateTime(AValue : Variant): TDateTime;
   class function VarToString(AValue : Variant): String;
   class function VarToInteger(AValue : Variant): Integer;
   class function VarToFloat(AValue : Variant): Double;
   class function FieldTypeToMyFieldType(AValue: TFieldType): TMyFieldType;
   class function MyFieldTypeToStr(AField : TMyFieldType) : string;

   class function GetInterfaceByPointer(APoiter : IUnknown) : Pointer;
   class procedure ReleaseInterfaceByPointer(APointer : Pointer);

  end;
  TField = class(TInterfacedObject, IFIeld)
  	private
    	FName: String;
      FFieldType: TMyFieldType;
      FIsPk: Boolean;
      FValue: Variant;
      FIsModified : Boolean;

  	protected
      function GetName : string; virtual;
      function GetValue : Variant; virtual;
      function GetFieldType : TMyFieldType; virtual;
      function GetIsPk : Boolean; virtual;


      function GetString : string; virtual;
      function GetFloat : Double; virtual;
      function GetDate : TDateTime; virtual;
      function GetInteger : Integer; virtual;
      function GetAsValue : Variant; virtual;
    	function GetIsModified: Boolean;

      procedure SetName(AName : string); virtual;
      procedure SetValue(AValue : Variant); virtual;
      procedure SetFieldType(AFieldType : TMyFieldType); virtual;
      procedure SetIsPk(AIsPk : Boolean); virtual;

      procedure SetString(AString : string); virtual;
      procedure SetFloat(AFloat : Double); virtual;
      procedure SetDate(ADate : TDateTime); virtual;
      procedure SetInteger(AInteger : Integer); virtual;
      procedure SetAsValue(AValue : Variant); virtual;
    public
    	constructor Create(AName: string; AFieldType : TMyFieldType; AIsPk : Boolean);
  end;

  TTable = class(TInterfacedObject, ITable)
  	private
      FConnection : TFDConnection;
      FTableName : string;
      FList : TList;
      FPK : Array of string;
      FLog : Boolean;
      FFileLog : string;
      FOnBeforeDelete: TTableEvent;
      FOnBeforeUpdate: TTableEvent;
      FOnBeforeInsert: TTableEvent;

			function hasFieldModified():Boolean;
      procedure doFreeList;
  	protected
    	function GetTableName: String; virtual;
    	function GetIFields(index : Integer): IFIeld; virtual;
      function FieldCount(): Integer; virtual;
      function FieldByName(AFieldName : string): IField; virtual;
      function IsPk(AField : String):Boolean;
      function GetLog : Boolean;
    	function GetFileLog: string;
      function GetOnBeforeInsert: TTableEvent;
      function GetOnBeforeUpdate: TTableEvent;
      function GetOnBeforeDelete: TTableEvent;

    	procedure SetTableName(ATableName : string); virtual;

      procedure doLoadFields; virtual;
      procedure doCopyPk(LPk : array of string);
      procedure SetLog(AValue : Boolean);
    	procedure SetFileLog(AFileLog : string);
      procedure SetOnBeforeInsert(AValue : TTableEvent);
      procedure SetOnBeforeUpdate(AValue : TTableEvent);
      procedure SetOnBeforeDelete(AValue : TTableEvent);

    public
      function Insert(): Integer;
      function Update(): Integer;
      function Delete(): Integer;
    	function Select(AFields : string): Boolean;

    	constructor Create(AConnection : TFDConnection ; ATableName : string; LPk : array of String);
      destructor Destroy; override;

  end;

implementation

{ TField }

constructor TField.Create(AName: string; AFieldType : TMyFieldType; AIsPk : Boolean);
begin
  inherited Create;

  if (AFieldType = IPersist.ftUnknow) then
  	raise Exception.Create('Tipo de campo ['+AName+'] inválido');
  
  FName := AName;
  FFieldType := AFieldType;
  FIsPk := AIsPk;
  FValue := null;
  FIsModified := False;
end;

function TField.GetAsValue: Variant;
begin
	Result := FValue;
end;

function TField.GetDate: TDateTime;
begin
	Result := TUtil.VarToDateTime(FValue);
end;

function TField.GetFieldType: TMyFieldType;
begin
  Result := FFieldType;
end;

function TField.GetFloat: Double;
begin
	Result := TUtil.VarToFloat(FValue);
end;

function TField.GetInteger: Integer;
begin
	Result := TUtil.VarToInteger(FValue);
end;

function TField.GetIsModified: Boolean;
begin
	Result := FIsModified;
end;

function TField.GetIsPk: Boolean;
begin
	Result := FIsPk;
end;

function TField.GetName: string;
begin
	Result := UpperCase(FName);
end;

function TField.GetString: string;
begin
	Result := TUtil.VarToString(FValue);
end;

function TField.GetValue: Variant;
begin
	Result := FValue;
end;

procedure TField.SetAsValue(AValue: Variant);
begin
	if AValue <> FValue then
  begin
	  FValue := AValue;
    FIsModified := True;
  end;
end;

procedure TField.SetDate(ADate: TDateTime);
begin
	if ADate <> FValue then
  begin
	  FValue := ADate;
    FIsModified := True;
  end;
end;

procedure TField.SetFieldType(AFieldType: TMyFieldType);
begin
	FFieldType := AFieldType;
end;

procedure TField.SetFloat(AFloat: Double);
begin
	if AFloat <> FValue then
  begin
	  FValue := AFloat;
    FIsModified := True;
  end;
end;

procedure TField.SetInteger(AInteger: Integer);
begin
	if AInteger <> FValue then
  begin
	  FValue := AInteger;
    FIsModified := True;
  end;
end;

procedure TField.SetIsPk(AIsPk: Boolean);
begin
	FIsPk := AIsPk;
end;

procedure TField.SetName(AName: string);
begin
	FName := UpperCase(AName);
end;

procedure TField.SetString(AString: string);
begin
	if AString <> FValue then
  begin
	  FValue := AString;
    FIsModified := True;
  end;
end;

procedure TField.SetValue(AValue: Variant);
begin
	if AValue <> FValue then
  begin
	  FValue := AValue;
    FIsModified := True;
  end;
end;

{ TConvert }

class function TUtil.FieldTypeToMyFieldType(AValue: TFieldType): TMyFieldType;
begin
	Result := IPersist.ftUnknow;
 	case AValue of
    db.ftString: Result := IPersist.ftString;

    db.ftSmallint,
    db.ftInteger,
    db.ftWord,
    db.ftLargeint: Result := IPersist.ftInteger;

    db.ftFloat,
    db.ftCurrency,
    db.ftBCD: Result := IPersist.ftFloat;

    db.ftDate,
    db.ftTime,
    db.ftDateTime,
    db.ftTimeStamp: Result := IPersist.ftData;

    db.ftBlob,
    db.ftMemo,
    db.ftFmtMemo: Result := IPersist.ftMemo;
  end;
end;

class function TUtil.GetInterfaceByPointer(APoiter: IInterface): Pointer;
begin
  APoiter._AddRef;
  Result := Pointer(APoiter);
end;

class function TUtil.MyFieldTypeToStr(AField: TMyFieldType): string;
begin

end;

class procedure TUtil.ReleaseInterfaceByPointer(APointer: Pointer);
var
	I: IUnknown;
begin
 	Pointer(I) := APointer;
end;

class function TUtil.VarToDateTime(AValue: Variant): TDateTime;
begin
	try
    Result := System.Variants.VarToDateTime(AValue);
  except
    Result := 0;
  end;
end;

class function TUtil.VarToFloat(AValue: Variant): Double;
begin
	try
    Result := AValue;
  except
    Result := 0;
  end;
end;

class function TUtil.VarToInteger(AValue: Variant): Integer;
begin
	try
    Result := AValue;
  except
    Result := 0;
  end;
end;

class function TUtil.VarToString(AValue: Variant): String;
begin
	try
    Result := System.Variants.VarToStr(AValue);
  except
    Result := '';
  end;
end;

{ TTable }

constructor TTable.Create(AConnection : TFDConnection ; ATAbleName : string; LPk : array of String);
begin
  inherited Create;
  FConnection := AConnection;
  FTableName := ATAbleName;
  FList := TList.Create;
	FLog := False;

  doCopyPK(LPk);
  doLoadFields;
end;

function TTable.Delete: Integer;
var
	LQuery : TFDQuery;
  I : Integer;
  LFieldName : string;
  LFieldValue : Variant;
  LSeparador : String;
  LCanExecute : Boolean;
begin
	Result := 0;
  try
    LQuery := TFDQuery.Create(nil);
    try
      if hasFieldModified then
      begin
    		LQuery.Connection := FConnection;
        LQuery.SQL.Add(' DELETE FROM '+FTableName);

        LQuery.SQL.Add(' WHERE ');
        LSeparador := '';
        for I := 0 to FieldCount - 1 do
        	if GetIFields(I).IsPk then
          begin
          	LFieldName := GetIFields(I).Name;
		        LQuery.SQL.Add(LSeparador + LFieldName + ' = :'+LFieldName);
        		LSeparador := ' AND ';
          end;


        //Param List
        LSeparador := '';
        for I := 0 to FieldCount - 1 do
        	if GetIFields(I).IsPk then
          begin
          	LFieldName := GetIFields(I).Name;
            LFieldValue := GetIFields(I).AsValue;
						case GetIFields(I).FieldType of
            	ftString :
              	begin
                	LQuery.ParamByName(LFieldName).DataType := db.ftString;
                  LQuery.ParamByName(LFieldName).Value := LFieldValue;
              	end;
              ftMemo:
              	begin
                	LQuery.ParamByName(LFieldName).DataType := db.ftMemo;
                  LQuery.ParamByName(LFieldName).Value := LFieldValue;
              	end;
              ftFloat:
              	begin
                	LQuery.ParamByName(LFieldName).DataType := db.ftFloat;
                  LQuery.ParamByName(LFieldName).Value := LFieldValue;
              	end;
              ftData:
              	begin
                	if GetIFields(I).asDate = 0 then
                  	LFieldValue := null
                  else
                    LFieldValue := GetIFields(I).asDate;

                	LQuery.ParamByName(LFieldName).DataType := db.ftDate;
                  LQuery.ParamByName(LFieldName).Value := LFieldValue;
              	end;
              ftInteger:
              	begin
                	LQuery.ParamByName(LFieldName).DataType := db.ftInteger;
                  LQuery.ParamByName(LFieldName).Value := LFieldValue;
              	end;
              ftUnknow:
            else
              raise Exception.Create('Campo: ' + LFieldName +' com tipo de dado não esperado.');
            end;
          end;

      end else
        Exit;

      if ITable(Self).UseLog then
      begin
        if Trim(ITable(Self).FileLog) = '' then
        	raise Exception.Create('FileLog não pode ser vazio');

        LQuery.SQL.SaveToFile(ITable(Self).FileLog);
      end;

      LCanExecute := True;
      //Verifica se o evento foi programado
      if Assigned(FOnBeforeDelete) then
      	FOnBeforeDelete(Self, LCanExecute);

      if not(LCanExecute) then
      	raise Exception.Create('Processo interrompido pelo usuário');

      LQuery.ExecSQL;
      Result := LQuery.RowsAffected;

    finally
    	LQuery.Close;
    end;
  except
  	on E : Exception do
    	raise Exception.Create(E.Message + ' on TTable.Update.');
  end;
end;

destructor TTable.Destroy;
begin
	doFreeList;
  inherited;
end;

procedure TTable.doCopyPk(LPk: array of string);
var
	LTam,
  LCount : Integer;
begin
	LTam := High(LPk);
  SetLength(FPk, LTam + 1);
  for LCount := Low(LPk) to LTam do
  	FPK[LTam] := LPk[LCount];
end;

procedure TTable.doFreeList;
var
	I : Integer;
begin
	for I := FList.Count - 1 downto 0 do
  begin
    TUtil.ReleaseInterfaceByPointer(FList[I]);
    FList[I] := nil;
  end;
  FList.Pack;
  FList.Free;
end;

procedure TTable.doLoadFields;
var
	LQuery : TFDQuery;
  I : Integer;
  LField : IField;
begin
	LQuery := TFDQuery.Create(nil);
  try
  	LQuery.Connection := FConnection;
    LQuery.SQL.Clear;
    LQuery.SQL.Add('SELECT * FROM ' + ITable(Self).TableName + ' WHERE 1 = 2');
    LQuery.Open;

    for I := 0 to LQuery.FieldCount - 1 do
    begin
      LField := TField.Create(LQuery.Fields[I].FieldName, TUtil.FieldTypeToMyFieldType(LQuery.Fields[I].DataType),
      						IsPk(LQuery.Fields[I].FieldName));

      FList.Add(TUtil.GetInterfaceByPointer(LField));
    end;


  finally
    LQuery.Close;
    LQuery.Free;
  end;
end;

function TTable.FieldByName(AFieldName: string): IField;
var
	I : Integer;
begin
	Result := nil;
  AFieldName := UpperCase(AFieldName);
  for I := 0 to FieldCount - 1 do
  	if ITable(Self).Fields[I].Name = AFieldName then
    begin
    	Result := ITable(Self).Fields[I];
      Break;
    end;
end;

function TTable.FieldCount: Integer;
begin
	Result := FList.Count;
end;

function TTable.GetFileLog: string;
begin
	Result := FFileLog;
end;

function TTable.GetIFields(index: Integer): IFIeld;
begin
	if index < 0 then
  	raise Exception.Create('Indice fora da lista');

  if index > (FList.Count - 1) then
  	raise Exception.Create('Indice fora da lista');

	Result := IUnknown(FList.Items[index]) as IFIeld;
end;

function TTable.GetLog: Boolean;
begin
	Result := FLog;
end;

function TTable.GetOnBeforeDelete: TTableEvent;
begin
	Result := FOnBeforeDelete;
end;

function TTable.GetOnBeforeInsert: TTableEvent;
begin
	Result := FOnBeforeInsert;
end;

function TTable.GetOnBeforeUpdate: TTableEvent;
begin
	Result := FOnBeforeUpdate;
end;

function TTable.GetTableName: String;
begin
	Result := FTableName;
end;

function TTable.hasFieldModified: Boolean;
var
	I : Integer;
begin
	Result := false;
	for I := 0 to FieldCount - 1 do
  begin
  	if GetIFields(I).IsModified then
		begin
      Result := True;
      Break;
    end;
  end;
end;

function TTable.Insert: Integer;
var
	LQuery : TFDQuery;
  I : Integer;
  LFieldName : string;
  LFieldValue : Variant;
  LSeparador : String;
  LCanExecute : Boolean;
begin
	Result := 0;
  try
    LQuery := TFDQuery.Create(nil);
    try
      if hasFieldModified then
      begin
    		LQuery.Connection := FConnection;
        LQuery.SQL.Add(' INSERT INTO '+FTableName);
        LQuery.SQL.Add(' (');
        LSeparador := '';
        //Fields
        for I := 0 to FieldCount - 1 do
        	if GetIFields(I).IsModified then
          begin
          	LFieldName := GetIFields(I).Name;
		        LQuery.SQL.Add(LSeparador + LFieldName);
        		LSeparador := ',';
          end;

        LQuery.SQL.Add(' )');

        //Values
        LQuery.SQL.Add(' VALUES');
        LQuery.SQL.Add(' (');
        LSeparador := '';
        for I := 0 to FieldCount - 1 do
        	if GetIFields(I).IsModified then
          begin
          	LFieldName := GetIFields(I).Name;
		        LQuery.SQL.Add(LSeparador +':'+ LFieldName);
        		LSeparador := ',';
          end;

        LQuery.SQL.Add(' )');

        //Param List
        LSeparador := '';
        for I := 0 to FieldCount - 1 do
        	if GetIFields(I).IsModified then
          begin
          	LFieldName := GetIFields(I).Name;
            LFieldValue := GetIFields(I).AsValue;
						case GetIFields(I).FieldType of
            	ftString :
              	begin
                	LQuery.ParamByName(LFieldName).DataType := db.ftString;
                  LQuery.ParamByName(LFieldName).Value := LFieldValue;
              	end;
              ftMemo:
              	begin
                	LQuery.ParamByName(LFieldName).DataType := db.ftMemo;
                  LQuery.ParamByName(LFieldName).Value := LFieldValue;
              	end;
              ftFloat:
              	begin
                	LQuery.ParamByName(LFieldName).DataType := db.ftFloat;
                  LQuery.ParamByName(LFieldName).Value := LFieldValue;
              	end;
              ftData:
              	begin
                	if GetIFields(I).asDate = 0 then
                  	LFieldValue := null
                  else
                    LFieldValue := GetIFields(I).asDate;

                	LQuery.ParamByName(LFieldName).DataType := db.ftDate;
                  LQuery.ParamByName(LFieldName).Value := LFieldValue;
              	end;
              ftInteger:
              	begin
                	LQuery.ParamByName(LFieldName).DataType := db.ftInteger;
                  LQuery.ParamByName(LFieldName).Value := LFieldValue;
              	end;
              ftUnknow:
            else
              raise Exception.Create('Campo: ' + LFieldName +' com tipo de dado não esperado.');
            end;
          end;

      end else
        Exit;

      if ITable(Self).UseLog then
      begin
        if Trim(ITable(Self).FileLog) = '' then
        	raise Exception.Create('FileLog não pode ser vazio');

        LQuery.SQL.SaveToFile(ITable(Self).FileLog);
      end;

      LCanExecute := True;
      //Verifica se o evento foi programado
      if Assigned(FOnBeforeInsert) then
      	FOnBeforeInsert(Self, LCanExecute);

      if not(LCanExecute) then
      	raise Exception.Create('Processo interrompido pelo usuário');

      LQuery.ExecSQL;
      Result := LQuery.RowsAffected;

    finally
    	LQuery.Close;
    end;
  except
  	on E : Exception do
    	raise Exception.Create(E.Message + ' on TTable.Insert.');
  end;
end;

function TTable.IsPk(AField: String): Boolean;
var
	I : Integer;
begin
	AField := UpperCase(AField);
  Result := False;
  for I := Low(FPk) to High(FPk) do
  	if UpperCase(FPk[I]) = AField then
    begin
      Result := True;
      Break;
    end;
end;

function TTable.Select(AFields: string): Boolean;
var
	LQuery : TFDQuery;
  I : Integer;
  LFieldName : string;
  LFieldValue : Variant;
  LSeparador : String;
begin
	Result := False;
  try
    LQuery := TFDQuery.Create(nil);
    try
      LQuery.Connection := FConnection;
      LQuery.SQL.Add(' SELECT '+AFields+' FROM '+GetTableName);

      LQuery.SQL.Add(' WHERE ');
      LSeparador := '';
      for I := 0 to FieldCount - 1 do
        if GetIFields(I).IsPk then
        begin
          LFieldName := GetIFields(I).Name;
          LQuery.SQL.Add(LSeparador + LFieldName + ' = :'+LFieldName);
          LSeparador := ' AND ';
        end;


      //Param List
      LSeparador := '';
      for I := 0 to FieldCount - 1 do
        if GetIFields(I).IsModified or GetIFields(I).IsPk then
        begin
          LFieldName := GetIFields(I).Name;
          LFieldValue := GetIFields(I).AsValue;
          case GetIFields(I).FieldType of
            ftString :
              begin
                LQuery.ParamByName(LFieldName).DataType := db.ftString;
                LQuery.ParamByName(LFieldName).Value := LFieldValue;
              end;
            ftMemo:
              begin
                LQuery.ParamByName(LFieldName).DataType := db.ftMemo;
                LQuery.ParamByName(LFieldName).Value := LFieldValue;
              end;
            ftFloat:
              begin
                LQuery.ParamByName(LFieldName).DataType := db.ftFloat;
                LQuery.ParamByName(LFieldName).Value := LFieldValue;
              end;
            ftData:
              begin
                if GetIFields(I).asDate = 0 then
                  LFieldValue := null
                else
                  LFieldValue := GetIFields(I).asDate;

                LQuery.ParamByName(LFieldName).DataType := db.ftDate;
                LQuery.ParamByName(LFieldName).Value := LFieldValue;
              end;
            ftInteger:
              begin
                LQuery.ParamByName(LFieldName).DataType := db.ftInteger;
                LQuery.ParamByName(LFieldName).Value := LFieldValue;
              end;
            ftUnknow:
          else
            raise Exception.Create('Campo: ' + LFieldName +' com tipo de dado não esperado.');
          end;
        end;

      if ITable(Self).UseLog then
      begin
        if Trim(ITable(Self).FileLog) = '' then
        	raise Exception.Create('FileLog não pode ser vazio');

        LQuery.SQL.SaveToFile(ITable(Self).FileLog);
      end;

      LQuery.Open;
      Result := not(LQuery.IsEmpty);

      for I := 0 to LQuery.FieldCount - 1 do
      begin
      	FieldByName(LQuery.Fields[I].FieldName).asValue := null;
        if Result then
	      	FieldByName(LQuery.Fields[I].FieldName).asValue := LQuery.Fields[I].Value;
      end;


    finally
    	LQuery.Close;
    end;
  except
  	on E : Exception do
    	raise Exception.Create(E.Message + ' on TTable.Select.');
  end;
end;

procedure TTable.SetFileLog(AFileLog: string);
begin
	FFileLog := AFileLog;
end;

procedure TTable.SetLog(AValue: Boolean);
begin
	FLog := AValue;
end;

procedure TTable.SetOnBeforeDelete(AValue: TTableEvent);
begin
	FOnBeforeDelete := AValue;
end;

procedure TTable.SetOnBeforeInsert(AValue: TTableEvent);
begin
	FOnBeforeInsert := AValue;
end;

procedure TTable.SetOnBeforeUpdate(AValue: TTableEvent);
begin
	FOnBeforeUpdate := AValue;
end;

procedure TTable.SetTableName(ATableName: string);
begin
	FTableName := ATableName;
end;

function TTable.Update: Integer;
var
	LQuery : TFDQuery;
  I : Integer;
  LFieldName : string;
  LFieldValue : Variant;
  LSeparador : String;
  LCanExecute : Boolean;
begin
	Result := 0;
  try
    LQuery := TFDQuery.Create(nil);
    try
      if hasFieldModified then
      begin
    		LQuery.Connection := FConnection;
        LQuery.SQL.Add(' UPDATE '+FTableName);
        LQuery.SQL.Add(' SET');
        LSeparador := '';
        //Fields
        for I := 0 to FieldCount - 1 do
        	if (GetIFields(I).IsModified) and not(GetIFields(I).IsPk) then
          begin
          	LFieldName := GetIFields(I).Name;
		        LQuery.SQL.Add(LSeparador + LFieldName + ' = :'+LFieldName);
        		LSeparador := ',';
          end;

        LQuery.SQL.Add(' WHERE ');
        LSeparador := '';
        for I := 0 to FieldCount - 1 do
        	if GetIFields(I).IsPk then
          begin
          	LFieldName := GetIFields(I).Name;
		        LQuery.SQL.Add(LSeparador + LFieldName + ' = :'+LFieldName);
        		LSeparador := ' AND ';
          end;


        //Param List
        LSeparador := '';
        for I := 0 to FieldCount - 1 do
        	if GetIFields(I).IsModified or GetIFields(I).IsPk then
          begin
          	LFieldName := GetIFields(I).Name;
            LFieldValue := GetIFields(I).AsValue;
						case GetIFields(I).FieldType of
            	ftString :
              	begin
                	LQuery.ParamByName(LFieldName).DataType := db.ftString;
                  LQuery.ParamByName(LFieldName).Value := LFieldValue;
              	end;
              ftMemo:
              	begin
                	LQuery.ParamByName(LFieldName).DataType := db.ftMemo;
                  LQuery.ParamByName(LFieldName).Value := LFieldValue;
              	end;
              ftFloat:
              	begin
                	LQuery.ParamByName(LFieldName).DataType := db.ftFloat;
                  LQuery.ParamByName(LFieldName).Value := LFieldValue;
              	end;
              ftData:
              	begin
                	if GetIFields(I).asDate = 0 then
                  	LFieldValue := null
                  else
                    LFieldValue := GetIFields(I).asDate;

                	LQuery.ParamByName(LFieldName).DataType := db.ftDate;
                  LQuery.ParamByName(LFieldName).Value := LFieldValue;
              	end;
              ftInteger:
              	begin
                	LQuery.ParamByName(LFieldName).DataType := db.ftInteger;
                  LQuery.ParamByName(LFieldName).Value := LFieldValue;
              	end;
              ftUnknow:
            else
              raise Exception.Create('Campo: ' + LFieldName +' com tipo de dado não esperado.');
            end;
          end;

      end else
        Exit;

      if ITable(Self).UseLog then
      begin
        if Trim(ITable(Self).FileLog) = '' then
        	raise Exception.Create('FileLog não pode ser vazio');

        LQuery.SQL.SaveToFile(ITable(Self).FileLog);
      end;

      LCanExecute := True;
      //Verifica se o evento foi programado
      if Assigned(FOnBeforeUpdate) then
      	FOnBeforeUpdate(Self, LCanExecute);

      if not(LCanExecute) then
      	raise Exception.Create('Processo interrompido pelo usuário');

      LQuery.ExecSQL;
      Result := LQuery.RowsAffected;

    finally
    	LQuery.Close;
    end;
  except
  	on E : Exception do
    	raise Exception.Create(E.Message + ' on TTable.Update.');
  end;
end;

end.
