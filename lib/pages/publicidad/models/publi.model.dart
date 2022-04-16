class PublicidadC{

  String recomendacion;
  String url;
  dynamic data;

  PublicidadC({
    required this.recomendacion,
    required this.url,
    required this.data
  });

  String getRecomendacion(){return recomendacion;}
  String getUrl(){return url;}

  factory PublicidadC.fromJson(Map<String, dynamic> item) {
    return PublicidadC(
      recomendacion: item['img_recomendaciones'],
      url: item['img_url'],
      data: item['img_data']
    );
  }
}
