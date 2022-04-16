import 'package:flutter/material.dart';
import 'package:nutriapp/models/objetivo/objetivo.models.dart';
import 'package:nutriapp/pages/login/widgets/login.dart';
import 'package:nutriapp/pages/objetivos/data/objetivo.data.dart';

class Objetivo extends StatefulWidget {
  const Objetivo({Key? key}) : super(key: key);

  @override
  _ObjetivoState createState() => _ObjetivoState();
}

class _ObjetivoState extends State<Objetivo> {

  List<ObjetivoI> objetivos = [];

  @override
  void initState() {
    super.initState();
    objetivos = getObjetivos() as List<ObjetivoI>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: ListView(
          children: <Widget>[
            _getTitle(),
            for(var item in objetivos)
              buttonSection(item),
          ],
        ),
      )
    );
  }
  Container _getTitle(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100.0,
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      margin: const EdgeInsets.only(top: 35.0),
      child: Center(
        child: Builder(
          builder: (context) {
            return const Text(
              "¿Cual es tu Objetivo",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),);
          }
        )),
    );
  }
  Container buttonSection(ObjetivoI objetivos) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90.0,
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      margin: const EdgeInsets.only(top: 25.0),
      
      child: ElevatedButton(
        onPressed: () {
          setState(() {
           Navigator.of(context).push(
             MaterialPageRoute(
               builder: (BuildContext context) => const LoginPage()
            ));
            // (Route<dynamic> route) => false);
          });
        },
        //elevation: 0.0,
        //color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(objetivos.getUrl())
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
              mainAxisSize: MainAxisSize.min,
              children: [
                 Text(
                   objetivos.getTitulo(),
                   style: const TextStyle(fontSize: 15, color: Colors.black),
                   textAlign: TextAlign.center,
                 ),
                 const SizedBox(height: 12),
                 Text(
                   objetivos.getTexto(),
                   style: const TextStyle(fontSize: 12, color: Colors.black),
                   textAlign: TextAlign.center,
                 ),
              ],
              ),
            )
          ],
          
        ),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
        ),
      ),
    );
  }

}