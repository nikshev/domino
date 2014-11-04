unit TestZU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Memo1: TMemo;
    Memo2: TMemo;
    OpenDialog1: TOpenDialog;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    SaveDialog1: TSaveDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure AddToChain(a,b:char);
    procedure DeleteDomino(index:integer);
    procedure Return (a:char);
    procedure AddToBeginChain(a,b:char; index:integer);
    procedure MovingFormChain(a,b:char; index:integer);
    function FindDouble(a,b:char):boolean;
    function printChain:string;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 const MaxDomKol=10; //������������ ����� ��������� 10
var
  Form1: TForm1;
  Domino: array [1..10,1..2] of char;
  DominoS: array [1..10,1..2] of char;
  Chain:  array [1..10,1..2] of char;
  DominoO: array [1..10] of char;
  DomKol: integer;  //���-�� ��������� (�������� 10 �� ����� � ��������)
  ChainIndex:integer;

implementation

{$R *.dfm}

//�� ������� ������ �������
procedure TForm1.BitBtn1Click(Sender: TObject);
var
 f:TextFile;
 tmpStr:String;
 i,j:integer;
begin
 //����� ������������� = ����� ���������
 OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
 if OpenDialog1.Execute then //��������� ������ ��������
  begin
   //���� �� ��������� �������� ������ � ������ ��� � Memo1
   {$i-}
   //�������������� ����������
   DomKol:=0;
   ChainIndex:=0;
   for i:=1 to MaxDomKol do
    begin
     for j:=1 to  2 do
      begin
       Domino[i,j]:='0';
       Chain[i,j]:='0';
      end;
      DominoO[i]:='0';
    end;
    Memo1.Clear;
    Memo2.Clear;
    Memo1.Lines.Add('����:'+OpenDialog1.FileName);
    Memo1.Lines.Add('���������:');
    AssignFile(f,OpenDialog1.FileName); //��������� ����
    Reset(f); //�������� ��� ������
    i:=1; //��������� ����� �������
    while not EOF(f) do //��������� ������
     begin
      Readln(f,tmpStr); //������ ������ �� ����
      if (i<MaxDomKol+1) then
       begin
        if not FindDouble(tmpStr[1],tmpStr[3]) then
         begin
          Domino[i,1]:=tmpStr[1]; //���������� ������ ����� ���������
          Domino[i,2]:=tmpStr[3]; //���������� ������ ����� ���������
          Inc(DomKol); //���-�� ��������� +1
          Memo1.Lines.Add(Domino[i,1]+';'+Domino[i,2]+';');
         end
         else
          begin
           Memo1.Lines.Add('�������: '+tmpStr[1]+';'+tmpStr[3]+'; �� ��������!');
           Dec(i);
          end;
       end;
      Inc(i); //��������� ���������
     end;
     Memo1.Lines.Add('���������� ���������:'+IntToStr(DomKol));
     CloseFile(f); //��������� ����
   {$i+}
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
 i,j:integer;
begin
 //�������������� ����������
 DomKol:=0;
 ChainIndex:=0;
 for i:=1 to MaxDomKol do
  begin
   for j:=1 to  2 do
    begin
     Domino[i,j]:='0';
     Chain[i,j]:='0';
    end;
    DominoO[i]:='0';
  end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
 tmpStr:String;
 index:integer;
 i,j:integer;
 wd:longint;
begin
 if (DomKol>2) then //���� ���-�� ��������� ������ 2
   begin             //������ �������
    DeleteDomino(1);
    AddToChain(Domino[1,1], Domino[1,2]);
    Return(Domino[1,2]);
    wd:=0;
    while (ChainIndex<>DomKol) do
     begin
      //��������� � ������ ��� �������
      for i:=1 to DomKol do
       if DominoO[i]='0' then
       begin
        AddToBeginChain(Domino[i,1],Domino[i,2],i);
        MovingFormChain(Domino[i,1],Domino[i,2],i);
       end;
       if (wd<>$ffff) then
        Inc(wd)
       else
        break;
      end;
     if (ChainIndex<>DomKol) then
      begin
        tmpStr:='';
        for i:=1 to DomKol do
         if DominoO[i]='0' then
           tmpStr:=tmpStr+' '+Domino[i,1]+';'+Domino[i,2]+';';
      Memo2.Lines.Add('������ �������� ���������:'+tmpStr);
      Memo2.Lines.Add(printChain);
      end
     else
      Memo2.Lines.Add(printChain);
   end
  else
    MessageDlg('�� ���� ������� ��������� �� �����!', mtInformation,[mbOk],0);
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var
 i,j:integer;
begin
 //�������������� ����������
 DomKol:=0;
 ChainIndex:=0;
 for i:=1 to MaxDomKol do
  begin
   for j:=1 to  2 do
    begin
     Domino[i,j]:='0';
     Chain[i,j]:='0';
    end;
    DominoO[i]:='0';
  end;
 Memo1.Clear;
 Memo2.Clear;
end;

