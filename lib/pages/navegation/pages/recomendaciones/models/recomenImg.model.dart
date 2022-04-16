class RecomendacionImgC{

  String recomendacion;
  String url;

  RecomendacionImgC({
    required this.recomendacion,
    required this.url
  });

  String getRecomendacion(){return recomendacion;}
  String getUrl(){return url;}

  factory RecomendacionImgC.fromJson(Map<String, dynamic> item) {
    return RecomendacionImgC(
      recomendacion: item['img_recomendaciones'],
      url: item['img_url'],
    );
  }
}
