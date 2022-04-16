import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nutriapp/constants/constant.dart';
import 'package:nutriapp/models/users/user.model.dart';
import 'package:nutriapp/pages/navegation/pages/usuario/widgets/registro.widget.dart';
import 'package:nutriapp/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  void showToastSucces() {  
    Fluttertoast.showToast(
        msg: "Inicio de Session Correcta",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
        
    );

  } 
  void showToastError() {  
    Fluttertoast.showToast(
        msg: "Correo o Contraseña Incorrecto",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
        
    ); 
  }
  void showToastBanneado() {  
    Fluttertoast.showToast(
        msg: "Sin Acceso, Usuario Bloqueado",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.amber,
        textColor: Colors.white,
        fontSize: 16.0,
        
    );
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: Constant.colorHorizontal,
        child: _isLoading ? const Center(child: CircularProgressIndicator()) : ListView(
          children: <Widget>[
            headerSection(),
            textSection(),
            buttonSection(),
          ],
        ),
      ),
    );
  }

  signIn(String email, pass)async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
      'password': pass
    };
    dynamic jsonResponse;
    var log=AuthRepository();
    var response=await log.login(data);
    if(response.statusCode == 200) {
      
      jsonResponse = json.decode(response.body);
      
      if(jsonResponse['done']=='successfull'){

        setState(() {
          _isLoading = false;
        });
        if(jsonResponse['activo']==0){
          showToastSucces();
          await sharedPreferences.setString("token", jsonResponse['token'].toString());
          await sharedPreferences.setString("userid", jsonResponse['userid'].toString());
          await sharedPreferences.setString("nombre", jsonResponse['nombre'].toString());
          await sharedPreferences.setString("apellido", jsonResponse['apellido'].toString());
          await sharedPreferences.setString("gmail", jsonResponse['gmail'].toString());

          await sharedPreferences.setString('sexo',jsonResponse['sexo']);
          await sharedPreferences.setInt('edad', jsonResponse['edad']);
          await sharedPreferences.setInt('altura', jsonResponse['altura']);
          await sharedPreferences.setInt('peso', jsonResponse['peso']);
          await sharedPreferences.setInt('actifisica', jsonResponse['actifisica']);

          Provider.of<UserC>(context, listen: false).signIn(jsonResponse['userid'],jsonResponse['nombre'],jsonResponse['apellido'].toString(),jsonResponse['gmail'].toString(),jsonResponse['activo'],jsonResponse['cargo']);
          if(true){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const RegistroUser()), (Route<dynamic> route) => false);
          }
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const MyApp()), (Route<dynamic> route) => false);
        }else{
          showToastBanneado();
        }
      }else{
        setState(() {
          _isLoading = false;
        });
        showToastError();
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

  response(){
    // return 
  }
  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.only(top: 15.0),
      child: ElevatedButton(
        onPressed: emailController.text == "" || passwordController.text == "" ? null : () {
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text);
          
          
        },
        // style: ,
        // elevation: 0.0,
        // color: Colors.purple,
        child: const Text("Iniciar Session", style: TextStyle(color: Colors.white70)),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Container textSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,

            style: const TextStyle(color: Colors.white70,fontSize: 24),
            decoration: const InputDecoration(
              icon: Icon(Icons.email, color: Colors.white70),
              hintText: "Email",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: const TextStyle(color: Colors.white70,fontSize: 20),
            decoration: const InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: "Password",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70,),
            ),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      // margin: const EdgeInsets.only(top: 50.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Center(
        child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("assets/imagenes/logo1.png")
                ),
      ),
    );
  }
}
