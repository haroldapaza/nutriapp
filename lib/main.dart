


// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:nutriapp/pages/navegation/pages/advertencias/widgets/advertencias.widget.dart';
import 'package:nutriapp/pages/navegation/pages/alimentos/widgets/alimentos.widget.dart';
import 'package:nutriapp/pages/navegation/pages/distribucionCalorica/widgets/distribucion.widget.dart';
import 'package:nutriapp/pages/navegation/pages/plan/widgets/plan.widget.dart';
import 'package:nutriapp/pages/navegation/pages/recetas/widgets/receta.widget.dart';
import 'package:nutriapp/pages/navegation/pages/recomendaciones/widgets/recomendaciones.widget.dart';
import 'package:nutriapp/pages/navegation/pages/usuario/widgets/user.widget.dart';

import 'package:nutriapp/pages/objetivos/widgets/objetivo.dart';
import 'package:nutriapp/splasscrean.dart';

import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/users/user.model.dart';
import 'pages/navegation/pages/usuario/widgets/registro.widget.dart';
import 'pages/publicidad/widget/alert.publicidad.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserC()),
      ],
      child:MaterialApp(
        theme: ThemeData(fontFamily: 'genostff'), 
        debugShowCheckedModeBanner: false,
        home: const Splasscreen(),
      )
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectDrawerItem=0;
  bool _isLoading = false;
  dynamic token;
  dynamic userId;
  dynamic nombre;
  dynamic apellido;
  dynamic publi;
  dynamic sexo;
  dynamic edad;
  dynamic altura=1.0;
  dynamic gmail;
  dynamic peso=1.0;
  dynamic actiFisica=2;
  SharedPreferences? sharedPreferences;
  List<String> titulos=['Distribucion Calorica','Plan','Receta','Alimentos','Recomendaciones','Advertencias','Usuario'];
  @override
  void initState() {
    checkLoginStatus();
    sharedPref();
    super.initState();
    // logOut();
    
  }
sharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token =sharedPreferences!.getString('token');
    userId= sharedPreferences!.getString('userid');
    nombre= sharedPreferences!.getString('nombre');
    apellido= sharedPreferences!.getString('apellido');
    gmail = sharedPreferences!.getString('gmail');
    publi = sharedPreferences!.getString('publi');
    // sexo = sharedPreferences!.getString('sexo');
    // edad = sharedPreferences!.getInt('edad');
    // altura = sharedPreferences!.getInt('altura');
    // peso = sharedPreferences!.getInt('peso');
    // actiFisica = sharedPreferences!.getInt('actifisica');

    if (sexo != "" && edad != "" && altura != "" &&sexo != null && edad != null && altura != null) {
      // print(edad);
      // print(altura);
      setState(() {
        _isLoading = false;
      });
    }
  }
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    

    if(sharedPreferences!.getString("token") == null){
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => const Objetivo(),
      ), (Route<dynamic> route) => false);
    // Navigator.pushReplacementNamed(context, '/objetivos');
    }else {
      
      if(sharedPreferences!.getString("nombre")==""){
      // if(true){
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => const RegistroUser(),
        ), (Route<dynamic> route) => false);
      }
    }
  }
  @override
  Widget build(BuildContext context){
    return _isLoading
            ? const Center(child: CircularProgressIndicator())
            :Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ventana(),
             Text(titulos[selectDrawerItem],style: const TextStyle(fontFamily: 'genostff',fontSize: 28,fontWeight: FontWeight.bold)),
              
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             UserAccountsDrawerHeader(
              accountName: Text(obtenerNombres()+" "+obtenerApellido(),style: const TextStyle(fontFamily: 'genostff',fontSize: 18)),
              // accountName: Text((sharedPreferences!.getString("nombre")!).toString()),
              accountEmail: Text((obtenerGmail()!="")?obtenerGmail():"Bienvenido",style: const TextStyle(fontFamily: 'genostff',fontSize: 18)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child:Text((obtenerNombres()!="")?(obtenerNombres().toString().split('')[0].toUpperCase()):"B",style: const TextStyle(fontFamily: 'genostff',fontSize: 50)),
                ) 
               
            ),
            ListTile(
              leading: const Icon(Icons.vertical_distribute),
              title: const Text('Distribucion Calorica',style: TextStyle(fontFamily: 'genostff',fontSize: 17,fontWeight: FontWeight.bold)),
              selected: (0==selectDrawerItem),
              onTap: () {
                Navigator.of(context).pop();
                onSelectItem(0);
                
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory_outlined),
              title: const Text('Plan',style: TextStyle(fontFamily: 'genostff',fontSize: 17,fontWeight: FontWeight.bold)),
              selected: (1==selectDrawerItem),
              onTap: () {
                Navigator.of(context).pop();
                onSelectItem(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.food_bank_outlined),
              title: const Text('Receta',style: TextStyle(fontFamily: 'genostff',fontSize: 17,fontWeight: FontWeight.bold)),
              selected: (2==selectDrawerItem),
              onTap: () {
                Navigator.of(context).pop();
                onSelectItem(2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.set_meal_outlined),
              title: const Text('Alimentos',style: TextStyle(fontFamily: 'genostff',fontSize: 17,fontWeight: FontWeight.bold)),
              selected: (3==selectDrawerItem),
              onTap: () {
                Navigator.of(context).pop();
                onSelectItem(3);
              },
            ),
            ListTile(
              leading: const Icon(Icons.recommend),
              title: const Text('Recomendacion',style: TextStyle(fontFamily: 'genostff',fontSize: 17,fontWeight: FontWeight.bold)),
              selected: (4==selectDrawerItem),
              onTap: () {
                Navigator.of(context).pop();
                onSelectItem(4);
              },
            ),
            ListTile(
              leading: const Icon(Icons.warning_amber),
              title: const Text('Advertencias',style: TextStyle(fontFamily: 'genostff',fontSize: 17,fontWeight: FontWeight.bold)),
              selected: (5==selectDrawerItem),
              onTap: () {
                Navigator.of(context).pop();
                onSelectItem(5);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person,),
              title: const Text('Usuario',style: TextStyle(fontFamily: 'genostff',fontSize: 17,fontWeight: FontWeight.bold)),
              selected: (6==selectDrawerItem),
              onTap: () {
                Navigator.of(context).pop();
                onSelectItem(6);
              },
            ),
          ],
        ),
    ),
      body: navigationDrawer(selectDrawerItem)
    );
  }
   ventana(){
     
    // ignore: unrelated_type_equality_checks
    if(nombre!=null && token!=null && nombre!=""){
      return const MyAlertD();
    }else{
      return const Text("");
    }
  }
  // obtenerNombre()async{
  //   SharedPreferences sharedPreferences;
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   if(sharedPreferences.getString("nombre")!=null){
  //     return sharedPreferences.getString("nombre").toString();
  //   }else{
  //     return null;
  //   }
  // }
  // obtenerToken()async{
  //   SharedPreferences sharedPreferences;
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   if(sharedPreferences.getString("token")!=null){
  //     return sharedPreferences.getString("token").toString();
  //   }else{
  //     return null;
  //   }
  // }
  obtenerPubli()async{
    DateTime now= DateTime.now();
    String newDate;
    if(publi!=null){
      newDate=now.toString().split(' ')[0];
      if(newDate==publi){
        sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences!.remove('publi');
        return null;
      }else{
        return publi;
      } 
    }else{
      return null;
    }
  }
   obtenerNombres(){
    if(nombre!=null){
      return nombre;
    }else{
      return "";
    }
  }
  obtenerApellido(){
    if(apellido!=null){
      return apellido;
    }else{
      return "";
    }
  }
  obtenerGmail(){
    if(gmail!=null){
      return gmail;
    }else{
      return "";
    }
  }
   navigationDrawer(int pos){
    switch(pos){
      case 0:return const DistribucionC();
      case 1:return const Plan();
      case 2:return const Receta();
      case 3:return const Alimentos();
      case 4:return const RecomendacionesImg();
      case 5:return const Advertencias();
      case 6:return const User();
    }
  }
  onSelectItem(int pos){
    setState(() {
      selectDrawerItem=pos;
    });
  } 
}
