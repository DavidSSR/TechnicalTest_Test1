import 'package:flutter/material.dart';
import 'package:technical_test/screens/create_user_screen.dart';
import 'package:technical_test/screens/home_screen.dart';
import 'package:technical_test/services/models/models.dart';
import 'package:technical_test/screens/adress_screen.dart';

class AppRoutes {
  static const initialRoute = '/';

  static final menuOptions = <MenuOption>[
    MenuOption(
      route: '/home',
      name: 'Home',
      icon: Icons.home,
      screen: const HomeScreen(),
    ),
    MenuOption(
      route: '/createuser',
      name: 'Create User',
      icon: Icons.add_reaction_rounded,
      screen: CreateUserScreen(),
    ),
        
  ];

  static Map<String, WidgetBuilder> getAppRoutes() {

    Map<String, WidgetBuilder> appRoutes = {};
    
    for (final option in menuOptions) {
      appRoutes.addAll({
        option.route: (BuildContext context) => option.screen,
      });
    }

    return appRoutes;
  }
  static List<MenuOption> getMenuOptions() {
    return menuOptions;
  }

  // funcion que convierte un menu options en routes
  static Route onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        return const HomeScreen();
      },
    );
  }
}
