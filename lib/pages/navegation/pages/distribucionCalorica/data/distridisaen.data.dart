

import 'dart:math';
import 'package:nutriapp/pages/navegation/pages/distribucionCalorica/models/macrositem.model.dart';

import 'distribucion.data.dart';
MacroNutrienetes? macroNutrientes;

List<MacrosItemC> getMacrosItem(peso,altura,edad,actiFisica,sexo){
  macroNutrientes= MacroNutrienetes(peso,altura,edad,actiFisica,sexo); 
  List<MacrosItemC> macrosI=[];
  List<String> nombreMacros=['PROTEÍNA','GRASA','CARBOHIDRATO'];
  // List<Widget> colores=[Colors.amber,Colors.amber,Colors.amber];
  List<String> imagenes=["assets/imagenes/protein.png","assets/imagenes/grasa.png","assets/imagenes/carbs.png"];
  List<double> macrosCaloriasPGC=[macroNutrientes!.proteinasKcal(),macroNutrientes!.grasasKcal(),macroNutrientes!.carboHidratosKcal()];
  List<double> macrosGramosPGC=[macroNutrientes!.proteinasGramos(),macroNutrientes!.grasasGramos(),macroNutrientes!.carboHidratosGramos()];
  for(int i=0;i<3;i++){
    macrosI.add(MacrosItemC(titulo:nombreMacros[i],imagen: imagenes[i],color: i,calorias: redondeo(macrosCaloriasPGC[i],2),gramos: redondeo(macrosGramosPGC[i],2)));
  }
  return macrosI;
} 
double redondeo(double val, int places){ 
   num mod = pow(10.0, places); 
   return ((val * mod).round().toDouble()/mod); 
}
double getMacrosTotalKcal(peso,altura,edad,actiFisica,sexo){
  macroNutrientes= MacroNutrienetes(peso,altura,edad,actiFisica,sexo); 
  double caloriasTotal=0.0;
  caloriasTotal=macroNutrientes!.calorias;
  
  return redondeo(caloriasTotal,2);
}
double getIndiceMasaCorporal(peso,altura,edad,actiFisica,sexo){
  macroNutrientes= MacroNutrienetes(peso,altura,edad,actiFisica,sexo); 
  return redondeo(macroNutrientes!.indiceMasaCorporal(),4);
}
double getEdadMetabolica(peso,altura,edad,actiFisica,sexo){
  macroNutrientes= MacroNutrienetes(peso,altura,edad,actiFisica,sexo); 
  double edadMetabolica=0.0;
  edadMetabolica=macroNutrientes!.edadMetabolica();
  return redondeo(edadMetabolica,2);
}
double getTasaMetabolicaBasal(peso,altura,edad,actiFisica,sexo){
  macroNutrientes= MacroNutrienetes(peso,altura,edad,actiFisica,sexo); 
  double tasaMetabolicoBasal=0.0;
  tasaMetabolicoBasal=macroNutrientes!.tasaMetabolicaBasal();
  return redondeo(tasaMetabolicoBasal,4);
}


double procentaje(dynamic valorItem,dynamic valorTotal){
  double resultado=10.0;
  if(valorItem!=0.0){
    resultado=(valorItem*100)/valorTotal;
  }
  
  return redondeo(resultado,1);
}
