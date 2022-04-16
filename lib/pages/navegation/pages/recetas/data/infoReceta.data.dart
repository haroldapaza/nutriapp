import 'dart:convert';
import 'dart:math';
import 'package:nutriapp/pages/navegation/pages/recetas/models/ingredientes.model.dart';
import 'package:nutriapp/pages/navegation/pages/recetas/models/receta.model.dart';
import 'package:nutriapp/pages/navegation/pages/recetas/models/sumaNutri.model.dart';
import 'package:nutriapp/services/api.dart';


List<SumaNutrientesC>sumarNutriReceta(RecetaC receta,double defectPorcion,double nuevoPorcion){
  List<SumaNutrientesC> nutrientes=[];
  double calorias=0.0;
  double proteinas=0.0;
  double carbs=0.0;
  double grasas=0.0;
  double agua=0.0;
  double fibra=0.0;
  double alvcarb=0.0;

  for (var i = 0; i < receta.ingredientes.length; i++) {
    calorias+= regla3(receta.ingredientes[i].nutrientes.foodItemAvlvarbs,receta.ingredientes[i].nutrientes.foodItemKcal,receta.ingredientes[i].ingredientGramos,receta.ingredientes[i].ingredientQuantity);
    proteinas+=regla3(receta.ingredientes[i].nutrientes.foodItemAvlvarbs,receta.ingredientes[i].nutrientes.foodItemProtein,receta.ingredientes[i].ingredientGramos,receta.ingredientes[i].ingredientQuantity);
    carbs+=    regla3(receta.ingredientes[i].nutrientes.foodItemAvlvarbs,receta.ingredientes[i].nutrientes.foodItemCarbs,receta.ingredientes[i].ingredientGramos,receta.ingredientes[i].ingredientQuantity);
    grasas+=   regla3(receta.ingredientes[i].nutrientes.foodItemAvlvarbs,receta.ingredientes[i].nutrientes.foodItemFats,receta.ingredientes[i].ingredientGramos,receta.ingredientes[i].ingredientQuantity);
    agua+=     regla3(receta.ingredientes[i].nutrientes.foodItemAvlvarbs,receta.ingredientes[i].nutrientes.foodItemWater,receta.ingredientes[i].ingredientGramos,receta.ingredientes[i].ingredientQuantity);
    fibra+=    regla3(receta.ingredientes[i].nutrientes.foodItemAvlvarbs,receta.ingredientes[i].nutrientes.foodItemFiber,receta.ingredientes[i].ingredientGramos,receta.ingredientes[i].ingredientQuantity);
    alvcarb+=  regla3(receta.ingredientes[i].nutrientes.foodItemAvlvarbs,receta.ingredientes[i].nutrientes.foodItemKcal,receta.ingredientes[i].ingredientGramos,receta.ingredientes[i].ingredientQuantity);
  }
  
  calorias=nuevaRacion(defectPorcion,nuevoPorcion,calorias);
  proteinas=nuevaRacion(defectPorcion,nuevoPorcion,proteinas);
  carbs=nuevaRacion(defectPorcion,nuevoPorcion,carbs);
  grasas=nuevaRacion(defectPorcion,nuevoPorcion,grasas);
  agua=nuevaRacion(defectPorcion,nuevoPorcion,agua);
  fibra=nuevaRacion(defectPorcion,nuevoPorcion,fibra);
  alvcarb=nuevaRacion(defectPorcion,nuevoPorcion,alvcarb);
  
  nutrientes.add(SumaNutrientesC(nombreNutri: 'Calorias',tagNutri: 'Kcal',valorNutri: redondeo(calorias,2)));
  nutrientes.add(SumaNutrientesC(nombreNutri: 'Proteinas',tagNutri: 'g', valorNutri: redondeo(proteinas,2)));
  nutrientes.add(SumaNutrientesC(nombreNutri: 'Carbs',tagNutri: 'g',valorNutri: redondeo(carbs,2)));
  nutrientes.add(SumaNutrientesC(nombreNutri: 'Grasas',tagNutri: 'g',valorNutri: redondeo(grasas,2)));
  nutrientes.add(SumaNutrientesC(nombreNutri: 'Agua',tagNutri: 'A',valorNutri: redondeo(agua,2)));
  nutrientes.add(SumaNutrientesC(nombreNutri: 'Fibra',tagNutri: 'g',valorNutri: redondeo(fibra,2)));
  nutrientes.add(SumaNutrientesC(nombreNutri: 'Total Gramos',tagNutri: 'ACarb',valorNutri: redondeo(alvcarb,2)));
  return nutrientes;
}
double redondeo(double val, int places){ 
   num mod = pow(10.0, places); 
   return ((val * mod).round().toDouble()/mod); 
}

double nuevaRacion(double defectPorcion,double nuevaCantidad,double valorNutriente){
  double resultado=(nuevaCantidad*valorNutriente)/defectPorcion;
  return resultado;
}
double regla3(dynamic alimentoGramos,dynamic varNutri,dynamic recetaAlimentGramos,dynamic cantidad){
  double result=(recetaAlimentGramos*varNutri)/alimentoGramos;
  return (result*cantidad);
}

double sumaTotalGramos(List<IngredientesC> ingre){
  double result=0.0;
  for(int i=0;i<ingre.length;i++){
    result+=ingre[i].ingredientGramos;
  }
  return result;
}

List<double> numeroNutrientes(List<IngredientesC> ingredientes){
  List<double> listaNumeroIngredientes=[];
  for (int i=0;i<ingredientes.length;i++){
    listaNumeroIngredientes.add(ingredientes[i].ingredientQuantity.toDouble());
  }
  return listaNumeroIngredientes;
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



