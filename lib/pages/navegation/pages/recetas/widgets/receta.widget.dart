

import 'package:flutter/material.dart';
import 'package:nutriapp/constants/constant.dart';
import 'package:nutriapp/pages/navegation/pages/recetas/data/receta.data.dart';
import 'package:nutriapp/pages/navegation/pages/recetas/models/receta.model.dart';
import 'package:http/http.dart' as http;
import 'package:nutriapp/pages/navegation/pages/recetas/widgets/buscarReceta.widget.dart';

import 'infoReceta.widget.dart';
class Receta extends StatefulWidget {
  const Receta({Key? key}) : super(key: key);
  @override
  _RecetaState createState() => _RecetaState();
}
class _RecetaState extends State<Receta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          FutureBuilder<List<RecetaC>>(
            future: fetchReceta(http.Client()),
            // // initialData: [],
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return RecetaList(receta: snapshot.data!);
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

  
}

class RecetaList extends StatefulWidget {
  const RecetaList({
    Key? key,
    required this.receta,
  }) : super(key: key);

  final List<RecetaC> receta;

  @override
  State<RecetaList> createState() => _RecetaListState();
}

class _RecetaListState extends State<RecetaList> {
  final List<String> titulosReceta = ["Desayunos","Almuerzos","Cenas"];
  final focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        scroll(widget.receta),
        buscarReceta(widget.receta)
      ],
    );
  }

  scroll(List<RecetaC> recetas){
    int item;

    return SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Headline',
              style: TextStyle(fontSize: 26),
            ),
            for(item=0;item<3;item++)
              condition(recetas,item)
          ],
        ),
      );
  }

  buscarReceta(List<RecetaC> receta){
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
  condition(List<RecetaC> recetas,int item){
    List<RecetaC> nuevoDish =[];
    if(item==0){
      nuevoDish=selectReceta(recetas,'DESAYUNO');
      if(nuevoDish.isNotEmpty){
        return columCard(selectReceta(recetas,'DESAYUNO'),item);
      }else{return columCardVacio(item);}
    }
    if(item==1){
      nuevoDish=selectReceta(recetas,'ALMUERZO');
      if(nuevoDish.isNotEmpty){
        return columCard(selectReceta(recetas,'ALMUERZO'),item);
      }else{return columCardVacio(item);}
    }
    if(item==2){
      nuevoDish=selectReceta(recetas,'CENA');
      if(nuevoDish.isNotEmpty){
        return columCard(selectReceta(recetas,'CENA'),item);
      }else{return columCardVacio(item);}
    }

  }
  columCard(List<RecetaC> recetas, int item){
    return Column(
            children: [
              Card(
              child: ListTile(
                title: Text(
                  titulosReceta[item],
                  style: Constant.tituloReceta,
                  ), 
                subtitle: Text('Opciones de Receta de ${titulosReceta[item]}',style: const TextStyle(fontFamily: 'genostff',fontSize: 18))
              ),
            ),
            SizedBox(
              height: 190.0,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: recetas.length,
                itemBuilder: (BuildContext context, int index) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                      ),
                      onPressed: () {
                        setState(() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => InfoReceta(recetas[index])
                          ));
                          // (Route<dynamic> route) => false);
                        });
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            child: Image.network(recetas[index].imgs.url,height: 120,)
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                recetas[index].dishName,
                                style: const TextStyle( color: Colors.black,fontFamily: 'genostff',fontSize: 17,fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                sumarLista(recetas[index]).toString()+" Kcal",
                                style: const TextStyle(fontSize: 18, color: Colors.blue,fontWeight: FontWeight.bold,fontFamily: 'genostff'),
                                textAlign: TextAlign.center,
                              ),
                            ],
                            ),
                          )

                        ],
                    ),
                      
                    ),
              ),
            ),
            ],
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
                subtitle: Text("No hay opciones en ${titulosReceta[item]}",style: const TextStyle(fontFamily: 'genostff',fontSize: 18))
              ),
            ),
            Text("No hay Recetas para ${titulosReceta[item]}",style: const TextStyle(fontFamily: 'genostff',fontSize: 15,fontWeight: FontWeight.bold))
            ],
          );
  }
}
