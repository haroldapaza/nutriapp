
import 'dart:convert';
import 'package:nutriapp/pages/navegation/pages/recomendaciones/models/recomenImg.model.dart';
import 'package:nutriapp/services/api.dart';

Future<List<RecomendacionImgC>> fetchRecomendacionImg(client) async {
  AuthRepository api = AuthRepository();
  final planLista = await api.recomendacionLista(client);
  // print(planLista.body);
  if(planLista.statusCode == 200) {
    //   dynamic jsonResponse = json.decode(planLista.body);
    // if(jsonResponse['error']=="Expired token"){
    //   logOut();
    // }
  }else{
    throw Exception('Failed to load pictures');
  }
  return (parseImgC(planLista.body));
}
List<RecomendacionImgC> parseImgC(String responseBody){
  final parsedP = jsonDecode(responseBody)["mensaje"];
  return parsedP?.map<RecomendacionImgC>(
    (item) => RecomendacionImgC.fromJson(item),
  )?.toList()?? [];
}