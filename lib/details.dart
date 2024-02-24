import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String name;
  final String phone;
  final IconData? image;
  const DetailsPage({super.key, required this.name, required this.phone, this.image});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(),
    body: Center(
      child: Column(
        children: [
          const SizedBox(height: 10,),
          Hero(tag: phone, child: CircleAvatar(radius: 100, child: image != null ? Icon(image, size: 80,): null)),
          const SizedBox(height: 10,),
          ListTile(title: const Text("Name"), subtitle: Text(name),),
          const SizedBox(height: 10,),
          ListTile(title: const Text("Phone Number"), subtitle: Text(phone),)
        ],
      ),
    ),);
  }
}