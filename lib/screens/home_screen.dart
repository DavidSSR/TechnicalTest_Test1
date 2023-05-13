import 'package:flutter/material.dart';
import 'package:technical_test/screens/widgets/widgets.dart';
import 'package:technical_test/services/router/router.dart';
import 'package:technical_test/services/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test/screens/bloc/global_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<MenuOption> menuOptions = AppRoutes.menuOptions;
    GlobalBloc globalBloc = context.read<GlobalBloc>();

    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF120D5F),
            title: const Text('Double V Partners - Inicio'),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    getUser(context, globalBloc.state.user);
                  },
                  icon: const Icon(Icons.account_circle)),
            ],
          ),
          drawer: const SideMenu(),
          body: ListView(
            children: [
              Center(
                child: MenuList(
                  items: menuOptions,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void getUser(BuildContext context, Map<String, dynamic> user) {
  if (!user.isEmpty) {
    List<String> direcciones = List<String>.from(user['addresses']);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Datos del usuario: '),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Nombre: ${user['name'].toString()}'),
              Text('Apellido: ${user['last_name'].toString()}'),
              Row(children: [
                Text('Fecha de nacimiento: '),
                Text(DateFormat('dd/MM/yyyy')
                    .format(DateTime.parse(user["date_b"]))),
              ]),
              Text('Direcciones:'),
              Column(
                children: direcciones.asMap().entries.map((entry) {
                  int index = entry.key;
                  String direccion = entry.value;
                  return Text('#${index + 1}:  $direccion');
                }).toList(),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No hay usuario creado actualmente '),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
