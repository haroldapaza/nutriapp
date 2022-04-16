class NutrientesC{
  int foodItemId;
  String foodItemName;
  int foodItemUnityId;
  int foodItemFtypeId;
  String foodItemObservation;
  String foodItemCreated;
  String foodItemModified;
  dynamic foodItemKcal;
  dynamic foodItemProtein;
  dynamic foodItemCarbs;
  dynamic foodItemFats;
  dynamic foodItemWater;
  dynamic foodItemAvlvarbs;
  dynamic foodItemFiber;

  NutrientesC({
   required this.foodItemId,
   required this.foodItemName,
   required this.foodItemUnityId,
   required this.foodItemFtypeId,
   required this.foodItemObservation,
   required this.foodItemCreated,
   required this.foodItemModified,
   required this.foodItemKcal,
   required this.foodItemProtein,
   required this.foodItemCarbs,
   required this.foodItemFats,
   required this.foodItemWater,
   required this.foodItemAvlvarbs,
   required this.foodItemFiber
  });

  int getFoodItemId(){ return foodItemId;}
  String getFoodItemName(){ return foodItemName;}
  int getFoodItemUnityId(){ return foodItemUnityId;}
  int getFoodItemFTId(){ return foodItemFtypeId;}
  String getFoodItemObserv(){ return foodItemObservation;}
  String getFoodItemCreat(){ return foodItemCreated;}
  String getFoodItemModif(){ return foodItemModified;}
  dynamic getFoodItemProtein(){ return foodItemProtein;}
  dynamic getFoodItemCarbs(){ return foodItemCarbs;}
  dynamic getFoodItemFats(){ return foodItemFats;}
  dynamic getFoodItemWater(){ return foodItemWater;}
  dynamic getFoodItemAvlCarbs(){ return foodItemAvlvarbs;}
  dynamic getFoodItemFiber(){ return foodItemFiber;}

  factory NutrientesC.fromJson(Map<String, dynamic> item) {
    return NutrientesC(
      foodItemId:item['food_item_id'],
      foodItemName:item['food_item_name'],
      foodItemUnityId:item['food_item_unity_id'],
      foodItemFtypeId:item['food_item_ftype_id'],
      foodItemObservation:item['food_item_observation'],
      foodItemCreated:item['food_item_created'],
      foodItemModified:item['food_item_modified'],
      foodItemKcal: item['food_item_kcal'],
      foodItemProtein:item['food_item_protein'],
      foodItemCarbs:item['food_item_carbs'],
      foodItemFats:item['food_item_fats'],
      foodItemWater:item['food_item_water'],
      foodItemAvlvarbs:item['food_item_avlvarbs'],
      foodItemFiber:item['food_item_fiber'],
    );
  }
}