// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_app/presentation/providers/auth_view_model.dart';
// import 'package:todo_app/presentation/screens/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:todo_app/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: TextButton(
          child: Text('Logout'),
          onPressed: () async {
            await AuthService().signOut();
            Navigator.popUntil(context, (route) => true);
          },
        ),
      ),
    );
  }
}
