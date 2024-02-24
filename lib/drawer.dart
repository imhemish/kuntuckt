import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(leading: const Icon(Icons.home), title: const Text("Home"),
          onTap: () {
            Navigator.pushReplacementNamed(context, "/");
            },),
          ListTile(leading: const Icon(Icons.add), title: const Text("Add"), onTap: () {
            Navigator.pushReplacementNamed(context, "/add");
            },)
          ],
      ),
    );
  }
}