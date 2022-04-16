
import 'package:flutter/material.dart';
import 'package:nutriapp/pages/navegation/pages/alimentos/widgets/alimentos.widget.dart';
import 'package:nutriapp/pages/navegation/pages/distribucionCalorica/widgets/distribucion.widget.dart';
import 'package:nutriapp/pages/navegation/pages/plan/widgets/plan.widget.dart';
import 'package:nutriapp/pages/navegation/pages/recetas/widgets/receta.widget.dart';
import 'package:nutriapp/pages/navegation/pages/usuario/widgets/user.widget.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  // final Widget child;
 
  // Navigation({Key key, this.child}) : super(key: key);
 
  @override
  _NavigationState createState() => _NavigationState();
}
 
class _NavigationState extends State<Navigation> {
 
     // Crear valor de atributo interno
     // Cree una matriz, este elemento de matriz es el método para introducirlo en la página.
     // List <Widget> page_view_list = List (); Si usa los atributos aquí, debe inicializarlo en initState
  // ignore: non_constant_identifier_names
  List<Widget> page_view_list2 = [
    const DistribucionC(),
    const Receta(),
    const Alimentos(),
    const Plan(),
    const User()
  ];
     // Crea un índice entero para obtener el índice del botón de menú actual. El valor inicial es 0. Este valor inicial representa la primera página mostrada por la aplicación, que es el índice en la matriz.
  int _nowindex = 0;
 
     // Reescribe el método initState heredado
  @override
  void initState() {
         // El siguiente código no se entiende ahora. Entonces se usa otra forma, y ​​el valor del elemento se establece al configurar el atributo page_view_list2
    // page_view_list
    //   ..add(HomeView())
    //   ..add(NewView())
    //   ..add(StudyView())
    //   ..add(TeacherView())
    //   ;
 
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
                body: page_view_list2 [_nowindex], // Presta atención a esta línea, no te la pierdas. Este es el cuerpo de la página
      bottomNavigationBar: BottomNavigationBar(
                    // Establecer los elementos internos
        items: const [
               BottomNavigationBarItem (
               icon: Icon (Icons.vertical_distribute),
               label: "Dis",
               
          ),
                 BottomNavigationBarItem (
               icon: Icon (Icons.food_bank_outlined), 
               label:"Recetas", 
          ),
               BottomNavigationBarItem (
             icon: Icon (Icons.set_meal_outlined), 
             label: "Alimentos", 
          ),
               BottomNavigationBarItem (
             icon: Icon (Icons.inventory_outlined), 
             label: "Plan", 
          ),
           BottomNavigationBarItem (
             icon: Icon (Icons.person_outline), 
             label: "Usuario", 
          ),
        ],
 
                      //punto clave 
                    currentIndex: _nowindex, // Establece el índice de la página que se muestra actualmente, usa las propiedades del conjunto.
                   selectedItemColor: Colors.amber[800],
                    type: BottomNavigationBarType.fixed, // Establecer tipo
 
                    // Establecer la respuesta al clic
                    onTap: (int index) {// El parámetro se establece en el índice predeterminado, este índice es el índice del botón seleccionado
                              // setState Este también es un método incorporado, solo necesita asignar el parámetro de índice al atributo set _now_index;
             setState(() {
              _nowindex =index; 
             });
        },
       
      ),
    );
  }
}


