
import 'dart:convert';

import 'img.model.dart';
import 'ingredientes.model.dart';

class RecetaC{
  int dishId;
  String dishName;
  String dishTipo;
  String dishDescription;
  String dishObservations;
  String dishCreated;
  String dishModified;
  ImgC imgs;
  List<IngredientesC> ingredientes;

  RecetaC({
    required this.dishId,
    required this.dishName,
    required this.dishTipo,
    required this.dishDescription,
    required this.dishObservations,
    required this.dishCreated,
    required this.dishModified,
    required this.imgs,
    required this.ingredientes
  });
  int getDishId() {return dishId;}
  String getDishName() {return dishName;}
  String getDishTipo() {return dishTipo;}
  String getDishDescr() {return dishDescription;}
  String getDishObserv() {return dishObservations;}
  String getDishCread() {return dishCreated;}
  String getDishModif() {return dishModified;}
  ImgC getDishImg() { return imgs;}
  List<IngredientesC> getDishIngredient() { return ingredientes;}

  factory RecetaC.fromJson(Map<String, dynamic> item) {
    return RecetaC(
      dishId: item['dish_id'] as int,
      dishName: item['dish_name'] as String,
      dishTipo: item['dish_tipo'] as String,
      dishDescription: item['dish_description'] as String,
      dishObservations: item['dish_observations'] as String,
      dishCreated: item['dish_created'] as String,
      dishModified: item['dish_modified'] as String,
      imgs: ImgC.fromJson(item['imgs']),
      // ingredientes: json['ingredientes'] as IngredientesC,  
      ingredientes:item['ingredientes'].map<IngredientesC>((item) => IngredientesC.fromJson(item)).toList(),
    );
  }
  List<IngredientesC> parseIngredientesC(final responseBody) {
    final parsedP = jsonDecode(responseBody);
    return parsedP.map<IngredientesC>(
      (item) => IngredientesC.fromJson(item),
    ).toList();
  }


}