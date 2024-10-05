unit unitSystemODEs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  formula, TAGraph, TASeries;

type

  { TForm1 }

  TForm1 = class(TForm)
    ArtFormula1: TArtFormula;
    ProcessTime: TLabel;
    Series9: TLineSeries;
    Series8: TLineSeries;
    Series7: TLineSeries;
    Series6: TLineSeries;
    Series5: TLineSeries;
    Series4: TLineSeries;
    Series3: TLineSeries;
    Series2: TLineSeries;
    Series1: TLineSeries;
    ViewRadioGr: TRadioGroup;
    RunBut: TButton;
    ClearBut: TButton;
    exampleBut: TButton;
    aboutBut: TButton;
    Chart1: TChart;
    xEquationEdit: TEdit;
    y1t0Edit: TEdit;
    z1t0Edit: TEdit;
    x2t0Edit: TEdit;
    MEdit: TEdit;
    y2t0Edit: TEdit;
    z2t0Edit: TEdit;
    yEquationEdit: TEdit;
    zEquationEdit: TEdit;
    aEdit: TEdit;
    bEdit: TEdit;
    xt0Edit: TEdit;
    yt0Edit: TEdit;
    zt0Edit: TEdit;
    x1t0Edit: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ResultMemo: TMemo;
    Memo2: TMemo;
    procedure aboutButClick(Sender: TObject);
    procedure ClearButClick(Sender: TObject);
    procedure exampleButClick(Sender: TObject);
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
  vals1,vals2,vals3,vals4:TCalcArray;
  k,num,M: integer;
  DiffEquX,DiffEquY,DiffEquZ,x_2,x1_2,t2,x2_2,y_2,y1_2,y2_2: string;
  z_2,z1_2,z2_2:string;
  TitleView1,TitleView2,TitleView3,TitleView4,TitleView5,TitleView6,Lines:string;
  a,b,xt0,x1t0,x2t0,yt0,y1t0,y2t0,zt0,z1t0,z2t0,h:extended;
  f1,g1,h1,i1,f2,g2,h2,i2,f3,g3,h3,i3,f4,g4,h4,i4:extended;
  j1,k1,l1,m1,n1,j2,k2,l2,m2,n2,j3,k3,l3,m3,n3,j4,k4,l4,m4,n4:extended;
  t,x,x1,x2,y,y1,y2,z,z1,z2:array[0..10000] of extended;
  start_time, stop_time, elapsed : TDateTime;


begin

 try

  start_time := Now; //start to counting Process time

  DiffEquX:=xEquationEdit.text; //Differential Equation x '''
  DiffEquY:=yEquationEdit.text; //Differential Equation y '''
  DiffEquZ:=zEquationEdit.text; //Differential Equation z '''

  a:=strtofloat(aEdit.text); //get value of a
  b:=strtofloat(bEdit.text); //get value of b
  M:=strtoint(MEdit.text); //get value of M (subinterval)

  xt0:=strtofloat(xt0Edit.text); //get value of x(t0)
  yt0:=strtofloat(yt0Edit.text); //get value of y(t0)
  zt0:=strtofloat(zt0Edit.text); //get value of z(t0)

  x1t0:=strtofloat(x1t0Edit.text); //get value of x'(t0)
  y1t0:=strtofloat(y1t0Edit.text); //get value of y'(t0)
  z1t0:=strtofloat(z1t0Edit.text); //get value of z'(t0)

  x2t0:=strtofloat(x2t0Edit.text); //get value of x''(t0)
  y2t0:=strtofloat(y2t0Edit.text); //get value of y''(t0)
  z2t0:=strtofloat(z2t0Edit.text); //get value of z''(t0)

  //boundary, etc handling
  if (M>10000) then
  begin
    showmessage('Max M is 10000 !!!');
    goto stop;
  end;

  if (a>b) then
  begin
    showmessage('Value of a must be lower than b !!!');
    goto stop;
  end;

 num:=10; //numbers of variable (t, x, y, z, p, q, r, s, u, v )
 setlength(vars,num);
 setlength(vals1,num);
 setlength(vals2,num);
 setlength(vals3,num);
 setlength(vals4,num);

  vars[0]:='t'; //t
  vars[1]:='x'; //x
  vars[2]:='y'; //y
  vars[3]:='z'; //z
  vars[4]:='p'; //x'
  vars[5]:='q'; //y'
  vars[6]:='r'; //z'
  vars[7]:='s'; //x''
  vars[8]:='u'; //y''
  vars[9]:='v'; //z''

 h:=(b-a)/M;
 t[0]:=a;
 t[M]:=b;
 x[0]:=xt0;    //x[k]
 x1[0]:=x1t0;  //x'[k]
 x2[0]:=x2t0;  //x''[k]
 y[0]:=yt0;    //y[k]
 y1[0]:=y1t0;  //y'[k]
 y2[0]:=y2t0;  //y''[k]
 z[0]:=zt0;    //z[k]
 z1[0]:=z1t0;  //z'[k]
 z2[0]:=z2t0;  //z''[k]

