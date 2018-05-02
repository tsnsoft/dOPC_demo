unit Unit_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  dOPCDA, dOPC, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm_Main = class(TForm)
    Timer_ReaderTags: TTimer;
    Timer_Starter: TTimer;
    Memo_Tags: TMemo;
    procedure Timer_ReaderTagsTimer(Sender: TObject);
    procedure Timer_StarterTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Main: TForm_Main;

  OPCServer: TdOPCDAServer; // Компонент доступа к OPC-серверу
  OPCGroup: TdOPCGroup; // Группа тегов для OPC-сервера

const
  StartDelay = 500; // Время для отрисовки GUI-окна перед активацией OPC
  UpdateRate = 2000; // Время обновления данных с OPC-сервера
  DoubleFormat = '########0.0000'; // Формат вывода значений тегов

implementation

{$R *.dfm}

procedure TForm_Main.Timer_StarterTimer(Sender: TObject);
// Инициализация доступа к OPC-серверу
begin
  try
    Timer_Starter.Enabled := false;
    OPCServer := TdOPCServer.Create(nil);
    OPCServer.ComputerName := 'application';  // Имя компьютера с OPC-сервером
    OPCServer.ServerName := '{C3B72AB1-6B33-11D0-9007-0020AFB6CF9F}';   // Имя OPC-сервера
    OPCGroup := OPCServer.OPCGroups.Add('test');  // Имя создаваемой группы для OPC-сервера
    screen.Cursor := crHourGlass;
    OPCServer.Active := true; // Активация подключения к OPC-серверу
    screen.Cursor := crDefault;
    Application.ProcessMessages;
    Randomize;
    Timer_ReaderTags.Enabled := true;
  except
    showmessage('Ошибка подключения к OPC-серверу! Выход из программы');
    close;
  end;
end;

procedure TForm_Main.Timer_ReaderTagsTimer(Sender: TObject);
// Чтение данных с OPC-сервера
var
  ItemList: TdOPCItemList;
  Item: TdOPCItem;
  s: string; i: integer;
begin
  try
    Memo_Tags.Lines.Clear;

    OPCGroup.OPCItems.Clear;
    if random(10) > 2 then OPCGroup.OPCItems.AddItem('PT24_01/AI1/OUT.CV');
    if random(10) > 3 then OPCGroup.OPCItems.AddItem('PT25_01/AI1/OUT.CV');
    if random(10) > 4 then OPCGroup.OPCItems.AddItem('PT26_01/AI1/OUT.CV');
    if OPCGroup.OPCItems.Count<1 then OPCGroup.OPCItems.AddItem('PT24_01/AI1/OUT.CV');

    ItemList := TdOPCItemList.Create(OPCGroup.OPCItems);

    if OPCGroup.SyncRead(ItemList, false) = true then begin
      s := '';
      for i := 0 to ItemList.Count - 1 do begin
        Item := ItemList[i];
        s := s + Item.ItemID + ': ' + formatfloat(DoubleFormat, Item.Value) +
          #$0D + #$0A;
      end;
      Memo_Tags.Text := s;
    end
    else begin Memo_Tags.Text := ''; abort; end;

    ItemList.Free;
    Application.ProcessMessages;
  except
    Timer_ReaderTags.Enabled := false;
    showmessage('Ошибка чтения тегов с OPC-сервера! Выход из программы');
    OPCServer.Free; // Отключение от OPC-сервера
    Application.Terminate;
  end;
end;

procedure TForm_Main.FormShow(Sender: TObject);
// Инициализация программы
begin
  Timer_Starter.Enabled := false;
  Timer_ReaderTags.Enabled := false;
  Timer_Starter.Interval := StartDelay;
  Timer_ReaderTags.Interval := UpdateRate;
  Timer_Starter.Enabled := true;
end;

procedure TForm_Main.FormClose(Sender: TObject; var Action: TCloseAction);
// Закрытие программы
begin
  OPCServer.Free; // Отключение от OPC-сервера
end;

end.
