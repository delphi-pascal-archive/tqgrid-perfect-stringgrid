unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, QGrid, ComCtrls, ExtCtrls, Spin;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    TrackBar2: TTrackBar;
    TrackBar1: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    RadioButton6: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton4: TRadioButton;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    CheckBox2: TCheckBox;
    ColorBox1: TColorBox;
    Label3: TLabel;
    Label4: TLabel;
    ColorBox2: TColorBox;
    Label5: TLabel;
    ColorBox3: TColorBox;
    Label6: TLabel;
    ColorBox4: TColorBox;
    ColorBox5: TColorBox;
    Label7: TLabel;
    Label8: TLabel;
    ColorBox6: TColorBox;
    Label9: TLabel;
    ColorBox7: TColorBox;
    ColorBox8: TColorBox;
    Label10: TLabel;
    GroupBox5: TGroupBox;
    Label11: TLabel;
    ColorBox9: TColorBox;
    Label12: TLabel;
    Label13: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    GroupBox6: TGroupBox;
    Label14: TLabel;
    ColorBox10: TColorBox;
    Label15: TLabel;
    ColorBox11: TColorBox;
    Label16: TLabel;
    ColorBox12: TColorBox;
    GroupBox7: TGroupBox;
    CheckBox1: TCheckBox;
    GroupBox8: TGroupBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    Procedure ClickBu(Sender : TObject; ACol,ARow:Integer ; TextCell:String) ;
    Procedure OnclickSup(sender : TObject; ACol, ARow : Integer) ;
    Procedure OnClickVal(sender : TObject; ACol, ARow : Integer) ;
    Procedure OnClickChek(Sender : TObject; ACol, ARow : Integer);
    Procedure OnClickRadio(Sender : TObject; ACol, ARow : Integer);
    Procedure OnClickCadenas(Sender : TObject; ACol, ARow : Integer);
    Procedure OnClickBitmap(Sender : TObject; ACol, ARow, AItem : Integer);
    Procedure OnClickMot(Sender : TObject; ACol, ARow : Integer);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure RadioButton6Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure ColorBox2Change(Sender: TObject);
    procedure ColorBox3Change(Sender: TObject);
    procedure ColorBox4Change(Sender: TObject);
    procedure ColorBox5Change(Sender: TObject);
    procedure ColorBox6Change(Sender: TObject);
    procedure ColorBox7Change(Sender: TObject);
    procedure ColorBox8Change(Sender: TObject);
    procedure ColorBox9Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure ColorBox11Change(Sender: TObject);
    procedure ColorBox10Change(Sender: TObject);
    procedure ColorBox12Change(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;
  QGrille1 : TQGrid;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
begin
    QGrille1.ColCheckedVisible:=not QGrille1.ColCheckedVisible;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    QGrille1.ProgressBar.DiamBall:=0;
    QGrille1.ProgressBar.StyleGradient:=sgRond;
    QGrille1.ProgressBar.Ball:=not QGrille1.ProgressBar.Ball;
    QGrille1.Refresh;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
    case QGrille1.ProgressBar.StyleText of
        sttNone:QGrille1.ProgressBar.StyleText:=sttValue;
        sttValue:QGrille1.ProgressBar.StyleText:=sttPercent;
        sttPercent:QGrille1.ProgressBar.StyleText:=sttNone;
    end;
    QGrille1.Refresh;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
    if QGrille1.ProgressBar.StyleGradient=sgHorizontal then
    begin
        QGrille1.ProgressBar.StyleGradient:=sgRond;
        QGrille1.ProgressBar.Ball:=False;
    end
    else
        QGrille1.ProgressBar.StyleGradient:=sgHorizontal;
    QGrille1.Refresh;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
    QGrille1.CheckBox.Check3D:=not QGrille1.CheckBox.Check3D;
    QGrille1.Refresh;
end;

Procedure TForm1.ClickBu(Sender : TObject; ACol,ARow:Integer ; TextCell:String);
begin
    if CheckBox1.Checked then
        ShowMessage(TextCell);
end;

procedure TForm1.ColorBox1Change(Sender: TObject);
begin
    QGrille1.CheckBox.ColorStick:=ColorBox1.Selected;
    QGrille1.Refresh;
end;

procedure TForm1.ColorBox2Change(Sender: TObject);
begin
    QGrille1.CheckBox.ColorStickGrayed:=ColorBox2.Selected;
    QGrille1.Refresh;
end;

procedure TForm1.ColorBox3Change(Sender: TObject);
begin
    QGrille1.CheckBox.ColorFontCheck:=ColorBox3.Selected;
    QGrille1.Refresh;
end;

procedure TForm1.ColorBox4Change(Sender: TObject);
begin
    QGrille1.CheckBox.ColorGrayed1:=ColorBox4.Selected;
    QGrille1.Refresh;
end;

procedure TForm1.ColorBox5Change(Sender: TObject);
begin
    QGrille1.CheckBox.ColorGrayed2:=ColorBox5.Selected;
    QGrille1.Refresh;
end;

procedure TForm1.ColorBox6Change(Sender: TObject);
begin
    QGrille1.CheckBox.ColorTourCheck:=ColorBox6.Selected;
    QGrille1.Refresh;
end;

procedure TForm1.ColorBox7Change(Sender: TObject);
begin
    QGrille1.ReadProgressGrid(2,12);
    QGrille1.ProgressBar.ColorFirst:=ColorBox7.Selected;
    QGrille1.WriteProgressGrid(2,12,QGrille1.ProgressBar.Position,0,100,
        QGrille1.ProgressBar.ColorFirst,QGrille1.ProgressBar.ColorEnd);
    QGrille1.Refresh;
end;

procedure TForm1.ColorBox8Change(Sender: TObject);
begin
    QGrille1.ReadProgressGrid(2,12);
    QGrille1.ProgressBar.ColorEnd:=ColorBox8.Selected;
    QGrille1.WriteProgressGrid(2,12,QGrille1.ProgressBar.Position,0,100,
        QGrille1.ProgressBar.ColorFirst,QGrille1.ProgressBar.ColorEnd);
    QGrille1.Refresh;
end;

Procedure TForm1.OnClickSup(sender : TObject; ACol, ARow : Integer) ;
begin
    if CheckBox1.Checked then
        ShowMessage('Supprimer');
end;

Procedure TForm1.OnClickVal(sender : TObject; ACol, ARow : Integer) ;
begin
    if CheckBox1.Checked then
        ShowMessage('Valider');
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
    QGrille1.ProgressBar.StyleGradient:=sgHorizontal;
    QGrille1.ProgressBar.Ball:=False;
    QGrille1.Refresh;
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
    QGrille1.ProgressBar.StyleGradient:=sgRond;
    QGrille1.ProgressBar.Ball:=False;
    QGrille1.Refresh;
end;

procedure TForm1.RadioButton3Click(Sender: TObject);
begin
    QGrille1.ProgressBar.DiamBall:=0;
    QGrille1.ProgressBar.StyleGradient:=sgRond;
    QGrille1.ProgressBar.Ball:=True;
    QGrille1.Refresh;
end;

procedure TForm1.RadioButton4Click(Sender: TObject);
begin
    QGrille1.ProgressBar.StyleText:=sttNone;
    QGrille1.InvalidateCell(2,12);
end;

procedure TForm1.RadioButton5Click(Sender: TObject);
begin
    QGrille1.ProgressBar.StyleText:=sttValue;
    QGrille1.InvalidateCell(2,12);
end;

procedure TForm1.RadioButton6Click(Sender: TObject);
begin
    QGrille1.ProgressBar.StyleText:=sttPercent;
    QGrille1.InvalidateCell(2,12);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
    QGrille1.ProgressBar.DiamBall:=TrackBar1.Position;
    QGrille1.InvalidateCell(2,12);
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
    QGrille1.ReadProgressGrid(2,12);
    QGrille1.WriteProgressGrid(2,12,TrackBar2.Position,0,100,
        QGrille1.ProgressBar.ColorFirst,QGrille1.ProgressBar.ColorEnd);
end;

Procedure TForm1.OnClickChek(Sender : TObject; ACol, ARow : Integer);
begin
    QGrille1.ReadCheckGrid(ACol,ARow);
    if CheckBox1.Checked then
        case QGrille1.CheckBox.CheckGrayed of
            GTrue   : ShowMessage(BoolToStr(QGrille1.CheckBox.Checked,True)+'+'+BoolToStr(QGrille1.CheckBox.Grayed,true)+'+'+'GTRUE');
            GFalse  : ShowMessage(BoolToStr(QGrille1.CheckBox.Checked,True)+'+'+BoolToStr(QGrille1.CheckBox.Grayed,true)+'+'+'GFALSE');
            GGrayed : ShowMessage(BoolToStr(QGrille1.CheckBox.Checked,True)+'+'+BoolToStr(QGrille1.CheckBox.Grayed,true)+'+'+'GGRAYED');
        end;
    QGrille1.Refresh;
end;

Procedure TForm1.OnClickRadio(Sender : TObject; ACol, ARow : Integer);
begin
    if CheckBox1.Checked then
    begin
        QGrille1.ReadRadioGrid(ACol,ARow);
        ShowMessage(BoolToStr(QGrille1.RadioButton.Checked,true));
    end;
end;

Procedure TForm1.OnClickCadenas(Sender : TObject; ACol, ARow : Integer);
begin
    if CheckBox1.Checked then
    begin
        QGrille1.ReadCadGrid(ACol,ARow);
        ShowMessage(BoolToStr(QGrille1.Cadenas.Checked,true));
    end;
end;

Procedure TForm1.OnClickBitmap(Sender : TObject; ACol, ARow, AItem : Integer);
begin
    if CheckBox1.Checked then
    begin
        QGrille1.Items.ReadBitmapItems(ACol,ARow);
        ShowMessage(BoolToStr(QGrille1.Items[AItem].Checked,True));
    end;
end;

Procedure TForm1.OnClickMot(Sender : TObject; ACol, ARow : Integer);
begin
    if CheckBox1.Checked then
    begin
        QGrille1.ReadMotifGrid(ACol,ARow);
        case QGrille1.Motif.Types of
            tmCoeur     : ShowMessage(IntToStr(QGrille1.Motif.Nombre)+' Coeur dont '+IntToStr(QGrille1.Motif.Plein)+' Plein');
            tmCarre     : ShowMessage(IntToStr(QGrille1.Motif.Nombre)+' Carre dont '+IntToStr(QGrille1.Motif.Plein)+' Plein');
            tmRond      : ShowMessage(IntToStr(QGrille1.Motif.Nombre)+' Rond dont '+IntToStr(QGrille1.Motif.Plein)+' Plein');
            tmEtoile    : ShowMessage(IntToStr(QGrille1.Motif.Nombre)+' Etoile dont '+IntToStr(QGrille1.Motif.Plein)+' Plein');
            tmCadenas   : ShowMessage(IntToStr(QGrille1.Motif.Nombre)+' Cadenas dont '+IntToStr(QGrille1.Motif.Plein)+' Plein');
        end;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    QGrille1:=TQGrid.Create(Form1);
    QGrille1.Parent:=Form1;
    Qgrille1.Left:=2;
    QGrille1.Top:=2;
    QGrille1.Height:=608;
    QGrille1.Width:=400;
    QGrille1.RowCount:=1000;
    QGrille1.ColCount:=4;
    QGrille1.ColWidths[0]:=20;
    QGrille1.ColWidths[1]:=150;
    QGrille1.ColWidths[2]:=100;
    QGrille1.ColWidths[3]:=100;
    QGrille1.RowHeights[12]:=100;
    QGrille1.RowHeights[17]:=50;
    QGrille1.RowHeights[18]:=50;
    QGrille1.ColCheckedVisible:=True;
    QGrille1.Options:=QGrille1.Options+[goColSizing,goRowSizing];
    qgrille1.LigColorVisible:=True;
    qgrille1.DefaultDrawing:=False;
    QGrille1.ProgressBar.StyleGradient:=sgHorizontal;
    QGrille1.Button.Add.Text:='Supprimer';
    Qgrille1.Button.Items[0].OnClickButtonItem:=OnclickSup;
    QGrille1.Button.Add.Text:='Valider';
    QGrille1.Button.Items[1].ColorFirst:=clYellow;
    QGrille1.Button.Items[1].ColorEnd:=clBlack;
    QGrille1.Button.Items[1].ColorText:=clWhite;
    Qgrille1.Button.Items[1].OnClickButtonItem:=OnclickVal;

    QGrille1.OnClickCheckBox:=OnClickChek;
    QGrille1.OnClickRadioButton:=OnClickRadio;
    QGrille1.OnClickCadenas:=OnClickCadenas;
    QGrille1.OnClickMotif:=OnClickMot;
    QGrille1.Cells[1,1]:='CheckBox';
    QGrille1.Cells[1,2]:='CheckBox Grayed';
    QGrille1.Cells[1,3]:='CheckBox Enabled';
    QGrille1.Cells[1,4]:='CheckBox Grayed Enabled';
    QGrille1.Cells[1,5]:='RaddioButton';
    QGrille1.Cells[1,6]:='RaddioButton Enabled';
    QGrille1.Cells[1,7]:='Motif Etoile';
    QGrille1.Cells[1,8]:='Motif Coeur';
    QGrille1.Cells[1,9]:='Motif Cadenas';
    QGrille1.Cells[1,10]:='Motif Carre Enabled';
    QGrille1.Cells[1,11]:='Motif Rond';
    QGrille1.Cells[1,12]:='ProgressBar';
    QGrille1.Cells[1,13]:='Bouton';
    QGrille1.Cells[1,14]:='Bouton';
    QGrille1.Cells[1,15]:='Checkbox Cadenas';
    QGrille1.Cells[1,16]:='Checkbox Cadenas Enabled';
    QGrille1.Cells[1,17]:='Image CheckBox';
    QGrille1.Cells[1,18]:='Image Enabled';

    QGrille1.WriteCheckGrid(2,1,False);
    QGrille1.WriteCheckGrid(2,2,False,True,False,GGrayed);
    QGrille1.WriteCheckGrid(2,3,False,False,True);
    QGrille1.WriteCheckGrid(2,4,True,True,True,GGrayed);
    QGrille1.WriteRadioGrid(2,5);
    QGrille1.WriteRadioGrid(2,6,True,True);
    QGrille1.WriteMotifGrid(2,7,False,tmEtoile,3,2);
    QGrille1.WriteMotifGrid(2,8,False,tmCoeur,3,2,clRed);
    QGrille1.WriteMotifGrid(2,9,False,tmCadenas,2,1);
    QGrille1.WriteMotifGrid(2,10,True,tmCarre,2,1);
    QGrille1.WriteMotifGrid(2,11,False,tmRond,5,3,clRed);
    QGrille1.WriteProgressGrid(2,12,85);
    QGrille1.Button.WriteButton(2,13,0);
    QGrille1.Button.WriteButton(2,14,1);
    QGrille1.WriteCadGrid(2,15,True,False);
    QGrille1.WriteCadGrid(2,16,True,True);
    with QGrille1.Items.Add do
    begin
          PictureTrue.LoadFromFile(ExtractFilePath(Application.ExeName)+'185288.cs.jpg');
          PictureFalse.LoadFromFile(ExtractFilePath(Application.ExeName)+'1852882.cs.jpg');
    end;
    QGrille1.Items.WriteBitmapItems(2,17,0,False,True,True);
    QGrille1.Items[0].OnClickBitmapItem:=OnClickBitmap;
    with QGrille1.Items.Add do
    begin
          PictureTrue.LoadFromFile(ExtractFilePath(Application.ExeName)+'185288.cs.jpg');
    end;
    QGrille1.Items.WriteBitmapItems(2,18,0,True,True,True);
    QGrille1.Items[1].OnClickBitmapItem:=OnClickBitmap;

    ColorBox1.Selected:=QGrille1.CheckBox.ColorStick;
    ColorBox2.Selected:=QGrille1.CheckBox.ColorStickGrayed;
    ColorBox3.Selected:=QGrille1.CheckBox.ColorFontCheck;
    ColorBox4.Selected:=QGrille1.CheckBox.ColorGrayed1;
    ColorBox5.Selected:=QGrille1.CheckBox.ColorGrayed2;
    ColorBox6.Selected:=QGrille1.CheckBox.ColorTourCheck;
end;

procedure TForm1.ColorBox9Change(Sender: TObject);
begin
    QGrille1.ReadMotifGrid(2,7);
    QGrille1.Motif.Color:=ColorBox9.Selected;
    with QGrille1.Motif do
        QGrille1.WriteMotifGrid(2,7,Enabled,tmEtoile,Nombre,Plein,Color);
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
    QGrille1.ReadMotifGrid(2,7);
    QGrille1.Motif.Nombre:=SpinEdit1.Value;
    with QGrille1.Motif do
        QGrille1.WriteMotifGrid(2,7,Enabled,tmEtoile,Nombre,Plein,Color);
end;

procedure TForm1.SpinEdit2Change(Sender: TObject);
begin
    QGrille1.ReadMotifGrid(2,7);
    QGrille1.Motif.Plein:=SpinEdit2.Value;
    with QGrille1.Motif do
        QGrille1.WriteMotifGrid(2,7,Enabled,tmEtoile,Nombre,Plein,Color);
end;

procedure TForm1.ColorBox11Change(Sender: TObject);
begin
    QGrille1.Button.Items[1].ColorEnd:=ColorBox11.Selected;
    QGrille1.Refresh;
end;

procedure TForm1.ColorBox10Change(Sender: TObject);
begin
    QGrille1.Button.Items[1].ColorFirst:=ColorBox10.Selected;
    QGrille1.Refresh;
end;

procedure TForm1.ColorBox12Change(Sender: TObject);
begin
    QGrille1.Button.Items[1].ColorText:=ColorBox12.Selected;
    QGrille1.Refresh;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
    QGrille1.Items[0].Checked:=not QGrille1.Items[0].Checked;
    QGrille1.Items.WriteBitmapItems(2,17,0,False,True,QGrille1.Items[0].Checked);
    QGrille1.Refresh;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
    QGrille1.ReadCheckGrid(2,1);
    QGrille1.CheckBox.Checked:=not QGrille1.CheckBox.Checked;
    QGRille1.WriteCheckGrid(2,1,QGrille1.CheckBox.Checked);
end;

end.
