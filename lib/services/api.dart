
import 'dart:io';


import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class AuthRepository{
  var url = "https://apirestcafpfc.herokuapp.com/";
  // var url = "http://192.168.1.35:3000/";
  String ?token;
  dynamic userId;
  SharedPreferences? sharedPreferences;

  login(Map data)async{
    var loginUrl=url+"login";
    var response = await http.post(Uri.parse(loginUrl), body: data);
    return response;
  }
  personUpdate(Map data)async{
    sharedPreferences = await SharedPreferences.getInstance();
    userId= sharedPreferences!.getString('userid');
    // if(id==null){}
    var personUrl=url+"person/"+userId.toString();
    token=  sharedPreferences!.getString("token")!;
    var response = await http.put(Uri.parse(personUrl), body: data,headers: {
          HttpHeaders.authorizationHeader: "Bearer "+token.toString()
        });
    return response;
  }
  personPeso(Map data)async{
    sharedPreferences = await SharedPreferences.getInstance();
    userId= sharedPreferences!.getString('userid');
    token=  sharedPreferences!.getString("token")!;
    var personPesoUrl=url+"weight/"+userId.toString();
    var response = await http.put(Uri.parse(personPesoUrl), body: data,headers: {
          HttpHeaders.authorizationHeader: "Bearer "+token.toString()
        });
    return response;
  }


 

  recetaLista(client)async{
    var recetaUrl=url+"receta_join";
    sharedPreferences = await SharedPreferences.getInstance();
    token=  sharedPreferences!.getString("token")!;
    final response = await http.get(Uri.parse(recetaUrl),headers: {
          HttpHeaders.authorizationHeader: "Bearer "+token.toString()
        });
    // print(response.body);
    return response;
  }
  
   getUser(client)async{
    var personUrl=url+"person";
    sharedPreferences = await SharedPreferences.getInstance();
    token=  sharedPreferences!.getString("token")!;
    final response = await http.get(Uri.parse(personUrl),headers: {
          HttpHeaders.authorizationHeader: "Bearer "+token.toString()
        });
    // print(response.body);
    return response;
  }

  getPlan(client)async{
    var planUrl=url+"plan";
    sharedPreferences = await SharedPreferences.getInstance();
    token=  sharedPreferences!.getString("token")!;
    final response = await http.get(Uri.parse(planUrl),headers: {
          HttpHeaders.authorizationHeader: "Bearer "+token.toString()
        });
    return response;
  }
  getPlanIdFecha(client)async{
    
    sharedPreferences = await SharedPreferences.getInstance();
    token=  sharedPreferences!.getString("token")!;
    userId= sharedPreferences!.getString('userid');
    var planUrl=url+"planfecha/"+userId.toString();
    final response = await http.get(Uri.parse(planUrl),headers: {
          HttpHeaders.authorizationHeader: "Bearer "+token.toString()
        });
    return response;
  }

  postPlanApi(Map data)async{
    var planUrl=url+"plan";
    sharedPreferences = await SharedPreferences.getInstance();
    token=  sharedPreferences!.getString("token")!;
    final response = await http.post(Uri.parse(planUrl),body:data,headers: {
          HttpHeaders.authorizationHeader: "Bearer "+token.toString()
        });
    return response;
  }
  deletePlanApi(int id)async{
    var planUrl=url+"plan/$id";
    sharedPreferences = await SharedPreferences.getInstance();
    token=  sharedPreferences!.getString("token")!;
    final response = await http.delete(Uri.parse(planUrl),headers: {
          HttpHeaders.authorizationHeader: "Bearer "+token.toString()
        });
    return response;
  }

  recomendacionLista(client)async{
    var recomendacionImgUrl=url+"imagenesr";
    sharedPreferences = await SharedPreferences.getInstance();
    token=  sharedPreferences!.getString("token")!;
    final response = await http.get(Uri.parse(recomendacionImgUrl),headers: {
          HttpHeaders.authorizationHeader: "Bearer "+token.toString()
        });
    // print(response.body);
    return response;
  }
  publicidadShare(client)async{
    var publicidadImgUrl=url+"imagenesp";
    sharedPreferences = await SharedPreferences.getInstance();
    token=  sharedPreferences!.getString("token")!;
    final response = await http.get(Uri.parse(publicidadImgUrl),headers: {
          HttpHeaders.authorizationHeader: "Bearer "+token.toString()
        });
    // print(response.body);
    return response;
  }
  //Like de Alimentos
  postAliemnto(Map dato)async{
    var likeUrl=url+"food_item_like";
    sharedPreferences = await SharedPreferences.getInstance();
    token=  sharedPreferences!.getString("token")!;
    final response = await http.post(Uri.parse(likeUrl),body:dato,headers: {
          HttpHeaders.authorizationHeader: "Bearer "+token.toString()
        });
    return response;
  }
}
