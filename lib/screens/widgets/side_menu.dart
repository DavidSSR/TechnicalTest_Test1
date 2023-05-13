import 'package:flutter/material.dart';
import 'package:technical_test/screens/create_user_screen.dart';
import 'package:technical_test/screens/home_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color(0xFFF1F5F9),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.home, color: const Color(0xFF000000)),
              title: const Text(
                'Inicio',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_reaction_rounded,
                  color: const Color(0xFF000000)),
              title: const Text(
                'Crear Usuario',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateUserScreen()));
              },
            ),
          ],
        ));
  }
}
