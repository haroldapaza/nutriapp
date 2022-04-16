

import 'dart:convert';
import 'dart:math';
import 'package:nutriapp/pages/navegation/pages/plan/models/plan.model.dart';
import 'package:nutriapp/services/api.dart';

Future<List<PlanC>> fetchPlan(client) async {
  AuthRepository api = AuthRepository();
  final planLista = await api.getPlanIdFecha(client);
  if(planLista.statusCode == 200) {
      
  }else{
    throw Exception('Failed to load pictures');
  }
  return (parsePlanC(planLista.body));
}
List<PlanC> parsePlanC(String responseBody){
  if(jsonDecode(responseBody)["exito"]==false){
    PlanC listaPlan=PlanC(planId: 0, planIdPerson: 1, fecha: "", comida: "", alimentoReceta: "", gramos: 1.0, cantidad: 1, unidad: "", kcal: 1.0, protein: 1.0, carbs: 1.0, fats: 1.0, created:"");
    List<PlanC> listaNueva=[listaPlan];
    return listaNueva;
  }
  final parsedP = jsonDecode(responseBody)["mensaje"];
  
  return parsedP?.map<PlanC>(
    (item) => PlanC.fromJson(item),
  )?.toList()?? [];
}

//delete
Future<dynamic> deleteItemPlan(id) async {
  AuthRepository api = AuthRepository();
  final planLista = await api.deletePlanApi(id);
  if(planLista.statusCode == 200) {
    // dynamic jsonResponse = json.decode(planLista.body);
    // if(jsonResponse['error']=="Expired token"){
    //   logOut();
    // }
      return (parseDeletePlanC(planLista.body));

  }else{
    throw Exception('Failed to load pictures');
  }
}
dynamic parseDeletePlanC(String responseBody){
  final parsedP = jsonDecode(responseBody)["mensaje"];
  
  return parsedP;
}
////////////////////

List<PlanC> selectPlan(List<PlanC> recetasGenral,String condicion){
  List<PlanC> desaAlmCena=[];
  
  for (var i=0; i<recetasGenral.length; i++) {
    if(recetasGenral[i].comida==condicion){
      desaAlmCena.add(recetasGenral[i]);
    }
  }
  return desaAlmCena;
}

List<double>sumaListaPlan(List<PlanC> plan){
  double kcal=0.0;
  double proteinas=0.0;
  double carbs=0.0;
  double fats=0.0;
  List<double> sumaNutrientes=[];
  for(int i=0;i<plan.length;i++){
    kcal+=plan[i].kcal;
    proteinas+=plan[i].protein;
    carbs+=plan[i].carbs;
    fats+=plan[i].fats;
  }
  sumaNutrientes.add(redondeo(kcal,2));
  sumaNutrientes.add(redondeo(proteinas,2));
  sumaNutrientes.add(redondeo(carbs,2));
  sumaNutrientes.add(redondeo(fats,2));
  return sumaNutrientes;
}

List<double>sumaTresListas(List<PlanC> listaD,List<PlanC> listaA,List<PlanC> listaC ){
  List<double> sumaTotalT=[0.0,0.0,0.0,0.0];
  List<double> sumaTotalD=[0.0,0.0,0.0,0.0];
  List<double> sumaTotalA=[0.0,0.0,0.0,0.0];
  List<double> sumaTotalC=[0.0,0.0,0.0,0.0];
  sumaTotalD=sumaListaPlan(listaD);
  sumaTotalA=sumaListaPlan(listaA);
  sumaTotalC=sumaListaPlan(listaC);

  for(int i=0;i<4;i++){
    sumaTotalT[i]=redondeo(sumaTotalD[i]+sumaTotalA[i]+sumaTotalC[i],2);
  }
  return sumaTotalT;

}
double redondeo(double val, int places){ 
   num mod = pow(10.0, places); 
   return ((val * mod).round().toDouble()/mod); 
}
List<PlanC> planToday(List<PlanC> listaPlan,dynamic fecha){
  PlanC today=PlanC(planId: 0, planIdPerson: 1, fecha: "", comida: "", alimentoReceta: "", gramos: 1.0, cantidad: 1, unidad: "", kcal: 1.0, protein: 1.0, carbs: 1.0, fats: 1.0, created:"");
  List<PlanC> listaToday=[today];
  for(int i=0;i<listaPlan.length;i++){
    if((listaPlan[i].fecha).toString().split('T')[0]==fecha.toString().split('T')[0]){
      listaToday.add(listaPlan[i]);
    }
  }
  return listaToday;
}
opcionesDias(dynamic fecha){
    switch(fecha){
      case 'Monday':{
        return 'Lunes';
      }
      case 'Tuesday':{
        return 'Martes';
      }
      case 'Wednesday':{
        return 'Miercoles';
      }
      case 'Thursday':{
        return 'Jueves';
      }
      case 'Friday':{
        return 'Viernes';
      }
      case 'Saturday':{
        return 'Sabado';
      }
      case 'Sunday':{
        return 'Domingo';
      }
      
    }
  }
  
 