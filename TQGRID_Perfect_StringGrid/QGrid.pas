{*******************************************************************************

    Composant QGrid Version 2b du 15/10/05 
    Remarque : Abandonné pour un temps indéfini
     
    Author  : Taz alias YANB sur CodesSources
    Contact : http://www.delphifr.com/auteur/YANB/185288.aspx 

    Attention : Si vous modifiez ce code faites en part à l'auteur
                afin de le faire évoluer sur CodesSources.(www.delphifr.com)

    Comment :   - L'auteur ne garantie rien sur le fonctionnement de ce code
                - L'utilisation de ce code est aux risques et périls
                    de l'utilisateur.                                                         

******************************************************************************** 
        
 Re : Ce code vous permet d'avoir dans un StringGrid différent 
        symbols, motifs, items...
        

  TItems    :   1   : TItems ( Image )
                2   : Numéro items
                3   : Redimensionnement automatique à la taille de la cellule
                4   : Image True ou Image False
                ex  : TItems,0,True,False

 VTItems    :   1   : VTItems enabled ( Image verrouiller )
                2   : Numéro items
                3   : Redimensionnement automatique à la taille de la cellule
                4   : Image True ou Image False
                ex  : VTItems,0,True,False

  TProgBar  :   1   : TProgBar ( Barre de progression )
                2   : Position
                3   : Valeur Min
                4   : Valeur Max
                5   : Couleur Début
                6   : Couleur Fin
                ex  : TProgBar,80,0,100,clYellow,clRed

  TMotif    :   1   : TMotif
                2   : Motif (Coeur,Etoile,Carre,Rond,Cadenas)
                3   : Nombre de motif
                4   : Nombre de motif plein
                5   : Couleur du motif
                ex  : TMotif,Coeur,2,1,clred

  VTMotif   :   1   : VTMotif enabled ( verrouiller )
                2   : Motif (Coeur,Etoile,Carre,Rond,Cadenas)
                3   : Nombre de motif
                4   : Nombre de motif plein
                5   : Couleur du motif
                ex  : VTMotif,Coeur,2,1,clred

  TCadTrue ou TCadFalse         : Cadenas se comportant comme un check
  VTCadTrue ou VTCadFalse       : Cadenas se comportant comme un check en enabled ( verrouiller )

  True ou False                 : Check standard
  VTrue ou VFalse               : Check Standard en enabled ( verrouiller )

  RTrue ou RFalse               : Radio standard
  VRTrue ou VRFalse             : Radio Standard en enabled ( verrouiller )

  GTrue ou GFalse ou GGRayed    : Check grayed
  VGTrue ou VGFalse ou VGGRayed : Check grayed en enabled ( verrouiller )

}

unit QGrid;

interface

uses
  Windows, SysUtils, Classes, Controls, Graphics, Grids, Messages, Jpeg;

type

  TPlacTextVert     = (ptvCentre,ptvGauche,ptvDroite);
  TPlacTextHorz     = (pthCentre,pthHaut,pthBas);
  TPlacTextLigne    = (ptlLigne,ptlMultiLigne);
  TStyleGradient    = (sgHorizontal,sgVertical,sgTopLeft,sgTopRight,sgBottomLeft,sgBottomRight,sgRadial,sgDoubleHorz,sgDoubleVert,sgRond);
  TGrayed           = (GTrue,GFalse,GGrayed);
  TStyle            = (sTransparent,sPlein);
  TTypeMotif        = (tmCoeur,tmCarre,tmRond,tmEtoile,tmCadenas);
  TStyleText        = (sttNone,sttValue,sttPercent);   
  TSourcePixel      = (spBottomRight,spBottomLeft,spTopRight,spTopLeft);

  TRGBArray = array[0..0] of TRGBTriple;
  PRGBArray = ^TRGBArray;

  TQGridBitmapCollection    = class;
  TQGridButtonCollection    = class;
  TQCheckBox                = class;
  TQProgressBar             = class;
  TQMotif                   = class;
  TQRadioButton             = class;
  TQCadenas                 = class;
  
  TNotifyButtonItemEvent    = Procedure (Sender : TObject; ACol, ARow : Integer) of object;
  TNotifyCheckEvent         = Procedure (Sender : TObject; ACol, ARow : Integer) of object;
  TNotifyRadioEvent         = Procedure (Sender : TObject; ACol, ARow : Integer) of object;
  TNotifyCadenasEvent       = Procedure (Sender : TObject; ACol, ARow : Integer) of object;
  TNotifyMotifEvent         = Procedure (Sender : TObject; ACol, ARow : Integer) of object;
  TNotifyBitmapItemEvent    = Procedure (Sender : TObject; ACol, ARow, AItem : Integer) of object;

  TQGrid = class(TStringGrid)
    private
    { Déclarations privées }
        MEditing:Boolean;
        FColorLigPaire:TColor;
        FColorLigImpaire:TColor;
        FColorSelection:TColor;
        FLigColorVisible:Boolean;
        FColCheckedVisible:Boolean;
        FEnrXLS:Boolean;
        FPlacTextVert:TPlacTextVert;
        FPlacTextHorz:TPlacTextHorz;
        FPlacTextLigne:TPlacTextLigne;
        FDirectFileXLS:String;
//        FFindDBGrid:String;
        FGrBitmap: TBitmap;
        FItems: TQGridBitmapCollection;
        FVisibleColCount:Longint;
        FVisibleRowCount:Longint;
        FCheckBox:TQCheckBox;
        FProgressBar:TQProgressBar;
        FMotif:TQMotif;
        FRadioButton:TQRadioButton;
        FCadenas:TQCadenas;
        FButton:TQGridButtonCollection;
        MemCol:Longint;
        MemRow:Longint;
        FOnClickCheckBox : TNotifyCheckEvent;
        FOnClickRadioButton : TNotifyRadioEvent;
        FOnClickCadenas : TNotifyCadenasEvent;
        FOnClickMotif : TNotifyMotifEvent;
        Procedure SetColorLigPaire(const Value:TColor);
        Procedure SetColorLigImpaire(const Value:TColor);
        Procedure SetColorSelection(const Value: TColor);
        Procedure SetLigColorVisible(const Value: Boolean);
        Procedure SetColCheckedVisible(const Value: Boolean);
        Procedure SetEnrXls(Const Value: Boolean);
        Procedure SetPlacTextVert(const Value: TPlacTextVert);
        Procedure SetPlacTextHorz(const Value: TPlacTextHorz);
        Procedure SetPlacTextLigne(const Value: TPlacTextLigne);
        Procedure SetDirectFileXLS(const Value: String);
//        Procedure SetFindDBGrid(Const Value: String);
        Procedure SetItems(Value:TQGridBitmapCollection);
        Procedure SetCheckBox(Value:TQCheckBox);
        Procedure SetProgressBar(Value:TQProgressBar);
        Procedure SetMotif(Value:TQMotif);
        Procedure SetRadioButton(Value:TQRadioButton);
        Procedure SetCadenas(Value: TQCadenas);
        Procedure SetButton(Value:TQGridButtonCollection);
    protected
    { Déclarations protégées }
        Procedure DrawCell(ACol, ARow: Longint; ARect: TRect;AState: TGridDrawState); override;
        Procedure DrawCell2(Handle:THandle;ACol: Longint; ARow: Longint; ARect: TRect; AState: TGridDrawState);
        procedure ExtraireChaine(Chaine:string; Tableau:TStringList; Separ:PAnsichar;ViderListe:Boolean=False;Carac:Boolean=False);
        Procedure WriteCheckBox(VCheckCol,VCheckRow:Integer;VChecked:Boolean;VGrayed:Boolean=False;VEnabled:Boolean=False;VCheckGrayed:TGrayed=GFalse);
        Procedure WriteProgressBar(VProgCol,VProgRow:Longint; VPosition:Integer; VMin:Integer=0; VMax:Integer=100; VColorFirst:TColor=clYellow;VColorEnd:TColor=clred);
        Procedure WriteMotif(VMotCol,VMotRow:Longint; Venabled:Boolean; VTypes:TTypeMotif; VNomb:Integer=1; VPlein:Integer=1; VColor:TColor=$000080FF);
        Procedure WriteRadio(VRadioCol,VRadioRow:Longint; VChecked:Boolean; VEnabled:Boolean=False);
        Procedure WriteCad(VCadCol,VCadRow:Longint; VChecked:Boolean; VEnabled:Boolean=False);
        Function  FindText(ACol, ARow: Longint):Boolean;
        Procedure ColorRow(ARow:Longint;var AColor1,AColor2:TColor);
        Procedure AlterCheck;
        Procedure ClickCheckBox;
        Procedure ClickRaddioButton;
        Procedure ClickCadenas;
        Procedure ClickMotif;

    public
    { Déclarations publiques }
        Constructor Create (Aowner:TComponent); override;
        Destructor  Destroy; override;
        Procedure   MouseDown(Button: TMouseButton; Shift: TShiftState;X, Y: Integer);override;
        Procedure   SetEditText(ACol, ARow: Longint; const Value: string); override;
        Procedure   KeyDown(var Key: Word; Shift: TShiftState); override;
        Procedure   TopLeftChanged; override;
        procedure   ColWidthsChanged; override;
        procedure   RowHeightsChanged; override;
        function    SelectCell(ACol, ARow: Longint): Boolean; override;
//        procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
//        procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
//        procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
//        procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
        Procedure XlsWriteCellLabel(XlsStream: TStream; const ACol, ARow: Word; const AValue: string);
        function  SaveAsExcelFile(AGrid: TQGrid; AFileName: string): Boolean;

        Procedure DesCheck(Stick, Active, Grayed:Boolean; ACol, ARow: Longint);
        Procedure DesProgBar(Chaine:TStringList;ACol,ARow:Longint);
        Procedure DesMotif(Chaine:TStringList;ACol,ARow:Longint);
        Procedure DesCad(Stick, Active:Boolean; ACol, ARow: Longint);
        Procedure DesItems(Chaine:TStringList;ACol,ARow:Longint);
        Procedure DesButton(Chaine:TStringList;ACol,ARow:Longint);

        Procedure VerifChaineProg(Chaine:TStringList;ACol,ARow:Longint);
        Procedure VerifChaineMotif(Chaine:TStringList);
        Procedure VerifChaineButton(Chaine:TStringList);
        Function  VerifChaineItems(Chaine:TStringList):Boolean;

    published
    { Déclarations publiées }
        function  WriteCheckGrid(VCol,VRow:Longint; VChecked:Boolean; VGrayed:Boolean=False; VEnabled:Boolean=False; VCheckGrayed:TGrayed=GFalse):Boolean;
        function  ReadCheckGrid(VCol,VRow:Longint):String;
        function  WriteProgressGrid(VCol,VRow:Longint; VPosition:Integer; VMin:Integer=0; VMax:Integer=100; VColorFirst:TColor=clYellow;VColorEnd:TColor=clred):Boolean;
        function  ReadProgressGrid(VCol,VRow:Longint):String;
        function  WriteMotifGrid(VCol,VRow:Longint; VEnabled:Boolean=False; VMotif:TTypeMotif=tmEtoile; VNomb:Integer=1; VPlein:Integer=1; VColor:TColor=$000080FF):Boolean;
        function  ReadMotifGrid(VCol,VRow:Longint):String;
        function  WriteRadioGrid(VCol,VRow:Longint; VChecked:Boolean=False; VEnabled:Boolean=False):Boolean;
        function  ReadRadioGrid(VCol,VRow:Longint):String;
        function  WriteCadGrid(VCol,VRow:Longint; VChecked:Boolean=False; VEnabled:Boolean=False):Boolean;
        function  ReadCadGrid(VCol,VRow:Longint):String;
        procedure InvalidateCell(ACol, ARow: Longint);virtual;

        Property ColorLigPaire:TColor read FColorLigPaire write SetColorLigPaire default $00F2D1B3;
        Property ColorLigImpaire:TColor read FColorLigImpaire write SetColorLigImpaire default $00DEEBFA;
        Property ColorSelection:TColor read FColorSelection write SetColorSelection default $0012F906;
        Property LigColorVisible:Boolean read FLigColorVisible write SetLigColorVisible default True;
        Property EnrXLS:Boolean read FEnrXLS write SetEnrXLS default False;
        Property ColCheckedVisible:Boolean read FColCheckedVisible write SetColCheckedVisible default True;
        Property CPlacTextVert:TPlacTextVert read FPlacTextVert write SetPlacTextVert default ptvCentre;
        Property CPlacTextHorz:TPlacTextHorz read FPlacTextHorz write SetPlacTextHorz default pthCentre;
        Property CPlacTextLigne:TPlacTextLigne read FPlacTextLigne write SetPlacTextLigne default ptlLigne;
        Property DirectFileXLS:String read FDirectFileXLS write SetDirectFileXLS;
//        Property FindDBGrid:String read FFindDBGrid write SetFindDBGrid;
        Property Options default [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goEditing];
        Property FixedColor default $00FF8080;
        Property Items:TQGridBitmapCollection read FItems write SetItems;
        Property CheckBox: TQCheckBox read FCheckBox write SetCheckBox;
        Property ProgressBar: TQProgressBar read FProgressBar write SetProgressBar;
        Property Motif: TQMotif read FMotif write SetMotif;
        Property RadioButton: TQRadioButton read FRadioButton write SetRadioButton;
        Property Cadenas: TQCadenas read FCadenas write SetCadenas;
        Property Button : TQGridButtonCollection read FButton write SetButton;
//        Event
        Property OnClickCheckBox : TNotifyCheckEvent read FOnClickCheckBox write FOnClickCheckBox;
        Property OnClickRadioButton : TNotifyRadioEvent read FOnClickRadioButton write FOnClickRadioButton;
        Property OnClickCadenas : TNotifyCadenasEvent read FonClickCadenas write FonClickCadenas;
        Property OnClickMotif : TNotifyMotifEvent read FOnClickMotif write FOnClickMotif;
    end;  

  TQGridBitmapItem = class(TCollectionItem)
    private
        FFichierTrue:String;
        FFichierFalse:String;
        FChecked:Boolean;
        FAutoSize:Boolean;
        FPictureTrue:TPicture;
        FPictureFalse:TPicture;
        FTransparent:Boolean;
        FSourcePixel:TSourcePixel;
        FOnClickBitmapItem:TNotifyBitmapItemEvent;
        Procedure SetFichierTrue(const Value : String);
        Procedure SetFichierFalse(const Value : String);
        Procedure SetChecked(const Value : Boolean);
        Procedure SetAutosize(const Value : Boolean);
        Procedure SetPictureTrue(Value : TPicture);overload;
        Procedure SetPictureFalse(Value : TPicture);overload;
        Procedure SetTransparent(const Value : Boolean);
        Procedure SetSourcePixel(const Value : TSourcePixel);
        Procedure ClickBitmapItem(Sender:TObject; ACol,ARow,AItem:Integer);
    protected
        function GetDisplayName:String;override;
    public
        Constructor Create(Collection:TCollection);override;
        destructor Destroy; override;
        Procedure Assign(Source: TPersistent);override;
    published
        Property FichierTrue:String read FFichierTrue write SetFichierTrue;
        Property FichierFalse:String read FFichierFalse write SetFichierFalse;
        Property Checked:Boolean read FChecked write SetChecked default True;
        Property AutoSize:Boolean read FAutoSize write SetAutoSize default True;
        Property PictureTrue:TPicture read FPictureTrue write SetPictureTrue;
        Property PictureFalse:TPicture read FPictureFalse write SetPictureFalse;
        Property Transparent:Boolean read FTransparent write SetTransparent default False;
        Property PixelSource:TSourcePixel read FSourcePixel write SetSourcePixel default spBottomLeft;
