unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, StrUtils, math;

type

  { TSolar }

  TSolar = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Pass: TEdit;
    PassAdv: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
    function GeneratePrivateKey(key:string):Byte;
    function GeneratePass(DevId:string; key : byte):String;
  public
    { public declarations }
  end;

var
  Solar: TSolar;

implementation

{$R *.lfm}

{ TSolar }

procedure TSolar.Button1Click(Sender: TObject);
var
  key : Byte;
  passw:string;
begin
  key:=GeneratePrivateKey(edit1.Caption);
  passw:=edit1.Caption + '#' + FormatDateTime('DDMM',now())+'2130';
  passw:=GeneratePass(passw, key);
  Pass.Caption:=passw;
  key:=GeneratePrivateKey(edit1.Caption+'-ADV');
  passw:=edit1.Caption + '#' + FormatDateTime('DDMM',now())+'2130';
  passw:=GeneratePass(passw, key);
  PassAdv.Caption:=passw;
end;

function TSolar.GeneratePrivateKey(key:string):Byte;
var
  i:integer;
  b,b2:Byte;
  value:integer;
begin
  b:=0;
  for i:= 1 to length(key) do
  begin
     value:=ord(key[i]);
     b:=b xor value;
  end;
  result:=b;
end;

function TSolar.GeneratePass(DevId:string; key : byte):String;
Var
   arrRaw : array[0..19] of byte ;
   i,j,k: integer;
   BinStr: String;
   BinSub : string;
   ConStr : array[0..35] of char = ('A','B','C','D','E','F','G','H','I','J','K','L','M','0','1','2','3','4','5','6','7','8','9','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
   tekst:string;
begin
  Result:='';
  Binstr:='';
  for i:= 0 to 19 do
  begin
    arrRaw[i]:=ord(DevId[i+1]) xor key;
    Binstr:=BinStr + InttoBin(ArrRaw[i],8);
  end;
  j:= ceil(length(binstr)/5);
  for i:= 0 to j-1 do
  begin
   binsub:=MidStr(Binstr,1+(i*5),5);
   result:=result + conStr[numb2dec(binsub,2)];
  end;
  Result:=result + conStr[5-length(binsub)];
end;


end.

