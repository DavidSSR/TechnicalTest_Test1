import 'package:flutter/material.dart';
import '../../services/models/menu_option.dart';


class MenuList extends StatelessWidget {
  final List<MenuOption> items;

  MenuList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: items.map((item) {
          return Container(
            width: 250,
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border:
                        Border.all(color: const Color(0xFF120D5F), width: 1),
                    color: const Color(0xFFFF1F5F9),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          item.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF120D5F)),
                        ),
                      ),
                      Center(
                        child: IconButton(
                          icon: Icon(item.icon),
                          iconSize: 50,
                          color: const Color(0xFF120D5F),
                          onPressed: (){
                            debugPrint(item.route.toString());
                            Navigator.pushNamed(context, item.route);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}