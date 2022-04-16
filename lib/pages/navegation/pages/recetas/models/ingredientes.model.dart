

import 'nutrientes.model.dart';

class IngredientesC{
  int ingredientId;
  int ingredientDishId;
  int ingredientFoodItemId;
  dynamic ingredientQuantity;
  String ingredientUnity;
  dynamic ingredientGramos;
  String ingredientCreated;
  String ingredientModified;
  NutrientesC nutrientes;

  IngredientesC({
    required this.ingredientId,
    required this.ingredientDishId,
    required this.ingredientFoodItemId,
    required this.ingredientQuantity,
    required this.ingredientUnity,
    required this.ingredientGramos,
    required this.ingredientCreated,
    required this.ingredientModified,
    required this.nutrientes,
  });

  int getIngId(){ return ingredientId;}
  int getIngDishId() {return ingredientDishId;}
  int getIngFoodId() {return ingredientFoodItemId;}
  dynamic getIngQuantity() {return ingredientQuantity;}
  String getIngUnity() {return ingredientUnity;}
  dynamic getIngGramos() {return ingredientUnity;}
  String getIngCread() {return ingredientCreated;}
  String getIngModif() {return ingredientModified;}
  NutrientesC getNutrientes() { return nutrientes;}

  factory IngredientesC.fromJson(Map<String, dynamic> item) {
    return IngredientesC(
      ingredientId:item['ingredient_id'],
      ingredientDishId:item['ingredient_dish_id'],
      ingredientFoodItemId:item['ingredient_food_item_id'],
      ingredientQuantity:item['ingredient_quantity'],
      ingredientUnity:item['ingredient_unity'],
      ingredientGramos: item['ingredient_gramos'],
      ingredientCreated:item['ingredient_created'],
      ingredientModified:item['ingredient_modified'],
      nutrientes:NutrientesC.fromJson(item['nutrientes']),
    );
  }
  
  List<IngredientesC> parseRecetaCP(dynamic responseBody) {
  final parsedP = (responseBody);
  return parsedP.map<IngredientesC>(
    (item) => IngredientesC.fromJson(item),
  ).toList();
  }
}