import 'package:flutter/material.dart';
import 'package:technical_test/screens/bloc/global_bloc.dart';
import 'package:technical_test/services/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List<dynamic> addresses = [];
  final List<TextEditingController> _controller = <TextEditingController>[];

  @override
  void initState() {
    _controller.add(TextEditingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalBloc globalBloc = context.read<GlobalBloc>();
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF120D5F),
            title: const Text('Información adicional'),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    getUser(context, globalBloc.state.user);
                  }, icon: const Icon(Icons.account_circle)),
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
                  children: [
                    Text(
                      "Escriba al menos una dirección",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 15),
                    Expanded(
                      child: ListView(
                        children: _controller.map((e) {
                          int index = _controller.indexOf(e);
                          String k = e.text.toString();

                          bool isEnabled = index < _controller.length - 1;
                          return Row(
                            children: [
                              Text(
                                "#${index.toString()}",
                                style: TextStyle(fontSize: 14),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 50, right: 50, top: 10, bottom: 10),
                                  child: Container(
                                    height: 40,
                                    child: TextField(
                                      maxLength: 25,
                                      controller: e,
                                      enabled: !isEnabled,
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
                                          hintText: 'Dirección',
                                          hintStyle: TextStyle(
                                              height: 0.5,
                                              color: const Color(0xFF4F80BD),
                                              fontSize: 12)),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if ((_controller.length - 1) != 0) {
                                    setState(() {
                                      _controller.remove(e);
                                      addresses.remove(e.text.toString());
                                    });
                                    Alerta('Dirección eliminada exitosamente',
                                        context,false);
                                  } else {
                                    Alerta(
                                        'No se puede eliminar, tienes que escribir al menos una dirección',
                                        context,false);
                                  }
                                },
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                              ),
                              IconButton(
                                  onPressed: () {
                                    if (e.text.trim().isNotEmpty && e.text.length > 4) {
                                      setState(() {
                                        addresses.remove(k);
                                        addresses.add(e.text.toString());
                                        _controller
                                            .add(TextEditingController());
                                      });
                                      Alerta('Dirección agregada exitosamente',
                                          context,false);
                                    } else {
                                      Alerta(
                                          "Campo de dirección debe contener al menos 5 caracteres", context,false);
                                    }
                                  },
                                  icon: const Icon(Icons.add_circle_outline))
                            ],
                          );
                        }).toList(),
                        

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
                              if (addresses.isNotEmpty) {
                                Map<String, dynamic> user = globalBloc.state.currentData;
                                user["addresses"] = addresses;
                                globalBloc.add(CreateUserEvent(user));
                                Alerta("Usuario creado exitosamente", context,true);
                              } else {
                                Alerta("Se necesita al menos una dirección",context,false);
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  const Color(0xFF120D5F)),
                            ),
                            child: Text(
                              "Crear Usuario",
                              style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        )
                  ],
                ),
              ),
            ),
          )),
        );
      },
    );
  }
}

void Alerta(String descripcion, BuildContext context, bool created) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('${descripcion}'),
        actions: [
          ElevatedButton(
            child: Text('Aceptar'),
            onPressed: () {
              if(created){
               Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }else{
                Navigator.of(context).pop();
              }
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