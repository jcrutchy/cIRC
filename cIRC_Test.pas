unit cIRC_Test;

interface

uses
  Windows,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StrUtils,
  cIRC_Data;

type

  TcIRC_TestMessageData = record
    Command: string;
    Destination: string;
    Hostname: string;
    Nick: string;
    Params: string;
    Prefix: string;
    Trailing: string;    User: string;
  end;

procedure RunTests;

procedure RunServerTests(var Success: Boolean);
procedure RunMessageTests(var Success: Boolean);
procedure RunChannelTests(var Success: Boolean);
procedure RunUserTests(var Success: Boolean);

implementation

uses
  Main;

procedure RunTests;
var
  Success: Boolean;
begin
  Success := True;
  Main.FormMain.MemoTraffic.Lines.Clear;
  Main.FormMain.MemoTraffic.Lines.Add('== RUNNING TESTS ==');
  RunServerTests(Success);
  RunMessageTests(Success);
  RunChannelTests(Success);
  RunUserTests(Success);
  if Success then
    Main.FormMain.MemoTraffic.Lines.Add('== ALL TESTS PASSED! ==')
  else
    Main.FormMain.MemoTraffic.Lines.Add('== ONE OR MORE TESTS FAILED! ==');
end;

procedure RunServerTests(var Success: Boolean);
begin

end;

procedure RunMessageTest(var Success: Boolean; const Data: string; const CheckData: TcIRC_TestMessageData);
var
  TestMessage: cIRC_Data.TcIRC_Message;
  LocalSuccess: Boolean;
begin
  TestMessage := cIRC_Data.TcIRC_Message.Create(Data);
  try
    LocalSuccess := True;
    if TestMessage.Command <> CheckData.Command then
      LocalSuccess := False;
    if TestMessage.Destination <> CheckData.Destination then
      LocalSuccess := False;
    if TestMessage.Hostname <> CheckData.Hostname then
      LocalSuccess := False;
    if TestMessage.Nick <> CheckData.Nick then
      LocalSuccess := False;
    if TestMessage.Params <> CheckData.Params then
      LocalSuccess := False;
    if TestMessage.Prefix <> CheckData.Prefix then
      LocalSuccess := False;
    if TestMessage.Trailing <> CheckData.Trailing then      LocalSuccess := False;    if TestMessage.User <> CheckData.User then
      LocalSuccess := False;
    if LocalSuccess = False then
    begin
      Main.FormMain.MemoTraffic.Lines.Add('RunMessageTest FAILED: "' + Data + '"');
      Success := False;
    end;
  finally
    TestMessage.Free;
  end;
end;

procedure RunMessageTests(var Success: Boolean);
var
  CheckData: TcIRC_TestMessageData;
begin
  CheckData.Command := '';
  CheckData.Destination := '';
  CheckData.Hostname := '';
  CheckData.Nick := '';
  CheckData.Params := '';
  CheckData.Prefix := '';
  CheckData.Trailing := '';  CheckData.User := '';
  RunMessageTest(Success, '', CheckData);
  CheckData.Command := 'QUIT';
  RunMessageTest(Success, 'QUIT', CheckData);
end;

procedure RunChannelTests(var Success: Boolean);
begin

end;

procedure RunUserTests(var Success: Boolean);
begin

end;

end.