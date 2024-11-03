import 'package:testutaflutter/modelos/mo_alumnos.dart';
import 'package:testutaflutter/modelos/mo_lista_notas.dart';
import 'package:testutaflutter/modelos/mo_materias.dart';

class Modelo_Notas {

  late int id;
  late bool activo;
  late double calificacion;
  late Modelo_Alumnos id_Alumnos;  
  late Modelo_Materias id_Materia;
  late Modelo_Lista_Notas id_Lista_Notas;  

  Modelo_Notas(this.id,
            this.activo,
            this.calificacion,
            this.id_Alumnos ,
            this.id_Materia ,
            this.id_Lista_Notas
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = id;
    map["activo"] = activo;
    map["calificacion"] = calificacion;
    map["iD_ALUMNOS"] = id_Alumnos.id;
    map["iD_MATERIA"] = id_Materia.id;
    map["iD_LISTA_NOTAS"] = id_Lista_Notas.id;
    return map;
  }

  Modelo_Notas.fromObject(dynamic notas) {
    id = notas["id"];
    activo = notas["activo"];
    calificacion = notas["calificacion"];
    id_Alumnos = Modelo_Alumnos.fromObject(notas["alumnos"]) ; //notas["iD_ALUMNOS"]
    id_Materia = Modelo_Materias.fromObject(notas["materias"]) ; //notas["iD_MATERIA"]
    id_Lista_Notas = Modelo_Lista_Notas.fromObject(notas["notas"]) ; //notas["iD_LISTA_NOTAS"]
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'activo': activo,
        'calificacion': calificacion,
        'iD_ALUMNOS': id_Alumnos,
        'iD_MATERIA': id_Materia,
        'iD_LISTA_NOTAS': id_Lista_Notas,
  };

}