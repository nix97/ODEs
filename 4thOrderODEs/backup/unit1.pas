unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, formula, TAGraph, TASeries;

type

  { TForm1 }

  TForm1 = class(TForm)
    ArtFormula1: TArtFormula;
    AboutBut: TButton;
    ExampleBut: TButton;
    Image1: TImage;
    y3Series4: TLineSeries;
    y2Series3: TLineSeries;
    y1Series2: TLineSeries;
    ClearBut: TButton;
    Chart1: TChart;
    ySeries1: TLineSeries;
    Label15: TLabel;
    Label3: TLabel;
    MemoHelp: TMemo;
    ResultMemo: TMemo;
    RunBut: TButton;
    DiffEquEdit: TEdit;
    aEdit: TEdit;
    bEdit: TEdit;
    yEdit: TEdit;
    y1Edit: TEdit;
    y2Edit: TEdit;
    y3Edit: TEdit;
    MEdit: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure AboutButClick(Sender: TObject);
    procedure ClearButClick(Sender: TObject);
    procedure ExampleButClick(Sender: TObject);
    procedure RunButClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.RunButClick(Sender: TObject);
label stop;
var
  vars : array of string;
  vals,vals2,vals3,vals4 : TCalcArray;
  k,num,M: integer;
  DiffEqu,t2,y_2,y1_2,y2_2,y3_2: string;
  a,b,yt0,y1t0,y2t0,y3t0,h,f1,g1,h1,i1:extended;
  f2,g2,h2,i2,f3,g3,h3,i3,f4,g4,h4,i4:extended;
  t,y,y1,y2,y3:array[0..10000] of extended;


begin

 try

  DiffEqu:=DiffEquEdit.text; //Differential Equation y ''''

  a:=strtofloat(aEdit.text); //get value of a
  b:=strtofloat(bEdit.text); //get value of b
  yt0:=strtofloat(yEdit.text); //get value of y(t0)
  y1t0:=strtofloat(y1Edit.text); //get value of y'(t0)
  y2t0:=strtofloat(y2Edit.text); //get value of y''(t0)
  y3t0:=strtofloat(y3Edit.text); //get value of y'''(t0)
  M:=strtoint(MEdit.text); //get value of M (subinterval)

  //handling
  if (M>10000) then
  begin
    showmessage('Maximal numbers of M are 10000 !!!');
    goto stop;
  end;

  if (a>b) then
  begin
    showmessage('Value of a must be lower than b !!!');
    goto stop;
  end;

 num:=5; //numbers of variable (t,y,y',y'',y''') or (t,y,y'=p, y''=q, y'''=r)
 setlength(vars,num);
 setlength(vals,num);
 setlength(vals2,num);
 setlength(vals3,num);
 setlength(vals4,num);

  vars[0]:='t';
  vars[1]:='y';
  vars[2]:='p';
  vars[3]:='q';
  vars[4]:='r';

 h:=(b-a)/M;
 t[0]:=a;
 t[M]:=b;
 y[0]:=yt0;
 y1[0]:=y1t0;
 y2[0]:=y2t0;
 y3[0]:=y3t0;


