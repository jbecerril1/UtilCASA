unit UFrm_BaseVer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, DB, ExtCtrls, StdCtrls, DBCtrls, TCGradientLabel;

type
  TFrmEdicionVer = class(TFrame)
    Splitter1: TSplitter;
    dsDatos: TDataSource;
    Panel1: TPanel;
    gridDatos: TDBGrid;
    Panel2: TPanel;
    Lb_titulo: TGradient;
    procedure FrameEnter(Sender: TObject);
    procedure FrameExit(Sender: TObject);
    procedure gridDatosEnter(Sender: TObject);
    procedure gridDatosDblClick(Sender: TObject);

  private
     FPnl_Edit: TPanel;
    FlistaCampos: TStringList;
    FcanEditar: Boolean;
    function sonValidos(FObliga: TStringList; var Mensaje: String;
      DataSet: TDataSet): Boolean;
    procedure SetlistaCampos(const Value: TStringList);
    procedure antesDeSalirPanel(Sender: TObject);
    procedure SetCanEditar(const Value: Boolean);
    { Private declarations }
  protected
   procedure PanelActivo;

   //Regresa  un valor dependiendo si el WinControl Tiene ono controles internos
   function TieneCtrol(AControl: TWinControl): Boolean;
   //Devuelve el primer WinControl quie puede tomar el foco dentro del Wincontrol indicado
   function CtrolFoco(AControl: TWinControl):TWinControl;

  public
    { Public declarations }
    //funcion que se ejecuta antes de salir del panel y es implementada por el usuario
    funcionUsuario: function : boolean of object; //TFuncionUser;
    procedure asignaPanel(panel :TPanel);
   //Esta funcion edita un registro
    procedure Edicion;
   //Esta funcion genera un nuevo registro
    procedure nuevo;
   //Esta funcion elimina un registro
    procedure Eliminar;
   //Esta funcion verifica que los campos con los nombre que reciba
   //en la lista de cadenas sean diferentes de null y unicamente regresa
   //si estan todos los campos llenos o alguno no lo esta
     Function hayCamposNulos(listaCampos :TStringList) : bool ;
   //Esta funcion verifica que los campos con los nombre que reciba
   //en la lista de cadenas sean diferentes de null y regresa
   //el DispalLabel del primer campo que no encuentre
     Function camposNulos(listaCampos :TStringList) : String ;
   //Esta funcion edita un registro
    procedure Guarda;
   //Esta funcion genera un nuevo registro
    procedure Cancelar;
     //Deshabilita el Frame y cambia de color el titulo y los label del panel asignados
    procedure Habilita(Edo: Boolean);
    // Pregunta para saber cancelar o guardar
    procedure Termina;
   
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy; override;

    published
    property listaCampos :TStringList read FlistaCampos write SetlistaCampos;
    property CanEditar: Boolean read FcanEditar write SetCanEditar default true;


    end;

implementation

{$R *.dfm}

{ TFrame2 }

procedure TFrmEdicionVer.asignaPanel(panel: TPanel);
begin
  FPnl_Edit:=panel;
  FPnl_Edit.Parent:=self;
  FPnl_Edit.Align:=alClient;
  FPnl_Edit.Enabled:=false;
  FPnl_Edit.TabOrder:=0;
  gridDatos.TabOrder:=1;
  FPnl_Edit.OnExit:= antesDeSalirPanel;

end;


procedure TFrmEdicionVer.nuevo;
var
temp:String;
begin
if  gridDatos.Focused then
begin
 try
  if Assigned(dsDatos.DataSet) then
    begin
     panelActivo;
     dsDatos.DataSet.Append;
    end
  else
   Application.MessageBox('No se pudo insertar el registro','Mensajes de la aplicación',MB_OK);

 except on E: Exception do
    begin
     temp:='No se pudo insertar el registro '+#10#13+E.Message;
     Application.MessageBox(pwidechar(temp),'Mensajes de la aplicatión',MB_OK);
    end;
   end;
 end;
end;

procedure TFrmEdicionVer.Edicion;
var
temp:String;
begin
if gridDatos.Focused then
begin
try
  if Assigned(dsDatos.DataSet) then
   begin
    if dsDatos.DataSet.State <> dsEdit then
     begin
      panelActivo;
      dsDatos.DataSet.Edit;
     end;
   end
  else
   Application.MessageBox('No se tiene asignado un dataset','Mensajes de la aplicatión',MB_OK);

 except on E: Exception
    do
    begin
     temp:='No se pudo Editar el registro '+#10#13+E.Message;
     Application.MessageBox(pwidechar(temp),'Mensajes de la aplicatión',MB_OK);
    end;
  end;
 end;
end;

