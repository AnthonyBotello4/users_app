import 'package:flutter/material.dart';
import 'package:users_app_sem14/database/database.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as dr;

class NewUser extends StatefulWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  late AppDatabase database;
  late TextEditingController txtName;
  late TextEditingController txtEmail;

  @override
  void initState() {
    super.initState();
    txtName = TextEditingController();
    txtEmail = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    database = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: const Text('Nuevo usuario'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: txtName,
            decoration: InputDecoration(
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'Ingrese nombre',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: txtEmail,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'Ingrese correo',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: (){
                database.insertUser(UsersCompanion(
                  name: dr.Value(txtName.text),
                  email: dr.Value(txtEmail.text)
                )).then((value) => {
                  Navigator.pop(context, true)
                });
              },
              child: const Text('Guardar usuario')
          )
        ],
      ),
    );
  }
}
