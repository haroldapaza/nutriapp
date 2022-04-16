import 'package:flutter/material.dart';
import 'package:nutriapp/constants/constant.dart';
import 'package:nutriapp/pages/navegation/pages/recetas/data/receta.data.dart';
import 'package:nutriapp/pages/navegation/pages/recetas/models/receta.model.dart';
import 'package:http/http.dart' as http;
import 'infoReceta.widget.dart';

// ignore: must_be_immutable
class BuscarReceta extends StatefulWidget {
  String valorBusqueda;
  BuscarReceta(this.valorBusqueda, {Key? key}) : super(key: key);

  @override
  State<BuscarReceta> createState() => _BuscarRecetaState();
}

class _BuscarRecetaState extends State<BuscarReceta> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  return RecetaList(receta: snapshot.data!,valorReceta:widget.valorBusqueda);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            
            
          ],
        )
      ),
    );
  }
  buscadorFlotante(){
    return Positioned(
              left: 30.0,
              top: 30.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                width: 280.0,
                height: 40.0,
                 decoration: const BoxDecoration(color: Colors.white),
                child: TextFormField(
                          initialValue: widget.valorBusqueda,
                          decoration: InputDecoration(
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
                            // print(value);
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
  
  botonReceta(RecetaC recetas){
    return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
          ),
          onPressed: () {
            setState(() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => InfoReceta(recetas)
              ));
              // (Route<dynamic> route) => false);
            });
          },
          child: Column(
            children: [
              SizedBox(
                child: Image.network(recetas.imgs.url,height: 120,)
              ),
              Expanded(
                flex: 2,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    recetas.dishName,
                    style: const TextStyle(fontSize: 16, color: Colors.black,fontFamily: 'genostff',),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    sumarLista(recetas).toString()+" Kcal",
                    style: const TextStyle(fontSize: 15, color: Colors.black,fontFamily: 'genostff'),
                    textAlign: TextAlign.center,
                  ),
                ],
                ),
              )

            ],
        ),
          
        );
  }
}

// ignore: must_be_immutable
class RecetaList extends StatefulWidget {
  RecetaList({
    Key? key,
    required this.valorReceta,
    required this.receta,
  }) : super(key: key);
  String valorReceta;
  final List<RecetaC> receta;
  @override
  State<RecetaList> createState() => _RecetaListState();
}

class _RecetaListState extends State<RecetaList> {
  List<RecetaC> searchRecetaList=[];
  final focus = FocusNode();
  @override
  void initState() {
    if(widget.valorReceta.isNotEmpty){
      filterSearch(widget.valorReceta);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        scroll(searchRecetaList),
        buscarReceta(widget.receta,widget.valorReceta)
      ],
    );
  }

  scroll(List<RecetaC> recetas){
    return condition(recetas);
  }
  buscarReceta(List<RecetaC> receta, String valorRecetaSearch){
    return Positioned(
              left: 30.0,
              top: 30.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                width: 280.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  initialValue: valorRecetaSearch,
                  decoration: InputDecoration(
                    hoverColor: Colors.amber,
                    prefixIcon: const Icon(Icons.search),
                    labelText: "Buscar Receta",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(),
                      
                    )
                    //fillColor: Colors.green
                  ),
                  onFieldSubmitted:(value) {
                    FocusScope.of(context).requestFocus(focus);
                    setState(() {
                      // print(value);
                        filterSearch(value);
                    });
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
  condition(List<RecetaC> recetas){
    if(recetas.isNotEmpty){
        return columCard(recetas);
      }else{return columCardVacio();}
  }
  columCard(List<RecetaC> recetas){
    return 
    Container(
      margin:const EdgeInsets.only(top: 50),
      child: ListView.builder(
            itemCount: recetas.length,
            itemBuilder: (context, index) {
              return Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
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
                  child:Card(
                    color: Colors.white,
                  child: Column(
                    
                    children: [
                      Container(
                        height: 150.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(recetas[index].imgs.url)),
                          borderRadius: const BorderRadius.only(topRight: Radius.elliptical(34, 23),topLeft: Radius.elliptical(34, 23)),
                          color: Colors.redAccent,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          recetas[index].dishName,
                          style: Constant.tituloReceta,
                          ), 
                        subtitle: Text(sumarLista(recetas[index]).toString()+" Kcal",style: const TextStyle(fontFamily: 'genostff',fontSize: 15))
                      ),
                    ],
                  ),
                ), 
                ),
              );
            },
          ),
    );
  }
  columCardVacio(){
    return Column(
            children:const[
              Card(
              child: ListTile(
                title: Text(
                  "Lista ",
                  style: TextStyle(color:Colors.white),
                  ), 
                subtitle: Text('Lista Vacia',style: TextStyle(color:Colors.white),)
              ),
            ),
            Text("Receta no Encontrada!",style: TextStyle(fontSize: 20,color: Colors.red),)
            ],
          );
  }
  filterSearch(String query) {
    
    List<RecetaC> resultListReceta=[];
    searchRecetaList.addAll(widget.receta);

    if (query.isNotEmpty) {
      resultListReceta.clear();
      for (var item in widget.receta) {
        if (item.dishName.contains(query)) {
          resultListReceta.add(item);
        }
      }
      setState(() {
        searchRecetaList.clear();
        searchRecetaList.addAll(resultListReceta);
      });
      return;
    } else {
      setState(() {
        searchRecetaList.clear();
        searchRecetaList.addAll(widget.receta);
      });
    }
  }
}