//        Event
        Property OnClickBitmapItem:TNotifyBitmapItemEvent read FOnClickBitmapItem write FOnClickBitmapItem;
  end;

  TQGridBitmapCollection = class(TCollection)
    private
        FQGrid:TQGrid;
        function GetItem(Index:integer):TQGridBitmapItem;
        Procedure SetItem(Index:integer;Value:TQGridBitmapItem);
    Protected
        function GetOwner: TPersistent; override;
        Procedure Update(Item:TCollectionItem);override;
        Procedure WriteBitmapItem(ABitmapItem:Integer;AAutosize:Boolean=False;AChecked:Boolean=False);
    Public
        Procedure WriteBitmapItems(ACol,ARow:Longint;ABitmapItem:Integer;AEnabled:Boolean=False;AAutosize:Boolean=False;AChecked:Boolean=False);
        function ReadBitmapItems(ACol,ARow:Longint):Integer;
        Constructor Create(CGrid:TQGrid);
        destructor Destroy; override;
        function Add:TQGridBitmapItem;
        Property Items[Index:Integer]:TQGridBitmapItem read GetItem write SetItem;default;
  end;

  TQCheckBox = Class(TPersistent)
    Private
        FChecked:Boolean;
        FCol:Longint;
        FRow:Longint;
        FGrayed:Boolean;
        FCheckGrayed:TGrayed;
        FEnabled:Boolean;
        FColorGrayed1:TColor;
        FColorGrayed2:TColor;
        FColorStickGrayed:TColor;
        FColorStick:TColor;
        FColorFontCheck:TColor;
        FColorTourCheck:TColor;
        FCheck3D:Boolean;
        FStyle:TStyle;
        Procedure SetChecked(Const Value : Boolean);
        Procedure SetCol(Const Value : Longint);
        Procedure SetRow(Const Value : Longint);
        Procedure SetGrayed(Const Value : Boolean);
        Procedure SetEnabled(Const Value : Boolean);
        Procedure SetCheckGrayed(Const Value : TGrayed);
        Procedure SetColorGrayed1(Const Value:TColor);
        Procedure SetColorGrayed2(Const Value:TColor);
        Procedure SetColorStickGrayed(Const Value:TColor);
        Procedure SetColorStick(Const Value: TColor);
        Procedure SetColorFontCheck(Const Value: TColor);
        Procedure SetColorTourCheck(Const Value: TColor);
        Procedure SetCheck3D(Const Value: Boolean);
        Procedure SetStyle(Const Value: TStyle);
    Protected
    Public
        constructor Create(AOwner: TComponent);
        destructor  Destroy; override;
    Published
        Property Checked : Boolean read FChecked write SetChecked default False;
        Property Col : Longint read FCol write SetCol default 1;
        Property Row : Longint read FRow write SetRow default 1;
        Property Grayed : Boolean read FGrayed write SetGrayed default False;
        Property Enabled : Boolean read FEnabled write SetEnabled default False;
        Property CheckGrayed : TGrayed read FCheckGrayed write SetCheckGrayed default GFalse;
        Property ColorGrayed1:TColor read FColorGrayed1 write SetColorGrayed1 default clPurple;
        Property ColorGrayed2:TColor read FColorGrayed2 write SetColorGrayed2 default clWhite;
        Property ColorStickGrayed:TColor read FColorStickGrayed write SetColorStickGrayed default clRed;
        Property ColorStick:TColor read FColorStick write SetColorStick default $0002BF28;
        Property ColorFontCheck:TColor read FColorFontCheck write SetColorFontCheck default clWhite;
        Property ColorTourCheck:TColor read FColorTourCheck write SetColorTourCheck default clBlack;
        Property Check3D:Boolean read FCheck3D write SetCheck3D default False;
        Property CheckStyle:TStyle read FStyle write SetStyle default sPlein;
    end;

  TQProgressBar = Class(TPersistent)
    Private
        FCol:Longint;
        FRow:Longint;
        FMin:Integer;
        FMax:Integer;
        FPosition:Integer;
        FColorFirst:TColor;
        FColorEnd:TColor;
        FStyleGradient:TStyleGradient;
        FBall:Boolean;
        FDiamBall:Integer;
        FStyleText:TStyleText;
        Procedure SetCol(const value : Longint);
        Procedure SetRow(const value : Longint);
        Procedure SetMin(const value : Integer);
        Procedure SetMax(const value : Integer);
        Procedure SetPosition(const value : Integer);
        Procedure SetColorFirst(const value : TColor);
        Procedure SetColorEnd(const value : TColor);
        Procedure SetStyleGradient(const value : TStyleGradient);
        Procedure SetBall(const value : Boolean);
        Procedure SetDiamBall(const value : Integer);
        Procedure SetStyleText(const value : TStyleText);
    Protected
    Public
        constructor Create(AOwner: TComponent);
        destructor  Destroy; override;
    Published
        Property Col: Longint read FCol write SetCol default 1;
        Property Row: Longint read FRow write SetRow default 1;
        Property Min: Integer read FMin write SetMin default 0;
        Property Max: Integer read FMax write SetMax default 100;
        Property Position : Integer read FPosition write SetPosition default 0;
        Property ColorFirst : TColor read FColorFirst write SetColorFirst default clYellow;
        Property ColorEnd : TColor read FColorEnd write SetColorEnd default clRed;
        Property StyleGradient : TStyleGradient read FStyleGradient write  SetStyleGradient default sgHorizontal;
        Property Ball : Boolean read FBall write SetBall default False;
        Property DiamBall : Integer read FDiamBall write SetDiamBall default 0;
        Property StyleText : TStyleText read FStyleText write SetStyleText default sttNone;
    end;

  TQMotif = Class(TPersistent)
    Private
        FCol:Longint;
        FRow:Longint;
        FTypes:TTypeMotif;
        FEnabled:Boolean;
        FPlein:Integer;
        FNombre:Integer;
        FColor:TColor;
        Procedure SetCol(Const Value : Longint);
        Procedure SetRow(Const Value : Longint);
        Procedure SetTypes(Const Value : TTypeMotif);
        Procedure SetEnabled(Const Value : Boolean);
        Procedure SetPlein(Const Value : Integer);
        Procedure SetNombre(Const Value : Integer);
        Procedure SetColor(Const Value : TColor);
    Protected
    Public
        constructor Create(AOwner: TComponent);
        destructor  Destroy; override;
    Published
        Property Col : Longint read FCol write SetCol default 1;
        Property Row : Longint read FRow write SetRow default 1;
        Property Types : TTypeMotif read FTypes write SetTypes default tmEtoile;
        Property Enabled : Boolean read FEnabled write SetEnabled default False;
        Property Plein : Integer read FPlein write SetPlein default 1;
        Property Nombre : Integer read FNombre write SetNombre default 1;
        Property Color : TColor read FColor write SetColor default $000080FF;
    end;

  TQRadioButton = Class(TPersistent)
    Private
        FCol:Longint;
        FRow:Longint;
        FChecked:Boolean;
        FEnabled:Boolean;
        Procedure SetCol(Const Value : Longint);
        Procedure SetRow(Const Value : Longint);
        Procedure SetChecked(Const Value : Boolean);
        Procedure SetEnabled(Const Value : Boolean);
    Protected
    Public
        constructor Create(AOwner: TComponent);
        destructor  Destroy; override;
    Published
        Property Col : Longint read FCol write SetCol default 1;
        Property Row : Longint read FRow write SetRow default 1;
        Property Checked : Boolean read FChecked write SetChecked default False;
        Property Enabled : Boolean read FEnabled write SetEnabled default False;
    end;

  TQCadenas = Class(TPersistent)
    Private
        FCol:Longint;
        FRow:Longint;
        FChecked:Boolean;
        FEnabled:Boolean;
        Procedure SetCol(Const Value : Longint);
        Procedure SetRow(Const Value : Longint);
        Procedure SetChecked(Const Value : Boolean);
        Procedure SetEnabled(Const Value : Boolean);
    Protected
    Public
        constructor Create(AOwner: TComponent);
        destructor  Destroy; override;
    Published
        Property Col : Longint read FCol write SetCol default 1;
        Property Row : Longint read FRow write SetRow default 1;
        Property Checked : Boolean read FChecked write SetChecked default False;
        Property Enabled : Boolean read FEnabled write SetEnabled default False;
    end;

  TQGridButtonItem = class(TCollectionItem)
    private
        FCol:Longint;
        FRow:Longint;
        FText:String;
        FEnabled:Boolean;
        FColorFirst:TColor;
        FColorEnd:TColor;
        FColorText:TColor;
        FOnClickButtonItem:TNotifyButtonItemEvent;
        Procedure SetCol(Const Value : Longint);
        Procedure SetRow(Const Value : Longint);
        Procedure SetText(Const Value : String);
        Procedure SetEnabled(Const Value : Boolean);
        Procedure SetColorFirst(Const Value : TColor);
        Procedure SetColorEnd(Const Value : TColor);
        Procedure SetColorText(Const Value : TColor);
        Procedure ClickButtonItem(Sender:TObject);
        function GetGrilleButtonCollection:TQGridButtonCollection;
        procedure SetGrilleButtonCollection(const Value: TQGridButtonCollection); reintroduce;
    protected
        FQGrid:TQGrid;
        function GetDisplayName:String;override;
        function GetQGrid: TQGrid;
    public
        Constructor Create(Collection:TCollection);override;
        destructor Destroy; override;
        Procedure Assign(Source: TPersistent);override;
        property Collection : TQGridButtonCollection read GetGrilleButtonCollection write SetGrilleButtonCollection;
    published
        Property Col : Longint read FCol write SetCol default 1;
        Property Row : Longint read FRow write SetRow default 1;
        Property Text : String read FText write SetText;
        Property Enabled : Boolean read FEnabled write SetEnabled default False;
        Property ColorFirst : TColor read FColorFirst write SetColorFirst default clWhite;
        Property ColorEnd : TColor read FColorEnd write SetColorEnd default $00ED7B5A;
        Property ColorText : TColor read FColorText write SetColorText default clBlack;
        property QGrid: TQGrid read GetQGrid;
//        Event
        Property OnClickButtonItem:TNotifyButtonItemEvent read FOnClickButtonItem write FonClickButtonItem;
  end;

  TQGridButtonCollection = class(TCollection)
    private
        FQGrid:TQGrid;
        function GetItem(Index:integer):TQGridButtonItem;
        Procedure SetItem(Index:integer;Value:TQGridButtonItem);
    Protected
        function GetOwner: TPersistent; override;
        Procedure Update(Item:TCollectionItem);override;
    Public
        Procedure WriteButton(ACol,ARow:Integer;AButtonItem:Integer);
        function ReadButton(ACol,ARow:Integer):Integer;
        Constructor Create(QGrid:TQGrid);virtual;
        destructor Destroy; override;
        function Add:TQGridButtonItem;
        Property Items[Index:Integer]:TQGridButtonItem read GetItem write SetItem;default;
        property QGrid: TQGrid read FQGrid;
  end;

Const
    ValCheck    :   array[0..9] of string = ('TRUE','FALSE','VTRUE','VFALSE','GTRUE','GFALSE','GGRAYED','VGTRUE','VGFALSE','VGGRAYED');
    ValMotif    :   array[0..4] of string = ('COEUR','CARRE','ROND','ETOILE','CADENAS');
    ValRadio    :   array[0..3] of string = ('RTRUE','RFALSE','VRTRUE','VRFALSE');
    ValCad      :   array[0..3] of string = ('TCADTRUE','TCADFALSE','VTCADTRUE','VTCADFALSE');

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Exemples', [TQGrid]);
end;

function TextReplace(const AText, AFromText, AToText: string): string;
begin
    Result := StringReplace(AText, AFromText, AToText, [rfReplaceAll]);
end;
         
function AnsiIndexStr(Val : string;const Value:array of string):integer;
begin
    Result := 0;
    while Result<=High(Value) do
    begin
        if Value[Result]=Val then
            exit
        else
            inc(Result);
    end;
    Result := -1;
end;

//****************************************************************************//
////////////////////////////////////////////////////////////////////////////////
//                              TQGridBitmapItem                            //
////////////////////////////////////////////////////////////////////////////////
//****************************************************************************//

constructor TQGridBitmapItem.Create(Collection:TCollection);
begin
    inherited create(Collection);
    FFichierTrue:='';
    FFichierFalse:='';
    FChecked:=True;
    FAutoSize:=True;
    FTransparent:=False;
    FSourcePixel:=spBottomLeft;
    FPictureTrue:=TPicture.Create;
    FPictureFalse:=TPicture.Create;
end;

destructor TQGridBitmapItem.Destroy;
begin
    inherited Destroy;
end;

Procedure TQGridBitmapItem.ClickBitmapItem(Sender:TObject; ACol,ARow,AItem:Integer);
begin
    if Assigned(FOnClickBitmapItem) then
        FOnClickBitmapItem(Sender,ACol,ARow,AItem);

end;

Procedure TQGridBitmapItem.SetFichierTrue(const Value: string);
begin
    if FFichierTrue<>Value then
    begin
        if FileExists(Value) then
            PictureTrue.LoadFromFile(Value)
        else
            exit;
        FFichierTrue:=Value;
    end;
end;

Procedure TQGridBitmapItem.SetFichierFalse(const Value: string);
begin
    if FFichierFalse<>Value then
    begin
        if FileExists(Value) then
            PictureFalse.LoadFromFile(Value)
        else
            exit;
        FFichierFalse:=Value;
    end;
end;

Procedure TQGridBitmapItem.SetChecked(const Value: Boolean);
begin
    if FChecked<>Value then
        FChecked:=Value;
end;

Procedure TQGridBitmapItem.SetAutoSize(const Value: Boolean);
begin
    if FAutoSize<>Value then
        FAutoSize:=Value;
end;

Procedure TQGridBitmapItem.SetPictureTrue(Value: TPicture);
begin
    if FPictureTrue <> nil then
        FreeAndNil(FPictureTrue);
    FPictureTrue:= TPicture.Create;
    FPictureTrue.Assign(Value);
    Changed(False);
end;

Procedure TQGridBitmapItem.SetPictureFalse(Value: TPicture);
begin
    if FPictureFalse <> nil then
        FreeAndNil(FPictureFalse);
    FPictureFalse:= TPicture.Create;
    FPictureFalse.Assign(Value);
    Changed(False);
end;

Procedure TQGridBitmapItem.SetTransparent(Const Value: Boolean);
begin
    if FTransparent <> Value then
        FTransparent:=Value;
end;

Procedure TQGridBitmapItem.SetSourcePixel(Const Value: TSourcePixel);
begin
    if FSourcePixel <> Value then
        FSourcePixel:=Value;
end;

function TQGridBitmapItem.GetDisplayName:String;
begin
    Result:=inherited GetDisplayName;
end;

Procedure TQGridBitmapItem.Assign(Source: TPersistent);
begin
    if Source is TQGridBitmapItem then
    begin
        FichierTrue:=TQGridBitmapItem(Source).FichierTrue;
        FichierFalse:=TQGridBitmapItem(Source).FichierFalse;
        Checked:=TQGridBitmapItem(Source).Checked;
        AutoSize:=TQGridBitmapItem(Source).AutoSize;
        PictureTrue:=TQGridBitmapItem(Source).PictureTrue;
        PictureFalse:=TQGridBitmapItem(Source).PictureFalse;
        Exit;
    end;
    inherited Assign(Source);
end;

//****************************************************************************//
////////////////////////////////////////////////////////////////////////////////
//                     TQGridBitmapCollection                                 //
////////////////////////////////////////////////////////////////////////////////
//****************************************************************************//

function TQGridBitmapCollection.GetItem(index: Integer):TQGridBitmapItem;
begin
    Result:=TQGridBitmapItem(inherited GetItem(index));
end;

procedure TQGridBitmapCollection.SetItem(index:Integer;Value:TQGridBitmapItem);
begin
    inherited SetItem(Index,Value);
end;

function TQGridBitmapCollection.GetOwner;
begin
    Result:=FQGrid;
end;

constructor TQGridBitmapCollection.create(CGrid:TQGrid);
begin
    inherited create(TQGridBitmapItem);
    FQGrid:=CGrid;
end;

destructor TQGridBitmapCollection.Destroy;
begin
    inherited Destroy;
end;

function TQGridBitmapCollection.Add:TQGridBitmapItem;
begin
    Result:=TQGridBitmapItem(inherited Add);
end;

Procedure TQGridBitmapCollection.Update(Item :TCollectionItem);
begin
;
end;

Procedure TQGridBitmapCollection.WriteBitmapItem(ABitmapItem:Integer;AAutosize:Boolean=False;AChecked:Boolean=False);
begin
    with FQGrid.Items[ABitmapItem]do
    begin
        Checked:=AChecked;
        AutoSize:=AAutosize;
    end;
end;

Procedure TQGridBitmapCollection.WriteBitmapItems(ACol,ARow:Longint;ABitmapItem:Integer;AEnabled:Boolean=False;AAutosize:Boolean=False;AChecked:Boolean=False);
begin
    WriteBitmapItem(ABitmapItem,AAutoSize,AChecked);
    if AEnabled then
        FQGrid.Cells[ACol,ARow]:='VTITEMS,'+IntToStr(ABitmapItem)+','+BoolToStr(AAutoSize,True)+','+BoolToStr(AChecked,True)
    else
        FQGrid.Cells[ACol,ARow]:='TITEMS,'+IntToStr(ABitmapItem)+','+BoolToStr(AAutoSize,True)+','+BoolToStr(AChecked,True);
end;

function TQGridBitmapCollection.ReadBitmapItems(ACol,ARow:Longint):Integer;
var
   Chaine   : TStringList;
   Temp     : String;
begin
    Result:=-1;
    with FQGrid do
    begin
        Temp:=UpperCase(Cells[Acol,ARow]);
        if Temp='' then
            Exit;
        Chaine:=TStringList.Create;
        try
            ExtraireChaine(Temp,Chaine,',');
            VerifChaineItems(Chaine);
            Result:=StrToInt(Chaine[1]);
            if (UpperCase(Chaine[0])='TITEMS')or(UpperCase(Chaine[0])='VTITEMS')then
                WriteBitmapItem(StrToInt(Chaine[1]),StrToBool(Chaine[2]),StrToBool(Chaine[3]));
        finally
            Chaine.Free;
        end;
    end;
end;

Procedure TQGrid.SetItems(Value: TQGridBitmapCollection);
begin
    FItems.Assign(Value);
