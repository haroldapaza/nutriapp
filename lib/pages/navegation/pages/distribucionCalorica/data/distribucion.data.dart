
class MacroNutrienetes{
  dynamic peso=1.0;
  dynamic edad=1.0;
  dynamic altura=1.0;
  dynamic actividadFisica=1.0;

  double carboHidratos =45; //45- 55%
  double proteinas =20; //20-35%
  double grasas = 20;//20-35%
  double calorias=1.0;
  String sexo="M";

  dynamic gramoCarbs=4; //Kcal
  dynamic gramoProtein=4;//Kcal
  dynamic gramoGrasa=9;//Kcal
  
  MacroNutrienetes(dynamic pesoi,alturai,edadi,actividadFisicai,String sexoi){
    peso=pesoi;
    altura=alturai;
    edad=edadi;
    actividadFisica=actividadFisicai;
    sexo=sexoi;
    calorias= caloriasPersona(sexoi);
  }
  
  double actividadFisicaCal(dynamic valor){
    double result=0.0;
    switch(valor){
      case 1:{
          result=1.2;//nula 0 dias a la semana
          carboHidratos=55;
          proteinas=35;
          grasas =35;
      }
          break; 
      case 2: {
          result=1.4;//Ligera 1-3 dias a la semana
          carboHidratos=53;
          proteinas=31;
          grasas =31;
      }
          break; 
      case 3:{ 
          result=1.6;//Moderada 3-5 dias a la semana
          carboHidratos=50;
          proteinas=26;
          grasas =26;
      }
          break; 
      case 4:{ 
          result=1.8;//fuerte 6-7 dias a la semana
          carboHidratos=47;
          proteinas=23;
          grasas =23;
      }
          break; 
      case 5:{
          result=2.0;//Alto doble sessiones
          carboHidratos=45;
          proteinas=20;
          grasas =20;
      }
          break; 
      default:{ 
          result=2.0;//Alto doble sessiones
      }
          break;
    }
    return result;
  }

  double caloriasPersona(String sexo){ 
    double kcal=0.0;
    switch(sexo) { 
      case "M": { 
          kcal= (655 + (9.6*peso)) + ((1.8* altura)- (4.7*edad))*actividadFisicaCal(actividadFisica);
      } 
      break; 
      case "F": { 
        kcal= (66 + (13.7*peso)) + ((5* altura)- (6.8*edad))*actividadFisicaCal(actividadFisica);
      } 
      break; 
    }
    return kcal;
  }

  double carboHidratosKcal(){
    return carboHidratos*calorias/100;
  }
  double proteinasKcal(){
    return proteinas*calorias/100;
  }
  double grasasKcal(){
    return grasas*calorias/100;
  }
  
  double carboHidratosGramos(){
    return carboHidratosKcal()/gramoCarbs;
  }
  double proteinasGramos(){
    return proteinasKcal()/gramoProtein;
  }
  double grasasGramos(){
    return grasasKcal()/gramoGrasa;
  }

  double indiceMasaCorporal(){
    if(peso==null ||altura==null){
    return 1.0;
  }
    return (peso/((altura/100)*(altura/100)));
    // return 1.0;
  }

  double edadMetabolica(){
    return condicionEdadMetabolica(sexo);
  }
  double condicionEdadMetabolica(String sexo){
    double edadMetabolica=0.0;
    switch(sexo) { 
      case "M": { 
          edadMetabolica= (66+(6.23*peso))+((12.7* (altura/100))-(6.8*edad));
      } 
      break; 
      case "F": { 
        edadMetabolica= (66+(4.35*peso))+((4.7*(altura/100))-(4.7*edad));
      } 
      break; 
    }
    return edadMetabolica;
  }

  double tasaMetabolicaBasal(){
    return condicionTasaMetabolica(edad,sexo);
  }
  double condicionTasaMetabolica(dynamic edad, String sexo){
    double tasaMetabolica=0.0;
    if(edad>=0 && edad<=3 && sexo=="M"){
      tasaMetabolica=(60.9*peso)-54;
    }else{
      tasaMetabolica= (61*peso)-51;
    }
    if(edad>=4 && edad<=10&& sexo=="M"){
      tasaMetabolica=(22.7*peso)+495;
    }else{
      tasaMetabolica= (22.5*peso)+499;
    }
    
    if(edad>=11 && edad<=18&& sexo=="M"){
      tasaMetabolica=(17.5*peso)+651;
    }else{
      tasaMetabolica= (12.2*peso)+746;
    }
    if(edad>=19 && edad<=30&& sexo=="M"){
      tasaMetabolica=(15.3*peso)+679;
    }else{
      tasaMetabolica=(14.7*peso)+496;
    }
    if(edad>=31 && edad<=61&& sexo=="M"){
      tasaMetabolica=(11.6*peso)+879;
    }else{
      tasaMetabolica=(8.7*peso)+829;
    }
    if(edad>=61&& sexo=="M"){
      tasaMetabolica=(596*peso)+487;
    }else{
      tasaMetabolica=(10.5*peso)+596;
    }
    return tasaMetabolica;
  }

}