procedure TFrmEdicionVer.Eliminar;
var
temp:String;
begin
if gridDatos.Focused then
begin
 try
  if Assigned(dsDatos.DataSet) then
    begin
     if not dsDatos.DataSet.IsEmpty
     then begin
            if Application.MessageBox('¿Desea realmente eliminar el registro?','Eliminar registro',MB_YESNO) = IDYES  then
            dsDatos.DataSet.Delete;
          end;
    end
  else
   Application.MessageBox('No se tiene un dataset asignado','Mensajes de la aplicatión',MB_OK);
 except on E: Exception
    do
    begin
     temp:='No se pudo eliminar el registro '+#10#13+E.Message;
     Application.MessageBox(pwidechar(temp),'Mensajes de la aplicatión',MB_OK);
    end;
  end;
 end;
end;


procedure TFrmEdicionVer.FrameEnter(Sender: TObject);
begin
    Lb_titulo.Color:=clActiveCaption;
    Lb_titulo.ColorTo := clMenuHighlight;
    Lb_titulo.Font.Color:=clWindow;
    Lb_titulo.Font.Style := [fsBold];
    gridDatos.SetFocus;
    {cambio para modificar tono de color}

    griddatos.Color:=  clwindow;
    //griddatos.FixedColor:= clwindow;
    griddatos.Options:= [dgtitles,dgColumnResize,
                            dgConfirmDelete, dgCancelonExit, dgColLines,dgRowLines];
    //FPnl_Edit.Color:=  cl3dLight;

end;

procedure TFrmEdicionVer.FrameExit(Sender: TObject);
begin
  if (dsDatos.DataSet.State= dsEdit) or (dsDatos.DataSet.State= dsInsert) then
    dsDatos.DataSet.Post;
  Lb_titulo.Color:=clBtnFace;
  Lb_titulo.ColorTo:=clInactiveCaption;
  Lb_titulo.Font.Color:=clWindowText;
  Lb_titulo.Font.Style := [];
  Lb_titulo.Repaint;
  griddatos.Color:=  clBtnFace;
  //griddatos.FixedColor:=  clBtnFace;
  griddatos.Options:= [dgtitles,dgColumnResize,
                            dgConfirmDelete, dgCancelonExit];
  //FPnl_Edit.Color:=  clBtnFace;
   {cambio para modificar tono de color}
end;

procedure TFrmEdicionVer.gridDatosEnter(Sender: TObject);
begin
FPnl_Edit.Enabled:=false;
end;
//************************************************************************
function TFrmEdicionVer.hayCamposNulos(listaCampos: TStringList): bool;
var
i:integer;
campo: TField;
begin
result:=true;
for i := 0  to listaCampos.Count-1 do
begin
 campo:= dsDatos.DataSet.FindField(listaCampos.Strings[i]);
 if  campo <> nil then
  begin
    if campo.IsNull then
     begin
      result:=false;
      break;
     end;
  end;
 end;
end;

//************************************************************************
function TFrmEdicionVer.camposNulos(listaCampos: TStringList): String;
var
i:integer;
campo: TField;
begin
  result:='';
  for i := 0  to listaCampos.Count-1 do
   begin
    campo:= dsDatos.DataSet.FindField(listaCampos.Strings[i]);
    if  campo <> nil then
     begin
      if campo.IsNull then
       begin
        result:=campo.DisplayLabel;
        break;
       end;
     end;
   end;
end;

procedure TFrmEdicionVer.Cancelar;
begin
  if Assigned(dsDatos.DataSet) then
   begin
     if (dsDatos.DataSet.State= dsEdit) or (dsDatos.DataSet.State= dsInsert) then
       begin
        dsDatos.DataSet.Cancel;
        gridDatos.SetFocus;
       end;

   end;
 end;

procedure TFrmEdicionVer.Guarda;
var
 mensaje:String;
 CtrolTmp:TWinControl;
 seSale:boolean;