end;

//****************************************************************************//
////////////////////////////////////////////////////////////////////////////////
//                              TQCheckBox                                    //
////////////////////////////////////////////////////////////////////////////////
//****************************************************************************//

Constructor TQCheckBox.Create(AOwner : TComponent);
begin
;
end;

destructor TQCheckBox.Destroy;
begin
    inherited destroy;
end;

Procedure TQCheckBox.SetChecked(Const Value : Boolean);
begin
    if FChecked<>Value then
        FChecked:=Value;
end;

Procedure TQCheckBox.SetCol(Const Value : Longint);
begin
    if FCol<>Value then
        FCol:=Value;
end;

Procedure TQCheckBox.SetRow(Const Value : Longint);
begin
    if FRow<>Value then
        FRow:=Value;
end;

Procedure TQCheckBox.SetGrayed(Const Value : Boolean);
begin
    if FGrayed<>Value then
        FGrayed:=Value;
end;

Procedure TQCheckBox.SetEnabled(Const Value : Boolean);
begin
    if FEnabled<>Value then
        FEnabled:=Value;
end;

Procedure TQCheckBox.SetCheckGrayed(Const Value : TGrayed);
begin
    if FCheckGrayed<>Value then
         FCheckGrayed:=Value;
end;

Procedure TQCheckBox.SetColorStick(const Value: TColor);
begin
    if FColorStick<>Value then
        FColorStick:=Value;
end;

Procedure TQCheckBox.SetColorFontCheck(const Value: TColor);
begin
    if FColorFontCheck<>Value then
        FColorFontCheck:=Value;

end;

Procedure TQCheckBox.SetColorTourCheck(const Value: TColor);
begin
    if FColorTourCheck<>Value then
        FColorTourCheck:=Value;
end;

Procedure TQCheckBox.SetColorGrayed1(const Value: TColor);
begin
    if FColorGrayed1<>Value then
        FColorGrayed1:=Value;
end;

Procedure TQCheckBox.SetColorGrayed2(const Value: TColor);
begin
    if FColorGrayed2<>Value then
        FColorGrayed2:=Value;
end;

Procedure TQCheckBox.SetColorStickGrayed(const Value: TColor);
begin
    if FColorStickGrayed<>Value then
        FColorStickGrayed:=Value;
end;

Procedure TQCheckBox.SetCheck3D(const Value: Boolean);
begin
    if FCheck3D<>Value then
        FCheck3D:=Value;
end;

Procedure TQCheckBox.SetStyle(const Value: TStyle);
begin
    if FStyle<>Value then
        FStyle:=Value;
end;

Procedure TQGrid.WriteCheckBox(VCheckCol,VCheckRow:Longint;VChecked:Boolean;VGrayed:Boolean=False;VEnabled:Boolean=False;VCheckGrayed:TGrayed=GFalse);
begin
    with FCheckBox do
    begin
        Col:=VCheckCol;
        Row:=VCheckRow;
        Checked:=VChecked;
        Grayed:=VGrayed;
        Enabled:=VEnabled;
        CheckGrayed:=VCheckGrayed;
    end;
end;

function TQGrid.WriteCheckGrid(VCol,VRow:Longint; VChecked:Boolean; VGrayed:Boolean=False; VEnabled:Boolean=False; VCheckGrayed:TGrayed=GFalse):Boolean;
begin
    with FCheckBox do
    begin
        WriteCheckBox(VCol,VRow,VChecked,VGrayed,VEnabled,VCheckGrayed);
        if not Enabled then
        begin
            if not Grayed then
                    Self.Cells[Col,Row]:=BoolToStr(Checked,True)
            else
                case CheckGrayed of
                    GTrue   : Self.Cells[Col,Row]:='GTRUE';
                    GFalse  : Self.Cells[Col,Row]:='GFALSE';
                    GGrayed : Self.Cells[Col,Row]:='GGRAYED';
                end;
        end
        else
        begin
            if not Grayed then
                Self.Cells[Col,Row]:='V'+BoolToStr(Checked,True)
            else
                case CheckGrayed of
                    GTrue   : Self.Cells[Col,Row]:='VGTRUE';
                    GFalse  : Self.Cells[Col,Row]:='VGFALSE';
                    GGrayed : Self.Cells[Col,Row]:='VGGRAYED';
                end;
        end;
    end;
end;    

function TQGrid.ReadCheckGrid(VCol,VRow: Longint):String;
begin
    with FCheckBox do
    begin
        Result:=UpperCase(Cells[VCol,VRow]);
        if Result='' then
            exit;
        case AnsiIndexStr(Result,ValCheck) of
            0 : WriteCheckBox(VCol,VRow,True,False,False,GFalse);
            1 : WriteCheckBox(VCol,VRow,False,False,False,GFalse);
            2 : WriteCheckBox(VCol,VRow,True,False,True,GFalse);
            3 : WriteCheckBox(VCol,VRow,False,False,True,GFalse);
            4 : WriteCheckBox(VCol,VRow,True,True,False,GTrue);
            5 : WriteCheckBox(VCol,VRow,True,True,False,GFalse);
            6 : WriteCheckBox(VCol,VRow,True,True,False,GGrayed);
            7 : WriteCheckBox(VCol,VRow,True,True,True,GTrue);
            8 : WriteCheckBox(VCol,VRow,True,True,True,GFalse);
            9 : WriteCheckBox(VCol,VRow,True,True,True,GGrayed);
        end;
    end;
end;

Procedure TQGrid.SetCheckBox(Value : TQCheckBox);
begin
    if FCheckBox<>Value then
        FCheckBox:=Value;
end;

//****************************************************************************//
////////////////////////////////////////////////////////////////////////////////
//                              TQProgresBar                                  //
////////////////////////////////////////////////////////////////////////////////
//****************************************************************************//

Constructor TQProgressBar.Create(AOwner: TComponent);
begin
;
end;

destructor TQProgressBar.Destroy;
begin
    Inherited Destroy;
end;

Procedure TQProgressBar.SetCol(Const Value : Longint);
begin
    if FCol<>Value then
        FCol:=Value;
end;

Procedure TQProgressBar.SetRow(Const Value : Longint);
begin
    if FRow<>Value then
        FRow:=Value;
end;

Procedure TQProgressBar.SetMin(Const Value : Integer);
begin
    if FMin<>Value then
    begin
        if Value>Position then
            Position:=Value;
        if Value>Max then
            Max:=Value+1;
         FMin:=Value;
    end;
end;

Procedure TQProgressBar.SetMax(Const Value : Integer);
begin
    if FMax<>Value then
    begin
        if Value<Position then
            Position:=Value;
        if Value<Min then
            Min:=Value-1;
        FMax:=Value;
    end;
end;

Procedure TQProgressBar.SetPosition(Const Value : Integer);
begin
    if FPosition<>Value then
    begin
        if Value>Max then
        begin
            FPosition:=Max;
            exit;
        end;
        if Value<Min then
        begin
            FPosition:=Min;
            exit;
        end;
        FPosition:=Value;
    end;
end;

Procedure TQProgressBar.SetColorFirst(Const Value : TColor);
begin
    if FColorFirst<>Value then
        FColorFirst:=Value;
end;

Procedure TQProgressBar.SetColorEnd(Const Value : TColor);
begin
    if FColorEnd<>Value then
        FColorEnd:=Value;
end;

Procedure TQProgressBar.SetStyleGradient(const Value : TStyleGradient);
begin
    if FStyleGradient<>Value then
        FStyleGradient:=Value;
end;

Procedure TQProgressBar.SetBall(const Value : Boolean);
begin
    if FBall<>Value then
    begin
        FBall:=Value;
        if Value then
            FStyleGradient:=sgRond;
    end;
end;

Procedure TQProgressBar.SetDiamBall(const Value : Integer);
begin
    if FDiamBall<>Value then
    begin
        if Value<0 then
            FDiamBall:=0
        else
            FDiamBall:=Value;
    end;
end;

Procedure TQProgressBar.SetStyleText(const value : TStyleText);
begin
    if Value<>FStyleText then
        FStyleText:=Value;
end;

Procedure TQGrid.WriteProgressBar(VProgCol,VProgRow:Longint; VPosition:Integer; VMin:Integer=0; VMax:Integer=100; VColorFirst:TColor=clYellow;VColorEnd:TColor=clred);
begin
    with FProgressBar do
    begin
        Col:=VProgCol;
        Row:=VProgRow;
        Min:=VMin;
        Max:=VMax;
        Position:=VPosition;
        ColorFirst:=VColorFirst;
        ColorEnd:=VColorEnd;
    end;
end;

function TQGrid.WriteProgressGrid(VCol,VRow:Longint; VPosition:Integer; VMin:Integer=0; VMax:Integer=100; VColorFirst:TColor=clYellow;VColorEnd:TColor=clred):Boolean;
begin
    with ProgressBar do
    begin
        WriteProgressBar(VCol,VRow,VPosition,VMin,VMax,VColorFirst,VColorEnd);
        Self.Cells[VCol,VRow]:='TPROGBAR,'+IntToStr(Position)+','+IntToStr(Min)+','+IntToStr(Max)+','+ColorToString(ColorFirst)+','+ColorToString(ColorEnd);
    end;
end;

function TQGrid.ReadProgressGrid(VCol,VRow:Longint):String;
var
    Chaine  : TStringList;
    Value   : Integer;
begin
    Chaine:=TStringList.Create;
    try
        Result:=Self.Cells[VCol,VRow];
        if Result='' then
            exit;
        ExtraireChaine(Self.Cells[VCol,VRow],Chaine,',');
        VerifChaineProg(Chaine,VCol,VRow);
        if not IdentToColor(Chaine[4],Value) then
            Chaine[4]:=ColorToString(clYellow);
        if not IdentToColor(Chaine[5],Value) then
            Chaine[5]:=ColorToString(clRed);
        WriteProgressBar(VCol,VRow,StrToIntDef(Chaine[1],0),StrToIntDef(Chaine[2],0),
            StrToIntDef(Chaine[3],100),StringToColor(Chaine[4]),StringToColor(Chaine[5]));
    finally
        Chaine.Free;
    end;
end;

Procedure TQGrid.SetProgressBar(Value : TQProgressBar);
begin
    if FProgressBar<>Value then
        FProgressBar:=Value;
end;

//****************************************************************************//
////////////////////////////////////////////////////////////////////////////////
//                               TQMotif                                      //
////////////////////////////////////////////////////////////////////////////////
//****************************************************************************//

Constructor TQMotif.Create(AOwner : TComponent);
begin
;
end;

destructor TQMotif.Destroy;
begin
    Inherited Destroy;
end;

Procedure TQMotif.SetCol(Const Value : Longint);
begin
    if FCol<>Value then
        FCol:=Value;
end;

Procedure TQMotif.SetRow(Const Value : Longint);
begin
    if FRow<>Value then
        FRow:=Value;
end;

Procedure TQMotif.SetTypes(Const Value : TTypeMotif);
begin
    if FTypes<>Value then
        FTypes:=Value;
end;

Procedure TQMotif.SetEnabled(Const Value : Boolean);
begin
    if FEnabled<>Value then
        FEnabled:=Value;
end;

Procedure TQMotif.SetPlein(Const Value : Integer);
begin
    if FPlein<>Value then
        FPlein:=Value;
end;

Procedure TQMotif.SetNombre(Const Value : Integer);
begin
    if FNombre<>Value then
        FNombre:=Value;
end;

Procedure TQMotif.SetColor(Const Value : TColor);
begin
    if FColor<>Value then
        FColor:=Value;
end;

Procedure TQGrid.WriteMotif(VMotCol,VMotRow:Longint; VEnabled:Boolean; VTypes:TTypeMotif; VNomb:Integer=1; VPlein:Integer=1; VColor:TColor=$000080FF);
begin
    with FMotif do
    begin
        Col:=VMotCol;
        Row:=VMotRow;
        Types:=VTypes;
        Nombre:=VNomb;
        Plein:=VPlein;
        Color:=VColor;
        Enabled:=VEnabled;
    end;
end;

function TQGrid.WriteMotifGrid(VCol,VRow:Longint; VEnabled:Boolean=False; VMotif:TTypeMotif=tmEtoile; VNomb:Integer=1; VPlein:Integer=1; VColor:TColor=$000080FF):Boolean;
var
    Temp    : String;
begin
    Temp:='';
    with FMotif do
    begin
        WriteMotif(VCol,VRow,VEnabled,VMotif,VNomb,VPlein,VColor);
        case VMotif of
            tmCoeur   : Temp:='COEUR';
            tmCarre   : Temp:='CARRE';
            tmRond    : Temp:='ROND';
            tmEtoile  : Temp:='ETOILE';
            tmCadenas : Temp:='CADENAS';
        end;
        if not VEnabled then
            Self.Cells[VCol,VRow]:='TMOTIF,'+Temp+','+IntToStr(VNomb)+','+IntToStr(VPlein)+','+ColorToString(VColor)
        else
            Self.Cells[VCol,VRow]:='VTMOTIF,'+Temp+','+IntToStr(VNomb)+','+IntToStr(VPlein)+','+ColorToString(VColor);
    end;
end;

function TQGrid.ReadMotifGrid(VCol,VRow:Longint):String;
var
   Chaine   : TStringList;
begin
    with FMotif do
    begin
        Result:=UpperCase(Cells[VCol,VRow]);
        if Result='' then
            exit;
        Chaine:=TStringList.Create;
        try
            ExtraireChaine(Result,Chaine,',');
            VerifChaineMotif(Chaine);
            with Motif do
            begin
                if (UpperCase(Chaine[0])='VTMOTIF')then
                    Enabled:=True
                else
                    Enabled:=False;
                if (UpperCase(Chaine[0])='TMOTIF')or(UpperCase(Chaine[0])='VTMOTIF')then
                begin
                    case AnsiIndexStr(UpperCase(Chaine[1]),ValMotif) of
                        0   :   WriteMotif(VCol,VRow,Enabled,tmCoeur,StrToIntDef(Chaine[2],1),StrToIntDef(Chaine[3],1),StringToColor(Chaine[4]));
                        1   :   WriteMotif(VCol,VRow,Enabled,tmCarre,StrToIntDef(Chaine[2],1),StrToIntDef(Chaine[3],1),StringToColor(Chaine[4]));
                        2   :   WriteMotif(VCol,VRow,Enabled,tmRond,StrToIntDef(Chaine[2],1),StrToIntDef(Chaine[3],1),StringToColor(Chaine[4]));
                        3   :   WriteMotif(VCol,VRow,Enabled,tmEtoile,StrToIntDef(Chaine[2],1),StrToIntDef(Chaine[3],1),StringToColor(Chaine[4]));
                        4   :   WriteMotif(VCol,VRow,Enabled,tmCadenas,StrToIntDef(Chaine[2],1),StrToIntDef(Chaine[3],1),StringToColor(Chaine[4]));
                    end;
                end;
            end;
        finally
            Chaine.Free;
        end;
    end;
end;

Procedure TQGrid.SetMotif(Value : TQMotif);
begin
    if FMotif<>Value then
        FMotif:=Value;
end;

//****************************************************************************//
////////////////////////////////////////////////////////////////////////////////
//                              TQRadioButton                                 //
////////////////////////////////////////////////////////////////////////////////
//****************************************************************************//

Constructor TQRadioButton.Create(AOwner : TComponent);
begin
;
end;

destructor TQRadioButton.Destroy;
begin
    Inherited Destroy;
end;

Procedure TQRadioButton.SetCol(Const Value : Longint);
begin
    if FCol<>Value then
        FCol:=Value;
end;

Procedure TQRadioButton.SetRow(Const Value : Longint);
begin
    if FRow<>Value then
        FRow:=Value;
end;

Procedure TQRadioButton.SetChecked(Const Value : Boolean);
begin
    if FChecked<>Value then
        FChecked:=Value;
end;

Procedure TQRadioButton.SetEnabled(Const Value : Boolean);
begin
    if FEnabled<>Value then
        FEnabled:=Value;
end;

Procedure TQGrid.WriteRadio(VRadioCol,VRadioRow:Longint; VChecked:Boolean; VEnabled:Boolean=False);
begin
    with FRadioButton do
    begin
        Col:=VRadioCol;
        Row:=VRadioRow;
        Checked:=VChecked;
        Enabled:=VEnabled;
    end;
end;

function TQGrid.WriteRadioGrid(VCol,VRow:Longint; VChecked:Boolean=False; VEnabled:Boolean=False):Boolean;
begin
    with FRadioButton do
    begin
        WriteRadio(VCol,VRow,VChecked,VEnabled);
        if not Enabled then
        begin
            if Checked then
                Self.Cells[Col,Row]:='RTRUE'
            else
                Self.Cells[Col,Row]:='RFALSE';
        end
        else
        begin
            if Checked then
                Self.Cells[Col,Row]:='VRTRUE'
            else
                Self.Cells[Col,Row]:='VRFALSE';
        end;
    end;
end;

