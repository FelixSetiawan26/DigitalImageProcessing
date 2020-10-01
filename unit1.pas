unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ExtDlgs, ExtCtrls, ComCtrls;

type
  { TForm1 }
  TForm1 = class(TForm)
    BrightnessLabel: TLabel;
    BinerBtn: TButton;
    BrightnessLabel1: TLabel;
    BrightnessLabel2: TLabel;
    ContrastBtn: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    SmoothingBtn: TButton;
    GrayscaleBtn: TButton;
    SharpeningBtn: TButton;
    SketchBtn: TButton;
    ResetBtn: TButton;
    Edit1: TEdit;
    SaveBtn: TButton;
    Image1: TImage;
    InversBtn: TButton;
    BrightnessBtn: TButton;
    InsertBtn: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    TrackBar1: TTrackBar;
    TrackBarG: TTrackBar;
    TrackBarP: TTrackBar;
    procedure BinerBtnClick(Sender: TObject);
    procedure ContrastBtnClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure BrightnessLabelClick(Sender: TObject);
    procedure GrayscaleBtnClick(Sender: TObject);
    procedure ResetBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure InsertBtnClick(Sender: TObject);
    procedure InversBtnClick(Sender: TObject);
    procedure SharpeningBtnClick(Sender: TObject);
    procedure SketchBtnClick(Sender: TObject);
    procedure SmoothingBtnClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBarGChange(Sender: TObject);
    procedure TrackBarPChange(Sender: TObject);
  private

  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
uses
 windows;
var
 bitmapR, bitmapG, bitmapB : array [0..1000, 0..1000] of Byte;
 tempR, tempG, tempB : array [0..1000, 0..1000] of Byte;

procedure TForm1.InsertBtnClick(Sender: TObject);
var
   x, y : integer;
begin
    if OpenPictureDialog1.Execute then
       begin
            Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
            for y:=0 to image1.Height-1 do
            begin
                 for x:=0 to image1.Width-1 do
                 begin
                      bitmapR[x,y] := GetRValue(image1.Canvas.Pixels[x,y]);
                      bitmapG[x,y] := GetGValue(image1.Canvas.Pixels[x,y]);
                      bitmapB[x,y] := GetBValue(image1.Canvas.Pixels[x,y]);
                      tempR[x,y] := bitmapR[x,y];
                      tempG[x,y] := bitmapG[x,y];
                      tempB[x,y] := bitmapB[x,y];
                 end;
            end;
       end;
     TrackBar1.Position := 0;
     Edit1.Text := IntToStr (0);
end;

procedure TForm1.SaveBtnClick(Sender: TObject);
begin
     if SavePictureDialog1.Execute then
     begin
          image1.Picture.SaveToFile(SavePictureDialog1.FileName);
     end;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.BinerBtnClick(Sender: TObject);
var
   x, y, gray : integer;
begin
     for y:=0 to image1.Height-1 do
     begin
         for x:=0 to image1.Width-1 do
         begin
              gray := (bitmapR[x,y] + bitmapG[x,y] + bitmapB[x,y]) div 3;
              if gray>120 then
                 begin
                 bitmapR[x,y]:=255;
                 bitmapG[x,y]:=255;
                 bitmapB[x,y]:=255;
                 image1.Canvas.Pixels[x,y] := RGB(bitmapR[x,y], bitmapG[x,y], bitmapB[x,y]);
                 end
              else
                  begin
                  bitmapR[x,y]:=0;
                  bitmapG[x,y]:=0;
                  bitmapB[x,y]:=0;
                  image1.Canvas.Pixels[x,y] := RGB(bitmapR[x,y], bitmapG[x,y], bitmapB[x,y]);
                  end
         end;
     end;
     image1.Canvas.Pixels[x,y] := RGB(bitmapR[x,y], bitmapG[x,y], bitmapB[x,y]);
end;

procedure TForm1.ContrastBtnClick(Sender: TObject);
var
   ContrastR,ContrastG,ContrastB, x, y, G,P: integer;