begin
  if Assigned(dsDatos.DataSet) then
   begin
    if (FlistaCampos.Count > 0) then
     begin
          if sonValidos(FlistaCampos,mensaje,dsDatos.DataSet) then
           begin
             sesale:=true;
             if assigned (funcionUsuario) then
                seSale:=funcionUsuario;
             if seSale then
               begin
                 if (dsDatos.DataSet.State= dsEdit) or (dsDatos.DataSet.State= dsInsert) then
                   begin
                     try
                       dsDatos.DataSet.Post;
                       gridDatos.SetFocus;
                     except
                        on e: exception do
                        begin
                           if (AnsiPos('UNIQUE KEY',uppercase(e.message))>0) or (AnsiPos('PRIMARY KEY',uppercase(e.message))>0)
                           then begin
                                  Mensaje:= 'El registro ya fue ingresado';
                               end
                           else begin
                               Mensaje:= 'Excepcion inesperada '+ e.Message;
                              end;
                        Application.MessageBox(pwidechar(Mensaje),'A V I S O',MB_ICONWARNING+MB_OK);
                        dsDatos.DataSet.Edit;
                        CtrolTmp:= CtrolFoco(FPnl_Edit);
                        if Ctroltmp <> nil
                        then
                            Ctroltmp.SetFocus;
                        end;
                     end;
                   end;
               end;
           end
          else
           begin
            Application.MessageBox(pwidechar(mensaje),
               'A V I S O ', MB_ICONWARNING+ MB_OK);
             CtrolFoco(FPnl_Edit).SetFocus;
           end;
     end
   else
    begin
        if (dsDatos.DataSet.State= dsEdit) or (dsDatos.DataSet.State= dsInsert) then
         begin
           try
             sesale:=true;
             if assigned (funcionUsuario) then
                seSale:=funcionUsuario;
             if seSale then
               begin
                 dsDatos.DataSet.Post;
                 gridDatos.SetFocus;
               end;  
           except
              on e: exception do
              begin
                 if (AnsiPos('UNIQUE KEY',uppercase(e.message))>0) or (AnsiPos('PRIMARY KEY',uppercase(e.message))>0)
                 then begin
                        Mensaje:= 'El registro ya fue ingresado';
                     end
                 else begin
                     Mensaje:= 'Excepcion inesperada '+ e.Message;
                    end;
              Application.MessageBox(pwidechar(Mensaje),'A V I S O',MB_ICONWARNING+MB_OK);
              dsDatos.DataSet.Edit;
              CtrolTmp:= CtrolFoco(FPnl_Edit);
              if Ctroltmp <> nil
              then
                  Ctroltmp.SetFocus;
              end;
           end;
         end;
    end;
   end;
end;


procedure TFrmEdicionVer.panelActivo;
var
ctrolTmp: TWinControl;

begin
  FPnl_Edit.Enabled:=true;
 try
    ctroltmp:= CtrolFoco(FPnl_Edit);
    ctroltmp.SetFocus;
 except
    Application.MessageBox('No es posible realizar la acción','A V I S O',MB_ICONWARNING+MB_OK);
 end;
end;

procedure TFrmEdicionVer.Habilita(Edo: Boolean);
var
cont: integer;
begin
  Enabled:= Edo;

  if Edo
  then begin
         Lb_titulo.Color:= clBtnFace;
         if FPnl_Edit<> nil
         then  begin
                  with FPnl_Edit
                  do begin
                        for cont:=0 to ControlCount-1
                        do begin
                              if Controls[cont] is TLabel
                              then
                                   (Controls[cont] as TLabel).Font.Color:= clBtnText;
                           end;
                     end;
               end;
       end
  else begin
         Lb_titulo.Color:= clBtnShadow;
         if FPnl_Edit<> nil
         then  begin
                  with FPnl_Edit
                  do begin
                        for cont:=0 to ControlCount-1
                        do begin
                              if Controls[cont] is TLabel
                              then
                                   (Controls[cont] as TLabel).Font.Color:= clBtnShadow;
                           end;
                     end;
               end;
       end;

end;
{-----------------------------------------------------------------------------}

function TFrmEdicionVer.TieneCtrol(AControl: TWinControl): Boolean;
begin
   result:= Acontrol.ControlCount> 0
end;

{-----------------------------------------------------------------------------}
function TFrmEdicionVer.CtrolFoco(AControl: TWinControl):TWinControl;
var
Ctroltmp: TWinControl;
CtrolInt: TWinControl;
contC: Integer;
tabtmp: Integer;
band: boolean;
begin
    tabtmp:= 0;
    Ctroltmp:= nil;
    band:= true;

    while band
    do begin
        CtrolInt:= nil;
        for contc:=0 to Acontrol.ControlCount-1
        do begin
             if (Acontrol.Controls[contc] is TWinControl)
             then begin
                     if (Acontrol.Controls[contc] as TWinControl).TabOrder= tabtmp
                     then begin
                            CtrolInt:= TWinControl(Acontrol.Controls[contc]);
                            break;
                          end;
                  end;
           end;

        if CtrolInt <> nil
        then begin
                if (CtrolInt.TabStop)  and
                   (CtrolInt.CanFocus)
                then begin
                       Ctroltmp:= CtrolInt;
                       //condicion de salida
                       break;
                     end
                else begin
                       if (TieneCtrol(CtrolInt)) and
                          (CtrolInt.CanFocus)
                       then begin
                               //Concurrecia controlada
                               CtrolTmp:= CtrolFoco(CtrolInt);

                               if Ctroltmp <> nil
                               then begin
                                      // salir del ciclo control encontrado
                                      break;
                                    end
                            end
                     end;
                inc(tabtmp);
             end
        else
            band:= false;
        end;

    result:= Ctroltmp;
end;

