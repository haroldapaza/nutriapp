
class PlanC{
  int planId;
  int planIdPerson;
  String fecha;
  String comida;
  String alimentoReceta;
  dynamic gramos;
  int cantidad;
  String unidad;
  dynamic kcal;
  dynamic protein;
  dynamic carbs;
  dynamic fats;
  String created; 

  PlanC({
    required this.planId,
    required this.planIdPerson,
    required this.fecha,
    required this.comida,
    required this.alimentoReceta,
    required this.gramos,
    required this.cantidad,
    required this.unidad,
    required this.kcal,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.created
  });

  factory PlanC.fromJson(Map<String, dynamic> item) {
    return PlanC(
      planId: item['plan_id'] as int,
      planIdPerson: item['plan_id_person'] as int,
      fecha: item['plan_fecha'] as String,
      comida: item['plan_comida'] as String,
      alimentoReceta: item['plan_alimento_receta'] as String,
      gramos: item['plan_gramos'] as dynamic,
      cantidad: item['plan_cantidad'] as int,
      unidad: item['plan_unidad'] as String,
      kcal: item['plan_kcal'] as dynamic,
      protein: item['plan_protein'] as dynamic,
      carbs: item['plan_carbs'] as dynamic,
      fats: item['plan_fats'] as dynamic,
      created: item['plan_created'] as String,
    );
  }
}