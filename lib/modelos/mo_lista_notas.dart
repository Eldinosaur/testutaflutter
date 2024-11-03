class Modelo_Lista_Notas {

  late int id;
  late String nombre;  

  Modelo_Lista_Notas(this.id,
            this.nombre
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = id;
    map["nombre"] = nombre;
    return map;
  }

  Modelo_Lista_Notas.fromObject(dynamic listNotas) {
    id = listNotas["id"];
    nombre = listNotas["nombre"];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre
  };

}
