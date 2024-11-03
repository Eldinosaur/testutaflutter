class Modelo_Alumnos {

  late int id;
  late String ci;
  late String nombre;  

  Modelo_Alumnos(this.id,
            this.ci,
            this.nombre
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = id;
    map["ci"] = ci;
    map["nombre"] = nombre;
    return map;
  }

  Modelo_Alumnos.fromObject(dynamic alumnos) {
    id = alumnos["id"];
    ci = alumnos["ci"];
    nombre = alumnos["nombre"];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'ci': ci,
        'nombre': nombre
  };

}
