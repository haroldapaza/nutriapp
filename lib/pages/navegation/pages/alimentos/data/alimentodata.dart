import 'dart:convert';
import 'dart:math';

import 'package:nutriapp/pages/navegation/pages/alimentos/models/food_item_list.model.dart';
import 'package:nutriapp/services/api.dart';


// Future<dynamic> getListadoAlimento(String dato) async {
//     Map datos={
//     "likesearch":dato
//     };
//   AuthRepository api = AuthRepository();
//     final respuesta = await api.postAliemnto(datos);
    
//     if (respuesta.statusCode == 200){
//       return jsonDecode(respuesta.body)['mensaje'];
//     } else {
//       print("Error con la respusta");
//     }
//   }

Future<List<FoodItemListC>> fetchAlimentoL(String dato) async {
  Map datos={
    "likesearch":dato
    };
  AuthRepository api = AuthRepository();
  final alimentoList = await api.postAliemnto(datos);
  if(alimentoList.statusCode == 200) {
    // dynamic jsonResponse = json.decode(alimentoList.body);
    // if(jsonResponse['error']=="Expired token"){
    //   logOut();
    // }  
  }else{
    throw Exception('Failed to load pictures');
  }
  return (parseFoodItemListC(alimentoList.body));
}
List<FoodItemListC> parseFoodItemListC(String responseBody){
  final parsedP = jsonDecode(responseBody)["mensaje"];
  return parsedP?.map<FoodItemListC>(
    (item) => FoodItemListC.fromJson(item),
  )?.toList()?? [];
}
double redondeo(double val, int places){ 
   num mod = pow(10.0, places); 
   return ((val * mod).round().toDouble()/mod); 
}

postPlan(Map data)async{
  dynamic jsonResponse;
    var log=AuthRepository();
    var response=await log.postPlanApi(data);
    if(response.statusCode == 200) {
      
      jsonResponse = json.decode(response.body);
      
      if(jsonResponse['exito']==true){
        // print("datos guardados");
      }else{
        // print("ocurrio un error");
      }
    }else{
      // print("error");
    }
}