function TQGrid.ReadRadioGrid(VCol,VRow:Longint):String;
begin
    with FRadioButton do
    begin
        Result:=UpperCase(Cells[VCol,VRow]);
        if Result='' then
            exit;
        case AnsiIndexStr(Result,ValRadio) of
            0 : WriteRadio(VCol,VRow,True,False);
            1 : WriteRadio(VCol,VRow,False,False);
            2 : WriteRadio(VCol,VRow,True,True);
            3 : WriteRadio(VCol,VRow,False,True);
        end;
    end;
end;

Procedure TQGrid.SetRadioButton(Value: TQRadioButton);
begin
    if FRadioButton<>Value then
        FRadioButton:=Value;
end;

//****************************************************************************//
////////////////////////////////////////////////////////////////////////////////
//                              TQGridCadenas                                 //
////////////////////////////////////////////////////////////////////////////////
//****************************************************************************//

Constructor TQCadenas.Create(AOwner : TComponent);
begin
;
end;

destructor TQCadenas.Destroy;
begin
    Inherited Destroy;
end;

Procedure TQCadenas.SetCol(Const Value : Longint);
begin
    if FCol<>Value then
        FCol:=Value;
end;

Procedure TQCadenas.SetRow(Const Value : Longint);
begin
    if FRow<>Value then
        FRow:=Value;
end;

Procedure TQCadenas.SetChecked(Const Value : Boolean);
begin
    if FChecked<>Value then
        FChecked:=Value;
end;

Procedure TQCadenas.SetEnabled(Const Value : Boolean);
begin
    if FEnabled<>Value then
        FEnabled:=Value;
end;

Procedure TQGrid.WriteCad(VCadCol,VCadRow:Longint; VChecked:Boolean; VEnabled:Boolean=False);
begin
    with FCadenas do
    begin
        Col:=VCadCol;
        Row:=VCadRow;
        Checked:=VChecked;
        Enabled:=VEnabled;
    end;
end;

function TQGrid.WriteCadGrid(VCol,VRow:Longint; VChecked:Boolean=False; VEnabled:Boolean=False):Boolean;
begin
    with FCadenas do
    begin
        WriteCad(VCol,VRow,VChecked,VEnabled);
        if not Enabled then
        begin
            if Checked then
                Self.Cells[Col,Row]:='TCADTRUE'
            else
                Self.Cells[Col,Row]:='TCADFALSE';
        end
        else
        begin
            if Checked then
                Self.Cells[Col,Row]:='VTCADTRUE'
            else
                Self.Cells[Col,Row]:='VTCADFALSE';
        end;
    end;
end;

procedure TQGrid.InvalidateCell(ACol, ARow: Longint);
begin
    inherited;
end;

function TQGrid.ReadCadGrid(VCol,VRow:Integer):String;
begin
    with FCadenas do
    begin
        Result:=UpperCase(Cells[VCol,VRow]);
        if Result='' then
            exit;
        case AnsiIndexStr(Result,ValCad) of
            0 : WriteCad(VCol,VRow,True,False);
            1 : WriteCad(VCol,VRow,False,False);
            2 : WriteCad(VCol,VRow,True,True);
            3 : WriteCad(VCol,VRow,False,True);
        end;
    end;
end;

Procedure TQGrid.SetCadenas(Value: TQCadenas);
begin
    if FCadenas<>Value then
        FCadenas:=Value;
end;

//****************************************************************************//
////////////////////////////////////////////////////////////////////////////////
//                              TQGridButtonItem                              //
////////////////////////////////////////////////////////////////////////////////
//****************************************************************************//

constructor TQGridButtonItem.Create(Collection:TCollection);
begin
    inherited create(Collection);
    Col:=1;
    Row:=1;
    Text:='';
    Enabled:=False;
    ColorFirst:=clWhite;
    ColorEnd:=$00ED7B5A;
    ColorText:=clBlack;
end;

destructor TQGridButtonItem.Destroy;
begin
    inherited Destroy;
end;

Procedure TQGridButtonItem.Assign(Source: TPersistent);
begin
    if Source is TQGridButtonItem then
    begin
        Col:=TQGridButtonItem(Source).Col;
        Row:=TQGridButtonItem(Source).Row;
        Text:=TQGridButtonItem(Source).Text;
        Enabled:=TQGridButtonItem(Source).Enabled;
        ColorFirst:=TQGridButtonItem(Source).ColorFirst;
        ColorEnd:=TQGridButtonItem(Source).ColorEnd;
        ColorText:=TQGridButtonItem(Source).ColorText;
        Exit;
    end;
    inherited Assign(Source);
end;

Procedure TQGridButtonItem.ClickButtonItem(Sender:TObject);
begin
    if Assigned(FOnClickButtonItem) then
        FOnClickButtonItem(Self,Col,Row);
end;

function TQGridButtonItem.GetGrilleButtonCollection: TQGridButtonCollection;
begin
  Result := TQGridButtonCollection(inherited Collection);
end;

procedure TQGridButtonItem.SetGrilleButtonCollection(const Value: TQGridButtonCollection);
begin
  inherited Collection := Value;
end;

function TQGridButtonItem.GetDisplayName:String;
begin
    Result:=inherited GetDisplayName;
end;

function TQGridButtonItem.GetQGrid:TQGrid;
begin
    Result := Collection.QGrid;
end;

Procedure TQGridButtonItem.SetCol(Const Value : Longint);
begin
    if FCol<>Value then
        FCol:=Value;
end;

Procedure TQGridButtonItem.SetRow(Const Value : Longint);
begin
    if FRow<>Value then
        FRow:=Value;
end;

Procedure TQGridButtonItem.SetText(Const Value : String);
begin
    if FText<>Value then
        FText:=Value;
end;

Procedure TQGridButtonItem.SetEnabled(Const Value : Boolean);
begin
    if FEnabled<>Value then
        FEnabled:=Value;
end;

Procedure TQGridButtonItem.SetColorFirst(Const Value : TColor);
begin
    if FColorFirst<>Value then
        FColorFirst:=Value;
end;

Procedure TQGridButtonItem.SetColorEnd(Const Value : TColor);
begin
    if FColorEnd<>Value then
        FColorEnd:=Value;
end;

Procedure TQGridButtonItem.SetColorText(Const Value : TColor);
begin
    if FColorText<>Value then
        FColorText:=Value;
end;

//****************************************************************************//
////////////////////////////////////////////////////////////////////////////////
//                              TQGridButtonCollection                        //
////////////////////////////////////////////////////////////////////////////////
//****************************************************************************//

function TQGridButtonCollection.GetItem(index: Integer):TQGridButtonItem;
begin
    Result:=TQGridButtonItem(inherited GetItem(index));
end;

procedure TQGridButtonCollection.SetItem(index:Integer;Value:TQGridButtonItem);
begin
    inherited SetItem(Index,Value);
end;

function TQGridButtonCollection.GetOwner;
begin
    Result:=FQGrid;
end;

constructor TQGridButtonCollection.create(QGrid:TQGrid);
begin
    inherited create(TQGridButtonItem);
    FQGrid:=QGrid;
end;

destructor TQGridButtonCollection.Destroy;
begin
    inherited Destroy;
end;

function TQGridButtonCollection.Add:TQGridButtonItem;
begin
    Result:=TQGridButtonItem(inherited Add);
end;

Procedure TQGridButtonCollection.Update(Item :TCollectionItem);
begin
;
end;

Procedure TQGridButtonCollection.WriteButton(ACol,ARow:Longint;AButtonItem:Integer);
begin
    FQGrid.Cells[Acol,ARow]:='TBUTTON'+IntToStr(AButtonItem);
end;

function TQGridButtonCollection.ReadButton(ACol,ARow:Longint):Integer;
begin
     Result:=StrToIntDef(TextReplace(FQGrid.Cells[ACol,ARow],'TBUTTON',''),-1);
end;

//****************************************************************************//
////////////////////////////////////////////////////////////////////////////////
//                              TQGrid                                      //
////////////////////////////////////////////////////////////////////////////////
//****************************************************************************//
           
Procedure TQGrid.SetButton(Value: TQGridButtonCollection);
begin
    FButton.Assign(Value);
end;

Function ConvPlacTextVert(const Value:TPlacTextVert):Cardinal;
begin
    case Value of
        ptvCentre  : Result := DT_CENTER;
        ptvGauche  : Result := DT_LEFT;
        ptvDroite  : Result := DT_RIGHT;
    else
        result := DT_CENTER;
    end;
end;

Function ConvPlacTextHorz(const Value:TPlacTextHorz):Cardinal;
begin
    case Value of
        pthCentre  : Result := DT_VCENTER;
        pthHaut    : Result := DT_TOP;
        pthBas     : Result := DT_BOTTOM;
    else
        Result := DT_VCENTER;
    end;
end;

Function ConvPlacTextLigne(const Value:TPlacTextLigne):Cardinal;
begin
    case Value of
        ptlLigne       : Result := DT_SINGLELINE;
        ptlMultiLigne  : Result := DT_WORDBREAK;
    else
        Result := DT_WORDBREAK;
    end;
end;

Function ConvCheckStyle(const Value:TStyle):Cardinal;
begin
    case Value of
        sTransparent : Result := 1;
        sPlein       : Result := 2;
    else
        Result := 2;
    end;
end;

Procedure TQGrid.SetPlacTextVert(const Value: TPlacTextVert);
begin
    if FPlacTextVert <> Value then
    begin
        FPlacTextVert := Value;
        Invalidate;
    end;
end;

Procedure TQGrid.SetPlacTextHorz(const Value: TPlacTextHorz);
begin
    if FPlacTextHorz <> Value then
    begin
        if FPlacTextLigne = ptlMultiLigne then
            FPlacTextHorz:=pthHaut
        else
            FPlacTextHorz:=Value;
        Invalidate;
    end;
end;

Procedure TQGrid.SetPlacTextLigne(const Value: TPlacTextLigne);
begin
    if FPlacTextLigne <> Value then
    begin
        If Value = ptlMultiLigne then
            CPlacTextHorz:=pthHaut;
        FPlacTextLigne := Value;
        Invalidate;
    end;
end;

Procedure TQGrid.SetColorLigPaire(const Value:TColor);
begin
    if FColorLigPaire <> Value then
    begin
        FColorLigPaire := Value;
        Invalidate;
    end;
end;

Procedure TQGrid.SetColorLigImpaire(const Value:TColor);
begin
    if FColorLigImpaire <> Value then
    begin
        FColorLigImpaire := Value;
        Invalidate;
    end;
end;

Procedure TQGrid.SetLigColorVisible(const Value:Boolean);
begin
    if FLigColorVisible <> Value then
    begin
        FLigColorVisible := Value;
        Invalidate;
    end;
end;

Procedure TQGrid.SetColorSelection(const Value:TColor);
begin
    if FColorSelection <> Value then
    begin
        FColorSelection := Value;
        Invalidate;
    end;
end;

Procedure TQGrid.SetColCheckedVisible(const Value: Boolean);
begin
    if FColCheckedVisible <> Value then
    begin
        FColCheckedVisible := Value;
        if MEditing then
            Options:=Options+[goEditing];
        Invalidate;
    end;
end;

Procedure TQGrid.SetDirectFileXLS(const Value: String);
begin
    if FDirectFileXLS <> Value then
    begin
        FDirectFileXLS := Value;
        Invalidate;
    end;
end;

Procedure TQGrid.SetEnrXls(Const Value: Boolean);
begin
    if FEnrXls <> Value then
    begin
        FEnrXls := Value;
        if (DirectFileXLS<>'') and (Value) then
            SaveAsExcelFile(Self,DirectFileXLS);
        EnrXLS:=False;
    end;
end;

constructor TQGrid.Create(Aowner:TComponent);
begin
    inherited Create(AOwner);
    FixedColor:=$00FF8080;
    ColorLigPaire:=$00F2D1B3;
    ColorLigImpaire:=$00DEEBFA;
    ColorSelection:=$0012F906;
    CPlacTextVert:=ptvCentre;
    CPlacTextHorz:=pthCentre;
    CPlacTextLigne:=ptlLigne;
    ColCheckedVisible:=True;
    MEditing:=True;
    LigColorVisible:=True;
    Options:=Options+[goEditing];
    FVisibleColCount:=ColCount;
    FVisibleRowCount:=RowCount;

    FCheckBox:=TQCheckBox.Create(Self);
    with CheckBox do
    begin
        Col:=1;
        Row:=1;
        Checked:=False;
        Grayed:=False;
        Enabled:=False;
        CheckGrayed:=GFalse;
        ColorStick:=$0002BF28;
        ColorGrayed1:=clPurple;
        ColorGrayed2:=clWhite;
        ColorFontCheck:=ClWhite;
        ColorTourCheck:=ClBlack;
        ColorStickGrayed:=clRed;
        Check3D:=False;
        CheckStyle:=sPlein;
    end;

    FProgressBar:=TQProgressBar.Create(Self);
    with ProgressBar do
    begin
        Col:=1;
        Row:=1;
        ColorFirst:=clYellow;
        ColorEnd:=clRed;
        StyleGradient:=sgHorizontal;
        Min:=0;
        Max:=100;
        Position:=0;
        Ball:=False;
        DiamBall:=0;
        StyleText:=sttNone;
    end;

    FMotif:=TQMotif.Create(Self);
    with Motif do
    begin
        Col:=1;
        Row:=1;
        Types:=tmEtoile;
        Enabled:=False;
        Plein:=1;
        Nombre:=1;
        Color:=$000080FF;
    end;

    FRadioButton:=TQRadioButton.Create(Self);
    with RadioButton do
    begin
        Col:=1;
        Row:=1;
        Checked:=False;
        Enabled:=False;
    end;

    FCadenas:=TQCadenas.Create(Self);
    with Cadenas do
    begin
        Col:=1;
        Row:=1;
        Checked:=False;
        Enabled:=False;
    end;

    FItems:=TQGridBitmapCollection.Create(Self);
    FButton:=TQGridButtonCollection.Create(Self);
end;

destructor TQGrid.Destroy;
begin
    inherited Destroy;
end;

{Procedure TQGrid.SetFindDBGrid(const Value: String);
var
    I       : Integer;
    Temp    : TComponent;
begin
    if FFindDBGrid<>Value then
    begin
        for I := Parent.ComponentCount - 1 downto 0 do
        begin
            Temp := Parent.Components[I];
            if (Temp is TControl) and (Temp.ClassName='TDBGrid') and (UpperCase(Value)=UpperCase(Temp.Name)) then
            begin
                FFindDBGrid:=Temp.Name;
                exit;
            end
            else
                FFindDBGrid:='';
        end;
    end;
end; }

procedure TQGrid.XlsWriteCellLabel(XlsStream: TStream; const ACol, ARow: Word;const AValue: string);
var
    L: Word;
const
    {$J+}
    CXlsLabel: array[0..5] of Word = ($204, 0, 0, 0, 0, 0);
    {$J-}
begin
    L := Length(AValue);
    CXlsLabel[1] := 8 + L;
    CXlsLabel[2] := ARow;
    CXlsLabel[3] := ACol;
    CXlsLabel[5] := L;
    XlsStream.WriteBuffer(CXlsLabel, SizeOf(CXlsLabel));
    {$IFDEF UNICODE}
        XlsStream.WriteBuffer(Pointer(AnsiString(AValue))^, L);
    {$ELSE}
        XlsStream.WriteBuffer(Pointer(AValue)^, L);
    {$ENDIF UNICODE}
end;

function TQGrid.SaveAsExcelFile(AGrid: TQGrid; AFileName: string): Boolean;
const
    {$J+}
    CXlsBof: array[0..5] of Word = ($809, 8, 00, $10, 0, 0);
    {$J-}
    CXlsEof: array[0..1] of Word = ($0A, 00);
var
    FStream : TFileStream;
    I, J    : Integer;
begin
    FStream := TFileStream.Create(PChar(AFileName), fmCreate or fmOpenWrite);
    try
        CXlsBof[4] := 0;
        FStream.WriteBuffer(CXlsBof, SizeOf(CXlsBof));
        for i := 0 to AGrid.ColCount - 1 do
            for j := 0 to AGrid.RowCount - 1 do
                XlsWriteCellLabel(FStream, I, J, AGrid.cells[i, j]);
        FStream.WriteBuffer(CXlsEof, SizeOf(CXlsEof));
        Result := True;
    finally
        FStream.Free;
    end;
end;

function CheckBoxRect(VRect: TRect): TRect;
begin
    with VRect do
    begin
        Result.Top    := Top + (((Bottom - Top) div 2) - (15 div 2));
        Result.Left   := Left - (15 div 2) + (Right - Left) div 2;
        Result.Right  := Result.Left + 15;
        Result.Bottom := Result.Top + 13;
    end;
end;

procedure TQGrid.ExtraireChaine(Chaine:string; Tableau:TStringList; Separ:PAnsichar;ViderListe:Boolean=False;Carac:Boolean=False);
var
    I,N         : Integer;
    MotTrouve   : String;
