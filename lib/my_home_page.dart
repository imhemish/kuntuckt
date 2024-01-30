import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String phone;

  const Contact(this.name, this.phone);

  factory Contact.fromSnapshot(DocumentSnapshot snapshot) {
    return Contact(snapshot.get("name"), snapshot.get("phone"));
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("contacts").snapshots().listen((event) {
      setState(() {
        contacts.clear();
        event.docs.forEach((element) {
        contacts.add(Contact.fromSnapshot(element));
        });
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Kuntuckt"),
      ),

      body: ListView.separated(itemBuilder: (context, index) => ListTile(title: Text(contacts[index].name), subtitle: Text(contacts[index].phone),),
      separatorBuilder: (context, index) => const SizedBox(height: 5), 
      
      itemCount: contacts.length),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/add"),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}