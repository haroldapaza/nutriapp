
class UsuarioInfo{
  String? dato;
  String? respuesta;

  UsuarioInfo({this.dato,this.respuesta});

  String? get datoG => dato;
  set datoS(String dato) {
    dato = dato;
  }

  String? get respuestaG => respuesta;
  set respuestaS(String respuesta) {
    respuesta = respuesta;
  }
}