begin
    if ViderListe then
        Tableau.Clear;
    N:=Length(Chaine);
    I:=1;
    while (I<=N) do
    begin
        MotTrouve:='';
        while (Chaine[I]=Separ)and(I<=N)do
            inc(I);
        while (Chaine[I]<>Separ)and(I<=N)do
        begin
            MotTrouve:=MotTrouve+Chaine[I];
            inc(I);
        end;
        if MotTrouve<>'' then
            Tableau.Append(MotTrouve)
    end;
end;

Procedure TQGrid.ColorRow(ARow:Longint;var AColor1,AColor2:TColor);
begin
    if odd(ARow) then
    begin
        AColor1:=ColorLigPaire;
        AColor2:=ColorLigImpaire;
    end
    else
    begin
        AColor1:=ColorLigImpaire;
        AColor2:=ColorLigPaire;
    end;
end;

Function TQGrid.FindText(ACol, ARow: Longint):Boolean;
var
  I: Integer;
  s:String;
begin
    Result:=False;
    if (UpperCase(Self.Cells[ACol,ARow])='TRUE')or(UpperCase(Self.Cells[ACol,ARow])='FALSE')or
        (UpperCase(Cells[ACol,ARow])='VTRUE')or(UpperCase(Cells[ACol,ARow])='VFALSE')or
        (UpperCase(Cells[ACol,ARow])='GTRUE')or(UpperCase(Cells[ACol,ARow])='GFALSE')or
        (UpperCase(Cells[ACol,ARow])='GGRAYED')or(UpperCase(Cells[ACol,ARow])='VGGRAYED')or
        (UpperCase(Cells[ACol,ARow])='VGTRUE')or(UpperCase(Cells[ACol,ARow])='VGFALSE')or
        (UpperCase(Cells[ACol,ARow])='RTRUE')or(UpperCase(Cells[ACol,ARow])='RFALSE')or
        (UpperCase(Cells[ACol,ARow])='VRTRUE')or(UpperCase(Cells[ACol,ARow])='VRFALSE')or
        (Pos('TPROGBAR',UpperCase(Cells[ACol,ARow]))=1)or
        (Pos('TMOTIF',UpperCase(Cells[ACol,ARow]))=1)or(Pos('VTMOTIF',UpperCase(Cells[ACol,ARow]))=1)or
        (UpperCase(Cells[ACol,ARow])='TCADTRUE')or(UpperCase(Cells[ACol,ARow])='VTCADTRUE')or
        (UpperCase(Cells[ACol,ARow])='TCADFALSE')or(UpperCase(Cells[ACol,ARow])='VTCADFALSE')or
        (Pos('TITEMS',UpperCase(Cells[ACol,ARow]))=1)or(Pos('VTITEMS',UpperCase(Cells[ACol,ARow]))=1)then//or
        Result:=True
    else
    begin
        for I := 0 to Self.Button.Count - 1 do
        begin
            if Pos('TBUTTON'+IntToStr(I),UpperCase(Cells[ACol,ARow]))=1 then
            begin
                Result:=True;
                Break;
            end
            else
                Result:=False;
        end;
    end;
end;

Procedure TQGrid.AlterCheck;
var
    VRect   : TRect;
    Chaine  : TStringList;
    I       : Integer;
begin
    if FColCheckedVisible then
    begin
//        QCheckbox
        VRect:=CheckBoxRect(CellRect(Col,Row));
        case AnsiIndexStr(UpperCase(Cells[Col,Row]),ValCheck) of
             0 : begin Cells[Col,Row]:='FALSE';ClickCheckBox;end;
             1 : begin Cells[Col,Row]:='TRUE';ClickCheckBox;end;
             2 : begin ClickCheckBox;end;//Cells[Col,Row]:='VFALSE';
             3 : begin ClickCheckBox;end;//Cells[Col,Row]:='VTRUE';
             4 : begin Cells[Col,Row]:='GFALSE';ClickCheckBox;end;
             5 : begin Cells[Col,Row]:='GGRAYED';ClickCheckBox;end;
             6 : begin Cells[Col,Row]:='GTRUE';ClickCheckBox;end;
        end;

//        QRadiobuttons
        case AnsiIndexStr(UpperCase(Cells[Col,Row]),ValRadio) of
             0 : begin Cells[Col,Row]:='RFALSE';ClickRaddioButton;end;
             1 : begin Cells[Col,Row]:='RTRUE';ClickRaddioButton;end;
             2 : begin ClickRaddioButton;end;//Cells[Col,Row]:='VRFALSE';
             3 : begin ClickRaddioButton;end;//Cells[Col,Row]:='VRTRUE';
        end;

//        QCadenas
        case AnsiIndexStr(UpperCase(Cells[Col,Row]),ValCad) of
             0 : begin Cells[Col,Row]:='TCADFALSE';ClickCadenas;end;
             1 : begin Cells[Col,Row]:='TCADTRUE';ClickCadenas;end;
             2 : begin ClickCadenas;end;//Cells[Col,Row]:='VTCADFALSE';
             3 : begin ClickCadenas;end;//Cells[Col,Row]:='VTCADTRUE';
        end;

//        QMotifs
        if (Pos('TMOTIF',UpperCase(Cells[Col,Row]))=1)or(Pos('VTMOTIF',UpperCase(Cells[Col,Row]))=1) then
        begin
            Chaine:=TStringList.Create;
            try
                ExtraireChaine(UpperCase(Cells[Col,Row]),Chaine,',');
                VerifChaineMotif(Chaine);
                if (Pos('TMOTIF',UpperCase(Cells[Col,Row]))=1) then
                begin
                    if StrToInt(Chaine[2])>StrToInt(Chaine[3]) then
                        Cells[Col,Row]:=Chaine[0]+','+Chaine[1]+','+Chaine[2]+','+IntToStr(StrToInt(Chaine[3])+1)+','+Chaine[4]
                    else
                        Cells[Col,Row]:=Chaine[0]+','+Chaine[1]+','+Chaine[2]+','+'0'+','+Chaine[4];
                end;
            finally
                ClickMotif;
                Chaine.Free;
            end;
        end;

//        QBitmapItems
        if (Pos('TITEMS',UpperCase(Cells[Col,Row]))=1)or(Pos('VTITEMS',UpperCase(Cells[Col,Row]))=1) then
        begin
            Chaine:=TStringList.Create;
            try
                ExtraireChaine(UpperCase(Cells[Col,Row]),Chaine,',');
                if VerifChaineItems(Chaine)then
                begin
                    if (Pos('TITEMS',UpperCase(Cells[Col,Row]))=1) then
                    begin
                        if UpperCase(Chaine.Strings[3])='TRUE' then
                            Cells[Col,Row]:=Chaine[0]+','+Chaine[1]+','+Chaine[2]+','+'FALSE'
                        else
                            Cells[Col,Row]:=Chaine[0]+','+Chaine[1]+','+Chaine[2]+','+'TRUE';
                    end;
                end;
            finally
                Items[StrToInt(Chaine[1])].ClickBitmapItem(Self,Col,Row,StrToInt(Chaine[1]));
                Chaine.Free;
            end;
        end;

//        QButtons
        if (Pos('TBUTTON',UpperCase(Cells[Col,Row]))=1) then
            for I := 0 to Self.Button.Count-1 do
                if Pos('TBUTTON'+IntToStr(I),UpperCase(Cells[Col,Row]))=1 then
                    Button.Items[I].ClickButtonItem(Self);
    end;
end;

Procedure TQGrid.ClickCheckBox;
begin
    if Assigned(FOnClickCheckBox) then
        FOnClickCheckBox(Self,Col,Row);
end;

Procedure TQGrid.ClickRaddioButton;
begin
    if Assigned(FOnClickRadioButton) then
        FOnClickRadioButton(Self,Col,Row);
end;

Procedure TQGrid.ClickCadenas;
begin
    if Assigned(FOnClickCadenas) then
        FOnClickCadenas(Self,Col,Row);
end;

Procedure TQGrid.ClickMotif;
begin
    if Assigned(FOnClickMotif) then
        FOnClickMotif(Self,Col,Row);
end;

function TQGrid.SelectCell(ACol, ARow: Longint): Boolean;
begin
    if FColCheckedVisible then
    begin
        if FindText(ACol, ARow) then
        begin
            if goEditing in Options then
            begin
                MEditing:=True;
                Options:=Options-[goEditing];
            end;
        end
        else
            if MEditing then
                Options:=Options+[goEditing];
    end;
    Result := True;
//    inherited SelectCell(ACol, ARow);
end;

Procedure TQGrid.KeyDown(var Key: Word; Shift: TShiftState);
begin
    if Key = VK_RETURN then
        AlterCheck;
    inherited KeyDown(Key,Shift);
end;

procedure TQGrid.SetEditText(ACol, ARow: Longint; const Value: string);
begin
    if FColCheckedVisible then
    begin
        if FindText(ACol, ARow)then
        begin
            if goEditing in Options then
            begin
                MEditing:=True;
                Options:=Options-[goEditing];
            end;
        end
        else
            if MEditing then
                Options:=Options+[goEditing];
    end;
    inherited SetEditText(ACol,ARow,Value);
end;

Procedure TQGrid.MouseDown(Button: TMouseButton; Shift: TShiftState;X, Y: Integer);
begin
    inherited MouseDown(Button,Shift,X, Y);
    if (Col>=FixedCols)and(Col<ColCount)and(Row>=FixedRows)and(Row<RowCount)then
        if Button=mbLeft then
            if (MouseCoord(X,Y).X=Col)and(MouseCoord(X,Y).Y=Row) then
                AlterCheck;
end;

Procedure TQGrid.DesCheck(Stick, Active, Grayed:Boolean; ACol, ARow: Longint);
var
    VRect   : TRect;
    I,J     : Integer;
begin
//    Position
    VRect:=CellRect(ACol,ARow);
    VRect.Left:=((VRect.Right-VRect.Left)div 2)+VRect.Left-(13 div 2);
    VRect.Right:=VRect.Left+13;
    VRect.Top:=((VRect.Bottom-VRect.Top)div 2)+VRect.Top-(13 div 2);
    VRect.Bottom:=VRect.Top+13;
//    Fond
    if Active then
        Canvas.Brush.Color:=CheckBox.ColorFontCheck
    else
        Canvas.Brush.Color:=clSilver;
    case ConvCheckStyle(CheckBox.CheckStyle) of
        1 : if Active then
                Canvas.Brush.Style:=bsClear
            else
                Canvas.Brush.Style:=bsSolid;
        2 : Canvas.Brush.Style:=bsSolid;
        else
            Canvas.Brush.Style:=bsSolid;
    end;
    if Grayed then
    begin
        for J:=VRect.Left to VRect.Right-1 do
        begin
            for I:=1 to 12 do
            begin
                if Active then
                begin
                    if (not odd(J)) and (not odd(I)) then
                        Canvas.Pixels[J,VRect.Top+I]:=CheckBox.ColorGrayed1
                    else
                        Canvas.Pixels[J,VRect.Top+I]:=CheckBox.ColorGrayed2;
                end
                else
                begin
                    if (not odd(J)) and (not odd(I)) then
                        Canvas.Pixels[J,VRect.Top+I]:=clWhite
                    else
                        Canvas.Pixels[J,VRect.Top+I]:=clSilver;
                end;
            end;
        end;
    end
    else
        Canvas.FillRect(VRect);
//    Tour
    Canvas.Brush.Style:=bsClear;
    if not CheckBox.Check3D then
    begin
        if Active then
            Canvas.Pen.Color:=CheckBox.ColorTourCheck
        else
            Canvas.Pen.Color:=clBlack;
        Canvas.Rectangle(VRect);
    end
    else
    begin
        Canvas.Pen.Color:=$00676767;
        Canvas.Polyline([Point(VRect.Left,VRect.Top+12),Point(VRect.Left,VRect.Top),Point(VRect.Left+12,VRect.Top)]);
        Canvas.Pen.Color:=clWhite;
        Canvas.Polyline([Point(VRect.Left+12,VRect.Top),Point(VRect.Left+12,VRect.Top+12),Point(VRect.Left-1,VRect.Top+12)]);
        Canvas.Pen.Color:=clBlack;
        Canvas.Polyline([Point(VRect.Left+1,VRect.Top+11),Point(VRect.Left+1,VRect.Top+1),Point(VRect.Left+11,VRect.Top+1)]);
        Canvas.Pen.Color:=$00E6E6E6;
        Canvas.Polyline([Point(VRect.Left+11,VRect.Top+1),Point(VRect.Left+11,VRect.Top+11),Point(VRect.Left+0,VRect.Top+11)]);
        Canvas.Brush.Color:=clWindow;
    end;
//    Stick
    if Stick then
    begin
        if Active then
        begin
            if Grayed then
                Canvas.Pen.Color:=CheckBox.ColorStickGrayed
            else
                Canvas.Pen.Color:=CheckBox.ColorStick;
        end
        else
            Canvas.Pen.Color:=clGray;
        Canvas.Polyline([Point(VRect.Left+3,VRect.Top+5),Point(VRect.Left+5,VRect.Top+7),Point(VRect.Left+9,VRect.Top+3),
            Point(VRect.Left+9,VRect.Top+5),Point(VRect.Left+5,VRect.Top+9),Point(VRect.Left+3,VRect.Top+7),Point(VRect.Left+3,VRect.Top+6),
            Point(VRect.Left+5,VRect.Top+8),Point(VRect.Left+9,VRect.Top+4)]);
    end;
end;

procedure BitmapGradient(Bitmap: TBitmap; VRect: TRect; ColorDeb, ColorFin: TColor; StyleGradient : TStyleGradient; Region: HRGN);
var
    I, J, K     : Integer;
    MaxDist     : Integer;
    X1, X2      : Integer;
    LigDest     : PRGBArray;
    Deb         : array[0..2] of Integer;
    Diff        : array[0..2] of Double;
    Coef        : Double;
    Rayon       : Extended;
    Res1        : Extended;
    Res2        : Extended;
    Res3        : Extended;
    Angle1      : Extended;
    Angle2      : Extended;
    Angle3      : Extended;
    Centre1     : Integer;
    Centre2     : Integer;
    BitmapRond  : TBitmap;
    VRectRond   : TRect;
    Coef2       : Extended;
const
    Deg = Pi/180;
