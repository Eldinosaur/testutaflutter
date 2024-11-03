import 'dart:convert';

import 'package:testutaflutter/modelos/mo_alumnos.dart';
import 'package:testutaflutter/modelos/mo_lista_notas.dart';
import 'package:testutaflutter/modelos/mo_materias.dart';
import 'package:testutaflutter/modelos/mo_notas.dart';
import 'package:testutaflutter/utils/apis_general.dart';

class API_Procesamiento {

    /// Alumnos
    static Future<List<Modelo_Alumnos>> selectListaALumnosProcesamiento() async {
      var res = await API_CRUD_DB.selectAlumnos();
      Iterable list = json.decode(res.body);
      List<Modelo_Alumnos> list_Modelo_Alumnos = [];
      list_Modelo_Alumnos = list.map((model) => Modelo_Alumnos.fromObject(model)).toList();
      return list_Modelo_Alumnos;
    }

    /// ListaNotas
    static Future<List<Modelo_Lista_Notas>> selectListaNotasProcesamiento() async {
      var res = await API_CRUD_DB.selectListaNotas();
      Iterable list = json.decode(res.body);
      List<Modelo_Lista_Notas> list_Modelo_Lista_Notas = [];
      list_Modelo_Lista_Notas = list.map((model) => Modelo_Lista_Notas.fromObject(model)).toList();
      return list_Modelo_Lista_Notas;
    }

    /// Materias
    static Future<List<Modelo_Materias>> selectListaMateriaProcesamiento() async {
      var res = await API_CRUD_DB.selectMaterias();
      Iterable list = json.decode(res.body);
      List<Modelo_Materias> list_Modelo_Materias = [];
      list_Modelo_Materias = list.map((model) => Modelo_Materias.fromObject(model)).toList();
      return list_Modelo_Materias;
    }

    /// Notas
    static Future<List<Modelo_Notas>> selectNotasProcesamiento() async {
      var res = await API_CRUD_DB.selectNotas();
      Iterable list = json.decode(res.body);
      List<Modelo_Notas> list_Modelo_Notas = [];
      list_Modelo_Notas = list.map((model) => Modelo_Notas.fromObject(model)).toList();
      return list_Modelo_Notas;
    }

    static Future<List<Modelo_Notas>> selectNotasAlumnoProcesamiento(int id) async {
      var res = await API_CRUD_DB.selectNotasAlumno(id);
      Iterable list = json.decode(res.body);
      List<Modelo_Notas> list_Modelo_Notas = [];
      list_Modelo_Notas = list.map((model) => Modelo_Notas.fromObject(model)).toList();
      return list_Modelo_Notas;
    }





    static Future<String> insertNotasProcesamiento(Modelo_Notas entidad) async {
      var res = await API_CRUD_DB.insertNota(entidad);
      return res.body;
    }

    static Future<String> updateNotasProcesamiento(Modelo_Notas entidad) async {
      var res = await API_CRUD_DB.updateNota(entidad);
      return res.body;
    }

    static Future<String> deleteNotasProcesamiento(Modelo_Notas deleteInfo) async {
      var res = await API_CRUD_DB.deleteNota(deleteInfo);
      return res.body;
    }


}