//���������� � �������
procedure TForm1.AddToChain(a,b:char);
 begin
  Inc(ChainIndex);
  Chain[ChainIndex,1]:=a; Chain[ChainIndex,2]:=b;
 end;

//���������� � ������ �������
procedure TForm1.AddToBeginChain(a,b:char; index:integer);
var
 tmpIndex,i:integer;
 begin
  if ((Chain[1,1]=b) or (Chain[1,1]=a)) and (DominoO[index]<>'1') then
   begin
    Inc(ChainIndex);
    DeleteDomino(index);
    tmpIndex:=ChainIndex;
    while(tmpIndex>1) do //��������� ������
     begin
      Chain[tmpIndex,1]:=Chain[tmpIndex-1,1];
      Chain[tmpIndex,2]:=Chain[tmpIndex-1,2];
      Dec(tmpIndex);
     end;
    if (Chain[1,1]=b) then
     begin
      Chain[tmpIndex,1]:=a;
      Chain[tmpIndex,2]:=b;
     end
    else
     begin
      Chain[tmpIndex,1]:=b;
      Chain[tmpIndex,2]:=a;
     end;
   end;
 end;

//������� ���������
procedure TForm1.DeleteDomino(index:integer);
begin
 DominoO[index]:='1';
end;

//������� ������ ����
procedure TForm1.Return (a:char);
 var
  tmpStr:String;
  i:integer;
begin
 //��������� ��� ������ ��������
 for i:=1 to DomKol do
  if (Domino[i,1]=a) and (Chain[ChainIndex,2]=a) and (DominoO[i]<>'1') then
   begin
    if (Domino[i,1]<>Domino[i,2]) then
     begin
      DeleteDomino(i);
      AddToChain(Domino[i,1],Domino[i,2]);
      Return(Domino[i,2]);
     end;
    end;

 //��������� ��� ����������� ��������
   for i:=1 to DomKol do
   if (Domino[i,2]=a) and (Chain[ChainIndex,2]=a) and (DominoO[i]<>'1') then
    begin
    if (Domino[i,1]<>Domino[i,2]) then
     begin
      DeleteDomino(i);
      AddToChain(Domino[i,2],Domino[i,1]);
      Return(Domino[i,1]);
     end;
    end;

end;

 //����������� �������
function TForm1.printChain:String;
var
 i:integer;
 tmpStr:string;
 begin
  tmpStr:='';
  for i:=1 to ChainIndex do
   begin
    tmpStr:=tmpStr+Chain[i,1]+';'+Chain[i,2]+';| '
   end;
  printChain:=tmpStr;
 end;

procedure TForm1.MovingFormChain(a,b:char; index:integer);
var
 tmpIndex, tmpIndex1,i:integer;
 begin
  if (a=b) and (DominoO[index]<>'1') then
   begin
    //������� �������� ��� ������
    tmpIndex:=0;
    for i:=1 to ChainIndex+1 do
     begin
      if (Chain[i-1,2]=a) and (Chain[i,1]=a) then
       tmpIndex:=i;
     end;

    //������ �����
    if (tmpIndex<>0) then
     begin
      Inc(ChainIndex);
      DeleteDomino(index);
      tmpIndex1:=ChainIndex;
      while (tmpIndex1>tmpIndex) do
       begin
        Chain[tmpIndex1,1]:=Chain[tmpIndex1-1,1];
        Chain[tmpIndex1,2]:=Chain[tmpIndex1-1,2];
        Dec(tmpIndex1);
       end;
        Chain[tmpIndex1,1]:=a;
        Chain[tmpIndex1,2]:=b;
     end;
   end;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
 var
 f:TextFile;
 tmpStr:String;
 i,j:integer;
begin
 //������� ����� ���������
//����� ������������� = ����� ���������
 SaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
 if SaveDialog1.Execute then //��������� ������ ��������
  begin
   {$I-}
    AssignFile(f,SaveDialog1.FileName);
    //�������������� ����������
     DomKol:=0;
     ChainIndex:=0;
     for i:=1 to MaxDomKol do
      begin
       for j:=1 to  2 do
        begin
         Domino[i,j]:='0';
         Chain[i,j]:='0';
        end;
        DominoO[i]:='0';
      end;
    Memo1.Clear;
    Memo2.Clear;
    Randomize;
    Rewrite(f);
    for i:=1 to MaxDomKol do
     begin
       tmpStr:=IntToStr(Random(6))+';'+IntToStr(Random(6))+';';
       Writeln(f,tmpStr);
     end;
    Memo1.Lines.Add('����:'+SaveDialog1.FileName+' ������� ������!');
    CloseFile(f); 
   {$I+}
  end;
end;

//����� ���������
function TForm1.FindDouble(a,b:char):boolean;
var
 i:integer;
 t:boolean;
begin
 t:=false;
 for i:=1 to DomKol do
  begin
   if (Domino[i,1]=a) and (Domino[i,2]=b) then
    t:=true;
  end;
  FindDouble:=t;
end;

end.
