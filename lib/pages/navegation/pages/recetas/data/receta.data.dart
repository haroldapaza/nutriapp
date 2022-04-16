import 'dart:convert';

import 'package:nutriapp/pages/navegation/pages/recetas/models/receta.model.dart';
import 'package:nutriapp/services/api.dart';


  double sumar(double valor,double valor2){
    return valor+valor2;
  }
  sumarLista(RecetaC receta){
  double sumaKcal=0;
  for (var i=0; i<receta.ingredientes.length; i++) {
      sumaKcal=sumaKcal+receta.ingredientes[i].nutrientes.foodItemKcal;
  }

  return sumaKcal;
}

List<RecetaC> selectReceta(List<RecetaC> recetasGenral,String condicion){
  List<RecetaC> desaAlmCena=[];
  
  for (var i=0; i<recetasGenral.length; i++) {
    if(recetasGenral[i].dishTipo==condicion){
      desaAlmCena.add(recetasGenral[i]);
    }
      
  }
  return desaAlmCena;

}
List<RecetaC>selecRecetas(List<RecetaC> recetasGeenral, int valor){
  List<RecetaC> desayuno=[];
  List<RecetaC> almuerzo=[];
  List<RecetaC> cena=[];
  List<RecetaC> vacio=[];
  for (var i=0; i<recetasGeenral.length; i++) {
    if(recetasGeenral[i].dishTipo=='DESAYUNO'){
      desayuno.add(recetasGeenral[i]);
    }else if(recetasGeenral[i].dishTipo=='ALMUERZO'){
      almuerzo.add(recetasGeenral[i]);
    }else{
      cena.add(recetasGeenral[i]);
    }
      
  }
  if(valor==0){return desayuno;}else{
    return vacio;
  }
}

Future<List<RecetaC>> fetchReceta(client) async {
  AuthRepository api = AuthRepository();
  final recetaLista = await api.recetaLista(client);
  if(recetaLista.statusCode == 200) {
    // dynamic jsonResponse = json.decode(recetaLista.body);
    // if(jsonResponse['error']=="Expired token"){
    //   logOut();
    // }  
  }else{
    throw Exception('Failed to load pictures');
  }
  return (parseRecetaC(recetaLista.body));
}
List<RecetaC> parseRecetaC(String responseBody){
  final parsedP = jsonDecode(responseBody)["mensaje"];
  return parsedP?.map<RecetaC>(
    (item) => RecetaC.fromJson(item),
  )?.toList()?? [];
}
