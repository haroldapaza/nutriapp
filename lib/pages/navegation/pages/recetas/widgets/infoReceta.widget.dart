

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nutriapp/pages/navegation/pages/recetas/data/infoReceta.data.dart';
import 'package:nutriapp/pages/navegation/pages/recetas/models/ingredientes.model.dart';
import 'package:nutriapp/pages/navegation/pages/recetas/models/receta.model.dart';
import 'package:nutriapp/pages/navegation/pages/recetas/models/sumaNutri.model.dart';
import 'package:shared_preferences/shared_preferences.dart';



// ignore: must_be_immutable
class InfoReceta extends StatefulWidget {
  RecetaC recetaInfo;
  InfoReceta(this.recetaInfo, {Key? key}) : super(key: key);

  @override
  State<InfoReceta> createState() => _InfoRecetaState();
}

class _InfoRecetaState extends State<InfoReceta> {
  String dropdownValue = 'Gramos';
  String valorDia='Desayuno';
  double defectPorcion=4;
  double nuevoPorcion=1;
  List<String> listaDiaria=['Desayuno', 'Almuerzo', 'Cena'];
  String ingresarA="Desayuno";
  double contaNutrientes=1;
  double contaNutrientesIndividual=1;
  double controladorNumero=0;
  dynamic userId;
  SharedPreferences? sharedPreferences;
  List<double> listaNutrientes=[];
  List<double> listaIngredienNumeroModificada=[] ;//original numero
  List<double> listaIngredienNumeroOriginal=[] ;//copia numero
  bool _isLoading = false;
  @override
  void initState() {
    optenerIdPerson();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              :ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              tituloReceta(widget.recetaInfo),
              const SizedBox(height: 2),
              nutrientesReceta(widget.recetaInfo),
              formulario(),
              addButton(),
              expansionIngredientes(widget.recetaInfo), 
            ],
      )),
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
  tituloReceta(RecetaC infoReceta){
    return Column(
      children: [
        Image.network(infoReceta.imgs.url),
        Text(
          infoReceta.dishName,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold,fontFamily: 'genostff',),
        ),
      ],
    );
  }
  nutrientesReceta(RecetaC infoReceta){
    return Column(
      children: [
        Text.rich(
          TextSpan(
            text: "Total: ",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'genostff',), // default text style
            children: <TextSpan>[
              TextSpan(text: (sumaTotalGramos(infoReceta.ingredientes)*nuevoPorcion).toString(), style: const TextStyle(fontStyle: FontStyle.normal,color: Colors.blue)),
              const TextSpan(text: " g", style: TextStyle(fontStyle: FontStyle.normal,color: Colors.blue)),
            ],
          ),
        ),
        const SizedBox(height: 2,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            for(var item=0;item<4;item++)
              infoNutri(sumarNutriReceta(infoReceta,defectPorcion,nuevoPorcion)[item],item)
          ],
        ),
      ],
    );
  }
  infoNutri(SumaNutrientesC sumaNutrientes,int index) {
    listaNutrientes.insert(index,sumaNutrientes.valorNutri);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text.rich(
          TextSpan(
            text: sumaNutrientes.valorNutri.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'genostff'), // default text style
            children: <TextSpan>[
              TextSpan(text: " "+sumaNutrientes.tagNutri.toString(), style: const TextStyle(fontStyle: FontStyle.normal,color: Colors.blue)),
            ],
          ),
        ),
        Text(
          sumaNutrientes.nombreNutri.toString(),
          style: const TextStyle(fontSize: 16, color: Colors.black,fontFamily: 'genostff'),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
  formulario(){
    return Column(
      children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              margin: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const[
                  Text("Porsion: ",style: TextStyle(fontFamily: 'genostff',fontSize: 16,fontWeight: FontWeight.bold)),
                  Text("Gramos",style: TextStyle(fontFamily: 'genostff',fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold)),
                  // DropdownButton<String>(
                  //   value: dropdownValue,
                  //   style: const TextStyle(color: Colors.black,fontSize: 16),
                    
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       dropdownValue = newValue!;
                  //     });
                  //   },
                  //   items: <String>['Gramos','hola']
                  //       .map<DropdownMenuItem<String>>((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(value),
                  //     );
                  //   }).toList(),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 0),
            
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Nro de Porsion:",style: TextStyle(fontFamily: 'genostff',fontSize: 16,fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 180.0,
                      child: Column(
                        children: [
                          
                          CupertinoSpinBox(
                            
                            min: 1,
                            max: 20,
                            value: 1,
                            onChanged: (value) => {setState(() {
                              nuevoPorcion=value;
                            })},
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
                  const Text("Agregar a ",style: TextStyle(fontFamily: 'genostff',fontSize: 16,fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: ingresarA,
                    style: const TextStyle(color: Colors.black,fontSize: 16),
                    
                    onChanged: (String? newValue) {
                      setState(() {
                        ingresarA = newValue!;
                      });
                    },
                    items: listaDiaria
                        .map<DropdownMenuItem<String>>((String value) {
                          
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: const TextStyle(fontFamily: 'genostff',fontSize: 18,fontWeight: FontWeight.bold)),

                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
    );
  }
  addButton(){
   return ElevatedButton(
      onPressed: () {
          setState(() {
            DateTime now = DateTime.now();
            Map data ={
              'idPerson':userId.toString(),
              'fecha':(now).toString(),
              'comida':ingresarA.toUpperCase(),
              'alimentoReceta':widget.recetaInfo.dishName,
              'gramos':(sumaTotalGramos(widget.recetaInfo.ingredientes)*nuevoPorcion).toString(),
              'cantidad':nuevoPorcion.toString(),
              'unidad':'porción',
              'kcal':listaNutrientes[0].toString(),
              'protein':listaNutrientes[1].toString(),
              'carbs':listaNutrientes[2].toString(),
              'fats':listaNutrientes[3].toString()
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
          // showToastSucces();
          Navigator.of(context).pop();
      },
      child: Text("Ingresar a $ingresarA",style: const TextStyle(fontFamily: 'genostff',fontSize: 20,fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        primary: Colors.amber,
      ),
    );
  }
//   void showToastSucces() {  
//     FlutterFlexibleToast.showToast(
//     message: "Se Añadio a Plan",
//     toastLength: Toast.LENGTH_LONG,
//     toastGravity: ToastGravity.TOP,
//     icon: ICON.SUCCESS,
//     radius: 100,
//     elevation: 10,
//     imageSize: 35,
//     textColor: Colors.white,
//     backgroundColor: Colors.greenAccent,
//     timeInSeconds: 1
// ); 
//   }
  expansionIngredientes(RecetaC infoReceta){
    List<IngredientesC> ingredientes=[];
    ingredientes=infoReceta.ingredientes;
    listaIngredienNumeroModificada.addAll(numeroNutrientes(ingredientes));
    listaIngredienNumeroOriginal.addAll(numeroNutrientes(ingredientes));
    // for(int i=0;i<widget.recetaInfo.ingredientes.length;i++){
    //   widget.recetaInfo.ingredientes[i].ingredientQuantity=listaIngredienNumeroModificada[i];
    // }
    return Column(
      children: <Widget> [
        const SizedBox(height: 20.0),
        ExpansionTile(
          title: const Text(
            "Ingredientes",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,fontFamily: 'genostff',color: Colors.green),
          ),
          children: <Widget>[
            Card(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text("Porciones",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'genostff'),),
                  ),
                  SizedBox(
                    width: 143.0,
                      child: Column(
                        children: [
                          CupertinoSpinBox(
                            min: 1,
                            max: 20,
                            value: (contaNutrientes),
                            
                            onChanged: (value) => {setState(() {
                              if(contaNutrientes>value){
                                for(int i=0;i<listaIngredienNumeroModificada.length;i++){
                                  listaIngredienNumeroModificada[i]-=listaIngredienNumeroOriginal[i];
                                }
                              }else{
                                for(int i=0;i<listaIngredienNumeroModificada.length;i++){
                                  listaIngredienNumeroModificada[i]+=listaIngredienNumeroOriginal[i];
                                }
                              }
                              contaNutrientes=value;
                              // _varialbe=value;
                            })},
                          )
                          
                        ],
                      ),
                  ),
                ],
              ),
            ),
            for (int i=0;i<ingredientes.length;i++)
              ingredienteUnitario(ingredientes[i],i),
          ],
        ),
        preparacionReceta(infoReceta),
        observacionReceta(infoReceta)
      ],
    );
  }
  
  ingredienteUnitario(IngredientesC ingrediente,int i){
    double nuevaPorcionI=0.0;

    nuevaPorcionI= nuevaRacion(listaIngredienNumeroOriginal[i],listaIngredienNumeroModificada[i],ingrediente.ingredientGramos.toDouble());
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                  ingrediente.nutrientes.foodItemName.toString(),
                  style: const TextStyle(fontSize: 13, color: Colors.black,fontFamily: 'genostff'),
                ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Text.rich(
                TextSpan(
                  text: ingrediente.ingredientUnity.toString()+"\n",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14,fontFamily: 'genostff'), // default text style
                  children: <TextSpan>[
                    TextSpan(text: "("+((nuevaPorcionI)).toString(), style: const TextStyle(fontStyle: FontStyle.normal,color: Colors.blue,fontSize: 15,fontFamily: 'genostff')),
                    const TextSpan(text: " g)", style: TextStyle(fontStyle: FontStyle.normal,color: Colors.blue,fontSize: 14,fontFamily: 'genostff')),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 143.0,
              child: Column(
                children: [
                  CupertinoSpinBox(
                    min: 1,
                    max: 20,
                    value: listaIngredienNumeroModificada[i],
                    
                    onChanged: (value) => {setState(() {
                      listaIngredienNumeroModificada[i]=value;
                      
                      
                      // print(listaIngredienNumeroModificada[i]);
                      // _varialbe=value;
                    })},
                  )
                ],
              ),
          ),
          
        ],
      ),
    );
  }
  preparacionReceta(RecetaC infoReceta){
      return ExpansionTile(
          title: const Text(
            "Preparación",
            style: TextStyle(fontSize: 24.0,color: Colors.green, fontWeight: FontWeight.bold,fontFamily: 'genostff'),
          ),
          children: <Widget>[
              Card(
                child: Text(
                  infoReceta.dishDescription.toString(),
                  style: const TextStyle(fontSize: 18, color: Colors.black,fontFamily: 'genostff'),
                ),
              ),
          ],
        );
  }
  observacionReceta(RecetaC infoReceta){
      return ExpansionTile(
          title: const Text(
            "Observación",
            style: TextStyle(fontSize: 24.0,color: Colors.green, fontWeight: FontWeight.bold,fontFamily: 'genostff'),
          ),
          children: <Widget>[
              Card(
                child: Text(
                  infoReceta.dishObservations.toString(),
                  style: const TextStyle(fontSize: 18, color: Colors.black,fontFamily: 'genostff'),
                ),
              ),
          ],
        );
  }
}

