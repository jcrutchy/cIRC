unit cIRC_Data;

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
  StrUtils;

type

  TcIRC_Server = class;
  TcIRC_ServerArray = class;
  TcIRC_Message = class;
  TcIRC_MessageArray = class;
  TcIRC_Channel = class;
  TcIRC_ChannelArray = class;
  TcIRC_User = class;
  TcIRC_UserArray = class;

  { TcIRC_Server }

  TcIRC_Server = class(TObject)
  private

  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  { TcIRC_ServerArray }

  TcIRC_ServerArray = class(TObject)
  private

  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  { TcIRC_Message }

  TcIRC_Message = class(TObject)
  private
    FCommand: string;
    FData: string;
    FDestination: string;
    FHostname: string;
    FNick: string;
    FParams: string;
    FPrefix: string;
    FServer: string;
    FTimeStamp: TDateTime;
    constructor Create(const Data: string);
  public
    property Command: string read FCommand;
    property Data: string read FData;
    property Destination: string read FDestination;
    property Hostname: string read FHostname;
    property Nick: string read FNick;
    property Params: string read FParams;
    property Prefix: string read FPrefix;
    property Server: string read FServer;
    property TimeStamp: TDateTime read FTimeStamp;

  { TcIRC_MessageArray }

  TcIRC_MessageArray = class(TObject)
  private

  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  { TcIRC_Channel }

  TcIRC_Channel = class(TObject)
  private

  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  { TcIRC_ChannelArray }

  TcIRC_ChannelArray = class(TObject)
  private

  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  { TcIRC_User }

  TcIRC_User = class(TObject)
  private

  public
    constructor Create;
  public

  end;

  { TcIRC_UserArray }

  TcIRC_UserArray = class(TObject)
  private

  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

implementation

{ TcIRC_Server }

constructor TcIRC_Server.Create;
begin

end;

destructor TcIRC_Server.Destroy;
begin

  inherited;
end;

{ TcIRC_ServerArray }

constructor TcIRC_ServerArray.Create;
begin

end;

destructor TcIRC_ServerArray.Destroy;
begin

  inherited;
end;

{ TcIRC_Message }

constructor TcIRC_Message.Create(const Data: string);
begin
  FData := Data;
  if Trim(Data) = '' then
    Exit;

    
  {FCommand: string;

  FDestination: string;
  FHostname: string;
  FNick: string;
  FParams: string;
  FPrefix: string;
  FServer: string;
  FTimeStamp: TDateTime;
end;

{ TcIRC_MessageArray }

constructor TcIRC_MessageArray.Create;
begin

end;

destructor TcIRC_MessageArray.Destroy;
begin

  inherited;
end;

{ TcIRC_Channel }

constructor TcIRC_Channel.Create;
begin

end;

destructor TcIRC_Channel.Destroy;
begin

  inherited;
end;

{ TcIRC_ChannelArray }

constructor TcIRC_ChannelArray.Create;
begin

end;

destructor TcIRC_ChannelArray.Destroy;
begin

  inherited;
end;

{ TcIRC_User }

constructor TcIRC_User.Create;
begin

end;

{ TcIRC_UserArray }

constructor TcIRC_UserArray.Create;
begin

end;

destructor TcIRC_UserArray.Destroy;
begin

  inherited;
end;

end.