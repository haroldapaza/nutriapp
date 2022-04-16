

import 'package:flutter/material.dart';
import 'package:nutriapp/pages/navegation/pages/advertencias/data/advertencias.data.dart';
import 'package:nutriapp/pages/navegation/pages/advertencias/models/advertencia.model.dart';

class Advertencias extends StatefulWidget {
  const Advertencias({Key? key}) : super(key: key);

  @override
  _AdvertenciasState createState() => _AdvertenciasState();
}

class _AdvertenciasState extends State<Advertencias> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 12,right: 12,top: 12),
      children: [
        for(var item in getDatoAdvertencias())
          itemAdvertencia(item)
      ],
    );
  }

  itemAdvertencia(AdvertenciaC advertItem){
    return Card(
          elevation: 14,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 12,right: 12,top: 12),
                child: Text(advertItem.titulo,style: const TextStyle(fontSize: 20,color: Colors.blue,fontWeight: FontWeight.bold),)
              ),
              Container(
                padding: const EdgeInsets.only(left: 12,right: 12,top: 12),
                child: Text(advertItem.text,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)
              ),
              ExpansionTile(
                title: const Text(
                  "Evitar Comer",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.red),
                ),
                children: <Widget>[
                   for(int i=0;i<advertItem.advertencias.length;i++)
                      listaAdver(advertItem.advertencias[i],i)
                ],
              ),
            ],
          ),
        );
  }
  listaAdver(String adver,int i){
    return Container(
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
          Container(
            padding: const EdgeInsets.only(left: 12,right: 12,top: 12,bottom: 12),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Text((i+1).toString(),style: const TextStyle(color: Colors.white),),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 12,right: 5,),
                          child: Text(
                            adver,
                            style: const TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),  
              ],
            ),
          ),
        ],
      )
    );
  }
}