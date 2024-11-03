class Modelo_Materias {

  late int id;
  late String nombre;  
  late String descripcion;  

  Modelo_Materias(this.id,
            this.nombre,
            this.descripcion
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = id;
    map["nombre"] = nombre;
    map["descripcion"] = descripcion;
    return map;
  }

  Modelo_Materias.fromObject(dynamic materias) {
    id = materias["id"];
    nombre = materias["nombre"];
    descripcion = materias["descripcion"];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'descripcion': descripcion
  };

}
