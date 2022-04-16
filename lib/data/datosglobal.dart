

import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
logOut()async{
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.clear();
}
bool variableGlobal=false;
// int selectDrawerItem=0;
// navigationDrawer(int pos){
//     switch(pos){
//       case 0:return const DistribucionC();
//       case 1:return const Plan();
//       case 2:return const Receta();
//       case 3:return const Alimentos();
//       case 4:return const RecomendacionesImg();
//       case 5:return const User();
      
//     }
//   }
// onSelectItem(int pos){
//     // setState(() {
//       selectDrawerItem=pos;
//     // });
//   } 