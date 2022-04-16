import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserC with ChangeNotifier {

  int _userId=0;
  String _userNombre="";
  String _userApellido="";
  String _userGmail="";
  int _userActivo=0;
  int _userCargo=0;

 int get userIdd => _userId;
  set userId(int userId) {
    _userId = userId;
  }
// ignore: unnecessary_getters_setters
String get userNombre => _userNombre;
  // ignore: unnecessary_getters_setters
  set userNombre(String userNombre) {
    _userNombre = userNombre;
  }
// ignore: unnecessary_getters_setters
String get userApellido => _userApellido;
  // ignore: unnecessary_getters_setters
  set userApellido(String userApellido) {
    _userApellido = userApellido;
  }
// ignore: unnecessary_getters_setters
String get userGmail => _userGmail;
  // ignore: unnecessary_getters_setters
  set userGmail(String userGmail) {
    _userGmail = userGmail;
  }
// ignore: unnecessary_getters_setters
int get userActivo => _userActivo;
  // ignore: unnecessary_getters_setters
  set userActivo(int userActivo) {
    _userActivo = userActivo;
  }
// ignore: unnecessary_getters_setters
int get userCargo => _userCargo;
  // ignore: unnecessary_getters_setters
  set userCargo(int userCargo) {
    _userCargo = userCargo;
  }
void signIn( int userId,
     String userNombre,
     String userApellido,
     String userGmail,
     int userActivo,
     int userCargo){
     _userId=userId;
    _userNombre=userNombre;
    _userApellido=userApellido;
    _userGmail=userGmail;
    _userActivo=userActivo;
    _userCargo=userCargo;
    notifyListeners();
  }
}

