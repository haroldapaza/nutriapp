class ObjetivoI {
  final String? url;
  final String? titulo;
  final String? texto;

  ObjetivoI({this.url, this.titulo, this.texto});

  getUrl(){
    return url;
  }
  getTitulo(){
    return titulo;
  }
  getTexto(){
    return texto;
  }
}