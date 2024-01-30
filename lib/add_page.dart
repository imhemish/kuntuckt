import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Add"),
        centerTitle: true,
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.loose(const Size(600, double.infinity)),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _nameController,
                  validator: (name) => (name == null || name.isEmpty) ? "Name should not be empty" : null,
                  decoration: const InputDecoration(label: Text("Name"), hintText: "John Doe"),
                ),
                const SizedBox(height: 10,),
            
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(label: Text("Phone Number")),
                  validator: (phone) => (phone?.length == 10) & (phone != null) & (int.tryParse(phone!) != null) ? null : "Enter a 10 digit number",
                ),
                const SizedBox(height: 10,),
            
                ElevatedButton(onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FirebaseFirestore.instance.collection("contacts").add(
                      {"name": _nameController.text,
                      "phone": _phoneController.text}
                      ).then((value) { 
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successfully Added")));
                        });
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.black),
                child: const Text("Submit"),
                )
                
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}