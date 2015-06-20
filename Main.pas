unit Main;

interface

uses
  Windows,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Sockets,
  StdCtrls,
  DateUtils,
  ComCtrls,
  Grids,
  ExtCtrls,
  ScktComp,
  Utils,
  Menus,
  cIRC_Data,
  cIRC_Test;

type

  TClientThread = class;

  TFormMain = class(TForm)
    MainMenu: TMainMenu;
    MenuFile: TMenuItem;
    MenuItemExit: TMenuItem;
    StatusBar: TStatusBar;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Panel4: TPanel;
    MemoTraffic: TMemo;
    Panel5: TPanel;
    Panel6: TPanel;
    EditSend: TEdit;
    ButtonSend: TButton;
    Label1: TLabel;
    ListBox1: TListBox;
    Label2: TLabel;
    Label3: TLabel;
    MenuTools: TMenuItem;
    MenuItemRunTests: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ButtonSendClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EditSendKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MenuItemExitClick(Sender: TObject);
    procedure MenuItemRunTestsClick(Sender: TObject);
  private
    FDestination: string;
    FThread: TClientThread;
    procedure ThreadHandler(const S: string);
  end;

  TClientThread = class(TThread)
  private
    FClient: TTcpClient;
    FBuffer: string;
    FHandler: TGetStrProc;
  private
    procedure ClientError(Sender: TObject; SocketError: Integer);
    procedure ClientSend(Sender: TObject; Buf: PAnsiChar; var DataLen: Integer);
  public
    constructor Create(CreateSuspended: Boolean);
    procedure Update;
    procedure Send(const Msg: string);
    procedure Execute; override;
  public
    property Handler: TGetStrProc read FHandler write FHandler;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

{ TClientThread }

constructor TClientThread.Create(CreateSuspended: Boolean);
begin
  inherited;
  FreeOnTerminate := True;
end;

procedure TClientThread.Execute;
var
  Buf: Char;
const
  TERMINATOR: string = #13#10;
begin
  try
    FClient := TTcpClient.Create(nil);
    FClient.OnError := ClientError;
    FClient.OnSend := ClientSend;
    try
      FClient.RemoteHost := FClient.LookupHostAddr('irc.sylnt.us');
      FClient.RemotePort := '6667';
      if FClient.Connect = False then
      begin
        FBuffer := '<< CONNECTION ERROR >>';
        Synchronize(Update);
        Exit;
      end;
      FBuffer := '<< CONNECTED >>';
      Synchronize(Update);

      Send('NICK cIRC_test');
      Send('USER cIRC_test hostname servername :cIRC test');

      FBuffer := '';
      while (Application.Terminated = False) and (Self.Terminated = False) and (FClient.Connected = True) do
      begin
        FClient.ReceiveBuf(Buf, 1);
        FBuffer := FBuffer + Buf;
        if Copy(FBuffer, Length(FBuffer) - Length(TERMINATOR) + 1, Length(TERMINATOR)) = TERMINATOR then
        begin
          FBuffer := Copy(FBuffer, 1, Length(FBuffer) - Length(TERMINATOR));
          Synchronize(Update);
          FBuffer := '';
        end;
      end;
      FBuffer := '<< DISCONNECTED >>';
      Synchronize(Update);
    finally
      FClient.Free;
    end;
  except
    FBuffer := '<< EXCEPTION ERROR >>';
    Synchronize(Update);
  end;
end;

procedure TClientThread.Send(const Msg: string);
begin
  if Assigned(FClient) then
    if FClient.Connected then
      FClient.Sendln(Msg);
end;

procedure TClientThread.Update;
begin
  if Assigned(FHandler) then
    FHandler(FBuffer);
end;

procedure TClientThread.ClientError(Sender: TObject; SocketError: Integer);
begin

end;

procedure TClientThread.ClientSend(Sender: TObject; Buf: PAnsiChar; var DataLen: Integer);
begin

end;

{ TFormMain }

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FDestination := '#test';
  FThread := TClientThread.Create(True);
  FThread.Handler := ThreadHandler;
  //FThread.Resume;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
var
  msg: string;
begin
  msg := 'QUIT';
  FThread.Send(msg);
end;

procedure TFormMain.ThreadHandler(const S: string);
begin
  MemoTraffic.Lines.Add(S);
end;

procedure TFormMain.ButtonSendClick(Sender: TObject);
var
  msg: string;
begin
  if Copy(EditSend.Text, 1, 1) = '/' then
  begin
    msg := Copy(EditSend.Text, 2, Length(EditSend.Text) - 1);
    if UpperCase(Copy(EditSend.Text, 2, 4)) = 'JOIN' then
      FDestination := Copy(EditSend.Text, 7, Length(EditSend.Text) - 6); // modify to allow joining multiple channels simultaneously (last becomes active)
  end
  else
    msg := 'PRIVMSG ' + FDestination + ' :' + EditSend.Text;
  FThread.Send(msg);
  MemoTraffic.Lines.Add(msg);
  EditSend.Text := '';
end;

procedure TFormMain.EditSendKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    ButtonSendClick(nil);
end;

procedure TFormMain.MenuItemExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.MenuItemRunTestsClick(Sender: TObject);
begin
  cIRC_Test.RunTests;
end;

end.
