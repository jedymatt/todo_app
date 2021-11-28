import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

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
          child: const Text('Logout'),
          onPressed: () async {
            await AuthService().signOut();
            Navigator.popUntil(context, (route) => true);
          },
        ),
      ),
    );
  }
}