function TFrmEdicionVer.sonValidos(FObliga:TStringList;var Mensaje:String;DataSet:TDataSet): Boolean;
var
cont: integer;
temp: boolean;
begin
   temp:= true;
   Mensaje:='';
   if FObliga.Count>0
   then begin
         for cont:=0 to  FObliga.Count-1
         do begin
               if (DataSet.FieldbyName(FObliga.Names[cont]).IsNull) or
                  (length(DataSet.FieldbyName(FObliga.Names[cont]).AsString) <= 0)
               then begin
                    Mensaje:= Mensaje+ 'El campo '+ FObliga.Values[FObliga.Names[cont]]
                                     + ' esta vacio'+ #10#13;
                    temp:= false;
                    end;
            end;
     end;
    result:= temp;  
end;

procedure TFrmEdicionVer.SetlistaCampos(const Value: TStringList);
begin
  FlistaCampos := Value;
end;

procedure TFrmEdicionVer.antesDeSalirPanel(Sender: TObject);
var
 mensaje:String;
 CtrolTmp:TWinControl;
 seSale:boolean;
begin
  if Assigned(dsDatos.DataSet) then
   begin
    if (FlistaCampos.Count > 0)
       and (dsDatos.DataSet.State<> dsBrowse)
    then begin
          if sonValidos(FlistaCampos,mensaje,dsDatos.DataSet) then
           begin
            sesale:=true;
            if assigned (funcionUsuario) then
                seSale:=funcionUsuario;
            if seSale then
             begin
               if (dsDatos.DataSet.State= dsEdit) or (dsDatos.DataSet.State= dsInsert) then
                begin
                  try
                     dsDatos.DataSet.Post;
                   except
                        on e: exception do
                        begin
                           if (AnsiPos('UNIQUE KEY',uppercase(e.message))>0) or (AnsiPos('PRIMARY KEY',uppercase(e.message))>0)
                           then begin
                                  Mensaje:= 'El registro ya fue ingresado';
                               end
                           else begin
                               Mensaje:= 'Excepcion inesperada '+ e.Message;
                              end;
                        Application.MessageBox(pwidechar(Mensaje),'A V I S O',MB_ICONWARNING+MB_OK);
                        dsDatos.DataSet.Edit;
                        CtrolTmp:= CtrolFoco(FPnl_Edit);
                        if Ctroltmp <> nil
                        then
                            Ctroltmp.SetFocus;
                        end;
                  end;
                end;
             end;
           end
         else
           begin
            Application.MessageBox(pwidechar(mensaje),
               'A V I S O ', MB_ICONWARNING+ MB_OK);
             if dsDatos.DataSet.State in [dsEdit,dsInsert]
             then
                 CtrolFoco(FPnl_Edit).SetFocus;
           end;
     end
   else
    begin
       if (dsDatos.DataSet.State= dsEdit) or (dsDatos.DataSet.State= dsInsert) then
              begin
                try
                sesale:=true;
                if assigned (funcionUsuario) then
                    seSale:=funcionUsuario;
                if seSale then
                   dsDatos.DataSet.Post;
                 except
                      on e: exception do
                      begin
                         if (AnsiPos('UNIQUE KEY',uppercase(e.message))>0) or (AnsiPos('PRIMARY KEY',uppercase(e.message))>0)
                         then begin
                                Mensaje:= 'El registro ya fue ingresado';
                             end
                         else begin
                             Mensaje:= 'Excepcion inesperada '+ e.Message;
                            end;
                      Application.MessageBox(pwidechar(Mensaje),'A V I S O',MB_ICONWARNING+MB_OK);
                      dsDatos.DataSet.Edit;
                      CtrolTmp:= CtrolFoco(FPnl_Edit);
                      if Ctroltmp <> nil
                      then
                          Ctroltmp.SetFocus;
                      end;
                end;
             end;
    end;
   end;
end;

constructor TFrmEdicionVer.Create(AOwner: TComponent);
begin
  inherited;
     listaCampos:= TStringList.Create;
     CanEditar:= true;
end;

destructor TFrmEdicionVer.Destroy;
begin
    listaCampos.free;
  inherited;
end;

procedure TFrmEdicionVer.Termina;
var
Mensaje: String;
res: integer;
begin
   Mensaje:= '¿Desea guardar la información de esta sección?';
   res:=  Application.MessageBox(pwidechar(Mensaje),'A V I S O', MB_ICONQUESTION+ MB_YESNOCANCEL);
   if res = 6
   then begin
          Guarda;
        end;
   if res = 7
   then begin
          Cancelar;
        end;

end;

procedure TFrmEdicionVer.gridDatosDblClick(Sender: TObject);
begin
   if not((dsDatos.DataSet.IsEmpty) or
          not (CanEditar))
   then
       Edicion;
end;

procedure TFrmEdicionVer.SetCanEditar(const Value: Boolean);
begin
  FcanEditar := Value;
end;

end.
