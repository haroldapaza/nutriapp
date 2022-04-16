// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutriapp/constants/constant.dart';
import 'package:nutriapp/pages/navegation/pages/alimentos/widgets/alimentos.widget.dart';
import 'package:nutriapp/pages/navegation/pages/plan/data/plan.data.dart';
import 'package:nutriapp/pages/navegation/pages/plan/models/plan.model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class DividerPlan extends StatefulWidget {
  const DividerPlan({Key? key}) : super(key: key);

  @override
  State<DividerPlan> createState() => _DividerPlanState();
}

class _DividerPlanState extends State<DividerPlan> {
  dynamic fecha= DateFormat('EEEE').format(DateTime.now());
  DateTime now= DateTime.now();
  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          contarDias(),
          FutureBuilder<List<PlanC>>(
            future: fetchPlan(http.Client()),
            // // initialData: [],
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Ocurrio un Error!'),
                );
              } else if (snapshot.hasData) {
                final List<PlanC> planG=[];
                final List<PlanC> planGFecha=[];
                
                  List<PlanC> listaD=[];
                  List<PlanC> listaA=[];
                  List<PlanC> listaC=[];
                // print("______________________________________________");
                // print(now.subtract(const Duration(days: -2)));
                planG.addAll(snapshot.data!);
                for(var items in planG){
                    if((items.fecha).toString().split('T')[0]==now.toString().split(' ')[0]){
                        planGFecha.add(items);   
                    }
                  }
                for(int item=0;item<3;item++){
                  if(item==0){
                    listaD=selectPlan(planGFecha,'DESAYUNO');
                  }else if(item==1){
                    listaA=selectPlan(planGFecha,'ALMUERZO');
                  }else if(item==2){
                    listaC=selectPlan(planGFecha,'CENA');
                  }
                }
                return ListaPlan(listaDesayuno: listaD,listaAlmuerzo: listaA,listaCena: listaC);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          
          
        ],
      )
    );
  }
  contarDias(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: (){
            setState(() {
              now=now.subtract(const Duration(days: 1));
            });
          },
          child: const Icon(Icons.chevron_left_outlined,size: 35,color: Colors.amber,),
        ),
        Text(opcionesDias(DateFormat('EEEE').format(now)),style: const TextStyle(fontSize: 24,fontFamily: 'genostff',fontWeight: FontWeight.bold,color: Colors.lightBlue),),
        TextButton(
          onPressed: (){
            setState(() {
              now=now.subtract(const Duration(days: -1));
            });
          },
          child: const Icon(Icons.chevron_right_outlined,size: 35,color: Colors.amber),
        ),
      ],
    );
  }

}

class ListaPlan extends StatefulWidget {
  const ListaPlan({Key? key,required this.listaDesayuno,required this.listaAlmuerzo,required this.listaCena}) : super(key: key);
  final List<PlanC> listaDesayuno;
  final List<PlanC> listaAlmuerzo;
  final List<PlanC> listaCena;
  
  @override
  _ListaPlanState createState() => _ListaPlanState();
}

class _ListaPlanState extends State<ListaPlan> {

  final List<String> titulosReceta = ["Desayunos","Almuerzos","Cenas"];
  List<String> alimentos=['camote','arroz','charlote'];
  List<String> tag=['kcal','g','g','g'];
  List<double> sumaTotalT=[0.0,0.0,0.0,0.0];
  dynamic fecha= DateFormat('EEEE').format(DateTime.now());
  SharedPreferences? sharedPreferences;
  dynamic proteinas="";
  dynamic grasas="";
  dynamic carbs="";
  dynamic kcal="";
  bool loading=false;
  @override
  void initState() {
    fecha=DateFormat('EEEE').format(DateTime.now());
    sumaTotalT=sumaTresListas(widget.listaDesayuno,widget.listaAlmuerzo,widget.listaCena);
    getNutrientes();
    super.initState();
  }

