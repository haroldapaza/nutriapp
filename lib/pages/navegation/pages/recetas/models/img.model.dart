class ImgC{
  int id;
  int idReceta;
  String tipo;
  String name;
  String url;

  ImgC({
    required this.id,
    required this.idReceta,
    required this.tipo,
    required this.name,
    required this.url
  });

  int getId(){return id;}
  int getIdReceta(){return idReceta;}
  String getTipo(){return tipo;}
  String getName(){return name;}
  String getUrl(){return url;}

  factory ImgC.fromJson(Map<String, dynamic> item) {
    return ImgC(
      id: item['img_id'],
      idReceta: item['img_receta_id'],
      name: item['img_name'],
      tipo: item['img_type'],
      url: item['img_path'],
    );
  }
}