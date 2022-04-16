
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nutriapp/constants/constant.dart';
import 'package:nutriapp/pages/navegation/pages/alimentos/data/alimentodata.dart';
import 'package:nutriapp/pages/navegation/pages/alimentos/models/food_item_list.model.dart';
import 'package:nutriapp/pages/navegation/pages/recetas/models/receta.model.dart';
import 'package:nutriapp/pages/navegation/pages/recetas/widgets/buscarReceta.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Alimentos extends StatefulWidget {
  const Alimentos({Key? key}) : super(key: key);

  @override
  _AlimentosState createState() => _AlimentosState();
}

class _AlimentosState extends State<Alimentos> {
  late final String title;
  List<String> titulos=['Buscar Alimentos','Buscar Receta'];
  int item=1;
  int item2=0;
  List<RecetaC> recetaInfo=[];
  String buscarAlimentoItem="";
  final focus = FocusNode();
  List<String> listaDiaria=['Desayuno', 'Almuerzo', 'Cena'];
  String ingresarA='Desayuno';
  List<String> infoAlimentoItems=[];
  List<String> datosTag=['Kcal','g','g','g'];
  List<String> datosNameNutrientes=['Kcal','Proteinas','Grasa','Carbs'];
  dynamic userId;
  SharedPreferences? sharedPreferences;
  bool _isLoading = false;

