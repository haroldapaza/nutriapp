import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinbox/cupertino.dart';
import 'package:nutriapp/data/datosglobal.dart';
import 'package:nutriapp/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../main.dart';
enum SingingCharacter {h, m}
class RegistroUser extends StatefulWidget {
  const RegistroUser({Key? key}) : super(key: key);

  @override
  _RegistroUserState createState() => _RegistroUserState();
}

class _RegistroUserState extends State<RegistroUser> {
  DateTime selectedDate = DateTime.now();
  bool _isLoading = false;
  SharedPreferences? sharedPreferences;

  final TextEditingController apellidoDato = TextEditingController();
  final TextEditingController nombreDato = TextEditingController();
  final TextEditingController nicknameDato = TextEditingController();
  DateTime fechaNacimientoDato= DateTime.now();
  dynamic alturaDato=70.0;
  dynamic pesoDato=70.0;
  dynamic actiFisicaDato=3.0;
  dynamic edadDato=18.0;
  String sexoDato="M";
  int idVal=1;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,

        firstDate: DateTime(1970, 8),
        lastDate: DateTime(2025));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        fechaNacimientoDato=picked;
      });
    }
  }
  final TextStyle miStylo=const TextStyle(fontSize: 18);
  // @override
  // void initState() {
  //   print(_character);
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading ? const Center(child: CircularProgressIndicator()) : ListView(
          children: <Widget>[
            const Text("Registro de Datos",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w400),),
            const SizedBox(height: 12,),
              apellidos(),
              nombres(),
              nickname(),
              sexoUser(),
              fechaNacimiento(),
              edadUser(),
              alturaUser(),
              pesoUser(),
              actividadFisica(),
              registroButton()
          ],
        ),
      ),
    );
  }
  registrar(String apellido,String nombre,String nickname,String sexo,dynamic edad,DateTime nacimiento,dynamic altura,dynamic peso, dynamic actiFisica)async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    dynamic userId= sharedPreferences.getString('userid');
    Map data = {
      'lastName': apellido.toString(),
      'firstName': nombre.toString(),
      'nickName': nickname.toString(),
      'sexo':sexo.toString(),
      'edad':edad.toString(),
      'birthData': nacimiento.toString(),
      'height': altura.toString(),
      'actividadFisica':actiFisica.toString()
    };
    // print(data);
    Map dataPeso = {
      'weight': peso.toString(),
      'person_id':userId.toString()
    };
    // print(dataPeso);
    dynamic jsonResponse,jsonResponsePeso;
    var log=AuthRepository();
    // print("IIIIDdddddddDdDdDdDdDd"+context.watch<UserC>().userNombre);
    var response=await log.personUpdate(data);
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if(jsonResponse['exito']==true){

        // setState(() {
        //   _isLoading = false;
        // });
        var responsePeso=await log.personPeso(dataPeso);
        if(response.statusCode == 200) {
          jsonResponsePeso = json.decode(responsePeso.body);
          if(jsonResponsePeso['exito']==true){
            setState(() {
              _isLoading = false;
            });

            await sharedPreferences.setString("nombre", nombre.toString());
            await sharedPreferences.setString("apellido", apellido.toString());
            // await sharedPreferences.setString("userid", "1");
            await sharedPreferences.setString('sexo',sexo.toString());
            await sharedPreferences.setInt('edad', edad.toInt());
            await sharedPreferences.setInt('altura',altura.toInt());
            await sharedPreferences.setInt('peso', peso.toInt());
            await sharedPreferences.setInt('actifisica',actiFisica.toInt());
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const MyApp()), (Route<dynamic> route) => false);
          }
        }
      }else{
        setState(() {
          _isLoading = false;
        });
        if(jsonResponse['error']=="Expired token"){
          logOut();
        }
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      // ignore: avoid_print
      print(response.body);
    }
  }
  
  apellidos(){
    return SizedBox(
      height: 45,
      child: TextFormField(

        controller: apellidoDato,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: 'Apellidos',
          hintStyle: miStylo,
        ),
        
      ),
    );
  }

  nombres(){
    return Container(
      margin: const EdgeInsets.only(top: 6.0),
      height: 45,
      child: TextFormField(
        controller: nombreDato,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: 'Nombres',
          hintStyle: miStylo,
        ),
      ),
    );
  }
  nickname(){
    return Container(
      height: 45,
      margin: const EdgeInsets.only(top: 5.0),
      child: TextField(
        controller: nicknameDato,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: 'NickName',
          hintStyle: miStylo,
        ),
      ),
    );
  }
  fechaNacimiento(){
    return Container(
      height: 45,
      // padding: const EdgeInsets.symmetric(horizontal: 30.0),
      margin: const EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
          SizedBox(
            width: 180,
            height: 30,
            child: ElevatedButton( 
              onPressed: () => _selectDate(context),
              child: Text('Fecha de Nacimiento',style: miStylo,),
            ),
          ),
          Text(
            "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}    ",
            style: const TextStyle(fontSize: 25),
              
          ),
        ],
      ),
    );
  }

  alturaUser(){
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text("Altura (cm)", style: miStylo),
          ),
          Expanded(
            flex: 2,
            // width: 223.0,
              child: Column(
                children:[
                  CupertinoSpinBox(
              min: 10,
              max: 260,
              value: alturaDato,
              
              onChanged: (value) => {setState(() {
                alturaDato=value;
              })},
            )
                  
                ],
              ),
          ),
          
        ],
      ),
    );
  }
  pesoUser(){
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 30.0),
      margin: const EdgeInsets.only(top: 5.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text("Peso (kg)", style: miStylo),
          ),
          Expanded(
            flex: 2,
            // width: 223.0,
              child: Column(
                children:[
                  CupertinoSpinBox(
              min: 20,
              max: 130,
              value: pesoDato,
              
              onChanged: (value) => {setState(() {
                pesoDato=value;
              })},
            )
                  
                ],
              ),
          ),
          
        ],
      ),
    );
  }
  actividadFisica(){
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 30.0),
      margin: const EdgeInsets.only(top: 5.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text("Actividad Fisica", style: miStylo),
          ),
          Expanded(
            flex: 2,
            // width: 223.0,
              child: Column(
                children:[
                  CupertinoSpinBox(
              min: 1,
              max: 7,
              value: actiFisicaDato,
              
              onChanged: (value) => {setState(() {
                actiFisicaDato=value;
              })},
            )
                  
                ],
              ),
          ),
          
        ],
      ),
    );
  }

  sexoUser(){
    return Container(
      height: 45,
      margin: const EdgeInsets.only(top: 6.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0) 
        ),
      ),
      
      child: Row(

        children: [
          const SizedBox(width: 20,),
          Expanded(
            flex: 1,
            child: Text("Genero", style: miStylo),
          ),
          Expanded(
            flex: 2,
              child: Row(
                children: <Widget>[
                  Text("Hombre", style: miStylo),
                  Radio(
                    value: 1,
                    groupValue: idVal,
                    onChanged: (value){
                      setState(() {
                        idVal=1;
                        sexoDato="M";
                      });
                    }
                  ),
                  Text("Mujer", style: miStylo),
                  Radio(
                    value: 2,
                    groupValue: idVal,
                    onChanged: (T){
                      setState(() {
                        idVal=2;
                        sexoDato="F";
                      });
                    }
                  )
                ],
              )
          ),
          
        ],
      ),
    );
  }
  edadUser(){
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text("Edad", style: miStylo),
          ),
          Expanded(
            flex: 2,
            // width: 223.0,
              child: Column(
                children:[
                  CupertinoSpinBox(
              min: 8,
              max: 65,
              value: edadDato,
              
              onChanged: (value) => {setState(() {
                edadDato=value;
              })},
            )
                  
                ],
              ),
          ),
          
        ],
      ),
    );
  }
  registroButton(){
    return ElevatedButton(
      onPressed: apellidoDato.text == ""||nombreDato.text == ""|| nicknameDato.text == "" ? null : () {
          setState(() {
            _isLoading = true;
          });
          registrar(apellidoDato.text, nombreDato.text,nicknameDato.text,sexoDato,edadDato,fechaNacimientoDato,alturaDato,pesoDato,actiFisicaDato);
        },
      child: const Text('Registrar',style: TextStyle(fontSize: 26),),
      style: ElevatedButton.styleFrom(
          primary: Colors.green,
        ),
    );
  }
}