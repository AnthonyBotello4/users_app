import 'package:flutter/material.dart';
import 'package:users_app_sem14/database/database.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as dr;

class UserEditDialog {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  late AppDatabase database;

  Widget buildDialog(BuildContext context, User? user, bool isNew) {
    isNew = false;
    if (!isNew) {
      nameController.text = user!.name;
      emailController.text = user.email;
    }
    database = Provider.of<AppDatabase>(context);

    return AlertDialog(
      title: Text(isNew ? 'Nuevo usuario' : 'Editar usuario'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            database
                .updateUser(UsersCompanion(
                    id: dr.Value(user.id),
                    name: dr.Value(nameController.text),
                    email: dr.Value(emailController.text)))
                .then((value) => {Navigator.pop(context, true)});
          },
          child: const Text('Actualizar usuario'),
        ),
      ],
    );
  }
}
