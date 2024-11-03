
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testutaflutter/UI/alumnos.dart';
import 'package:testutaflutter/modelos/mo_alumnos.dart';
import 'package:testutaflutter/modelos/mo_lista_notas.dart';
import 'package:testutaflutter/modelos/mo_materias.dart';
import 'package:testutaflutter/modelos/mo_notas.dart';
import 'package:testutaflutter/utils/action_general_buttons.dart';
import 'package:testutaflutter/utils/apis_procesamiento.dart';
import 'package:testutaflutter/utils/colors.dart';
import 'package:testutaflutter/utils/style.dart';

class ProfesorViewUI extends StatefulWidget {
  const ProfesorViewUI({super.key});
  @override
  State<StatefulWidget> createState() => _ProfesorState();
}

class _ProfesorState extends State<ProfesorViewUI> {

  List<Modelo_Lista_Notas> listModelo_Lista_Notas = [];
  List<Modelo_Alumnos> listModelo_Alumnos = [];
  List<Modelo_Materias> listModelo_Materias = [];

  List<Modelo_Notas> listModelo_Notas = [];
  bool activeForms = false;
  bool activeNewvalueLista = false;


  // recuperar listaNotas
    selectListaNotasProcesamiento()async {    
      listModelo_Lista_Notas = await API_Procesamiento.selectListaNotasProcesamiento();   
      setState(() {listModelo_Lista_Notas;});
    }

  // recuperar Alumnos
    selectListaALumnosProcesamiento()async {    
      listModelo_Alumnos = await API_Procesamiento.selectListaALumnosProcesamiento();   
      setState(() {listModelo_Alumnos;});
    }

  // recuperar Materia
    selectListaMateriaProcesamiento()async {    
      listModelo_Materias = await API_Procesamiento.selectListaMateriaProcesamiento();   
      setState(() {listModelo_Materias;});
    }

  // recuperar Notas
    selectNotasProcesamiento()async {    
      listModelo_Notas = await API_Procesamiento.selectNotasProcesamiento();   
      setState(() {listModelo_Notas;});
    }
   
    @override
    void initState() {
      super.initState();

      selectListaNotasProcesamiento();
      selectListaALumnosProcesamiento();
      selectListaMateriaProcesamiento();
      
      selectNotasProcesamiento();
    }

