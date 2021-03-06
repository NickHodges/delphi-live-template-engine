unit TestuBaseScriptEngine;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, uBaseScriptEngine, CodeTemplateAPI, Classes, ToolsAPI;

type
  // Test methods for class TBaseScriptEngine

  TestTBaseScriptEngine = class(TTestCase)
  strict private
    FBaseScriptEngine: TBaseScriptEngine;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestFetchScriptInfo;
    procedure TestGetIDString;
    procedure TestProcessScriptEntry;
  end;

implementation

procedure TestTBaseScriptEngine.SetUp;
begin

end;

procedure TestTBaseScriptEngine.TearDown;
begin

end;

procedure TestTBaseScriptEngine.TestFetchScriptInfo;
begin

end;

procedure TestTBaseScriptEngine.TestGetIDString;
begin
end;

procedure TestTBaseScriptEngine.TestProcessScriptEntry;
begin

end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTBaseScriptEngine.Suite);
end.