begin
    if Bitmap.Empty then
        exit;
    if (ColorDeb=ColorFin)then
    begin
        Bitmap.Canvas.Brush.Color:=ColorDeb;
        if Region > 0 then
            FillRgn(Bitmap.Canvas.Handle, Region, Bitmap.Canvas.Brush.Handle)
        else
            Bitmap.Canvas.FillRect(VRect);
        exit;
    end;
    X1:=ColorToRGB(ColorDeb);
    X2:=ColorToRGB(ColorFin);
    if StyleGradient=sgRond then
    begin
        BitmapRond:=TBitmap.Create;
        BitmapRond.PixelFormat := pf24bit;
        Rayon:=Round(VRect.Right / Pi) div 2;
        Coef2:=(VRect.Right)/(Rayon*2);
        if VRect.Right<VRect.Bottom then
        begin
            BitmapRond.Width:=Round(VRect.Right*Coef2);
            BitmapRond.Height:=Round(VRect.Bottom*Coef2);
        end
        else
        begin
            BitmapRond.Width:=Round(VRect.Bottom*Coef2);
            BitmapRond.Height:=Round(VRect.Right*Coef2);
        end;
        VRectRond.Left:=0;
        VRectRond.Top:=0;
        VRectRond.Right:=BitmapRond.Width;
        VRectRond.Bottom:=BitmapRond.Height;
    end;
    case StyleGradient of
        sgVertical      : MaxDist := (VRect.Bottom - VRect.Top);
        sgHorizontal    : MaxDist := (VRect.Right - VRect.Left);
        sgRond          : MaxDist := (VRectRond.Right - VRectRond.Left);
        sgTopLeft       : MaxDist := (Round(Sqrt(Sqr(VRect.Right-VRect.Left)+Sqr(VRect.Bottom-VRect.Top)))-VRect.Left);
        sgTopRight      : MaxDist := (Round(Sqrt(Sqr(VRect.Right-VRect.Left)+Sqr(VRect.Bottom-VRect.Top)))-VRect.Left);
        sgBottomLeft    : MaxDist := (Round(Sqrt(Sqr(VRect.Right-VRect.Left)+Sqr(VRect.Bottom-VRect.Top)))-VRect.Left);
        sgBottomRight   : MaxDist := (Round(Sqrt(Sqr(VRect.Right-VRect.Left)+Sqr(VRect.Bottom-VRect.Top)))-VRect.Left);
        sgRadial        : MaxDist := (Round(((Sqrt(Sqr(VRect.Right-VRect.Left)+Sqr(VRect.Bottom-VRect.Top)))- VRect.Left)/ 2));
        sgDoubleHorz    : MaxDist := (Round((VRect.Right - VRect.Left) div 2));
        sgDoubleVert    : MaxDist := (Round((VRect.Bottom - VRect.Top) div 2));
    end;
    Deb[0]  := GetRValue(X1);
    Deb[1]  := GetGValue(X1);
    Deb[2]  := GetBValue(X1);
    Diff[0] := (GetRValue(X2) - Deb[0]) / MaxDist;
    Diff[1] := (GetGValue(X2) - Deb[1]) / MaxDist;
    Diff[2] := (GetBValue(X2) - Deb[2]) / MaxDist;
    if Diff[0] > 255 then
        Diff[0] := 255;
    if Diff[1] > 255 then
        Diff[1] := 255;
    if Diff[2] > 255 then
        Diff[2] := 255;

    if StyleGradient<>sgRond then
    for K:= VRect.Top to VRect.Bottom -1 do
    begin
        LigDest := Bitmap.ScanLine[K];
        for J := VRect.Left to VRect.Right - 1 do
        begin
            if (Region > 0) and not(PtInRegion(Region, J, K)) then
                Continue;
            case StyleGradient of
                sgHorizontal    : Coef := J - VRect.Left;
                sgVertical      : Coef := K - VRect.Top;
                sgTopLeft       : Coef := Sqrt(Sqr(J - VRect.Left) + Sqr(K - VRect.Top));
                sgTopRight      : Coef := Sqrt(Sqr(VRect.Right - J) + Sqr(K - VRect.Top));
                sgBottomLeft    : Coef := Sqrt(Sqr(J - VRect.Left) + Sqr(VRect.Bottom - K));
                sgBottomRight   : Coef := Sqrt(Sqr(VRect.Right - J) + Sqr(VRect.Bottom - K));
                sgRadial        : Coef := Sqrt(Sqr(((VRect.Right - VRect.Left) shr 1) - J) + Sqr(K - ((VRect.Bottom - VRect.Top) shr 1)));
                sgDoubleHorz    : Coef := Abs(J - MaxDist - VRect.Left);
                sgDoubleVert    : Coef := Abs(K - MaxDist - VRect.Top);
            end;
            LigDest[J].rgbtRed   := Byte(Round(Deb[0]+(Diff[0]*Coef)));
            LigDest[J].rgbtGreen := Byte(Round(Deb[1]+(Diff[1]*Coef)));
            LigDest[J].rgbtBlue  := Byte(Round(Deb[2]+(Diff[2]*Coef)));
        end;
    end
    else
    begin
        for K:= VRectRond.Top to VRectRond.Top do
        begin
            LigDest := BitmapRond.ScanLine[K];
            for J := VRectRond.Left to VRectRond.Right - 1 do
            begin
                if (Region > 0) and not PtInRegion(Region, J, K) then
                    Continue;
                Coef := J - VRectRond.Left;
                LigDest[J].rgbtRed   := Byte(Round(Deb[0]+(Diff[0]*Coef)));
                LigDest[J].rgbtGreen := Byte(Round(Deb[1]+(Diff[1]*Coef)));
                LigDest[J].rgbtBlue  := Byte(Round(Deb[2]+(Diff[2]*Coef)));
            end;
        end;
        Rayon:=Round(VRectRond.Right / Pi) div 2;
        Centre1:=VRect.Right div 2;
        Centre2:=VRect.Bottom div 2;
        Bitmap.Canvas.Pen.Width:=2;
        for I := VRectRond.Left to VRectRond.Right do
        begin
            if I = VRectRond.Right then
                Bitmap.Canvas.Pen.Width:=1;
            Bitmap.Canvas.Pen.Color:=BitmapRond.Canvas.Pixels[I,VRect.Top];
            Bitmap.Canvas.Brush.Color:=Bitmap.Canvas.Pixels[I,VRect.Top];
            Bitmap.Canvas.PenPos:=Point(VRect.Right div 2,VRect.Bottom div 2);
            Angle1:=(180-(90/(VRectRond.Right/4)*I))/2;
            Res1:=(Cos(Deg*Angle1)*Rayon)*2;
            Angle2:=180-(Angle1+90);
            Res2:=(Cos(Deg*Angle2)*Res1);
            Angle3:=180-(Angle2+90);
            Res3:=(Cos(Deg*Angle3)*Res1);
            Bitmap.Canvas.LineTo(Round(Centre1+Res2),Round(Centre2-Rayon+Res3));
        end;
        BitmapRond.Free;
    end;
end;

Procedure TexteDraw(Bitmap:TBitmap;Text:String);
begin
    Bitmap.Canvas.Font.Color:=clBlack;
    Bitmap.Canvas.TextRect(Bitmap.Canvas.ClipRect,
        (Bitmap.Width div 2)-((Bitmap.Canvas.TextWidth(Text))div 2),
        (Bitmap.Height div 2)-((Bitmap.Canvas.TextHeight(Text))div 2),
        Text);
end;

Procedure TQGrid.DesProgBar(Chaine:TStringList;ACol,ARow:Longint);
var
    VRect       : TRect;
    TeRect      : TRect;
    Coef        : Integer;
    CRect       : TRect;
    Pos         : Integer;
    Min         : Integer;
    Max         : Integer;
    Color1      : TColor;
    Color2      : TColor;
    Centre1     : Integer;
    Centre2     : Integer;
    Rayon       : Extended;
//    R           : HRGN;
    ColorAr     : TColor;
    Per         : Extended;
    Res1        : Extended;
    Res2        : Extended;
    Res3        : Extended;
    Angle1      : Extended;
    Angle2      : Extended;
    Angle3      : Extended;
    Dia         : Extended;
    Ray         : Extended;
    Ray2        : Extended;
    PerP        : Extended;
    NoCer       : Integer;
    I           : Integer;
    Taille      : Extended;
    TVBitmap    : TBitmap;
    FiBitmap    : TBitmap;
    ColorArOp   : TColor;
const
    Deg = Pi/180;
begin
//    Arriere plan
    VerifChaineProg(Chaine,ACol,ARow);
    Pos:=StrToIntDef(Chaine.Strings[1],0);
    Min:=StrToIntDef(Chaine.Strings[2],0);
    Max:=StrToIntDef(Chaine.Strings[3],100);
    Color1:=StringToColor(Chaine.Strings[4]);
    Color2:=StringToColor(Chaine.Strings[5]);
//    Couleur arrière plan
    ColorRow(ARow,ColorAr,ColorArOp);
    FGrBitmap := TBitmap.Create;
    TVBitmap  := TBitmap.Create;
    FiBitmap  := TBitmap.Create;
    try
        FGrBitmap.PixelFormat   := pf24bit;
        TVBitmap.PixelFormat    := pf24bit;
        FiBitmap.PixelFormat    := pf24bit;
        VRect:=CellRect(ACol,ARow);
        FiBitmap.Canvas.Brush.Color:=ColorAr;
        FiBitmap.Canvas.Pen.Color:=ColorAr;
        FiBitmap.Width := VRect.Right-VRect.Left;
        FiBitmap.Height := VRect.Bottom-VRect.Top;
        if Self.ProgressBar.StyleGradient<>sgRond then
        begin
            TeRect.Top:=Round(((VRect.Bottom-VRect.Top)div 2)+VRect.Top-6);
            TeRect.Bottom:=Round(((VRect.Bottom-VRect.Top)div 2)+VRect.Top+6);
            TeRect.Left:=VRect.Left+6;
            TeRect.Right:=VRect.Right-6;
        end
        else
        begin
            TeRect:=VRect;
            FGrBitmap.Canvas.Brush.Color:=ColorAr;
            FGrBitmap.Canvas.Pen.Color:=ColorAr;
            TvBitmap.Canvas.Brush.Color:=ColorAr;
            TvBitmap.Canvas.Pen.Color:=ColorAr;
        end;
        VRect:=TeRect;
        FGrBitmap.Width := VRect.Right-VRect.Left;
        FGrBitmap.Height := VRect.Bottom-VRect.Top;
        TVBitmap.Width := VRect.Right-VRect.Left;
        TVBitmap.Height := VRect.Bottom-VRect.Top;
        TeRect.Top:=0;
        TeRect.Left:=0;
        TeRect.Right:=VRect.Right-VRect.Left;
        TeRect.Bottom:=VRect.Bottom-VRect.Top;
//        R := CreateRoundRectRgn (VRet.Left,VRect.top,VRect.right,VRect.Bottom,10,10);
//        try
//            FGrBitmap.Canvas.Brush.Style := bsClear;
//        BitmapGradient(FGrBitmap, TeRect, Color1, Color2, Self.ProgressBar.StyleGradient, 0);
        if Pos>0 then
            BitmapGradient(FGrBitmap, TeRect, Color1, Color2, Self.ProgressBar.StyleGradient, 0);
//        finally
//            DeleteObject(R);
//        end;
        if Min<0 then
        begin
            Max:=Max-Min;
            Min:=0;
        end;
        if Pos>Max then
            Max:=Pos;
        if Pos<Min then
            Min:=Pos;

        if Self.ProgressBar.StyleGradient=sgRond then
        begin
            Centre1:=FGrBitmap.Width div 2;
            Centre2:=FGrBitmap.Height div 2;
            if FGrBitmap.Height<=FGrBitmap.Width then
                Rayon:=FGrBitmap.Height div 2
            else
                Rayon:=FGrBitmap.Width div 2;
            with FGrBitmap.Canvas do
            begin
//                diminution des irrégularitées
                Pen.Width:=3;
                Brush.Style:=bsClear;
                Pen.Color:=ColorAr;
                Ellipse(Round(Centre1-Rayon-3),Round(Centre2-Rayon-3),Round(Centre1+Rayon+3),Round(Centre2+Rayon+3));
                Ellipse(Round(Centre1-Rayon-1),Round(Centre2-Rayon-1),Round(Centre1+Rayon+1),Round(Centre2+Rayon+1));
                Pen.Width:=1;
                Pen.Color:=ClBlack;
                Ellipse(Round(Centre1-Rayon+1),Round(Centre2-Rayon+1),Round(Centre1+Rayon-1),Round(Centre2+Rayon-1));
                Brush.Style:=bsSolid;
                Brush.Color:=ColorAr;
//                Part
                if(Pos>0) and (Pos<>Max)then
                begin
                    Per:=2*Pi*Rayon;
                    Angle1:=(180-((90/(Per/4))*(Per*(Pos/Max))))/2;
                    Res1:=(Cos(Deg*Angle1)*Rayon)*2;
                    Angle2:=180-(Angle1+90);
                    Res2:=(Cos(Deg*Angle2)*Res1);
                    Angle3:=180-(Angle2+90);
                    Res3:=(Cos(Deg*Angle3)*Res1);
                    if Progressbar.Ball then
                        Pen.Color:=ColorAr
                    else
                        Pen.Color:=clBlack;
                    Pie(Round(Centre1-Rayon)+1,Round(Centre2-Rayon)+1,Round(Centre1+Rayon)-1,Round(Centre2+Rayon)-1,
                        Centre1+1,Round(Centre2-Rayon-1),Round(Centre1+Res2),Round(Centre2-Rayon+Res3));
                end;
//                cercle centrale
                if not Progressbar.Ball then
                begin
                    Pen.Color:=clBlack;
                    Ellipse(Round(Centre1-Rayon+(Rayon / 3)),Round(Centre2-Rayon+(Rayon / 3)),Round(Centre1+Rayon-(Rayon / 3)),Round(Centre2+Rayon-(Rayon / 3)));
                    TVBitmap.Canvas.Brush.Color:=ColorArOp;
                    TVBitmap.TransparentMode:=tmFixed;
                    TVBitmap.Transparent:=True;
                    TVBitmap.TransparentColor:=ColorArOp;
                end
                else
                begin
//                    Petit cercle
                    if ProgressBar.DiamBall=0 then
                        Dia:=Rayon / 2
                    else
                        if ProgressBar.DiamBall>(Rayon / 1.1) then
                            Dia:=Rayon / 1.1
                        else
                            Dia:=ProgressBar.DiamBall;
                    Ray:=Dia / 2; //Espacement entre les cercles (lié au diamètre)
                    Ray2:=Rayon-(Ray+(Ray / 5));
                    Perp:=Ray2 * 2 * Pi;
                    NoCer:=Round(Perp / Dia);
                    Taille:=Dia / 10;
//                    centre du cercle
                    TVBitmap.Canvas.Brush.Color:=ColorArOp;
                    TVBitmap.TransparentMode:=tmFixed;
                    TVBitmap.Transparent:=True;
                    TVBitmap.TransparentColor:=ColorArOp;
                    if Pos=0 then
                        TVBitmap.Canvas.Pen.Color:=clBlack;
//                    TVBitmap.Canvas.Brush.Style:=bsClear;
                    for I := 1 to NoCer do
                    begin
                        Angle1:=(180-((90/(Perp/4))*(Perp*(I/NoCer))))/2;
                        Res1:=(Cos(Deg*Angle1)*Ray2)*2;
                        Angle2:=180-(Angle1+90);
                        Res2:=(Cos(Deg*Angle2)*Res1);
                        Angle3:=180-(Angle2+90);
                        Res3:=(Cos(Deg*Angle3)*Res1);
                        TVBitmap.Canvas.Ellipse(Round(Centre1+Res2-Ray+Taille),Round(Centre2-Ray2+Res3-Ray+Taille),Round(Centre1+Res2+Ray-Taille),Round(Centre2-Ray2+Res3+Ray-Taille));
                    end;
                    Draw(0,0,TVBitmap);
                end;
                //texte
                if ProgressBar.StyleText=sttValue then
                    TexteDraw(TVBitmap,IntToStr(Pos));
                if ProgressBar.StyleText=sttPercent then
                    TexteDraw(TVBitmap,IntToStr(Round((Pos / Max)*100))+'%');
                if ProgressBar.StyleText<>sttNone then
                    Draw(0,0,TVBitmap);
            end;
        end
        else
        begin
//            Partie à supprimer
            with FGrBitmap.Canvas do
            begin
                Brush.Style:=bsSolid;
                Brush.Color:=ColorAr;
                Pen.Color:=ColorAr;
                TeRect:=ClipRect;
                if Pos>0 then
                    TeRect.Left:=Round(TeRect.Left+(((TeRect.Right-TeRect.Left)*Pos)div Max));
                Rectangle(TeRect);
            end;
//            Texte
            if ProgressBar.StyleText<>sttNone then
            begin
                with TVBitmap do
                begin
                    Width:=FGrBitmap.Width;
                    Height:=FGrBitmap.Height;
                    Canvas.Brush.Color:=ColorArOp;
                    TransparentMode:=tmFixed;
                    Transparent:=True;
                    TransparentColor:=ColorArOp;
                end;
                if ProgressBar.StyleText=sttValue then
                    TexteDraw(TVBitmap,IntToStr(Pos));
                if ProgressBar.StyleText=sttPercent then
                    TexteDraw(TVBitmap,IntToStr(Round((Pos / Max)*100))+'%');
                FGrBitmap.Canvas.Draw(0,0,TVBitmap);
            end;
        end;
//        Mise en place de la couleur de fond cellule
        FiBitmap.Canvas.Brush.Style:=bsSolid;
        FiBitmap.Canvas.Rectangle(CellRect(ACol,ARow));
        if Self.ProgressBar.StyleGradient<>sgRond then
        begin // Partie barre
            FiBitmap.Canvas.Draw((FiBitmap.Width div 2)-(FGrBitmap.Width div 2),
                (FiBitmap.Height div 2)-(FGrBitmap.Height div 2),FGrBitmap);
            Canvas.CopyRect(CellRect(ACol,ARow), FiBitmap.Canvas, FiBitmap.Canvas.ClipRect);
        end
        else // Partie ball
            Canvas.CopyRect(VRect, FGrBitmap.Canvas, FGrBitmap.Canvas.ClipRect);
    finally
        TVBitmap.Free;
        FGrBitmap.Free;
        FiBitmap.Free;
    end;
    if Self.ProgressBar.StyleGradient<>sgRond then
    begin
//        Tour
        Canvas.Brush.Style:=bsClear;
        Canvas.Pen.Color:=clBlack;
        CRect.Left:=VRect.Left-2;
        CRect.Right:=VRect.Right+2;
        CRect.Top:=VRect.Top-2;
        CRect.Bottom:=VRect.Bottom+2;
        Canvas.Rectangle(CRect);
    end;
end;

Procedure TQGrid.VerifChaineProg(Chaine:TStringList;ACol,ARow:Longint);
var
    Value   : Integer;
begin
    case Chaine.Count of
        1 : begin
                Chaine.Add('0');
                Chaine.Add('0');
                Chaine.Add('100');
                Chaine.Add(ColorToString(ProgressBar.ColorFirst));
                Chaine.Add(ColorToString(ProgressBar.ColorEnd));
            end;
        2 : begin
                Chaine.Add('0');
                Chaine.Add('100');
                Chaine.Add(ColorToString(ProgressBar.ColorFirst));
                Chaine.Add(ColorToString(ProgressBar.ColorEnd));
            end;
        3 : begin
                Chaine.Add('100');
                Chaine.Add(ColorToString(ProgressBar.ColorFirst));
                Chaine.Add(ColorToString(ProgressBar.ColorEnd));
            end;
        4 : begin
                Chaine.Add(ColorToString(ProgressBar.ColorFirst));
                Chaine.Add(ColorToString(ProgressBar.ColorEnd));
            end;
        5 : Chaine.Add(ColorToString(ProgressBar.ColorEnd));
        else
            while Chaine.Count>6 do
                Chaine.Delete(Chaine.Count-1);
    end;
    Chaine.Strings[1]:=IntToStr(StrToIntDef(Chaine.Strings[1],0));
    Chaine.Strings[2]:=IntToStr(StrToIntDef(Chaine.Strings[2],0));
    Chaine.Strings[3]:=IntToStr(StrToIntDef(Chaine.Strings[3],100));
    if not IdentToColor(Chaine.Strings[4],Value) then
        Chaine.Strings[4]:=ColorToString(ProgressBar.ColorFirst);
    if not IdentToColor(Chaine.Strings[5],Value) then
        Chaine.Strings[5]:=ColorToString(ProgressBar.ColorEnd);
