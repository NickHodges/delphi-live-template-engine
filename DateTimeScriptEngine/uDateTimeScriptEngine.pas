unit uDateTimeScriptEngine;

interface

uses
         uBaseScriptEngine
       , CodeTemplateAPI
       , ToolsAPI
       ;

type
  TDateTimeScriptEngine = class(TBaseScriptEngine)
  private
    const
      cDateFormatStr = 'dateformatstr';
      cTimeFormatStr = 'timeformatstr';
    procedure RemoveFormatStrings;
    procedure DeleteIfExists(i: Integer);
  private
    FDateFormatString: string;
    FTimeFormatString: string;
    procedure GetFormatStrings;
    function GetTimeString: string;
    function GetDateString: string;
  protected
    function GetIDString: WideString; override;
    function GetLanguage: WideString; override;
    procedure ProcessScriptEntry(const aPoint: IOTACodeTemplatePoint; const aName: string; const aValue: string); override;
  public
    procedure Execute(const ATemplate: IOTACodeTemplate; const APoint: IOTACodeTemplatePoint; const ASyncPoints: IOTASyncEditPoints; const AScript: IOTACodeTemplateScript; var Cancel: Boolean); override;
  end;

  procedure Register;

implementation

uses
        DateUtils
      , SysUtils
      , NixUtils
      ;

procedure Register;
begin
  (BorlandIDEServices as IOTACodeTemplateServices).RegisterScriptEngine(TDateTimeScriptEngine.Create);
end;

{ TDateTimeScriptEngine }

procedure TDateTimeScriptEngine.Execute(const ATemplate: IOTACodeTemplate;
  const APoint: IOTACodeTemplatePoint; const ASyncPoints: IOTASyncEditPoints;
  const AScript: IOTACodeTemplateScript; var Cancel: Boolean);
var
  TempPoint: IOTACodeTemplatePoint;
  i: integer;
  TempPointName: string;
  TempFunctionName: string;
  TempDate: string;
  TempTime: string;
const
  cDate = 'InsertDate';
  cTime = 'InsertTime';
  cDateTime = 'InsertDateTime';
begin
  inherited;
  GetFormatStrings;
  for i := 0 to ScriptInfo.Count - 1 do
  begin
     {
      In the script, the items are set up as follows:

      TempPointName=TempFunctionName

      where

      * TempPointName is the name of the point in the live template that is
      to be replaced by the script
      * TempFunctionName is the name given to the action to be taken.

      In this procedure, we'll be handling those TempFunctionName values.
    }
    TempPointName := ScriptInfo.Names[i];
    TempFunctionName := ScriptInfo.Values[TempPointName];
    if (ATemplate <> nil) then
    begin
      TempPoint := aTemplate.FindPoint(TempPointName);
      if TempPoint <> nil then
      begin
        TempPoint.Editable := False;
        if TempFunctionName = cDate then
        begin
          TempPoint.Value := GetDateString;
        end else
        begin
          if TempFunctionName = cTime then
          begin
            TempPoint.Value := GetTimeString;
          end else
          begin
            if  TempFunctionName = cDateTime then
            begin
              TempDate := GetDateString;
              TempTime := GetTimeString;
              TempPoint.Value := Format('%s %s', [TempDate, TempTime]);;
            end;
          end;
        end;
      end;
    end;
  end;
  Cancel := False;
end;


procedure TDateTimeScriptEngine.DeleteIfExists(i: Integer);
begin
  if i > 0 then
  begin
    ScriptInfo.Delete(i);
  end;
end;

function StringIsNotEmpty(Str: string): Boolean;
begin
  Result := not StringIsEmpty(Str);
end;

function TDateTimeScriptEngine.GetDateString: string;
begin
  // First look for format string.....
  if StringIsNotEmpty(FDateFormatString) then
  begin
    Result := FormatDateTime(FDateFormatString, Now);
  end else
  begin
    Result := DateToStr(Now);
  end;
end;

procedure TDateTimeScriptEngine.GetFormatStrings;
begin

end;

//procedure TDateTimeScriptEngine.GetFormatStrings;
//begin
//  // Pull the formatting strings out of the script string
//  FDateFormatString := ScriptInfo.Values[cDateFormatStr];
//  FTimeFormatString := ScriptInfo.Values[cTimeFormatStr];
//  // Once you have them, get rid of entries in string list
////  RemoveFormatStrings;
//end;

function TDateTimeScriptEngine.GetIDString: WideString;
begin
  // This function is required by the IOTACodeTemplateScriptEngine
  // interface, and needs a unique identifier.  A GUID is unique as
  // they come, no?
  Result := '{5A866B09-828F-425C-99B6-4FDA2C446D3A}';
end;

function TDateTimeScriptEngine.GetLanguage: WideString;
begin
  // Should return a name for the scripting engine.  This will be used
  // in the Live Template to identify the script engine to use.
  Result := 'DateTimeScript';
end;

function TDateTimeScriptEngine.GetTimeString: string;
begin
  // First check for formatting string.....
  if StringIsNotEmpty(FTimeFormatString) then
  begin
    Result := FormatDateTime(FTimeFormatString, Now);
  end else
  begin
    Result := TimeToStr(Now);
  end;
end;

procedure TDateTimeScriptEngine.ProcessScriptEntry(const aPoint: IOTACodeTemplatePoint; const aName:string; const aValue: string);
begin

end;

procedure TDateTimeScriptEngine.RemoveFormatStrings;
begin

end;

end.