//Find x[k], x'[k] or x1[k], x''[k] or x2[k],y[k], y'[k] or y1[k], y''[k] or y2[k],
//z[k], z'[k] or z1[k], z''[k] or z2[k]

 for k:=0 to M-1 do
 begin
  //f1,g1,h1,i1,j1,k1
  t[k]:=a+k*h;
  f1:= x1[k];
  g1:= y1[k];
  h1:= z1[k];
  i1:= x2[k];
  j1:= y2[k];
  k1:= z2[k];

  //l1,m1,n1
  t2:=floattostr(t[k]); // before calc use artFormula, value convert to string (t2)
  x_2:=floattostr(x[k]); //x
  y_2:=floattostr(y[k]); //y
  z_2:=floattostr(z[k]); //z
  x1_2:=floattostr(x1[k]); //x'
  y1_2:=floattostr(y1[k]); //y'
  z1_2:=floattostr(z1[k]); //z'
  x2_2:=floattostr(x2[k]); //x''
  y2_2:=floattostr(y2[k]); //y''
  z2_2:=floattostr(z2[k]); //z''

  setS(vals1[0],t2);
  setS(vals1[1],x_2);
  setS(vals1[2],y_2);
  setS(vals1[3],z_2);
  setS(vals1[4],x1_2);
  setS(vals1[5],y1_2);
  setS(vals1[6],z1_2);
  setS(vals1[7],x2_2);
  setS(vals1[8],y2_2);
  setS(vals1[9],z2_2);

  l1:=strtofloat(ArtFormula1.ComputeStr(DiffEquX,num,@vars,@vals1));
  m1:=strtofloat(ArtFormula1.ComputeStr(DiffEquY,num,@vars,@vals1));
  n1:=strtofloat(ArtFormula1.ComputeStr(DiffEquZ,num,@vars,@vals1));

  //f2,g2,h2,i2,j2,k2
  f2:= x1[k]+h/2*i1;
  g2:= y1[k]+h/2*j1;
  h2:= z1[k]+h/2*k1;
  i2:= x2[k]+h/2*l1;
  j2:= y2[k]+h/2*m1;
  k2:= z2[k]+h/2*n1;

  //l2,m2,n2 at (t+h/2)
  t2:=floattostr(t[k]+h/2); // t
  x_2:=floattostr(x[k]+h/2*f1); //x
  y_2:=floattostr(y[k]+h/2*g1); //y
  z_2:=floattostr(z[k]+h/2*h1); //z
  x1_2:=floattostr(x1[k]+h/2*i1); //x'
  y1_2:=floattostr(y1[k]+h/2*j1); //y'
  z1_2:=floattostr(z1[k]+h/2*k1); //z'
  x2_2:=floattostr(x2[k]+h/2*l1); //x''
  y2_2:=floattostr(y2[k]+h/2*m1); //y''
  z2_2:=floattostr(z2[k]+h/2*n1); //z''

  setS(vals2[0],t2);
  setS(vals2[1],x_2);
  setS(vals2[2],y_2);
  setS(vals2[3],z_2);
  setS(vals2[4],x1_2);
  setS(vals2[5],y1_2);
  setS(vals2[6],z1_2);
  setS(vals2[7],x2_2);
  setS(vals2[8],y2_2);
  setS(vals2[9],z2_2);

  l2:=strtofloat(ArtFormula1.ComputeStr(DiffEquX,num,@vars,@vals2));
  m2:=strtofloat(ArtFormula1.ComputeStr(DiffEquY,num,@vars,@vals2));
  n2:=strtofloat(ArtFormula1.ComputeStr(DiffEquZ,num,@vars,@vals2));

  //f3,g3,h3,i3,j3,k3
  f3:= x1[k]+h/2*i2;
  g3:= y1[k]+h/2*j2;
  h3:= z1[k]+h/2*k2;
  i3:= x2[k]+h/2*l2;
  j3:= y2[k]+h/2*m2;
  k3:= z2[k]+h/2*n2;

  //l3,m3,n3 at (t+h/2)
  t2:=floattostr(t[k]+h/2); // t
  x_2:=floattostr(x[k]+h/2*f2); //x
  y_2:=floattostr(y[k]+h/2*g2); //y
  z_2:=floattostr(z[k]+h/2*h2); //z
  x1_2:=floattostr(x1[k]+h/2*i2); //x'
  y1_2:=floattostr(y1[k]+h/2*j2); //y'
  z1_2:=floattostr(z1[k]+h/2*k2); //z'
  x2_2:=floattostr(x2[k]+h/2*l2); //x''
  y2_2:=floattostr(y2[k]+h/2*m2); //y''
  z2_2:=floattostr(z2[k]+h/2*n2); //z''

  setS(vals3[0],t2);
  setS(vals3[1],x_2);
  setS(vals3[2],y_2);
  setS(vals3[3],z_2);
  setS(vals3[4],x1_2);
  setS(vals3[5],y1_2);
  setS(vals3[6],z1_2);
  setS(vals3[7],x2_2);
  setS(vals3[8],y2_2);
  setS(vals3[9],z2_2);

  l3:=strtofloat(ArtFormula1.ComputeStr(DiffEquX,num,@vars,@vals3));
  m3:=strtofloat(ArtFormula1.ComputeStr(DiffEquY,num,@vars,@vals3));
  n3:=strtofloat(ArtFormula1.ComputeStr(DiffEquZ,num,@vars,@vals3));

  //f4,g4,h4,i4,j4,k4
  f4:= x1[k]+h*i3;
  g4:= y1[k]+h*j3;
  h4:= z1[k]+h*k3;
  i4:= x2[k]+h*l3;
  j4:= y2[k]+h*m3;
  k4:= z2[k]+h*n3;

  //l4,m4,n4 at (t+h)
  t2:=floattostr(t[k]+h); // t
  x_2:=floattostr(x[k]+h*f3); //x
  y_2:=floattostr(y[k]+h*g3); //y
  z_2:=floattostr(z[k]+h*h3); //z
  x1_2:=floattostr(x1[k]+h*i3); //x'
  y1_2:=floattostr(y1[k]+h*j3); //y'
  z1_2:=floattostr(z1[k]+h*k3); //z'
  x2_2:=floattostr(x2[k]+h*l3); //x''
  y2_2:=floattostr(y2[k]+h*m3); //y''
  z2_2:=floattostr(z2[k]+h*n3); //z''

  setS(vals4[0],t2);
  setS(vals4[1],x_2);
  setS(vals4[2],y_2);
  setS(vals4[3],z_2);
  setS(vals4[4],x1_2);
  setS(vals4[5],y1_2);
  setS(vals4[6],z1_2);
  setS(vals4[7],x2_2);
  setS(vals4[8],y2_2);
  setS(vals4[9],z2_2);

  l4:=strtofloat(ArtFormula1.ComputeStr(DiffEquX,num,@vars,@vals4));
  m4:=strtofloat(ArtFormula1.ComputeStr(DiffEquY,num,@vars,@vals4));
  n4:=strtofloat(ArtFormula1.ComputeStr(DiffEquZ,num,@vars,@vals4));

  //Final result
  x[k+1]:=x[k]+h/6*(f1+2*f2+2*f3+f4); //x
  y[k+1]:=y[k]+h/6*(g1+2*g2+2*g3+g4); //y
  z[k+1]:=z[k]+h/6*(h1+2*h2+2*h3+h4); //z

  x1[k+1]:=x1[k]+h/6*(i1+2*i2+2*i3+i4); //x'
  y1[k+1]:=y1[k]+h/6*(j1+2*j2+2*j3+j4);  //y'
  z1[k+1]:=z1[k]+h/6*(k1+2*k2+2*k3+k4);  //z'

  x2[k+1]:=x2[k]+h/6*(l1+2*l2+2*l3+l4); //x''
  y2[k+1]:=y2[k]+h/6*(m1+2*m2+2*m3+m4);  //y''
  z2[k+1]:=z2[k]+h/6*(n1+2*n2+2*n3+n4);  //z''

 end;

 ResultMemo.lines.clear;
 TitleView1:='k         tk                       xk                                      yk                                       zk';
 TitleView2:='k         tk                       x '' k                                    y '' k                                     z '' k';
 TitleView3:='k         tk                       x '''' k                                    y '''' k                                  z '''' k ';
 TitleView4:='k         tk                       xk                                      x '' k                                     x '''' k';
 TitleView5:='k         tk                       yk                                      y '' k                                       y '''' k';
 TitleView6:='k         tk                       zk                                      z '' k                                       z '''' k';

 Lines:='===================================================================';

 Case (ViewRadioGr.ItemIndex) of
 0:
 begin
  ResultMemo.Lines.Add(TitleView1);
  ResultMemo.Lines.Add(Lines);
  for k:=0 to M do
  begin
   ResultMemo.Lines.Add(inttostr(k)+format(' %10.3f',[t[k]])+format(' %26.18e',[x[k]])+format(' %26.18e',[y[k]])+format(' %26.18e',[z[k]]));
  end;
 end;

 1:
 begin
 ResultMemo.Lines.Add(TitleView2);
  ResultMemo.Lines.Add(Lines);
  for k:=0 to M do
  begin
   ResultMemo.Lines.Add(inttostr(k)+format(' %10.3f',[t[k]])+format(' %26.18e',[x1[k]])+format(' %26.18e',[y1[k]])+format(' %26.18e',[z1[k]]));
  end;
 end;

 2:
 begin
   ResultMemo.Lines.Add(TitleView3);
   ResultMemo.Lines.Add(Lines);
  for k:=0 to M do
  begin
   ResultMemo.Lines.Add(inttostr(k)+format(' %10.3f',[t[k]])+format(' %26.18e',[x2[k]])+format(' %26.18e',[y2[k]])+format(' %26.18e',[z2[k]]));
  end;
 end;

 3:
 begin
   ResultMemo.Lines.Add(TitleView4);
   ResultMemo.Lines.Add(Lines);
  for k:=0 to M do
  begin
   ResultMemo.Lines.Add(inttostr(k)+format(' %10.3f',[t[k]])+format(' %26.18e',[x[k]])+format(' %26.18e',[x1[k]])+format(' %26.18e',[x2[k]]));
  end;
 end;

 4:
 begin
   ResultMemo.Lines.Add(TitleView5);
   ResultMemo.Lines.Add(Lines);
  for k:=0 to M do
  begin
   ResultMemo.Lines.Add(inttostr(k)+format(' %10.3f',[t[k]])+format(' %26.18e',[y[k]])+format(' %26.18e',[y1[k]])+format(' %26.18e',[y2[k]]));
  end;
 end;

 5:
 begin
   ResultMemo.Lines.Add(TitleView6);
   ResultMemo.Lines.Add(Lines);
  for k:=0 to M do
  begin
   ResultMemo.Lines.Add(inttostr(k)+format(' %10.3f',[t[k]])+format(' %26.18e',[z[k]])+format(' %26.18e',[z1[k]])+format(' %26.18e',[z2[k]]));
  end;
 end;

 end;

 //Graph

 //Clear graph
 Series1.Clear;
 Series2.Clear;
 Series3.Clear;
 Series4.Clear;
 Series5.Clear;
 Series6.Clear;
 Series7.Clear;
 Series8.Clear;
 Series9.Clear;

  //Make legend not visible
  Series1.Legend.Visible:=false;
  Series2.Legend.Visible:=false;
  Series3.Legend.Visible:=false;
  Series4.Legend.Visible:=false;
  Series5.Legend.Visible:=false;
  Series6.Legend.Visible:=false;
  Series7.Legend.Visible:=false;
  Series8.Legend.Visible:=false;
  Series9.Legend.Visible:=false;


 Case (ViewRadioGr.ItemIndex) of
 0: //x,y,z
 begin
  Chart1.LeftAxis.Title.Caption:='x , y , z';
  Series1.Legend.Visible:=true;
  Series2.Legend.Visible:=true;
  Series3.Legend.Visible:=true;

  for k:=0 to M do
  begin
    Series1.AddXY(t[k],x[k] ); //(t,x)
    Series2.AddXY(t[k],y[k] ); //(t,y)
    Series3.AddXY(t[k],z[k] );  //(t,z)
  end;
 end;

 1: // x',y',z'
 begin
  Chart1.LeftAxis.Title.Caption:='x '' , y '' , z '' '; //for display char ('), e.g. (x'') means first derivative,will be display as (x')
  Series4.Legend.Visible:=true;
  Series5.Legend.Visible:=true;
  Series6.Legend.Visible:=true;

  for k:=0 to M do
  begin
    Series4.AddXY(t[k],x1[k] ); //(t,x')
    Series5.AddXY(t[k],y1[k] ); //(t,y')
    Series6.AddXY(t[k],z1[k] );  //(t,z')
  end;
 end;

 2: // x'',y'',z''
 begin
  Chart1.LeftAxis.Title.Caption:='x '''' , y '''' , z '''' ';
  Series7.Legend.Visible:=true;
  Series8.Legend.Visible:=true;
  Series9.Legend.Visible:=true;

  for k:=0 to M do
  begin
    Series7.AddXY(t[k],x2[k] ); //(t,x'')
    Series8.AddXY(t[k],y2[k] ); //(t,y'')
    Series9.AddXY(t[k],z2[k] );  //(t,z'')
  end;
 end;

 3: // x,x',x''
 begin
  Chart1.LeftAxis.Title.Caption:='x , x '' , x '''' ';
  Series1.Legend.Visible:=true;
  Series4.Legend.Visible:=true;
  Series7.Legend.Visible:=true;

  for k:=0 to M do
  begin
    Series1.AddXY(t[k],x[k] ); //(t,x)
    Series4.AddXY(t[k],x1[k] ); //(t,x')
    Series7.AddXY(t[k],x2[k] );  //(t,x'')
  end;
 end;

 4: // y,y',y''
 begin
  Chart1.LeftAxis.Title.Caption:='y , y '' , y '''' ';
  Series2.Legend.Visible:=true;
  Series5.Legend.Visible:=true;
  Series8.Legend.Visible:=true;

  for k:=0 to M do
  begin
    Series2.AddXY(t[k],y[k] ); //(t,y)
    Series5.AddXY(t[k],y1[k] ); //(t,y')
    Series8.AddXY(t[k],y2[k] );  //(t,y'')
  end;
 end;

 5: // z,z',z''
 begin
  Chart1.LeftAxis.Title.Caption:='z , z '' , z '''' ';
  Series3.Legend.Visible:=true;
  Series6.Legend.Visible:=true;
  Series9.Legend.Visible:=true;

  for k:=0 to M do
  begin
    Series3.AddXY(t[k],z[k] ); //(t,z)
    Series6.AddXY(t[k],z1[k] ); //(t,z')
    Series9.AddXY(t[k],z2[k] );  //(t,z'')
  end;
 end;

 end;


 stop:


 except
  showmessage('Something wrong with the input !!!');
 end;
 stop_time := Now;
 elapsed := stop_time - start_time;
 ProcessTime.Caption:='Process time : '+timetostr(elapsed)+' (hh:mm:ss)';