begin
     G := TrackBarG.Position;
     P := TrackBarP.Position;
   for y:=0 to image1.Height-1 do
   begin
        for x:=0 to image1.Width-1 do
            begin
                 ContrastR := ((G*(bitmapR[x,y]-P))+P);
                 ContrastG := ((G*(bitmapG[x,y]-P))+P);
                 ContrastB := ((G*(bitmapB[x,y]-P))+P);
                 if ContrastR>255 then
                    ContrastR := 255;
                 if ContrastG>255 then
                    ContrastG := 255;
                 if ContrastB>255 then
                    ContrastB := 255;

                 if ContrastR<0 then
                    ContrastR := 0;
                 if ContrastG<0 then
                    ContrastG := 0;
                 if ContrastB<0 then
                    ContrastB := 0;
                 image1.Canvas.Pixels[x,y] := RGB(ContrastR, ContrastG, ContrastB);
            end;
   end;
end;

procedure TForm1.BrightnessLabelClick(Sender: TObject);
begin

end;

procedure TForm1.GrayscaleBtnClick(Sender: TObject);
var
   gray, x, y : integer;
begin
   for y:=0 to image1.Height-1 do
   begin
        for x:=0 to image1.Width-1 do
        begin
             gray := (bitmapR[x,y] + bitmapG[x,y] + bitmapB[x,y]) div 3;
             image1.Canvas.Pixels[x,y] := RGB(gray, gray, gray);
        end;
   end;
end;

procedure TForm1.ResetBtnClick(Sender: TObject);
begin
   TrackBar1.Position := 0;
   Edit1.Text := IntToStr (0);
end;

procedure TForm1.InversBtnClick(Sender: TObject);
var
   inversR,inversG,inversB, x, y: integer;
begin
   for y:=0 to image1.Height-1 do
   begin
        for x:=0 to image1.Width-1 do
            begin
                 inversR := (255-bitmapR[x,y]);
                 inversG := (255-bitmapG[x,y]);
                 inversB := (255-bitmapB[x,y]);
                 image1.Canvas.Pixels[x,y] := RGB(inversR, inversG, inversB);
            end;
   end;
end;

procedure TForm1.SharpeningBtnClick(Sender: TObject);
var
  x, y  : integer;
  SharpeningR, SharpeningG, SharpeningB : double;
begin
     for y:= 0 to image1.height-1 do
     begin
          for x:= 0 to image1.width-1 do
          begin
          SharpeningR := (bitmapR[x-1][y-1] * (-0.1)) + (bitmapR[x][y-1] * (-0.1)) + (bitmapR[x+1][y-1] * (-0.1))
                         + (bitmapR[x-1][y] * (-0.1)) + (bitmapR[x][y] * 1.8) + (bitmapR[x+1][y] * (-0.1))
                         + (bitmapR[x-1][y+1] * (-0.1)) + (bitmapR[x][y+1] * (-0.1)) + (bitmapR[x+1][y+1] * (-0.1));
          SharpeningG := (bitmapG[x-1][y-1] * (-0.1)) + (bitmapG[x][y-1] * (-0.1)) + (bitmapG[x+1][y-1] * (-0.1))
                         + (bitmapG[x-1][y] * (-0.1)) + (bitmapG[x][y] * 1.8) + (bitmapG[x+1][y] * (-0.1))
                         + (bitmapG[x-1][y+1] * (-0.1)) + (bitmapG[x][y+1] * (-0.1)) + (bitmapG[x+1][y+1] * (-0.1));
          SharpeningB := (bitmapB[x-1][y-1] * (-0.1)) + (bitmapB[x][y-1] * (-0.1)) + (bitmapB[x+1][y-1] * (-0.1))
                         + (bitmapB[x-1][y] * (-0.1)) + (bitmapB[x][y] * 1.8) + (bitmapB[x+1][y] * (-0.1))
                         + (bitmapB[x-1][y+1] * (-0.1)) + (bitmapB[x][y+1] * (-0.1)) + (bitmapB[x+1][y+1] * (-0.1));
          if SharpeningR>255 then
          begin
                SharpeningR := 255;
          end;
          if SharpeningG>255 then
          begin
             SharpeningG := 255;
          end;
          if SharpeningB>255 then
          begin
            SharpeningB := 255;
          end;

          if SharpeningR<0 then
          begin
             SharpeningR:= 0;
          end;
          if SharpeningG<0 then
          begin
             SharpeningG := 0;
          end;
          if SharpeningB<0 then
          begin
             SharpeningB := 0;
          end;
          image1.Canvas.Pixels[x,y] := RGB(Trunc(SharpeningR), Trunc(SharpeningG), Trunc(SharpeningB));
          end;
     end;