end;

Procedure TQGrid.VerifChaineMotif(Chaine:TStringList);
var
    Value : Integer;
begin
    case Chaine.Count of
        1 : begin
                Chaine.Add('ETOILE');
                Chaine.Add('1');
                Chaine.Add(Chaine.Strings[2]);
                Chaine.Add(ColorToString(Self.Motif.Color));
            end;
        2 : begin
                Chaine.Add('1');
                Chaine.Add(Chaine.Strings[2]);
                Chaine.Add(ColorToString(Self.Motif.Color));
            end;
        3 : begin
                Chaine.Add(Chaine.Strings[2]);
                Chaine.Add(ColorToString(Self.Motif.Color));
            end;
        4 : begin
                Chaine.Add(ColorToString(Self.Motif.Color));
            end;
        else
            while Chaine.Count>5 do                                                                             
                Chaine.Delete(Chaine.Count-1);
    end;
    Chaine.Strings[2]:=IntToStr(StrToIntDef(Chaine.Strings[2],1));
    Chaine.Strings[3]:=IntToStr(StrToIntDef(Chaine.Strings[3],StrToInt(Chaine.Strings[2])));
    if not identToColor(Chaine.Strings[4],Value)then
        Chaine.Strings[4]:=ColorToString(Self.Motif.Color);
end;

Procedure TQGrid.DesMotif(Chaine:TStringList;ACol,ARow:Longint);
var
    Po              : Integer;
    I               : Integer;
    VRect           : TRect;
    NbMotif         : Integer;
    NbMotifPlein    : Integer;
    Value           : Integer;
    Mil1            : Integer;
    Mil2            : Integer;
    PtEtoile        : Boolean;
begin
    VerifChaineMotif(Chaine);
    PtEtoile:=False;
    NbMotif:=StrToIntDef(Chaine.Strings[2],1);
    NbMotifPlein:=StrToIntDef(Chaine.Strings[3],NbMotif);
    VRect:=CellRect(ACol,ARow);
    if (Chaine[1]='COEUR') or (Chaine[1]='ETOILE') then
    begin
        Mil1:=(VRect.Left+((VRect.Right-VRect.Left)div 2))-((NbMotif*14)div 2);
        Mil2:=(VRect.Top+((VRect.Bottom-VRect.Top)div 2))-6;
    end;
    if (Chaine[1]='ETOILE') then
    begin
        if PtEtoile then
        begin
            Mil1:=(VRect.Left+((VRect.Right-VRect.Left)div 2))-((NbMotif*12)div 2);
            Mil2:=(VRect.Top+((VRect.Bottom-VRect.Top)div 2))-6;
        end
        else
        begin
            Mil1:=(VRect.Left+((VRect.Right-VRect.Left)div 2))-((NbMotif*17)div 2);
            Mil2:=(VRect.Top+((VRect.Bottom-VRect.Top)div 2))-8;
        end;
    end;
    if (chaine[1]='CADENAS') then
    begin
        Mil1:=(VRect.Left+((VRect.Right-VRect.Left)div 2))-((NbMotif*16)div 2);
        Mil2:=(VRect.Top+((VRect.Bottom-VRect.Top)div 2))-3;
    end;
    if (Chaine[1]='ROND')or(Chaine[1]='CARRE')then
    begin
        Mil1:=(VRect.Left+((VRect.Right-VRect.Left)div 2))-((NbMotif*12)div 2);
        Mil2:=(VRect.Top+((VRect.Bottom-VRect.Top)div 2))-6;
    end;
    if identToColor(Chaine.Strings[4],Value)then
        Canvas.Brush.Color:=StringToColor(Chaine.Strings[4])
    else
        Canvas.Brush.Color:=Self.Motif.Color;
    Canvas.Brush.Style:=bsSolid;        
    Canvas.Pen.Color:=clBlack;
    if Chaine[1]='COEUR' then
    begin
        for I := 0 to NbMotif-1 do
        begin 
            if I+1>NbMotifPlein then
                Canvas.Brush.Style:=bsClear;         
            Po:=i*14;
            Canvas.Polygon([Point(Mil1+Po+2,Mil2),Point(Mil1+Po+4,Mil2),
                Point(Mil1+Po+6,Mil2+2),Point(Mil1+Po+8,Mil2),
                Point(Mil1+Po+10,Mil2),Point(Mil1+Po+12,Mil2+2),
                Point(Mil1+Po+12,Mil2+4),Point(Mil1+Po+6,Mil2+10),
                Point(Mil1+Po+0,Mil2+4),Point(Mil1+Po+0,Mil2+2),Point(Mil1+Po+2,Mil2)]);
            Canvas.Pixels[Mil1+Po+2,Mil2+2]:=ClWhite;
            Canvas.Pixels[Mil1+Po+3,Mil2+2]:=ClWhite;
            Canvas.Pixels[Mil1+Po+2,Mil2+3]:=ClWhite;
        end;
    end;
    if Chaine[1]='ETOILE' then
    begin
        for I := 0 to NbMotif-1 do
        begin  
            if I+1>NbMotifPlein then
                Canvas.Brush.Style:=bsClear;
                Canvas.pen.Color:=clBlack;
            if PtEtoile then
            begin
                Po:=i*12;
                Canvas.Polygon([Point(Mil1+Po+6,Mil2),Point(Mil1+Po+8,Mil2+4),
                    Point(Mil1+Po+12,Mil2+4),Point(Mil1+Po+8,Mil2+6),Point(Mil1+Po+10,Mil2+10),
                    Point(Mil1+Po+6,Mil2+8),Point(Mil1+Po+2,Mil2+10),Point(Mil1+Po+4,Mil2+6),
                    Point(Mil1+Po+0,Mil2+4),Point(Mil1+Po+4,Mil2+4),Point(Mil1+Po+6,Mil2)]);
            end
            else
            begin
                Po:=i*17;
                Canvas.Polygon([Point(Mil1+Po+2,Mil2+15),Point(Mil1+Po+3,Mil2+15),Point(Mil1+Po+3,Mil2+13),
                    Point(Mil1+Po+4,Mil2+12),Point(Mil1+Po+4,Mil2+11),Point(Mil1+Po+5,Mil2+10),Point(Mil1+Po+1,Mil2+6),
                    Point(Mil1+Po+6,Mil2+6),Point(Mil1+Po+6,Mil2+5),Point(Mil1+Po+7,Mil2+5),Point(Mil1+Po+7,Mil2+3),
                    Point(Mil1+Po+8,Mil2+2),Point(Mil1+Po+8,Mil2+1),Point(Mil1+Po+9,Mil2+1),Point(Mil1+Po+9,Mil2+2),
                    Point(Mil1+Po+10,Mil2+3),Point(Mil1+Po+10,Mil2+4),Point(Mil1+Po+10,Mil2+5),Point(Mil1+Po+11,Mil2+5),
                    Point(Mil1+Po+11,Mil2+6),Point(Mil1+Po+16,Mil2+6),Point(Mil1+Po+12,Mil2+10),Point(Mil1+Po+13,Mil2+11),
                    Point(Mil1+Po+13,Mil2+12),Point(Mil1+Po+14,Mil2+13),Point(Mil1+Po+14,Mil2+15),Point(Mil1+Po+15,Mil2+15),
                    Point(Mil1+Po+14,Mil2+14),Point(Mil1+Po+12,Mil2+14),Point(Mil1+Po+11,Mil2+13),Point(Mil1+Po+10,Mil2+13),
                    Point(Mil1+Po+9,Mil2+12),Point(Mil1+Po+8,Mil2+12),Point(Mil1+Po+7,Mil2+13),Point(Mil1+Po+6,Mil2+13),
                    Point(Mil1+Po+5,Mil2+14),Point(Mil1+Po+4,Mil2+14),Point(Mil1+Po+2,Mil2+15)]);
            end;
        end;
    end;
    if Chaine[1]='CARRE' then
    begin
        for I := 0 to NbMotif-1 do
        begin
            if I+1>NbMotifPlein then
                Canvas.Brush.Style:=bsClear;
            po:=i*12;
            Canvas.Pen.Color:=clBlack;
            Canvas.FillRect(Rect(Mil1+Po+1,Mil2+1,Mil1+Po+11,Mil2+11));
            Canvas.Rectangle(Mil1+Po+1,Mil2+1,Mil1+Po+11,Mil2+11);
            Canvas.Pen.Color:=clGray;
            Canvas.Rectangle(Mil1+Po+2,Mil2+2,Mil1+Po+10,Mil2+10);
            Canvas.Pen.Color:=clSilver;
            Canvas.Polygon([Point(Mil1+Po+2,Mil2+9),Point(Mil1+Po+2,Mil2+2),Point(Mil1+Po+9,Mil2+2),Point(Mil1+Po+2,Mil2+2)]);
        end;
    end;
    if Chaine[1]='ROND' then
    begin
        for I := 0 to NbMotif-1 do
        begin
            if I+1>NbMotifPlein then
                Canvas.Brush.Style:=bsClear;
            po:=i*12;
            Canvas.Ellipse(Mil1+Po+1,Mil2+1,Mil1+Po+11,Mil2+11);
            Canvas.Pixels[Mil1+Po+3,Mil2+4]:=ClWhite;
            Canvas.Pixels[Mil1+Po+4,Mil2+4]:=ClWhite;
            Canvas.Pixels[Mil1+Po+3,Mil2+5]:=ClWhite;
            Canvas.Pixels[Mil1+Po+4,Mil2+3]:=ClWhite;
            Canvas.Pixels[Mil1+Po+5,Mil2+3]:=ClWhite;
        end;
    end;
    if Chaine[1]='CADENAS' then
    begin
        for I := 0 to NbMotif-1 do
        begin
            po:=i*16;
//            Bas
            Canvas.Brush.Style:=bsSolid;
            Canvas.Pen.Color:=$006CB6FF;
            Canvas.Brush.Color:=$000BE9F4;
            Canvas.Rectangle(Mil1+Po,Mil2,Mil1+Po+10,Mil2+8);
            Canvas.Pen.Color:=$005B9FE3;
            Canvas.Polygon([Point(Mil1+Po+1,Mil2+7),Point(Mil1+Po+9,Mil2+7),Point(Mil1+Po+9,Mil2+1),Point(Mil1+Po+9,Mil2+7)]);
            Canvas.Pen.Color:=$006CB6FF;
            Canvas.Polygon([Point(Mil1+Po+2,Mil2+6),Point(Mil1+Po+2,Mil2+2)]);
            Canvas.Polygon([Point(Mil1+Po+7,Mil2+6),Point(Mil1+Po+7,Mil2+2)]);
            Canvas.Rectangle(Mil1+Po+4,Mil2+2,Mil1+Po+6,Mil2+4);
            Canvas.Pen.Color:=clGray;
            Canvas.Brush.Color:=clGray;
//            Verrou
            if I+1>NbMotifPlein then
                Canvas.Polygon([Point(Mil1+Po+7,Mil2-1),Point(Mil1+Po+7,Mil2-2),Point(Mil1+Po+9,Mil2-4),Point(Mil1+Po+12,Mil2-4),
                    Point(Mil1+Po+14,Mil2-2),Point(Mil1+Po+14,Mil2+2),Point(Mil1+Po+13,Mil2+2),Point(Mil1+Po+13,Mil2-2),
                    Point(Mil1+Po+11,Mil2-3),Point(Mil1+Po+9,Mil2-3),Point(Mil1+Po+8,Mil2-1)])
            else
                Canvas.Polygon([Point(Mil1+Po+1,Mil2-1),Point(Mil1+Po+1,Mil2-2),Point(Mil1+Po+3,Mil2-4),Point(Mil1+Po+6,Mil2-4),
                    Point(Mil1+Po+8,Mil2-2),Point(Mil1+Po+8,Mil2-1),Point(Mil1+Po+7,Mil2-1),Point(Mil1+Po+7,Mil2-2),
                    Point(Mil1+Po+5,Mil2-3),Point(Mil1+Po+3,Mil2-3),Point(Mil1+Po+2,Mil2-1)]);
        end;
    end;
end;

Procedure TQGrid.DesCad(Stick, Active:Boolean; ACol, ARow: Longint);
var
    VRect   : TRect;
    Mil1    : Integer;
    Mil2    : Integer;
    Po      : Integer;
begin
    VRect:=CellRect(ACol,ARow);
    Po:=0;
    Mil1:=(VRect.Left+((VRect.Right-VRect.Left)div 2))-((1*16)div 2);
    Mil2:=(VRect.Top+((VRect.Bottom-VRect.Top)div 2))-3;
    Canvas.Brush.Style:=bsSolid;
    Canvas.Pen.Color:=$006CB6FF;
    Canvas.Brush.Color:=$000BE9F4;
    Canvas.Rectangle(Mil1+Po,Mil2,Mil1+Po+10,Mil2+8);
    Canvas.Pen.Color:=$005B9FE3;
    Canvas.Polygon([Point(Mil1+Po+1,Mil2+7),Point(Mil1+Po+9,Mil2+7),Point(Mil1+Po+9,Mil2+1),Point(Mil1+Po+9,Mil2+7)]);
    Canvas.Pen.Color:=$006CB6FF;
    Canvas.Polygon([Point(Mil1+Po+2,Mil2+6),Point(Mil1+Po+2,Mil2+2)]);
    Canvas.Polygon([Point(Mil1+Po+7,Mil2+6),Point(Mil1+Po+7,Mil2+2)]);
    Canvas.Rectangle(Mil1+Po+4,Mil2+2,Mil1+Po+6,Mil2+4);
    if Active then
    begin
        Canvas.Pen.Color:=clGray;
        Canvas.Brush.Color:=clGray;
    end
    else
    begin
        Canvas.Pen.Color:=clRed;
        Canvas.Brush.Color:=clRed;
    end;
//    Verrou
    if not Stick then
        Canvas.Polygon([Point(Mil1+Po+7,Mil2-1),Point(Mil1+Po+7,Mil2-2),Point(Mil1+Po+9,Mil2-4),Point(Mil1+Po+12,Mil2-4),
            Point(Mil1+Po+14,Mil2-2),Point(Mil1+Po+14,Mil2+2),Point(Mil1+Po+13,Mil2+2),Point(Mil1+Po+13,Mil2-2),
            Point(Mil1+Po+11,Mil2-3),Point(Mil1+Po+9,Mil2-3),Point(Mil1+Po+8,Mil2-1)])
    else
        Canvas.Polygon([Point(Mil1+Po+1,Mil2-1),Point(Mil1+Po+1,Mil2-2),Point(Mil1+Po+3,Mil2-4),Point(Mil1+Po+6,Mil2-4),
            Point(Mil1+Po+8,Mil2-2),Point(Mil1+Po+8,Mil2-1),Point(Mil1+Po+7,Mil2-1),Point(Mil1+Po+7,Mil2-2),
            Point(Mil1+Po+5,Mil2-3),Point(Mil1+Po+3,Mil2-3),Point(Mil1+Po+2,Mil2-1)]);
end;

function TQGrid.VerifChaineItems(Chaine:TStringList):Boolean;
var
    ValueBool   : Boolean;
begin
    case Chaine.Count of
        1 : begin
                Chaine.Add('0');
                Chaine.Add('True');
                Chaine.Add('True');
            end;
        2 : begin
                Chaine.Add('True');
                Chaine.Add('True');
            end;
        3 : begin
                Chaine.Add('True');
            end;
        else
            while Chaine.Count>4 do
                Chaine.Delete(Chaine.Count-1);
    end;
    Chaine.Strings[1]:=IntToStr(StrToIntDef(Chaine.Strings[1],0));
    if (Items.Count-1<StrToInt(Chaine.Strings[1]))and(Items.Count<>0)then
    begin
        Result:=False;
        exit;
    end;
    if not TryStrToBool(Chaine.Strings[2],ValueBool)then
        Chaine.Strings[2]:='False';
    if not TryStrToBool(Chaine.Strings[3],ValueBool)then
        Chaine.Strings[3]:='True';
    Result:=True;
end;

Procedure TQGrid.DesItems(Chaine:TStringList;ACol,ARow:Longint);
var
    VRect       : TRect;
    FRect       : TRect;
    FGBitmap1    : TBitmap;
    FGBitmap2   : TBitmap;
    FGBitmapF   : TBitmap;
    NItems      : Integer;
    Ratio       : Double;
    Ratio2      : Double;
    Coef        : Double;
    Coef2       : Double;
    ColorAr     : TColor;
    ColorArOp   : TColor;
