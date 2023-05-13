import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:technical_test/screens/adress_screen.dart';
import 'package:technical_test/screens/bloc/global_bloc.dart';

import 'package:intl/intl.dart';

class CreateUserScreen extends StatefulWidget {
  CreateUserScreen({super.key});

  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  DateTime date = DateTime(2007);

  @override
  Widget build(BuildContext context) {
    GlobalBloc globalBloc = context.read<GlobalBloc>();

    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF120D5F),
            title: const Text('Crear Usuario'),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    getUser(context, globalBloc.state.user);
                  },
                  icon: const Icon(Icons.account_circle)),
            ],
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  height: 550,
                  width: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: const Color(0xFFFFFFFF),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Ingrese el nombre del usuario",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 50, right: 50),
                            child: Container(
                                height: 40,
                                child: TextFormField(
                                  maxLength: 25,
                                  controller: nombreController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    counterText: '',
                                      filled: true,
                                      fillColor: Color(0xFFF1F5F9),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          borderSide: BorderSide(
                                              width: 1.0,
                                              color: Color(0xFF120D5F))),
                                      hintText: 'Nombre',
                                      hintStyle: TextStyle(
                                          height: 0.5,
                                          color: const Color(0xFF4F80BD),
                                          fontSize: 12)),
                                ))),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Ingrese el Apellido del usuario",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 50, right: 50),
                            child: Container(
                                height: 40,
                                child: TextField(
                                  maxLength: 25,
                                  controller: apellidoController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    counterText: '',
                                      filled: true,
                                      fillColor: Color(0xFFF1F5F9),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          borderSide: BorderSide(
                                              width: 1.0,
                                              color: Color(0xFF120D5F))),
                                      hintText: 'Apellido',
                                      hintStyle: TextStyle(
                                          height: 0.5,
                                          color: const Color(0xFF4F80BD),
                                          fontSize: 12)),
                                ))),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Seleccione la fecha de nacimiento del usuario",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: EdgeInsets.only(left: 50, right: 50),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              border: Border.all(
                                  color: const Color(0xFF120D5F), width: 1),
                              color: const Color(0xFFFF1F5F9),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${date.year}/${date.month}/${date.day}',
                                  style:
                                      TextStyle(color: const Color(0xFF120D5F)),
                                ),
                                IconButton(
                                  iconSize: 20,
                                  icon: const Icon(
                                    Icons.calendar_month,
                                  ),
                                  onPressed: () async {
                                    DateTime? newDate = await showDatePicker(
                                        context: context,
                                        initialDate: date,
                                        firstDate: DateTime(1980),
                                        lastDate: DateTime(2007));
                                    if (newDate == null) {
                                      return;
                                    } else {
                                      setState(() => date = newDate);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          // padding: const EdgeInsets.all(15.0),
                          height: 30,
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (nombreController.text.trim().isNotEmpty &&
                                  apellidoController.text.trim().isNotEmpty) {
                                if (date == DateTime(2007)) {
                                  mostrarAlerta(
                                      context, "Selecciona una fecha");
                                }
                                else if(nombreController.text.length < 3 || apellidoController.text.length < 3){
                                  mostrarAlerta(context,"Nombre y Apellido deben contenter minimo 3 caracteres");

                                } else {
                                  String dat = date.toIso8601String();
                                  Map<String, dynamic> user = {
                                    'name': nombreController.text.toString(),
                                    'last_name':
                                        apellidoController.text.toString(),
                                    'date_b': dat,
                                  };
                                  globalBloc.add(DataEvent(user));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddressScreen()));
                                }
                              } else {
                                mostrarAlerta(
                                    context, 'Completa todos los campos');
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  const Color(0xFF120D5F)),
                            ),
                            child: Text(
                              "Siguiente",
                              style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        )
                      ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

void mostrarAlerta(BuildContext context, String descripcion) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('${descripcion}'),
        actions: [
          ElevatedButton(
            child: Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
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
          title: Text('No hay usuario creado actualmente: '),
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
