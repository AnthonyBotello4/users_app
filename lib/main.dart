import 'package:flutter/material.dart';
import 'package:users_app_sem14/ui/list_user.dart';
import 'package:users_app_sem14/database/database.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AppDatabase(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: listUser(),
      ),
    );
  }
}