//Find y[k], y'[k] or y1[k], y''[k] or y2[k], y'''[k] or y3[k]
 for k:=0 to M-1 do
 begin

  //f1,g1,h1,i1
  t[k]:=a+k*h;
  f1:= y1[k];
  g1:= y2[k];
  h1:= y3[k];


  t2:=floattostr(t[k]); // before calc use artFormula, value convert to string (t2)
  y_2:=floattostr(y[k]); //y
  y1_2:=floattostr(y1[k]); //y'
  y2_2:=floattostr(y2[k]); //y''
  y3_2:=floattostr(y3[k]); //y'''

  setS(vals[0],t2);
  setS(vals[1],y_2);
  setS(vals[2],y1_2);
  setS(vals[3],y2_2);
  setS(vals[4],y3_2);

  i1:=strtofloat(ArtFormula1.ComputeStr(DiffEqu,num,@vars,@vals));


  //f2,g2,h2,i2

  f2:= y1[k]+h/2*g1;
  g2:= y2[k]+h/2*h1;
  h2:= y3[k]+h/2*i1;

  t2:=floattostr(t[k]+h/2); // t at (t+h/2)
  y_2:=floattostr(y[k]+h/2*f1); //y
  y1_2:=floattostr(y1[k]+h/2*g1); //y'
  y2_2:=floattostr(y2[k]+h/2*h1); //y''
  y3_2:=floattostr(y3[k]+h/2*i1); //y'''

  setS(vals2[0],t2);
  setS(vals2[1],y_2);
  setS(vals2[2],y1_2);
  setS(vals2[3],y2_2);
  setS(vals2[4],y3_2);

  i2:=strtofloat(ArtFormula1.ComputeStr(DiffEqu,num,@vars,@vals2));


  //f3,g3,h3,i3

  f3:= y1[k]+h/2*g2;
  g3:= y2[k]+h/2*h2;
  h3:= y3[k]+h/2*i2;

  t2:=floattostr(t[k]+h/2); // t at (t+h/2)
  y_2:=floattostr(y[k]+h/2*f2); //y
  y1_2:=floattostr(y1[k]+h/2*g2); //y'
  y2_2:=floattostr(y2[k]+h/2*h2); //y''
  y3_2:=floattostr(y3[k]+h/2*i2); //y'''

  setS(vals3[0],t2);
  setS(vals3[1],y_2);
  setS(vals3[2],y1_2);
  setS(vals3[3],y2_2);
  setS(vals3[4],y3_2);

  i3:=strtofloat(ArtFormula1.ComputeStr(DiffEqu,num,@vars,@vals3));


  //f4,g4,h4,i4
  f4:= y1[k]+h*g3;
  g4:= y2[k]+h*h3;
  h4:= y3[k]+h*i3;

  t2:=floattostr(t[k]+h); // t at (t+h)
  y_2:=floattostr(y[k]+h*f3); //y
  y1_2:=floattostr(y1[k]+h*g3); //y'
  y2_2:=floattostr(y2[k]+h*h3); //y''
  y3_2:=floattostr(y3[k]+h*i3); //y'''

  setS(vals4[0],t2);
  setS(vals4[1],y_2);
  setS(vals4[2],y1_2);
  setS(vals4[3],y2_2);
  setS(vals4[4],y3_2);

  i4:=strtofloat(ArtFormula1.ComputeStr(DiffEqu,num,@vars,@vals4));

  //Final result
  y[k+1]:=y[k]+h/6*(f1+2*f2+2*f3+f4);
  y1[k+1]:=y1[k]+h/6*(g1+2*g2+2*g3+g4);
  y2[k+1]:=y2[k]+h/6*(h1+2*h2+2*h3+h4);
  y3[k+1]:=y3[k]+h/6*(i1+2*i2+2*i3+i4);

 end;
 ResultMemo.lines.clear;
 ResultMemo.Lines.add('k         tk                       yk                                      y '' k                                   y '''' k                                   y '''''' k ');
 ResultMemo.Lines.add('====================================================================================');
 for k:=0 to M do
 begin
  ResultMemo.Lines.Add(inttostr(k)+format(' %10.3f',[t[k]])+format(' %26.18e',[Y[k]])+format(' %26.18e',[Y1[k]])+format(' %26.18e',[Y2[k]])+format(' %26.18e',[Y3[k]]));
 end;


 //Graph
 ySeries1.Clear;
 y1Series2.Clear;
 y2Series3.Clear;
 y3Series4.Clear;


  for k:=0 to M do
  begin
    ySeries1.AddXY(t[k],y[k] ); //(t,y)
    y1Series2.AddXY(t[k],y1[k] ); //(t,y')
    y2Series3.AddXY(t[k],y2[k] );  //(t,y'')
    y3Series4.AddXY(t[k],y3[k] );  //(t,y''')

  end;

 stop:

 except
  showmessage('Something wrong with the input !!!');
 end;


 end;

procedure TForm1.ClearButClick(Sender: TObject);
begin
  DiffEquEdit.Clear;
  aEdit.Clear;
  bEdit.Clear;
  YEdit.Clear;
  Y1Edit.Clear;
  Y2Edit.Clear;
  Y3Edit.Clear;
  MEdit.Clear;
  ResultMemo.Clear;
  ySeries1.Clear;
  y1Series2.Clear;
  y2Series3.Clear;
  y3Series4.Clear;

end;

procedure TForm1.AboutButClick(Sender: TObject);
const
 sAbout = '|======== Fourth-Order ODE Solver ========|' + #13#10 +
          '' + #13#10 +
          'Version 1.0 - build 29 august 2024'+ #13#10 +
          'Created by Lukas Setiawan.' + #13#10 +
          'Copyright (c) 2024. All Rights Reserved.' + #13#10 +
          '' + #13#10 +
          'Visit www.metodenumeriku.blogspot.com' + #13#10 +
          'FB search: Metode Numerik-Plus Programnya' + #13#10 +
          'e-mail : lukassetiawan@yahoo.com' + #13#10 +
          'My other works :'+ #13#10 +
          'https://bitbucket.org/nixz97/nix/downloads/' + #13#10 +

          '' + #13#10 +
          'Accepting donations for software development.'+ #13#10
         ;
begin
 MessageDlg( sAbout, mtInformation, [mbOK], 0);
end;

procedure TForm1.ExampleButClick(Sender: TObject);
begin
  DiffEquEdit.Text:='((-2*t^2-6)*r-5*q+p+2*y-4*t^6+2*t^5-55*t^4-24*t^3-22*t^2-t*32)/3';
  aEdit.Text:='0';
  bEdit.Text:='1';
  yEdit.Text:='0';
  y1Edit.Text:='1';
  y2Edit.Text:='-8';
  y3Edit.Text:='6';
  MEdit.Text:='10';


end;



end.

