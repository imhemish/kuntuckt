import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuntuckt/details.dart';
import 'package:kuntuckt/drawer.dart';

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
    FirebaseFirestore.instance
        .collection("contacts")
        .snapshots()
        .listen((event) {
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
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Kuntuckt"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => 
          
          Dismissible(
                key: Key(contacts[index].phone),
                background: Container(
                  color: Colors.red,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(Icons.delete, color: Colors.white,),
                    ),
                  ),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    var snapshots = await FirebaseFirestore.instance.collection("contacts").where("phone", isEqualTo: contacts[index].phone).get();
                    snapshots.docs[0].reference.delete();
                  }
                  return true;
                },
                child: ListTile(
                  leading: Hero(
                      tag: contacts[index].phone,
                      child: const Icon(Icons.person)),
                  title: Text(contacts[index].name),
                  subtitle: Text(contacts[index].phone),
                  trailing: const Icon(Icons.navigate_next),
                  onTap: () => Get.to(
                      DetailsPage(
                        name: contacts[index].name,
                        phone: contacts[index].phone,
                        image: Icons.person,
                      ),
                      duration: Duration(milliseconds: 600)),
                ),
              ),
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
