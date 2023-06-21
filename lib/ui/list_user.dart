import 'package:flutter/material.dart';
import 'package:users_app_sem14/database/database.dart';
import 'package:provider/provider.dart';
import 'package:users_app_sem14/ui/new_user.dart';

class listUser extends StatefulWidget {
  const listUser({Key? key}) : super(key: key);

  @override
  State<listUser> createState() => _listUserState();
}

class _listUserState extends State<listUser> {
  late AppDatabase database;

  @override
  Widget build(BuildContext context) {

    database = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de usuarios'),
      ),
      body: FutureBuilder<List<User>>(
        future: database.getListUsers(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            List<User>? userList = snapshot.data;
            return ListView.builder(
              itemCount: userList!.length,
              itemBuilder: (context, index){
                User userData = userList[index];
                return ListTile(
                  title: Text(userData.name),
                  subtitle: Text(userData.email),
                );
              }
            );
          }
          else if(snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          else {
              return Center(
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
        child: Icon(
            Icons.plus_one,
            color: Colors.white
        )
      ),
    );
  }

  void addUser() async {
    var res = await Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => NewUser()
      )
    );
    if ( res != null && res == true){
      setState(() {

      });
    }
  }

}