end;

procedure TForm1.SketchBtnClick(Sender: TObject);
var
   gray, x, y: integer;
begin
   for y:=0 to image1.Height-1 do
   begin
        for x:=0 to image1.Width-1 do
        begin
             gray := (bitmapR[x,y] + bitmapG[x,y] + bitmapB[x,y]) div 3;
             image1.Canvas.Pixels[x,y] := RGB(gray, gray, gray);
        end;
   end;
end;

procedure TForm1.SmoothingBtnClick(Sender: TObject);
var
  x, y  : integer;
  gausR, gausG, gausB : double;
begin
     for y:= 0 to image1.height-1 do
     begin
          for x:= 0 to image1.width-1 do
          begin
          gausR := (tempR[x-1][y-1] * 0.075) + (tempR[x][y-1] * 0.124) + (tempR[x+1][y-1] * 0.075)
                   + (tempR[x-1][y] * 0.075) + (tempR[x][y] * 0.124) + (tempR[x+1][y] * 0.075)
                   + (tempR[x-1][y+1] * 0.075) + (tempR[x][y+1] * 0.124) + (tempR[x+1][y+1] * 0.075);
          gausG := (tempG[x-1][y-1] * 0.075) + (tempG[x][y-1] * 0.124) + (tempG[x+1][y-1] * 0.075)
                   + (tempG[x-1][y] * 0.075) + (tempG[x][y] * 0.124) + (tempG[x+1][y] * 0.075)
                   + (tempG[x-1][y+1] * 0.075) + (tempG[x][y+1] * 0.124) + (tempG[x+1][y+1] * 0.075);
          gausB := (tempB[x-1][y-1] * 0.075) + (tempB[x][y-1] * 0.124) + (tempB[x+1][y-1] * 0.075)
                   + (tempB[x-1][y] * 0.075) + (tempB[x][y] * 0.124) + (tempB[x+1][y] * 0.075)
                   + (tempB[x-1][y+1] * 0.075) + (tempB[x][y+1] * 0.124) + (tempB[x+1][y+1] * 0.075);
                    if gausR>255 then
                    begin
                       tempR[x,y] := 255;
                    end;
                    if gausG>255 then
                    begin
                       tempG[x,y] := 255;
                    end;
                    if gausB>255 then
                    begin
                       tempB[x,y] := 255;
                    end;

                    if gausR<0 then
                    begin
                       tempR[x,y] := 0;
                    end;
                    if gausG<0 then
                    begin
                       tempG[x,y] := 0;
                    end;
                    if gausB<0 then
                    begin
                       tempB[x,y] := 0;
                    end;
          image1.Canvas.Pixels[x,y] := RGB(Trunc(gausR), Trunc(gausG), Trunc(gausB));
          end;
     end;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
var
   BrightnessR, BrightnessG, BrightnessB, x, y, input: integer;
begin
   input := TrackBar1.Position;
   Edit1.Text := IntToStr (TrackBar1.Position);
   for y:=0 to image1.Height-1 do
   begin
        for x:=0 to image1.Width-1 do
            begin
                 BrightnessR := bitmapR[x,y]+input;
                 BrightnessG := bitmapG[x,y]+input;
                 BrightnessB := bitmapB[x,y]+input;
                 if BrightnessR>255 then
                    BrightnessR := 255;
                 if BrightnessG>255 then
                    BrightnessG := 255;
                 if BrightnessB>255 then
                    BrightnessB := 255;

                 if BrightnessR<0 then
                    BrightnessR := 0;
                 if BrightnessG<0 then
                    BrightnessG := 0;
                 if BrightnessB<0 then
                    BrightnessB := 0;
                 image1.Canvas.Pixels[x,y] := RGB(BrightnessR, BrightnessG, BrightnessB);
            end;
   end;
end;

procedure TForm1.TrackBarGChange(Sender: TObject);
begin
     if TrackBarP.Position = 0 then
        Edit3.Text := '0'
     else
         Edit3.Text := IntToStr (TrackBarG.Position);
end;

procedure TForm1.TrackBarPChange(Sender: TObject);
begin
     if TrackBarP.Position = 0 then
        Edit2.Text := '0'
     else
         Edit2.Text := IntToStr (TrackBarP.Position);
end;



end.
