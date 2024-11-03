
import 'dart:convert';

import 'package:testutaflutter/modelos/mo_notas.dart';
import 'package:testutaflutter/utils/constantes.dart';
import 'package:http/http.dart' as http;

class API_CRUD_DB {

  ///// Alumnos
  //////select
  static Future selectAlumnos() async {
    String https = "/api/sistema/alumnos/lista";
    return await http.get(Uri.parse("$urlGeneral:$port$https"), headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });
  }


  ///// ListaNotas
  //////select
  static Future selectListaNotas() async {
    String https = "/api/sistema/lista/notas/lista_notas";
    return await http.get(Uri.parse("$urlGeneral:$port$https"), headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });
  }

  ///// Materias
  //////select
  static Future selectMaterias() async {
    String https = "/api/sistema/materias/lista";
    return await http.get(Uri.parse("$urlGeneral:$port$https"), headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });
  }


  ///// Notas
  //////select
  static Future selectNotas() async {
    String https = "/api/sistema/notas/lista";
    return await http.get(Uri.parse("$urlGeneral:$port$https"), headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });
  }

  static Future selectNotasAlumno(int id) async {
    String https = "/api/sistema/notas/lista_alumno?idAlumno=$id";
    return await http.get(Uri.parse("$urlGeneral:$port$https"), 
    headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    },);
  }

  


  ///insert
  static Future insertNota(Modelo_Notas notas) async {
    String https = "/api/sistema/notas/insert";
    return await http.post(Uri.parse("$urlGeneral:$port$https"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json",
          'Accept': '*/*'
        },
        body: json.encode(notas.toMap()));
  }  
  
  ///update
    static Future updateNota(Modelo_Notas notas) async {
    String https = "/api/sistema/notas/update";
    return await http.post(Uri.parse("$urlGeneral:$port$https"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
        body: json.encode(notas.toMap()));
  }

    ///delete
    static Future deleteNota(Modelo_Notas notas) async {
    String https = "/api/sistema/notas/delete";
    return await http.post(Uri.parse("$urlGeneral:$port$https"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
        body: json.encode(notas.toMap()));
  }


}