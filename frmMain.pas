unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Contnrs;

type
  TForm1 = class(TForm)
    btnNewObject: TButton;
    btnShowObjects: TButton;
    lstObjects: TListBox;
    btnDeleteObject: TButton;
    procedure btnShowObjectsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNewObjectClick(Sender: TObject);
    procedure btnDeleteObjectClick(Sender: TObject);
  private
    FOwner  : TComponent;
    FNextID: Integer;
    FMyList: TComponentList;
    procedure ShowList();
  public
    { Public declarations }
  end;

var
  Form1: TForm1;



implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FNextID := 1;
  FMyList := TComponentList.Create;
  FOwner := TComponent.Create(nil);
  FOwner.Name := 'IAmTheOwner';
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
 oComponent: TComponent;
begin
  FreeAndNil(FOwner);



  while FMyList.Count > 0 do
  begin
    oComponent := FMyList.Items[0];
    FreeAndNil(oComponent);
  end;
  FreeAndNil(FMyList);
end;


procedure TForm1.btnShowObjectsClick(Sender: TObject);
begin
  ShowList();
end;



procedure TForm1.btnNewObjectClick(Sender: TObject);
var
  oNewObject: TComponent;
begin
  oNewObject := TComponent.Create(FOwner);
  oNewObject.Name := Format('Object%d', [FNextID] );
  FNextID := FNextID + 1;
  FMyList.Add(oNewObject);

  ShowList();
end;

procedure TForm1.btnDeleteObjectClick(Sender: TObject);
var
  oObjectToDelete: TComponent;
  nSelectedIndex: Integer;
begin
   nSelectedIndex := lstObjects.ItemIndex;
   oObjectToDelete := FMyList.Items[nSelectedIndex];
   FreeAndNil(oObjectToDelete);

   ShowList();
end;

procedure TForm1.ShowList;
var
  I: Integer;
  oCurrentObject: TComponent;
begin
  lstObjects.Items.Clear;
  for I := 0 to FMyList.Count - 1 do
  begin
    oCurrentObject := FMyList.Items[I];
    lstObjects.Items.Add(oCurrentObject.Name);
  end;
  lstObjects.Items.Add('------');
  lstObjects.Items.Add(Self.Components[0].Name)

end;

end.