begin
    if not VerifChaineItems(Chaine)then
    begin
        Cells[ACol,ARow]:='';
        exit;
    end;
    NItems:=StrToInt(Chaine.Strings[1]);
    VRect:=CellRect(ACol,ARow);
    FGBitmap1 := TBitmap.Create;
    FGBitmap2 := TBitmap.Create;
    FGBitmapF := TBitmap.Create;
    try
        ColorRow(ARow,ColorAr,ColorArOp);
        with FGBitmapF do
        begin
            Canvas.Brush.Color:=ColorAr;
            Canvas.Pen.Color:=ColorAr;
            Width:=VRect.Right-VRect.Left;
            Height:=VRect.Bottom-VRect.Top;
            Canvas.Rectangle(VRect);
        end;
        if (StrToBool(Chaine.Strings[3])) then
        begin
            FGBitmap2.Width := (Items[NItems].PictureTrue.Width);
            FGBitmap2.Height := (Items[NItems].PictureTrue.Height);
            FGBitmap2.Canvas.Draw(0, 0,Items[NItems].PictureTrue.Graphic);
        end
        else
        begin
            FGBitmap2.Width := (Items[NItems].PictureFalse.Width);
            FGBitmap2.Height := (Items[NItems].PictureFalse.Height);
            FGBitmap2.Canvas.Draw(0, 0,Items[NItems].PictureFalse.Graphic);
        end;

        if (FGBitmap2.Width > (VRect.Right-VRect.Left))or(FGBitmap2.Height > (VRect.Bottom-VRect.Top))  then
        begin
            Ratio   :=  FGBitmap2.Height / FGBitmap2.Width;
            Ratio2  :=  FGBitmap2.Width / FGBitmap2.Height;
            Coef    :=  FGBitmap2.Height / (VRect.Bottom-VRect.Top);
            Coef2   :=  FGBitmap2.Width / (VRect.Right-VRect.Left);
            if Coef2<Coef then
            begin
                FGBitmap1.Height := VRect.Bottom-VRect.Top;
                FGBitmap1.Width  := Round(FGBitmap1.Height * Ratio2);
            end
            else
            begin
                FGBitmap1.Width  := VRect.Right-VRect.Left;
                FGBitmap1.Height := Round(FGBitmap1.Width * Ratio);
            end;
            FGBitmap1.Canvas.StretchDraw(FGBitmap1.Canvas.ClipRect, FGBitmap2);
        end
        else
            FGBitmap1.Assign(FGBitmap2);

        if StrToBool(Chaine.Strings[2])then
        begin
            if (VRect.Right-VRect.Left) > FGBitmap1.Width then
            begin
                FRect:=VRect;
                VRect.Left  :=(FRect.Left+((FRect.Right-FRect.Left)div 2))-(FGBitmap1.Width div 2);
                VRect.Right :=(FRect.Right-((FRect.Right-FRect.Left)div 2))+(FGBitmap1.Width div 2);
            end;
            if (VRect.Bottom - VRect.Top) > FGBitmap1.Height then
            begin
                FRect:=VRect;
                VRect.Top := (FRect.Top+((FRect.Bottom-FRect.Top)div 2))-(FGBitmap1.Height div 2);
                VRect.Bottom := (FRect.Bottom-((FRect.Bottom-FRect.Top)div 2))+(FGBitmap1.Height div 2);
            end;
        end;
        FGBitmap1.IgnorePalette := true;        
        if Items[NItems].Transparent then
            case Items[NItems].PixelSource of
                spBottomRight : Canvas.BrushCopy(VRect, FGBitmap1, FGBitmap1.Canvas.ClipRect, FGBitmap1.Canvas.Pixels[FGBitmap1.Width-1,FGBitmap1.Height-1]);
                spBottomLeft  : Canvas.BrushCopy(VRect, FGBitmap1, FGBitmap1.Canvas.ClipRect, FGBitmap1.Canvas.Pixels[0,FGBitmap1.Height-1]);
                spTopRight    : Canvas.BrushCopy(VRect, FGBitmap1, FGBitmap1.Canvas.ClipRect, FGBitmap1.Canvas.Pixels[FGBitmap1.Width-1,0]);
                spTopLeft     : Canvas.BrushCopy(VRect, FGBitmap1, FGBitmap1.Canvas.ClipRect, FGBitmap1.Canvas.Pixels[0,0]);
            end
        else
        begin
            FGBitmapF.Canvas.Draw((FGBitmapF.Width div 2)-(FGBitmap1.Width div 2),
                (FGBitmapF.Height div 2)-(FGBitmap1.Height div 2),FGBitmap1);
            Canvas.CopyRect(CellRect(ACol,ARow),FGBitmapF.Canvas,FGBitmapF.Canvas.ClipRect);
        end;
    finally
        FGBitmap1.Free;
        FGBitmap2.Free;
        FGBitmapF.Free;
    end;
end;

Procedure TQGrid.VerifChaineButton(Chaine: TStringList);
begin
    ;
end;

Procedure TQGrid.DesButton(Chaine: TStringList; ACol: Longint; ARow: Longint);
var
    FGBitmap    : TBitmap;
    FGBitmap2   : TBitmap;
    VRect       : TRect;
    Test        : TBitmap;
    ColorAr     : TColor;
    ColorArOp   : TColor;
    test2        : String;
    crect:trect;
begin
    ColorRow(ARow,ColorAr,ColorArOp);
    FGBitmap := TBitmap.Create;
    FGBitmap2:= TBitmap.Create;
    try
        FGBitmap.PixelFormat:=pf24bit;
        VRect:=CellRect(ACol,ARow);
        Chaine.Add(Button.Items[StrToIntDef(TextReplace(Chaine.Strings[0],'TBUTTON',''),0)].Text);
        FGBitmap.Width:=VRect.Right-VRect.Left;
        FGBitmap.Height:=VRect.Bottom-VRect.Top;
//        Font du bouton
        BitmapGradient(FGBitmap,FGBitmap.Canvas.ClipRect,Button.Items[StrToIntDef(TextReplace(Chaine.Strings[0],'TBUTTON',''),0)].ColorFirst,
            Button.Items[StrToIntDef(TextReplace(Chaine.Strings[0],'TBUTTON',''),0)].ColorEnd,sgVertical,0);
//        Texte du bouton
        FGBitmap2.PixelFormat:=pf24bit;
        FGBitmap2.Canvas.Brush.Color:=ColorAr;
        FGBitmap2.Width:=FGBitmap.Width;
        FGBitmap2.Height:=FGBitmap.Height;
        FGBitmap2.Canvas.Font.Color:=Button.Items[StrToIntDef(TextReplace(Chaine.Strings[0],'TBUTTON',''),0)].ColorText;
        FGBitmap2.Canvas.TextRect(FGBitmap2.Canvas.ClipRect,
            (FGBitmap2.Width div 2)-((FGBitmap2.Canvas.TextWidth(Chaine.Strings[1]))div 2),
            (FGBitmap2.Height div 2)-((FGBitmap2.Canvas.TextHeight(Chaine.Strings[1]))div 2),
            Chaine.Strings[1]);
        FGBitmap2.TransparentColor:=ColorAr;
        FGBitmap2.Transparent:=True;
        FGBitmap.Canvas.Draw(0,0,FGBitmap2);
//        Tour du bouton
        FGBitmap2.Transparent:=False;
        FGBitmap2.Canvas.Pen.Color:=clBlack;
        FGBitmap2.Canvas.Brush.Color:=ColorArOp;//couleur dans rectangle
        FGBitmap2.Canvas.Brush.Style:=bsSolid;
        FGBitmap2.TransparentColor:=ColorArOp;
        FGBitmap2.Canvas.Pen.Width:=1;
        FGBitmap2.Canvas.RoundRect(2,2,FGBitmap.Width-2,FGBitmap.Height-2,6,6);
        FGBitmap2.Transparent:=True;
        FGBitmap.Canvas.Draw(0,0,FGBitmap2);
        Canvas.CopyRect(VRect,FGBitmap.Canvas,FGBitmap.Canvas.ClipRect);
    finally
        FGBitmap.Free;
        FGBitmap2.Free;
    end;
end;

Procedure TQGrid.TopLeftChanged;
var
    VCol    : Integer;
    VRow    : Integer;
    Dernier : Integer;
    Color1  : TColor;
    Color2  : TColor;
begin
    if(LeftCol+VisibleColCount<>FVisibleColCount)then
        for VCol := FVisibleColCount to LeftCol+VisibleColCount do
            InvalidateCol(VCol);
    if(TopRow+VisibleRowCount<>FVisibleRowCount)then
        for VRow := FVisibleRowCount to TopRow+VisibleRowCount do
            InvalidateRow(VRow);
    FVisibleColCount := LeftCol+VisibleColCount;
    FVisibleRowCount := TopRow+VisibleRowCount;
    inherited TopLeftChanged;
end;

procedure TQGrid.ColWidthsChanged;
begin
    inherited ColWidthsChanged;
    InvalidateCol(VisibleColCount+1);
end;

procedure TQGrid.RowHeightsChanged;
begin
    inherited RowHeightsChanged;
    InvalidateRow(VisibleRowCount+1);
end;

Procedure TQGrid.DrawCell2(Handle:THandle;ACol: Longint; ARow: Longint; ARect: TRect; AState: TGridDrawState);
var
    VRect   : TRect;
    PRect   : TRect;
    Chaine  : TStringList;
begin
    if FColCheckedVisible then
    begin
        if not(FindText(ACol, ARow))then
        begin
            DrawText(Handle,PChar(Cells[ACol,ARow]),-1,ARect,
                ConvPlacTextVert(FPlacTextVert)//DT_CENTER
                or DT_NOPREFIX or ConvPlacTextHorz(FPlacTextHorz)//DT_VCENTER
                or ConvPlacTextLigne(FPlacTextLigne))//DT_SINGLELINE
        end
        else
        begin
            PRect:=CellRect(ACol,ARow);
            VRect:=CheckBoxRect(CellRect(ACol,ARow));
            if (not(gdFixed in AState))then
            begin
                if(ColWidths[ACol]<=PRect.Right-PRect.Left)and(RowHeights[ARow]<=PRect.Bottom-PRect.Top)then
                begin
                    if (UpperCase(Cells[ACol,ARow])='TRUE') or (UpperCase(Cells[ACol,ARow])='GTRUE') then
                        DesCheck(True,True,False,ACol,ARow);
//                        DrawFrameControl(Handle, VRect, DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED);
                    if (UpperCase(Cells[ACol,ARow])='FALSE') or (UpperCase(Cells[ACol,ARow])='GFALSE') then
                        DesCheck(False,True,False,ACol,ARow);
//                        DrawFrameControl(Handle, VRect, DFC_BUTTON, DFCS_BUTTONCHECK);
                    if (UpperCase(Cells[ACol,ARow])='GGRAYED') then
                        DesCheck(True,True,True,ACol,ARow);
                    if (UpperCase(Cells[ACol,ARow])='VGGRAYED') then
                        DesCheck(True,False,True,ACol,ARow);
                    if (UpperCase(Cells[ACol,ARow])='VTRUE') or (UpperCase(Cells[ACol,ARow])='VGTRUE') then
                        DesCheck(True,False,False,ACol,ARow);
//                        DrawFrameControl(Handle, VRect, DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED or DFCS_INACTIVE);
                    if (UpperCase(Cells[ACol,ARow])='VFALSE') or (UpperCase(Cells[ACol,ARow])='VGFALSE') then
                        DesCheck(False,False,False,ACol,ARow);
//                        DrawFrameControl(Handle, VRect, DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_INACTIVE);
                    if UpperCase(Cells[ACol,ARow])='RTRUE' then
                        DrawFrameControl(Handle, VRect, DFC_BUTTON, DFCS_BUTTONRADIO or DFCS_CHECKED);
                    if UpperCase(Cells[ACol,ARow])='RFALSE' then
                        DrawFrameControl(Handle, VRect, DFC_BUTTON, DFCS_BUTTONRADIO);
                    if UpperCase(Cells[ACol,ARow])='VRTRUE' then
                        DrawFrameControl(Handle, VRect, DFC_BUTTON, DFCS_BUTTONRADIO or DFCS_CHECKED or DFCS_INACTIVE);
                    if UpperCase(Cells[ACol,ARow])='VRFALSE' then
                        DrawFrameControl(Handle, VRect, DFC_BUTTON, DFCS_BUTTONRADIO or DFCS_INACTIVE);
                    if Pos('TPROGBAR',UpperCase(Cells[ACol,ARow]))=1 then
                    begin
                        Chaine:=TStringList.Create;
                        try
                            ExtraireChaine(UpperCase(Cells[ACol,ARow]),Chaine,',');
                            DesProgBar(Chaine,ACol,ARow);
                        finally
                            Chaine.Free;
                        end;
                    end;
                    if (Pos('TMOTIF',UpperCase(Cells[ACol,ARow]))=1)or(Pos('VTMOTIF',UpperCase(Cells[ACol,ARow]))=1) then
                    begin
                        Chaine:=TStringList.Create;
                        try
                            ExtraireChaine(UpperCase(Cells[ACol,ARow]),Chaine,',');
                            DesMotif(Chaine,ACol,ARow);
                        finally
                            Chaine.Free;
                        end;
                    end;
                    if(UpperCase(Cells[ACol,ARow])='TCADTRUE')then
                        DesCad(True,True,ACol,ARow);
                    if(UpperCase(Cells[ACol,ARow])='VTCADTRUE')then
                        DesCad(True,False,ACol,ARow);
                    if(UpperCase(Cells[ACol,ARow])='TCADFALSE')then
                        DesCad(False,True,ACol,ARow);
                    if(UpperCase(Cells[ACol,ARow])='VTCADFALSE')  then
                        DesCad(False,False,ACol,ARow);
                    if(Pos('TITEMS',UpperCase(Cells[ACol,ARow]))=1)or(Pos('VTITEMS',UpperCase(Cells[ACol,ARow]))=1)then
                    begin
                        Chaine:=TStringList.Create;
                        try
                            ExtraireChaine(UpperCase(Cells[ACol,ARow]),Chaine,',');
                            DesItems(Chaine,ACol,ARow);
                        finally
                            Chaine.Free;
                        end;
                    end;
                    if(Pos('TBUTTON',UpperCase(Cells[ACol,ARow]))=1)or(Pos('VTBUTTON',UpperCase(Cells[ACol,ARow]))=1)then
                    begin
                        Chaine:=TStringList.Create;
                        try
                            ExtraireChaine(UpperCase(Cells[ACol,ARow]),Chaine,',');
                            DesButton(Chaine,ACol,ARow);
                        finally
                            Chaine.Free;
                        end;
                    end;
                end;
            end;
        end;
    end
    else
    begin
        DrawText(Handle,PChar(Cells[ACol,ARow]),-1,ARect,
            ConvPlacTextVert(FPlacTextVert)
            or DT_NOPREFIX or ConvPlacTextHorz(FPlacTextHorz)
            or ConvPlacTextLigne(FPlacTextLigne))
    end;
end;

procedure TQGrid.DrawCell(ACol, ARow: Longint; ARect: TRect;AState: TGridDrawState);
begin
//    inherited DrawCell(ACol,ARow,ARect,AState);
    if not LigColorVisible then
        exit;
    with Self as TQGrid do
    begin
        with Canvas do
        begin
            if ((Pos('TPROGBAR',UpperCase(Cells[ACol,ARow]))<>1)and
                (Pos('TITEMS',UpperCase(Cells[ACol,ARow]))<>1)and
                (Pos('VTITEMS',UpperCase(Cells[ACol,ARow]))<>1)and
                (Pos('TBUTTON',UpperCase(Cells[ACol,ARow]))<>1)and
                (Pos('VTBUTTON',UpperCase(Cells[ACol,ARow]))<>1))or
                ((VisibleRowCount+TopRow=ARow)or(VisibleColCount+LeftCol=ACol))then
            begin
                if gdFixed in AState then
                    Brush.Color := FixedColor
                else
                    if gdSelected in AState then
                    begin
                        if not FindText(ACol,ARow) then
                            Brush.Color := FColorSelection
                        else
                            if Odd(ARow)then
                                Brush.Color := FColorLigPaire
                            else
                                Brush.Color := FColorLigImpaire;
                    end
                    else
                        if Odd(ARow)then
                            Brush.Color := FColorLigPaire
                        else
                            Brush.Color := FColorLigImpaire;
                FillRect(ARect);
                if gdSelected in AState then
                    Font.Color:=clWhite
                else
                    Font.Color:=clBlack;
            end;
            if FColCheckedVisible then
            begin
                DrawCell2(Handle,ACol,ARow,ARect,AState);
            end
            else
            begin
                DrawText(Handle,PChar(Cells[ACol,ARow]),-1,ARect,
                    ConvPlacTextVert(FPlacTextVert)
                    or DT_NOPREFIX or ConvPlacTextHorz(FPlacTextHorz)
                    or ConvPlacTextLigne(FPlacTextLigne))
            end;
        end;
    end;
end;

end.

