import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nutriapp/pages/login/widgets/login.dart';
import 'package:nutriapp/pages/navegation/pages/usuario/models/userinfo.model.dart';
import 'package:nutriapp/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  bool _isLoading = false;
  SharedPreferences? sharedPreferences;
  dynamic token;
  dynamic userId;
  dynamic nombre;
  dynamic apellido;
  dynamic sexo;
  dynamic edad;
  dynamic altura;
  dynamic peso;
  dynamic actiFisica;
  List<UsuarioInfo> datosUser=[];
  final TextEditingController pesoDato = TextEditingController();
  @override
  void initState(){
    super.initState();
    sharedPref();
  }
  sharedPref()async{
    sharedPreferences = await SharedPreferences.getInstance();
    token =sharedPreferences!.getString('token');
    userId= sharedPreferences!.getString('userid');
    nombre= sharedPreferences!.getString('nombre');
    apellido= sharedPreferences!.getString('apellido');
    sexo= sharedPreferences!.getString('sexo');
    edad= sharedPreferences!.getInt('edad');
    altura= sharedPreferences!.getInt('altura');
    peso= sharedPreferences!.getInt('peso');
    actiFisica= sharedPreferences!.getInt('actifisica');
    if(userId!=""){
      setState(() {
          _isLoading = false;
        });
    }
    datosUser=[
      UsuarioInfo(dato: 'Id',respuesta: userId.toString()),
      UsuarioInfo(dato: 'Nombres',respuesta: nombre.toString()),
      UsuarioInfo(dato: 'Apellidos',respuesta: apellido.toString()),
      UsuarioInfo(dato: 'Sexo',respuesta: sexo.toString()),
      UsuarioInfo(dato: 'Edad',respuesta: edad.toString()),
      UsuarioInfo(dato: 'Altura',respuesta: altura.toString()),
      UsuarioInfo(dato: 'Peso',respuesta: peso.toString()),
      UsuarioInfo(dato: 'Actividad Física',respuesta: actiFisica.toString()),
    ];

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_isLoading ? const Center(child: CircularProgressIndicator()) : ListView(
        padding: const EdgeInsets.symmetric(vertical: 23,horizontal: 30),
        children: [
          Row(
            children: [
              const Text("Informacion Del Usuario",style: TextStyle(fontSize: 25,color: Colors.blue),),
              TextButton(
                onPressed:() => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Modifcar Peso'),
                      content: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: pesoDato,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Peso',
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: (){

                            Navigator.pop(context, 'Cancel');
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: (){
                            setState(() {
                              registrar(pesoDato.text);
                              datosUser[6].respuesta=pesoDato.text;
                            });
                            Navigator.pop(context, 'OK');
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
       
                child: const Icon(Icons.create_rounded,color: Colors.amber,)
                )
            ],
          ),

          const SizedBox(height: 12,),
          for(var user in datosUser)
            infoUsuario(user),  
          const SizedBox(height: 15,),
          TextButton(
            onPressed: (){
              setState(() {
                logOut();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const LoginPage()), (Route<dynamic> route) => false);
              });
            },
            child: const Text("Cerrar Session",style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),),
            ),        
        ],
      )
    );
  }
  logOut()async{
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.clear();
  }
  registrar(String peso1)async {
    sharedPreferences = await SharedPreferences.getInstance();
    dynamic userId= sharedPreferences!.getString('userid');
    Map dataPeso = {
      'weight': peso1.toString(),
      'person_id':userId.toString()
    };
    // print(dataPeso);
    dynamic jsonResponsePeso;
    var log=AuthRepository();
    var response=await log.personPeso(dataPeso);
    if(response.statusCode == 200) {
      jsonResponsePeso = json.decode(response.body);
      // print(":_____________________________________________");
      // print(jsonResponsePeso);
      if(jsonResponsePeso['exito']==true){
        // setState(() {
        //   _isLoad = false;
        // });
        
        await sharedPreferences!.setInt('peso',int.parse(peso1));
      }else{
        // print("No entroooooo000000000");
      }
      if(jsonResponsePeso['error']=="Expired token"){
        logOut();
      }
    }
      
  }

  infoUsuario(UsuarioInfo user){
    return Card(
      child: SizedBox(
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Text(user.datoG.toString(), style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold ),),
            ),
            Expanded(
              flex: 1,
              child: Text(": "+user.respuestaG.toString(),style: const TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }


}