end;


procedure TForm1.ClearButClick(Sender: TObject);
begin
 //clear
 xEquationEdit.Clear;
 yEquationEdit.Clear;
 zEquationEdit.Clear;
 aEdit.Clear;
 bEdit.Clear;
 MEdit.Clear;
 xt0Edit.Clear;
 yt0Edit.Clear;
 zt0Edit.Clear;
 x1t0Edit.Clear;
 y1t0Edit.Clear;
 z1t0Edit.Clear;
 x2t0Edit.Clear;
 y2t0Edit.Clear;
 z2t0Edit.Clear;
 ResultMemo.Clear;

 //Clear graph
 Series1.Clear;
 Series2.Clear;
 Series3.Clear;
 Series4.Clear;
 Series5.Clear;
 Series6.Clear;
 Series7.Clear;
 Series8.Clear;
 Series9.Clear;

end;

procedure TForm1.aboutButClick(Sender: TObject);
const
 sAbout = '|======== System of Third-Order ODEs Solver  ========|' + #13#10 +
          '' + #13#10 +
          'Version 1.0 - build Sept 24, 2024'+ #13#10 +
          'Created by Lukas Setiawan.' + #13#10 +
          'Copyright (c) 2024. All Rights Reserved.' + #13#10 +
          '' + #13#10 +
          'Visit www.metodenumeriku.blogspot.com' + #13#10 +
          'Facebook search: Metode Numerik-Plus Programnya' + #13#10 +
          'E-mail : lukassetiawan@yahoo.com' + #13#10 +
          '' + #13#10 +
          'My other works :'+ #13#10 +
          'https://bitbucket.org/nixz97/nix/downloads/' + #13#10 +

          '' + #13#10 +
          'Accepting donations for software development.'+ #13#10;

begin
 MessageDlg( sAbout, mtInformation, [mbOK], 0);
end;

procedure TForm1.exampleButClick(Sender: TObject);
begin
 //example
 xEquationEdit.Text:='2*s-p+x+sin(t)+y-z';
 yEquationEdit.Text:='-u+4*q-2*y+exp(t)+x';
 zEquationEdit.Text:='-3*v-2*r+z+cos(t)+x-y';
 aEdit.Text:='0';
 bEdit.Text:='10';
 MEdit.Text:='100';
 xt0Edit.Text:='0';
 yt0Edit.Text:='1';
 zt0Edit.Text:='0';
 x1t0Edit.Text:='0';
 y1t0Edit.Text:='0';
 z1t0Edit.Text:='1';
 x2t0Edit.Text:='1';
 y2t0Edit.Text:='0';
 z2t0Edit.Text:='0';

end;


end.

