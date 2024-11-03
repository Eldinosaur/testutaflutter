import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testutaflutter/modelos/mo_alumnos.dart';
import 'package:testutaflutter/modelos/mo_lista_notas.dart';
import 'package:testutaflutter/modelos/mo_materias.dart';
import 'package:testutaflutter/modelos/mo_notas.dart';
import 'package:testutaflutter/utils/apis_procesamiento.dart';

class AlumnoViewUI extends StatefulWidget {
  const AlumnoViewUI({super.key});
  @override
  State<StatefulWidget> createState() => _ProfesorState();
}

class _ProfesorState extends State<AlumnoViewUI> {

  List<Modelo_Alumnos> listModelo_Alumnos = [];

  List<Modelo_Notas> listModelo_Notas = [];


  // recuperar Alumnos
    selectListaALumnosProcesamiento()async {    
      listModelo_Alumnos = await API_Procesamiento.selectListaALumnosProcesamiento();   
      setState(() {listModelo_Alumnos;});
    }

  // recuperar Notas
    selectNotasProcesamiento(int id)async {    
      listModelo_Notas = await API_Procesamiento.selectNotasAlumnoProcesamiento(id);   
      setState(() {listModelo_Notas;});
    }
   
    @override
    void initState() {
      super.initState();

      selectListaALumnosProcesamiento();
      
      
    }

    TextEditingController calificacionController =  TextEditingController();
    Modelo_Notas modelNotasSelect = Modelo_Notas(-1,false,0, Modelo_Alumnos(-1, "", ""),Modelo_Materias(-1, "", ""),Modelo_Lista_Notas(-1,""));
    var snackBar;
    
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
     
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,

        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[      

              Text("Alumnos",style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(8.0) ),),

              comboBoxModelo_Alumnos(listModelo_Alumnos),


              const Padding(padding: EdgeInsets.all(3)),
              
              Text("Notas",style: TextStyle(fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(8.0) ),),

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


                          ],
                          rows: listModelo_Notas // Loops through dataColumnText, each iteration assigning the value to element
                                  .map(
                                    ((element) => DataRow(
                                          cells: <DataCell>[
                                            DataCell(Text(element.id_Alumnos.nombre.toString())), //Extracting from Map element the value
                                            DataCell(Text(element.id_Materia.nombre.toString())),
                                            DataCell(Text(element.id_Lista_Notas.nombre.toString())),
                                            DataCell(Text(element.calificacion.toString())),
                                          ],
                                        )),
                                  )
                                  .toList(),
                        ),
                  ),
                                 ),
               ),
             

            ],
          ),
        ),
      ),
    );
  }




  Modelo_Alumnos? _selectedModelo_Alumnos;
 



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
              value: _selectedModelo_Alumnos,
                             
              
              
              onChanged: (newValue) {
                setState(() {
                  _selectedModelo_Alumnos = newValue!;

                  selectNotasProcesamiento(_selectedModelo_Alumnos!.id);
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



}