    TextEditingController calificacionController =  TextEditingController();
    Modelo_Notas modelNotasSelect = Modelo_Notas(-1,false,0, Modelo_Alumnos(-1, "", ""),Modelo_Materias(-1, "", ""),Modelo_Lista_Notas(-1,""));
    var snackBar;
    int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorUTA,//Theme.of(context).colorScheme.inversePrimary,
        title: Text("Sistema Flutter Ejemplo", style: TextStyle(color: colorWhite),),
      ),

      bottomNavigationBar: ConvexAppBar(
        backgroundColor: colorUTA,

        style: TabStyle.react,
        items: [
            TabItem(icon: Icon(Icons.list, size: ScreenUtil().setWidth(8),color: Colors.white,), title: 'Profesor'),
            TabItem(icon: Icon(Icons.list, size: ScreenUtil().setWidth(8),color: Colors.white,), title: 'Alumno'),
      ],
        initialActiveIndex: 0,
        onTap: (int i) {
          setState(() {
             _selectedIndex = i;          
          });
        } ,
      ),

      
      backgroundColor: Colors.white,
      body: 
      _selectedIndex == 0? Profesor(): const AlumnoViewUI()
      
    
    );
  }



  Widget Profesor (){
    return   Container(
        color: Colors.white,

        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[      

              Text("Profesor",style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(8.5) ),),

              const Padding(padding: EdgeInsets.all(3)),
              
              Text("Notas Alumnos",style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(8.0) ),),

              Padding(
                padding:  EdgeInsets.only(left: ScreenUtil().setHeight(3), right: ScreenUtil().setHeight(5)),
                 child: SizedBox(
                    height: ScreenUtil().setHeight(80),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      //physics: const ScrollPhysics(),
                      child:DataTable(
                          showCheckboxColumn: false,
                          columnSpacing: ScreenUtil().setWidth(7),
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Alumno',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Materia',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Nota',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Calificación',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Estado',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),

                          ],
                          rows: listModelo_Notas // Loops through dataColumnText, each iteration assigning the value to element
                                  .map(
                                    ((element) => DataRow(
                                          onSelectChanged: (value) {
                                            print("$value $element");
                                            setState(() { 

                                                modelNotasSelect = element;
                                                if(!activeForms){
                                                  activeForms = !activeForms;
                                                }

                                                activeNewvalueLista = false;

                                                selectInfo(modelNotasSelect);
                                            });
                                          },
                                          cells: <DataCell>[
                                            DataCell(Text(element.id_Alumnos.nombre.toString())), //Extracting from Map element the value
                                            DataCell(Text(element.id_Materia.nombre.toString())),
                                            DataCell(Text(element.id_Lista_Notas.nombre.toString())),
                                            DataCell(Text(element.calificacion.toString())),
                                             DataCell(Text(element.activo?"A":"D")),
                                          ],
                                        )),
                                  )
                                  .toList(),
                        ),
                  ),
                                 ),
               ),
             
              activeForms ? calificacionesForm() : const SizedBox(width: 0,height: 0),

              activeForms ?botonesCalificaciones() : const SizedBox(width: 0,height: 0),

              ActionButtonGeneral.buttonActionPais(!activeForms?"Nuevo":"Cancelar", (){
                      cleanInfoControllers();
                      activeForms = !activeForms;
                      print("Nuevo");
                      
                      },TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(6),
                                        fontWeight: FontWeight.bold)),

                


            ],
          ),
        ),
      );
  }

  Widget botonesCalificaciones(){
    return Column(children: [
      const Padding(padding: EdgeInsets.all(8)),
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    
                    children: [

                    ActionButtonGeneral.buttonActionPais("Guardar", (){
                      // guardar o actualizar información
                      Modelo_Notas modelNotas = modelNotasSelect;
                      
                      
                      
                      if(modelNotas.id!=-1){
                        // update

                        modelNotas.calificacion = double.parse(calificacionController.text);
                        modelNotas.id_Lista_Notas = _selectedModelo_Lista_Notas!;

                        updateInfo(modelNotas);
                          
                        snackBar = ActionButtonGeneral.showSnackBar("Datos Actualizados", "Actualizados");
                      }else{
                          modelNotas.id = 0;
                          if(calificacionController.text.isNotEmpty && _selectedModelo_Alumnos!=null
                           &&  _selectedModelo_Lista_Notas!=null && _selectedModelo_Materias!=null){
                              modelNotas.activo = true;
                              modelNotas.calificacion = double.parse(calificacionController.text);
                              
                              modelNotas.id_Alumnos = _selectedModelo_Alumnos!;
                              modelNotas.id_Lista_Notas = _selectedModelo_Lista_Notas!;
                              modelNotas.id_Materia = _selectedModelo_Materias!;

                              saveInfo(modelNotas);
    
                            snackBar = ActionButtonGeneral.showSnackBar("Datos Creados", "Nuevo Registro"); 

                          }else{
                             snackBar = ActionButtonGeneral.showSnackBar("Error\nseleccione los datos a guardar", "Error Registro"); 
                          }
                      }
                      cleanInfoControllers();
                      print("Guardar");
                          
                      
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(6),
                                        fontWeight: FontWeight.bold)),
                      
                      
                          
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1 / 3.5,
                    ),
                        
                    ActionButtonGeneral.buttonActionPais("Borrar", (){print("Borrar");
                      Modelo_Notas modelNotas = modelNotasSelect;
                    
                      if(modelNotas.id!=-1){
                        // update

                        modelNotas.activo = !modelNotas.activo;

                        borrarInfo(modelNotas);
                          
                        snackBar = ActionButtonGeneral.showSnackBar("Datos Borrados", "Borrar");
                      }
                      cleanInfoControllers();
                      print("Guardar");
                      
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    
                    },TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(6),
                                        fontWeight: FontWeight.bold)),
              
                  ],),
     
    ],);
  }

  Widget calificacionesForm(){
    return Column(children: [
                    const Padding(padding: EdgeInsets.all(8)),
              Text("Ingreso de Calificaciones",style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(8.0) ),),
              
              const Padding(padding: EdgeInsets.all(4)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Alumno',style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(6.0) )),
                      comboBoxModelo_Alumnos(listModelo_Alumnos),
                    ],
                  ),

                  const Padding(padding: EdgeInsets.all(4)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text('Materia',style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(6.0) )),
                      comboBoxModelo_Materias(listModelo_Materias),
                    ],
                  ),

                  const Padding(padding: EdgeInsets.all(4)),                  
                  Column(
                   // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nota',style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(6.0) )),
                      comboBoxModelo_Lista_Notas(listModelo_Lista_Notas),
                    ],
                  ),
                  
                  const Padding(padding: EdgeInsets.all(4)),
                  Column(
                    children: [
                      Text('Calificación',style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(6.0) )),
                     
                      SizedBox(
                        height: ScreenUtil().setHeight(11),
                        width: ScreenUtil().setWidth(30),
                        child: textFormGeneral(TextInputType.number, calificacionController,"0.0")),
                    ],
                  ),

                ],
              ),
               
               
    ],);
  }


  void updateInfo(Modelo_Notas modelSave)async {
    var ress = await API_Procesamiento.updateNotasProcesamiento(modelSave);
    if (ress.toString().contains("2")) {
          //showSnackBar("No se puede registrar datos duplicados", "Insertar");
          //ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        print("Update : $ress");

      selectListaNotasProcesamiento();
      
  }

  void saveInfo(Modelo_Notas modelSave)async {
    var ress = await API_Procesamiento.insertNotasProcesamiento(modelSave);
    if (ress.toString().contains("2")) {
          //showSnackBar("No se puede registrar datos duplicados", "Insertar");
          //ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        print("Insertar : $ress");

    selectNotasProcesamiento();        
  }

  void borrarInfo(Modelo_Notas modelSave)async {
    var ress = await API_Procesamiento.deleteNotasProcesamiento(modelSave);
    if (ress.toString().contains("2")) {
          //showSnackBar("No se puede registrar datos duplicados", "Insertar");
          //ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        print("Update : $ress");

      selectListaNotasProcesamiento();
      
  }



  Modelo_Lista_Notas? _selectedModelo_Lista_Notas;
  Modelo_Materias? _selectedModelo_Materias;
  Modelo_Alumnos? _selectedModelo_Alumnos;
 


  Widget comboBoxModelo_Lista_Notas(List<Modelo_Lista_Notas> modelo_Lista_Notas){

    Modelo_Lista_Notas valSel = 
    modelNotasSelect.id!=-1?modelo_Lista_Notas.firstWhere((element) =>element.id == modelNotasSelect.id_Lista_Notas.id):Modelo_Lista_Notas(-1,"");

    return DropdownButton<Modelo_Lista_Notas>(
            
            hint: _selectedModelo_Lista_Notas == null
                ? const Text('Nota')
                : Text(
                    _selectedModelo_Lista_Notas!.nombre,
                    style: const TextStyle(color: Colors.blue),
                  ),
            value: modelNotasSelect.id==-1 || activeNewvalueLista ?_selectedModelo_Lista_Notas : valSel,
            onChanged: (newValue) {
              setState(() {
                _selectedModelo_Lista_Notas = newValue!;
                if(valSel.id!=-1){
                  valSel.id != _selectedModelo_Lista_Notas!.id ? activeNewvalueLista=true:activeNewvalueLista=false;
                }
                print(activeNewvalueLista);
              });
            },
            items: modelo_Lista_Notas.map((modelo_Lista_N) {
              return DropdownMenuItem(
                child:  Text(modelo_Lista_N!.nombre),
                value: modelo_Lista_N,
              );
            }).toList()
          );
  }

  Widget comboBoxModelo_Materias(List<Modelo_Materias> modelo_materias){
    return IgnorePointer(
      ignoring:  modelNotasSelect.id==-1? false: true,
      child: DropdownButton<Modelo_Materias>(
              hint: _selectedModelo_Materias == null
                  ? const Text('Materia')
                  : Text(
                      _selectedModelo_Materias!.nombre,
                      style: const TextStyle(color: Colors.blue),
                    ),
              value: modelNotasSelect.id==-1?_selectedModelo_Materias : modelo_materias.firstWhere((element) =>element.id == modelNotasSelect.id_Materia.id),

              onChanged: (newValue) {
                setState(() {
                  _selectedModelo_Materias = newValue!;
                });
              },
              items: modelo_materias.map((modelo_M) {
                return DropdownMenuItem(
                  child:  Text(modelo_M!.nombre),
                  value: modelo_M,
                );
              }).toList()
            ),
    );
  }

  Widget comboBoxModelo_Alumnos(List<Modelo_Alumnos> modelo_alumnos){
    return IgnorePointer(
      ignoring:  modelNotasSelect.id==-1? false: true,
      child: DropdownButton<Modelo_Alumnos>(
              hint: _selectedModelo_Alumnos == null
                  ? const Text('Alumno')
                  : Text(
                      _selectedModelo_Alumnos!.nombre,
                      style: const TextStyle(color: Colors.blue),
                    ),
              value: 
                             modelNotasSelect.id==-1?_selectedModelo_Alumnos : modelo_alumnos.firstWhere((element) =>element.id == modelNotasSelect.id_Alumnos.id),

              
              
              onChanged: (newValue) {
                setState(() {
                  _selectedModelo_Alumnos = newValue!;
                });
              },
              items: modelo_alumnos.map((modelo_A) {
                return DropdownMenuItem(
                  child:  Text(modelo_A!.nombre),
                  value: modelo_A,
                );
              }).toList()
            ),
    );
  }


  Widget textFormGeneral(TextInputType textInputType, TextEditingController textEditingController, var label){
    return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              final number = double.tryParse(value) ?? 0;
                              if (number > 10) {
                                // Si el valor es mayor que 10, resetea el campo o maneja el error
                                // Puedes mostrar un mensaje de error o ajustar el valor aquí.
                                textEditingController.text = "0.0";
                              }
                            }
                          },
                          
                          keyboardType: textInputType,
                          controller: textEditingController,
                          
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}(\.\d{0,2})?$')),
                            FilteringTextInputFormatter.deny(',', replacementString: '.'),
                            //FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,2})')),
                          ],
                          decoration: InputDecoration(
                              
                              errorStyle: TextStyle(
                                  color: Colors.red[400],
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(6),
                                  height: 0),
                              contentPadding: EdgeInsets.only(left: ScreenUtil().setWidth(2) ,bottom: ScreenUtil().setWidth(4)),
                              hintText: '0.0',
                            ),
                          style: letterSizeColorWeight(
                              ScreenUtil().setSp(6),
                              Colors.black, FontWeight.bold),
                          
                          autocorrect: true,
                        ),
                      );
  }


selectInfo(Modelo_Notas modelNotas){
    setState(() {
      calificacionController.text = modelNotas.calificacion.toString();

      _selectedModelo_Lista_Notas= modelNotas.id_Lista_Notas;
      _selectedModelo_Materias= modelNotas.id_Materia;
      _selectedModelo_Alumnos= modelNotas.id_Alumnos; 
     print(_selectedModelo_Lista_Notas); 
    });
    
}

  void cleanInfoControllers(){
    setState(() {
      calificacionController.text = "";
      _selectedModelo_Lista_Notas= null;
      _selectedModelo_Materias= null;
      _selectedModelo_Alumnos= null;
      modelNotasSelect = Modelo_Notas(-1,false,0, Modelo_Alumnos(-1, "", ""),Modelo_Materias(-1, "", ""),Modelo_Lista_Notas(-1,""));

    });
  }


}