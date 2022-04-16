import 'dart:convert';

import 'package:nutriapp/data/datosglobal.dart';
import 'package:nutriapp/pages/publicidad/models/publi.model.dart';
import 'package:nutriapp/services/api.dart';

Future<List<PublicidadC>> fetchPublicidadImg(client) async {
  AuthRepository api = AuthRepository();
  final planLista = await api.publicidadShare(client);
  // print(planLista.body);
  if(planLista.statusCode == 200) {
      dynamic jsonResponse = json.decode(planLista.body);
    if(jsonResponse['error']=="Expired token"){
      logOut();
    }
  }else{
    throw Exception('Failed to load pictures');
  }
  return (parseImgC(planLista.body));
}
List<PublicidadC> parseImgC(String responseBody){
  final parsedP = jsonDecode(responseBody)["mensaje"];
  return parsedP?.map<PublicidadC>(
    (item) => PublicidadC.fromJson(item),
  )?.toList()?? [];
}