  getNutrientes()async{
    sharedPreferences= await SharedPreferences.getInstance();
    
    setState(() {
      proteinas = sharedPreferences!.getString('proteinas');
    grasas = sharedPreferences!.getString('grasas');
    carbs = sharedPreferences!.getString('carbs');
    kcal= sharedPreferences!.getString('kcal');
      loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
          
          children: <Widget>[
            Container(
              height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              
              child: loading?const Center(child:CircularProgressIndicator()): Column(
                
                children: [
                  // contarDias(),
                  const SizedBox(height: 30,),
                  // const Text("Hoy",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18),),
                  Row(
                    
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Expanded(
                        flex: 2,
                        child: Text(""+sumaTotalT[0].toString()+"/\n"+kcal.toString()+"\nkcal",style: const TextStyle(fontFamily: 'genostff',fontSize: 18,fontWeight: FontWeight.bold))),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: const[
                            Text('Protein ', 
                            style: 
                              TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'genostff',
                                fontSize: 15
                              )
                            ),
                            Text('Carbs ', style:
                            TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'genostff',
                              fontSize: 15,
                              )),
                            Text('Grasas', style: 
                            TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'genostff',
                              fontSize: 15
                              )),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text(''+sumaTotalT[1].toString()+'/'+proteinas.toString()+" g",style: const TextStyle(fontFamily: 'genostff',fontSize: 16,fontWeight: FontWeight.bold)),
                            Text(''+sumaTotalT[2].toString()+'/'+carbs.toString()+" g",style: const TextStyle(fontFamily: 'genostff',fontSize: 16,fontWeight: FontWeight.bold)),
                            Text(''+sumaTotalT[3].toString()+'/'+grasas.toString()+" g",style: const TextStyle(fontFamily: 'genostff',fontSize: 16,fontWeight: FontWeight.bold)),
                          ],
                          
                        ),
                      )
                    ],
                  ),
                ],
              )
            ),
            Expanded(
              child: Stack(
                children: [
                  scroll(),
                ],
              ),
            ),
          ],
        ),
    );
  }
  
  contarDias(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: (){

          },
          child: const Icon(Icons.chevron_left_outlined),
        ),
        Text(opcionesDias(fecha),style: const TextStyle(fontSize: 12,fontFamily: 'genostff'),),
        TextButton(
          onPressed: (){

          },
          child: const Icon(Icons.chevron_right_outlined),
        ),
      ],
    );
  }
  scroll(){
    int item;
    return SingleChildScrollView(
      child: Card(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for(item=0;item<3;item++)
                condition(item),            
            ],
          ),
      ),
      );
  }
  condition(int item){
    if(item==0){
      if(widget.listaDesayuno.isNotEmpty){
        return columCard(widget.listaDesayuno,item);
      }else{return columCardVacio(item);}
    }
    if(item==1){
      if(widget.listaAlmuerzo.isNotEmpty){
        return columCard(widget.listaAlmuerzo,item);
      }else{return columCardVacio(item);}
    }
    if(item==2){
      if(widget.listaCena.isNotEmpty){
        return columCard(widget.listaCena,item);
      }else{return columCardVacio(item);}
    }

  }
  columCard(List<PlanC> plan, int item){
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 13,
      
      child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    title: Text(
                      titulosReceta[item],
                      style: Constant.tituloReceta,
                      ), 
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for(var i=0;i<4;i++)
                          infoNutri(plan,i),
                      ],
                    ),
                  ),
                ),
                listadoAlimentos(plan,item),
                buttonAdd()
              ],
            ),
    );
  }
  listadoAlimentos(List<PlanC> plan, int item){
    return SizedBox(
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: plan.length,
        itemBuilder: (BuildContext context, int index) {
          final item = plan[index];
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {
                   plan.removeAt(index);
                  sumaTotalT=sumaTresListas(widget.listaDesayuno,widget.listaAlmuerzo,widget.listaCena);
                  // widget.planG.clear();
                  // print("eliminado"+index.toString());
                  deleteItemPlan(item.planId);
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(''+item.alimentoReceta+' Eliminado',style: const TextStyle(fontFamily: 'genostff',fontSize: 18))));
              },
              background: Container(color: Colors.red,child: const Icon(Icons.delete,color: Colors.white,),),
              
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                plan[index].alimentoReceta,
                                style: const TextStyle(fontSize: 16, color: Colors.black,fontFamily: 'genostff'),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: plan[index].cantidad.toString()+" ",style: const TextStyle(fontSize: 14), // default text style
                                  children: <TextSpan>[
                                    TextSpan(text: plan[index].unidad.toString(), style: const TextStyle(color: Colors.amber)),
                                  ],
                                ),
                              ),
                              Text(
                                plan[index].kcal.toString()+" kcal",
                                style: const TextStyle(color: Colors.black,fontFamily: 'genostff',fontSize: 18),
                              ),
                              
                            ],
                          ),
                        ),  
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: const [
                              Icon(Icons.check_circle,color: Colors.green,)
                            ],
                          ) 
                          )
                        
                      ],
                    ),
                    const SizedBox(height: 8,)

                  ],
                  
                ),
              ),
            );
        }
          
      ),
    );
  }
  columCardVacio(int item){
    return Column(
            children: [
              Card(
              child: ListTile(
                title: Text(
                  titulosReceta[item],
                  style: Constant.tituloReceta,
                  ), 
                subtitle: const Text('Ud puede agregar alimentos aqui todo los dias',style: TextStyle(fontFamily: 'genostff',fontSize: 18))
              ),
            ),
            Text("No hay plan para ${titulosReceta[item]}",style: const TextStyle(fontFamily: 'genostff',fontSize: 14,fontWeight: FontWeight.bold)),
            buttonAdd()
            ],
          );
  }
  infoNutri(List<PlanC> plan,int i) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 6),
        Text.rich(
          TextSpan(
            text: sumaListaPlan(plan)[i].toString(),style: const TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold), // default text style
            children: <TextSpan>[
              TextSpan(text: tag[i], style: const TextStyle(fontStyle: FontStyle.normal,color: Colors.blue)),
            ],
          ),
        ),
      ],
    );
  }
  buttonAdd(){
    return SizedBox(
      height: 34,
      child: TextButton.icon(
        onPressed: (){
          Navigator.of(context).push(
             MaterialPageRoute(
               builder: (BuildContext context) => const Alimentos()
            ));
          
        }, 
        icon: const Icon(Icons.add,color: Colors.green,), 
        label: const Text("Agregar Alimento",style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold),),

        ),
    );
        
      // child: ElevatedButton(

      //     onPressed:(){
      //       setState(() {
              
      //       });
      //     }, 
      //     child: const ListTile(
      //             leading: Icon(Icons.add_box_outlined,color: Colors.blue),
      //             title: Text('Agregar Alimento'),
      //           ),
          
      //     // style: ElevatedButton.styleFrom(
      //     //   primary: Colors.white,
      //     // ),
      //   ),
    
  }
}


const colors = [
  Colors.red,
  Colors.green,
  Colors.greenAccent,
  Colors.amberAccent,
  Colors.blue,
  Colors.amber,
];
