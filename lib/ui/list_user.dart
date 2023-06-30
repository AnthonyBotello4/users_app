import 'package:flutter/material.dart';
import 'package:users_app_sem14/database/database.dart';
import 'package:provider/provider.dart';
import 'package:users_app_sem14/ui/new_user.dart';
import 'package:drift/drift.dart' as dr;
import 'edit_user_dialog.dart';

class listUser extends StatefulWidget {
  const listUser({Key? key}) : super(key: key);

  @override
  State<listUser> createState() => _listUserState();
}

class _listUserState extends State<listUser> {
  late AppDatabase database;
  late Future<List<User>> userListFuture;

  @override
  void initState() {
    super.initState();
    database = Provider.of<AppDatabase>(context, listen: false);
    userListFuture = database.getListUsers();
  }

  @override
  Widget build(BuildContext context) {
    database = Provider.of<AppDatabase>(context);
    UserEditDialog dialogEditUser = UserEditDialog();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de usuarios'),
      ),
      body: FutureBuilder<List<User>>(
        future: database.getListUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User>? userList = snapshot.data;
            return ListView.builder(
                itemCount: userList!.length,
                itemBuilder: (context, index) {
                  User userData = userList[index];
                  return Dismissible(
                    key: Key(userData.id.toString()),
                    onDismissed: (direction) {
                      database.deleteUser(UsersCompanion(
                          id: dr.Value(userData.id),
                          name: dr.Value(userData.name),
                          email: dr.Value(userData.email)));
                    },
                    background: Container(
                      color: Colors.red,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: ListTile(
                      title: Text(userData.name),
                      subtitle: Text(userData.email),
                      trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            editUser(dialogEditUser, userData);
                          }),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            addUser();
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.plus_one, color: Colors.white)),
    );
  }

  void addUser() async {
    var res = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewUser()));
    if (res != null && res == true) {
      setState(() {});
    }
  }

  void editUser(UserEditDialog dialogEditUser, User userData) async {
    var res = await showDialog(
        context: context,
        builder: (BuildContext context) =>
            dialogEditUser.buildDialog(context, userData, false));

    if (res != null && res == true) {
      setState(() {});
    }
  }
}
