class RespuestaC{
  bool exito;
  dynamic respuesta;

  RespuestaC({
    required this.exito,
    this.respuesta
  });

  bool getExito() { return exito;}
  dynamic getMensaje(){return respuesta;}
}