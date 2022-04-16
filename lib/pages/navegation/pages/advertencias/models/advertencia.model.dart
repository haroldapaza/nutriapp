class AdvertenciaC{
  String titulo;
  String text;
  List<String> advertencias;
 

  AdvertenciaC({
    required this.titulo,
    required this.text,
    required this.advertencias,
  });

  // factory AdvertenciaC.fromJson(Map<String, dynamic> item) {
  //   return AdvertenciaC(
  //     planId: item['plan_id'] as int,
  //     planIdPerson: item['plan_id_person'] as int,
  //     fecha: item['plan_fecha'] as String,
  //     comida: item['plan_comida'] as String,
  //     alimentoReceta: item['plan_alimento_receta'] as String,
  //     gramos: item['plan_gramos'] as dynamic,
  //     cantidad: item['plan_cantidad'] as int,
  //     unidad: item['plan_unidad'] as String,
  //     kcal: item['plan_kcal'] as dynamic,
  //     protein: item['plan_protein'] as dynamic,
  //     carbs: item['plan_carbs'] as dynamic,
  //     fats: item['plan_fats'] as dynamic,
  //     created: item['plan_created'] as String,
  //   );
  // }
}