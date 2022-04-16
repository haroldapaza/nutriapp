class MacrosItemC{
  String? titulo;
  String? imagen;
  int? color;
  double? calorias;
  double? gramos;

  MacrosItemC({this.titulo,this.imagen,this.color,this.calorias,this.gramos});
  
  String? get tituloG => titulo;
  set tituloS(String? titulo) {
    titulo = titulo;
  }
  String? get imagenG => imagen;
  set imagenS(String? imagen) {
    imagen = imagen;
  }
  int? get colorG => color;
  set colorS(int? color) {
    color = color;
  }
  double? get caloriasG => calorias;
  set caloriasS(double calorias) {
    calorias = calorias;
  }
  double? get gramosG => gramos;
  set gramosS(double gramos) {
    gramos = gramos;
  }
}