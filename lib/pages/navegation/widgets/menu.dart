import 'package:flutter/material.dart';
import 'package:nutriapp/models/users/user.model.dart';
import 'package:nutriapp/pages/navegation/pages/plan/widgets/plan.widget.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             UserAccountsDrawerHeader(
              accountName: Text(context.watch<UserC>().userNombre+" "+context.watch<UserC>().userApellido),
              accountEmail: Text(context.watch<UserC>().userGmail),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child:Consumer<UserC>(
                  builder: (context, userModel, child) {
                    String message = (userModel.userNombre == ""
                        ? "H"
                        : userModel.userNombre.split('')[0].toUpperCase());
                    return Text(message);
                  },
                ) 
                // Text(context.watch<UserC>().userNombre.split('')[0].toUpperCase()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.vertical_distribute),
              title: const Text('Distribucion Calorica'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory_outlined),
              title: const Text('Plan'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Plan()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.food_bank_outlined),
              title: const Text('Receta'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.set_meal_outlined),
              title: const Text('Alimentos'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.vertical_distribute),
              title: const Text('Recomendacion'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
    );
  }
}