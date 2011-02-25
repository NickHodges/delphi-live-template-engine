unit uBaseScriptEngine;

interface

uses
        CodeTemplateAPI
      , ToolsAPI
      , Classes
      ;

type
  TBaseScriptEngine = class abstract(TNotifierObject, IOTACodeTemplateScriptEngine)
  private
    FScriptInfo: TStrings;
    procedure FetchScriptInfo(const AScript: IOTACodeTemplateScript);
    function GetScriptInfo: TStrings;
  protected
    function GetIDString: WideString; virtual; abstract;
    function GetLanguage: WideString; virtual; abstract;
    procedure ProcessScriptEntry(const aPoint: IOTACodeTemplatePoint; const aName: string; const aValue: string); virtual; abstract;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute(const ATemplate: IOTACodeTemplate; const APoint: IOTACodeTemplatePoint; const ASyncPoints: IOTASyncEditPoints; const AScript: IOTACodeTemplateScript; var Cancel: Boolean); virtual;
    property Language: WideString read GetLanguage;
    property ScriptInfo: TStrings read GetScriptInfo;
  end;

implementation

uses
       SysUtils
     ;

{ TBaseScriptEngine }

constructor TBaseScriptEngine.Create;
begin
  inherited Create;
end;

destructor TBaseScriptEngine.Destroy;
begin
  FScriptInfo.Free;
  inherited;
end;

procedure TBaseScriptEngine.Execute(const ATemplate: IOTACodeTemplate;
  const APoint: IOTACodeTemplatePoint; const ASyncPoints: IOTASyncEditPoints;
  const AScript: IOTACodeTemplateScript; var Cancel: Boolean);
var
  i: Integer;
  TempName: string;
  TempPoint: IOTACodeTemplatePoint;
begin
  FetchScriptInfo(aScript);

  for i := 0 to ScriptInfo.Count - 1 do
  begin
    TempName := Scriptinfo.Names[i];
    TempPoint := aTemplate.FindPoint(TempName);
    ProcessScriptEntry(TempPoint, TempName, ScriptInfo.Values[TempName]);
  end;

end;

procedure TBaseScriptEngine.FetchScriptInfo(const AScript: IOTACodeTemplateScript);
var
  Counter: Integer;
begin
  ScriptInfo.Text := AScript.Script;
  // Trim each item in the stringlist
  for Counter := 0 to ScriptInfo.Count - 1 do
  begin
    ScriptInfo[Counter] := Trim(ScriptInfo[Counter]);
  end;
end;

function TBaseScriptEngine.GetScriptInfo: TStrings;
begin
  if FScriptInfo = nil then
  begin
    FScriptInfo := TStringList.Create
  end;
  Result := FScriptInfo;
end;


end.