  List<double> datosNutrientes=[0.0,0.0,0.0,0.0];
  double multi=1.0;
  int valorCambiante=1;
  // @override
  // void setState(VoidCallback fn) {
  //   buscarAlimentoItem="";
  //   super.setState(fn);
  // }
  @override
  void initState() {
    optenerIdPerson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:_isLoading
              ? const Center(child: CircularProgressIndicator())
              :alimentos()
      ),
    );
  }
  optenerIdPerson()async{
    sharedPreferences = await SharedPreferences.getInstance();
    userId= sharedPreferences!.getString('userid');
    if (userId!="") {
      setState(() {
        _isLoading = false;
      });
    }
    return userId;
  }
  selectSearch(){
    if(item==1){
      return buscarAlimento();
    }else{
      return buscarReceta();
    }
  }
  buscarAlimento(){
    return Positioned(
              left: 35.0,
              top: 5.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                width: 280.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hoverColor: Colors.amber,
                    prefixIcon: const Icon(Icons.search),
                    labelText: "Buscar Alimento",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  onFieldSubmitted:(value) {
                    if(value.isEmpty){

                    }else{
                      setState(() {
                        buscarAlimentoItem=value;
                      });
                    }
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Email cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ));
  }
  buscarReceta(){
    return Positioned(
              left: 35.0,
              top: 5.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                width: 280.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hoverColor: Colors.amber,
                    prefixIcon: const Icon(Icons.search),
                    labelText: "Buscar Receta",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  onFieldSubmitted:(value) {
                    if(value.isEmpty){

                    }else{
                      setState(() {
                        FocusScope.of(context).requestFocus(focus);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context)=> BuscarReceta(value)
                          )
                        );
                      });
                    }
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Email cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ));
  }
  alimentos(){
    return Stack(
      children: [
        botonesRecetaAlimento(),
        condicionListadoAlimento(),
        selectSearch(),
       
      ],
    );
  }
  condicionListadoAlimento(){
    if(buscarAlimentoItem!=""){
      return  FutureBuilder<List<FoodItemListC>>(
          future: fetchAlimentoL(buscarAlimentoItem),
          builder: (context, snapshot){
            if (snapshot.hasData) {
              
              return Container(
                margin: const EdgeInsets.only(top: 95,left: 15,right: 15),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return botonItemLista((snapshot.data!)[index],index);
                  },
                ),
              );
            } else {
              // print("No hay información");
              return Container(
                margin: const EdgeInsets.only(top: 95,left: 15,right: 15),
                child: const Text("No hay datos"),);
            }
          }

        );
    }else{
      return Container(
                margin: const EdgeInsets.only(top: 50),
                child: const Text(""),);
    }
    
  }
  botonItemLista(FoodItemListC itemLista,int index){
    return TextButton(
        onPressed: (){
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (BuildContext context, StateSetter mystate){
                return Container(
                  height: 600,
                  color: Colors.white,
                  child: Center(
                    child: Column(

                      children: <Widget>[
                        const SizedBox(height: 8,),
                        Text(itemLista.foodItemName,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black)),
                        const SizedBox(height: 4,),
                        Text("Datos por "+multi.toString()+" Unidad(es) (${redondeo((itemLista.foodItemAvlvarbs)*multi,2)} g)"),
                        nutrientesReceta(itemLista),
                        formulario(mystate),
                        addButton(mystate,itemLista,index)
                      ],
                    ),
                  ),
                );
              });
            },
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black12,
                width: 2.0,
              ),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(child: Text((index+1).toString()),),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(
                          itemLista.foodItemName,
                          style: const TextStyle(fontSize: 20, color: Colors.indigo),
                        ),
                      ],
                    ),
                  ),  
                  
                  
                ],
              ),
            ],
          ),
        ),
      );
  }
  nutrientesReceta(FoodItemListC itemLista){
    return Column(
      children: [
        Text.rich(
          TextSpan(
            text: (itemLista.foodItemAvlvarbs*valorCambiante).toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18), // default text style
            children: const[
              TextSpan(text: "", style: TextStyle(fontStyle: FontStyle.normal,color: Colors.blue,fontSize: 18)),
              TextSpan(text: " g", style: TextStyle(fontStyle: FontStyle.normal,color: Colors.blue,fontSize: 16)),
            ],
          ),
        ),
        const SizedBox(height: 6,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            
            for(var item=0;item<4;item++)
              infoNutri(itemLista,item)
          ],
        ),
      ],
    );
  }
  selectNutrientes(FoodItemListC itemLista,int i){
    if(i==0){
     return (itemLista.foodItemKcal).toDouble();
    }else if(i==1){
     return (itemLista.foodItemProtein).toDouble();
    }else if(i==2){
     return (itemLista.foodItemFats).toDouble();
    }else if(i==3){
     return (itemLista.foodItemCarbs).toDouble();
    }
  }
  infoNutri(FoodItemListC itemLista,int i) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text.rich(
          TextSpan( 
            text: (redondeo(selectNutrientes(itemLista,i)*multi,2)).toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18), // default text style
            children: <TextSpan>[
              TextSpan(text: datosTag[i], style: const TextStyle(fontStyle: FontStyle.normal,color: Colors.blue,fontSize: 18)),
            ],
          ),
        ),
        Text(
          datosNameNutrientes[i],
          style: const TextStyle(fontSize: 18, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
  formulario(StateSetter mystate){
    return Column(
      children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              margin: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const[
                  Text("Porsion: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  Text("Gramos",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                ],
              ),
            ), 
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Nro de Porsion:",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 180.0,
                      child: Column(
                        children: [
                          CupertinoSpinBox(
                            min: 1,
                            max: 20,
                            value: 1,
                            onChanged: (value) => {
                              mystate(() {
                                multi=value;
                                valorCambiante++;
                              }
                              
                            )},
                          )
                        ],
                      ),
                  ),
                ],
              ),
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Agregar a ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: ingresarA,
                    style: const TextStyle(color: Colors.black,fontSize: 16),
                    
                    onChanged: (String? newValue) {
                      mystate(() {
                        ingresarA = newValue!;
                      });
                    },
                    items: <String>['Desayuno', 'Almuerzo', 'Cena']
                        .map<DropdownMenuItem<String>>((String value) {
                          
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),

                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
    );
  }
  addButton(StateSetter mystate,FoodItemListC itemLista,int index){
   return ElevatedButton(
      onPressed: () {
          mystate(() {
            DateTime now = DateTime.now();
            Map data ={
              'idPerson':userId.toString(),
              'fecha':(now).toString(),
              'comida':ingresarA.toUpperCase(),
              'alimentoReceta':itemLista.foodItemName.toString(),
              'gramos':(redondeo((itemLista.foodItemAvlvarbs)*multi,2)).toString(),
              'cantidad':multi.toString(),
              'unidad':'Alimento',
              'kcal':(redondeo(selectNutrientes(itemLista,0)*multi,2)).toString(),
              'protein':(redondeo(selectNutrientes(itemLista,1)*multi,2)).toString(),
              'carbs':(redondeo(selectNutrientes(itemLista,2)*multi,2)).toString(),
              'fats':(redondeo(selectNutrientes(itemLista,3)*multi,2)).toString(),
            };
            postPlan(data);
            Fluttertoast.showToast(
                msg: "Se agrego a Plan",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
                
            ); 
          });
          Navigator.of(context).pop();
      },
      child: Text("Ingresar a $ingresarA",style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
      style: ElevatedButton.styleFrom(
        primary: Colors.amber,
      ),
    );
  }

  botonesRecetaAlimento(){
    return Container(
      margin: const EdgeInsets.only(top: 44),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            for(int i=0;i<2;i++)
              botones(i)
        ],
      ),
    );
  }
  botones(int i){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: (i==0 )?coloresSelect(item):coloresSelect(item2),
      ),
      onPressed: (){
        setState(() {
          if(i==0){
            item=1;
            item2=0;
          }else{
            item=0;
            item2=1;
          }
        });
      },
      child: Text(
        titulos[i],
        style: const TextStyle(fontSize: 16, color: Colors.white),
        textAlign: TextAlign.center,
      ),
      );
  }

  coloresSelect(int i){
    if(i==0){
      return Constant.botonColorReceta;
    }else{
      return Constant.botonColorAlimento;
    }
  }
}

List<String> listado( List<dynamic> info ){

  List<String> lista = [];
  for (var elemento in info) {
    lista.add(elemento["food_item_name"]);
  }
  return lista;

}





